--[==[
my hs init config
refer to awesome-hammerspoon
updated: 20220125
--]==]

local obj = {}
-- obj.__index = obj

obj._metadata = {
    name = 'my hs init config',
    version = '1.0',
    author = '',
    homepage = '',
    license = 'MIT - https://opensource.org/licenses/MIT',
    created = '20220122'
}

obj.logger = hs.logger.new('MyHSConfig')
-- obj.spoonPath = hs.spoons.scriptPath()
obj.modifier_map = {
    cmd = '⌘',
    ctrl = '⌃',
    alt = '⌥',
    shift = '⇧',
 }
obj.appSearchPaths = {
    "/Applications",
    "/System/Applications",
    "~/Applications",
    "/Developer/Applications",
    "/Applications/Xcode.app/Contents/Applications",
    "/System/Library/PreferencePanes",
    "/Library/PreferencePanes",
    "~/Library/PreferencePanes",
    "/System/Library/CoreServices/Applications",
    "/System/Library/CoreServices/",
    "/usr/local/Cellar",
    "/Library/Scripts",
    "~/Library/Scripts"
 }

obj.cfg = {
    autoReloadConfig = true,
    enable_clock = true,
    enable_whints = false,
    key_map = {
        supervisor = {{'cmd', 'shift', 'ctrl'}, 'q'},
        reloadConfiguration = {{'cmd', 'shift'}, 'r'},
        help = {'alt', 'h'},
        noFnMate = {'alt', 'v'},
        windowHints = {'alt', 'tab'},
        appLauncher = {'alt', 'a'},
        myClock = {'alt', 't'},
        KSheet = {'alt', 's'},
        WinWin = {'alt', 'w'},
        CountDown = {'alt', 'j'},
        ClipboardTool = {'alt', 'p'},
    },
    app_map = {
        a = 'App Store',
        c = 'Visual Studio Code',
        d = 'TickTick',
        e = 'Microsoft Edge',
        f = 'Finder',
        g = 'Google Chrome',
        h = 'Hammerspoon',
        m = 'Mail',
        n = 'Notion',
        p = 'System Preferences',
        q = 'QQ',
        r = 'Reminders',
        s = 'Safari',
        t = 'Terminal',
        v = 'MacVim',
        w = 'WPS Office',
        x = 'XMind',
    },
    spoons = {
        'SPoonInstall',
        'KSheet',
        -- 'Calendar',
        -- 'HCalendar',
        -- 'ClipboardTool',
        'WinWin',
        -- 'CountDown',
        -- 'FnMate',
    },
}

obj.activated_keys = {}

---- supervisor
function obj:newModal(id, keys)
    local cmodal = hs.hotkey.modal.new()
    cmodal:bind('', 'escape', string.format('Deactivate %s mode', id), function() 
        obj:deactivateModal(id) 
    end)
    cmodal:bind('', 'q', string.format('Deactivate %s mode', id), function()
        obj:deactivateModal(id) 
    end)
    -- function cmodal:entered() hs.alert.show(string.format('Entered  %s mode', id)) end
    -- function cmodal:exited()  hs.alert.show(string.format('Entered  %s mode', id))  end
    if keys then
        obj.supervisor:bind(keys[1], keys[2], string.format('Enter %s mode', id), function()
            obj:deactivateAllModal()
            obj:activateModal(id, obj.trayColor)
        end)
    end
    obj.modal_map[id] = cmodal
    return obj.modal_map[id]
end

function obj:activateModal(id, trayColor, showKeys)
    obj.modal_map[id]:enter()
    obj.activate_map[id] = obj.modal_map[id]
    
    if trayColor then
        local cscreen = hs.screen.mainScreen()
        local cres = cscreen:fullFrame()
        local lcres = cscreen:absoluteToLocal(cres)
        obj.modal_tray:frame(cscreen:localToAbsolute{
            x = cres.w - 40,
            y = cres.h - 40,
            w = 20,
            h = 20
        })
        if type(trayColor) ~= 'string' then trayColor = obj.trayColor end 
        obj.modal_tray[1].fillColor = {hex = trayColor, alpha = 0.7}
        obj.modal_tray:show()
    end
end

function obj:deactivateModal(id)
    obj.modal_map[id]:exit()
    obj.activate_map[id] = nil
    
    obj.modal_tray:hide()
end

function obj:deactivateAllModal()
    for k, v in pairs(obj.activate_map) do
        obj:deactivateModal(k)
    end
end
--- functions & setups
local function setupReloadConfig()
    local function notifyAndReload()
        hs.notify.new({title="Hammerspoon", informativeText="Config reloaded."}):send()
        hs.reload() 
    end
    local k = 'reloadConfiguration'
    hs.hotkey.bind(obj.key_map[k][1], obj.key_map[k][2], 'Reload Configuration', notifyAndReload)
    obj.activated_keys[k] = obj.key_map[k]
    if obj.autoReloadConfig then
        obj.cfg_watcher = hs.pathwatcher.new(hs.configdir, notifyAndReload):start()
    end
end

local function setupAppLauncher()
    local k = 'appLauncher'
    local cmodal = obj:newModal(k, obj.key_map[k])
    obj.activated_keys[k] = obj.key_map[k]
    for key, app in pairs(obj.app_map) do
        cmodal:bind('', key, function()
            hs.application.launchOrFocus(app)
        end)
    end
end

local function setupWindowHints()
    if obj.enable_whints then
        local k = 'windowHints'
        obj.supervisor:bind(obj.key_map[k][1], obj.key_map[k][2], 'Show Window Hints', function()
            obj:deactivateAllModal()
            hs.hints.windowHints()
        end)
        obj.activated_keys[k] = obj.key_map[k]
    end
end

local function toggleHelp()
    if obj.hcanvas and obj.hcanvas:isShowing() then
        obj.hcanvas:hide()
    else
        local mainRes = hs.screen.primaryScreen():fullFrame()
        obj.hcanvas = obj.hcanvas or hs.canvas.new({x=(mainRes.w-600)/2, y=(mainRes.h-500)/2, w=600, h=500}):appendElements(
            {
                type = "rectangle",
                action = "fill",
                fillColor = {hex = "#EEEEEE", alpha = 0.95},
                roundedRectRadii = {xRadius = 10, yRadius = 10},
            },
            {
                type = 'text',
                text = hs.inspect(obj.activated_keys) .. '\n\n 😄',
                textSize = 26,
                textColor = {hex = "#2390FF", alpha = 1},
                textAlignment = 'left',
            }
        )
        obj.hcanvas:show()
    end
end

local function setupHelp()
    local k = 'help'
    obj.supervisor:bind(obj.key_map[k][1], obj.key_map[k][2], 'toggle help', toggleHelp)
    obj.activated_keys[k] = obj.key_map[k]
end

local function toggleClock(bool)
    -- if running
    if obj.ctimer and obj.ctimer:running() then
        if not bool then
            obj.ctimer:stop()
            obj.ctimer = nil
            obj.ccanvas:hide()
        end
    elseif bool ~= false then
        local mainRes = hs.screen.primaryScreen():fullFrame()
        obj.ccanvas = obj.ccanvas or hs.canvas.new({x=10, y=mainRes.h - 60, w=300, h=60}):appendElements(
            {
                type = 'text',
                text = os.date('%H:%M'),
                textSize = 40,
                textColor = {hex='#1891C3'},
                textAlignment = 'left',
            }
        )
        obj.ccanvas:bringToFront(true)
        obj.ccanvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
        obj.ccanvas:show()
        obj.ctimer = hs.timer.doEvery(20, function() obj.ccanvas[1].text = os.date('%H:%M') end)
    end
end

local function setupClock()
    if obj.enable_clock then
        local k = 'myClock'
        obj.supervisor:bind(obj.key_map[k][1], obj.key_map[k][2], 'Toggle Clock', function() 
            toggleClock() 
        end)
        obj.activated_keys[k] = obj.key_map[k]
        toggleClock()
    end
end

local function toggleNoFnMate(bool)
    local function catcher(event)
        if event:getCharacters() == "h" then
            return true, {hs.eventtap.event.newKeyEvent({}, "left", true)}
        elseif event:getCharacters() == "l" then
            return true, {hs.eventtap.event.newKeyEvent({}, "right", true)}
        elseif event:getCharacters() == "j" then
            return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
        elseif event:getCharacters() == "k" then
            return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}
        elseif event:getCharacters() == "y" then
            return true, {hs.eventtap.event.newScrollEvent({3, 0}, {}, "line")}
        elseif event:getCharacters() == "o" then
            return true, {hs.eventtap.event.newScrollEvent({-3, 0}, {}, "line")}
        elseif event:getCharacters() == "u" then
            return true, {hs.eventtap.event.newScrollEvent({0, -10}, {}, "line")}
        elseif event:getCharacters() == "i" then
            return true, {hs.eventtap.event.newScrollEvent({0, 10}, {}, "line")}
        elseif event:getCharacters() == "," then
            local currentpos = hs.mouse.getAbsolutePosition()
            return true, {hs.eventtap.leftClick(currentpos)}
        elseif event:getCharacters() == "." then
            local currentpos = hs.mouse.getAbsolutePosition()
            return true, {hs.eventtap.rightClick(currentpos)}
        end
    end

    if obj.nofn_tapper and obj.nofn_tapper:isEnabled() then
        if not bool then
            obj.nofn_tapper:stop()
        end
    elseif bool ~= false then
        obj.nofn_tapper = obj.nofn_tapper or hs.eventtap.new({hs.eventtap.event.types.keyDown}, catcher)
        obj.nofn_tapper:start()
    end
end

local function setupNoFnMate()
    local k = 'noFnMate'
    local cmodal = obj:newModal(k, obj.key_map[k])
    cmodal:bind('', 'escape', 'Deactivate noFnMate mode', function()
        toggleNoFnMate(false)
        obj:deactivateModal(k)
    end)
    cmodal:bind('', 'q', 'Deactivate noFnMate mode', function()
        toggleNoFnMate(false)
        obj:deactivateModal(k)
    end)
    obj.supervisor:bind(obj.key_map[k][1], obj.key_map[k][2], 'Enter noFnMate mode', function()
        obj:deactivateAllModal()
        obj:activateModal(k, true)
        toggleNoFnMate(true)
    end)
    obj.activated_keys[k] = obj.key_map[k]
end

local function setupKSheet()
    local k = 'KSheet'
    local cmodal = obj:newModal(k)
    cmodal:bind('', 'escape', 'Deactivate KSheet mode', function()
        spoon.KSheet:hide()
        obj:deactivateModal(k)
    end)
    cmodal:bind('', 'q', 'Deactivate KSheet mode', function()
        spoon.KSheet:hide()
        obj:deactivateModal(k)
    end)
    obj.supervisor:bind(obj.key_map[k][1], obj.key_map[k][2], 'Enter KSheet mode', function()
        spoon.KSheet:show()
        obj:deactivateAllModal()
        obj:activateModal(k)
    end)
    obj.activated_keys[k] = obj.key_map[k]
end

local function setupWinWin()
    local k = 'WinWin'
    local cmodal = obj:newModal(k, obj.key_map[k])
    cmodal:bind('', 'left', 'Lefthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end)
    cmodal:bind('', 'right', 'Righthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end)
    cmodal:bind('', 'up', 'Uphalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfup") end)
    cmodal:bind('', 'down', 'Downhalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfdown") end)
    cmodal:bind('ctrl+alt', 'left', 'NorthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNW") end)
    cmodal:bind('ctrl+alt', 'right', 'NorthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNE") end)
    cmodal:bind('ctrl+alt+shift', 'left', 'SouthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSW") end)
    cmodal:bind('ctrl+alt+shift', 'right', 'SouthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSE") end)
    cmodal:bind('', 'h', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
    cmodal:bind('', 'l', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
    cmodal:bind('', 'k', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
    cmodal:bind('', 'j', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)
    cmodal:bind('shift', 'H', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
    cmodal:bind('shift', 'L', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
    cmodal:bind('shift', 'K', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
    cmodal:bind('shift', 'J', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)
    cmodal:bind('', 'F', 'Fullscreen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end)
    -- cmodal:bind('', 'M', 'Maximize', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("maximize") end)
    -- cmodal:bind('', 'N', 'Minimize', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("minimize") end)
    cmodal:bind('', 'C', 'Center Window', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("center") end)
    cmodal:bind('', '=', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
    cmodal:bind('', '-', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)
    -- cmodal:bind('ctrl+cmd', 'left', 'Move to Left Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("left") end)
    -- cmodal:bind('ctrl+cmd', 'right', 'Move to Right Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("right") end)
    -- cmodal:bind('ctrl+cmd', 'up', 'Move to Above Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("up") end)
    -- cmodal:bind('ctrl+cmd', 'down', 'Move to Below Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("down") end)
    -- cmodal:bind('ctrl+cmd', 'space', 'Move to Next Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("next") end)
    cmodal:bind('', 'u', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
    cmodal:bind('shift', 'u', 'Redo Window Manipulation', function() spoon.WinWin:redo() end)
    cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)

    obj.activated_keys[k] = obj.key_map[k]
end

local function setupClipboardTool()
    spoon.ClipboardTool:bindHotkeys({toggle_clipboard = obj.key_map['ClipboardTool']})
    spoon.ClipboardTool:start()

    obj.activated_keys[k] = obj.key_map[k]
end

function obj:init()
    for k,v in pairs(obj._metadata) do obj[k] = v end
    for k,v in pairs(obj.cfg) do obj[k] = v end

    obj.modal_map = {}
    obj.activate_map = {}

    obj.supervisor = hs.hotkey.modal.new(
        obj.key_map['supervisor'][1], 
        obj.key_map['supervisor'][2], 
        'Initialize Modal Environment')
    obj.supervisor:bind(
        obj.key_map['supervisor'][1], 
        obj.key_map['supervisor'][2], 
        'Reset Modal Environment', 
        function() obj.supervisor:exit() end
    )
    -- 
    obj.trayColor = "#FFBD2E"
    obj.modal_tray = hs.canvas.new({x = 0, y = 0, w = 0, h = 0})
    obj.modal_tray:level(hs.canvas.windowLevels.tornOffMenu)
    obj.modal_tray[1] = {
        type = "circle",
        action = "fill",
        fillColor = {hex = "#FFFFFF", alpha = 0.7},
    }

    if obj.spoons then
        for _,v in ipairs(obj.spoons) do hs.loadSpoon(v) end
    end
    return self
end

function obj:start()
    setupHelp()
    -- reload config
    setupReloadConfig()
    -- app launcher mode
    setupAppLauncher()
    -- windowHints
    setupWindowHints()
    -- clock
    setupClock()
    --
    setupNoFnMate()
    -- KSheet mode
    if spoon.KSheet then setupKSheet() end
    -- WinWin
    if spoon.WinWin then setupWinWin() end
    -- ClipboardTool
    if spoon.ClipboardTool then setupClipboardTool() end
    -- finally enter supervisor
    obj.supervisor:enter()
    return self
end

function obj:stop()
    if obj.cfg_watcher then obj.cfg_watcher:stop() end
    if obj.enable_clock then obj:toggleClock(false) end
    if obj.nofn_tapper then obj.nofn_tapper:stop() end

    obj.supervisor:exit()
    return self
end

function obj:bindHotkeys(mapping)
    local def = {}
    for action, key in pairs(mapping) do
        if action == 'reloadConfiguration' then
            def.reloadConfiguration = hs.fnutils.partial(hs.reload, self)
        else
            self.logger.ef("Invalid hotkey action '%s'", action)
        end
    end
    -- hs.spoons.bindHotkeysToSpec(def, mapping)
    return self
end

---- begin
obj:init():start()
-- hs.alert.show(hs.inspect(obj), 5)

return obj
