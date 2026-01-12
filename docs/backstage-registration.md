# Backstage Registration Guide

This guide explains how to register this template in your Backstage instance.

## Overview

This repository provides two registration options:

1. **Software Template** - Allows users to scaffold new projects from Backstage UI
2. **Component** - Lists the template repository in the catalog for reference

## Option 1: Register as Software Template (Recommended)

This allows users to create new projects from this template using Backstage's "Create" page.

### Step 1: Register the Template

Add the template URL to your Backstage instance:

#### Via Backstage UI

1. Navigate to **Create** → **Register Existing Component**
2. Enter the template URL:
   ```
   https://github.com/btp-dev-squad/template-node-lib/blob/main/template.yaml
   ```
3. Click **Analyze** → **Import**

#### Via app-config.yaml (Permanent)

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

### Step 2: Verify Template is Available

1. Go to **Create** page in Backstage
2. You should see "Node.js Library Template" with the description
3. Click on it to see the template form

### Step 3: Configure GitHub Integration (If Needed)

Ensure your Backstage has GitHub integration configured:

```yaml
# app-config.yaml
integrations:
  github:
    - host: github.com
      token: ${GITHUB_TOKEN}
```

And GitHub OAuth (for user authentication):

```yaml
# app-config.yaml
auth:
  providers:
    github:
      development:
        clientId: ${GITHUB_CLIENT_ID}
        clientSecret: ${GITHUB_CLIENT_SECRET}
```

## Option 2: Register as Component Only

If you only want to list this template repository in the catalog (not for scaffolding):

### Register Component

1. Navigate to **Catalog** → **Register Existing Component**
2. Enter:
   ```
   https://github.com/btp-dev-squad/template-node-lib/blob/main/catalog-info.yaml
   ```
3. Click **Analyze** → **Import**

**Note**: This won't allow users to create new projects from the template, only view it in the catalog.

## Using the Template

Once registered as a Software Template, users can:

1. Click **Create** in Backstage
2. Select **Node.js Library Template**
3. Fill in the form:
   - **Name**: Project name (e.g., `my-library`)
   - **Description**: Brief description
   - **Owner**: Team or user owning the project
   - **Repository Location**: GitHub org and repo name
4. Click **Create**

Backstage will:
- Create a new GitHub repository
- Copy all template files
- Replace template variables with user inputs
- Register the new component in the catalog
- Set up branch protection (if configured)

## Template Features

When users create a project from this template, they get:

### Automated Setup
- ✅ ESLint, Prettier, Stylelint configured
- ✅ Husky git hooks installed
- ✅ Commitlint configured
- ✅ GitHub Actions workflows ready
- ✅ TypeScript configured
- ✅ Documentation structure

### GitHub Integration
- ✅ Issue templates (bug, feature, hotfix, security, docs)
- ✅ PR template with checklist
- ✅ Code owners file
- ✅ Branch validation workflow
- ✅ Code review workflow
- ✅ Auto-release workflow

### Development Workflow
- ✅ Three-branch strategy (main/staging/develop)
- ✅ Conventional commits enforced
- ✅ Semantic versioning
- ✅ Automated changelog generation
- ✅ Security policy

## Customizing the Template

### Modify Template Parameters

Edit `template.yaml` to add/remove parameters:

```yaml
parameters:
  - title: Custom Settings
    properties:
      my_custom_field:
        title: Custom Field
        type: string
        description: My custom configuration
```

### Exclude Files from Templating

Some files should not have template variables replaced (like workflows). These are already configured in `template.yaml`:

```yaml
steps:
  - id: template
    action: fetch:template
    input:
      copyWithoutTemplating:
        - .github/workflows/**
        - .husky/**
```

### Add Custom Steps

Add additional steps to the template scaffolding:

```yaml
steps:
  - id: template
    # ... existing step

  - id: custom-step
    name: Custom Action
    action: my:custom:action
    input:
      param: value
```

## Troubleshooting

### Template Not Appearing in "Create" Page

**Check**:
1. Template is registered (check **Catalog** → search for `nodejs-library-template`)
2. Template kind is `Template` (not `Component`)
3. No validation errors in template.yaml
4. Backstage has access to the GitHub repository

**Validate Template**:
```bash
# Install Backstage CLI
npm install -g @backstage/cli

# Validate template
backstage-cli repo schema openapi verify --schema template.yaml
```

### "Not Allowed Kind" Error

If you get:
```
Entity template:default/nodejs-library-template is not of an allowed kind
```

**Solution**: Register via `app-config.yaml` with explicit allow rules:

```yaml
catalog:
  locations:
    - type: url
      target: https://github.com/btp-dev-squad/template-node-lib/blob/main/template.yaml
      rules:
        - allow: [Template]
```

### Template Variables Not Replaced

**Check**:
1. Variables use correct syntax: `${{ values.component_id }}`
2. Files are not in `copyWithoutTemplating` list
3. Variable names match parameter names in template.yaml

### GitHub Authentication Failed

**Ensure**:
1. GitHub integration is configured in `app-config.yaml`
2. GitHub token has required permissions (repo, workflow)
3. User has OAuth token (if using `requestUserCredentials`)

### Repository Creation Failed

**Possible causes**:
1. Repository already exists with that name
2. User doesn't have permission to create repos in the org
3. GitHub token invalid or expired
4. Branch protection can't be set (insufficient permissions)

## Best Practices

### 1. Use Descriptive Template Metadata

```yaml
metadata:
  name: nodejs-library-template
  title: Node.js Library Template  # User-friendly title
  description: |
    Production-ready template with:
    - Automated testing and linting
    - CI/CD workflows
    - Documentation structure
  tags:
    - recommended  # Helps users find it
```

### 2. Provide Good Parameter Descriptions

```yaml
properties:
  component_id:
    title: Name
    description: |
      Unique name for your library (lowercase, hyphens allowed).
      Example: my-awesome-library
```

### 3. Set Reasonable Defaults

```yaml
properties:
  description:
    title: Description
    default: A Node.js library
    description: Brief description (can be changed later)
```

### 4. Use Entity Name Picker

```yaml
properties:
  component_id:
    ui:field: EntityNamePicker  # Validates uniqueness
```

### 5. Link to Documentation

Add links in the template output:

```yaml
output:
  links:
    - title: Repository
      url: ${{ steps.publish.output.remoteUrl }}
    - title: Documentation
      url: https://github.com/btp-dev-squad/template-node-lib/blob/main/docs/
```

## Advanced Configuration

### Custom Backstage Actions

Create custom actions for your template:

```typescript
// packages/backend/src/plugins/scaffolder.ts
import { createBuiltinActions } from '@backstage/plugin-scaffolder-backend';

export default async function createPlugin(env: PluginEnvironment) {
  const builtInActions = createBuiltinActions({
    // ... config
  });

  const actions = [
    ...builtInActions,
    // Add custom actions here
  ];

  return await createRouter({ actions, /* ... */ });
}
```

### Template Filters

Use Nunjucks filters in your templates:

```yaml
# In catalog-info.yaml template
name: ${{ values.component_id | lower | replace(" ", "-") }}
```

Available filters: upper, lower, replace, trim, and more.

### Conditional Templating

```yaml
# In template files
{% if values.include_tests %}
scripts:
  test: jest
{% endif %}
```

## Additional Resources

- [Backstage Software Templates](https://backstage.io/docs/features/software-templates/)
- [Template Actions](https://backstage.io/docs/features/software-templates/builtin-actions)
- [Writing Templates](https://backstage.io/docs/features/software-templates/writing-templates)
- [Template Syntax](https://backstage.io/docs/features/software-templates/input-examples)

## Support

- **Template Issues**: [GitHub Issues](https://github.com/btp-dev-squad/template-node-lib/issues)
- **Backstage Issues**: [Backstage Discord](https://discord.gg/backstage)
- **Contact**: arun.krishnamoorthy@aarini.com
