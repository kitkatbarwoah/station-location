local effect = script.Parent
local replicatedStorage = game.ReplicatedStorage
local round = replicatedStorage.TimerFires.BeginRound
local heartbeat = game:GetService("RunService").Heartbeat

local introLabel = effect.IntroLabel
local playerLabel = effect.PlayerLabel
local juggernautLabel = effect.JuggernautLabel
local selectedJuggernaut = replicatedStorage.ServerVariables.SelectedJuggernaut

round.OnClientEvent:Connect(function()
	effect.Visible = true
	effect.BackgroundTransparency = 1
	introLabel.TextTransparency = 1
	playerLabel.TextTransparency = 1
	juggernautLabel.TextTransparency = 1
	for i = 1, 20 do
		effect.BackgroundTransparency -= 0.05
		heartbeat:Wait()
	end
	task.wait(1)
	for i = 1, 20 do
		introLabel.TextTransparency -= 0.05
		heartbeat:Wait()
	end
	task.wait(1)
	playerLabel.Text = "(" .. selectedJuggernaut.Value .. ")"
	juggernautLabel.Text = "Butcher"
	for i = 1, 20 do
		playerLabel.TextTransparency -= 0.05
		juggernautLabel.TextTransparency -= 0.05
		heartbeat:Wait()
	end
	task.wait(1)
	for i = 1, 20 do
		effect.BackgroundTransparency += 0.05
		introLabel.TextTransparency += 0.05
		playerLabel.TextTransparency += 0.05
		juggernautLabel.TextTransparency += 0.05
		heartbeat:Wait()
	end
	task.wait(1)
	effect.Visible = false
end)
