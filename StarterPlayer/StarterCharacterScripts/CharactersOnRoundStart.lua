local replicatedStorage = game.ReplicatedStorage
local pickTeams = replicatedStorage.TimerFires.PickTeams
local player = game.Players.LocalPlayer
local team = player.PlayerAttributes.Team
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local stamina = player.PlayerAttributes.Stamina
local health = player.PlayerAttributes.Health
local maxStamina = player.PlayerAttributes.MaxStamina
local maxHealth = player.PlayerAttributes.MaxHealth
local walkSpeed = player.PlayerAttributes.WalkSpeed
local runSpeed = player.PlayerAttributes.RunSpeed
local inRound = player.PlayerAttributes.InRound

local cooldown1max = player.PlayerAttributes.Cooldown1Max
local cooldown2max = player.PlayerAttributes.Cooldown2Max
local cooldown3max = player.PlayerAttributes.Cooldown3Max
local cooldown4max = player.PlayerAttributes.Cooldown4Max

local equippedSurvivor = player.PlayerAttributes.EquippedCharacterName
local equippedJuggernaut = player.PlayerAttributes.EquippedJuggernautName

local survivorSpawn = game.Workspace:WaitForChild("SurvivorSpawn")
local juggernautSpawn = game.Workspace:WaitForChild("JuggernautSpawn")

pickTeams.OnClientEvent:Connect(function()
	if inRound.Value == true then
		if team.Value == "Survivor" then
			character:MoveTo(survivorSpawn.Position + Vector3.new(math.random(-3, 3), 5, math.random(-3, 3)))
			if equippedSurvivor.Value == "Archer" then
				stamina.Value = 70
				health.Value = 90
				maxStamina.Value = 70
				maxHealth.Value = 90
				walkSpeed.Value = 13
				runSpeed.Value = 32
				cooldown2max.Value = 20
				cooldown3max.Value = 24
			elseif equippedSurvivor.Value == "Doctor" then
				stamina.Value = 100
				health.Value = 80
				maxStamina.Value = 100
				maxHealth.Value = 80
				walkSpeed.Value = 12
				runSpeed.Value = 29
				cooldown2max.Value = 36
				cooldown3max.Value = 16
			end
		elseif team.Value == "Juggernaut" then
			character:MoveTo(juggernautSpawn.Position + Vector3.new(math.random(-3, 3), 5, math.random(-3, 3)))
			stamina.Value = 120
			health.Value = 900
			maxStamina.Value = 120
			maxHealth.Value = 900
			walkSpeed.Value = 6
			runSpeed.Value = 33
			cooldown1max.Value = 1.5
			cooldown2max.Value = 15
			cooldown3max.Value = 12
			cooldown4max.Value = 20
		end
		humanoid.WalkSpeed = walkSpeed.Value
	end
end)
