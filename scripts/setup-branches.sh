#!/bin/bash

# Setup script for initializing branches in repositories created from template
# This script should be run in a new repository created from the template

set -e  # Exit on error

echo "=== Template Repository Branch Setup ==="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo -e "${RED}Error: Not a git repository${NC}"
  exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "Current branch: ${GREEN}${CURRENT_BRANCH}${NC}"
echo ""

# Function to check if branch exists locally
branch_exists_local() {
  git show-ref --verify --quiet "refs/heads/$1"
}

# Function to check if branch exists remotely
branch_exists_remote() {
  git ls-remote --heads origin "$1" 2>/dev/null | grep -q "$1"
}

# Ensure we're on main branch
if [ "$CURRENT_BRANCH" != "main" ]; then
  echo -e "${YELLOW}Switching to main branch...${NC}"
  git checkout main
fi

# Ensure main is up to date
echo "Fetching latest changes..."
git fetch origin
git pull origin main

echo ""
echo "=== Creating Required Branches ==="
echo ""

# Create develop branch
if branch_exists_remote "develop"; then
  echo -e "${GREEN}✓${NC} develop branch exists remotely"
  if ! branch_exists_local "develop"; then
    git checkout -b develop origin/develop
    echo -e "${GREEN}✓${NC} Checked out develop branch from remote"
  fi
elif branch_exists_local "develop"; then
  echo -e "${YELLOW}⚠${NC} develop branch exists locally but not remotely"
  read -p "Do you want to push it to remote? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push -u origin develop
    echo -e "${GREEN}✓${NC} Pushed develop branch to remote"
  fi
else
  echo "Creating develop branch..."
  git checkout -b develop
  git push -u origin develop
  echo -e "${GREEN}✓${NC} Created and pushed develop branch"
fi

# Create staging branch
git checkout main
if branch_exists_remote "staging"; then
  echo -e "${GREEN}✓${NC} staging branch exists remotely"
  if ! branch_exists_local "staging"; then
    git checkout -b staging origin/staging
    echo -e "${GREEN}✓${NC} Checked out staging branch from remote"
  fi
elif branch_exists_local "staging"; then
  echo -e "${YELLOW}⚠${NC} staging branch exists locally but not remotely"
  read -p "Do you want to push it to remote? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push -u origin staging
    echo -e "${GREEN}✓${NC} Pushed staging branch to remote"
  fi
else
  echo "Creating staging branch..."
  git checkout -b staging
  git push -u origin staging
  echo -e "${GREEN}✓${NC} Created and pushed staging branch"
fi

# Return to main branch
git checkout main

echo ""
echo "=== Setup Complete ==="
echo ""
echo -e "${GREEN}✓${NC} All required branches are now set up:"
git branch -a | grep -E '(remotes/origin/)?(main|develop|staging)$' || true

echo ""
echo "=== Next Steps ==="
echo ""
echo "1. Set up branch protection rules in GitHub:"
echo "   - Go to Settings > Branches"
echo "   - Protect main, staging, and develop branches"
echo "   - Require pull requests for all merges"
echo ""
echo "2. Development workflow:"
echo "   - Create feature branches from develop"
echo "   - Merge features to develop via PR"
echo "   - Merge develop to staging via PR (for testing)"
echo "   - Run 'Prepare Release' workflow (from GitHub Actions)"
echo "   - Merge staging to main via PR (for production)"
echo ""
echo "3. For more information, see:"
echo "   - .github/RELEASE_WORKFLOW.md"
echo ""
