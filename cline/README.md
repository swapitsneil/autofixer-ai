# CLI Integration

This directory contains CLI prompts and scripts for the AutoFixer AI system.

## Overview

The CLI integration layer provides tools for:
- AI-assisted fix application using Cline
- Automated testing and validation
- Pull request creation
- Workflow orchestration

## Directory Structure

```
cline/
├── prompts/          # AI prompts for Cline interactions
│   ├── apply_fix.md  # Prompt for applying patches
│   ├── run_tests.md  # Prompt for testing fixes
│   └── create_pr.md  # Prompt for PR creation
└── scripts/          # Shell scripts for automation
    ├── apply_patch.sh # Patch application script
    ├── test.sh       # Test execution script
    └── pr.sh         # PR creation script
```

## Prompts

### apply_fix.md
**Purpose**: Guide Cline to apply generated fixes safely

**Use Case**: When a patch has been validated and needs to be applied to the codebase

**Key Instructions**:
- Read target file carefully
- Apply changes exactly as specified
- Verify fix addresses root cause
- Maintain code style

### run_tests.md
**Purpose**: Guide Cline to verify fixes don't break functionality

**Use Case**: After applying a fix to ensure no regressions

**Key Instructions**:
- Run existing test suite
- Perform smoke tests
- Verify original error is resolved
- Check for new errors

### create_pr.md
**Purpose**: Guide Cline to create clear, descriptive pull requests

**Use Case**: When a fix is ready for code review

**Key Instructions**:
- Create descriptive PR title
- Document what/why/how of the fix
- Reference related issues
- Add appropriate labels

## Scripts

### apply_patch.sh
**Status**: Placeholder for Phase 2

**Future Implementation**:
- Read patch data from stdin or file
- Validate patch format
- Apply changes to target files
- Verify application success
- Report results

### test.sh
**Status**: Placeholder for Phase 2

**Future Implementation**:
- Run existing test suite
- Perform smoke tests
- Verify no regressions
- Check original error is resolved
- Report test results

### pr.sh
**Status**: Placeholder for Phase 3

**Future Implementation**:
- Create new branch for fix
- Commit changes with descriptive message
- Push branch to remote
- Create pull request
- Add labels and reviewers

## Workflow Integration

```
Kestra → AI Agents → Fix Plan → Cline Prompts → Scripts → Applied Fix
```

## Phase 1 Status

Currently contains placeholder implementations. Full implementation will be completed in:
- **Phase 2**: Script implementations for fix application and testing
- **Phase 3**: PR creation and code review integration

## Usage Examples

### Applying a Fix
```bash
# Phase 2 will implement:
./cline/scripts/apply_patch.sh < fix_data.json
```

### Running Tests
```bash
# Phase 2 will implement:
./cline/scripts/test.sh --file patched_file.js
```

### Creating PR
```bash
# Phase 3 will implement:
./cline/scripts/pr.sh --fix-summary "Fixed undefined variable"
```

## Future Enhancements

- Interactive mode for manual review
- Dry-run mode for testing fixes
- Rollback capabilities
- Integration with version control
- Progress tracking and reporting