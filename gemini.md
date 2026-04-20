# Gemini Agent Guidelines - Looker Project

## Core Development Principles
- **LookML Best Practices:** Always consult available Looker skills and documentation for instructions on creating and optimizing LookML.
- **LAMS Validation:** A hook is triggered after every file update. You must resolve the issues identified by LAMS in the file you are working in.
- **Looker Validation:** You must run the `validate_project` MCP tool every time a file is updated.
- **Code Integrity:** Never commit broken code. Ensure all validation checks pass before proceeding to the commit stage.

## Git & Deployment Workflow
- **Commits:** Create and push commits often. Aim to commit after the completion of every individual feature or logical change.
- **IDE Syncing:** After pushing changes via the CLI, the Looker IDE will be out of sync. You must instruct the user to perform the following steps to see the updates in the Looker UI:
    1. Open the project in the Looker instance.
    2. Click **"Revert to..."** in the Git menu.
    3. Select **"Revert local changes"**. 
    *Note: This allows the IDE to pull in the remote changes created by the CLI.*