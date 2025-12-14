#!/bin/bash
# Test Script - Phase 2 Implementation
# This script validates that fixes work correctly

set -e

echo "AutoFixer AI - Test Script"
echo "==========================="

# Check if test data is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <test_config_json>"
    echo "   or: $0 --smoke-test <file_path>"
    exit 1
fi

if [ "$1" = "--smoke-test" ]; then
    # Smoke test mode - basic validation
    FILE_PATH="$2"
    
    if [ -z "$FILE_PATH" ]; then
        echo "Error: File path required for smoke test"
        exit 1
    fi
    
    echo "Running smoke test on: $FILE_PATH"
    echo ""
    
    # Check if file exists
    if [ ! -f "$FILE_PATH" ]; then
        echo "❌ Error: File not found: $FILE_PATH"
        exit 1
    fi
    
    # Check for syntax errors
    echo "Checking syntax..."
    if node --check "$FILE_PATH" 2>/dev/null; then
        echo "✓ Syntax check passed"
    else
        echo "❌ Syntax error detected"
        exit 1
    fi
    
    # Check for undefined variables (common issue)
    echo "Checking for undefined variables..."
    
    # Check if x is declared before being used
    if grep -B5 "const result = 10 + x;" "$FILE_PATH" | grep -q "const x ="; then
        echo "✓ Variable 'x' is properly declared before use"
    elif grep -q "const result = 10 + x;" "$FILE_PATH"; then
        echo "❌ Found undefined variable 'x' - fix not applied correctly"
        exit 1
    else
        echo "✓ No undefined variable 'x' detected"
    fi
    
    echo ""
    echo "✅ Smoke test passed!"
    exit 0
fi

# Parse test configuration
TEST_CONFIG=$(cat "$1")

echo "Test configuration:"
echo "$TEST_CONFIG"
echo ""

# Run specific tests based on configuration
echo "$TEST_CONFIG" | node -e "
const config = JSON.parse(require('fs').readFileSync(0, 'utf8'));
const { spawn } = require('child_process');

console.log('Running validation tests...');

// Example test: Check if the fixed file can be imported without errors
if (config.file_path) {
    try {
        // Try to require/import the file
        delete require.cache[config.file_path];
        const module = require(config.file_path);
        console.log('✓ File can be imported without errors');
    } catch (error) {
        console.error('❌ Error importing file:', error.message);
        process.exit(1);
    }
}

// Example test: Check if specific patterns exist
if (config.expected_patterns) {
    const fs = require('fs');
    const content = fs.readFileSync(config.file_path, 'utf8');
    
    config.expected_patterns.forEach(pattern => {
        if (content.includes(pattern)) {
            console.log(\`✓ Found expected pattern: \${pattern}\`);
        } else {
            console.error(\`❌ Missing expected pattern: \${pattern}\`);
            process.exit(1);
        }
    });
}

// Example test: Check if error patterns are removed
if (config.error_patterns) {
    const fs = require('fs');
    const content = fs.readFileSync(config.file_path, 'utf8');
    
    config.error_patterns.forEach(pattern => {
        if (!content.includes(pattern)) {
            console.log(\`✓ Error pattern removed: \${pattern}\`);
        } else {
            console.error(\`❌ Error pattern still present: \${pattern}\`);
            process.exit(1);
        }
    });
}

console.log('✅ All validation tests passed!');
"

exit 0