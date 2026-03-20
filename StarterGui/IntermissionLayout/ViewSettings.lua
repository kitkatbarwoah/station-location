local gameSettings = script.Parent
local settingsMenu = gameSettings.SettingsMenu
local settingsButton = gameSettings.SettingsButton
local settingsTexts = settingsMenu.SettingsTexts
local settingsButtons = settingsMenu.SettingsButtons

local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local idTab = "Settings"
local guiFunctions = require(replicatedStorage.ModuleScripts.GuiFunctions)

local player = game.Players.LocalPlayer

local maliceGain = player.PlayerAttributes.MaliceGain
local afkMode = player.PlayerAttributes.AfkMode
local hitboxesEnabled = player.PlayerAttributes.HitboxesEnabled

local maliceButton = settingsButtons.MaliceCheck
local afkButton = settingsButtons.AfkCheck
local hitboxesButton = settingsButtons.HitboxesCheck

local afkIndicator = gameSettings.AfkIndicator

local inRound = player.PlayerAttributes.InRound

--local bass = settingsMenu.Bass

settingsMenu.Visible = false
settingsButton.Visible = true

round.OnClientEvent:Connect(function()
	task.wait(1)
	print("happens")
	if inRound.Value == true then
		settingsMenu.Visible = false
		settingsButton.Visible = false
		print("oh")
	end
end)

intermission.OnClientEvent:Connect(function()
	task.wait(1)
	settingsButton.Visible = true
end)

settingsButton.MouseButton1Click:Connect(function()
	if settingsMenu.Visible == false then
		guiFunctions.closeTabs(idTab)
	else
		guiFunctions.closeTabs(nil)
	end
end)

maliceButton.MouseButton1Click:Connect(function()
	if maliceGain.Value == true then
		maliceGain.Value = false
		maliceButton.Image = "rbxassetid://82700746510321"
	else
		maliceGain.Value = true
		maliceButton.Image = "rbxassetid://98354154174040"
	end
end)

afkButton.MouseButton1Click:Connect(function()
	if afkMode.Value == false then
		afkMode.Value = true
		afkButton.Image = "rbxassetid://82700746510321"
		afkIndicator.Visible = true
	else
		afkMode.Value = false
		afkButton.Image = "rbxassetid://98354154174040"
		afkIndicator.Visible = false
	end
end)

hitboxesButton.MouseButton1Click:Connect(function()
	if hitboxesEnabled.Value == false then
		hitboxesEnabled.Value = true
		hitboxesButton.Image = "rbxassetid://82700746510321"
	else
		hitboxesEnabled.Value = false
		hitboxesButton.Image = "rbxassetid://98354154174040"
	end
end)
