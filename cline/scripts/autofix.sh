#!/bin/bash
# AutoFix Script - Phase 2 Implementation
# Main orchestration script for autonomous bug fixing

set -e

echo "AutoFixer AI - Autonomous Fix Loop"
echo "==================================="
echo ""

# Parse command line arguments
if [ $# -lt 3 ]; then
    echo "Usage: $0 <file_path> <error_message> <stack_trace>"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/file.js \"x is not defined\" \"ReferenceError: x is not defined\\n    at handler (file.js:15:21)\""
    exit 1
fi

FILE_PATH="$1"
ERROR_MESSAGE="$2"
STACK_TRACE="$3"

echo "📋 Incident Details:"
echo "  File: $FILE_PATH"
echo "  Error: $ERROR_MESSAGE"
echo ""

# Step 1: Validate input
if [ ! -f "$FILE_PATH" ]; then
    echo "❌ Error: File not found: $FILE_PATH"
    exit 1
fi

# Step 2: Analyze the error and generate fix using AI reasoning
echo "🔍 Step 1: Analyzing root cause..."
echo ""

# Create analysis payload
ANALYSIS_PAYLOAD=$(cat << EOF
{
  "file_path": "$FILE_PATH",
  "error_message": "$ERROR_MESSAGE",
  "stack_trace": "$STACK_TRACE"
}
EOF
)

# Simulate AI analysis (in real implementation, this would call Oumi agents)
echo "Analyzing with forensics agent..."
echo "Identifying root cause..."

# For demo purposes, we'll use a predefined fix based on common patterns
if echo "$ERROR_MESSAGE" | grep -q "x is not defined"; then
    # This is the known bug in calc.js
    ROOT_CAUSE="Variable 'x' is referenced but never defined"
    FIX_STRATEGY="declare_variable"
    
    echo "✓ Root cause identified: $ROOT_CAUSE"
    echo ""
    
    # Step 3: Generate fix
    echo "🔧 Step 2: Generating fix..."
    
    # Read the file to find the exact line
    BUGGY_LINE=$(grep -n "const result = 10 + x;" "$FILE_PATH" | cut -d: -f1)
    
    if [ -z "$BUGGY_LINE" ]; then
        echo "❌ Error: Could not find buggy line in file"
        exit 1
    fi
    
    echo "Found bug at line $BUGGY_LINE"
    
    # Generate patch
    PATCH_JSON=$(cat << EOF
{
  "fix_strategy": "$FIX_STRATEGY",
  "files_to_modify": ["$FILE_PATH"],
  "exact_changes": [
    {
      "file": "$FILE_PATH",
      "line": $BUGGY_LINE,
      "before": "    const result = 10 + x;",
      "after": "    const x = Number(req.query.x) || 0;\n    const result = 10 + x;"
    }
  ],
  "risk_assessment": "Low risk - simple variable declaration with default value"
}
EOF
)
    
    echo "Generated fix:"
    echo "$PATCH_JSON"
    echo ""
    
    # Step 4: Apply the fix
    echo "📝 Step 3: Applying fix..."
    echo "$PATCH_JSON" | ./apply_patch.sh --stdin
    
    if [ $? -ne 0 ]; then
        echo "❌ Error: Failed to apply fix"
        exit 1
    fi
    
    echo ""
    
    # Step 5: Validate the fix
    echo "✅ Step 4: Validating fix..."
    ./test.sh --smoke-test "$FILE_PATH"
    
    if [ $? -ne 0 ]; then
        echo "❌ Error: Fix validation failed"
        exit 1
    fi
    
    echo ""
    echo "🎉 AutoFix completed successfully!"
    echo ""
    echo "Summary:"
    echo "  ✓ Root cause identified"
    echo "  ✓ Fix generated"
    echo "  ✓ Fix applied"
    echo "  ✓ Fix validated"
    echo ""
    echo "The file has been fixed locally and is ready for use."
    
else
    echo "❌ Error: Unrecognized error pattern"
    echo "This autofix system currently only handles 'x is not defined' errors"
    exit 1
fi

exit 0