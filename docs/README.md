# AutoFixer AI Documentation

This directory contains documentation for the AutoFixer AI system.

## Overview

AutoFixer AI is an autonomous bug detection and fixing system that:
1. Detects runtime errors in applications
2. Analyzes root causes using AI agents
3. Generates safe, minimal fixes
4. Validates and applies fixes automatically

## Phase 1: Foundation

The current implementation includes:

### Application Layer (`../app/`)
- Next.js demo application with intentional bugs
- Error logging to Kestra webhook
- Simple UI to trigger errors

### Orchestration Layer (`../kestra/`)
- Webhook-triggered workflows
- Incident validation and enrichment
- Workflow chain for error processing

### AI Reasoning Layer (`../agents/`)
- Forensics Agent: Root cause analysis
- Patch Agent: Fix generation
- Validation Agent: Fix verification

### CLI Integration (`../cline/`)
- Prompts for AI-assisted fix application
- Scripts for automated workflows
- Placeholder implementations for Phase 2

## Architecture

```
Next.js App → Kestra Webhook → Workflow Chain → AI Agents → Fix Plan
     ↓              ↓                ↓              ↓           ↓
  Error       Incident       Validation &    Reasoning    Patch
 Occurs      Captured       Enrichment      Analysis     Generated
```

## Future Phases

### Phase 2: Fix Execution
- Automated patch application
- Test execution and validation
- Fix verification

### Phase 3: Code Review Integration
- CodeRabbit integration
- Automated PR creation
- Review feedback processing

### Phase 4: Deployment
- Vercel deployment automation
- Production monitoring
- Rollback mechanisms

## Getting Started

1. Navigate to `../app/` and run `npm install && npm run dev`
2. Start Kestra server on localhost:8080
3. Configure Oumi agents with Together AI
4. Trigger errors from the demo app UI
5. Observe workflow execution in Kestra

## Documentation Files

- `architecture.md`: Detailed system architecture (to be created)
- `api.md`: API documentation (to be created)
- `workflows.md`: Kestra workflow documentation (to be created)
- `agents.md`: AI agent specifications (to be created)

## Contributing

This is Phase 1 implementation. Future phases will build upon this foundation.