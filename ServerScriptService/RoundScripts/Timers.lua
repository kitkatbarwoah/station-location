local replicatedStorage = game.ReplicatedStorage
local time = replicatedStorage.ServerVariables.Timer
local roundInProgress = replicatedStorage.ServerVariables.RoundInProgress

local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local function roundClock(startingTime)
	time.Value = startingTime
	while time.Value > 0 do
		time.Value -= 1
		task.wait(1)
		print(time.Value)
	end
end

while true do
	intermission:FireAllClients()
	roundInProgress.Value = false
	roundClock(15) -- short for now for testing purposes, will be extended to 45 seconds before final version
	round:FireAllClients()
	roundInProgress.Value = true
	task.wait(1)
	roundClock(210)
	task.wait(1)
end
