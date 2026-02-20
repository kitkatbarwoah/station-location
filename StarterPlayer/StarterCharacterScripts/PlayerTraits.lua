local userInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local stamina = player.PlayerAttributes.Stamina
local health = player.PlayerAttributes.Health
local maxStamina = player.PlayerAttributes.MaxStamina
local maxHealth = player.PlayerAttributes.MaxHealth
local walkSpeed = player.PlayerAttributes.WalkSpeed
local runSpeed = player.PlayerAttributes.RunSpeed

local sprinting = false
local regenStamina = false

local shiftRegen = false

--[[
 checks if the user has enough stamina to sprint, then changes 
 walkspeed based on criteria
]]
userInputService.InputBegan:Connect(function(input)
	shiftRegen = true
	if input.KeyCode == Enum.KeyCode.LeftShift then
		if stamina.Value > 0 then
			humanoid.WalkSpeed = runSpeed.Value
			regenStamina = false
			sprinting = true
		else
			humanoid.WalkSpeed = walkSpeed.Value
			sprinting = false
		end
	end
end)

--[[
 checks to see the last time the player sprinted to know when
 to begin regenerating stamina
]]

userInputService.InputEnded:Connect(function(input)
	if shiftRegen == true then
		shiftRegen = false
	else
		shiftRegen = true
	end
	if input.KeyCode == Enum.KeyCode.LeftShift and shiftRegen == false then
		humanoid.WalkSpeed = walkSpeed.Value
		regenStamina = false
		sprinting = false
		--[[
		this is to prevent button-mashing from
		messing with the stamina system and giving
		players unfair advantages/disadvantages
		over others
		]]
		for i = 1, 25 do
			task.wait(0.025)
			if regenStamina == true then
				regenStamina = false
			end
		end
		regenStamina = true
	end
end)

--[[
 this system always runs while a player exists. it calculates
 stamina and health factors based on current scenarios
]]
while true do
	
	--stamina mechanics
	if sprinting == false and stamina.Value < maxStamina.Value and regenStamina == true then
		stamina.Value += 1
	elseif sprinting == true and stamina.Value > 0 then
		stamina.Value -= 1
		task.wait(0.025)
	elseif sprinting == true and stamina.Value == 0 then
		humanoid.WalkSpeed = walkSpeed.Value
		sprinting = false
		task.wait(1)
		regenStamina = true
		shiftRegen = false
	end
	
	--set a player's true health to 0 if they have 0 health
	if health.Value <= 0 then
		humanoid.Health = 0
	end
	
	-- this is so the system isn't running hundreds of times a second
	task.wait(0.025)
	
	-- for testing purposes, will be removed once proper stamina GUI is implemented
	print("stamina: " .. stamina.Value)
	
	
end
