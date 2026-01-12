# Release Workflow Documentation

This document explains how the automated release and changelog workflow works in this repository.

## Overview

The repository uses a three-branch strategy:
- **develop**: Development branch where feature branches are merged
- **staging**: Testing and code review branch
- **main**: Production branch

## Automated Changelog System

The repository includes two GitHub Actions workflows to automate changelog generation and releases:

### 1. Prepare Release Workflow (`prepare-release.yml`)

**Trigger**: Manual (workflow_dispatch)

**Purpose**: Generates the changelog and prepares a release from the staging branch

**What it does**:
1. Analyzes commits since the last release tag
2. Generates a CHANGELOG.md file using conventional commits
3. Bumps the version in package.json based on commit types (major/minor/patch)
4. Commits the changes to the staging branch with message `chore(release): prepare X.Y.Z`
5. Creates a version tag (e.g., `v1.2.3`)
6. Syncs the changelog back to the develop branch (prevents branch divergence)
7. Creates a pull request from staging to main

**How to use it**:
1. Go to Actions tab in GitHub
2. Select "Prepare Release" workflow
3. Click "Run workflow"
4. Wait for it to complete
5. Review the auto-created PR from staging to main
6. Merge the PR when ready

### 2. Auto Release Workflow (`release.yml`)

**Trigger**: Automatic on push to main branch

**Purpose**: Creates a GitHub release after staging is merged to main

**What it does**:
1. Checks if a version tag exists for the current version in package.json
2. Creates a GitHub release using the existing tag
3. Uses CHANGELOG.md as the release notes

**Note**: This workflow does NOT commit any files to main, preventing sync issues

## Workflow Process

### Step-by-Step Release Process:

1. **Develop features on feature branches**
   ```bash
   git checkout develop
   git pull
   git checkout -b feature/my-new-feature
   # Make changes
   git commit -m "feat: add new feature"
   git push origin feature/my-new-feature
   ```

2. **Create PR from feature branch to develop**
   - Merge via PR when ready

3. **Create PR from develop to staging**
   - Merge via PR when ready for testing

4. **Prepare release (Manual step)**
   - Go to GitHub Actions
   - Run "Prepare Release" workflow
   - This creates the changelog and version bump on staging
   - Automatically syncs to develop
   - Automatically creates PR from staging to main

5. **Review and merge the auto-created PR from staging to main**
   - Review the changelog and version
   - Merge the PR when ready to release

6. **GitHub release is automatically created**
   - The "Auto Release" workflow triggers on merge to main
   - Creates a GitHub release with the version tag

## Conventional Commits

The changelog generation uses conventional commits format. Use these prefixes:

- `feat:` - New feature (triggers MINOR version bump)
- `fix:` - Bug fix (triggers PATCH version bump)
- `BREAKING CHANGE:` - Breaking change (triggers MAJOR version bump)
- `chore:` - Maintenance tasks
- `docs:` - Documentation changes
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Test changes

Example:
```bash
git commit -m "feat: add user authentication"
git commit -m "fix: resolve login timeout issue"
git commit -m "feat!: redesign API (BREAKING CHANGE)"
```

## Benefits of This Approach

1. **No sync issues**: The changelog is created on staging BEFORE merging to main, and synced back to develop
2. **No manual pulling**: You won't need to pull branches to get the changelog commit
3. **Automatic versioning**: Version is determined automatically based on commit types
4. **Clear release process**: Manual trigger gives you control over when to prepare a release
5. **No commits on main after merge**: The main branch doesn't get new commits from automation

## Troubleshooting

### "No new commits since last release"
- This means there are no new commits to release since the last version tag
- Check if you've made any commits since the last release

### PR creation fails
- Ensure you have permissions to create PRs
- Check if a PR from staging to main already exists

### Sync to develop fails
- Manually merge staging back to develop if there are conflicts
- Run: `git checkout develop && git merge staging && git push`

### Version tag already exists
- This usually means a release was already prepared for this set of changes
- Check existing tags: `git tag -l`
- If you need to create a new version, make more commits first

## Manual Override

If you need to manually create a release without the workflow:

```bash
# On staging branch
git checkout staging
git pull

# Generate changelog manually
npm install -g conventional-changelog-cli
conventional-changelog -p angular -i CHANGELOG.md -s

# Bump version
npm version patch  # or minor, or major

# Commit and tag
git add CHANGELOG.md package.json
git commit -m "chore(release): X.Y.Z"
git tag "vX.Y.Z"

# Push
git push origin staging --tags

# Sync to develop
git checkout develop
git merge staging
git push origin develop

# Create PR to main manually
```
