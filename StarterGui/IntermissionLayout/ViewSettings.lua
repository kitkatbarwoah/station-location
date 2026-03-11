local gameSettings = script.Parent
local settingsMenu = gameSettings.SettingsMenu
local settingsButton = gameSettings.SettingsButton

local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local idTab = "Settings"
local guiFunctions = require(replicatedStorage.ModuleScripts.GuiFunctions)

local player = game.Players.LocalPlayer

settingsMenu.Visible = false
settingsButton.Visible = true

round.OnClientEvent:Connect(function()
	settingsMenu.Visible = false
	settingsButton.Visible = false
end)

intermission.OnClientEvent:Connect(function()
	settingsButton.Visible = true
end)

settingsButton.MouseButton1Click:Connect(function()
	if settingsMenu.Visible == false then
		guiFunctions.closeTabs(idTab)
	else
		guiFunctions.closeTabs(nil)
	end
end)
