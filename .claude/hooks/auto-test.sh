#!/bin/bash
#
# Auto-test Hook
# Automatically runs tests for test files after changes
#

set -e

FILE_PATH="${1:-${CLAUDE_FILE_PATH}}"

if [ -z "$FILE_PATH" ]; then
    echo "Error: No file path provided"
    exit 1
fi

# Run tests for this file
if pytest "$FILE_PATH" -x --tb=short --quiet 2>&1; then
    echo "$(date -Iseconds) | auto-test | $FILE_PATH | PASSED" >> .claude/logs/hooks.log
    exit 0
else
    echo "⚠️  Test file has failures - review output above"
    echo "$(date -Iseconds) | auto-test | $FILE_PATH | FAILED" >> .claude/logs/hooks.log
    exit 0  # Don't block on test failures
fi
