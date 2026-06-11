local replicatedStorage = game.ReplicatedStorage
local pickTeams = replicatedStorage.TimerFires.PickTeams
local player = game.Players.LocalPlayer
local team = player.PlayerAttributes.Team
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local face = character:WaitForChild("Head"):WaitForChild("face")
local bodyColors = character:WaitForChild("Body Colors")

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

local survivorSpawn = game.Workspace:WaitForChild("Main Map"):WaitForChild("SurvivorSpawn")
local juggernautSpawn = game.Workspace:WaitForChild("Main Map"):WaitForChild("JuggernautSpawn")

character.Weapon.Handle.Transparency = 1
character.Bow.Handle.Transparency = 1
character.Hat.Handle.Transparency = 1
character.Hair.Handle.Transparency = 1

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
				bodyColors.TorsoColor3 = Color3.fromRGB(150, 44, 190)
				bodyColors.LeftLegColor3 = Color3.fromRGB(60, 14, 110)
				bodyColors.RightLegColor3 = Color3.fromRGB(60, 14, 110)
				face.Texture = "rbxassetid://83146247547038"
				character.Bow.Handle.Transparency = 0
			elseif equippedSurvivor.Value == "Doctor" then
				stamina.Value = 100
				health.Value = 80
				maxStamina.Value = 100
				maxHealth.Value = 80
				walkSpeed.Value = 12
				runSpeed.Value = 29
				cooldown2max.Value = 36
				cooldown3max.Value = 16
				bodyColors.TorsoColor3 = Color3.fromRGB(122, 222, 90)
				bodyColors.LeftLegColor3 = Color3.fromRGB(33, 122, 70)
				bodyColors.RightLegColor3 = Color3.fromRGB(33, 122, 70)
				face.Texture = "rbxassetid://110621746825104"
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
			bodyColors.TorsoColor3 = Color3.fromRGB(120, 45, 15)
			bodyColors.LeftLegColor3 = Color3.fromRGB(20, 25, 34)
			bodyColors.RightLegColor3 = Color3.fromRGB(20, 25, 34)
			character.Weapon.Handle.Transparency = 0
			character.Hat.Handle.Transparency = 0
			character.Hair.Handle.Transparency = 0
			face.Texture = "rbxassetid://111864759096914"
		end
		humanoid.WalkSpeed = walkSpeed.Value
	end
end)
