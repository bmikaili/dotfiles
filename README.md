# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Features

- ✨ **Profile-based configuration**: Separate work and private configs
- 🔒 **Secret management**: Integration with 1Password
- 📦 **Single source of truth**: No config duplication
- 🚀 **Easy setup**: One command to apply all configs

## Profiles

### Work Profile
Includes:
- Salesforce CLI configs (`sfcli/`)
- 1Password configs (`op/`)
- AWS credentials
- Jira API token
- Additional work-specific tools (pipx, direnv, Nix)

### Private Profile
Standard configs without work-specific tools and credentials.

## Quick Start

### First-time setup on a new machine

```bash
# Install chezmoi
brew install chezmoi

# Initialize from this repo
chezmoi init git@github.com:bmikaili/dotfiles.git

# Preview changes
chezmoi diff

# Apply dotfiles
chezmoi apply
```

### Daily usage

```bash
# Check what would change
chezmoi diff

# Apply changes
chezmoi apply

# Edit a file in the source
chezmoi edit ~/.config/fish/config.fish

# Add a new file to be managed
chezmoi add ~/.config/newapp/config.yml

# Pull latest from git and apply
chezmoi update

# Go to source directory
chezmoi cd
```

## Structure

```
~/.local/share/chezmoi/         # Source directory (this repo)
├── .chezmoi.toml.tmpl          # Profile detection
├── .chezmoiignore              # Conditional ignores
├── install.sh                  # System setup script
├── dot_config/                 # ~/.config
│   ├── fish/
│   │   └── config.fish.tmpl    # Template with work/private logic
│   ├── nvim/
│   ├── aerospace/
│   └── ...
└── Library/                    # ~/Library configs
```

## Configuration

Profile is automatically detected based on:
- Hostname containing "snowflake"
- Presence of `SFCLI_OP_ACCOUNT` environment variable

You can override during init:
```bash
chezmoi init --data profile=private
```

Or configure in `~/.config/chezmoi/chezmoi.toml`:
```toml
[data]
    profile = "work"  # or "private"
    email = "your@email.com"
```

## Adding Secrets

Use 1Password integration:
```bash
# In templates:
{{ onepasswordRead "op://Private/item/field" }}
```

## Updating Configs

```bash
# Make changes to your live configs as usual
vim ~/.config/fish/config.fish

# Add the changes to chezmoi
chezmoi add ~/.config/fish/config.fish

# Or edit directly in source
chezmoi edit ~/.config/fish/config.fish

# Commit and push
chezmoi cd
git add .
git commit -m "Update fish config"
git push
```

## Troubleshooting

### See what chezmoi knows about your system
```bash
chezmoi data
```

### See what files are managed
```bash
chezmoi managed
```

### Force apply (ignore file changes)
```bash
chezmoi apply --force
```

## Links

- [chezmoi documentation](https://www.chezmoi.io/)
- [Template syntax](https://www.chezmoi.io/user-guide/templating/)

