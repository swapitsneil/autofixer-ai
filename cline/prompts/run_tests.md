# Run Tests Prompt

This prompt will be used by the Cline CLI to verify that fixes don't break existing functionality.

## Purpose

Guide the AI to run tests and verify the fix works correctly.

## Structure

```
You are verifying that a fix doesn't break existing functionality.

Fixed File: {file_path}
Fix Summary: {fix_summary}

Instructions:
1. Check if the project has tests
2. Run existing tests to verify nothing broke
3. If no tests exist, perform basic smoke tests
4. Verify the original error no longer occurs
5. Check for any new errors or warnings

Report the test results.