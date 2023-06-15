local wezterm = require 'wezterm'

-- mouse bindings setting --
local mouse_bindings = {
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

return mouse_bindings
