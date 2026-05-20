#!/bin/bash

# ==============================================================================
# run-lams-hook.sh
# 
# Description:
#   A robust, turn-aware PostInvocation hook for Looker Actionable Linting (LAMS).
#   1. Extracts the transcript path from stdin.
#   2. Dynamically finds the step index of the last user input (start of current turn).
#   3. Scans all planner response steps since the turn start to find any edited LookML (.lkml) files.
#   4. If LookML files were modified, runs LAMS linting on them and reports results in standard chat.
#   5. If no LookML files were modified, exits silently with no injected steps.
# ==============================================================================

# Read input JSON payload passed via stdin from the Antigravity execution loop
input=$(cat)

# Parse critical metadata keys from the input payload
transcriptPath=$(echo "$input" | jq -r '.transcriptPath // empty')
workspace_path=$(echo "$input" | jq -r '.workspacePaths[0] // empty')

# Proceed with parsing only if we have a valid transcript path
if [ -n "$transcriptPath" ] && [ -f "$transcriptPath" ]; then
  # Parse additional hook-specific parameters
  stepIdx=$(echo "$input" | jq -r '.stepIdx // empty')
  initialNumSteps=$(echo "$input" | jq -r '.initialNumSteps // empty')

  if [ -n "$stepIdx" ]; then
    # PostToolUse Hook: scan the completed step and its preceding step
    edited_files=$(jq -s -r --argjson idx "$stepIdx" '
      .[] |
      select((.step_index == $idx or .step_index == ($idx - 1)) and .type == "PLANNER_RESPONSE") |
      .tool_calls[]? |
      select(.name == "replace_file_content" or .name == "write_to_file" or .name == "multi_replace_file_content") |
      .args.TargetFile | fromjson? // . | gsub("^\"|\"$"; "")
    ' "$transcriptPath" | grep '\.lkml$' | sort -u || true)
  else
    # PostInvocation Hook: find all LookML files edited during the current user turn
    edited_files=$(jq -s -r '
      (map(select(.source == "USER_EXPLICIT" and .type == "USER_INPUT")) | last | .step_index) as $start |
      .[] |
      select(.step_index >= $start and .type == "PLANNER_RESPONSE") |
      .tool_calls[]? |
      select(.name == "replace_file_content" or .name == "write_to_file" or .name == "multi_replace_file_content") |
      .args.TargetFile | fromjson? // . | gsub("^\"|\"$"; "")
    ' "$transcriptPath" | grep '\.lkml$' | sort -u || true)
  fi

  # If files were edited, perform the LAMS validation
  if [ -n "$edited_files" ]; then
    # Load NVM to ensure we have access to Node/LAMS
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
      . "$NVM_DIR/nvm.sh"
    fi

    # Change to workspace directory to ensure LAMS finds the project files
    if [ -n "$workspace_path" ] && [ -d "$workspace_path" ]; then
      cd "$workspace_path"
    fi

    # Run the local LAMS installation and capture all stdout and stderr
    lams_output=$(lams 2>&1)
    lams_exit_code=$?

    if [ $lams_exit_code -eq 127 ]; then
      final_message="❌ LAMS hook error: 'lams' command not found. Please ensure LAMS is installed and in PATH."
      jq -n --arg msg "$final_message" '{ "injectSteps": [ { "userMessage": $msg } ] }'
      exit 0
    fi
    
    # Filter the LAMS output for errors denoted by the cross emoji
    all_errors=$(echo "$lams_output" | grep '❌' || true)

    final_message=""

    # Iterate over each modified LookML file to map corresponding LAMS issues
    while IFS= read -r file_path; do
      if [ -z "$file_path" ]; then continue; fi
      
      # Extract the basename/entity name (e.g. view name) from the file path
      entity_name=$(basename "$file_path" | sed 's/\..*//')
      
      # Search for errors specific to this file/entity
      file_errors=$(echo "$all_errors" | grep "$entity_name" || true)
      
      if [ -n "$file_errors" ]; then
        final_message="${final_message}❌ LAMS Issues found in $file_path:\n$file_errors\n\n"
      else
        final_message="${final_message}✅ No LAMS issues found for $file_path.\n"
      fi
    done <<< "$edited_files"

    # Output the final JSON with a single injected step
    jq -n --arg msg "$final_message" '{ "injectSteps": [ { "userMessage": $msg } ] }'
    exit 0
  fi
fi

# Default: inject nothing
echo '{"injectSteps": []}'
