-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19

-- Winodw configuration
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

-- Coolnight colorscheme
config.colors = {
	foreground = "#CBE0F0",       -- soft cyan text
	background = "#0C1A2B",       -- darker navy blue (new)
	cursor_bg = "#47FF9C",        
	cursor_border = "#47FF9C",
	cursor_fg = "#0C1A2B",
	selection_bg = "#1D3555",     -- slightly lighter than background
	selection_fg = "#CBE0F0",

	ansi = {
		"#0C1A2B", -- black (same as background)
		"#E05252", -- red
		"#44FFB1", -- green
		"#FFD56A", -- yellow
		"#3FC0FF", -- blue
		"#A277FF", -- magenta
		"#2CDDFE", -- cyan
		"#B8DFFC", -- white/light
	},

	brights = {
		"#1F2F45", -- bright black
		"#FF5F5F", -- bright red
		"#72FFD3", -- bright green
		"#FFE07C", -- bright yellow
		"#68CBFF", -- bright blue
		"#C9A6FF", -- bright magenta
		"#6CEFFF", -- bright cyan
		"#DCEFFF", -- bright white
	}
}



return config