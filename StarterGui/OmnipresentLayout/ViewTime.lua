local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local stateIndicator = script.Parent.StateIndicator
local timeLeft = script.Parent.TimeLeft
local time = replicatedStorage.ServerVariables.Timer
local roundInProgress = replicatedStorage.ServerVariables.RoundInProgress

local tick = script.Tick

local nextSecond = 0
local newSecond = false

while true do
	if time.Value == nextSecond then
		newSecond = true
	else
		newSecond = false
	end
	nextSecond = time.Value - 1
	task.wait(0.025)
	if time.Value % 60 >= 10 then
		timeLeft.Text = math.floor(time.Value / 60) .. ":" .. time.Value % 60
	else
		timeLeft.Text = math.floor(time.Value / 60) .. ":0" .. time.Value % 60
	end
	if ((time.Value <= 3 and roundInProgress.Value == false) or (time.Value <= 10 and roundInProgress.Value == true)) and newSecond == true then
		task.spawn(function()
			tick:Play()
			for i = 1, 10 do
				task.wait(0.025)
				timeLeft.TextColor3 = Color3.fromRGB(25.5 * i, 25.5 * i, 25.5 * i)
			end
		end)
	end
	if roundInProgress.Value == true then
		stateIndicator.Text = "Round ends in:"
	else
		stateIndicator.Text = "Round begins in:"
	end
end
