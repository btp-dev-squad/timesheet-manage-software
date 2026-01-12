# Claude Context: Node.js Library Template

This file provides context for Claude AI about this template repository.

## Project Overview

**Name**: Node.js Library Template
**Type**: Software Template / Starter Kit
**Purpose**: Production-ready template for creating Node.js libraries with comprehensive DevOps automation
**Organization**: btp-dev-squad (Aarini)
**Maintainer**: Arun Krishnamoorthy (arun.krishnamoorthy@aarini.com)

## What This Template Provides

This is a scaffolding template designed to help developers quickly bootstrap Node.js library projects with enterprise-grade tooling and best practices built-in. It is NOT a library itself, but a foundation for building libraries.

### Core Philosophy

1. **Automation First** - Minimize manual processes through intelligent automation
2. **Quality by Default** - Enforce best practices without requiring configuration
3. **Developer Experience** - Fast, frictionless workflows
4. **Security Conscious** - Built-in security best practices
5. **Production Ready** - Enterprise-grade tooling

## Key Features

### 1. Code Quality Automation

- **ESLint**: Modern flat config format with TypeScript support
- **Prettier**: Opinionated code formatting
- **Stylelint**: CSS/SCSS linting with Sass guidelines
- **TypeScript**: Strict mode enabled, ES2022 target
- **Lint-staged**: Only lints staged files for performance

### 2. Git Workflow Automation

- **Husky**: Git hooks management
- **Pre-commit hook**: Runs linters and formatters automatically
- **Commit-msg hook**: Validates conventional commit format
- **Commitlint**: Enforces conventional commits specification

### 3. GitHub Integration

- **Issue Templates**: Bug report, feature request, hotfix, security, documentation
- **PR Template**: Comprehensive checklist with deployment notes
- **Code Owners**: Automatic review assignment
- **GitHub Actions**: Three automated workflows

### 4. CI/CD Workflows

- **Branch Validation**: Enforces naming conventions (feature/, bugfix/, hotfix/, release/)
- **Code Review**: GitHub Copilot automated review for security, performance, error handling
- **Auto Release**: Semantic versioning with conventional changelog generation

### 5. Branch Strategy

Three-branch model:
- **main**: Production, triggers auto-release
- **staging**: Pre-production testing
- **develop**: Active development

Merge strategy:
- Feature → Develop: Squash and merge
- Develop → Staging: Merge commit
- Staging → Main: Merge commit

### 6. Documentation

- **MkDocs**: Documentation site configuration
- **Backstage Integration**: catalog-info.yaml for developer portal
- **Comprehensive Docs**: Features, technical details, configuration guides

## Project Structure

```
template-node-lib/
├── .github/
│   ├── ISSUE_TEMPLATE/          # 5 issue templates
│   ├── workflows/               # 3 GitHub Actions
│   ├── CODEOWNERS              # @aarinidevsquad
│   └── PULL_REQUEST_TEMPLATE.md
├── .husky/
│   ├── pre-commit              # lint-staged
│   └── commit-msg              # commitlint
├── docs/                        # MkDocs documentation
│   ├── features/               # User-facing features
│   ├── technical/              # Implementation details
│   └── configuration/          # Configuration guides
├── scripts/
│   ├── setup.sh                # Branch protection (shell)
│   └── setup.js                # Branch protection (Node.js)
├── src/
│   └── index.ts                # Entry point (template starting point)
├── tests/
│   └── code-review/
│       └── test-code-review-agent.ts
├── catalog-info.yaml           # Backstage catalog
├── mkdocs.yaml                 # Documentation config
├── package.json                # npm package
├── tsconfig.json               # TypeScript config
├── eslint.config.ts            # ESLint flat config
├── .prettierrc                 # Prettier config
├── .stylelintrc                # Stylelint config
├── commitlint.config.js        # Commitlint config
├── .lintstagedrc.json          # Lint-staged config
├── .nvmrc                      # Node.js 20
├── .env.example                # Environment template
├── README.md                   # Project readme
├── SECURITY.md                 # Security policy
└── claude.md                   # This file
```

## Configuration Files Explained

### ESLint (`eslint.config.ts`)

- Modern flat config format (ESLint 9+)
- TypeScript ESLint integration
- Prettier integration (no conflicts)
- Global ignores: build artifacts, IDE files
- Custom rules: unused vars with underscore exception

### Prettier (`.prettierrc`)

- Print width: 80
- Tab width: 2 spaces
- Double quotes (singleQuote: false)
- Trailing commas (ES5)
- Semicolons enabled
- Avoid arrow parens when possible

### Stylelint (`.stylelintrc`)

- Sass guidelines extended
- Alphabetical property ordering
- Max nesting depth: 2
- Max ID selectors: 1
- Prettier integration

### TypeScript (`tsconfig.json`)

- Target: ES2022
- Module: ESNext
- Strict mode: enabled
- Path aliases: `@/` (src), `@@/` (root)
- No emit (type checking only)

### Commitlint (`commitlint.config.js`)

- Extends: @commitlint/config-conventional
- Allowed types: build, chore, ci, docs, feat, fix, perf, refactor, revert, style, test
- Max subject length: 150
- No start-case, pascal-case, or upper-case subjects

## npm Scripts

- `npm start`: Run with ts-node
- `npm run lint`: Check for linting errors
- `npm run lint:scripts`: Auto-fix linting errors
- `npm run lint:styles`: Lint CSS/SCSS
- `npm run format`: Format all code
- `npm run format:scripts`: Format JS/TS with Prettier
- `npm run format:styles`: Format CSS/SCSS with Stylelint
- `npm test`: Placeholder (not implemented)
- `npm run prepare`: Install Husky hooks (auto-runs after install)
- `npm run uninstall-husky`: Complete Husky removal

## GitHub Actions Workflows

### 1. Branch Naming Validation (`.github/workflows/branchname-validation.yml`)

**Trigger**: Push (except main/develop/staging), PRs to main/develop/staging
**Purpose**: Enforces branch naming conventions
**Valid Patterns**: feature/*, release/*, hotfix/*, bugfix/*
**Action**: Fails build if branch name doesn't match patterns

### 2. Code Review (`.github/workflows/code-review.yml`)

**Trigger**: PR opened or synchronized
**Purpose**: Automated code review using GitHub Copilot
**Features**:
- Detects changed files (up to 10)
- Reviews for security vulnerabilities, performance issues, missing error handling
- Posts review as PR comment
- Requires permissions: contents:read, pull-requests:write, actions:read

### 3. Auto Release (`.github/workflows/release.yml`)

**Trigger**: Push to main (skips if commit contains "chore(release)")
**Purpose**: Automated semantic versioning and releases
**Process**:
1. Checkout with full history
2. Install dependencies (conventional-changelog, conventional-recommended-bump)
3. Check for new commits since last tag
4. Generate changelog (Angular preset)
5. Calculate version bump (major/minor/patch)
6. Update package.json version
7. Create git tag (vX.Y.Z)
8. Commit and push changes
9. Create GitHub release with auto-generated notes

## Issue Templates

All templates are YAML format in `.github/ISSUE_TEMPLATE/`:

1. **bug_report.yml**: Severity levels, environment, steps to reproduce
2. **feature_request.yml**: Priority, category, problem statement, acceptance criteria
3. **hotfix.yml**: Critical production issues, impact assessment, rollback plan
4. **security.yml**: Directs to private email reporting
5. **documentation.yml**: Documentation type and issue classification

## Branch Protection

Scripts (`scripts/setup.sh` and `scripts/setup.js`) configure:

- Required pull request reviews: 1
- Dismiss stale reviews: true
- Enforce for admins: true
- Required status checks: "Validate Branch Naming Convention"
- Allow force pushes: false
- Allow deletions: false

Applied to: main, develop, staging

## Conventional Commits

Format: `<type>(<scope>): <subject>`

**Version Bumps**:
- `feat:` → Minor version (0.1.0)
- `fix:`, `perf:` → Patch version (0.0.1)
- `feat!:` or `BREAKING CHANGE:` → Major version (1.0.0)
- Others (docs, style, refactor, test, chore, build, ci) → No bump

## Security

- **Security Policy**: SECURITY.md with private reporting instructions
- **Contact**: arun.krishnamoorthy@aarini.com
- **Response Time**: 48 hours
- **Supported Versions**: 1.x.x only

## Backstage Integration

The `catalog-info.yaml` defines:
- Two entities: Template and Component
- Template for scaffolding new projects
- Component for catalog registration
- TechDocs reference: dir:.
- Owner: group:aarinidevsquad
- System: developer-platform

## Documentation Structure

MkDocs-powered documentation in `docs/`:

**Features** (User-focused):
- overview.md - All features at a glance
- code-quality.md - Linting and formatting
- git-hooks.md - Pre-commit automation
- commit-management.md - Conventional commits
- github-templates.md - Issue and PR templates
- cicd-workflows.md - GitHub Actions
- branch-strategy.md - Git workflow
- security.md - Security best practices

**Technical** (Implementation details):
- project-structure.md - File organization
- typescript-config.md - TypeScript setup
- eslint-config.md - ESLint configuration
- prettier-config.md - Prettier configuration
- stylelint-config.md - Stylelint configuration
- husky-setup.md - Git hooks setup
- commitlint-config.md - Commit validation
- github-actions.md - Workflow details
- branch-protection.md - Protection scripts

**Configuration** (How-to guides):
- package-scripts.md - npm scripts explained
- environment.md - Environment variables
- node-version.md - Node.js version management

## Dependencies

### Production Dependencies

None (this is a template, not a library)

### Development Dependencies (19 packages)

**Linting & Formatting**:
- eslint (9.36.0) + typescript-eslint (8.44.0)
- prettier (3.6.2)
- stylelint (16.24.0) + plugins

**Git Hooks**:
- husky (9.1.7)
- lint-staged (16.1.6)

**Commit Management**:
- @commitlint/cli + config-conventional (19.8.1)
- conventional-changelog-cli (5.0.0)

**TypeScript**:
- typescript (5.9.2)
- ts-node (10.9.2)
- @types/node (24.5.2)

## Environment Variables

Only one variable needed (for automation):

- `GITHUB_TOKEN`: GitHub API token for workflows (scopes: repo, workflow)

## Node.js Version

- Version: 20 (specified in `.nvmrc`)
- Reason: LTS release, ES2022 support, stable
- Support: Until April 2026

## Common Use Cases

### For Developers

1. **Creating a new library**: Use this template as starting point
2. **Understanding best practices**: Read documentation
3. **Learning DevOps automation**: Study workflows and hooks

### For Teams

1. **Standardizing projects**: Enforce this template for all Node.js libraries
2. **Onboarding**: New developers get pre-configured environment
3. **Compliance**: Built-in security and quality checks

### For Organizations

1. **Backstage integration**: Register template in developer portal
2. **Self-service**: Developers scaffold projects without DevOps help
3. **Governance**: Consistent tooling and practices across all projects

## Important Notes for Claude

1. **This is a template, not a library**: Don't treat src/index.ts as functional code
2. **Configuration over code**: Most value is in config files, not source code
3. **Automation is key**: Git hooks, workflows, and linters run automatically
4. **Three-branch workflow**: Understand the flow: feature → develop → staging → main
5. **Conventional commits**: All commit messages must follow this format
6. **Documentation is comprehensive**: Point users to docs/ for detailed information
7. **Security-conscious**: Never commit .env, always use private reporting for vulnerabilities
8. **Backstage-ready**: Can be registered in Backstage developer portal

## When Users Ask About...

### "How do I use this template?"

Point to README.md Quick Start and docs/getting-started.md

### "Why is my commit being rejected?"

Explain conventional commit format and commitlint rules

### "How do releases work?"

Explain the auto-release workflow triggered on main branch merges

### "What's the branch strategy?"

Explain three-branch model: develop → staging → main

### "How do I configure X?"

Direct to relevant config file and corresponding docs/technical/ documentation

### "Can I remove feature Y?"

Yes, this is a template - explain how to remove unwanted features safely

## File Modification Guidelines

### Safe to Modify

- src/* (source code - this is your library)
- tests/* (test files)
- docs/index.md (customize for your project)
- package.json (name, version, description, author)
- README.md (if needed, though comprehensive)

### Modify with Caution

- Configuration files (understand implications first)
- GitHub workflows (changes affect CI/CD)
- Git hooks (changes affect workflow)

### Don't Modify Unless Necessary

- .github/ISSUE_TEMPLATE/* (standardized templates)
- scripts/* (branch protection setup)
- docs/features/* (template feature documentation)
- docs/technical/* (implementation documentation)

## Success Metrics

This template is successful if:

1. Developers can scaffold a new project in < 5 minutes
2. Code quality is enforced automatically without thinking
3. Releases happen automatically without manual intervention
4. Team follows consistent practices across all projects
5. Onboarding new developers is fast due to standardization

## Version Information

- Template Version: 1.0.0
- Node.js: 20
- TypeScript: 5.9.2
- ESLint: 9.36.0
- Husky: 9.1.7

## Contact & Support

- **Maintainer**: Arun Krishnamoorthy
- **Email**: arun.krishnamoorthy@aarini.com
- **Organization**: Aarini Dev Squad
- **GitHub**: btp-dev-squad/template-node-lib
- **Security**: Private email reporting only

---

**Last Updated**: 2026-01-09
**Claude Context Version**: 1.0
