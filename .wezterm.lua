local wezterm = require 'wezterm'

-- global setting --
font = wezterm.font 'SauceCodePro Nerd Font'
color_scheme = 'nord'
window_background_opacity = 0.9
hide_tab_bar_if_only_one_tab = true

-- mouse bindings setting --
mouse_bindings = {
    {
        event = {Up = {streak = 2, button = 'Left'}},
        mods = 'NONE',
        action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
    {
        event = {Down = {streak = 2, button = 'Right'}},
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

-- for macOS
function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on("for-macos-neovim", function(window, pane)
    local process_name = basename(pane:get_foreground_process_name())
    -- window:set_right_status(wezterm.format {
    --     { Text = process_name },
    -- })

    if process_name == 'nvim' then
        window:perform_action(
            wezterm.action.SendKey {key = 'j', mods = 'CTRL'},
            pane
        )
    else
        window:perform_action(
            wezterm.action.SendKey {key = 'j', mods = 'CMD'},
            pane
        )
    end
end)

-- full screen --
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

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
        keys = {
            {key = 'h', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Left'},
            {key = 'l', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Right'},
            {key = 'k', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Up'},
            {key = 'j', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Down'},
            {key = 'LeftArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Left', 1}},
            {key = 'RightArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Right', 1}},
            {key = 'UpArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Up', 1}},
            {key = 'DownArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Down', 1}},
            {key = 'RightArrow', mods = 'CTRL', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}},
            {key = 'DownArrow', mods = 'CTRL', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}},
            {key = 'x', mods = 'CTRL|ALT', action = wezterm.action.ActivateCopyMode},
            {key = '1', mods = 'ALT', action = wezterm.action.ShowLauncher},
        },
    }
elseif wezterm.target_triple == 'aarch64-apple-darwin' then
    return {
        font = font,
        front_end = 'WebGpu',
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        mouse_bindings = mouse_bindings,
        keys = {
            {key = 'h', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Left'},
            {key = 'l', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Right'},
            {key = 'k', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Up'},
            {key = 'j', mods = 'CTRL|CMD', action = wezterm.action.ActivatePaneDirection 'Down'},
            {key = 'LeftArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Left', 1}},
            {key = 'RightArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Right', 1}},
            {key = 'UpArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Up', 1}},
            {key = 'DownArrow', mods = 'CTRL|CMD', action = wezterm.action.AdjustPaneSize {'Down', 1}},
            {key = 'RightArrow', mods = 'CMD', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}},
            {key = 'DownArrow', mods = 'CMD', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}},
            {key = 'x', mods = 'CTRL|CMD', action = wezterm.action.ActivateCopyMode},
            {key = 'j', mods = 'CMD', action = wezterm.action.EmitEvent 'for-macos-neovim'},
            {key = '1', mods = 'ALT', action = wezterm.action.ShowLauncher},
        }
    }
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' or wezterm.target_triple == 'aarch64-unknown-linux-gnu' then
    return {
        font = font,
        color_scheme = color_scheme,
        window_background_opacity = window_background_opacity,
        hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab,
        mouse_bindings = mouse_bindings,
        keys = {
            {key = 'h', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Left'},
            {key = 'l', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Right'},
            {key = 'k', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Up'},
            {key = 'j', mods = 'CTRL|ALT', action = wezterm.action.ActivatePaneDirection 'Down'},
            {key = 'LeftArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Left', 1}},
            {key = 'RightArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Right', 1}},
            {key = 'UpArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Up', 1}},
            {key = 'DownArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize {'Down', 1}},
            {key = 'RightArrow', mods = 'CTRL', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}},
            {key = 'DownArrow', mods = 'CTRL', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}},
            {key = 'x', mods = 'CTRL|ALT', action = wezterm.action.ActivateCopyMode},
            {key = '1', mods = 'ALT', action = wezterm.action.ShowLauncher},
        }
    }
end
