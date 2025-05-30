local wezterm = require 'wezterm'

return {
  front_end = "OpenGL",
  automatically_reload_config = true,
  color_scheme = "GruvboxDarkHard",
  colors = {
    tab_bar = {
      background = "rgba(0,0,0,0)", -- Transparent background
      active_tab = {
        bg_color = "#ffcb6b",
        fg_color = "#000000",
      },
      inactive_tab = {
        bg_color = "#000000",
        fg_color = "#5c6773",
      },
      inactive_tab_hover = {
        bg_color = "#5c6773",
        fg_color = "#000000",
      },
    },
  },
  window_decorations = "RESIZE",
  window_background_opacity = 0.95,
  window_padding = {
    left = '0.75cell',
    right = '0.75cell',
    top = '0.25cell',
    bottom = '0cell',
  },
  window_frame = {
    inactive_titlebar_bg = "rgba(0,0,0,0)",
    active_titlebar_bg = "rgba(0,0,0,0)",
    font_size = 10.0,
  },
  window_close_confirmation = "NeverPrompt",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 10.0,
  leader = { key = "a", mods = "CTRL" },
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true,
  switch_to_last_active_tab_when_closing_tab = true,
  use_fancy_tab_bar = true,
  keys = {
    { key = "a",  mods = "LEADER|CTRL",  action = wezterm.action.ActivateLastTab },
    { key = "-",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "\\", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "s",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "v",  mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "o",  mods = "LEADER",       action = "TogglePaneZoomState" },
    { key = "z",  mods = "LEADER",       action = "TogglePaneZoomState" },
    { key = "c",  mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { key = "h",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
    { key = "j",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
    { key = "k",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
    { key = "l",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
    { key = "H",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
    { key = "J",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
    { key = "K",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
    { key = "L",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
    { key = "1",  mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
    { key = "2",  mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
    { key = "3",  mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
    { key = "4",  mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
    { key = "5",  mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
    { key = "6",  mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
    { key = "7",  mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
    { key = "8",  mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
    { key = "9",  mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
    { key = "&",  mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    { key = "d",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
    { key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
  },
  max_fps = 144,
}
