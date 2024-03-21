local wezterm = require("wezterm")
local act = wezterm.action

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- font_dirs = {
	--     'C:\\Users\\whoami\\.dotfiles\\.fonts'
	-- }
	default_prog = { "wsl.exe", "~", "-d", "Ubuntu-20.04" }
end

wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

return {
	check_for_updates = true,
	term = "xterm-256color",
	use_ime = true,

	----------------
	-- Appearance --
	----------------
	window_background_opacity = 0.99,
	color_scheme = "Tokyo Night",
	window_padding = {
		left = 3,
		right = 3,
		top = 3,
		bottom = 3,
	},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.7,
	},

	initial_rows = 50,
	initial_cols = 140,

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	-- How many lines of scrollback you want to retain per tab
	scrollback_lines = 3500,
	enable_scroll_bar = true,

	-----------
	-- Fonts --
	-----------
	--disable_default_key_bindings = true,
	--line_height = 1,
	-- font = wezterm.font("Fira Code"),
	font = wezterm.font("JetBrains Mono"),
	font_size = 13.0,

	-----------
	-- Keys  --
	-----------
	-- Rather than emitting fancy composed characters when alt is pressed, treat the
	-- input more like old school ascii with ALT held down
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,

	-- change here to key="b", mods="CMD" for ^+b equivalent in tmux.
	-- leader = { key = "META", mods = "NONE", timeout_milliseconds = 1000 },
	keys = {
		{ key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
		{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },

		-- The physical CMD key on OSX is the Alt key on Win/*nix, so map the common Alt-combo commands.
		{ key = ".", mods = "CMD", action = act.SendString("\x1b.") },
		{ key = "p", mods = "CMD", action = act.SendString("\x1bp") },
		{ key = "n", mods = "CMD", action = act.SendString("\x1bn") },
		{ key = "b", mods = "CMD", action = act.SendString("\x1bb") },
		{ key = "f", mods = "CMD", action = act.SendString("\x1bf") },

		-- Window management
		{ key = "a", mods = "ALT", action = act({ SendString = "`" }) },
		{ key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "\\", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "z", mods = "ALT", action = "TogglePaneZoomState" },
		{ key = "c", mods = "ALT", action = act({ SpawnTab = "CurrentPaneDomain" }) },

		{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

		{ key = "H", mods = "ALT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "ALT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "ALT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "ALT", action = act({ AdjustPaneSize = { "Right", 5 } }) },

		{ key = "`", mods = "ALT", action = act.ActivateLastTab },
		{ key = " ", mods = "ALT", action = act.ActivateTabRelative(1) },
		{ key = "1", mods = "ALT", action = act({ ActivateTab = 0 }) },
		{ key = "2", mods = "ALT", action = act({ ActivateTab = 1 }) },
		{ key = "3", mods = "ALT", action = act({ ActivateTab = 2 }) },
		{ key = "4", mods = "ALT", action = act({ ActivateTab = 3 }) },
		{ key = "5", mods = "ALT", action = act({ ActivateTab = 4 }) },
		{ key = "6", mods = "ALT", action = act({ ActivateTab = 5 }) },
		{ key = "7", mods = "ALT", action = act({ ActivateTab = 6 }) },
		{ key = "8", mods = "ALT", action = act({ ActivateTab = 7 }) },
		{ key = "9", mods = "ALT", action = act({ ActivateTab = 8 }) },
		{ key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },

		-- Activate Copy Mode
		{ key = "[", mods = "ALT", action = act.ActivateCopyMode },
		-- Paste from Copy Mode
		{ key = "]", mods = "ALT", action = act.PasteFrom("PrimarySelection") },
	},

	key_tables = {
		-- added new shortcuts to the end
		copy_mode = {
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },

			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },

			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },

			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },

			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },

			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },

			{ key = " ", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },

			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },

			-- Enter y to copy and quit the copy mode.
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({
					act.CopyTo("ClipboardAndPrimarySelection"),
					act.CopyMode("Close"),
				}),
			},
			-- Enter search mode to edit the pattern.
			-- When the search pattern is an empty string the existing pattern is preserved
			{ key = "/", mods = "NONE", action = act({ Search = { CaseSensitiveString = "" } }) },
			{ key = "?", mods = "NONE", action = act({ Search = { CaseInSensitiveString = "" } }) },
			{ key = "n", mods = "CTRL", action = act({ CopyMode = "NextMatch" }) },
			{ key = "p", mods = "CTRL", action = act({ CopyMode = "PriorMatch" }) },
		},

		search_mode = {
			{ key = "Escape", mods = "NONE", action = act({ CopyMode = "Close" }) },
			-- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
			-- to navigate search results without conflicting with typing into the search area.
			{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
			{ key = "c", mods = "CTRL", action = "ActivateCopyMode" },
			{ key = "n", mods = "CTRL", action = act({ CopyMode = "NextMatch" }) },
			{ key = "p", mods = "CTRL", action = act({ CopyMode = "PriorMatch" }) },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
		},
	},
}
