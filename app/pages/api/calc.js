import { logError } from '../../lib/logger';

/**
 * Calculator API with intentional bugs for AutoFixer AI demo
 * - 20% probability of random failure
 * - Intentional bug: undefined variable 'x'
 */

export default async function handler(req, res) {
  const { a, b } = req.query;
  const route = '/api/calc';

  try {
    // 20% chance of random failure
    if (Math.random() < 0.2) {
      throw new Error('Random failure occurred');
    }

    // Intentional bug: x is undefined
    const x = Number(req.query.x) || 0;
    const result = 10 + x;

    // This code never runs due to the bug above
    res.status(200).json({
      success: true,
      result: result,
      operation: 'addition',
      operands: { a: Number(a), b: Number(b) }
    });

  } catch (error) {
    // Log error to Kestra webhook
    await logError(error, route);

    // Return error response
    res.status(500).json({
      success: false,
      error: error.message,
      route: route,
      timestamp: new Date().toISOString()
    });
  }
}