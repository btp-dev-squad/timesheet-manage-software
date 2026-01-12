# Code Quality & Linting

Automated code quality enforcement ensures your codebase remains consistent, maintainable, and free of common errors.

## Overview

This template includes three complementary linting tools:

1. **ESLint** - JavaScript and TypeScript code quality
2. **Prettier** - Opinionated code formatting
3. **Stylelint** - CSS and SCSS linting

All three work together seamlessly and run automatically on every commit.

## ESLint

### What It Does

ESLint analyzes your JavaScript and TypeScript code for:

- Potential bugs and errors
- Code style violations
- Best practice violations
- TypeScript-specific issues

### Configuration

**File**: `eslint.config.ts`

```typescript
import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import prettier from 'eslint-config-prettier';
import prettierPlugin from 'eslint-plugin-prettier';

export default tseslint.config(
  eslint.configs.recommended,
  ...tseslint.configs.recommended,
  prettier,
  {
    plugins: {
      prettier: prettierPlugin
    },
    rules: {
      'prettier/prettier': 'error',
      '@typescript-eslint/no-unused-vars': [
        'error',
        { argsIgnorePattern: '^_' }
      ]
    }
  }
);
```

### Key Features

- Modern flat config format
- TypeScript-first configuration
- Prettier integration (no conflicts)
- Customizable rules
- IDE integration support

### Ignored Patterns

The following directories are automatically ignored:

- `.history/`
- `.husky/`
- `.vscode/`
- `coverage/`
- `dist/`
- `node_modules/`

### Usage

```bash
# Check for linting errors
npm run lint

# Auto-fix linting errors (where possible)
npm run lint:scripts
```

### Custom Rules

The template includes these custom rules:

- `prettier/prettier: error` - Enforces Prettier formatting
- `@typescript-eslint/no-unused-vars` - Allows underscore-prefixed unused variables

## Prettier

### What It Does

Prettier automatically formats your code for:

- Consistent indentation
- Proper line wrapping
- Quote style consistency
- Trailing comma placement
- Semicolon usage

### Configuration

**File**: `.prettierrc`

```json
{
  "printWidth": 80,
  "tabWidth": 2,
  "singleQuote": false,
  "trailingComma": "es5",
  "arrowParens": "avoid",
  "bracketSpacing": true,
  "useTabs": false,
  "endOfLine": "auto",
  "semi": true,
  "jsxSingleQuote": false,
  "quoteProps": "as-needed"
}
```

### Key Settings

| Setting | Value | Description |
|---------|-------|-------------|
| Print Width | 80 | Maximum line length |
| Tab Width | 2 | Spaces per indentation |
| Single Quote | false | Use double quotes |
| Trailing Comma | es5 | Add where valid in ES5 |
| Arrow Parens | avoid | Omit when possible |
| Semi | true | Add semicolons |
| End of Line | auto | Maintain existing |

### Ignored Files

**File**: `.prettierignore`

```
.history
.husky
.vscode
coverage
dist
node_modules
```

### Usage

```bash
# Format all files
npm run format

# Format only scripts
npm run format:scripts

# Format only styles
npm run format:styles
```

## Stylelint

### What It Does

Stylelint enforces CSS and SCSS best practices:

- Property ordering (alphabetical)
- Nesting depth limits
- Sass-specific guidelines
- Selector complexity limits

### Configuration

**File**: `.stylelintrc`

```json
{
  "plugins": [
    "stylelint-order",
    "stylelint-prettier"
  ],
  "extends": [
    "stylelint-config-recommended",
    "stylelint-config-sass-guidelines"
  ],
  "overrides": [
    {
      "files": ["**/*.scss"],
      "customSyntax": "postcss-scss"
    }
  ],
  "rules": {
    "prettier/prettier": true,
    "no-descending-specificity": null,
    "max-nesting-depth": 2,
    "selector-max-id": 1,
    "order/properties-alphabetical-order": true
  }
}
```

### Key Rules

- **Alphabetical properties**: Enforces consistent property order
- **Max nesting depth**: 2 (prevents overly complex selectors)
- **Max ID selectors**: 1 (encourages class-based styling)
- **Prettier integration**: Formatting delegated to Prettier

### Usage

```bash
# Lint CSS/SCSS files
npm run lint:styles

# Auto-fix style issues
npm run format:styles
```

## Lint-staged Integration

### What It Does

Lint-staged runs linters only on files you've staged for commit, making the process fast and efficient.

### Configuration

**File**: `.lintstagedrc.json`

```json
{
  "**/*.{ts,js,html,json}": [
    "prettier --write",
    "eslint --fix"
  ],
  "**/*.{css,scss}": [
    "stylelint --fix"
  ]
}
```

### How It Works

1. You stage files: `git add .`
2. You commit: `git commit -m "feat: add feature"`
3. Husky triggers lint-staged
4. Lint-staged runs linters on staged files only
5. If all pass, commit proceeds
6. If any fail, commit is blocked

## Automation

### Pre-commit Hook

All linting runs automatically via the Husky pre-commit hook:

**File**: `.husky/pre-commit`

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

### What Gets Checked

Every commit automatically checks:

- TypeScript/JavaScript syntax
- Code style consistency
- TypeScript type errors
- CSS/SCSS best practices
- File formatting

## IDE Integration

### VS Code

Install these extensions for the best experience:

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "stylelint.vscode-stylelint"
  ]
}
```

**Settings** (`.vscode/settings.json`):

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.fixAll.stylelint": true
  }
}
```

### WebStorm

WebStorm has built-in support for:
- ESLint (auto-detected from config)
- Prettier (enable in preferences)
- Stylelint (enable in preferences)

## Customization

### Disabling Rules

To disable a specific rule:

```typescript
// eslint.config.ts
export default tseslint.config({
  rules: {
    'rule-to-disable': 'off'
  }
});
```

### Adding Rules

To add or customize a rule:

```typescript
// eslint.config.ts
export default tseslint.config({
  rules: {
    'new-rule': 'error',
    'existing-rule': ['error', { option: true }]
  }
});
```

### Prettier Overrides

```json
{
  "singleQuote": true,
  "printWidth": 100
}
```

### Stylelint Overrides

```json
{
  "rules": {
    "max-nesting-depth": 3,
    "selector-max-id": 0
  }
}
```

## Troubleshooting

### ESLint Errors Not Showing

```bash
# Restart ESLint server (VS Code)
Cmd/Ctrl + Shift + P → "ESLint: Restart ESLint Server"

# Or reinstall
npm install eslint --save-dev
```

### Prettier Not Formatting

```bash
# Check Prettier is installed
npm list prettier

# Verify .prettierrc exists
cat .prettierrc
```

### Conflicting Rules

This template is pre-configured to avoid conflicts between ESLint and Prettier using `eslint-config-prettier`.

### Performance Issues

If linting is slow:

```bash
# Use lint-staged (already configured)
# It only checks changed files

# Or add more ignore patterns
echo "large-directory/" >> .eslintignore
```

## Best Practices

1. **Don't bypass linters** - They catch real issues
2. **Fix errors immediately** - Don't accumulate technical debt
3. **Customize minimally** - Default rules are well-tested
4. **Use IDE integration** - Fix issues as you type
5. **Keep dependencies updated** - Get latest rule improvements

## Related Documentation

- [Git Hooks](git-hooks.md) - How linting integrates with commits
- [TypeScript Configuration](../technical/typescript-config.md) - TypeScript setup details
- [ESLint Configuration](../technical/eslint-config.md) - Deep dive into ESLint
- [Prettier Configuration](../technical/prettier-config.md) - Prettier details
