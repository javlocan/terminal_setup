local w = require("wezterm")
local c = {}

w.enable_wayland = false
c.enable_wayland = w.enable_wayland

w.color_scheme = "Gruvbox dark, hard (base16)"
c.color_scheme = w.color_scheme

w.tab_bar_at_bottom = true
c.tab_bar_at_bottom = w.tab_bar_at_bottom

w.use_fancy_tab_bar = false
c.use_fancy_tab_bar = w.use_fancy_tab_bar

c.font_rules = {
	{
		intensity = "Normal",
		italic = false,
		font = w.font_with_fallback({
			{ family = "JetBrainsMonoNerdFontMono", weight = "Light" },
			{ family = "JetBrains Mono", weight = "Regular" },
		}),
	},
	{
		intensity = "Bold",
		italic = false,
		font = w.font_with_fallback({
			{ family = "JetBrainsMonoNerdFontMono", weight = "ExtraBold" },
			{ family = "JetBrains Mono", weight = "ExtraBold" },
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = w.font_with_fallback({
			{ family = "VictorMonoNerdFontMono", weight = "Light", style = "Italic" },
			{ family = "JetBrains Mono", weight = "Regular", style = "Italic" },
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = w.font_with_fallback({
			{ family = "VictorMonoNerdFontMono", weight = "Bold", style = "Italic" },
			{ family = "JetBrains Mono", weight = "ExtraBold", style = "Italic" },
		}),
	},
}

return c
