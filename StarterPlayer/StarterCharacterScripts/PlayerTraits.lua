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
local inRound = player.PlayerAttributes.InRound
local afkMode = player.PlayerAttributes.AfkMode

local sprinting = false
local regenStamina = true

local shiftRegen = false
local holdingShift = false

local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

round.OnClientEvent:Connect(function()
	if afkMode.Value == false then
		inRound.Value = true
	else
		inRound.Value = false
	end
end)

intermission.OnClientEvent:Connect(function()
	inRound = false
end)

--[[
 checks if the user has enough stamina to sprint, then changes 
 walkspeed based on criteria
]]
userInputService.InputBegan:Connect(function(input)
	shiftRegen = true
	if input.KeyCode == Enum.KeyCode.LeftShift then
		holdingShift = true
		if stamina.Value > 0 then
			humanoid.WalkSpeed = runSpeed.Value
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
	if input.KeyCode == Enum.KeyCode.LeftShift then
		holdingShift = false
		if shiftRegen == true then
			shiftRegen = false
		else
			shiftRegen = true
		end
	end
	if input.KeyCode == Enum.KeyCode.LeftShift and shiftRegen == false then
		humanoid.WalkSpeed = walkSpeed.Value
		sprinting = false
		--[[
		this is to prevent button-mashing from
		messing with the stamina system and giving
		players unfair advantages/disadvantages
		over others
		]]
		if humanoid.MoveDirection.Magnitude > 0 then
			regenStamina = false
			for i = 1, 25 do
				task.wait(0.025)
				if regenStamina == true then
					regenStamina = false
				end
			end
			regenStamina = true
		end
	end
end)

--[[
 this system always runs while a player exists. it calculates
 stamina and health factors based on current scenarios
]]
while true do
	
	--irons out stamina usage and regeneration with shift and movement key usage
	if sprinting == true and humanoid.MoveDirection.Magnitude > 0 then
		regenStamina = false
	else
		if regenStamina == false then
			for i = 1, 25 do
				if sprinting == true then
					break
				end
				task.wait(0.025)
				if regenStamina == true then
					regenStamina = false
				end
			end
			if sprinting == false then
				regenStamina = true
			end
		end
	end
	
	--stamina mechanics
	if ((sprinting == false) or (holdingShift == true and humanoid.MoveDirection.Magnitude <= 0)) and stamina.Value < maxStamina.Value and regenStamina == true then
		stamina.Value += 1
	elseif sprinting == true and stamina.Value > 0 and humanoid.MoveDirection.Magnitude > 0 then
		stamina.Value -= 0.5
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
	
	-- since stamina is lost and gained in different increments, this statement removes any extra stamina a player may get
	if stamina.Value > maxStamina.Value then
		stamina.Value = maxStamina.Value
	end
	
	-- this is so the system isn't running hundreds of times a second
	task.wait(0.025)
	
end
