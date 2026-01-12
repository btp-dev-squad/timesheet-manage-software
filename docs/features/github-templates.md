# GitHub Templates

This template includes comprehensive GitHub templates for issues and pull requests, standardizing collaboration and ensuring important information is captured.

## Overview

GitHub templates help teams:

- Collect structured information consistently
- Guide contributors through the process
- Reduce back-and-forth in issues and PRs
- Ensure critical details aren't forgotten
- Triage and categorize work effectively

## Issue Templates

### Location

All issue templates are in `.github/ISSUE_TEMPLATE/`

### Template Types

1. **Bug Report** - Report software defects
2. **Feature Request** - Propose new functionality
3. **Hotfix** - Critical production issues
4. **Security** - Report security vulnerabilities
5. **Documentation** - Documentation improvements

### Bug Report Template

**File**: `.github/ISSUE_TEMPLATE/bug_report.yml`

#### Structure

```yaml
name: Bug Report
description: Report a bug or unexpected behavior
title: "[BUG]: "
labels: ["bug", "needs-triage"]
body:
  - type: dropdown
    attributes:
      label: Severity
      options:
        - Critical (System unusable)
        - High (Major functionality broken)
        - Medium (Feature partially works)
        - Low (Minor issue)

  - type: dropdown
    attributes:
      label: Environment
      options:
        - Production
        - Staging
        - Development
        - Local

  - type: textarea
    attributes:
      label: Description
      description: Clear description of the bug
    validations:
      required: true

  # ... more fields
```

#### Features

- **Severity levels**: Critical, High, Medium, Low
- **Environment tracking**: Production, Staging, Development, Local
- **Required fields**: Description, Steps to Reproduce, Expected/Actual Behavior
- **Optional fields**: Error logs, screenshots, additional context
- **Auto-labels**: `bug`, `needs-triage`

#### Example Usage

When users click "New Issue" → "Bug Report", they get a structured form ensuring all necessary information is provided.

### Feature Request Template

**File**: `.github/ISSUE_TEMPLATE/feature_request.yml`

#### Structure

```yaml
name: Feature Request
description: Suggest a new feature or enhancement
title: "[FEATURE]: "
labels: ["enhancement", "needs-triage"]
body:
  - type: dropdown
    attributes:
      label: Priority
      options:
        - Critical
        - High
        - Medium
        - Low

  - type: dropdown
    attributes:
      label: Category
      options:
        - New Feature
        - Enhancement
        - Performance
        - Developer Experience
        - Documentation
        - Security
        - Other

  - type: textarea
    attributes:
      label: Problem Statement
      description: What problem does this solve?
    validations:
      required: true

  # ... more fields
```

#### Features

- **Priority levels**: Critical, High, Medium, Low
- **Category selection**: Helps with organization
- **Problem-first approach**: Focuses on the "why"
- **Acceptance criteria**: Clear success metrics
- **Auto-labels**: `enhancement`, `needs-triage`

### Hotfix Template

**File**: `.github/ISSUE_TEMPLATE/hotfix.yml`

#### Purpose

For critical production issues requiring immediate attention.

#### Structure

```yaml
name: Hotfix Request
description: Critical production issue requiring immediate fix
title: "[HOTFIX]: "
labels: ["hotfix", "critical", "priority-high"]
body:
  - type: checkboxes
    attributes:
      label: Severity Confirmation
      options:
        - label: This is a critical production issue
          required: true

  - type: dropdown
    attributes:
      label: Impact Level
      options:
        - System completely down
        - Major functionality broken
        - Security vulnerability
        - Data integrity issue
        - Partial functionality affected

  - type: textarea
    attributes:
      label: Business Impact
      description: How is this affecting users/business?
    validations:
      required: true

  # ... more fields
```

#### Features

- **Severity confirmation**: Checkbox to confirm criticality
- **Impact assessment**: Clear business impact description
- **Testing plan**: Required testing strategy
- **Rollback plan**: Required contingency planning
- **Auto-labels**: `hotfix`, `critical`, `priority-high`

### Security Template

**File**: `.github/ISSUE_TEMPLATE/security.yml`

#### Purpose

Guide users to report security vulnerabilities privately.

#### Structure

```yaml
name: Security Vulnerability
description: Report a security issue (PRIVATE REPORTING ONLY)
title: "[SECURITY]: "
labels: ["security", "needs-triage"]
body:
  - type: markdown
    attributes:
      value: |
        ## ⚠️ IMPORTANT

        **DO NOT** create a public issue for security vulnerabilities.

        Please report security issues privately via email:
        **arun.krishnamoorthy@aarini.com**

  # ... instruction fields
```

#### Features

- **Clear instructions**: Directs to private reporting
- **Email contact**: arun.krishnamoorthy@aarini.com
- **Auto-assigned**: Security manager automatically notified
- **Auto-labels**: `security`, `needs-triage`

### Documentation Template

**File**: `.github/ISSUE_TEMPLATE/documentation.yml`

#### Structure

```yaml
name: Documentation Issue
description: Report issues with documentation
title: "[DOCS]: "
labels: ["documentation", "needs-triage"]
body:
  - type: dropdown
    attributes:
      label: Documentation Type
      options:
        - API Documentation
        - User Guide
        - Developer Documentation
        - README
        - Code Comments
        - Configuration Guide
        - Troubleshooting Guide

  - type: dropdown
    attributes:
      label: Issue Type
      options:
        - Missing Documentation
        - Incorrect Information
        - Unclear/Confusing
        - Outdated Information
        - Broken Links
        - Formatting Issues
        - Translation

  # ... more fields
```

#### Features

- **Type categorization**: API, guides, README, etc.
- **Issue classification**: Missing, incorrect, unclear, etc.
- **Location field**: Where the documentation exists/should exist
- **Auto-labels**: `documentation`, `needs-triage`

### Issue Configuration

**File**: `.github/ISSUE_TEMPLATE/config.yml`

```yaml
blank_issues_enabled: false
contact_links:
  - name: General Discussion
    url: https://github.com/btp-dev-squad/template-node-lib/discussions
    about: For general questions and discussions
  - name: Support
    url: https://aarini.com/support
    about: For support inquiries
```

#### Features

- **Blank issues disabled**: Users must use templates
- **Contact links**: Directs non-issue discussions elsewhere
- **Support channels**: Clear escalation paths

## Pull Request Template

### Location

**File**: `.github/PULL_REQUEST_TEMPLATE.md`

### Structure

The PR template includes:

1. **Type of Change** (with emojis)
   - New feature
   - Bug fix
   - Breaking change
   - Documentation
   - Code style/refactoring
   - Performance improvement
   - Tests

2. **Related Issues**
   - Closes #...
   - Related to #...

3. **Description**
   - What changed
   - Why it changed
   - How it changed

4. **Testing**
   - Unit tests
   - Integration tests
   - Manual testing
   - Coverage

5. **Screenshots/Demo** (if applicable)

6. **Pre-Merge Checklist**
   - [ ] Code follows project style
   - [ ] Self-review completed
   - [ ] Code commented where needed
   - [ ] Documentation updated
   - [ ] No merge conflicts
   - [ ] Dependencies updated
   - [ ] Security considerations addressed
   - [ ] Performance impact considered

7. **Review Checklist** (for reviewers)
   - [ ] Logic is correct
   - [ ] Follows established patterns
   - [ ] Error handling is adequate
   - [ ] Security implications reviewed
   - [ ] Performance is acceptable
   - [ ] Documentation is clear
   - [ ] Tests are comprehensive

8. **Deployment Notes**
   - Database migrations
   - Environment variables
   - Configuration changes
   - Monitoring requirements
   - Rollback plan

9. **Performance Impact**
   - Memory usage
   - Load time
   - Database queries

10. **Security Considerations**

### Example PR Content

```markdown
## Type of Change
- [x] 🐛 Bug fix (non-breaking change which fixes an issue)

## Related Issues
Closes #234

## Description
Fixes memory leak in data processing by properly disposing of event listeners.

### What Changed
- Added cleanup logic to `processData()` function
- Implemented proper event listener removal
- Added unit tests for cleanup behavior

### Why It Changed
Users reported increasing memory usage over time. Investigation revealed
event listeners were not being removed after processing completed.

## Testing
- [x] Unit tests pass
- [x] Added new tests for cleanup
- [x] Manual testing: memory profiling shows stable memory usage
- [x] Test coverage: 95%

## Pre-Merge Checklist
- [x] Code follows project style
- [x] Self-review completed
- [x] Code commented where needed
- [x] Documentation updated
- [x] No merge conflicts
- [x] Dependencies updated
- [x] Security considerations addressed
- [x] Performance impact considered

## Performance Impact
- Memory usage: Improved (no longer leaks)
- Load time: No change
- Database queries: No change
```

## Code Owners

### Location

**File**: `.github/CODEOWNERS`

### Configuration

```
# Global ownership
* @aarinidevsquad

# Specific paths (examples)
# /docs/ @documentation-team
# /*.md @documentation-team
# /src/api/ @backend-team
# /src/ui/ @frontend-team
```

### How It Works

1. PR is created
2. GitHub automatically assigns reviewers based on CODEOWNERS
3. Reviews from code owners are required (if configured)
4. PR cannot be merged without approval

### Customization

```
# Multiple owners
* @owner1 @owner2 @owner3

# Path-specific ownership
/src/api/ @backend-team
/src/ui/ @frontend-team
/docs/ @documentation-team

# File pattern ownership
*.js @javascript-team
*.ts @typescript-team
*.css @design-team

# Nested ownership (more specific wins)
* @aarinidevsquad
/src/security/ @security-team
```

## Best Practices

### For Issue Templates

1. **Keep required fields minimal** - Only require truly necessary info
2. **Provide examples** - Show users what good input looks like
3. **Use dropdowns** - Easier than free text for categorization
4. **Auto-label appropriately** - Helps with triage and organization
5. **Update regularly** - Reflect changes in your workflow

### For PR Templates

1. **Make checklists actionable** - Each item should be clear
2. **Don't overcomplicate** - Too many fields = people skip them
3. **Include what matters** - Focus on critical information
4. **Provide examples** - Link to good PRs as examples
5. **Keep it current** - Remove items that aren't being used

### For Code Owners

1. **Start broad, get specific** - Begin with global owners, add specifics as needed
2. **Balance load** - Don't overload any one person/team
3. **Match expertise** - Assign owners who understand the code
4. **Update regularly** - As team structure changes
5. **Document ownership** - Make it clear who owns what

## Customization

### Modifying Templates

1. **Edit YAML files** in `.github/ISSUE_TEMPLATE/`
2. **Test on a fork** before committing
3. **Preview on GitHub** after pushing

### Adding New Templates

```bash
# Create new template
touch .github/ISSUE_TEMPLATE/my-template.yml
```

```yaml
name: My Template
description: Description of template
title: "[PREFIX]: "
labels: ["label1", "label2"]
body:
  - type: textarea
    attributes:
      label: My Field
      description: Field description
    validations:
      required: true
```

### Removing Templates

```bash
# Delete template file
rm .github/ISSUE_TEMPLATE/unwanted-template.yml

# Allow blank issues
# Edit .github/ISSUE_TEMPLATE/config.yml
blank_issues_enabled: true
```

## Benefits

### For Contributors

- Clear expectations of required information
- Guided process reduces errors
- Examples help create better issues/PRs
- Faster feedback from maintainers

### For Maintainers

- Consistent information format
- Easier triage and categorization
- Less time requesting missing information
- Better tracking and metrics

### For Teams

- Standardized workflow
- Reduced onboarding time
- Better collaboration
- Improved project organization

## Related Documentation

- [CI/CD Workflows](cicd-workflows.md) - How PRs trigger automation
- [Branch Strategy](branch-strategy.md) - How PRs fit into workflow
- [Code Quality](code-quality.md) - What gets checked on PR
- [Security](security.md) - Security vulnerability handling
