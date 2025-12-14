/**
 * Logger module for AutoFixer AI Demo
 * Sends error reports to Kestra webhook for incident detection
 */

/**
 * Logs an error to the Kestra webhook
 * @param {Error} error - The error object to log
 * @param {string} route - The API route where the error occurred
 */
export async function logError(error, route) {
  const payload = {
    message: error.message || String(error),
    stack: error.stack || '',
    route: route || 'unknown',
    timestamp: new Date().toISOString()
  };

  try {
    // Send to Kestra webhook - failures should not crash the app
    await fetch('http://localhost:8080/api/v1/executions/webhook/autofixer', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(payload),
    });
  } catch (webhookError) {
    // Silently fail - webhook errors should not affect app stability
    console.warn('Failed to send error to Kestra webhook:', webhookError.message);
  }
}