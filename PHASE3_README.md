# AutoFixer AI - Phase 3: Code Review Integration

This document describes the Phase 3 implementation of the AutoFixer AI system, focusing on CodeRabbit integration for automated code review.

## Overview

Phase 3 adds automated code review capabilities to the autonomous fix loop:
- **PR Creation**: Automated pull request generation with detailed descriptions
- **CodeRabbit Integration**: Automated code review and feedback
- **Review Processing**: Handle and apply review suggestions
- **Approval Workflow**: Mark fixes as ready for production

## Phase 3 Components

### 1. create_pr.sh
**Automated PR Creation**

Creates pull requests with comprehensive documentation of the fix.

**Features:**
- Generates clear PR titles and descriptions
- Documents what was broken, why, and how it was fixed
- Includes testing validation results
- Creates Git branches and commits
- Pushes to remote repositories
- Provides GitHub CLI commands for PR creation

**Usage:**
```bash
./create_pr.sh <fixed_file> <original_error> <root_cause> <fix_summary>
```

**Example:**
```bash
./create_pr.sh ../../app/pages/api/calc.js "x is not defined" "Variable undefined" "Added variable declaration"
```

**Output:**
- Git branch creation
- Commit with descriptive message
- PR summary with full documentation
- GitHub CLI commands for PR creation

### 2. code_rabbit_review.sh
**CodeRabbit Integration**

Handles all aspects of CodeRabbit review process.

**Actions:**
- `check-status`: Check review status
- `get-feedback`: Get review comments and suggestions
- `apply-fixes`: Apply suggested improvements
- `approve`: Mark as ready for merge

**Usage:**
```bash
./code_rabbit_review.sh <pr_url_or_id> <action>
```

**Examples:**
```bash
# Check review status
./code_rabbit_review.sh 123 check-status

# Get feedback
./code_rabbit_review.sh 123 get-feedback

# Apply suggestions
./code_rabbit_review.sh 123 apply-fixes

# Approve PR
./code_rabbit_review.sh 123 approve
```

### 3. autofix_with_review.sh
**Complete Phase 3 Workflow**

Orchestrates the entire Phase 3 process from fix to approval.

**Workflow:**
1. Phase 2: Apply fix and validate
2. Phase 3: Create PR
3. Phase 3: CodeRabbit review
4. Phase 3: Apply suggestions
5. Phase 3: Final approval

**Usage:**
```bash
./autofix_with_review.sh <file_path> <error_message> <stack_trace>
```

## Phase 3 Workflow

```
Phase 2 Complete (Fixed & Validated)
           ↓
    create_pr.sh
           ↓
    Git Branch + Commit
           ↓
    Push to Remote
           ↓
    Create PR (GitHub CLI)
           ↓
    code_rabbit_review.sh
           ↓
    Check Status
           ↓
    Get Feedback
           ↓
    Apply Suggestions
           ↓
    Final Approval
           ↓
    Ready for Merge
```

## PR Documentation

Every PR includes:

### Title
Clear, descriptive title indicating the fix
```
Fix: x is not defined in calc.js
```

### Description
Comprehensive documentation with:

**What was broken**
- Error message
- File path
- Impact

**Why it happened**
- Root cause analysis
- Technical explanation

**What was changed**
- Specific changes made
- Files modified
- Lines affected

**Why the fix is safe**
- Minimal changes
- Addresses root cause
- No refactoring
- Preserves style
- Tested locally

**Testing**
- Syntax validation
- Variable declaration checks
- Import validation
- Build verification

**Risk Assessment**
- Safety evaluation
- Potential concerns
- Mitigation strategies

## CodeRabbit Review Process

### 1. Status Check
Returns:
- Approval status
- Confidence level
- Issues found
- Suggestions count
- Summary comments

### 2. Feedback Collection
Gathers:
- Approval comments
- Suggestions for improvement
- Questions about implementation
- Code quality notes

### 3. Suggestion Application
Applies:
- Code style improvements
- Best practice suggestions
- Security enhancements
- Performance optimizations

### 4. Final Approval
Confirms:
- All checks passed
- No blocking issues
- Fix is safe
- Ready for merge

## Example: Complete Phase 3 Run

```bash
$ ./autofix_with_review.sh ../../app/pages/api/calc.js "x is not defined" "ReferenceError: x is not defined"

AutoFixer AI - Phase 3 Complete Workflow
=========================================

📋 Phase 3: Autonomous Fix with Code Review

🔄 Phase 2: Applying fix...
✓ Root cause identified
✓ Fix generated
✓ Fix applied
✓ Fix validated

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Phase 3: Creating PR...
✓ PR summary generated
✓ Git branch created
✓ Commit created
✓ Branch pushed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🤖 Phase 3: CodeRabbit Review...
✓ Status checked - Approved
✓ Feedback received
✓ Suggestions applied
✓ Final approval

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎉 Phase 3 Complete!

Workflow Summary:
  ✓ Phase 2: Bug fixed locally
  ✓ Phase 2: Fix validated
  ✓ Phase 3: PR created
  ✓ Phase 3: CodeRabbit review completed
  ✓ Phase 3: Suggestions applied
  ✓ Phase 3: PR approved

Next Steps:
  1. Merge the PR
  2. Delete the feature branch
  3. Proceed to Phase 4 (deployment)
```

## Integration Points

### Git Integration
- Automatic branch creation
- Descriptive commit messages
- Remote push support
- Branch naming conventions

### GitHub Integration
- GitHub CLI commands
- PR creation automation
- Label assignment
- Reviewer assignment

### CodeRabbit Integration
- API calls for review status
- Feedback retrieval
- Suggestion processing
- Approval management

## Safety Features

### PR Safety
- Clear documentation
- Risk assessment
- Testing validation
- Minimal changes

### Review Safety
- Conservative approvals
- Detailed feedback
- Suggestion validation
- Human oversight option

### Code Safety
- No risky refactors
- Preserve original intent
- Maintain code style
- Reversible changes

## Exit Criteria

Phase 3 is complete when:
- ✅ Fix is applied locally
- ✅ Fix is validated
- ✅ PR is created
- ✅ CodeRabbit review is complete
- ✅ All suggestions are applied
- ✅ PR is approved
- ✅ Ready for merge

## Next Phase: Phase 4

Phase 4 will add:
- Automated deployment (Vercel)
- Production monitoring
- Rollback mechanisms
- Post-deployment validation

## Configuration

### Environment Variables
```bash
GITHUB_TOKEN=<your_github_token>
CODERABBIT_API_KEY=<your_coderaabit_key>
REPO_OWNER=<repo_owner>
REPO_NAME=<repo_name>
```

### Git Configuration
```bash
git config user.name "AutoFixer AI"
git config user.email "autofixer@example.com"
```

## Troubleshooting

### PR Creation Issues
- Check Git repository status
- Verify remote origin
- Ensure GitHub CLI is installed
- Validate Git credentials

### CodeRabbit Issues
- Check API key
- Verify PR URL
- Ensure CodeRabbit is installed
- Check review permissions

### Review Feedback Issues
- Validate suggestion format
- Check file permissions
- Ensure working directory
- Verify Git status

## Best Practices

1. **Always document changes** - Clear PR descriptions
2. **Validate before PR** - Ensure fixes work locally
3. **Review feedback carefully** - Apply suggestions thoughtfully
4. **Test after suggestions** - Re-validate after changes
5. **Maintain clean history** - Use descriptive commit messages

## Metrics

Track these metrics:
- PR creation time
- Review response time
- Suggestion application rate
- Approval rate
- Time to merge

---

**Phase 3 Status: ✅ Complete**

The autonomous fix loop now includes automated code review with CodeRabbit integration.