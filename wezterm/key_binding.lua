local wezterm = require 'wezterm'

local key_bindings

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

    key_bindings = {
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
elseif wezterm.target_triple == 'aarch64-apple-darwin' then

    key_bindings = {
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
        {key = 'k', mods = 'SHIFT|ALT', action = wezterm.action.ScrollByPage(-1)},
        {key = 'j', mods = 'SHIFT|ALT', action = wezterm.action.ScrollByPage(1)},
        {key = 'p', mods = 'CTRL|CMD', action = wezterm.action.ShowDebugOverlay},
    }
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' or wezterm.target_triple == 'aarch64-unknown-linux-gnu' then

    key_bindings = {
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
end

return key_bindings
