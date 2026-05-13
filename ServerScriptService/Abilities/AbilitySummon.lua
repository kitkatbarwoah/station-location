local replicatedStorage = game.ReplicatedStorage
local abilityRequest = replicatedStorage.CharacterFires.AbilityRequest
local heartbeat = game:GetService("RunService").Heartbeat
local playerService = game:GetService("Players")

local animation = Instance.new("Animation")
local hitbox = replicatedStorage.Hitboxes.Hitbox
local fragment = replicatedStorage.Assets.DebrisPiece
local updateSpeed = replicatedStorage.CharacterFires.UpdateSpeed
local cooldownReduction = replicatedStorage.CharacterFires.CooldownReduction

local abilityStorage = require(replicatedStorage.ModuleScripts.AbilityStorage)

local cooldownInterval = 1/60
local targettedAbility = 0
local reduction = 0

cooldownReduction.Event:Connect(function(player, abilityno, cdreduction)
	targettedAbility = abilityno
	reduction = cdreduction
end)

abilityRequest.OnServerEvent:Connect(function(player, abilityno)
	--retrieve player data
	--local playerSettings = dataStoreService:GetDataStore("PlayerStats", "Settings")local character = player.Character or player.CharacterAdded:Wait()
	--local humanoid = player:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local stmDrain = player.PlayerAttributes.StaminaDrain
	local team = player.PlayerAttributes.Team
	local equippedSurvivor = player.PlayerAttributes.EquippedCharacterName
	local equippedJuggernaut = player.PlayerAttributes.EquippedJuggernautName
	local cooldown1 = player.PlayerAttributes.Cooldown1
	local cooldown2 = player.PlayerAttributes.Cooldown2
	local cooldown3 = player.PlayerAttributes.Cooldown3
	
	local dmg = 0
	local dmgDealt = false
	
	--initialize functions
	local function abilityCooldown(cd)
		if abilityno == 1 then
			while cd > 0 do
				heartbeat:Wait()
				cd -= 1/60
				if targettedAbility == 1 and reduction > 0 then
					cd -= reduction
					targettedAbility = 0
					reduction = 0
				end
				cooldown1.Value = cd
			end
		elseif abilityno == 2 then
			while cd > 0 do
				heartbeat:Wait()
				cd -= 1/60
				if targettedAbility == 2 and reduction > 0 then
					cd -= reduction
					targettedAbility = 0
					reduction = 0
				end
				cooldown2.Value = cd
			end
		elseif abilityno == 3 then
			while cd > 0 do
				heartbeat:Wait()
				cd -= 1/60
				if targettedAbility == 3 and reduction > 0 then
					cd -= reduction
					targettedAbility = 0
					reduction = 0
				end
				cooldown3.Value = cd
			end
		end
	end
	
	local function ability1()
		if team.Value == "Juggernaut" then
			if equippedJuggernaut.Value == "Butcher" then
				task.spawn(function() abilityCooldown(1.5) end)
				abilityStorage.genericM1(player, 1.5, 20, 0.25, 0.25)
			end
		end
	end
	
	local function ability2()
		if team.Value == "Juggernaut" then
			if equippedJuggernaut.Value == "Butcher" then
				task.spawn(function() abilityCooldown(15) end)
				abilityStorage.butcherLeap(player, 15, 25, 0.65, 10.5)
			end
		end
	end
	
	local function ability3()
		if team.Value == "Juggernaut" then
			if equippedJuggernaut.Value == "Butcher" then
				task.spawn(function() abilityCooldown(12) end)
				abilityStorage.butcherPin(player, 12, 15, 0.5, 4, 3)
			end
		end
	end
	
	if abilityno == 1 then
		ability1(player)
	elseif abilityno == 2 then
		ability2(player)
	elseif abilityno == 3 then
		ability3(player)
	end
	
end)
