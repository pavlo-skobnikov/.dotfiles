local M = {}

M.HYPER = { 'cmd', 'ctrl', 'alt', 'shift' }

function M.ternary(condition, ifTrue, ifFalse)
    if condition then
        return ifTrue
    else
        return ifFalse
    end
end

function M.wrapModalExit(functionToWrap)
    return function(modal)
        functionToWrap(modal)
        modal:exit()
    end
end

function M.alert(alert)
    hs.alert.closeAll()
    hs.alert.show(alert)
end

function M.sendKey(mods, key)
    if mods == nil then
        mods = {}
    end

    hs.eventtap.keyStroke(mods, key)
end

function M.sendSystemKey(key)
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

local function getFromListByIndexOrFirstItem(list, index)
    if index > #list then
        return list[1]
    else
        return list[index]
    end
end

function M.focusOrCycleApps(appNames)
    local focusedWindow = hs.window.focusedWindow()

    local focusedWindowName = focusedWindow:application():name()

    -- If the focused window is in the application list,
    -- then launch or focus the next one
    if hs.fnutils.contains(appNames, focusedWindowName) then
        local focusedWindowIndex = hs.fnutils.indexOf(appNames, focusedWindowName)

        local nextWindowName = getFromListByIndexOrFirstItem(appNames, focusedWindowIndex + 1)
        hs.application.launchOrFocus(nextWindowName)
    else
        -- If not focused, launch or focus the first application
        -- from the list
        hs.application.launchOrFocus(appNames[1])
    end
end

function M.bindHyperSubmodeActions(triggerKey, modeName, keysAndActions)
    local modal = hs.hotkey.modal.new(M.HYPER, triggerKey)

    for key, actionSupplier in pairs(keysAndActions) do
        modal:bind('', key, function()
            actionSupplier(modal)
        end)
    end

    modal:bind('', 'escape', function()
        M.alert('Exiting ' .. modeName .. ' mode')
        modal:exit()
    end)
end

return M
