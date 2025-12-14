#!/bin/bash
# Apply Patch Script - Phase 2 Implementation
# This script applies generated fixes to the codebase

set -e  # Exit on error

echo "AutoFixer AI - Apply Patch Script"
echo "=================================="

# Check if patch data is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <patch_json_file>"
    echo "   or: $0 --stdin (to read from stdin)"
    exit 1
fi

# Read patch data
if [ "$1" = "--stdin" ]; then
    PATCH_JSON=$(cat)
else
    PATCH_JSON=$(cat "$1")
fi

# Parse patch data using Node.js
NODE_SCRIPT=$(cat << 'EOF'
const patchData = JSON.parse(process.argv[1]);
console.log(JSON.stringify({
    strategy: patchData.fix_strategy,
    files: patchData.files_to_modify,
    changes: patchData.exact_changes,
    risk: patchData.risk_assessment
}, null, 2));
EOF
)

PARSED_PATCH=$(node -e "$NODE_SCRIPT" "$PATCH_JSON")

echo "Parsed patch data:"
echo "$PARSED_PATCH"
echo ""

# Extract fix strategy
STRATEGY=$(echo "$PARSED_PATCH" | node -e "console.log(JSON.parse(require('fs').readFileSync(0, 'utf8')).strategy);")
echo "Fix strategy: $STRATEGY"

# Apply changes to each file
echo "$PARSED_PATCH" | node -e "
const patch = JSON.parse(require('fs').readFileSync(0, 'utf8'));
const fs = require('fs');
const path = require('path');

patch.changes.forEach(change => {
    const filePath = change.file;
    const lineNum = change.line;
    const before = change.before;
    const after = change.after;
    
    console.log(\`Applying fix to: \${filePath} at line \${lineNum}\`);
    
    // Read the file
    let content = fs.readFileSync(filePath, 'utf8');
    const lines = content.split('\n');
    
    // Validate the line exists and matches expected content
    if (lineNum > lines.length) {
        console.error(\`Error: Line \${lineNum} does not exist in \${filePath}\`);
        process.exit(1);
    }
    
    const actualLine = lines[lineNum - 1];
    if (actualLine.trim() !== before.trim()) {
        console.error(\`Error: Line content mismatch\`);
        console.error(\`Expected: \${before}\`);
        console.error(\`Actual:   \${actualLine}\`);
        process.exit(1);
    }
    
    // Apply the fix
    lines[lineNum - 1] = after;
    
    // Write back to file
    fs.writeFileSync(filePath, lines.join('\n'));
    console.log(\`✓ Fixed applied successfully\`);
});
"

echo ""
echo "✅ All fixes applied successfully!"
echo ""
echo "Risk Assessment:"
echo "$PARSED_PATCH" | node -e "console.log(JSON.parse(require('fs').readFileSync(0, 'utf8')).risk);"

exit 0