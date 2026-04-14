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

local survivorSpawn = game.Workspace:WaitForChild("SurvivorSpawn")
local juggernautSpawn = game.Workspace:WaitForChild("JuggernautSpawn")

pickTeams.OnClientEvent:Connect(function()
	if inRound.Value == true then
		if team.Value == "Survivor" then
			character:MoveTo(survivorSpawn.Position + Vector3.new(math.random(-3, 3), 5, math.random(-3, 3)))

			stamina.Value = 100
			health.Value = 100
			maxStamina.Value = 100
			maxHealth.Value = 100
			walkSpeed.Value = 12
			runSpeed.Value = 29

		elseif team.Value == "Juggernaut" then
			character:MoveTo(juggernautSpawn.Position + Vector3.new(math.random(-3, 3), 5, math.random(-3, 3)))
			
			stamina.Value = 120
			health.Value = 900
			maxStamina.Value = 120
			maxHealth.Value = 900
			walkSpeed.Value = 6
			runSpeed.Value = 32
			
		end
		humanoid.WalkSpeed = walkSpeed.Value
		print(team.Value)
	end
end)
