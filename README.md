# Dotfiles

A dotfiles manager with per-machine variant support and tool management via [mise](https://mise.jdx.dev/).

## Prerequisites

Install these before bootstrapping:

- **zsh** (ships with macOS; `apt install zsh` on Linux)
- **git** (`xcode-select --install` on macOS; `apt install git` on Linux)
- **stow** (`brew install stow` on macOS; `apt install stow` on Linux)
- **[mise](https://mise.jdx.dev/getting-started.html)** (manages dev tools declared in `.config/mise/config.toml`)

## Bootstrap

```sh
# Clone the repo
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Activate mise for the current shell session
eval "$(mise activate zsh)"    # or: eval "$(mise activate bash)"

# Install python (from the repo-local mise.toml)
mise install

# Set the variant for this machine
./dotfiles.py variant oxygen

# Assemble configs, install antidote, and symlink into $HOME
./dotfiles.py prepare

# Install all tools declared in the global mise config
mise install
```

On first shell startup after `dotfiles prepare`, [antidote](https://github.com/mattmc3/antidote) will automatically clone zsh plugins (powerlevel10k).

## Usage

| Command | Description |
|---|---|
| `./dotfiles.py prepare` | Assemble config files from templates, clone/update antidote, symlink into `$HOME` |
| `./dotfiles.py clear` | Remove symlinks from `$HOME` |
| `./dotfiles.py variant` | Show current variant |
| `./dotfiles.py variant <name>` | Set variant (run `prepare` after) |

## How it works

### Config templating

Files in `common/` are config templates. Lines starting with `----- partial_name` are replaced with content from `variants/<variant>/partial_name`, falling back to `variants/default/partial_name`. The assembled output goes into `current/`, which is symlinked into `$HOME` via stow.

### Variants

Each machine gets a variant name. Currently only `oxygen` has overrides:

```
variants/
  oxygen/
    zshrc_misc    # machine-specific shell config
```

### Tool management

CLI tools are managed by mise via `common/.config/mise/config.toml`. After `dotfiles prepare` and `mise install`, the following are available:

- python, neovim, fzf, bat, ripgrep, direnv, sops

Zsh plugins (powerlevel10k) are managed by antidote via `common/.zsh_plugins.txt`.

LSP servers and formatters (gopls, pyright, rust-analyzer, stylua, ruff, etc.) are managed by Mason inside neovim.

Project-level tools (go, ruby, node, java, scala, gradle) are managed by per-project `.mise.toml` files, not the global config.

## Repo structure

```
dotfiles.py       Standalone CLI script (no dependencies)
mise.toml         Repo-local mise config (python for bootstrapping)
common/           Config templates (symlinked into $HOME)
  .zshrc
  .zsh_plugins.txt
  .gitconfig
  .p10k.zsh
  .config/
    bat/
    kmonad/
    mise/
    nvim/
variants/         Per-machine overrides
  oxygen/
current/          Generated output (gitignored)
current_variant   Active variant name
```
