local application = require("hs.application")
local screen = require("hs.screen")

local double_press = require("ctrlDoublePress")

local screen_watcher = screen.watcher.newWithActiveScreen(function()
    local appName = "WezTerm"
    local app = application.get(appName)
    local window = app:allWindows()[1]
    local mainScreen = screen.mainScreen()

    if app == nil or app:isHidden() then
        window:moveToScreen(mainScreen)
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

    screen_watcher:start()

end

double_press.timeframe = 0.5
double_press.action = open_wezterm
