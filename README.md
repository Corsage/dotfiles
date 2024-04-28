# dotfiles
A collection of my personal dotfile configs.

This configuration is focused on **cross-platform** compatibility.

*The theme and colors used are all based on [Tokyo Night](https://github.com/imjoshellis/tokyonight.nvim).*

<img src="https://github.com/Corsage/dotfiles/blob/main/showcase/terminal.png"/>

## Setup

### Terminal Emulator

[Wezterm](https://wezfurlong.org/wezterm/index.html) - a powerful cross-platform terminal emulator and multiplexer.

### Shell

[NuShell](https://www.nushell.sh/) - a flexible cross-platform shell with a modern feel.

[Starship](https://starship.rs/) - the minimal, blazing-fast, and infinitely customizable prompt for any shell!

## Applications

### Neovim

<img src="https://github.com/Corsage/dotfiles/blob/main/showcase/neovim.png"/>

## Customization

### Projects Workspace

Uses `NuShell` to generate workspaces based on the `PROJECT_DIR` set in `/nushell/custom.nu`.

The command `sync-projects` will generate the project workspaces.

The generated project workspaces are saved in `/wezterm/` as `projects.lua` which is then read by `WezTerm` when in Projects mode.

<img src="https://github.com/Corsage/dotfiles/blob/main/showcase/project-workspaces.gif"/>
