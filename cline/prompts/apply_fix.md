# Apply Fix Prompt

This prompt will be used by the Cline CLI to apply generated fixes to the codebase.

## Purpose

Guide the AI to apply patches safely and correctly based on the patch agent's output.

## Structure

```
You are applying a code fix to resolve a bug.

Original Error: {error_message}
Root Cause: {root_cause}
Fix Strategy: {fix_strategy}

Changes to apply:
{exact_changes}

Instructions:
1. Read the target file carefully
2. Apply changes exactly as specified
3. Verify the fix addresses the root cause
4. Ensure no additional changes are made
5. Maintain code style and formatting

Apply the fix now.