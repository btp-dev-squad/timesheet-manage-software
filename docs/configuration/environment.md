# Environment Variables

Configuration for environment variables in this template.

## Environment File

**Template**: `.env.example`

```bash
# GitHub API Token (for automation)
# Create at: https://github.com/settings/tokens
# Required scopes: repo, workflow
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## Setup

```bash
# Copy example to .env
cp .env.example .env

# Edit with your values
nano .env  # or your preferred editor
```

## Security Best Practices

### Never Commit .env

`.gitignore` includes:
```
.env
```

### Use .env.example

Document required variables without sensitive values:

```bash
# .env.example
DATABASE_URL=postgresql://user:pass@localhost:5432/db
API_KEY=your_api_key_here
```

### Rotate Credentials Regularly

Change tokens and passwords periodically.

### Limit Permissions

Use minimum required scopes for tokens.

### Use Secrets in CI/CD

Store production credentials in GitHub Secrets, not in code.

## Loading Variables

### TypeScript/JavaScript

```typescript
import * as dotenv from 'dotenv';

dotenv.config();

const githubToken = process.env.GITHUB_TOKEN;
```

### With Validation

```typescript
import * as dotenv from 'dotenv';
import { z } from 'zod';

dotenv.config();

const envSchema = z.object({
  GITHUB_TOKEN: z.string().min(1, 'GitHub token is required'),
  NODE_ENV: z.enum(['development', 'staging', 'production']).default('development')
});

export const config = envSchema.parse(process.env);
```

## GitHub Actions

Use repository secrets instead of `.env`:

```yaml
# .github/workflows/release.yml
- name: Create Release
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: gh release create ...
```

## Related Documentation

- [Security](../features/security.md)
- [CI/CD Workflows](../features/cicd-workflows.md)
