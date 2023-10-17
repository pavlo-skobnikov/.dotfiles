local hyper = { 'cmd', 'ctrl', 'alt', 'shift' }

-- Reload the configuration
hs.hotkey.bind(hyper, 'l', function()
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
    a = 'Activity Monitor', -- [a]ctivity
    b = '',
    c = 'Calendar', -- [c]alendar
    d = 'Docker Desktop', -- [d]ocker
    e = 'System Preferences', -- `e` for `environment`
    f = 'Finder', -- [f]inder
    g = 'Google Chrome', -- [g]oogle
    i = 'IntelliJ IDEA', -- [i]ntellij
    j = '',
    k = 'Kitty', -- [k]itty
    -- l = '', -> Reserved for reloading Hammerspoon's configuration
    m = 'Mail', -- [m]ail
    n = 'NordPass', -- [n]ordpass
    o = 'Obsidian', -- [o]bsidian
    p = 'Postman', -- [p]ostman
    -- q = '', -> Reserved for closing applications
    r = 'Reminders', -- [r]eminders
    s = 'Slack', -- [s]lack
    t = 'Telegram', -- [t]elegram
    u = '',
    v = '',
    w = 'Microsoft Teams', -- microsoft (upside down m -> [w])
    -- x = '', -> Reserved for relaunching Amethyst
    y = 'Youtube Music', -- [y]outube
    z = 'zoom.us', -- [z]oom
}

for key, appName in pairs(launchOrFocusToBindMap) do
    bindLaunchOrFocusAppToHyperAndKey(appName, key)
end

hs.alert.show 'Hammerspoon configuration loaded'
