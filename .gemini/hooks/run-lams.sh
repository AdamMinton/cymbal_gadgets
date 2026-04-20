#!/bin/bash
input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.path // empty')

if [ -n "$file_path" ] && [ "$file_path" != "null" ]; then
  entity_name=$(basename "$file_path" | sed 's/\..*//')
else
  entity_name="null"
fi

lams_output=$(lams 2>&1)
all_errors=$(echo "$lams_output" | grep '❌' || true)

if [ "$entity_name" != "null" ]; then
  file_errors=$(echo "$all_errors" | grep "$entity_name" || true)
else
  file_errors=""
fi

if [ -n "$file_errors" ]; then
  jq -n \
    --arg msg "❌ LAMS Issues found in $file_path:\n$file_errors" \
    '{decision: "deny", reason: "LAMS violations", systemMessage: $msg}'
else
  jq -n \
    --arg msg "✅ No LAMS issues found for $file_path." \
    '{decision: "allow", systemMessage: $msg}'
fi
