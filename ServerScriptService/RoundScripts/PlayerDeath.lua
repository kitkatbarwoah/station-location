local replicatedStorage = game.ReplicatedStorage
local playerDeath = replicatedStorage.CharacterFires.PlayerDeath
local increaseTime = replicatedStorage.TimerFires.IncreaseTime
local prematurelyEndGame = replicatedStorage.TimerFires.PrematurelyEndGame

playerDeath.OnServerEvent:Connect(function(player)
	local inRound = player.PlayerAttributes.InRound
	local team = player.PlayerAttributes.Team
	
	inRound.Value = false
	if team.Value == "Survivor" then
		increaseTime:Fire(35)
	elseif team.Value == "Juggernaut" then
		prematurelyEndGame:Fire()
	end
	team.Value = "None"
end)
