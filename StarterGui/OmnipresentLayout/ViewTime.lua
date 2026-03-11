local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local stateIndicator = script.Parent.StateIndicator
local timeLeft = script.Parent.TimeLeft
local time = replicatedStorage.ServerVariables.Timer
local roundInProgress = replicatedStorage.ServerVariables.RoundInProgress

while true do
	task.wait(0.025)
	if time.Value >= 10 then
		timeLeft.Text = math.floor(time.Value / 60) .. ":" .. time.Value % 60
	else
		timeLeft.Text = math.floor(time.Value / 60) .. ":0" .. time.Value % 60
	end
	if roundInProgress.Value == true then
		stateIndicator.Text = "Round ends in:"
	else
		stateIndicator.Text = "Round begins in:"
	end
end
