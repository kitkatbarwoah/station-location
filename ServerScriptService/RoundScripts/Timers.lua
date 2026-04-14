local replicatedStorage = game.ReplicatedStorage
local time = replicatedStorage.ServerVariables.Timer
local roundInProgress = replicatedStorage.ServerVariables.RoundInProgress

local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound
local pickTeams = replicatedStorage.TimerFires.PickTeams

local player = game.Players.LocalPlayer
local players = game.Players:GetPlayers()
local team = ""
local malice = 0
local highestMalice = 0
local nextJuggernaut = 0

local selectedJuggernaut = replicatedStorage.ServerVariables.SelectedJuggernaut

local function roundClock(startingTime)
	time.Value = startingTime
	while time.Value > 0 do
		time.Value -= 1
		task.wait(1)
	end
end

while true do
	intermission:FireAllClients()
	roundInProgress.Value = false
	roundClock(15) -- short for now for testing purposes, will be extended to 45 seconds before final version
	round:FireAllClients()
	
	players = game.Players:GetPlayers()
	for _, player in ipairs(players) do
		if player.PlayerAttributes.AfkMode.Value == true then
			continue
		end
		player.PlayerAttributes.Team.Value = "Survivor"
		malice = player.PlayerAttributes.Malice.Value
		if malice >= highestMalice then
			highestMalice = malice
			nextJuggernaut = player
			nextJuggernautName = player.Name
		end
	end
	nextJuggernaut.PlayerAttributes.Team.Value = "Juggernaut"
	nextJuggernaut.PlayerAttributes.Malice.Value = 0
	selectedJuggernaut.Value = nextJuggernautName
	wait(1)
	pickTeams:FireAllClients()
	print(nextJuggernautName .. " is the next juggernaut")
	roundInProgress.Value = true
	roundClock(210)
	task.wait(1)
end
