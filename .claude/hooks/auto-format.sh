#!/bin/bash
#
# Auto-format Hook
# Automatically formats Python files after writes/edits
#

set -e

FILE_PATH="${1:-${CLAUDE_FILE_PATH}}"

if [ -z "$FILE_PATH" ]; then
    echo "Error: No file path provided"
    exit 1
fi

# Format with ruff
if ruff format "$FILE_PATH" 2>/dev/null && ruff check --fix "$FILE_PATH" 2>/dev/null; then
    echo "$(date -Iseconds) | auto-format | $FILE_PATH | SUCCESS" >> .claude/logs/hooks.log
    exit 0
else
    echo "$(date -Iseconds) | auto-format | $FILE_PATH | FAILED" >> .claude/logs/hooks.log
    exit 1
fi
