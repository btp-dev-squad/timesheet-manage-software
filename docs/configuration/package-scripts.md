# Package.json Scripts

This document explains all npm scripts available in this template.

## Available Scripts

### Development Scripts

#### `npm start`

**Command**: `ts-node src/index.ts`

**Purpose**: Run TypeScript code directly without compiling.

**Usage**:
```bash
npm start
```

**When to use**:
- Quick testing during development
- Running examples or demos
- Development mode

**Example**:
```typescript
// src/index.ts
console.log('Hello from template!');
```

```bash
$ npm start
Hello from template!
```

### Code Quality Scripts

#### `npm run lint`

**Command**: `eslint .`

**Purpose**: Check code for linting errors.

**Usage**:
```bash
npm run lint
```

**Output**:
```
src/index.ts
  3:7  error  'unused' is defined but never used  @typescript-eslint/no-unused-vars

✖ 1 problem (1 error, 0 warnings)
```

**When to use**:
- Before committing (though pre-commit hook does this)
- CI/CD pipeline
- Code review preparation

#### `npm run lint:scripts`

**Command**: `eslint . --fix`

**Purpose**: Auto-fix linting errors where possible.

**Usage**:
```bash
npm run lint:scripts
```

**What it fixes**:
- Formatting issues (via Prettier integration)
- Missing semicolons
- Incorrect quote style
- Trailing commas
- And more...

**What it doesn't fix**:
- Logic errors
- Unused variables (must manually remove)
- Type errors (use TypeScript)

#### `npm run lint:styles`

**Command**: `stylelint **/*.{css,scss}`

**Purpose**: Lint CSS and SCSS files.

**Usage**:
```bash
npm run lint:styles
```

**When to use**:
- If your library includes styles
- Can be removed if not using CSS/SCSS

#### `npm run format`

**Command**: `npm run format:scripts && npm run format:styles`

**Purpose**: Format all code and styles.

**Usage**:
```bash
npm run format
```

**What it does**:
1. Runs `format:scripts` (Prettier on JS/TS)
2. Runs `format:styles` (Stylelint on CSS/SCSS)

#### `npm run format:scripts`

**Command**: `prettier --write .`

**Purpose**: Format JavaScript/TypeScript files with Prettier.

**Usage**:
```bash
npm run format:scripts
```

**Files formatted**:
- `*.ts` (TypeScript)
- `*.js` (JavaScript)
- `*.json` (JSON)
- `*.md` (Markdown)
- `*.html` (HTML)

#### `npm run format:styles`

**Command**: `stylelint **/*.{css,scss} --fix`

**Purpose**: Format and fix CSS/SCSS files.

**Usage**:
```bash
npm run format:styles
```

### Testing Scripts

#### `npm test`

**Command**: `echo "Error: no test specified" && exit 1`

**Purpose**: Placeholder for test runner.

**Current state**: Not implemented in template.

**To implement**:

```bash
# Install test framework
npm install --save-dev jest @types/jest ts-jest

# Update script
npm set-script test "jest"

# Run tests
npm test
```

### Setup Scripts

#### `npm run prepare`

**Command**: `husky install`

**Purpose**: Install Husky git hooks.

**When it runs**:
- Automatically after `npm install`
- Can be run manually

**What it does**:
- Sets up `.husky/` directory
- Configures git hooks
- Enables pre-commit and commit-msg validation

**Usage**:
```bash
# Manual run (rarely needed)
npm run prepare
```

#### `npm run uninstall-husky`

**Command**: Multi-line script to completely remove Husky.

**Purpose**: Clean removal of Husky hooks.

**Usage**:
```bash
npm run uninstall-husky
```

**What it does**:
1. Uninstalls Husky package
2. Removes `.husky/` directory
3. Resets git hooks path
4. Cleans up git configuration

**When to use**:
- Removing template features
- Troubleshooting hook issues
- Team doesn't want git hooks

## Script Patterns

### Running Multiple Scripts

#### Sequential (One After Another)

```json
{
  "scripts": {
    "build": "npm run clean && npm run compile"
  }
}
```

**Usage**: `&&` runs the second command only if the first succeeds.

#### Parallel (At Same Time)

```json
{
  "scripts": {
    "dev": "npm run watch:ts & npm run watch:styles"
  }
}
```

**Usage**: `&` runs commands in parallel (Unix/Mac). For cross-platform, use `npm-run-all`.

#### With npm-run-all

```bash
npm install --save-dev npm-run-all
```

```json
{
  "scripts": {
    "format": "npm-run-all format:*",
    "format:scripts": "prettier --write .",
    "format:styles": "stylelint **/*.scss --fix"
  }
}
```

### Passing Arguments

```bash
# Pass additional flags
npm run lint -- --debug

# Pass to nested script
npm run format:scripts -- --no-config
```

## Custom Scripts Examples

### Build Scripts

```json
{
  "scripts": {
    "build": "tsc",
    "build:watch": "tsc --watch",
    "prebuild": "npm run clean",
    "postbuild": "npm run copy-files",
    "clean": "rm -rf dist",
    "copy-files": "cp -r src/assets dist/"
  }
}
```

### Development Scripts

```json
{
  "scripts": {
    "dev": "ts-node-dev --respawn src/index.ts",
    "debug": "node --inspect-brk -r ts-node/register src/index.ts"
  }
}
```

### Release Scripts

```json
{
  "scripts": {
    "release": "npm run build && npm publish",
    "version": "npm run build && git add -A dist",
    "postversion": "git push && git push --tags"
  }
}
```

### Testing Scripts

```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:unit": "jest --testPathPattern=unit",
    "test:integration": "jest --testPathPattern=integration"
  }
}
```

## Pre and Post Hooks

npm automatically runs `pre*` and `post*` scripts:

```json
{
  "scripts": {
    "build": "tsc",
    "prebuild": "npm run lint",    // Runs before build
    "postbuild": "npm run test"    // Runs after build
  }
}
```

**Running `npm run build` executes**:
1. `npm run prebuild` (lint)
2. `npm run build` (tsc)
3. `npm run postbuild` (test)

## Cross-Platform Scripts

### Problem: Platform Differences

```bash
# Unix/Mac
"clean": "rm -rf dist"

# Windows
"clean": "rmdir /s /q dist"
```

### Solution: Use Cross-Platform Tools

```bash
npm install --save-dev rimraf cross-env npm-run-all
```

```json
{
  "scripts": {
    "clean": "rimraf dist",
    "dev": "cross-env NODE_ENV=development ts-node src/index.ts",
    "format": "npm-run-all format:*"
  }
}
```

## Environment Variables

### Setting Variables

```json
{
  "scripts": {
    "dev": "NODE_ENV=development ts-node src/index.ts",
    "prod": "NODE_ENV=production node dist/index.js"
  }
}
```

### Cross-Platform with cross-env

```bash
npm install --save-dev cross-env
```

```json
{
  "scripts": {
    "dev": "cross-env NODE_ENV=development ts-node src/index.ts"
  }
}
```

## Script Best Practices

### 1. Keep Scripts Simple

```json
// ❌ Too complex
"build": "rm -rf dist && mkdir dist && tsc && cp package.json dist && echo 'Done'"

// ✅ Break into smaller scripts
"clean": "rimraf dist",
"compile": "tsc",
"copy": "cp package.json dist",
"build": "npm run clean && npm run compile && npm run copy"
```

### 2. Use Descriptive Names

```json
// ❌ Unclear
"go": "ts-node src/index.ts",
"fix": "eslint . --fix && prettier --write ."

// ✅ Clear
"start": "ts-node src/index.ts",
"lint:fix": "eslint . --fix && prettier --write ."
```

### 3. Leverage Pre/Post Hooks

```json
"build": "tsc",
"prebuild": "npm run lint",
"postbuild": "npm run test"
```

### 4. Document Complex Scripts

```json
{
  "scripts": {
    "// build": "Compiles TypeScript and copies assets",
    "build": "npm run compile && npm run copy-assets"
  }
}
```

## Troubleshooting

### Script Not Found

```bash
$ npm run missing-script
npm ERR! missing script: missing-script
```

**Solution**: Check spelling in `package.json`.

### Script Fails Silently

```bash
# Exit immediately on error
"build": "npm run lint && npm run compile"

# Continue on error
"build": "npm run lint; npm run compile"
```

### Permission Denied

```bash
$ npm run script
sh: permission denied: ./script.sh
```

**Solution**:
```bash
chmod +x script.sh
```

### Command Not Found

```bash
$ npm run lint
sh: eslint: command not found
```

**Solutions**:
1. Install package: `npm install --save-dev eslint`
2. Use `npx`: `"lint": "npx eslint ."`
3. Reference directly: `"lint": "node_modules/.bin/eslint ."`

## Useful Script Additions

### Type Checking

```json
{
  "scripts": {
    "type-check": "tsc --noEmit",
    "type-check:watch": "tsc --noEmit --watch"
  }
}
```

### Dependency Management

```json
{
  "scripts": {
    "deps:check": "npm outdated",
    "deps:update": "npm update",
    "deps:audit": "npm audit",
    "deps:audit:fix": "npm audit fix"
  }
}
```

### Git Operations

```json
{
  "scripts": {
    "commit": "git-cz",
    "push": "git push && git push --tags",
    "sync": "git pull --rebase && npm install"
  }
}
```

## Related Documentation

- [Getting Started](../getting-started.md)
- [Code Quality](../features/code-quality.md)
- [Git Hooks](../features/git-hooks.md)
- [Project Structure](../technical/project-structure.md)
