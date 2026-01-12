# Node Version Management

This template uses Node.js version 20 specified in `.nvmrc`.

## Version File

**Location**: `.nvmrc`

```
20
```

## Using nvm

### Installation

**macOS/Linux**:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

**Windows**: Use [nvm-windows](https://github.com/coreybutler/nvm-windows)

### Usage

```bash
# Install correct Node version
nvm install

# Use correct Node version
nvm use

# Verify version
node --version  # Should show v20.x.x
```

### Automatic Switching

Add to your shell profile (`.bashrc`, `.zshrc`):

```bash
# Auto-switch Node version
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

## Without nvm

### Manual Installation

Download Node.js 20 from [nodejs.org](https://nodejs.org/).

### Using Volta

```bash
# Install Volta
curl https://get.volta.sh | bash

# Pin Node version
volta pin node@20
```

## CI/CD Integration

### GitHub Actions

```yaml
- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version-file: '.nvmrc'
```

This workflow automatically uses the version specified in `.nvmrc`.

## Why Node.js 20?

- **LTS Release**: Long-term support until April 2026
- **Modern Features**: ES2022 support, performance improvements
- **Stability**: Production-ready and widely adopted

## Updating Version

To change Node version:

1. Update `.nvmrc`:
   ```bash
   echo "22" > .nvmrc
   ```

2. Install new version:
   ```bash
   nvm install
   nvm use
   ```

3. Test your code:
   ```bash
   npm install
   npm run lint
   npm test
   ```

4. Update documentation if needed

## Related Documentation

- [Getting Started](../getting-started.md)
- [Project Structure](../technical/project-structure.md)
- [TypeScript Configuration](../technical/typescript-config.md)
