local dataStoreService = game:GetService("DataStoreService")
local playerStats = dataStoreService:GetDataStore("PlayerStats")
local playerMalice = dataStoreService:GetDataStore("PlayerStats", "Malice")
local playerCurrency = dataStoreService:GetDataStore("PlayerStats", "Currency")
local playerSettings = dataStoreService:GetDataStore("PlayerStats", "Settings")

game.Players.PlayerAdded:Connect(function(player)
	
	local playerVar = Instance.new("Folder", player)
	playerVar.Name = "PlayerAttributes"
	playerVar.Parent = player
	
	--[[
	These are default values upon joining in game. Many of these attributes
	will be overwritten by most character archetypes upon joining a round.
	]]--
	
	local inRound = Instance.new("BoolValue", playerVar)
	inRound.Name = "InRound"
	inRound.Value = false
	
	local hp = Instance.new("NumberValue", playerVar)
	hp.Name = "Health"
	hp.Value = 100
	
	local maxHp = Instance.new("NumberValue", playerVar)
	maxHp.Name = "MaxHealth"
	maxHp.Value = 100
	
	local stm = Instance.new("NumberValue", playerVar)
	stm.Name = "Stamina"
	stm.Value = 100
	
	local maxStm = Instance.new("NumberValue", playerVar)
	maxStm.Name = "MaxStamina"
	maxStm.Value = 100
	
	local wlkSpd = Instance.new("NumberValue", playerVar)
	wlkSpd.Name = "WalkSpeed"
	wlkSpd.Value = 12
	
	local runSpd = Instance.new("NumberValue", playerVar)
	runSpd.Name = "RunSpeed"
	runSpd.Value = 29
	
	local stmDrain = Instance.new("BoolValue", playerVar)
	stmDrain.Name = "StaminaDrain"
	stmDrain.Value = true
	
	--[[
	Stats that will be saved across games
	]]--
	
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local money = Instance.new("IntValue", playerVar)
	money.Name = "Currency"
	money.Value = 0
	
	local malice = Instance.new("IntValue", playerVar)
	malice.Name = "Malice"
	malice.Value = 0
	
	--[[local success, currentMalice = pcall(function()
		return playerMalice:GetAsync(player.UserId)
	end)
	if success then
		malice.Value = currentMalice
	else
		malice.Value = 0
	end
	
	local success, currentCurrency = pcall(function()
		return playerCurrency:GetAsync(player.UserId)
	end)
	if success then
		money.Value = currentCurrency
	else
		money.Value = 0
	end]]
	
	local selected = Instance.new("StringValue", playerVar)
	selected.Name = "SelectedCharacter"
	selected.Value = "None"
	
	local selectedName = Instance.new("StringValue", playerVar)
	selectedName.Name = "SelectedCharacterName"
	selectedName.Value = "None"
	
	local equippedName = Instance.new("StringValue", playerVar)
	equippedName.Name = "EquippedCharacterName"
	equippedName.Value = "Default"
	
	local equippedJuggernaut = Instance.new("StringValue", playerVar)
	equippedJuggernaut.Name = "EquippedJuggernautName"
	equippedJuggernaut.Value = "Butcher"
	
	local team = Instance.new("StringValue", playerVar)
	team.Name = "Team"
	team.Value = "Lobby"
	
	local cooldown1 = Instance.new("NumberValue", playerVar)
	cooldown1.Name = "Cooldown1"
	cooldown1.Value = 0
	
	local cooldown2 = Instance.new("NumberValue", playerVar)
	cooldown2.Name = "Cooldown2"
	cooldown2.Value = 0
	
	local cooldown3 = Instance.new("NumberValue", playerVar)
	cooldown3.Name = "Cooldown3"
	cooldown3.Value = 0
	
	local cooldown4 = Instance.new("NumberValue", playerVar)
	cooldown4.Name = "Cooldown4"
	cooldown4.Value = 0
	
	local cooldown1max = Instance.new("NumberValue", playerVar)
	cooldown1max.Name = "Cooldown1Max"
	cooldown1max.Value = 1
	
	local cooldown2max = Instance.new("NumberValue", playerVar)
	cooldown2max.Name = "Cooldown2Max"
	cooldown2max.Value = 1
	
	local cooldown3max = Instance.new("NumberValue", playerVar)
	cooldown3max.Name = "Cooldown3Max"
	cooldown3max.Value = 1
	
	local cooldown4max = Instance.new("NumberValue", playerVar)
	cooldown4max.Name = "Cooldown4Max"
	cooldown4max.Value = 1
	
	--settings
	
	local maliceGain = Instance.new("BoolValue", playerVar)
	maliceGain.Name = "MaliceGain"
	maliceGain.Value = true
	
	local afkMode = Instance.new("BoolValue", playerVar)
	afkMode.Name = "AfkMode"
	afkMode.Value = false
	
	local hitboxesEnabled = Instance.new("BoolValue", playerVar)
	hitboxesEnabled.Name = "HitboxesEnabled"
	hitboxesEnabled.Value = false
	
	--player position
	local charPosition = Instance.new("Vector3Value", playerVar)
	charPosition.Name = "CharPosition"
	charPosition.Value = Vector3.new(0, 0, 0)
	
	--[[local settingsArray = Instance.new("BoolValue", playerVar)
	settingsArray.Name = "SettingsArray"
	settingsArray.Value = {true, false, false}]]
	
	--[[local success, currentSettings = pcall(function()
		return playerSettings:GetAsync(player.UserID)
	end)
	if success then
		settingsArray = currentSettings
	else
		settingsArray = {true, false, false}
	end]]
	
end)
