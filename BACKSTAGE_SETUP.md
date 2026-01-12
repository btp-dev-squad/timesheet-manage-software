# Backstage Setup - Quick Guide

This document provides quick instructions for registering this template in Backstage.

## What Changed

Your repository now has two entity files:

1. **`template.yaml`** - Software Template definition (for scaffolding new projects)
2. **`catalog-info.yaml`** - Component definition (generated when someone uses the template)

## How to Register as Software Template

### Method 1: Via Backstage UI (Quick Test)

1. Open your Backstage instance
2. Go to **Create** → **Register Existing Component**
3. Enter this URL:
   ```
   https://github.com/btp-dev-squad/template-node-lib/blob/main/template.yaml
   ```
4. Click **Analyze** → **Import**

### Method 2: Via app-config.yaml (Permanent)

Add to your Backstage `app-config.yaml`:

```yaml
catalog:
  locations:
    # Node.js Library Template
    - type: url
      target: https://github.com/btp-dev-squad/template-node-lib/blob/main/template.yaml
      rules:
        - allow: [Template]
```

Then restart Backstage.

## Verify It's Working

1. Go to **Create** page in Backstage
2. Look for "Node.js Library Template"
3. Click on it - you should see a form with:
   - Name field
   - Description field
   - Owner picker
   - Repository location picker

## Using the Template

When users create a project:

1. Click **Create** → **Node.js Library Template**
2. Fill in the form:
   - **Name**: `my-awesome-library`
   - **Description**: "My new library"
   - **Owner**: Select a team or user
   - **Repository**: Choose org and enter repo name
3. Click **Create**

Backstage will:
- Create the GitHub repository
- Copy all template files
- Replace `${{ values.component_id }}` with the actual name
- Set up the project with all DevOps tooling
- Register it in the catalog

## What Users Get

Every project created from this template includes:

- ✅ ESLint, Prettier, Stylelint (pre-configured)
- ✅ Husky git hooks (auto-installed)
- ✅ Commitlint (conventional commits)
- ✅ GitHub Actions (branch validation, code review, auto-release)
- ✅ TypeScript (strict mode)
- ✅ Documentation structure (MkDocs)
- ✅ Issue templates (5 types)
- ✅ PR template
- ✅ Security policy
- ✅ Three-branch workflow (main/staging/develop)

## Troubleshooting

### Template not showing in Create page

**Solution**: Check that you registered `template.yaml` (not `catalog-info.yaml`)

### "Not allowed kind" error

**Solution**: Add to `app-config.yaml` with explicit rules:

```yaml
catalog:
  locations:
    - type: url
      target: https://github.com/btp-dev-squad/template-node-lib/blob/main/template.yaml
      rules:
        - allow: [Template]  # Explicitly allow Template kind
```

### Variables not being replaced

**Check**: Files with `${{ values.* }}` should be processed by the template engine. Workflows and git hooks are excluded (see `copyWithoutTemplating` in template.yaml).

## Need More Details?

See the full guide: [docs/backstage-registration.md](docs/backstage-registration.md)

## Support

- **Template Issues**: [GitHub Issues](https://github.com/btp-dev-squad/template-node-lib/issues)
- **Contact**: arun.krishnamoorthy@aarini.com
