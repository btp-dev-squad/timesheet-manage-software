# GitHub Actions Details

Technical implementation details of GitHub Actions workflows.

## Workflows

### 1. Branch Naming Validation

**File**: `.github/workflows/branchname-validation.yml`

**Trigger**: Push and PR events

**Valid Patterns**:
- `feature/*`
- `release/*`
- `hotfix/*`
- `bugfix/*`

**Protected Branches**: main, develop, staging (bypass validation)

### 2. Code Review Automation

**File**: `.github/workflows/code-review.yml`

**Trigger**: PR opened/synchronized

**Features**:
- GitHub Copilot integration
- Reviews up to 10 changed files
- Checks for security, performance, error handling
- Posts review as PR comment

**Permissions**:
- `contents: read`
- `pull-requests: write`
- `actions: read`

### 3. Automatic Release

**File**: `.github/workflows/release.yml`

**Trigger**: Push to main (skips if message contains "chore(release)")

**Process**:
1. Checkout with full history
2. Setup Node.js from `.nvmrc`
3. Install dependencies
4. Check for new commits since last tag
5. Generate conventional changelog
6. Calculate version bump (major/minor/patch)
7. Update package.json
8. Create git tag
9. Push changes
10. Create GitHub release

**Environment**:
- Uses `GITHUB_TOKEN` for authentication
- Node.js version from `.nvmrc` (20)

## Monitoring Workflows

```bash
# List recent runs
gh run list

# View specific workflow
gh run list --workflow=release.yml

# View run details
gh run view <run-id>

# View logs
gh run view <run-id> --log
```

## Customization

Edit workflow files in `.github/workflows/` to customize behavior.

## Related Documentation

- [CI/CD Workflows](../features/cicd-workflows.md)
- [Branch Strategy](../features/branch-strategy.md)
- [Commit Management](../features/commit-management.md)
