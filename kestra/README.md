# Kestra Workflows

This directory contains Kestra workflow definitions for the AutoFixer AI orchestration layer.

## Overview

Kestra workflows handle the orchestration of incident detection, processing, and routing through the AutoFixer AI system.

## Workflows

### 1. detect-incident.yaml
**Purpose**: Webhook entry point for receiving error incidents

**Responsibilities**:
- Receives POST requests at `/api/v1/executions/webhook/autofixer`
- Captures error payload from Next.js app
- Forwards incident data to routing workflow
- Logs incident receipt

**Input Payload**:
```json
{
  "message": "Error message",
  "stack": "Stack trace",
  "route": "/api/calc",
  "timestamp": "2025-01-14T07:30:00.000Z"
}
```

### 2. route-incident.yaml
**Purpose**: Validates and enriches incident data

**Responsibilities**:
- Validates all required fields (message, stack, route, timestamp)
- Adds severity classification (currently always "HIGH")
- Forwards enriched data to storage workflow
- Logs validation results

**Enrichment**:
- Adds `severity` field based on error analysis
- Validates payload completeness
- Ensures data quality for AI processing

### 3. store-incident.yaml
**Purpose**: Stores incident data and marks processing complete

**Responsibilities**:
- Receives enriched incident data
- Logs complete incident details
- Marks workflow as successful
- Signals readiness for AI agent analysis

**Output**:
- Structured incident logs
- Confirmation of successful storage
- Trigger for AI reasoning pipeline

## Workflow Chain

```
Webhook → detect-incident → route-incident → store-incident → AI Agents
```

## Namespace

All workflows use the `autofixer` namespace.

## Execution

Workflows are triggered automatically when the Next.js app sends errors to the webhook endpoint.

## Future Enhancements

- Dynamic severity calculation based on error patterns
- Integration with AI agent calls
- Database storage for incident history
- Alerting and notification workflows