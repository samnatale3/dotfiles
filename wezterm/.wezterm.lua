local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.enable_wayland = false

-- Darker Tokyo Night inspired color scheme
config.colors = {
	foreground = "#a5b0d3",
	background = "#0d0e18",
	cursor_bg = "#a5b0d3",
	cursor_border = "#a5b0d3",
	cursor_fg = "#0d0e18",
	selection_bg = "#3b3e56",
	selection_fg = "#a5b0d3",
}

config.color_scheme = "Tokyo Night"

-- Font settings
config.font = wezterm.font("Fira Code", { weight = "Medium" })

config.font_size = 13

-- Disable tab bar
config.enable_tab_bar = false

-- Window decorations and resizing behavior
config.window_decorations = "RESIZE"
-- You can uncomment this line to add opacity to the background
-- config.window_background_opacity = 0.95

-- Return the configuration to WezTerm
return config
