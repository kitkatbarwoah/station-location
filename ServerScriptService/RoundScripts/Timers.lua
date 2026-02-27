local replicatedStorage = game.ReplicatedStorage
local time = replicatedStorage.ServerVariables.Timer

local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local function roundClock(startingTime)
	time.Value = startingTime
	while time.Value >= 0 do
		time.Value -= 1
		task.wait(1)
		print(time.Value)
	end
end

while true do
	intermission:FireAllClients()
	roundClock(15) -- short for now for testing purposes, will be extended to 45 seconds before final version
	round:FireAllClients()
	task.wait(2)
	roundClock(210)
	task.wait(2)
end
