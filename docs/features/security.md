# Security

This template includes security best practices and a comprehensive security policy for responsible vulnerability disclosure.

## Security Policy

### Overview

The template includes a security policy that:

- Defines supported versions
- Provides vulnerability reporting instructions
- Establishes response timelines
- Protects researchers who report responsibly

### Location

**File**: `SECURITY.md`

### Supported Versions

| Version | Supported |
|---------|-----------|
| 1.x.x   | ✅ Yes    |
| < 1.0   | ❌ No     |

Only the latest major version receives security updates.

### Reporting Vulnerabilities

#### Private Reporting

**DO NOT** create public issues for security vulnerabilities.

**Instead**, report privately via email:

📧 **arun.krishnamoorthy@aarini.com**

Include in your report:

1. **Description** - Clear description of the vulnerability
2. **Impact** - Potential impact and severity
3. **Steps to Reproduce** - Detailed reproduction steps
4. **Proof of Concept** - If applicable (code, screenshots)
5. **Suggested Fix** - If you have one
6. **Your Contact Info** - For follow-up questions

#### Response Timeline

- **48 hours** - Initial response acknowledging receipt
- **7 days** - Assessment of severity and impact
- **30 days** - Fix deployed (for critical issues)
- **90 days** - Public disclosure (coordinated)

#### Safe Harbor

We will not pursue legal action against researchers who:

- Report vulnerabilities privately first
- Avoid privacy violations and data destruction
- Use exploits only for testing
- Do not perform DoS attacks
- Allow us time to address issues before public disclosure

## Security Features

### Dependency Management

#### Automated Updates

Consider using Dependabot:

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

#### Security Audits

Regularly run security audits:

```bash
# Check for vulnerabilities
npm audit

# Fix automatically (where possible)
npm audit fix

# Force fix (may introduce breaking changes)
npm audit fix --force

# View full report
npm audit --json
```

#### Update Dependencies

Keep dependencies current:

```bash
# Check outdated packages
npm outdated

# Update within version ranges
npm update

# Update to latest (may have breaking changes)
npx npm-check-updates -u
npm install
```

### Environment Variables

#### Best Practices

**File**: `.env.example`

```bash
# GitHub API Token (for automation)
# Create at: https://github.com/settings/tokens
# Required scopes: repo, workflow
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

#### Security Rules

1. **Never commit `.env`** - It's in `.gitignore`
2. **Use `.env.example`** - Document required variables
3. **Rotate credentials** - Change tokens regularly
4. **Limit permissions** - Minimum required scopes
5. **Use secrets management** - For production (GitHub Secrets, AWS Secrets Manager, etc.)

#### Loading Variables

```typescript
// src/config.ts
import * as dotenv from 'dotenv';

dotenv.config();

export const config = {
  githubToken: process.env.GITHUB_TOKEN,
  // Validate presence
  validate() {
    if (!this.githubToken) {
      throw new Error('GITHUB_TOKEN is required');
    }
  }
};
```

### Code Security

#### TypeScript Strict Mode

**File**: `tsconfig.json`

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  }
}
```

**Benefits**:
- Catches type errors at compile time
- Prevents null/undefined errors
- Enforces explicit typing
- Reduces runtime errors

#### Input Validation

Always validate user input:

```typescript
// ❌ Bad: No validation
function processUser(id: string) {
  return db.query(`SELECT * FROM users WHERE id = ${id}`);
}

// ✅ Good: Validated and parameterized
import { z } from 'zod';

const UserIdSchema = z.string().uuid();

function processUser(id: string) {
  const validatedId = UserIdSchema.parse(id);
  return db.query('SELECT * FROM users WHERE id = ?', [validatedId]);
}
```

#### Error Handling

Never expose sensitive information in errors:

```typescript
// ❌ Bad: Exposes internals
catch (error) {
  res.status(500).json({ error: error.message });
}

// ✅ Good: Generic message, log details
catch (error) {
  console.error('Database error:', error);
  res.status(500).json({ error: 'Internal server error' });
}
```

### Secrets in Code

#### Detection

Use tools to scan for secrets:

```bash
# Install gitleaks
brew install gitleaks

# Scan repository
gitleaks detect --source . --verbose

# Scan specific files
gitleaks detect --source ./src
```

#### Pre-commit Hook

Add to `.husky/pre-commit`:

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check for secrets
if command -v gitleaks &> /dev/null; then
  gitleaks protect --staged
fi

npx lint-staged
```

#### If Secrets Leaked

If you accidentally commit secrets:

1. **Immediately rotate** the compromised credentials
2. **Remove from history** using BFG Repo-Cleaner or git-filter-repo
3. **Force push** the cleaned history
4. **Notify team** to re-clone the repository

```bash
# Using BFG (recommended)
bfg --replace-text passwords.txt repo.git
cd repo.git
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force

# Or manually remove file
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all
git push --force --all
```

## GitHub Security Features

### Code Scanning

Enable GitHub code scanning:

```yaml
# .github/workflows/codeql.yml
name: "CodeQL"
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]
  schedule:
    - cron: '0 0 * * 1'  # Weekly

jobs:
  analyze:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v2
        with:
          languages: javascript, typescript
      - uses: github/codeql-action/analyze@v2
```

### Dependabot Alerts

Enable in repository settings:

1. Go to Settings → Security & analysis
2. Enable "Dependabot alerts"
3. Enable "Dependabot security updates"

### Secret Scanning

Automatically enabled for public repos. For private repos:

1. Go to Settings → Security & analysis
2. Enable "Secret scanning"
3. Enable "Push protection"

## Security Checklist

### Development

- [ ] Use TypeScript strict mode
- [ ] Validate all user input
- [ ] Sanitize data before output
- [ ] Use parameterized queries
- [ ] Handle errors securely
- [ ] No secrets in code
- [ ] Dependencies are up to date
- [ ] Security audit passes (`npm audit`)

### Deployment

- [ ] Environment variables configured
- [ ] HTTPS enabled
- [ ] Security headers configured
- [ ] Rate limiting implemented
- [ ] Authentication required
- [ ] Authorization checked
- [ ] Logs don't contain sensitive data
- [ ] Backups are encrypted

### Maintenance

- [ ] Regular dependency updates
- [ ] Security patches applied promptly
- [ ] Access credentials rotated
- [ ] Security audit performed
- [ ] Penetration testing completed
- [ ] Incident response plan documented
- [ ] Team security training current

## Common Vulnerabilities

### SQL Injection

**Risk**: Attacker manipulates database queries

**Prevention**:
```typescript
// ❌ Vulnerable
const query = `SELECT * FROM users WHERE id = ${userId}`;

// ✅ Safe
const query = 'SELECT * FROM users WHERE id = ?';
db.execute(query, [userId]);
```

### XSS (Cross-Site Scripting)

**Risk**: Attacker injects malicious scripts

**Prevention**:
```typescript
// ❌ Vulnerable
element.innerHTML = userInput;

// ✅ Safe
element.textContent = userInput;
// Or use a sanitization library
import DOMPurify from 'dompurify';
element.innerHTML = DOMPurify.sanitize(userInput);
```

### Command Injection

**Risk**: Attacker executes arbitrary commands

**Prevention**:
```typescript
// ❌ Vulnerable
exec(`convert ${filename}.jpg ${filename}.png`);

// ✅ Safe
import { spawn } from 'child_process';
spawn('convert', [filename + '.jpg', filename + '.png']);
```

### Path Traversal

**Risk**: Attacker accesses unauthorized files

**Prevention**:
```typescript
// ❌ Vulnerable
const content = fs.readFileSync(`./uploads/${filename}`);

// ✅ Safe
import path from 'path';
const safePath = path.join('./uploads', path.basename(filename));
const content = fs.readFileSync(safePath);
```

### SSRF (Server-Side Request Forgery)

**Risk**: Attacker makes server request internal resources

**Prevention**:
```typescript
// ❌ Vulnerable
const response = await fetch(userProvidedUrl);

// ✅ Safe
const allowedDomains = ['api.example.com', 'cdn.example.com'];
const url = new URL(userProvidedUrl);
if (!allowedDomains.includes(url.hostname)) {
  throw new Error('Invalid URL');
}
const response = await fetch(url.toString());
```

## Security Resources

### Tools

- **npm audit** - Dependency vulnerability scanning
- **Snyk** - Continuous security monitoring
- **OWASP ZAP** - Web application security testing
- **gitleaks** - Secret detection
- **CodeQL** - Semantic code analysis

### Learning

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [Node.js Security Best Practices](https://nodejs.org/en/docs/guides/security/)
- [npm Security Best Practices](https://docs.npmjs.com/packages-and-modules/securing-your-code)

### Standards

- [CWE (Common Weakness Enumeration)](https://cwe.mitre.org/)
- [CVE (Common Vulnerabilities and Exposures)](https://cve.mitre.org/)
- [CVSS (Common Vulnerability Scoring System)](https://www.first.org/cvss/)

## Incident Response

### If Vulnerability Discovered

1. **Assess severity** using CVSS
2. **Document details** in private channel
3. **Develop fix** in private branch
4. **Test thoroughly** before deploying
5. **Deploy to production** as soon as possible
6. **Notify users** if their data was affected
7. **Publish advisory** with details and mitigation
8. **Conduct post-mortem** to prevent recurrence

### Severity Levels

| CVSS Score | Severity | Response Time |
|------------|----------|---------------|
| 9.0 - 10.0 | Critical | 24 hours |
| 7.0 - 8.9  | High     | 7 days |
| 4.0 - 6.9  | Medium   | 30 days |
| 0.1 - 3.9  | Low      | 90 days |

## Related Documentation

- [GitHub Templates](github-templates.md) - Security issue template
- [CI/CD Workflows](cicd-workflows.md) - Automated security checks
- [Code Quality](code-quality.md) - Code quality enforcement
- [Branch Strategy](branch-strategy.md) - Secure branching workflow
