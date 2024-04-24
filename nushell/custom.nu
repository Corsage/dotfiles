# Nushell Custom Config File
#
# version = "0.92.2"

# Starship config.
use ~/.cache/starship/init.nu

# Environment variables.
$env.PROJECT_DIR = "C:\\Users\\Corsage\\Documents\\Projects"

# Aliases.
alias g = git

alias sync-projects = nu ($env.WEZTERM_CONFIG_DIR + "\\generate_project_workspaces.nu")