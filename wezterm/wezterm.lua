local wezterm = require 'wezterm'
local mouse_bindings = require 'mouse_binding'
local key_bindings = require 'key_binding'
require 'event'

-- global setting --
font = wezterm.font 'SauceCodePro Nerd Font'
color_scheme = 'nord'
window_background_opacity = 0.9
hide_tab_bar_if_only_one_tab = true

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

    -- Launcher Setting --
    HOME_DIR = wezterm.home_dir
    launch_menu = {
        {
            label = 'PowerShell',
            args = { HOME_DIR..'\\AppData\\Local\\Microsoft\\WindowsApps\\pwsh.exe' },
        }
    }

    return {
        default_prog = {"wsl.exe", "--cd", "~"},
        launch_menu = launch_menu,
        font = font,
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        mouse_bindings = mouse_bindings,
        keys = key_bindings,
    }
elseif wezterm.target_triple == 'aarch64-apple-darwin' then

    return {
        font = font,
        front_end = 'WebGpu',
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        mouse_bindings = mouse_bindings,
        keys = key_bindings,
    }
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' or wezterm.target_triple == 'aarch64-unknown-linux-gnu' then

    return {
        font = font,
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        mouse_bindings = mouse_bindings,
        keys = key_bindings,
    }
end
