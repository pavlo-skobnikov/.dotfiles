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
    c = 'Calendar', -- [c]alendar
    d = 'Docker Desktop', -- [d]ocker
    g = 'Google Chrome', -- [g]oogle
    i = 'IntelliJ IDEA', -- [i]ntellij
    k = 'Kitty', -- [k]itty
    m = 'Mail', -- [m]ail
    n = 'NordPass', -- [n]ordpass
    o = 'Obsidian', -- [o]bsidian
    r = 'Reminders', -- [r]eminders
    s = 'Slack', -- [s]lack
    t = 'Telegram', -- [t]elegram
    y = 'Youtube Music', -- [y]outube
    z = 'zoom.us', -- [z]oom
}

for key, appName in pairs(launchOrFocusToBindMap) do
    bindLaunchOrFocusAppToHyperAndKey(appName, key)
end

hs.alert.show 'Hammerspoon configuration loaded'
