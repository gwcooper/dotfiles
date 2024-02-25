local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 14

-- config.window_background_image = "/Users/george/Pictures/terminal_background_2.jpeg"
config.window_decorations = "RESIZE"
config.window_background_image_hsb = {
	brightness = 0.05,
	saturation = 0.2,
}
config.window_background_opacity = 0.6
config.macos_window_background_blur = 20

config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

config.scrollback_lines = 3000
config.default_workspace = "main"

config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "a",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "activate_pane",
			one_shot = false,
		}),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "split_pane",
			one_shot = false,
		}),
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow",  action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h",          action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l",          action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow",    action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k",          action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow",  action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j",          action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape",     action = "PopKeyTable" },
	},
	activate_pane = {
		{ key = "LeftArrow",  action = act.ActivatePaneDirection("Left") },
		{ key = "h",          action = act.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "l",          action = act.ActivatePaneDirection("Right") },

		{ key = "UpArrow",    action = act.ActivatePaneDirection("Up") },
		{ key = "k",          action = act.ActivatePaneDirection("Up") },

		{ key = "DownArrow",  action = act.ActivatePaneDirection("Down") },
		{ key = "j",          action = act.ActivatePaneDirection("Down") },
		{ key = "Escape",     action = "PopKeyTable" },
	},
	split_pane = {
		{ key = "h",      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "v",      action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- Tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Right status
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
		-- { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		-- { Text = " | " },
		-- { Foreground = { Color = "#e0af68" } },
		-- { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		-- "ResetAttributes",
		{ Text = "  " .. wezterm.nerdfonts.md_clock .. "  " .. time .. "  " },
		-- { Text = time },
	}))
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
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
