#!/bin/bash

# Fresh Start Script for Template Repositories
# This script creates a clean repository with NO commit history from the template
# Perfect for starting fresh without carrying over template commits

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_header() {
  echo ""
  echo -e "${CYAN}========================================${NC}"
  echo -e "${CYAN}$1${NC}"
  echo -e "${CYAN}========================================${NC}"
  echo ""
}

print_status() {
  echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC}  $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_info() {
  echo -e "${BLUE}ℹ${NC}  $1"
}

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  print_error "Not a git repository"
  exit 1
fi

print_header "Fresh Start - Template Repository Cleaner"

print_info "This script will:"
echo "  1. Remove ALL commit history from template"
echo "  2. Create a single 'Initial commit' with current files"
echo "  3. Force push to main branch"
echo "  4. Create clean develop and staging branches"
echo "  5. Optionally set up branch protection"
echo ""

print_warning "THIS IS DESTRUCTIVE! All git history will be erased."
print_warning "Make sure you have a backup if needed."
echo ""

read -p "Do you want to continue? (yes/no): " -r
echo
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
  print_info "Operation cancelled"
  exit 0
fi

# Get repository information
REPO_URL=$(git config --get remote.origin.url || echo "")
CURRENT_BRANCH=$(git branch --show-current)

if [ -z "$REPO_URL" ]; then
  print_error "No remote origin found"
  print_info "Please add a remote origin first: git remote add origin <url>"
  exit 1
fi

print_info "Repository: $REPO_URL"
print_info "Current branch: $CURRENT_BRANCH"
echo ""

# Step 1: Get project info for commit message
print_header "Step 1: Project Information"

# Try to get project name from package.json
if [ -f "package.json" ]; then
  PROJECT_NAME=$(grep -o '"name"[[:space:]]*:[[:space:]]*"[^"]*"' package.json | sed 's/"name"[[:space:]]*:[[:space:]]*"\(.*\)"/\1/')
  PROJECT_DESC=$(grep -o '"description"[[:space:]]*:[[:space:]]*"[^"]*"' package.json | sed 's/"description"[[:space:]]*:[[:space:]]*"\(.*\)"/\1/')
else
  PROJECT_NAME=""
  PROJECT_DESC=""
fi

if [ -z "$PROJECT_NAME" ]; then
  read -p "Enter project name: " PROJECT_NAME
fi

if [ -z "$PROJECT_DESC" ]; then
  read -p "Enter project description: " PROJECT_DESC
fi

echo ""
print_status "Project: $PROJECT_NAME"
print_status "Description: $PROJECT_DESC"

# Step 2: Ensure we're on main branch
print_header "Step 2: Preparing Main Branch"

if [ "$CURRENT_BRANCH" != "main" ]; then
  print_info "Switching to main branch..."
  git checkout main 2>/dev/null || git checkout -b main
fi

print_status "On main branch"

# Step 3: Create orphan branch (no history)
print_header "Step 3: Creating Fresh Repository"

print_info "Creating orphan branch (no commit history)..."
git checkout --orphan fresh-main

print_status "Orphan branch created"

# Step 4: Add all files and create initial commit
print_header "Step 4: Creating Initial Commit"

print_info "Staging all files..."
git add -A

print_info "Creating initial commit..."
git commit -m "chore: initial commit

Project: $PROJECT_NAME
Description: $PROJECT_DESC

This is a fresh start from the Node.js Library Template.
All template commit history has been removed for a clean slate.

🚀 Generated with Node.js Library Template
" --no-verify 2>/dev/null || git commit -m "chore: initial commit" --no-verify

print_status "Initial commit created"

# Step 5: Replace main branch
print_header "Step 5: Replacing Main Branch"

print_warning "Deleting old main branch..."
git branch -D main 2>/dev/null || true

print_info "Renaming fresh-main to main..."
git branch -m main

print_status "Main branch replaced with clean history"

# Step 6: Force push to remote
print_header "Step 6: Pushing to Remote"

print_warning "Force pushing to remote (this will overwrite remote main)..."
echo ""
read -p "Push to remote origin? (yes/no): " -r
echo

if [[ $REPLY =~ ^[Yy]es$ ]]; then
  git push -f origin main
  print_status "Pushed to remote main"
else
  print_warning "Skipped remote push - you'll need to do this manually:"
  echo "  git push -f origin main"
fi

# Step 7: Create clean develop and staging branches
print_header "Step 7: Creating Clean Branches"

print_info "Creating develop branch from main..."
git checkout -b develop
print_status "Develop branch created"

if [[ $REPLY =~ ^[Yy]es$ ]]; then
  git push -f origin develop
  print_status "Pushed to remote develop"
fi

print_info "Creating staging branch from main..."
git checkout -b staging
print_status "Staging branch created"

if [[ $REPLY =~ ^[Yy]es$ ]]; then
  git push -f origin staging
  print_status "Pushed to remote staging"
fi

git checkout main
print_status "Returned to main branch"

# Step 8: Branch protection setup
print_header "Step 8: Branch Protection (Optional)"

echo ""
print_info "Would you like to set up branch protection now?"
echo ""
echo "This requires:"
echo "  • GitHub personal access token with repo permissions"
echo "  • Repository owner and name"
echo ""
read -p "Set up branch protection? (yes/no): " -r
echo

if [[ $REPLY =~ ^[Yy]es$ ]]; then
  # Extract owner and repo from URL
  if [[ $REPO_URL =~ github.com[:/]([^/]+)/([^/.]+) ]]; then
    REPO_OWNER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"

    print_info "Detected: $REPO_OWNER/$REPO_NAME"

    read -p "GitHub Token (or set GITHUB_TOKEN env var): " GITHUB_TOKEN

    if [ -n "$GITHUB_TOKEN" ]; then
      export GITHUB_TOKEN
      bash "$(dirname "$0")/setup.sh" "$REPO_OWNER" "$REPO_NAME"
    else
      print_warning "No token provided, skipping branch protection"
      print_info "Run later with: bash scripts/setup.sh $REPO_OWNER $REPO_NAME"
    fi
  else
    print_warning "Could not parse GitHub owner/repo from URL"
    print_info "Run setup manually: bash scripts/setup.sh <owner> <repo>"
  fi
else
  print_info "Skipping branch protection"
  print_info "You can set it up later with:"
  echo "  bash scripts/setup.sh <owner> <repo> <token>"
fi

# Final summary
print_header "🎉 Fresh Start Complete!"

echo ""
print_status "Repository is now clean with:"
echo "  • Single initial commit (no template history)"
echo "  • main, develop, staging branches (all at same point)"
echo "  • Ready for your first feature branch"
echo ""

print_info "Your repository structure:"
git log --oneline --graph --all --decorate -n 5
echo ""

print_info "Next steps:"
echo "  1. Create a feature branch:"
echo "     git checkout develop"
echo "     git checkout -b feature/my-first-feature"
echo ""
echo "  2. Make changes and commit"
echo ""
echo "  3. Push and create PR to develop:"
echo "     git push -u origin feature/my-first-feature"
echo ""
echo "  4. Follow the workflow:"
echo "     feature → develop → staging → main"
echo ""

print_status "Done! Your repository is ready for clean development 🚀"
echo ""
