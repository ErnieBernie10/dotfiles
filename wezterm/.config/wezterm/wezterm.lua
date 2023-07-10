local wezterm = require("wezterm")

local act = wezterm.action

local config = {}

config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

config.default_prog = { '/usr/bin/zsh' }

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.add_to_config_reload_watch_list(".dotfiles/wezterm/.config/wezterm/")

-- CTRL + SHIFT + ARROW = switch panes
local mykeys = {}

for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(mykeys, {
    key = tostring(i),
    mods = "ALT",
    action = act({ ActivateTab = i - 1 }),
  })
end

table.insert(mykeys, { key = "R", mods = "ALT", action = wezterm.action.ReloadConfiguration })

table.insert(mykeys, { key = "n", mods = "ALT", action = act({ SpawnTab = "CurrentPaneDomain" }) })

table.insert(mykeys, { key = "f", mods = "ALT", action = "ToggleFullScreen" })


table.insert(mykeys, { key = "[", mods = "ALT", action = act.MoveTabRelative(-1) })
table.insert(mykeys, { key = "]", mods = "ALT", action = act.MoveTabRelative(1) })

table.insert(mykeys, { key = "H", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) })
table.insert(mykeys, { key = "V", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) })

table.insert(mykeys, { key = "h", mods = "ALT", action = act({ ActivatePaneDirection = "Left" }) })
table.insert(mykeys, { key = "j", mods = "ALT", action = act({ ActivatePaneDirection = "Down" }) })
table.insert(mykeys, { key = "k", mods = "ALT", action = act({ ActivatePaneDirection = "Up" }) })
table.insert(mykeys, { key = "l", mods = "ALT", action = act({ ActivatePaneDirection = "Right" }) })


table.insert(mykeys, { key = "h", mods = "CTRL|ALT", action = act.AdjustPaneSize { 'Left', 1 } })
table.insert(mykeys, { key = "j", mods = "CTRL|ALT", action = act.AdjustPaneSize { 'Down', 1 } })
table.insert(mykeys, { key = "k", mods = "CTRL|ALT", action = act.AdjustPaneSize { 'Up', 1 } })
table.insert(mykeys, { key = "l", mods = "CTRL|ALT", action = act.AdjustPaneSize { 'Right', 1 } })

table.insert(mykeys, { key = "c", mods = "ALT", action = act.ActivateCopyMode })

table.insert(mykeys, { key = "q", mods = "ALT", action = act.QuickSelect })

table.insert(mykeys, { key = "s", mods = "ALT", action = act.Search { CaseSensitiveString = '' } })

table.insert(mykeys, { key = "H", mods = "ALT", action = act.AdjustPaneSize { 'Left', 5 } })
table.insert(mykeys, { key = "J", mods = "ALT", action = act.AdjustPaneSize { 'Down', 5 } })
table.insert(mykeys, { key = "K", mods = "ALT", action = act.AdjustPaneSize { 'Up', 5 } })
table.insert(mykeys, { key = "L", mods = "ALT", action = act.AdjustPaneSize { 'Right', 5 } })


config.font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false, stretch = 'Normal' })

config.harfbuzz_features = {
  'calt=1',
  'clig=1',
  'liga=1',
  'zero',
  'onum',
  'ss1',
  'ss2',
  'ss3',
  'ss4',
  'ss5',
  'ss6',
  'ss7',
  'ss8',
  'ss9',
  'ss10',
  'cv01',
  'cv02',
  'cv03',
  'cv04',
  'cv05',
  'cv06',
  'cv07',
  'cv08',
  'cv09',
  'cv10',
  'cv11',
  'cv12',
  'cv13',
  'cv14',
  'cv15',
  'cv16',
  'cv17',
  'cv18',
  'cv19',
  'cv20',
  'cv21',
  'cv22',
  'cv23',
  'cv24',
  'cv25',
  'cv26',
  'cv27',
  'cv28',
  'cv29',
  'cv30',
  'cv31',
}
config.audible_bell = "Disabled"
config.window_background_opacity = 0.90
config.scrollback_lines = 10000
config.color_scheme = "Google Dark (Gogh)"
config.exit_behavior = "Close"
config.keys = mykeys
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.default_cursor_style = 'BlinkingBlock'

wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

return config
