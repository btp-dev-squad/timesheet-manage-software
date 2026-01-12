# Husky Setup

Husky manages Git hooks in this template, enabling automated checks before commits.

## Installation

Husky installs automatically:

```bash
npm install  # Runs 'npm run prepare' → 'husky install'
```

## Hooks Configured

### Pre-commit

**File**: `.husky/pre-commit`

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

**Runs**: Lint-staged (lints and formats staged files)

### Commit-msg

**File**: `.husky/commit-msg`

```bash
#!/usr/bin/env sh
# Validate commit message format
npx --no -- commitlint --edit ${1}
```

**Runs**: Commitlint (validates commit message format)

## Uninstalling

```bash
npm run uninstall-husky
```

## Troubleshooting

### Hooks Not Running

```bash
# Reinstall Husky
npm run prepare

# Check permissions
chmod +x .husky/pre-commit
chmod +x .husky/commit-msg
```

### Verify Installation

```bash
# Check git config
git config core.hooksPath
# Should output: .husky
```

## Related Documentation

- [Git Hooks](../features/git-hooks.md)
- [Commit Management](../features/commit-management.md)
