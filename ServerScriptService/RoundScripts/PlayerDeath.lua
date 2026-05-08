local replicatedStorage = game.ReplicatedStorage
local playerDeath = replicatedStorage.CharacterFires.PlayerDeath
local increaseTime = replicatedStorage.TimerFires.IncreaseTime
local prematurelyEndGame = replicatedStorage.TimerFires.PrematurelyEndGame
local player = game.Players.LocalPlayer
local quota = replicatedStorage.ServerVariables.Quota
local quotaProgress = replicatedStorage.ServerVariables.QuotaProgress

local juggernautPosition = game.ReplicatedStorage.ServerVariables.JuggernautPosition

playerDeath.OnServerEvent:Connect(function(player)
	local inRound = player.PlayerAttributes.InRound
	local team = player.PlayerAttributes.Team
	
	inRound.Value = false
	if team.Value == "Survivor" then
		if (player.PlayerAttributes.CharPosition - juggernautPosition.Value).Magnitude < 150 then
			quotaProgress.Value += 1
			if quota.Value == quotaProgress.Value then
				prematurelyEndGame:Fire("JuggernautWin")
			else
				increaseTime:Fire(35)
			end
		else
			quota *= math.round(((3/2) - 1) * 2/3)
		end
	elseif team.Value == "Juggernaut" then
		prematurelyEndGame:Fire("SurvivorWin")
	end
	team.Value = "None"
end)
