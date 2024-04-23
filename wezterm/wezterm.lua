--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- Corsage's Wezterm config.

local NAME = 'crsg'

-- Wezterm config.
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

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

---
--- Defaults.
---

local shell = 'C:/Program Files/nu/bin/nu.exe'
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
---
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
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnWindow,
  },
  {
    key = 'Space',
    mods = 'CTRL|SHIFT',
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
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
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
}

--- F1 through F8 to activate that tab.
for i = 1, 8 do
  table.insert(config.keys, {
    key = 'F' .. tostring(i),
    action = wezterm.action.ActivateTab(i - 1),
  })
end


---
--- Colors & Appearance.
---

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font_with_fallback({
    { family = "FiraCode Nerd Font", scale = 0.8, weight = "Medium", },
})

config.background = {
  {
    source = {
      File = { path = wezterm.config_dir .. "\\background.jpg" },
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
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = "#f7768e"

    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
      stat = window:active_key_table()
      stat_color = "#7dcfff"
    end
    if window:leader_is_active() then
      stat = "LDR"
      stat_color = "#bb9af7"
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
      { Foreground = { Color = stat_color } },
      { Text = "  " },
      { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
      { Text = " |" },
    }))

    -- Right status
    window:set_right_status(wezterm.format({
      -- Wezterm has a built-in nerd fonts
      -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
      { Text = wezterm.nerdfonts.md_flower_tulip .. " " .. NAME },
      { Text = " | " },
      { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
      { Text = " | " },
      { Foreground = { Color = "#e0af68" } },
      { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
      "ResetAttributes",
      { Text = " | " },
      { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
      { Text = "  " },
    }))
  end)

-- and finally, return the configuration to wezterm
return config