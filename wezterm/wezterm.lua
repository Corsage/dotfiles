--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- Corsage's Wezterm config.

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local USER = {
  name = 'crsg',
  icon = wezterm.nerdfonts.md_flower_tulip
}

---
--- Helper functions.
---

-- Normalize a path.
local normalize = function(s)
  return s:gsub("[\\/]$", ""):gsub("^[\\/]",""):gsub("\\", "/")
end

-- Get the basename.
local basename = function(s)
  return s:match("[^\\/:]*$")
end

-- Snakecase to UPPER Title Case.
local snakecase_to_upper_titlecase = function(s)
  return (s:gsub("_", " "):upper())
end

---
--- Defaults.
---

local shell = 'C:\\Users\\Corsage\\.cargo\\bin\\nu.exe'
config.default_prog = { shell }
config.default_workspace = "main"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.enable_scroll_bar = true

-- Controls default window size.
config.initial_cols = 200
config.initial_rows = 50

---
--- Keybindings.
---
--- How do you remember so many keys?
---
--- 1. ALT affects panes.
--- 2. CTRL affects tabs.
--- 3. CTRL + SHIFT affects the window/workspace.
--- 4. WASD controls all travel.
--- 5. Space enables LEADER keys.
---
config.leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 2000 }
config.keys = {
  ---
  --- Window / Workspace.
  ---
  {
    key = 'q',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuitApplication
  },
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
  -- {
  --   key = 'n',
  --   mods = 'CTRL|SHIFT',
  --   action = wezterm.action.SpawnWindow,
  -- },
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  {
    key = 'Space',
    mods = 'CTRL',
    action = wezterm.action.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SwitchWorkspaceRelative(-1)
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SwitchWorkspaceRelative(1)
  },
  ---
  --- Tabs.
  ---
  {
    key = 'q',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab { confirm = false }
  },
  {
    key = 'n',
    mods = 'CTRL',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'a',
    mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'd',
    mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(1)
  },
  ---
  --- Panes.
  ---
  {
    key = 'q',
    mods = 'ALT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'h',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'a',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'd',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'w',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 's',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  ---
  --- Leader.
  ---
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'projects',
      one_shot = true,
    },
  },
}

for i = 1, 8 do
  --- F1 through F8 to activate that tab.
  table.insert(config.keys, {
    key = 'F' .. tostring(i),
    action = wezterm.action.ActivateTab(i - 1),
  })
end

---
--- Key Tables.
--- Shortcuts for our shortcuts.
---
config.key_tables = {
  projects = {
    {
      key = 'Escape',
      action = 'PopKeyTable'
    },
    {
      key = 'Space',
      action = wezterm.action_callback(function(window, pane)
        local projects = require 'projects'

        window:perform_action(
          wezterm.action.InputSelector {
            action = wezterm.action_callback(
              function(inner_window, inner_pane, id, label)
                if not id and not label then
                  wezterm.log_info 'cancelled'
                else
                  wezterm.log_info('id = ' .. id)
                  wezterm.log_info('label = ' .. label)
                  inner_window:perform_action(
                    wezterm.action.SwitchToWorkspace {
                      name = 'PROJECT: ' .. label,
                      spawn = {
                        label = label,
                        cwd = id,
                      },
                    },
                    inner_pane
                  )
                end
              end
            ),
            title = 'Choose Project Workspace',
            choices = projects,
            fuzzy = true,
            fuzzy_description = 'Fuzzy find and/or make a project workspace',
          },
          pane
        )
      end),
    },
  }
}


---
--- Colors & Appearance.
---

-- Colors taken from to match theme.
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors.lua
local COLORS = {
  Red = "#f7768e",
  Green = "#9ece6a",
  Purple = "#9d7cd8",
  Orange = "#ff9e64",
  Yellow = "#e0af68",
  Teal = "#1abc9c",
  Blue = "#7aa2f7",
  Cyan = "#7dcfff"
}

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font_with_fallback({
    { family = "FiraCode Nerd Font", scale = 0.8, weight = "Medium", },
})

config.background = {
  {
    source = {
      File = { path = wezterm.config_dir .. "\\4.jpg" },
    },
    opacity = 0.9,
    width = "100%",
    hsb = { brightness = 0.25 },
  }
}

config.window_decorations = "RESIZE"

-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.25,
    brightness = 0.5
}

-- Tab bar.
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = true

-- Get home directory.
local home = normalize(wezterm.home_dir)

wezterm.on("update-status", function(window, pane)
  local stat = {
    label = window:active_workspace(),
    color = COLORS.Red,
    icon = wezterm.nerdfonts.oct_table
  };

  if window:active_key_table() then
    stat.label = snakecase_to_upper_titlecase(window:active_key_table())
    stat.color = COLORS.Green
    stat.icon = wezterm.nerdfonts.md_table
  elseif window:leader_is_active() then
    stat.label = "LEADER"
    stat.color = COLORS.Teal
    stat.icon = wezterm.nerdfonts.md_layers
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  cwd = cwd and normalize(cwd.file_path) or ""

  if cwd == home then
    cwd = "Home"
  else
    cwd = basename(cwd)
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  cmd = cmd and basename(cmd) or "Unknown"

  -- Time
  local time = wezterm.strftime("%H:%M")

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat.color } },
    { Text = "  " },
    { Text = stat.icon .. "  " .. stat.label },
    { Text = " |" },
  }))

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Foreground = { Color = COLORS.Purple } },
    { Text = USER.icon .. " " .. USER.name },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Foreground = { Color = COLORS.Yellow } },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = "  " },
  }))
end)

-- and finally, return the configuration to wezterm
return config