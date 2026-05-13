local userInputService = game:GetService("UserInputService")
local heartbeat = game:GetService("RunService").Heartbeat
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local replicatedStorage = game.ReplicatedStorage

local cooldown1 = player.PlayerAttributes.Cooldown1
local cooldown2 = player.PlayerAttributes.Cooldown2
local cooldown3 = player.PlayerAttributes.Cooldown3
local cooldown4 = player.PlayerAttributes.Cooldown4
local abilityRequest = replicatedStorage.CharacterFires.AbilityRequest

local hitbox = replicatedStorage.Hitboxes.Hitbox
local fragment = replicatedStorage.Assets.DebrisPiece

local walkSpeed = player.PlayerAttributes.WalkSpeed
local runSpeed = player.PlayerAttributes.RunSpeed
local stmDrain = player.PlayerAttributes.StaminaDrain
local updateSpeed = replicatedStorage.CharacterFires.UpdateSpeed

local colaSfx = script.Cola

local cooldownInterval = 1/60
local dmg = 0
local dmgDealt = false

local canUseAbility = false
local abilityReady = replicatedStorage.CharacterFires.AbilityReady
local inRound = player.PlayerAttributes.InRound
local intermission = replicatedStorage.TimerFires.BeginIntermission
local pickTeams = replicatedStorage.TimerFires.PickTeams
local triggerAnimation = replicatedStorage.CharacterFires.TriggerAnimation
local visualReduction = replicatedStorage.CharacterFires.VisualReduction

local team = player.PlayerAttributes.Team
local equippedSurvivor = player.PlayerAttributes.EquippedCharacterName
local equippedJuggernaut = player.PlayerAttributes.EquippedJuggernautName

local animation = Instance.new("Animation")
animation.AnimationId = ("rbxassetid://139451044141937")
local animTrack = humanoid:LoadAnimation(animation)
animTrack.Looped = false
animTrack.Priority = Enum.AnimationPriority.Action
animation.AnimationId = ("rbxassetid://75401893462085")
local animTrack2 = humanoid:LoadAnimation(animation)
animTrack2.Looped = false
animTrack2.Priority = Enum.AnimationPriority.Action
animation.AnimationId = ("rbxassetid://122050644953024")
local animTrack3 = humanoid:LoadAnimation(animation)
animTrack3.Looped = false
animTrack3.Priority = Enum.AnimationPriority.Action
animation.AnimationId = ("rbxassetid://133013490910372")
local animTrack4 = humanoid:LoadAnimation(animation)
animTrack4.Looped = false
animTrack4.Priority = Enum.AnimationPriority.Action

pickTeams.OnClientEvent:Connect(function()
	if inRound.Value == true then
		canUseAbility = true
	else
		canUseAbility = false
	end
end)

intermission.OnClientEvent:Connect(function()
	canUseAbility = false
end)

abilityReady.OnClientEvent:Connect(function(plr)
	--base amount of time guaranteed between all abilities
	if plr == player then
		task.wait(0.5)
		canUseAbility = true
	end
end)

triggerAnimation.OnClientEvent:Connect(function(plr, anim)
	if plr == player then
		if anim == "ButcherLanding" then
			animTrack4:Play()
		end
	end
end)

local function ability1()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			animTrack:Play()
		end
	end
end

local function ability2()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			animTrack2:Play()
		end
	elseif team.Value == "Survivor" then
		--[[if equippedSurvivor.Value == "Default" then
			cooldown2.Value = 40
			colaSfx:Play()

			--begin drinking
			walkSpeed.Value = 6
			runSpeed.Value = 14.5
			updateSpeed:Fire()
			task.wait(2)
			canUseAbility = true

			--initial speed boost
			walkSpeed.Value = 15.6
			runSpeed.Value = 37.7
			updateSpeed:Fire()
			task.wait(1.5)

			--lesser speed boost
			walkSpeed.Value = 13.2
			runSpeed.Value = 31.9
			updateSpeed:Fire()
			task.wait(5)

			--speed reset
			walkSpeed.Value = 12
			runSpeed.Value = 29
			updateSpeed:Fire()

		end]]
	end
end

local function ability3()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			animTrack3:Play()
		end
	elseif team.Value == "Survivor" then
		if equippedSurvivor.Value == "Default" then
			--[[cooldown3.Value = 35
			walkSpeed.Value = 2
			runSpeed.Value = 2
			updateSpeed:Fire()
			task.wait(0.7)
			for i = 1, 22 do
				local hitboxClone = hitbox:Clone()
				hitboxClone.Parent = workspace
				hitboxClone.Size = Vector3.new(5, 5, 5)
				hitboxClone.CFrame = humanoid.RootPart.CFrame
				hitboxClone.CFrame *= CFrame.new(0, 1, -3)
				hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
				hitboxClone.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") then
						--hit.Parent.Humanoid:TakeDamage(10)
					end
				end)
				task.wait(0.0167)
				hitboxClone:Destroy()
			end

			task.wait(0.3)
			canUseAbility = true

			walkSpeed.Value = 12
			runSpeed.Value = 29
			updateSpeed:Fire()]]
		end
	end
end

userInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and cooldown1.Value <= 0 and canUseAbility == true then
		canUseAbility = false
		abilityRequest:FireServer(1)
		ability1()
	elseif input.KeyCode == Enum.KeyCode.Q and cooldown2.Value <= 0 and canUseAbility == true then
		canUseAbility = false
		abilityRequest:FireServer(2)
		ability2()
	elseif input.KeyCode == Enum.KeyCode.E and cooldown3.Value <= 0  and canUseAbility == true then
		canUseAbility = false
		abilityRequest:FireServer(3)
		ability3()
	end
end)
