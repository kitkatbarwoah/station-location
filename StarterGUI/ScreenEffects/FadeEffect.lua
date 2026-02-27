local effect = script.Parent
local replicatedStorage = game.ReplicatedStorage
local round = replicatedStorage.TimerFires.BeginRound

round.OnClientEvent:Connect(function()
	effect.Visible = true
	effect.BackgroundTransparency = 1
	for i = 1, 20 do
		effect.BackgroundTransparency -= 0.05
		task.wait(0.01)
	end
	task.wait(1)
	for i = 1, 20 do
		effect.BackgroundTransparency += 0.05
		task.wait(0.01)
	end
	task.wait(1)
	effect.Visible = false
end)
