local wezterm = require 'wezterm'

-- for macOS
function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on("for-macos-neovim", function(window, pane)
    local process_name = basename(pane:get_foreground_process_name())

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
