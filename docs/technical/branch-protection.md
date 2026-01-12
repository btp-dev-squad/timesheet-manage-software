# Branch Protection Setup

Scripts for automating branch protection rules via GitHub API.

## Setup Scripts

### Shell Script

**File**: `scripts/setup.sh`

```bash
./scripts/setup.sh <owner> <repo> <github-token>
```

### Node.js Script

**File**: `scripts/setup.js`

```bash
node scripts/setup.js <owner> <repo> <github-token>
```

## Protection Rules Applied

For branches: main, develop, staging

### Required Settings

- **Enforce for admins**: true
- **Required approving reviews**: 1
- **Dismiss stale reviews**: true
- **Required status checks**: Branch naming validation
- **Allow force pushes**: false
- **Allow deletions**: false

## Creating GitHub Token

1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Generate new token (classic)
3. Select scopes:
   - `repo` (Full control of repositories)
   - `admin:repo_hook` (Write repo hooks)
4. Copy token

## Usage Example

```bash
./scripts/setup.sh btp-dev-squad template-node-lib ghp_xxxxxxxxxxxx
```

## Manual Configuration

Alternatively, configure via GitHub UI:

1. Go to repository Settings
2. Navigate to Branches
3. Add branch protection rule
4. Configure requirements

## Related Documentation

- [Branch Strategy](../features/branch-strategy.md)
- [CI/CD Workflows](../features/cicd-workflows.md)
