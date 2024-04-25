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

c.font_size = 13
c.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

local a = w.action

local function is_inside_vim(pane)
	local tty = pane:get_tty_name()
	if tty == nil then
		return false
	end

	local success, _, _ = w.run_child_process({
		"sh",
		"-c",
		"ps -o state= -o comm= -t"
			.. w.shell_quote_arg(tty)
			.. " | "
			.. "grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'",
	})

	return success
end

local function is_outside_vim(pane)
	return not is_inside_vim(pane)
end

local function bind_if(cond, key, mods, action)
	local function callback(win, pane)
		if cond(pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(a.SendKey({ key = key, mods = mods }), pane)
		end
	end

	return { key = key, mods = mods, action = w.action_callback(callback) }
end

c.keys = {
	bind_if(is_outside_vim, "h", "CTRL", a.ActivatePaneDirection("Left")),
	bind_if(is_outside_vim, "j", "CTRL", a.ActivatePaneDirection("Up")),
	bind_if(is_outside_vim, "k", "CTRL", a.ActivatePaneDirection("Down")),
	bind_if(is_outside_vim, "l", "CTRL", a.ActivatePaneDirection("Right")),
}

return c
