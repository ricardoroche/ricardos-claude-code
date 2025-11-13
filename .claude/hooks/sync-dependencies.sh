#!/bin/bash
#
# Sync Dependencies Hook
# Automatically syncs dependencies after pyproject.toml changes
#

set -e

# Try uv first, fall back to pip
if command -v uv &> /dev/null; then
    if uv sync --quiet 2>&1; then
        echo '✓ Dependencies synced with uv'
        echo "$(date -Iseconds) | dep-sync | uv | SUCCESS" >> .claude/logs/hooks.log
    else
        echo "$(date -Iseconds) | dep-sync | uv | FAILED" >> .claude/logs/hooks.log
    fi
elif command -v pip &> /dev/null; then
    if pip install -q -r requirements.txt 2>&1; then
        echo '✓ Dependencies installed with pip'
        echo "$(date -Iseconds) | dep-sync | pip | SUCCESS" >> .claude/logs/hooks.log
    else
        echo "$(date -Iseconds) | dep-sync | pip | FAILED" >> .claude/logs/hooks.log
    fi
else
    echo "No package manager found (uv or pip)"
    echo "$(date -Iseconds) | dep-sync | NONE | FAILED" >> .claude/logs/hooks.log
fi
