import os
import sys
import asyncio
import subprocess
import looker_sdk
from looker_sdk import models
from google.antigravity import Agent, LocalAgentConfig, CapabilitiesConfig

MAX_ATTEMPTS = 3

def get_issue_context():
    title = os.environ.get("ISSUE_TITLE", "")
    body = os.environ.get("ISSUE_BODY", "")
    return f"Issue Title: {title}\n\nIssue Body: {body}"

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
    branch_name = f"agent-fix/issue-{os.environ.get('ISSUE_NUMBER', '0')}"
    issue_context = get_issue_context()
    
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
            "Read the necessary .lkml files, apply your fixes, and provide a summary of your changes."
        ),
        capabilities=CapabilitiesConfig()  # Enables tool calling (read_file, write_file, etc.)
    )
    
    validation_errors = []
    
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
            print(f"Agent response:\n{await response.text()}\n")
            
            print("Syncing changes with remote repository...")
            commit_message = f"Agent fix attempt {attempt} for issue #{os.environ.get('ISSUE_NUMBER', '0')}"
            sync_with_remote(branch_name, commit_message)
            
            print("Running Looker validation...")
            validation_errors = validate_in_looker(sdk, project_id, branch_name)
            
            if not validation_errors:
                print("LookML validation passed successfully!")
                sys.exit(0)
            else:
                print(f"Validation failed with {len(validation_errors)} errors.")
                for err in validation_errors:
                    print(f" - {err.message} (File: {err.file_path})")
                    
        print(f"Failed to fix LookML after {MAX_ATTEMPTS} attempts.")
        sys.exit(1)

if __name__ == "__main__":
    asyncio.run(main())
