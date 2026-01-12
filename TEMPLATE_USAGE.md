# Template Usage Guide

This document explains how to create and set up a new repository from this template.

## Important: Understanding GitHub Templates

**GitHub templates only copy the default branch (main).** Other branches like `develop` and `staging` are NOT automatically copied to new repositories created from this template.

## Creating a New Repository from This Template

### Option 1: Automatic Setup (Recommended)

When you create a new repository from this template:

1. **Click "Use this template" button** on GitHub
2. Fill in your repository details and create it
3. **Wait for the automatic branch initialization workflow to run**
   - Go to Actions tab in your new repository
   - Look for "Initialize Template Repository" workflow
   - It should run automatically and create `develop` and `staging` branches
4. **If the workflow doesn't run automatically**, trigger it manually:
   - Go to Actions tab
   - Select "Initialize Template Repository"
   - Click "Run workflow"
   - Select main branch
   - Click "Run workflow" button

### Option 2: Manual Setup

If you prefer manual setup or the automatic workflow didn't run:

1. **Clone your new repository**:
   ```bash
   git clone <your-repo-url>
   cd <your-repo-name>
   ```

2. **Run the setup script**:
   ```bash
   bash scripts/setup-branches.sh
   ```

   This script will:
   - Create `develop` branch from `main`
   - Create `staging` branch from `main`
   - Push both branches to remote
   - Display next steps

3. **Verify branches were created**:
   ```bash
   git branch -a
   ```

   You should see:
   ```
   * main
     develop
     staging
     remotes/origin/main
     remotes/origin/develop
     remotes/origin/staging
   ```

## Fixing Already-Created Repositories

If you already created a repository from this template and have branch issues:

### Problem Symptoms:
- Branches exist but show thousands of unexpected changes
- PR comparisons show files that shouldn't be there
- Branches are out of sync

### Solution:

1. **Delete the problematic branches** (if they exist):
   ```bash
   # Switch to main first
   git checkout main

   # Delete local branches
   git branch -D develop staging

   # Delete remote branches (⚠️ Warning: This deletes remote branches)
   git push origin --delete develop staging
   ```

2. **Run the setup script to recreate them properly**:
   ```bash
   bash scripts/setup-branches.sh
   ```

   This ensures all branches start from the same point (main) and are in sync.

3. **Verify everything is clean**:
   ```bash
   # Check develop vs staging - should show no differences
   git diff develop..staging

   # Check staging vs main - should show no differences
   git diff staging..main
   ```

## Branch Protection Setup

After creating your repository, set up branch protection rules:

1. Go to **Settings** > **Branches** in your GitHub repository
2. Click **Add rule** for each branch

### For `main` branch:
- Branch name pattern: `main`
- ✅ Require a pull request before merging
- ✅ Require approvals (at least 1)
- ✅ Require status checks to pass before merging
- ✅ Require branches to be up to date before merging
- ✅ Do not allow bypassing the above settings

### For `staging` branch:
- Branch name pattern: `staging`
- ✅ Require a pull request before merging
- ✅ Require status checks to pass before merging
- ✅ Require branches to be up to date before merging

### For `develop` branch:
- Branch name pattern: `develop`
- ✅ Require a pull request before merging
- ✅ Require status checks to pass before merging

## Development Workflow

Once your repository is set up:

1. **Create feature branch**:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/my-feature
   ```

2. **Make changes and commit**:
   ```bash
   # Use conventional commits
   git commit -m "feat: add new feature"
   git commit -m "fix: resolve bug"
   ```

3. **Push and create PR to develop**:
   ```bash
   git push origin feature/my-feature
   # Create PR on GitHub: feature/my-feature -> develop
   ```

4. **After testing on develop, create PR to staging**:
   ```
   PR: develop -> staging
   ```

5. **Prepare release when ready**:
   - Go to Actions tab
   - Run "Prepare Release" workflow
   - This creates changelog and version bump on staging
   - Automatically creates PR from staging -> main

6. **Review and merge to production**:
   ```
   PR: staging -> main (auto-created by workflow)
   ```

7. **GitHub release is auto-created** when merged to main

## Troubleshooting

### Q: I see thousands of changes when comparing branches
**A**: Your branches were likely created incorrectly. Follow the "Fixing Already-Created Repositories" section above.

### Q: The "Prepare Release" workflow fails
**A**: Ensure you have commits on staging that aren't tagged yet. Check conventional commit format.

### Q: I need to pull the changelog commit every time
**A**: This is now fixed! The new workflow creates changelog on staging BEFORE merging to main, preventing this issue.

### Q: Branches are not showing in my new repository
**A**: Run the initialization workflow manually or use `scripts/setup-branches.sh`.

### Q: Can I change the branch names?
**A**: Yes, but you'll need to update all workflow files in `.github/workflows/` to reference your new branch names.

## Template Maintenance

### Updating the template repository itself:

When you need to make changes to the template repository (`template-node-lib`):

1. Create feature branch from develop
2. Make changes
3. Create PR: feature -> develop
4. Create PR: develop -> staging
5. Run "Prepare Release" workflow
6. Create PR: staging -> main

### Updating existing projects created from template:

Repositories created from templates are independent. To sync updates:

1. Add template as remote:
   ```bash
   git remote add template <template-repo-url>
   git fetch template
   ```

2. Merge specific changes:
   ```bash
   git checkout develop
   git merge template/develop --allow-unrelated-histories
   # Resolve conflicts if any
   git push origin develop
   ```

## Additional Resources

- [Release Workflow Documentation](.github/RELEASE_WORKFLOW.md)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

## Support

For issues with this template:
- Check existing GitHub Issues
- Create a new issue with detailed description
- Include screenshots if relevant
