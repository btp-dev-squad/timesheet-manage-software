# Stylelint Configuration

Configuration for CSS and SCSS linting in this template.

## Configuration File

**Location**: `.stylelintrc`

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

## Key Features

- **Sass support**: PostCSS SCSS syntax
- **Prettier integration**: Consistent formatting
- **Property ordering**: Alphabetical
- **Nesting limits**: Max 2 levels
- **Sass guidelines**: Community best practices

## Running Stylelint

```bash
# Lint styles
npm run lint:styles

# Auto-fix
npm run format:styles
```

## Related Documentation

- [Code Quality](../features/code-quality.md)
- [Package Scripts](../configuration/package-scripts.md)
