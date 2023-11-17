local M = {}

M.HYPER = { 'cmd', 'ctrl', 'alt', 'shift' }

---@param condition boolean
---@param ifTrue any
---@param ifFalse any
---@return any
function M.ternary(condition, ifTrue, ifFalse)
    if condition then
        return ifTrue
    else
        return ifFalse
    end
end

---@param functionToWrap function
---@return function
function M.wrapModalExit(functionToWrap)
    return function(modal)
        functionToWrap(modal)
        modal:exit()
    end
end

---@param alert string
function M.alert(alert)
    hs.alert.closeAll()
    hs.alert.show(alert)
end

---@param mods string[] | nil
---@param key string
function M.sendKey(mods, key)
    if mods == nil then
        mods = {}
    end

    hs.eventtap.keyStroke(mods, key)
end

---@param key string
function M.sendSystemKey(key)
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

---@param appName string
function M.focusOrCycleAppWindows(appName)
    local focusedWindow = hs.window.focusedWindow()

    -- If already focused, try to find the next window
    if focusedWindow and focusedWindow:application():name() == appName then
        local appWindows = hs.application.get(appName):allWindows()

        if #appWindows > 0 then
            -- It seems that this list order changes after one window get focused,
            -- let's directly bring the last one to focus every time
            appWindows[#appWindows]:focus()
        else
            -- This should not happen, but just in case
            hs.application.launchOrFocus(appName)
        end
    else
        -- If not focused
        hs.application.launchOrFocus(appName)
    end
end

---@param list string[]
---@param index number
---@return string
local function getFromListByIndexOrFirstItem(list, index)
    if index > #list then
        return list[1]
    else
        return list[index]
    end
end

---@param appNames string[]
function M.focusOrCycleDifferentApps(appNames)
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

---@param triggerKey string
---@param modeName string
---@param keysAndActions table<string, function>
---@return nil
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
