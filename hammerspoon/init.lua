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
    e = 'Google Chrome', -- N[e]twork
    r = 'Youtube Music', -- [R]ecords
    t = 'Telegram', -- [T]elegram

    s = 'Calendar', -- [S]chedule
    d = 'Mail', -- Correspon[d]ence
    f = 'Reminders', -- E[f]fort
    g = 'Slack', -- [G]roup chat

    c = 'Activity Monitor', -- [C]PU & RAM
    v = 'Docker Desktop', -- [V]Ms
    b = 'zoom.us', -- [B]usiness meetings

    u = 'Kitty', -- CLI [U]tils
    i = 'IntelliJ IDEA', -- [I]ntellij
    o = 'Obsidian', -- [O]bsidian
    p = 'NordPass', -- [P]asswords
}

for key, appName in pairs(launchOrFocusToBindMap) do
    bindLaunchOrFocusAppToHyperAndKey(appName, key)
end

hs.alert.show 'Hammerspoon configuration loaded'
