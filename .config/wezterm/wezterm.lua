-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Function to apply the tab bar colors based on the appearance
local function apply_tab_bar_colors(appearance)
	if appearance:find("Dark") then
		return "Github Dark"
	else
		return "Github"
	end
end

wezterm.on("window-config-reloaded", function(window, _)
	local appearance = window:get_appearance()
	local scheme = apply_tab_bar_colors(appearance)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

config.font = wezterm.font({ family = "Liga SFMono Nerd Font", weight = "Bold" })
config.font_size = 14
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false

config.keys = {
	{
		key = "+",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "h",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
}

config.front_end = "OpenGL"
config.freetype_load_flags = "NO_HINTING"

return config
