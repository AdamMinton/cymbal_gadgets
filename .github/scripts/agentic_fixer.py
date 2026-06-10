import os
import sys
import json
import asyncio
import subprocess
import looker_sdk
from looker_sdk import models40 as models
from google.antigravity import Agent, LocalAgentConfig, CapabilitiesConfig

MAX_ATTEMPTS = 3

def get_issue_thread(issue_number):
    """Fetches the complete issue conversation (description + comments) using gh CLI."""
    try:
        result = subprocess.run(
            ["gh", "issue", "view", str(issue_number), "--json", "title,body,comments"],
            capture_output=True,
            text=True,
            check=True
        )
        data = json.loads(result.stdout)
        title = data.get("title", "")
        body = data.get("body", "")
        comments = data.get("comments", [])
        
        thread = f"Issue Title: {title}\n\nOriginal Issue Description:\n{body}\n"
        
        if comments:
            thread += "\n--- Conversation History ---\n"
            for comment in comments:
                author = comment.get("author", {}).get("login", "unknown")
                comment_body = comment.get("body", "")
                if author == "github-actions[bot]":
                    thread += f"Agent: {comment_body}\n\n"
                else:
                    thread += f"User ({author}): {comment_body}\n\n"
        return thread
    except Exception as e:
        print(f"Failed to fetch issue thread via gh CLI: {e}")
        title = os.environ.get("ISSUE_TITLE", "")
        body = os.environ.get("ISSUE_BODY", "")
        return f"Issue Title: {title}\n\nIssue Body: {body}"

def post_issue_comment(issue_number, message):
    """Posts a comment back to the GitHub issue."""
    try:
        subprocess.run(
            ["gh", "issue", "comment", str(issue_number), "--body", message],
            check=True
        )
        print("Successfully posted comment to GitHub Issue.")
    except Exception as e:
        print(f"Failed to post comment to GitHub Issue: {e}")

def sync_with_remote(branch_name, message):
    """Commits local changes and pushes to the remote branch."""
    try:
        subprocess.run(["git", "add", "."], check=True)
        # If there are no changes, git commit will return a non-zero exit code
        result = subprocess.run(["git", "status", "--porcelain"], capture_output=True, text=True)
        if not result.stdout.strip():
            print("No changes to commit.")
            return False
        
        subprocess.run(["git", "commit", "-m", message], check=True)
        # Force push in case of multiple attempts
        subprocess.run(["git", "push", "-u", "origin", branch_name, "--force"], check=True)
        return True
    except subprocess.CalledProcessError as e:
        print(f"Git operation failed: {e}")
        return False

def validate_in_looker(sdk: looker_sdk.methods40.Looker40SDK, project_id: str, branch_name: str):
    """Validates the project in Looker after syncing with the remote branch."""
    print("Switching Looker to dev workspace...")
    sdk.update_session(models.WriteApiSession(workspace_id="dev"))
    
    print(f"Switching Looker to branch {branch_name}...")
    sdk.update_git_branch(project_id, models.WriteGitBranch(name=branch_name))
    
    print("Resetting Looker dev project to remote to ensure latest changes are applied...")
    sdk.reset_project_to_remote(project_id)
    
    print("Running LookML validation...")
    validation_results = sdk.validate_project(project_id)
    
    errors = [e for e in validation_results.errors if e.severity in ["fatal", "error"]]
    return errors

async def main():
    project_id = "demo_cg5839"
    issue_number = os.environ.get("ISSUE_NUMBER", "0")
    branch_name = f"agent-fix/issue-{issue_number}"
    
    print(f"Fetching conversation thread for Issue #{issue_number}...")
    issue_context = get_issue_thread(issue_number)
    
    # Initialize Looker SDK (It automatically reads LOOKERSDK_* env vars)
    print("Initializing Looker SDK...")
    sdk = looker_sdk.init40()
    
    # Initialize AGY Agent Config
    print("Initializing AGY SDK...")
    config = LocalAgentConfig(
        system_instructions=(
            "You are an expert LookML developer and architecture expert. "
            "Your task is to fix LookML files based on a GitHub issue report. "
            "You have full capabilities to read and write files locally. "
            "Read the necessary .lkml files, apply your fixes, and respond with a summary of your changes."
        ),
        capabilities=CapabilitiesConfig()  # Enables tool calling (read_file, write_file, etc.)
    )
    
    validation_errors = []
    agent_explanation = ""
    
    async with Agent(config) as agent:
        for attempt in range(1, MAX_ATTEMPTS + 1):
            print(f"--- Attempt {attempt} of {MAX_ATTEMPTS} ---")
            
            prompt = (
                f"Please fix the following issue.\n\n{issue_context}\n\n"
            )
            
            if validation_errors:
                prompt += "Your previous changes resulted in the following LookML validation errors:\n"
                for err in validation_errors:
                    prompt += f"- [{err.file_path}] {err.message}\n"
                prompt += "\nPlease correct these compilation errors in the LookML files."
            else:
                prompt += "Please identify the relevant LookML files in this repository, edit them directly using your tools to fix the issue, and then respond with a summary of the changes you made."
                
            print("Prompting agent to apply fixes...")
            response = await agent.chat(prompt)
            agent_explanation = await response.text()
            print(f"Agent response:\n{agent_explanation}\n")
            
            print("Syncing changes with remote repository...")
            commit_message = f"Agent fix attempt {attempt} for issue #{issue_number}"
            sync_with_remote(branch_name, commit_message)
            
            print("Running Looker validation...")
            validation_errors = validate_in_looker(sdk, project_id, branch_name)
            
            if not validation_errors:
                print("LookML validation passed successfully!")
                comment_body = (
                    f"### Agent Fix Success (Attempt {attempt}/{MAX_ATTEMPTS})\n\n"
                    f"LookML validation passed successfully!\n\n"
                    f"**Changes made:**\n{agent_explanation}\n\n"
                    f"The changes have been pushed to the PR branch."
                )
                post_issue_comment(issue_number, comment_body)
                sys.exit(0)
            else:
                print(f"Validation failed with {len(validation_errors)} errors.")
                for err in validation_errors:
                    print(f" - {err.message} (File: {err.file_path})")
                    
        comment_body = (
            f"### Agent Fix Failed\n\n"
            f"I attempted to fix the LookML files {MAX_ATTEMPTS} times, but validation still failed. "
            f"Here are the remaining validation errors:\n\n"
        )
        for err in validation_errors:
            comment_body += f"- **[{err.file_path}]**: {err.message}\n"
        comment_body += "\nLast changes made:\n" + agent_explanation
        post_issue_comment(issue_number, comment_body)
        sys.exit(1)

if __name__ == "__main__":
    asyncio.run(main())
