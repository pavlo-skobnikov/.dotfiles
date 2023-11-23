local u = require 'util'

--- `Hyper` sub-layer key bindings

hs.window.animationDuration = 0 -- Disable animations, default value = 0.2

u.bindHyperSubmodeActions(
    'v',
    '[V]iews',
    hs.fnutils.map({
        -- Occupy 1/2 of a screen
        h = { 0, 0, 0.5, 1 }, -- <
        l = { 0.5, 0, 0.5, 1 }, -- >
        j = { 0, 0.5, 1, 0.5 }, -- v
        k = { 0, 0, 1, 0.5 }, -- ^
        -- Occupy 1/3 of a screen
        n = { 0, 0, 0.33, 1 }, -- Left
        m = { 0.33, 0, 0.33, 1 }, -- Middle
        [','] = { 0.66, 0, 0.33, 1 }, -- Right
        -- Occupy 1/4 of a screen
        y = { 0, 0, 0.5, 0.5 }, -- ⌜
        u = { 0, 0.5, 0.5, 0.5 }, -- ⌞
        i = { 0.5, 0.5, 0.5, 0.5 }, -- ⌟
        o = { 0.5, 0, 0.5, 0.5 }, -- ⌝
        -- Maximize
        p = function()
            hs.window.focusedWindow():maximize()
        end,
        -- Center
        [';'] = function()
            hs.window.focusedWindow():centerOnScreen()
        end,
    }, function(windowUnitOrFunction)
        local action = u.ternary(
            type(windowUnitOrFunction) == 'function',
            windowUnitOrFunction,
            function()
                hs.window.focusedWindow():moveToUnit(windowUnitOrFunction)
            end
        )

        return u.wrapModalExit(action)
    end)
)

u.bindHyperSubmodeActions(
    's',
    '[S]witch Apps',
    hs.fnutils.map({
        y = 'Youtube Music', -- [Y]outube Music
        u = { 'Calendar', 'Reminders', 'Mail' }, -- [U]tilities
        i = 'IntelliJ IDEA', -- [I]ntellij
        o = 'Obsidian', -- [O]bsidian
        p = 'NordPass', -- [P]asswords
        h = 'Hammerspoon', -- [H]ammerspoon
        j = 'Google Chrome', -- [J]avaScript
        k = 'Kitty', -- [K]itty
        [';'] = 'Docker Desktop', -- No mnemonic binding :)
        n = 'Finder', -- [N]avigation
        m = { 'Slack', 'Telegram' }, -- [M]essaging
        [','] = 'zoom.us', -- No mnemonic binding :)
        ['.'] = 'Microsoft Teams classic', -- No mnemonic binding :)
    }, function(appNameOrNames)
        if type(appNameOrNames) == 'string' then
            appNameOrNames = { appNameOrNames }
        end

        return u.wrapModalExit(function()
            u.focusOrCycleApps(appNameOrNames)
        end)
    end)
)

u.bindHyperSubmodeActions(
    'c',
    '[C]ontrols',
    hs.fnutils.map({
        h = 'PREVIOUS',
        j = 'SOUND_DOWN',
        k = 'SOUND_UP',
        l = 'NEXT',
        [';'] = function()
            u.sendSystemKey 'MUTE'
        end,
        u = 'BRIGHTNESS_DOWN',
        i = 'BRIGHTNESS_UP',
        o = 'FAST',
        y = 'REWIND',
        p = hs.caffeinate.lockScreen,
        ['.'] = function()
            u.sendSystemKey 'PLAY'
        end,
    }, function(systemKeyOrFunction)
        return u.ternary(
            type(systemKeyOrFunction) == 'function',
            u.wrapModalExit(systemKeyOrFunction),
            function()
                u.sendSystemKey(systemKeyOrFunction)
            end
        )
    end)
)

u.bindHyperSubmodeActions(
    'z',
    '[Z]ap Screen',
    hs.fnutils.map({
        u = { { 'cmd', 'shift' }, '3' },
        i = { { 'ctrl', 'cmd', 'shift' }, '3' },
        j = { { 'cmd', 'shift' }, '4' },
        k = { { 'ctrl', 'cmd', 'shift' }, '4' },
        o = { { 'cmd', 'shift' }, '5' },
    }, function(modsAndKey)
        return u.wrapModalExit(function()
            u.sendKey(modsAndKey[1], modsAndKey[2])
        end)
    end)
)

u.bindHyperSubmodeActions(
    'x',
    'E[x]ecute',
    hs.fnutils.map({
        k = function() -- [K]ill
            hs.application.frontmostApplication():kill()
        end,
        l = function() -- [L]oad Hammerspoon configuration
            hs.reload()
        end,
    }, function(action)
        return u.wrapModalExit(action)
    end)
)

--- Top level `Hyper` key bindings

local topLevelHyperBindings = {
    f = function() -- [F]ind Applications
        u.sendKey({ 'cmd' }, 'space')
    end,
}

for key, action in pairs(topLevelHyperBindings) do
    hs.hotkey.bind(u.HYPER, key, action)
end

hs.alert.show 'Configuration reloaded'
