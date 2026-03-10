local module = {}

local player = game.Players.LocalPlayer

local selection = player.PlayerGui.IntermissionButtons.IntermissionLayout.Selection
local selectionMenu = selection.SelectionMenu
local selectionDisplay = selection.SelectionDisplay
local selectionInformation = selection.SelectionInformation

local gameSettings = player.PlayerGui.IntermissionButtons.IntermissionLayout.Settings
local settingsMenu = gameSettings.SettingsMenu

function module.closeTabs(openedTab)
	selectionMenu.Visible = false
	selectionDisplay.Visible = false
	selectionInformation.Visible = false
	settingsMenu.Visible = false
	if openedTab == "Settings" then
		settingsMenu.Visible = true
	elseif openedTab == "Selection" then
		selectionMenu.Visible = true
		selectionDisplay.Visible = true
	end
	
end

return module
