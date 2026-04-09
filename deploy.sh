#!/bin/bash

# =============================================================================
# GUARDRAIL: Deploy script for Relentless Construction Website
# This script verifies all targets before deploying.
# =============================================================================

set -e

# Authorized targets - DO NOT MODIFY
AUTHORIZED_GITHUB_REPO="Emerald-Beacon/Relentless-Construction-Website"
AUTHORIZED_NETLIFY_PROJECT="relentless-construction-website"
AUTHORIZED_NETLIFY_SITE_ID="5761d556-2e2d-409d-a0e2-dac63d2348a2"
AUTHORIZED_URL="relentlessconstruction.io"

echo ""
echo "============================================================"
echo "  Relentless Construction - Deploy Script"
echo "============================================================"
echo ""

# Check 1: Verify Git Remote
echo "Checking Git remote..."
CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "NOT SET")

if [[ "$CURRENT_REMOTE" != *"$AUTHORIZED_GITHUB_REPO"* ]]; then
    echo ""
    echo "  ❌ WRONG GIT REMOTE"
    echo "  Current: $CURRENT_REMOTE"
    echo "  Expected: *$AUTHORIZED_GITHUB_REPO*"
    echo ""
    echo "  Run: git remote set-url origin https://github.com/$AUTHORIZED_GITHUB_REPO.git"
    echo ""
    exit 1
fi
echo "  ✓ Git remote verified: $AUTHORIZED_GITHUB_REPO"

# Check 2: Verify Netlify Project
echo "Checking Netlify project..."
NETLIFY_STATUS=$(netlify status 2>/dev/null || echo "NOT LINKED")

if [[ "$NETLIFY_STATUS" != *"$AUTHORIZED_NETLIFY_PROJECT"* ]]; then
    echo ""
    echo "  ❌ WRONG NETLIFY PROJECT"
    echo "  Expected: $AUTHORIZED_NETLIFY_PROJECT"
    echo ""
    echo "  Run: netlify link --name $AUTHORIZED_NETLIFY_PROJECT"
    echo ""
    exit 1
fi
echo "  ✓ Netlify project verified: $AUTHORIZED_NETLIFY_PROJECT"

# Check 3: Verify Netlify URL
if [[ "$NETLIFY_STATUS" != *"$AUTHORIZED_URL"* ]]; then
    echo ""
    echo "  ❌ WRONG NETLIFY URL"
    echo "  Expected URL to contain: $AUTHORIZED_URL"
    echo ""
    exit 1
fi
echo "  ✓ Netlify URL verified: $AUTHORIZED_URL"

echo ""
echo "All checks passed! Deploying..."
echo ""

# Deploy
netlify deploy --prod --dir=website

echo ""
echo "============================================================"
echo "  ✓ Deploy complete to $AUTHORIZED_URL"
echo "============================================================"
echo ""
