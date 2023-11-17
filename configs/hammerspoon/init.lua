local utils = require("utils")

local function focusApp(appName)
	return function()
		utils.focusApp(appName)
	end
end

local function toggleApp(appName)
	return function()
		utils.toggleApp(appName)
	end
end

local function weakFocus(appName)
	return function()
		utils.weakFocus(appName)
	end
end

hs.hotkey.bind({'command'}, 'escape', toggleApp("Alacritty"))
hs.hotkey.bind({ 'command', 'ctrl' }, 's', focusApp("Spotify"))
