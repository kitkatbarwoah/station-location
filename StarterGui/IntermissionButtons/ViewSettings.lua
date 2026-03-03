local settings = script.Parent
local settingsMenu = settings.SettingsMenu
local settingsButton = settings.SettingsButton

local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

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
		settingsMenu.Visible = true
	else
		settingsMenu.Visible = false
	end
end)
