# AI Agents

This directory contains Oumi agent definitions for the AutoFixer AI reasoning layer.

## Overview

AI agents provide the reasoning capabilities to analyze errors, identify root causes, and generate safe fixes. These agents use Together AI for processing.

## Agent Architecture

All agents are designed with:
- **Clear responsibilities**: Each agent has a specific, focused job
- **Structured I/O**: JSON-based input and output for machine readability
- **Reasoning-first**: Focus on analysis, not execution
- **Production-safe**: Conservative approaches prioritizing stability

## Agents

### 1. forensics_agent.json
**Purpose**: Root cause analysis from error logs and stack traces

**Input**:
- Error message and stack trace
- File paths and line numbers
- Code context

**Output**:
```json
{
  "root_cause": "Explanation of why error occurred",
  "confidence": "HIGH|MEDIUM|LOW",
  "affected_files": ["file1.js", "file2.js"],
  "error_type": "ReferenceError|TypeError|etc"
}
```

**Responsibilities**:
- Analyze stack traces to identify exact error locations
- Determine root cause of failures
- Classify error types
- Assess confidence in analysis

### 2. patch_agent.json
**Purpose**: Generate minimal, safe code fixes

**Input**:
- Root cause analysis
- Affected files and locations
- Error context

**Output**:
```json
{
  "fix_strategy": "declare_variable|handle_null|fix_logic",
  "files_to_modify": ["file1.js"],
  "exact_changes": [
    {
      "file": "file1.js",
      "line": 15,
      "before": "const result = 10 + x;",
      "after": "const x = 0; const result = 10 + x;"
    }
  ],
  "risk_assessment": "Safety notes and considerations"
}
```

**Responsibilities**:
- Create surgical, minimal fixes
- Ensure fixes are reversible
- Avoid risky refactors
- Focus on root cause, not symptoms

### 3. validation_agent.json
**Purpose**: Verify fixes are logically correct and safe

**Input**:
- Original error and root cause
- Proposed fix
- Code context

**Output**:
```json
{
  "is_valid": true|false,
  "confidence": "HIGH|MEDIUM|LOW",
  "reasoning": "Explanation of validation decision",
  "concerns": ["potential issue 1", "potential issue 2"],
  "suggestions": ["improvement 1", "improvement 2"]
}
```

**Responsibilities**:
- Verify fix addresses root cause
- Check for logical errors
- Identify potential risks
- Approve or reject fixes

## Agent Pipeline

```
Error Data → Forensics → Root Cause → Patch → Fix Plan → Validation → Approved Fix
```

## Model Configuration

All agents use:
- **Model**: togethercomputer/llama-2-70b-chat
- **Temperature**: 0.1-0.3 (conservative for reliability)
- **Max Tokens**: 512-2048 (based on task complexity)

## Design Principles

1. **Minimal Changes**: Prefer surgical fixes over large refactors
2. **Reversibility**: All fixes must be easy to undo
3. **No Bypassing**: Never use try/catch to hide errors
4. **Production Safety**: Conservative, risk-aware approaches
5. **Structured Output**: Machine-readable JSON for automation

## Future Enhancements

- Multi-model support (different models for different tasks)
- Confidence thresholding
- Human-in-the-loop for low-confidence cases
- Learning from fix outcomes
- Integration with code review systems