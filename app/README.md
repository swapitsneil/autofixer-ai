# AutoFixer AI Demo Application

A Next.js application that intentionally produces runtime errors to demonstrate the AutoFixer AI system's capabilities.

## Overview

This demo app is part of the AutoFixer AI project - an autonomous bug detection and fixing system. The app intentionally contains bugs that trigger runtime errors, which are then captured and sent to Kestra for AI-powered analysis and automated fixing.

## Features

- **Buggy Calculator API** (`/api/calc`): 20% random failure rate + undefined variable bug
- **Guaranteed Error Endpoint** (`/api/trigger-bug`): Always fails for testing purposes
- **Kestra Integration**: All errors are logged to Kestra webhook for incident detection
- **Simple UI**: Web interface to trigger both types of errors
- **Production-Ready**: Stable, never hangs, always responds

## Getting Started

### Prerequisites

- Node.js 18+ installed
- npm or yarn package manager

### Installation

```bash
# Install dependencies
npm install

# Run the development server
npm run dev
```

The app will be available at [http://localhost:3000](http://localhost:3000).

### Building for Production

```bash
# Create production build
npm run build

# Start production server
npm start
```

## How to Trigger Bugs

### 1. Random Calculator Bug

**UI Method:**
- Click the "Trigger Random Calc" button on the homepage

**API Method:**
```bash
curl "http://localhost:3000/api/calc?a=5&b=10"
```

**What happens:**
- 20% chance of random failure
- Always fails with `ReferenceError: x is not defined`
- Error is logged to Kestra webhook

### 2. Guaranteed Bug

**UI Method:**
- Click the "Trigger Guaranteed Bug" button on the homepage

**API Method:**
```bash
curl "http://localhost:3000/api/trigger-bug"
```

**What happens:**
- Always throws an error
- Error is logged to Kestra webhook

## Expected Behavior

### Successful Response (Never happens with current bugs)
```json
{
  "success": true,
  "result": 15,
  "operation": "addition",
  "operands": { "a": 5, "b": 10 }
}
```

### Error Response (What you'll actually see)
```json
{
  "success": false,
  "error": "x is not defined",
  "route": "/api/calc",
  "timestamp": "2025-01-14T07:30:00.000Z"
}
```

## Architecture

### Error Flow

1. **Error Occurs**: Runtime error in API endpoint
2. **Logger Captures**: `logError()` function captures error details
3. **Webhook Sent**: Error payload sent to Kestra at `http://localhost:8080/api/v1/executions/webhook/autofixer`
4. **Kestra Processes**: Workflow chain processes the incident
5. **AI Analysis**: Oumi agents analyze root cause and plan fixes
6. **Auto-Fix**: Future phase will automatically apply fixes

### Error Payload Structure

```json
{
  "message": "Error message",
  "stack": "Error stack trace",
  "route": "/api/calc",
  "timestamp": "2025-01-14T07:30:00.000Z"
}
```

## Intentional Bugs

This app contains **intentional bugs** for demonstration purposes:

1. **Undefined Variable** (`/api/calc`):
   ```javascript
   const result = 10 + x; // x is not defined
   ```

2. **Random Failure** (`/api/calc`):
   ```javascript
   if (Math.random() < 0.2) {
     throw new Error('Random failure occurred');
   }
   ```

3. **Guaranteed Error** (`/api/trigger-bug`):
   ```javascript
   throw new Error('Guaranteed bug triggered');
   ```

These bugs are designed to test the AutoFixer AI system's ability to:
- Detect runtime errors
- Analyze stack traces
- Identify root causes
- Generate safe fixes

## Kestra Integration

The app sends all errors to a Kestra webhook for processing:

- **Webhook URL**: `http://localhost:8080/api/v1/executions/webhook/autofixer`
- **Method**: POST
- **Content-Type**: application/json
- **Failure Handling**: Webhook failures don't crash the app

## Deployment

This app is ready for Vercel deployment:

1. Push to GitHub
2. Connect repository to Vercel
3. Deploy automatically on push

The app will work in production, but Kestra webhook URLs will need to be updated to production endpoints.

## Development

### Project Structure

```
app/
├── pages/
│   ├── api/
│   │   ├── calc.js           # Buggy calculator endpoint
│   │   └── trigger-bug.js    # Always-fails endpoint
│   └── index.js              # Demo UI
├── lib/
│   └── logger.js             # Kestra webhook logger
├── package.json
└── README.md
```

### Adding New Bug Types

To add a new intentional bug:

1. Create new API route in `pages/api/`
2. Add intentional error code
3. Call `logError(error, route)` in catch block
4. Add UI button in `pages/index.js`

## Troubleshooting

### App won't start
- Ensure Node.js 18+ is installed
- Run `npm install` to install dependencies
- Check port 3000 is not in use

### Webhook not received
- Ensure Kestra is running on localhost:8080
- Check browser console for webhook errors
- Webhook failures are logged but don't crash the app

### Errors not appearing
- Check browser developer console
- Verify API endpoints are accessible
- Ensure no browser extensions are blocking requests

## Next Steps

This demo app is Phase 1 of the AutoFixer AI system. Future phases will include:

- **Phase 2**: AI-powered fix generation
- **Phase 3**: Automated code review (CodeRabbit)
- **Phase 4**: Automated deployment (Vercel)

## License

MIT License - AutoFixer AI Team