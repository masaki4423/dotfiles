local application = require("hs.application")
local geometry = require("hs.geometry")
local hotkey = require("hs.hotkey")
local mouse = require("hs.mouse")
local screen = require("hs.screen")
local window = require("hs.window")

local double_press = require("ctrlDoublePress")

local window_filter = window.filter.new()

local function focusedWindowFunc(focusedWindow)
    local appName = "WezTerm"
    local app = application.get(appName)
    local appWindow = app:allWindows()[1]
    local focusedWindowScreen = focusedWindow:screen()

    if app == nil or app:isHidden() then
        appWindow:moveToScreen(focusedWindowScreen)
    end
end

local eventTable = {
    windowFocused = focusedWindowFunc
}

window_filter:subscribe(eventTable)

hotkey.bind({"cmd", "ctrl"}, "i", function()
    local focusedWindow = window.focusedWindow()
    local rect = focusedWindow:frame()
    local center = geometry.rectMidPoint(rect)

    mouse.absolutePosition(center)

end)


local screen_watcher = screen.watcher.newWithActiveScreen(function()
    local appName = "WezTerm"
    local app = application.get(appName)
    local appWindow = app:allWindows()[1]
    local focusedWindow = window.focusedWindow()
    local focusedWindowScreen = focusedWindow:screen()

    if app == nil or app:isHidden() then
        appWindow:moveToScreen(focusedWindowScreen)
    end

end):start()

local open_wezterm = function()
    local appName = "WezTerm"
    local app = application.get(appName)

    if app == nil or app:isHidden() or not(app:isFrontmost()) then
        application.launchOrFocus(appName)
    else
        app:hide()
    end

    -- screen_watcher:start()

end

double_press.timeframe = 0.5
double_press.action = open_wezterm
