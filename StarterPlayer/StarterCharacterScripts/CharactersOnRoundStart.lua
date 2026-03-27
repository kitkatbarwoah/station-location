local replicatedStorage = game.ReplicatedStorage
local pickTeams = replicatedStorage.TimerFires.PickTeams
local player = game.Players.LocalPlayer
local team = player.PlayerAttributes.Team
local humanoid = player.Character.Humanoid

pickTeams.OnClientEvent:Connect(function()
	if team.Value == "Survivor" then
		--humanoid.RootPart.Position = Vector3.new(0, 300, 0)
	elseif team.Value == "Juggernaut" then
		--humanoid.RootPart.Position = Vector3.new(0, 600, 300)
	end
	print(team.Value)
end)
