# ESLint Configuration

This document explains the ESLint configuration used in this template.

## Configuration File

**Location**: `eslint.config.ts`

This template uses the modern **flat config format** (ESLint 9+).

```typescript
import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import prettier from 'eslint-config-prettier';
import prettierPlugin from 'eslint-plugin-prettier';

export default tseslint.config(
  {
    ignores: [
      '.history',
      '.husky',
      '.vscode',
      'coverage',
      'dist',
      'node_modules',
    ],
  },
  eslint.configs.recommended,
  ...tseslint.configs.recommended,
  prettier,
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    },
    plugins: {
      prettier: prettierPlugin,
    },
    rules: {
      'prettier/prettier': 'error',
      '@typescript-eslint/no-unused-vars': [
        'error',
        {
          argsIgnorePattern: '^_',
        },
      ],
    },
  }
);
```

## Configuration Breakdown

### Import Statements

```typescript
import eslint from '@eslint/js';
```
Core ESLint recommended configuration.

```typescript
import tseslint from 'typescript-eslint';
```
TypeScript-specific ESLint rules and parser.

```typescript
import prettier from 'eslint-config-prettier';
```
Disables ESLint rules that conflict with Prettier.

```typescript
import prettierPlugin from 'eslint-plugin-prettier';
```
Runs Prettier as an ESLint rule.

### Ignored Patterns

```typescript
{
  ignores: [
    '.history',    // Local history plugin
    '.husky',      // Git hooks
    '.vscode',     // Editor config
    'coverage',    // Test coverage
    'dist',        // Build output
    'node_modules' // Dependencies
  ]
}
```

These directories are excluded from linting.

### Recommended Configurations

```typescript
eslint.configs.recommended
```
ESLint's core recommended rules for JavaScript.

```typescript
...tseslint.configs.recommended
```
TypeScript ESLint recommended rules (spread to flatten array).

```typescript
prettier
```
Disables conflicting rules between ESLint and Prettier.

### Language Options

```typescript
languageOptions: {
  globals: {
    ...globals.browser,  // Browser globals (window, document, etc.)
    ...globals.node      // Node.js globals (process, __dirname, etc.)
  }
}
```

Defines available global variables.

### Plugins

```typescript
plugins: {
  prettier: prettierPlugin
}
```

Registers the Prettier plugin to run formatting as a linting rule.

### Custom Rules

#### `prettier/prettier: 'error'`

Treats Prettier formatting issues as ESLint errors.

**Effect**:
```typescript
// ❌ Error: Prettier formatting violation
const x=1;

// ✅ Correct: Properly formatted
const x = 1;
```

#### `@typescript-eslint/no-unused-vars`

Prevents unused variables, with exception for underscore-prefixed names.

**Configuration**:
```typescript
'@typescript-eslint/no-unused-vars': [
  'error',
  {
    argsIgnorePattern: '^_'
  }
]
```

**Example**:
```typescript
// ❌ Error: Unused variable
function process(data, metadata) {
  return data;  // metadata unused
}

// ✅ Correct: Underscore prefix indicates intentionally unused
function process(data, _metadata) {
  return data;
}
```

## Rule Severity Levels

ESLint supports three severity levels:

| Level | Value | Description |
|-------|-------|-------------|
| Off | `0` or `'off'` | Rule disabled |
| Warning | `1` or `'warn'` | Rule violation reported as warning |
| Error | `2` or `'error'` | Rule violation reported as error |

**Example**:
```typescript
rules: {
  'no-console': 'warn',           // Warns on console.log
  'no-debugger': 'error',         // Errors on debugger statements
  'no-var': 'off'                 // Allows var (not recommended)
}
```

## Common Rules

### TypeScript-Specific Rules

#### `@typescript-eslint/no-explicit-any`

Disallows the `any` type (enabled by recommended config).

```typescript
// ❌ Error
function process(data: any) {
  return data;
}

// ✅ Correct
function process(data: unknown) {
  return data;
}
```

#### `@typescript-eslint/explicit-function-return-type`

Requires explicit return types on functions.

```typescript
// Add to rules to enable:
'@typescript-eslint/explicit-function-return-type': 'error'

// ❌ Error
function add(a: number, b: number) {
  return a + b;
}

// ✅ Correct
function add(a: number, b: number): number {
  return a + b;
}
```

#### `@typescript-eslint/no-non-null-assertion`

Disallows non-null assertions (`!`).

```typescript
// ❌ Error (if enabled)
const value = obj!.property;

// ✅ Correct
const value = obj?.property;
```

### JavaScript Rules

#### `no-console`

Warns or errors on console statements.

```typescript
rules: {
  'no-console': 'warn'  // Add this rule
}

// ⚠️ Warning
console.log('debug');

// ✅ Correct (for production)
// Remove or use proper logging library
```

#### `no-debugger`

Disallows `debugger` statements (enabled by recommended).

```typescript
// ❌ Error
debugger;
```

#### `eqeqeq`

Requires `===` and `!==` instead of `==` and `!=`.

```typescript
rules: {
  'eqeqeq': 'error'  // Add this rule
}

// ❌ Error
if (x == null) { }

// ✅ Correct
if (x === null) { }
```

## Running ESLint

### Command Line

```bash
# Lint all files
npm run lint

# Lint specific file/directory
npx eslint src/

# Auto-fix issues
npm run lint:scripts

# Lint with specific config
npx eslint --config eslint.config.ts src/
```

### Package.json Scripts

```json
{
  "scripts": {
    "lint": "eslint .",
    "lint:scripts": "eslint . --fix"
  }
}
```

### Pre-commit Hook

ESLint runs automatically on staged files:

```json
// .lintstagedrc.json
{
  "**/*.{ts,js}": ["eslint --fix"]
}
```

## IDE Integration

### VS Code

1. **Install Extension**:
   - ESLint (dbaeumer.vscode-eslint)

2. **Configure** (`.vscode/settings.json`):
```json
{
  "eslint.enable": true,
  "eslint.format.enable": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```

3. **Restart ESLint Server**:
   - Cmd/Ctrl + Shift + P
   - "ESLint: Restart ESLint Server"

### WebStorm

1. **Enable ESLint**:
   - Settings → Languages & Frameworks → JavaScript → Code Quality Tools → ESLint
   - Check "Automatic ESLint configuration"

2. **Auto-fix on save**:
   - Settings → Tools → Actions on Save
   - Check "Run eslint --fix"

## Customization

### Adding Rules

```typescript
export default tseslint.config(
  // ... existing config
  {
    rules: {
      // Add new rules
      'no-console': 'warn',
      'no-alert': 'error',
      'prefer-const': 'error',

      // TypeScript rules
      '@typescript-eslint/explicit-function-return-type': 'warn',
      '@typescript-eslint/no-explicit-any': 'error'
    }
  }
);
```

### Disabling Rules

```typescript
rules: {
  '@typescript-eslint/no-explicit-any': 'off'  // Disable rule
}
```

### Per-File Overrides

```typescript
export default tseslint.config(
  // ... base config
  {
    files: ['**/*.test.ts', '**/*.spec.ts'],
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',  // Allow any in tests
      'no-console': 'off'                            // Allow console in tests
    }
  }
);
```

### Inline Disabling

```typescript
// Disable for entire file
/* eslint-disable @typescript-eslint/no-explicit-any */

// Disable for next line
// eslint-disable-next-line no-console
console.log('debug');

// Disable for block
/* eslint-disable no-console */
console.log('start');
console.log('end');
/* eslint-enable no-console */
```

## Troubleshooting

### ESLint Not Working

```bash
# 1. Check ESLint is installed
npm list eslint

# 2. Verify configuration
npx eslint --print-config src/index.ts

# 3. Check for syntax errors in config
npx eslint --debug src/
```

### Conflicts with Prettier

This template uses `eslint-config-prettier` to disable conflicting rules.

If you still see conflicts:

```bash
# Check for conflicts
npx eslint-config-prettier eslint.config.ts
```

### Performance Issues

```bash
# Use cache
npx eslint --cache src/

# Check what's being linted
npx eslint --debug src/ 2>&1 | grep "Processing"
```

### TypeScript Errors Not Showing

```bash
# Verify typescript-eslint is working
npx eslint src/ --parser @typescript-eslint/parser

# Check tsconfig is found
npx tsc --showConfig
```

## Migration from Legacy Config

If migrating from `.eslintrc.*`:

### Old Format (.eslintrc.js)

```javascript
module.exports = {
  extends: ['eslint:recommended'],
  rules: {
    'no-console': 'warn'
  }
};
```

### New Format (eslint.config.ts)

```typescript
import eslint from '@eslint/js';

export default [
  eslint.configs.recommended,
  {
    rules: {
      'no-console': 'warn'
    }
  }
];
```

## Best Practices

1. **Use recommended configs** - Start with solid defaults
2. **Minimize custom rules** - Only add when needed
3. **Enable auto-fix** - Fix issues automatically where safe
4. **Run in CI** - Catch issues before merge
5. **Keep ESLint updated** - Get latest rules and fixes
6. **Document exceptions** - Explain why rules are disabled
7. **Use inline comments sparingly** - Prefer fixing the issue

## Recommended Additional Rules

```typescript
rules: {
  // Code quality
  'no-console': 'warn',
  'no-alert': 'error',
  'no-debugger': 'error',
  'prefer-const': 'error',
  'no-var': 'error',

  // TypeScript
  '@typescript-eslint/explicit-function-return-type': 'warn',
  '@typescript-eslint/no-explicit-any': 'error',
  '@typescript-eslint/consistent-type-imports': 'error',

  // Imports
  'import/order': ['error', {
    'groups': ['builtin', 'external', 'internal'],
    'alphabetize': { 'order': 'asc' }
  }]
}
```

## Related Documentation

- [Code Quality](../features/code-quality.md)
- [TypeScript Configuration](typescript-config.md)
- [Prettier Configuration](prettier-config.md)
- [Git Hooks](../features/git-hooks.md)
