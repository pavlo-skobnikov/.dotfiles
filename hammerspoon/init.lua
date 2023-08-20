local hyper = { 'cmd', 'ctrl', 'alt', 'shift' }

-- Reload the configuration
hs.hotkey.bind(hyper, 'r', function()
    hs.reload()
end)

-- Close the currently focused application
hs.hotkey.bind(hyper, 'q', function()
    hs.application.frontmostApplication():kill()
end)

local function bindLaunchOrFocusAppToHyperAndKey(appName, key)
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(appName)
    end)
end

local launchOrFocusToBindMap = {
    a = 'Activity Monitor',
    b = '',
    c = 'Calendar',
    d = 'Docker Desktop',
    e = 'System Preferences', -- `e` for `environment`
    f = 'Finder',
    g = 'Google Chrome',
    h = 'Hammerspoon',
    i = 'IntelliJ IDEA',
    j = '',
    k = 'Kitty',
    l = 'Reminders', -- `l` for `TODO list`
    m = 'Mail',
    n = 'NordPass',
    o = 'Obsidian',
    p = 'Postman',
    -- q = '', -> Reserved for closing applications
    -- r = '', -> Reserved for reloading Hammerspoon's configuration
    s = 'Slack',
    t = 'Telegram',
    u = '',
    -- v = '', -> Reserved for showing the shortcut reminder
    w = 'Microsoft Teams', -- `w` for `work`
    -- x = '', -> Reserved for relaunching Amethyst
    y = 'Youtube Music',
    z = 'zoom.us',
}

for key, appName in pairs(launchOrFocusToBindMap) do
    bindLaunchOrFocusAppToHyperAndKey(appName, key)
end

hs.alert.show 'Hammerspoon configuration loaded'
