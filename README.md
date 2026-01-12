# ${{ values.component_id }}

${{ values.description }}

## Overview

This project was created using the Node.js Library Template with automated changelog, versioning, and release workflows.

## Getting Started

### Installation

```bash
npm install ${{ values.component_id }}
```

### Usage

```typescript
// Add usage examples here
```

## 📚 Documentation

- **[Template Usage Guide](TEMPLATE_USAGE.md)** - How to create and set up repositories from this template
- **[Release Workflow](.github/RELEASE_WORKFLOW.md)** - Automated changelog and release process
- **[Scripts](scripts/)** - Setup and utility scripts

## 🌿 Branch Structure

This repository uses a three-branch strategy:

1. **main** - Production branch
   - Protected, requires PR approval
   - Receives merges from `staging` only
   - Triggers automatic GitHub releases

2. **staging** - Pre-production/testing branch
   - Protected, requires PR approval
   - Receives merges from `develop`
   - Where changelog and versioning happens

3. **develop** - Development branch
   - Protected, requires PR approval
   - Receives merges from feature branches
   - Active development happens here

## 🔄 Development Workflow

```
feature/xyz → develop → staging → main
                         ↓
                   (changelog created here)
```

1. Create feature branch from `develop`
2. Merge feature to `develop` via PR
3. Merge `develop` to `staging` via PR
4. Run "Prepare Release" workflow (creates changelog)
5. Merge `staging` to `main` via PR (triggers release)

## 🛡️ Branch Protection

After creating a repository from this template, set up branch protection rules:

### Option 1: Automated Setup (If available)

```sh
./scripts/setup.sh <repo_org> <repo_name> <github_token>
```

### Option 2: Manual Setup

Go to **Settings** → **Branches** → **Add rule** for each branch:

**For `main`**:
- ✅ Require pull request reviews
- ✅ Require status checks
- ✅ Require branches to be up to date

**For `staging` and `develop`**:
- ✅ Require pull requests
- ✅ Require status checks

See [TEMPLATE_USAGE.md](TEMPLATE_USAGE.md#branch-protection-setup) for detailed instructions.

## 📦 Automated Release Process

This template includes automated changelog generation and releases:

- **Changelog**: Auto-generated from conventional commits
- **Versioning**: Semantic versioning based on commit types
- **Releases**: Auto-created on GitHub when merged to main

See [Release Workflow Documentation](.github/RELEASE_WORKFLOW.md) for details.

## 🔧 Setup Scripts

Make scripts executable:

```sh
chmod +x ./scripts/setup-branches.sh
chmod +x ./scripts/setup.sh
```

Initialize branches (for new repositories):

```sh
bash scripts/setup-branches.sh
```

## 📝 Commit Conventions

This template uses [Conventional Commits](https://www.conventionalcommits.org/):

```bash
feat: add new feature      # Minor version bump
fix: resolve bug           # Patch version bump
feat!: breaking change     # Major version bump
chore: maintenance task    # No version bump
docs: documentation        # No version bump
```

## ⚠️ Troubleshooting

### Branches showing thousands of changes in new repository?
→ See [TEMPLATE_USAGE.md - Fixing Already-Created Repositories](TEMPLATE_USAGE.md#fixing-already-created-repositories)

### Need to pull changelog commit after every release?
→ This is now fixed! See [Release Workflow Documentation](.github/RELEASE_WORKFLOW.md)

### Workflow not running automatically?
→ Trigger manually from Actions tab or run `scripts/setup-branches.sh`

## 📖 Additional Resources

- [Template Usage Guide](TEMPLATE_USAGE.md)
- [Release Workflow](.github/RELEASE_WORKFLOW.md)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
