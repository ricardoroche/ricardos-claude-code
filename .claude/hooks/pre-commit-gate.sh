#!/bin/bash
#
# Pre-commit Quality Gate Hook
# Runs linting, type checking, and tests before allowing commits
#

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Log function
log() {
    echo "$(date -Iseconds) | pre-commit-gate | $1" >> .claude/logs/hooks.log
}

# Check if YOLO mode is enabled
if [ "${CLAUDE_YOLO_MODE:-0}" = "1" ]; then
    echo -e "${YELLOW}⚠️  YOLO mode enabled - skipping quality checks${NC}"
    log "SKIPPED (YOLO_MODE=1)"
    exit 0
fi

# Check if quick skip is enabled
if [ "${CLAUDE_SKIP_CHECKS:-0}" = "1" ]; then
    echo -e "${YELLOW}⚠️  Quality checks skipped (CLAUDE_SKIP_CHECKS=1)${NC}"
    log "SKIPPED (SKIP_CHECKS=1)"
    exit 0
fi

echo "Running pre-commit quality gate..."

# 1. Linting with ruff
echo -n "  Linting with ruff... "
if ruff check . 2>&1 | grep -q "error"; then
    echo -e "${RED}✗ Failed${NC}"
    echo ""
    echo "Fix linting issues with: /fix"
    log "FAILED (linting)"
    exit 1
fi
echo -e "${GREEN}✓ Passed${NC}"

# 2. Type checking with mypy
echo -n "  Type checking with mypy... "
if ! mypy . --no-error-summary 2>&1 > /dev/null; then
    echo -e "${RED}✗ Failed${NC}"
    echo ""
    echo "Fix type errors manually or review with: /lint"
    log "FAILED (type-check)"
    exit 1
fi
echo -e "${GREEN}✓ Passed${NC}"

# 3. Running tests
echo -n "  Running tests... "
if ! pytest --quiet -x --lf --ff 2>&1 > /dev/null; then
    echo -e "${RED}✗ Failed${NC}"
    echo ""
    echo "Fix failing tests or run: /test"
    log "FAILED (tests)"
    exit 1
fi
echo -e "${GREEN}✓ Passed${NC}"

echo ""
echo -e "${GREEN}✓ All quality checks passed${NC}"
log "PASSED"

exit 0
