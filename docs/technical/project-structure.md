# Project Structure

This document explains the organization and purpose of files and directories in the template.

## Directory Tree

```
template-node-lib/
├── .github/                    # GitHub configuration
│   ├── ISSUE_TEMPLATE/        # Issue templates
│   │   ├── bug_report.yml
│   │   ├── feature_request.yml
│   │   ├── hotfix.yml
│   │   ├── security.yml
│   │   ├── documentation.yml
│   │   └── config.yml
│   ├── workflows/             # GitHub Actions
│   │   ├── branchname-validation.yml
│   │   ├── code-review.yml
│   │   └── release.yml
│   ├── CODEOWNERS            # Code ownership
│   └── PULL_REQUEST_TEMPLATE.md
├── .husky/                    # Git hooks
│   ├── pre-commit            # Pre-commit validation
│   └── commit-msg            # Commit message validation
├── docs/                      # Documentation
│   ├── features/             # Feature documentation
│   ├── technical/            # Technical documentation
│   └── configuration/        # Configuration guides
├── scripts/                   # Automation scripts
│   ├── setup.sh              # Branch protection setup (shell)
│   └── setup.js              # Branch protection setup (Node.js)
├── src/                       # Source code
│   └── index.ts              # Main entry point
├── tests/                     # Test files
│   └── code-review/
│       └── test-code-review-agent.ts
├── .env.example              # Environment variables template
├── .eslintignore             # ESLint ignore patterns (via config)
├── .gitignore                # Git ignore patterns
├── .lintstagedrc.json        # Lint-staged configuration
├── .nvmrc                    # Node version specification
├── .prettierignore           # Prettier ignore patterns
├── .prettierrc               # Prettier configuration
├── .stylelintignore          # Stylelint ignore patterns
├── .stylelintrc              # Stylelint configuration
├── catalog-info.yaml         # Backstage catalog configuration
├── commitlint.config.js      # Commitlint rules
├── eslint.config.ts          # ESLint configuration
├── mkdocs.yaml               # MkDocs documentation config
├── package.json              # npm package configuration
├── README.md                 # Project overview
├── SECURITY.md               # Security policy
├── tsconfig.json             # TypeScript configuration
└── claude.md                 # Claude AI context file
```

## Directory Explanations

### `.github/`

Contains GitHub-specific configurations.

#### `.github/ISSUE_TEMPLATE/`

Issue templates guide users in reporting bugs, requesting features, etc.

- `bug_report.yml` - Bug report template
- `feature_request.yml` - Feature request template
- `hotfix.yml` - Critical issue template
- `security.yml` - Security vulnerability template
- `documentation.yml` - Documentation issue template
- `config.yml` - Issue template configuration

#### `.github/workflows/`

GitHub Actions workflow definitions for CI/CD automation.

- `branchname-validation.yml` - Validates branch naming conventions
- `code-review.yml` - Automated code review using GitHub Copilot
- `release.yml` - Automated release and changelog generation

#### `.github/CODEOWNERS`

Defines code ownership for automatic review assignment.

#### `.github/PULL_REQUEST_TEMPLATE.md`

Template for pull request descriptions.

### `.husky/`

Git hooks managed by Husky.

- `pre-commit` - Runs lint-staged before commits
- `commit-msg` - Validates commit message format

### `docs/`

Project documentation organized for MkDocs.

- `features/` - User-facing feature documentation
- `technical/` - Technical implementation details
- `configuration/` - Configuration guides

### `scripts/`

Automation scripts for repository setup.

- `setup.sh` - Shell script for branch protection setup
- `setup.js` - Node.js script for branch protection setup

### `src/`

Source code directory for your library.

- `index.ts` - Main entry point (customize for your library)

### `tests/`

Test files for your library.

- `code-review/` - Code review agent tests (template-specific)

## Configuration Files

### `.env.example`

Template for environment variables. Copy to `.env` and fill in values.

```bash
GITHUB_TOKEN=your_token_here
```

### `.gitignore`

Specifies files Git should ignore:

- Build artifacts (`dist/`, `build/`)
- Dependencies (`node_modules/`)
- Environment files (`.env`)
- IDE files (`.vscode/`, `.idea/`)
- Logs (`*.log`)

### `.lintstagedrc.json`

Configures which linters run on staged files:

```json
{
  "**/*.{ts,js,html,json}": ["prettier --write", "eslint --fix"],
  "**/*.{css,scss}": ["stylelint --fix"]
}
```

### `.nvmrc`

Specifies Node.js version (20).

### `.prettierignore`

Directories Prettier should ignore (mirrors `.gitignore`).

### `.prettierrc`

Prettier formatting rules:

- Print width: 80
- Tab width: 2
- Semicolons: true
- Single quotes: false

### `.stylelintignore`

Directories Stylelint should ignore.

### `.stylelintrc`

Stylelint rules for CSS/SCSS.

### `catalog-info.yaml`

Backstage catalog configuration for registering this template in your developer portal.

### `commitlint.config.js`

Commit message validation rules (Conventional Commits).

### `eslint.config.ts`

ESLint configuration using modern flat config format.

### `mkdocs.yaml`

MkDocs configuration for documentation site.

### `package.json`

npm package configuration:

- Project metadata
- Dependencies
- Scripts
- Husky setup

### `tsconfig.json`

TypeScript compiler configuration:

- Target: ES2022
- Module: ESNext
- Strict mode: enabled
- Path aliases: `@/` and `@@/`

### `README.md`

Project overview and quick start guide.

### `SECURITY.md`

Security policy and vulnerability reporting instructions.

### `claude.md`

Context file for Claude AI to understand the project.

## Key Files Explained

### Entry Point: `src/index.ts`

Starting point for your library. Export your public API here:

```typescript
// Example structure
export { MyFunction } from './myFunction';
export { MyClass } from './myClass';
export type { MyType } from './types';
```

### Package Configuration: `package.json`

```json
{
  "name": "template-node-lib",
  "version": "1.0.0",
  "description": "Aarini Starter template",
  "main": "dist/index.js",
  "scripts": {
    "prepare": "husky install",
    "lint": "eslint .",
    "format": "prettier --write . && stylelint **/*.{css,scss} --fix"
  }
}
```

**Key sections**:

- `name`: Package name (change for your library)
- `version`: Semantic version (auto-updated on release)
- `main`: Entry point for consumers
- `scripts`: Automation commands
- `prepare`: Auto-runs after `npm install`

## Path Aliases

TypeScript supports path aliases for cleaner imports:

```typescript
// Instead of:
import { MyClass } from '../../src/myClass';

// Use:
import { MyClass } from '@/myClass';

// Or for root:
import config from '@@/config';
```

**Configuration** (`tsconfig.json`):

```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"],
      "@@/*": ["./*"]
    }
  }
}
```

## Adding New Files

### Adding Source Files

```bash
# Create new source file
touch src/myFeature.ts

# Export from index
echo "export * from './myFeature';" >> src/index.ts
```

### Adding Tests

```bash
# Create test file
mkdir -p tests/unit
touch tests/unit/myFeature.test.ts
```

### Adding Scripts

```bash
# Create script
touch scripts/myScript.js

# Make executable
chmod +x scripts/myScript.js

# Add to package.json
npm set-script my-script "node scripts/myScript.js"
```

### Adding Documentation

```bash
# Create doc file
touch docs/my-feature.md

# Add to mkdocs.yaml
# Update nav section
```

## Build Output

When you add a build step:

```bash
# Add TypeScript build script
npm set-script build "tsc"

# Build output goes to:
dist/
├── index.js
├── index.d.ts
├── myFeature.js
└── myFeature.d.ts
```

The `dist/` directory is ignored by Git (`.gitignore`) but included in npm packages.

## Ignored Files

### By Git (`.gitignore`)

- `node_modules/`
- `dist/`, `build/`
- `.env`
- `*.log`
- `.vscode/`, `.idea/`
- Coverage reports

### By Linters

- `node_modules/`
- `dist/`, `build/`
- `.history/`
- `.husky/`
- Coverage reports

## File Naming Conventions

### TypeScript Files

```
camelCase.ts        # General files
PascalCase.ts       # Classes
index.ts            # Directory entry points
*.test.ts           # Test files
*.spec.ts           # Specification files
*.d.ts              # Type definitions
```

### Documentation Files

```
kebab-case.md       # Documentation files
README.md           # README files (caps)
CHANGELOG.md        # Special files (caps)
```

### Configuration Files

```
.configname         # Dotfiles
configname.config.js # Config files
```

## Customization

### Removing Unnecessary Files

If you don't need certain features:

```bash
# Remove Stylelint (if no CSS/SCSS)
rm .stylelintrc .stylelintignore
npm uninstall stylelint stylelint-*

# Remove test directory (initially)
rm -rf tests/

# Remove scripts (if not using)
rm -rf scripts/
```

### Adding New Directories

```bash
# Add new source directories
mkdir -p src/{api,utils,models,services}

# Add new doc directories
mkdir -p docs/{guides,api-reference}
```

## Best Practices

1. **Keep `src/` organized** - Use subdirectories for large projects
2. **Document public APIs** - Add JSDoc comments
3. **Test comprehensively** - Match directory structure in `tests/`
4. **Update `.gitignore`** - Add project-specific patterns
5. **Maintain CHANGELOG** - Auto-generated on release
6. **Clean up unused files** - Remove what you don't need

## Related Documentation

- [TypeScript Configuration](typescript-config.md)
- [Package Scripts](../configuration/package-scripts.md)
- [ESLint Configuration](eslint-config.md)
- [Getting Started](../getting-started.md)
