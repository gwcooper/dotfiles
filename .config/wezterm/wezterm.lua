local wezterm = require("wezterm")
local k = require("utils.keys")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 14

-- config.window_background_image = "/Users/george/Pictures/terminal_background_2.jpeg"
config.window_decorations = "RESIZE"
config.window_background_image_hsb = {
  brightness = 0.05,
  saturation = 0.2,
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5,
}

config.window_padding = {
  left = 30,
  right = 30,
  top = 20,
  bottom = 10,
}
config.max_fps = 120

config.scrollback_lines = 3000
config.default_workspace = "main"

-- config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  k.cmd_key("d", act.SplitHorizontal({ domain = "CurrentPaneDomain" })),
  k.cmd_key("D", act.SplitVertical({ domain = "CurrentPaneDomain" })),
  k.cmd_key("LeftArrow", act.ActivatePaneDirection("Left")),
  k.cmd_key("RightArrow", act.ActivatePaneDirection("Right")),
  k.cmd_key("UpArrow", act.ActivatePaneDirection("Up")),
  k.cmd_key("DownArrow", act.ActivatePaneDirection("Down")),
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

config.set_environment_variables = {
  -- THEME_FLAVOUR = "latte",
  BAT_THEME = "Catppuccin%20Mocha",
}
return config
