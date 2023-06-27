hs.hotkey.bind({"cmd", "ctrl"}, "i", function()
    local appName = "WezTerm"
    local app = hs.application.get(appName)
    local window = app:allWindows()[1]
    local mainScreen = hs.screen.mainScreen()

    if app == nil or app:isHidden() then
        window:moveToScreen(mainScreen)
        hs.application.launchOrFocus(appName)
    elseif not(app:isFrontmost()) then
        hs.application.launchOrFocus(appName)
    else
        app:hide()
    end
end)
