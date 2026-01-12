# Commitlint Configuration

Commitlint validates commit messages against Conventional Commits specification.

## Configuration File

**Location**: `commitlint.config.js`

```javascript
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'build',
        'chore',
        'ci',
        'docs',
        'feat',
        'fix',
        'perf',
        'refactor',
        'revert',
        'style',
        'test',
      ],
    ],
    'subject-case': [
      2,
      'never',
      ['start-case', 'pascal-case', 'upper-case'],
    ],
    'subject-empty': [2, 'never'],
    'subject-max-length': [2, 'always', 150],
    'type-empty': [2, 'never'],
  },
};
```

## Rules Explained

- **type-enum**: Allowed commit types (feat, fix, docs, etc.)
- **subject-case**: Prevents capitalized subjects
- **subject-empty**: Subject is required
- **subject-max-length**: Max 150 characters
- **type-empty**: Type is required

## Valid Commit Examples

```bash
feat: add user authentication
fix: resolve memory leak
docs: update API documentation
refactor: simplify error handling
```

## Integration

Runs via `.husky/commit-msg` hook on every commit.

## Related Documentation

- [Commit Management](../features/commit-management.md)
- [Git Hooks](../features/git-hooks.md)
