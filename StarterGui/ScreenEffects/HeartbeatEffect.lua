local effect = script.Parent.Parent
local replicatedStorage = game.ReplicatedStorage
local chaseProximity = replicatedStorage.LocalFires.ChaseProximity
local heartbeatIndicator = script.Parent

local previousLayer = 0

chaseProximity.Event:Connect(function(chaseLayer)
	if previousLayer == 0 and chaseLayer ~= 0 then
		heartbeatIndicator.Image = "rbxassetid://72483968001780"
		heartbeatIndicator.Visible = true
		heartbeatIndicator.ImageTransparency = 1
		for i = 1, 10 do
			heartbeatIndicator.ImageTransparency -= 0.1
			task.wait(0.025)
		end
	elseif previousLayer ~= 0 and chaseLayer == 0 then
		heartbeatIndicator.ImageTransparency = 0
		for i = 1, 10 do
			heartbeatIndicator.ImageTransparency += 0.1
			task.wait(0.025)
		end
		heartbeatIndicator.Visible = false
	else
	end
	if chaseLayer == 1 then
		heartbeatIndicator.Image = "rbxassetid://72483968001780"
	elseif chaseLayer == 2 then
		heartbeatIndicator.Image = "rbxassetid://102152999010406"
	elseif chaseLayer == 3 then
		heartbeatIndicator.Image = "rbxassetid://84801178137633"
	elseif chaseLayer == 4 then
		heartbeatIndicator.Image = "rbxassetid://135111319445373"
	end
	previousLayer = chaseLayer
end)

while true do
	heartbeatIndicator.Size += UDim2.new(0.05, 0, 0.05, 0)
	for i = 1, 10 do
		heartbeatIndicator.Size -= UDim2.new(0.005, 0, 0.005, 0)
		task.wait(0.025 / previousLayer)
	end
	task.wait((1.1 - previousLayer * 0.25))
end
