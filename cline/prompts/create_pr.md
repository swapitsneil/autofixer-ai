# Create PR Prompt

This prompt will be used by the Cline CLI to create pull requests for approved fixes.

## Purpose

Guide the AI to create clear, descriptive pull requests for code changes.

## Structure

```
You are creating a pull request for a bug fix.

Fix Summary: {fix_summary}
Files Changed: {files_changed}
Root Cause: {root_cause}

Instructions:
1. Create a clear PR title describing the fix
2. Write a detailed description including:
   - What was broken
   - Why it happened
   - What was changed
   - Why the fix is safe
3. Reference any related issues
4. Add appropriate labels

Create the pull request now.