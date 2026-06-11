local module = {}

local heartbeat = game:GetService("RunService").Heartbeat
local players = game:GetService("Players")
local replicatedStorage = game.ReplicatedStorage
local abilityReady = replicatedStorage.CharacterFires.AbilityReady
local hitbox = replicatedStorage.Hitboxes.Hitbox
local fragment = replicatedStorage.Assets.DebrisPiece
local updateSpeed = replicatedStorage.CharacterFires.UpdateSpeed
local requestSpeedChange = replicatedStorage.CharacterFires.RequestSpeedChange
local triggerAnimation = replicatedStorage.CharacterFires.TriggerAnimation
local visualReduction = replicatedStorage.CharacterFires.VisualReduction
local cooldownReduction = replicatedStorage.CharacterFires.CooldownReduction

function module.genericM1(player, damage, windup, linger)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local dmg = damage
	local dmgDealt = false
	local i = 0	

	task.wait(windup)

	while i < linger * 60 do
		i += 1
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
					contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
					dmgDealt = true
					i = linger * 60
				end
			end
		end)
		heartbeat:Wait()
		hitboxClone:Destroy()
	end
	abilityReady:FireAllClients(player)
end

function module.butcherLeap(player, damage, windup, forwardPower)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local abilitySpeedMult = player.PlayerAttributes.AbilitySpeedMult
	local dmg = damage
	local dmgDealt = false
	local i = 0	
	
	abilitySpeedMult.Value = 0.001
	updateSpeed:FireAllClients(player)
	
	task.wait(windup)
	
	while humanoid.FloorMaterial == Enum.Material.Air or i < 10 do
		i += 1
		local initialDirection = humanoid.RootPart.CFrame.LookVector * Vector3.new(0.4, 0, 0.4)
		character:PivotTo(character:GetPivot() + initialDirection * forwardPower + Vector3.new(0, (-i+60)/18 - (i * i)/300, 0))
		if forwardPower > 0 then
			forwardPower -= 0.15
		end
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
					contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
					dmgDealt = true
				end
			end
		end)
		heartbeat:Wait()
		hitboxClone:Destroy()
	end
	
	dmgDealt = false
	
	--damage effect
	for j = 1, math.random(7, 15) do
		local fragmentClone = fragment:Clone()
		fragmentClone.Parent = workspace
		local fragmentSize = math.random(1, 8)/8
		fragmentClone.Size = Vector3.new(fragmentSize, fragmentSize, fragmentSize)
		fragmentClone.CFrame = humanoid.RootPart.CFrame
		fragmentClone.CFrame *= CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
		fragmentClone.CFrame *= CFrame.new(math.random(-8, 8), math.random(-1, 1), math.random(-8, 8))
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
					contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
					dmgDealt = true
				end
			end
		end)
		heartbeat:Wait()
		hitboxClone:Destroy()
	end
	
	triggerAnimation:FireAllClients(player, "ButcherLanding")

	task.wait(2.5)
	abilityReady:FireAllClients(player)

	abilitySpeedMult.Value = 1
	updateSpeed:FireAllClients(player)
end

function module.butcherPin(player, damage, windup, projectileSpeed, projectileLifespan)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local abilitySpeedMult = player.PlayerAttributes.AbilitySpeedMult
	local dmg = damage
	local dmgDealt = false
	local i = 0	
	
	abilitySpeedMult.Value = 0.25
	updateSpeed:FireAllClients(player)
	
	task.wait(windup)
	
	character.Weapon.Handle.Transparency = 1
	local originalCFrame = humanoid.RootPart.CFrame
	
	while i < projectileLifespan * 60 do
		i += 1
		if i == 20 then
			abilitySpeedMult.Value = 1
			updateSpeed:FireAllClients(player)
			abilityReady:FireAllClients(player)

		end
		if i >= 20 and i < 40 then
			character.Weapon.Handle.Transparency = 1 - ((i - 20) * 0.05)
		end
		local hitboxClone = hitbox:Clone()
		local swordClone = replicatedStorage.Assets["Butcher Sword"]:Clone()
		swordClone.Parent = hitboxClone
		swordClone.CFrame = originalCFrame
		swordClone.CFrame *= CFrame.new(0, 1, -4.5 - (i*projectileSpeed))
		swordClone.CFrame *= CFrame.Angles(i * -0.4, 0, 0)
		swordClone.Transparency = 0
		hitboxClone.Parent = workspace
		hitboxClone.Size = Vector3.new(4, 4, 4)
		hitboxClone.CFrame = originalCFrame
		hitboxClone.CFrame *= CFrame.new(0, 1, -4.5 - (i*projectileSpeed))
		hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
		hitboxClone.Touched:Connect(function(hit)
			local hitboxContacts = hitboxClone:GetTouchingParts()
			for _, contact in ipairs(hitboxContacts) do
				if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") and dmgDealt == false then
					contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
					dmgDealt = true
					i = 180
					
					if i > 20 then
						abilitySpeedMult.Value = 1
						updateSpeed:FireAllClients(player)
						abilityReady:FireAllClients(player)
						character.Weapon.Handle.Transparency = 0
					end
					
					visualReduction:FireAllClients(player, 3)
					cooldownReduction:Fire(player, 3, 8)

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

function module.archerArrow(player, damage, windup, projectileSpeed, projectileLifespan)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local abilitySpeedMult = player.PlayerAttributes.AbilitySpeedMult
	local face = character.Head.face
	local dmg = damage
	local dmgDealt = false
	local i = 0	

	abilitySpeedMult.Value = 0.4
	updateSpeed:FireAllClients(player)
	face.Texture = "rbxassetid://96866396006967"

	task.wait(windup)
	face.Texture = "rbxassetid://105322980330006"

	local originalCFrame = humanoid.RootPart.CFrame

	while i < projectileLifespan * 60 do
		i += 1
		local hitboxClone = hitbox:Clone()
		local arrowClone = replicatedStorage.Assets["Arrow"]:Clone()
		arrowClone.Parent = hitboxClone
		arrowClone.CFrame = originalCFrame
		arrowClone.CFrame *= CFrame.new(0, 1, -4.5 - (i*projectileSpeed))
		arrowClone.CFrame *= CFrame.Angles(0, math.rad(270), 0)
		arrowClone.Transparency = 0
		hitboxClone.Parent = workspace
		hitboxClone.Size = Vector3.new(4, 2, 2)
		hitboxClone.CFrame = originalCFrame
		hitboxClone.CFrame *= CFrame.new(0, 1, -1.5 - (i*projectileSpeed))
		hitboxClone.CFrame *= CFrame.Angles(0, math.rad(90), 0)
		hitboxClone.Touched:Connect(function(hit)
			local hitboxContacts = hitboxClone:GetTouchingParts()
			for _, contact in ipairs(hitboxContacts) do
				if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") and dmgDealt == false then
					contact.Parent:FindFirstChild("Humanoid"):TakeDamage(dmg)
					dmgDealt = true
					i = 182
				end
			end
		end)
		if i == 30 or i == 182 then
			face.Texture = "rbxassetid://83146247547038"
			abilitySpeedMult.Value = 1
			updateSpeed:FireAllClients(player)
			abilityReady:FireAllClients(player)

		end
		heartbeat:Wait()
		hitboxClone:Destroy()
	end
end

function module.archerDash(player, forwardPower)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local abilitySpeedMult = player.PlayerAttributes.AbilitySpeedMult
	local i = 0	

	abilitySpeedMult.Value = 0.001
	updateSpeed:FireAllClients(player)

	while i < 32 do
		i += 1
		local initialDirection = humanoid.RootPart.CFrame.LookVector * Vector3.new(0.3, 0, 0.3)
		character:PivotTo(character:GetPivot() + initialDirection * forwardPower)
		if forwardPower > 0 then
			forwardPower -= 0.05
		end
		heartbeat:Wait()
	end

	abilityReady:FireAllClients(player)
	abilitySpeedMult.Value = 1
	updateSpeed:FireAllClients(player)
end

function module.doctorMedkit(player, heal, linger, windup)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local abilitySpeedMult = player.PlayerAttributes.AbilitySpeedMult
	local face = character.Head.face
	local i = 0
	
	abilitySpeedMult.Value = 1.075
	updateSpeed:FireAllClients(player)
	face.Texture = "rbxassetid://91743605237089"
	task.wait(windup)

	while i < linger * 60 do
		i += 1
		local hitboxClone = hitbox:Clone()
		hitboxClone.Parent = workspace
		hitboxClone.Shape = "Cylinder"
		hitboxClone.Size = Vector3.new(1, 32, 32)
		hitboxClone.CFrame = humanoid.RootPart.CFrame
		hitboxClone.CFrame *= CFrame.new(0, -2, 0)
		hitboxClone.CFrame *= CFrame.Angles(math.rad(90), math.rad(90), 0)
		
		local medkitClone = replicatedStorage.Assets["Medkit"]:Clone()
		medkitClone.Parent = workspace
		medkitClone.CFrame = humanoid.RootPart.CFrame
		medkitClone.CFrame *= CFrame.new(0, 4, 0)
		medkitClone.CFrame *= CFrame.Angles(i/5, i/5, 0)
		medkitClone.Transparency = 0
		
		hitboxClone.Touched:Connect(function(hit)
			local hitboxContacts = hitboxClone:GetTouchingParts()
			for _, contact in ipairs(hitboxContacts) do
				if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") then
					contact.Parent:FindFirstChild("Humanoid"):TakeDamage(-heal/20)
				end
			end
		end)
		heartbeat:Wait()
		hitboxClone:Destroy()
		medkitClone:Destroy()
	end
	
	abilitySpeedMult.Value = 0.3
	updateSpeed:FireAllClients(player)
	face.Texture = "rbxassetid://110621746825104"
	task.wait(1)
	
	abilitySpeedMult.Value = 1
	updateSpeed:FireAllClients(player)
	
	abilityReady:FireAllClients(player)
end

function module.doctorBottle(player, windup, projectileSpeed)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local walkSpeed = player.PlayerAttributes.WalkSpeed
	local runSpeed = player.PlayerAttributes.RunSpeed
	local abilitySpeedMult = player.PlayerAttributes.AbilitySpeedMult
	local speedMult = player.PlayerAttributes.SpeedMult
	local face = character.Head.face
	local i = 0	

	abilitySpeedMult.Value = 0.6
	updateSpeed:FireAllClients(player)
	face.Texture = "rbxassetid://127701447371407"

	task.wait(windup)
	face.Texture = "rbxassetid://94403218536994"

	character.Weapon.Handle.Transparency = 1
	local originalCFrame = humanoid.RootPart.CFrame

	while i ~= -1 and i < 180 do
		i += 1
		local bottleClone = replicatedStorage.Assets["Bottle"]:Clone()
		bottleClone.Parent = workspace
		bottleClone.CFrame = originalCFrame
		bottleClone.CFrame *= CFrame.new(0, 1 + (0.6 * i) - (((i*projectileSpeed))*i)/75, -1 - (i*projectileSpeed))
		bottleClone.CFrame *= CFrame.Angles(i * -0.4, 0, 0)
		bottleClone.Transparency = 0
		bottleClone.Touched:Connect(function(hit)
			local hitboxContacts = bottleClone:GetTouchingParts()
			for _, contact in ipairs(hitboxContacts) do
				i = -1
				local j = 0
				local size = 15
				
				for j = 1, math.random(3, 6) do
					local fragmentClone = fragment:Clone()
					fragmentClone.Parent = workspace
					local fragmentSize = math.random(2, 5)/10
					fragmentClone.Size = Vector3.new(fragmentSize, fragmentSize, fragmentSize)
					fragmentClone.BrickColor = BrickColor.new("Baby blue")
					fragmentClone.CFrame = bottleClone.CFrame
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
				
				bottleClone:Destroy()
				
				while j < 5 do
					j += 1
					local hitboxClone = hitbox:Clone()
					hitboxClone.Parent = workspace
					hitboxClone.Shape = "Ball"
					hitboxClone.Size = Vector3.new(size, size, size)
					hitboxClone.CFrame = bottleClone.CFrame + Vector3.new(0, -3/i, 0)
					hitboxClone.CFrame *= CFrame.Angles(math.rad(90), math.rad(90), 0)
					heartbeat:Wait()
					hitboxClone:Destroy()
					hitboxClone.Touched:Connect(function(hit)
						local hitboxContacts = hitboxClone:GetTouchingParts()
						for _, contact in ipairs(hitboxContacts) do
							if contact.Parent:FindFirstChild("Humanoid") and contact.Parent:FindFirstChild("Humanoid") ~= character:FindFirstChild("Humanoid") then
								contact.Parent:FindFirstChild("Humanoid"):TakeDamage(-15)
							end
						end
					end)
				end
			end
		end)
		if i == 35 then
			face.Texture = "rbxassetid://110621746825104"
			abilitySpeedMult.Value = 1
			updateSpeed:FireAllClients(player)
			abilityReady:FireAllClients(player)

		end
		heartbeat:Wait()
		if i ~= -1 then
			bottleClone:Destroy()
		end
	end
	
	abilitySpeedMult.Value = 1
	updateSpeed:FireAllClients(player)

	abilityReady:FireAllClients(player)
end

return module
