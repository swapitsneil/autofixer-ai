import { logError } from '../../lib/logger';

/**
 * API endpoint that always throws an error
 * For testing guaranteed failure scenarios in AutoFixer AI demo
 */

export default async function handler(req, res) {
  const route = '/api/trigger-bug';

  try {
    // Always throw an error
    throw new Error('Guaranteed bug triggered - this endpoint always fails');

  } catch (error) {
    // Log error to Kestra webhook
    await logError(error, route);

    // Return error response
    res.status(500).json({
      success: false,
      error: error.message,
      route: route,
      timestamp: new Date().toISOString(),
      note: 'This endpoint is designed to always fail for demo purposes'
    });
  }
}