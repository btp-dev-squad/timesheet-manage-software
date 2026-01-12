# Prettier Configuration

This document explains the Prettier configuration used in this template.

## Configuration File

**Location**: `.prettierrc`

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

## Options Explained

### `printWidth: 80`

**What it does**: Maximum line length before wrapping.

**Why 80**:
- Readable on most screens
- Fits in side-by-side editor panels
- GitHub code review friendly
- Historical standard

**Example**:
```typescript
// Wraps at 80 characters
const longFunctionName = (param1, param2, param3, param4) => {
  return something;
};
```

**Alternatives**:
- `100` - Wider, more code per line
- `120` - Very wide, common in modern codebases

### `tabWidth: 2`

**What it does**: Number of spaces per indentation level.

**Why 2**:
- Less horizontal space usage
- More code visible
- JavaScript/TypeScript community standard

**Example**:
```typescript
function example() {
  if (true) {
    return 'two spaces';
  }
}
```

**Alternatives**:
- `4` - More visual distinction, common in Python

### `singleQuote: false`

**What it does**: Use double quotes instead of single quotes.

**Why double**:
- JSON compatibility
- HTML attribute consistency
- Less escaping in prose

**Example**:
```typescript
const name = "John";           // Double quotes
const message = "It's working"; // No escaping needed
```

**Alternative**:
```json
"singleQuote": true

// Results in:
const name = 'John';
const message = 'It\'s working';  // Needs escaping
```

### `trailingComma: "es5"`

**What it does**: Add trailing commas where valid in ES5.

**Why es5**:
- Cleaner git diffs
- Easier to add/remove items
- Supported everywhere

**Example**:
```typescript
const array = [
  1,
  2,
  3,  // Trailing comma
];

const object = {
  name: "John",
  age: 30,  // Trailing comma
};

// But not in function parameters (not valid ES5)
function example(
  param1,
  param2  // No trailing comma
) {}
```

**Alternatives**:
- `"none"` - No trailing commas
- `"all"` - Even in function parameters (ES2017+)

### `arrowParens: "avoid"`

**What it does**: Omit parentheses when possible in arrow functions.

**Why avoid**:
- Cleaner syntax
- Less visual noise

**Example**:
```typescript
// Single parameter - no parens
const square = x => x * x;

// Multiple parameters - parens required
const add = (a, b) => a + b;

// No parameters - parens required
const random = () => Math.random();
```

**Alternative**:
```json
"arrowParens": "always"

// Always use parens:
const square = (x) => x * x;
```

### `bracketSpacing: true`

**What it does**: Add spaces inside object literal braces.

**Example**:
```typescript
// With bracketSpacing: true
const obj = { name: "John", age: 30 };

// With bracketSpacing: false
const obj = {name: "John", age: 30};
```

### `useTabs: false`

**What it does**: Use spaces instead of tabs for indentation.

**Why spaces**:
- Consistent appearance across editors
- JavaScript community standard

**Alternative**:
```json
"useTabs": true

// Uses tabs (\t) instead of spaces
```

### `endOfLine: "auto"`

**What it does**: Maintain existing line endings or use system default.

**Why auto**:
- Works across Windows (CRLF) and Unix (LF)
- Git handles conversion with `core.autocrlf`

**Example**:
- Unix/Mac: `\n` (LF)
- Windows: `\r\n` (CRLF)

**Alternatives**:
- `"lf"` - Force Unix line endings
- `"crlf"` - Force Windows line endings
- `"cr"` - Old Mac (rare)

### `semi: true`

**What it does**: Add semicolons at the end of statements.

**Why true**:
- Explicit statement termination
- Prevents ASI (Automatic Semicolon Insertion) bugs
- More compatible with tooling

**Example**:
```typescript
const x = 1;
const y = 2;
return x + y;
```

**Alternative**:
```json
"semi": false

// No semicolons:
const x = 1
const y = 2
return x + y
```

### `jsxSingleQuote: false`

**What it does**: Use double quotes in JSX attributes.

**Example**:
```jsx
<Component name="value" />      // double quotes
```

**Alternative**:
```json
"jsxSingleQuote": true

// Results in:
<Component name='value' />      // single quotes
```

### `quoteProps: "as-needed"`

**What it does**: Only quote object properties when necessary.

**Example**:
```typescript
const obj = {
  name: "John",           // No quotes needed
  "first-name": "John",   // Quotes needed (contains hyphen)
  123: "value",           // No quotes (number key)
};
```

**Alternatives**:
- `"consistent"` - If any property needs quotes, quote all
- `"preserve"` - Keep quotes as written

## Ignore File

**Location**: `.prettierignore`

```
.history
.husky
.vscode
coverage
dist
node_modules
```

Similar to `.gitignore`, prevents Prettier from formatting certain files/directories.

## Running Prettier

### Command Line

```bash
# Format all files
npm run format

# Format specific files
npx prettier --write src/

# Check formatting (no changes)
npx prettier --check src/

# Format specific file types
npx prettier --write "**/*.{ts,js,json}"
```

### Package.json Scripts

```json
{
  "scripts": {
    "format": "npm run format:scripts && npm run format:styles",
    "format:scripts": "prettier --write .",
    "format:styles": "stylelint **/*.{css,scss} --fix"
  }
}
```

### Pre-commit Hook

Prettier runs automatically on staged files:

```json
// .lintstagedrc.json
{
  "**/*.{ts,js,html,json}": ["prettier --write"]
}
```

## IDE Integration

### VS Code

1. **Install Extension**:
   - Prettier - Code formatter (esbenp.prettier-vscode)

2. **Configure** (`.vscode/settings.json`):
```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

3. **Format**:
   - Cmd/Ctrl + Shift + P → "Format Document"
   - Or set `formatOnSave: true`

### WebStorm

1. **Enable Prettier**:
   - Settings → Languages & Frameworks → JavaScript → Prettier
   - Check "On save"
   - Check "On code reformat"

2. **Format**:
   - Cmd/Ctrl + Alt + L (reformat code)

## Integration with ESLint

This template uses `eslint-config-prettier` to disable conflicting ESLint rules.

**ESLint Config** (`eslint.config.ts`):
```typescript
import prettier from 'eslint-config-prettier';
import prettierPlugin from 'eslint-plugin-prettier';

export default tseslint.config(
  prettier,  // Disables conflicting rules
  {
    plugins: {
      prettier: prettierPlugin
    },
    rules: {
      'prettier/prettier': 'error'  // Run Prettier as ESLint rule
    }
  }
);
```

**Benefits**:
- Single command (`npm run lint:scripts`) formats and lints
- Consistent tooling in pre-commit hooks
- IDE sees formatting issues as lint errors

## Customization

### Project-Specific Overrides

Edit `.prettierrc`:

```json
{
  "printWidth": 100,      // Wider lines
  "singleQuote": true,    // Single quotes
  "trailingComma": "all", // All trailing commas
  "tabWidth": 4,          // Four spaces
  "semi": false           // No semicolons
}
```

### File-Specific Overrides

Use `.prettierrc.js` for advanced config:

```javascript
module.exports = {
  printWidth: 80,
  overrides: [
    {
      files: "*.md",
      options: {
        printWidth: 100  // Wider for markdown
      }
    },
    {
      files: "*.json",
      options: {
        tabWidth: 4  // Four spaces for JSON
      }
    }
  ]
};
```

### Ignore Specific Code

```typescript
// prettier-ignore
const matrix = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
];

// prettier-ignore-start
const uglyCode = {x:1,y:2,z:3};
const moreUgly = function(){return 42;};
// prettier-ignore-end
```

## Troubleshooting

### Prettier Not Formatting

```bash
# Check Prettier is installed
npm list prettier

# Verify configuration
npx prettier --find-config-path src/index.ts

# Test formatting
npx prettier --write src/index.ts
```

### Conflicts with ESLint

```bash
# Check for conflicts
npx eslint-config-prettier eslint.config.ts

# Should output: "No rules that are unnecessary or conflict with Prettier were found."
```

### Format on Save Not Working

**VS Code**:
1. Check extension is installed
2. Verify `.prettierrc` exists
3. Check workspace settings
4. Reload window (Cmd/Ctrl + Shift + P → "Reload Window")

**WebStorm**:
1. Verify Prettier plugin is enabled
2. Check "On save" is selected
3. Restart IDE

### Formatting Differences Between CLI and IDE

```bash
# Check which config is being used
npx prettier --find-config-path .

# VS Code: Check output panel
# View → Output → Select "Prettier"
```

## Best Practices

1. **Use default configuration** - Start with this template's settings
2. **Team agreement** - Formatting is subjective; agree as a team
3. **Commit `.prettierrc`** - Ensure consistency across team
4. **Run in pre-commit** - Automatic formatting
5. **Format entire codebase initially** - One-time commit
6. **Don't bypass Prettier** - Avoid `// prettier-ignore` unless necessary
7. **Update regularly** - New Prettier versions may change formatting slightly

## Common Configurations

### Minimalist

```json
{
  "printWidth": 80,
  "tabWidth": 2,
  "semi": false,
  "singleQuote": true,
  "trailingComma": "none"
}
```

### Opinionated

```json
{
  "printWidth": 100,
  "tabWidth": 2,
  "semi": true,
  "singleQuote": false,
  "trailingComma": "all",
  "arrowParens": "always",
  "bracketSpacing": true
}
```

### Compact

```json
{
  "printWidth": 120,
  "tabWidth": 2,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "bracketSpacing": false
}
```

## Prettier vs ESLint

| Aspect | Prettier | ESLint |
|--------|----------|--------|
| **Purpose** | Code formatting | Code quality |
| **Fixes** | Whitespace, quotes, commas | Logic errors, best practices |
| **Opinionated** | Yes | Configurable |
| **Examples** | Indentation, line breaks | Unused variables, === vs == |

**Use both**: Prettier for formatting, ESLint for code quality.

## Related Documentation

- [Code Quality](../features/code-quality.md)
- [ESLint Configuration](eslint-config.md)
- [Git Hooks](../features/git-hooks.md)
- [Stylelint Configuration](stylelint-config.md)
