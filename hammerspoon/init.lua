local hyper = { 'cmd', 'ctrl', 'alt', 'shift' }

-- Close the currently focused application
hs.hotkey.bind(hyper, 'q', function()
    hs.application.frontmostApplication():kill()
end)

-- Reload the configuration
hs.hotkey.bind(hyper, 'a', function()
    hs.reload()
end)

local function bindLaunchOrFocusAppToHyperAndKey(appName, key)
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(appName)
    end)
end

local launchOrFocusToBindMap = {
    e = 'Google Chrome',
    r = 'Youtube Music',
    t = 'Telegram',

    s = 'Calendar',
    d = 'Mail',
    f = 'Reminders',
    g = 'Slack',

    c = 'Activity Monitor',
    v = 'Docker Desktop',
    b = 'zoom.us',

    u = 'Kitty',
    i = 'IntelliJ IDEA',
    o = 'Obsidian',
    p = 'NordPass',
}

for key, appName in pairs(launchOrFocusToBindMap) do
    bindLaunchOrFocusAppToHyperAndKey(appName, key)
end

hs.alert.show 'Hammerspoon configuration loaded'
