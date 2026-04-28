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

local hitbox = replicatedStorage.Hitboxes.Hitbox
local fragment = replicatedStorage.Assets.DebrisPiece

local walkSpeed = player.PlayerAttributes.WalkSpeed
local runSpeed = player.PlayerAttributes.RunSpeed
local stmDrain = player.PlayerAttributes.StaminaDrain
local updateSpeed = replicatedStorage.LocalFires.UpdateSpeed

local colaSfx = script.Cola

local cooldownInterval = 1/60
local dmg = 0
local dmgDealt = false

local canUseAbility = false
local conclude = false
local inRound = player.PlayerAttributes.InRound
local intermission = replicatedStorage.TimerFires.BeginIntermission
local pickTeams = replicatedStorage.TimerFires.PickTeams

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

local function ability1()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			cooldown1.Value = 1.5
			dmg = 20
			dmgDealt = false
			animTrack:Play()
			task.wait(0.25)
			for i = 1, 20 do
				local hitboxClone = hitbox:Clone()
				hitboxClone.Parent = workspace
				hitboxClone.Size = Vector3.new(7, 6, 6)
				hitboxClone.CFrame = humanoid.RootPart.CFrame
				hitboxClone.CFrame *= CFrame.new(0, 1, -4.5)
				hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
				hitboxClone.Touched:Connect(function(hit)
					local hitboxContacts = hitboxClone:GetTouchingParts()
					for _, contact in ipairs(hitboxContacts) do
						if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") and dmgDealt == false then
							dmgDealt = false
							contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
							dmg = 0
							dmgDealt = true
						end
					end
				end)
				heartbeat:Wait()
				hitboxClone:Destroy()
			end
			task.wait(0.2)
			canUseAbility = true
		end
	end
end

local function ability2()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			cooldown2.Value = 15
			dmg = 25
			walkSpeed.Value = 0.01
			runSpeed.Value = 0.01
			updateSpeed:Fire()
			animTrack2:Play()
			task.wait(0.65)
			local initialDirection = humanoid.RootPart.CFrame.LookVector * Vector3.new(0.4, 0, 0.4)
			local i = 0

			stmDrain.Value = false
			while humanoid.FloorMaterial == Enum.Material.Air or i < 10 do
				character:PivotTo(character:GetPivot() + initialDirection * 6 + Vector3.new(0, (-i+40)/13, 0))
				local hitboxClone = hitbox:Clone()
				hitboxClone.Parent = workspace
				hitboxClone.Size = Vector3.new(8, 9, 12)
				hitboxClone.CFrame = humanoid.RootPart.CFrame
				hitboxClone.CFrame *= CFrame.new(0, 0, 0)
				hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
				hitboxClone.Touched:Connect(function(hit)
					local hitboxContacts = hitboxClone:GetTouchingParts()
					for _, contact in ipairs(hitboxContacts) do
						if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") and dmgDealt == false then
							dmgDealt = false
							contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
							dmg = 0
							dmgDealt = true
						end
					end
				end)
				heartbeat:Wait()
				hitboxClone:Destroy()
				i += 1
			end
			
			for j = 1, math.random(10, 15) do
				local fragmentClone = fragment:Clone()
				fragmentClone.Parent = workspace
				local fragmentSize = math.random(3, 13)/10
				fragmentClone.Size = Vector3.new(fragmentSize, fragmentSize, fragmentSize)
				fragmentClone.CFrame = humanoid.RootPart.CFrame
				fragmentClone.CFrame *= CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
				fragmentClone.CFrame *= CFrame.new(math.random(-9, 9), -4, math.random(-9, 9))
				fragment.AssemblyLinearVelocity = Vector3.new(math.random(-50, 50), math.random(35, 75), math.random(-50, 50))
				fragment.AssemblyAngularVelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
				task.delay(0.25, function()
					fragmentClone.CanCollide = true
					task.wait(1)
					for k = 1, 30 do
						fragmentClone.Transparency = (k)/30
						heartbeat:Wait()
					end
					fragmentClone:Destroy()
				end)
			end
			
			animTrack4:Play()
			
			dmg = 25
			dmgDealt = false
			
			for j = 1, 6 do
				local hitboxClone = hitbox:Clone()
				hitboxClone.Parent = workspace
				hitboxClone.Size = Vector3.new(18, 6, 18)
				hitboxClone.CFrame = humanoid.RootPart.CFrame
				hitboxClone.CFrame *= CFrame.new(0, -1, 0)
				hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
				hitboxClone.Touched:Connect(function(hit)
					local hitboxContacts = hitboxClone:GetTouchingParts()
					for _, contact in ipairs(hitboxContacts) do
						if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") and dmgDealt == false then
							dmgDealt = false
							contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
							dmg = 0
							dmgDealt = true
						end
					end
				end)
				heartbeat:Wait()
				hitboxClone:Destroy()
			end
			stmDrain.Value = true
			
			task.wait(2.5)
			canUseAbility = true

			walkSpeed.Value = 6
			runSpeed.Value = 33
			updateSpeed:Fire()

		end
	elseif team.Value == "Survivor" then
		if equippedSurvivor.Value == "Default" then
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

		end
	end
end

local function ability3()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			cooldown3.Value = 12
			dmg = 15
			walkSpeed.Value = 2
			runSpeed.Value = 9
			updateSpeed:Fire()
			animTrack3:Play()
			task.wait(0.5)
			character.Weapon.Handle.Transparency = 1
			local originalCFrame = humanoid.RootPart.CFrame
			local projectileDestroyed = false

			for i = 1, 120 do
				if i == 20 then
					walkSpeed.Value = 6
					runSpeed.Value = 33
					updateSpeed:Fire()
					canUseAbility = true

				end
				if i >= 20 and i < 40 then
					character.Weapon.Handle.Transparency = 1 - ((i - 20) * 0.05)
				end
				local hitboxClone = hitbox:Clone()
				local swordClone = replicatedStorage.Assets["Butcher Sword"]:Clone()
				swordClone.Parent = hitboxClone
				swordClone.CFrame = originalCFrame
				swordClone.CFrame *= CFrame.new(0, 1, -4.5 - (i*1.25))
				swordClone.CFrame *= CFrame.Angles(i * -0.4, 0, 0)
				swordClone.Transparency = 0
				hitboxClone.Parent = workspace
				hitboxClone.Size = Vector3.new(4, 4, 4)
				hitboxClone.CFrame = originalCFrame
				hitboxClone.CFrame *= CFrame.new(0, 1, -4.5 - (i*1.25))
				hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
				hitboxClone.Touched:Connect(function(hit)
					local hitboxContacts = hitboxClone:GetTouchingParts()
					for _, contact in ipairs(hitboxContacts) do
						if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") and dmgDealt == false then
							dmgDealt = false
							contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
							dmg = 0
							dmgDealt = true
							
							--damage effect
							for j = 1, math.random(3, 6) do
								local fragmentClone = fragment:Clone()
								fragmentClone.Parent = workspace
								local fragmentSize = math.random(2, 5)/10
								fragmentClone.Size = Vector3.new(fragmentSize, fragmentSize, fragmentSize)
								fragmentClone.BrickColor = BrickColor.new("Bright red")
								fragmentClone.CFrame = contact.Parent:FindFirstChild("Humanoid").RootPart.CFrame
								fragmentClone.CFrame *= CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
								fragmentClone.CFrame *= CFrame.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
								fragment.AssemblyLinearVelocity = Vector3.new(math.random(-15, 15), math.random(25, 65), math.random(-15, 15))
								fragment.AssemblyAngularVelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
								task.delay(0.25, function()
									fragmentClone.CanCollide = true
									task.wait(1)
									for k = 1, 30 do
										fragmentClone.Transparency = (k)/30
										heartbeat:Wait()
									end
									fragmentClone:Destroy()
								end)
							end
						end
					end
				end)
				heartbeat:Wait()
				hitboxClone:Destroy()
			end

		end
	elseif team.Value == "Survivor" then
		if equippedSurvivor.Value == "Default" then
			cooldown3.Value = 35
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
			updateSpeed:Fire()
		end	
	end
end

userInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and cooldown1.Value <= 0 and canUseAbility == true then
		canUseAbility = false
		ability1()
	elseif input.KeyCode == Enum.KeyCode.Q and cooldown2.Value <= 0 and canUseAbility == true then
		canUseAbility = false
		ability2()

	elseif input.KeyCode == Enum.KeyCode.E and cooldown3.Value <= 0  and canUseAbility == true then
		canUseAbility = false
		ability3()
	end
end)

while true do
	heartbeat:Wait()
	if cooldown1.Value > 0 then
		cooldown1.Value -= cooldownInterval
	end
	if cooldown2.Value > 0 then
		cooldown2.Value -= cooldownInterval
	end
	if cooldown3.Value > 0 then
		cooldown3.Value -= cooldownInterval
	end
	if cooldown4.Value > 0 then
		cooldown4.Value -= cooldownInterval
	end
end
