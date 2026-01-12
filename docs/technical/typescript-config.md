# TypeScript Configuration

This document explains the TypeScript configuration used in this template.

## Configuration File

**Location**: `tsconfig.json`

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": ".",
    "strict": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "allowSyntheticDefaultImports": true,
    "allowImportingTsExtensions": true,
    "noEmit": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@@/*": ["./*"]
    }
  },
  "include": ["src", "*.ts"],
  "exclude": ["node_modules", "dist"]
}
```

## Compiler Options Explained

### `target: "ES2022"`

**What it does**: Specifies the ECMAScript target version for compiled JavaScript.

**Why ES2022**:
- Modern JavaScript features (top-level await, class fields, etc.)
- Better performance and cleaner output
- Node.js 20 (specified in `.nvmrc`) supports ES2022

**Alternatives**:
- `ES2020` - For older Node versions
- `ES2023` - For cutting-edge features
- `ESNext` - Latest features (less stable)

### `module: "ESNext"`

**What it does**: Determines the module system for output.

**Why ESNext**:
- Native ES modules (`import`/`export`)
- Better tree-shaking in bundlers
- Modern standard

**Alternatives**:
- `CommonJS` - For Node.js <14 (`require`/`module.exports`)
- `AMD` - For browser module loaders
- `UMD` - Universal module definition

### `moduleResolution: "node"`

**What it does**: Determines how TypeScript resolves module imports.

**Why node**:
- Matches Node.js module resolution algorithm
- Resolves packages from `node_modules/`
- Handles package.json `main` and `exports` fields

**Alternatives**:
- `classic` - Legacy, not recommended
- `node16`/`nodenext` - Modern Node.js resolution (ESM support)

### `outDir: "./dist"`

**What it does**: Specifies where compiled JavaScript files are placed.

**Usage**:
```bash
# Compile TypeScript
npx tsc

# Output structure:
dist/
├── index.js
└── myFile.js
```

### `rootDir: "."`

**What it does**: Specifies the root directory of source files.

**Why "."**:
- Includes both `src/` and root-level `.ts` files
- Allows config files in TypeScript (e.g., `eslint.config.ts`)

**Alternative**:
```json
"rootDir": "./src"  // Only compile src/ directory
```

### `strict: true`

**What it does**: Enables all strict type-checking options.

**Includes**:
- `strictNullChecks` - `null` and `undefined` must be explicit
- `strictFunctionTypes` - Function types checked contravariantly
- `strictBindCallApply` - Stricter `bind`, `call`, `apply`
- `strictPropertyInitialization` - Class properties must be initialized
- `noImplicitAny` - No implicit `any` types
- `noImplicitThis` - No implicit `this` types
- `alwaysStrict` - Parse in strict mode, emit `"use strict"`

**Benefits**:
- Catches more bugs at compile time
- Better IDE autocomplete
- Safer refactoring
- More maintainable code

**Example**:
```typescript
// ❌ Error with strict: true
function greet(name) {  // Error: Parameter 'name' implicitly has an 'any' type
  return `Hello, ${name}`;
}

// ✅ Correct
function greet(name: string): string {
  return `Hello, ${name}`;
}
```

### `esModuleInterop: true`

**What it does**: Enables interoperability between CommonJS and ES modules.

**Benefits**:
- Import CommonJS modules using ES6 syntax
- Cleaner import statements

**Example**:
```typescript
// Without esModuleInterop
import * as express from 'express';

// With esModuleInterop
import express from 'express';
```

### `forceConsistentCasingInFileNames: true`

**What it does**: Ensures import paths match actual file name casing.

**Why important**:
- Prevents issues on case-sensitive file systems (Linux, macOS)
- Windows is case-insensitive, but production might not be

**Example**:
```typescript
// File: MyClass.ts

// ❌ Error
import { MyClass } from './myclass';  // Wrong casing

// ✅ Correct
import { MyClass } from './MyClass';  // Matches file name
```

### `resolveJsonModule: true`

**What it does**: Allows importing JSON files as modules.

**Usage**:
```typescript
import packageJson from './package.json';

console.log(packageJson.version);
```

### `allowSyntheticDefaultImports: true`

**What it does**: Allows default imports from modules without default exports.

**Benefits**:
- More flexible imports
- Better compatibility with CommonJS

**Example**:
```typescript
// Module without default export
export const config = { ... };

// Can still use default import
import config from './config';
```

### `allowImportingTsExtensions: true`

**What it does**: Allows importing TypeScript files with `.ts` extension.

**Usage**:
```typescript
import { MyClass } from './MyClass.ts';  // Allowed
```

### `noEmit: true`

**What it does**: TypeScript won't generate output files.

**Why**:
- This template is configured for type checking only
- Use a bundler (webpack, esbuild, etc.) for production builds
- Faster type checking

**For building**:
```bash
# Type check only
npx tsc --noEmit

# Build output (remove noEmit in tsconfig.build.json)
npx tsc --project tsconfig.build.json
```

### `baseUrl: "."`

**What it does**: Base directory for resolving non-relative module names.

**Why**:
- Enables path aliases
- Cleaner imports

### `paths`

**What it does**: Maps module names to locations.

**Configuration**:
```json
{
  "paths": {
    "@/*": ["./src/*"],
    "@@/*": ["./*"]
  }
}
```

**Usage**:
```typescript
// Instead of:
import { MyClass } from '../../../src/utils/MyClass';

// Use:
import { MyClass } from '@/utils/MyClass';

// Root import:
import config from '@@/config';
```

## Include and Exclude

### `include: ["src", "*.ts"]`

**What it does**: Specifies which files to include in compilation.

**Includes**:
- All files in `src/` directory
- Root-level `.ts` files (e.g., `eslint.config.ts`)

### `exclude: ["node_modules", "dist"]`

**What it does**: Specifies which files to exclude from compilation.

**Excluded by default** (even without listing):
- `node_modules/`
- `outDir` contents

## Advanced Configurations

### Separate Build Config

Create `tsconfig.build.json` for production builds:

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "noEmit": false,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist", "**/*.test.ts", "**/*.spec.ts"]
}
```

**Usage**:
```bash
npx tsc --project tsconfig.build.json
```

### Declaration Files

To generate `.d.ts` files:

```json
{
  "compilerOptions": {
    "declaration": true,
    "declarationMap": true
  }
}
```

**Output**:
```
dist/
├── index.js
├── index.d.ts        # Type declarations
└── index.d.ts.map    # Source map for types
```

### Source Maps

For debugging:

```json
{
  "compilerOptions": {
    "sourceMap": true,
    "inlineSourceMap": false
  }
}
```

## Path Mapping Limitations

**Important**: Path mappings only work for TypeScript. For runtime (Node.js), you need additional tools:

### Option 1: tsconfig-paths

```bash
npm install --save-dev tsconfig-paths
```

```typescript
// src/index.ts
import 'tsconfig-paths/register';
import { MyClass } from '@/utils/MyClass';
```

### Option 2: Module Alias

```bash
npm install --save-dev module-alias
```

```json
// package.json
{
  "_moduleAliases": {
    "@": "./dist/src",
    "@@": "./dist"
  }
}
```

```typescript
import 'module-alias/register';
```

### Option 3: Build Tool

Use a bundler (esbuild, webpack) that handles path mapping.

## Type Checking

### Command Line

```bash
# Check all files
npx tsc

# Check specific file
npx tsc src/myFile.ts

# Watch mode
npx tsc --watch

# Show config
npx tsc --showConfig
```

### IDE Integration

#### VS Code

Install the TypeScript extension (usually included):

```json
// .vscode/settings.json
{
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsdk": true
}
```

#### WebStorm

TypeScript support is built-in. Configure in:
- Settings → Languages & Frameworks → TypeScript

## Common Issues

### Module Not Found

```typescript
// Error: Cannot find module '@/utils/MyClass'
```

**Solutions**:
1. Check `baseUrl` and `paths` in `tsconfig.json`
2. Restart TypeScript server (VS Code: Cmd+Shift+P → "TypeScript: Restart TS Server")
3. For runtime: use tsconfig-paths or module-alias

### Type Errors in Dependencies

```typescript
// Error: Could not find declaration file for module 'some-package'
```

**Solutions**:
```bash
# Install types
npm install --save-dev @types/some-package

# Or allow missing types
// tsconfig.json
{
  "compilerOptions": {
    "skipLibCheck": true  // Skip type checking in node_modules
  }
}
```

### Strict Mode Errors

```typescript
// Error: Object is possibly 'null'
const value = obj.property;  // obj might be null
```

**Solutions**:
```typescript
// Option 1: Null check
if (obj !== null) {
  const value = obj.property;
}

// Option 2: Non-null assertion (use sparingly)
const value = obj!.property;

// Option 3: Optional chaining
const value = obj?.property;
```

## Best Practices

1. **Keep strict mode enabled** - Catches bugs early
2. **Use path aliases** - Cleaner imports
3. **Generate declaration files** - For library consumers
4. **Enable source maps** - For easier debugging
5. **Separate build config** - Different needs for dev vs prod
6. **Use latest TypeScript** - Get new features and fixes
7. **Configure IDE** - Better development experience

## Customization Examples

### For a Library

```json
{
  "compilerOptions": {
    "declaration": true,
    "declarationMap": true,
    "noEmit": false,
    "outDir": "./dist"
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
```

### For an Application

```json
{
  "compilerOptions": {
    "declaration": false,
    "noEmit": true,
    "outDir": "./build"
  },
  "include": ["src", "types"],
  "exclude": ["node_modules"]
}
```

## Related Documentation

- [Project Structure](project-structure.md)
- [ESLint Configuration](eslint-config.md)
- [Package Scripts](../configuration/package-scripts.md)
