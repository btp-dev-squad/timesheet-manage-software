# Quick Fix Guide for Existing Template Repositories

## Problem

You created a repository from this template and now see:
- Thousands of unexpected file changes when comparing branches
- PRs showing 7,000+ additions that shouldn't be there
- Branches appear to be completely different

## Why This Happens

When you click "Use this template" on GitHub, **only the `main` branch is copied** to your new repository. The `develop` and `staging` branches are NOT automatically created.

If you manually created these branches later, they may have started from a different point or were empty, causing massive differences between branches.

## How to Fix Your Existing Repository

### Step 1: Navigate to Your Repository

```bash
cd /path/to/your/repository
# For example: cd ~/template-node-cap-js
```

### Step 2: Check Current Branch Status

```bash
git branch -a
```

You might see branches that are out of sync.

### Step 3: Reset to Clean State

**⚠️ Warning**: This will delete and recreate `develop` and `staging` branches. Make sure you don't have uncommitted work!

```bash
# Ensure you're on main and it's up to date
git checkout main
git pull origin main

# Delete local develop and staging branches if they exist
git branch -D develop staging 2>/dev/null || true

# Delete remote develop and staging branches
# ⚠️ ONLY do this if you want to start fresh!
git push origin --delete develop staging 2>/dev/null || true

# Fetch latest state
git fetch --all --prune
```

### Step 4: Recreate Branches Correctly

#### Option A: Use the Setup Script (Recommended)

```bash
# Download the setup script from the template repo
curl -o setup-branches.sh https://raw.githubusercontent.com/<template-org>/template-node-lib/main/scripts/setup-branches.sh

# Make it executable
chmod +x setup-branches.sh

# Run it
bash setup-branches.sh
```

#### Option B: Manual Recreation

```bash
# Create develop from main
git checkout main
git checkout -b develop
git push -u origin develop

# Create staging from main
git checkout main
git checkout -b staging
git push -u origin staging

# Return to main
git checkout main
```

### Step 5: Verify Everything is Clean

```bash
# All these should show NO differences
git diff main..develop
git diff develop..staging
git diff staging..main

# Check branches exist
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

### Step 6: Verify on GitHub

1. Go to your repository on GitHub
2. Check the branches dropdown - you should see `main`, `develop`, and `staging`
3. Try comparing `develop` and `staging` - should show "No differences"

## After Fixing

Now you can follow the normal workflow:

1. Create feature branch from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/my-feature
   ```

2. Make changes, commit, push:
   ```bash
   git add .
   git commit -m "feat: my new feature"
   git push origin feature/my-feature
   ```

3. Create PR on GitHub:
   - `feature/my-feature` → `develop`

## Preventing This in the Future

When creating NEW repositories from the template:

1. **Use the automatic initialization workflow**:
   - After creating from template, go to Actions tab
   - Look for "Initialize Template Repository" workflow
   - It should run automatically
   - If not, click "Run workflow" manually

2. **OR use the setup script immediately**:
   ```bash
   git clone <your-new-repo>
   cd <your-new-repo>
   bash scripts/setup-branches.sh
   ```

## Still Having Issues?

### Issue: "I don't want to delete my branches, I have work in them"

If you have work in the incorrectly created branches:

1. **Create backup branches**:
   ```bash
   git checkout develop
   git checkout -b develop-backup
   git push origin develop-backup

   git checkout staging
   git checkout -b staging-backup
   git push origin staging-backup
   ```

2. **Reset develop and staging**:
   ```bash
   git checkout main
   git branch -D develop staging
   git push origin --delete develop staging
   ```

3. **Recreate them correctly**:
   ```bash
   bash scripts/setup-branches.sh
   ```

4. **Cherry-pick your work**:
   ```bash
   git checkout develop
   git cherry-pick <commit-hash-from-develop-backup>
   # Repeat for each commit you want to keep
   ```

### Issue: "The script fails with permission denied"

```bash
chmod +x scripts/setup-branches.sh
bash scripts/setup-branches.sh
```

### Issue: "I get merge conflicts"

This means the branches diverged significantly. Start fresh:

```bash
git checkout main
git pull origin main
git branch -D develop staging
git push origin --delete develop staging
bash scripts/setup-branches.sh
```

## Quick Reference Commands

```bash
# Check branch status
git branch -a

# Check differences between branches
git diff develop..staging

# Reset to template state
git checkout main && git pull origin main
git branch -D develop staging
git push origin --delete develop staging
bash scripts/setup-branches.sh

# Verify all clean
git diff main..develop && git diff develop..staging && echo "✅ All branches in sync!"
```

## Need More Help?

See the full documentation:
- [Template Usage Guide](TEMPLATE_USAGE.md)
- [Release Workflow](.github/RELEASE_WORKFLOW.md)
