game.Players.PlayerAdded:Connect(function(player)
	
	local playerVar = Instance.new("Folder", player)
	playerVar.Name = "PlayerAttributes"
	
	--[[
	These are default values upon joining in game. Many of these attributes
	will be overwritten by most character archetypes upon joining a round.
	]]--
	
	local inRound = Instance.new("BoolValue", playerVar)
	inRound.Name = "InRound"
	inRound.Value = false
	
	local hp = Instance.new("IntValue", playerVar)
	hp.Name = "Health"
	hp.Value = 100
	
	local maxHp = Instance.new("IntValue", playerVar)
	maxHp.Name = "MaxHealth"
	maxHp.Value = 100
	
	local stm = Instance.new("IntValue", playerVar)
	stm.Name = "Stamina"
	stm.Value = 100
	
	local maxStm = Instance.new("IntValue", playerVar)
	maxStm.Name = "MaxStamina"
	maxStm.Value = 100
	
	local wlkSpd = Instance.new("IntValue", playerVar)
	wlkSpd.Name = "WalkSpeed"
	wlkSpd.Value = 10
	
	local runSpd = Instance.new("IntValue", playerVar)
	runSpd.Name = "RunSpeed"
	runSpd.Value = 26
	
end)
