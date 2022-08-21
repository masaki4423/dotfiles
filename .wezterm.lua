local wezterm = require 'wezterm'

-- global setting --
font = wezterm.font 'SauceCodePro Nerd Font'
color_scheme = 'nord'
window_background_opacity = 0.8
hide_tab_bar_if_only_one_tab = true


-- full screen --
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    return {
        default_prog = {"wsl.exe", "--distribution", "Slackware", "--cd", "~"},
        font = font,
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        keys = {
            {key = 'b', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Left'},
            {key = 'f', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Right'},
            {key = 'p', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Up'},
            {key = 'n', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Down'},
            {key = 'LeftArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Left', 1}},
            {key = 'RightArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Right', 1}},
            {key = 'UpArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Up', 1}},
            {key = 'DownArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Down', 1}},
            {key = 'RightArrow', mods = 'CTRL', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}},
            {key = 'DownArrow', mods = 'CTRL', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}},
            {key = 'x', mods = 'CTRL|ALT', action = wezterm.action.ActivateCopyMode},
        },
    }
elseif wezterm.target_triple == 'aarch64-apple-darwin' then
    return {
        font = font,
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        keys = {
            {key = 'b', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Left'},
            {key = 'f', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Right'},
            {key = 'p', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Up'},
            {key = 'n', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Down'},
            {key = 'LeftArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Left', 1}},
            {key = 'RightArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Right', 1}},
            {key = 'UpArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Up', 1}},
            {key = 'DownArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Down', 1}},
            {key = 'RightArrow', mods = 'CMD', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}},
            {key = 'DownArrow', mods = 'CMD', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}},
            {key = 'x', mods = 'CTRL|CMD', action = wezterm.action.ActivateCopyMode},
        }
    }
end