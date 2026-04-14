local abilityDisplay = script.Parent
local player = game.Players.LocalPlayer
local replicatedStorage = game.ReplicatedStorage
local inRound = player.PlayerAttributes.InRound
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local team = player.PlayerAttributes.Team
local pickTeams = replicatedStorage.TimerFires.PickTeams
local equippedCharacter = player.PlayerAttributes.EquippedCharacterName
local equippedJuggernaut = player.PlayerAttributes.EquippedJuggernautName

local cooldown1 = player.PlayerAttributes.Cooldown1
local cooldown2 = player.PlayerAttributes.Cooldown2
local cooldown3 = player.PlayerAttributes.Cooldown3
local cooldown4 = player.PlayerAttributes.Cooldown4

local cooldown1max = player.PlayerAttributes.Cooldown1Max
local cooldown2max = player.PlayerAttributes.Cooldown2Max
local cooldown3max = player.PlayerAttributes.Cooldown3Max
local cooldown4max = player.PlayerAttributes.Cooldown4Max

local ability1 = abilityDisplay.Ability1
local ability1name = ability1.DisplayName
local ability1cooldown = ability1.Cooldown
local ability1indicator = ability1.CooldownIndicator

local ability2 = abilityDisplay.Ability2
local ability2name = ability2.DisplayName
local ability2cooldown = ability2.Cooldown
local ability2indicator = ability2.CooldownIndicator

local ability3 = abilityDisplay.Ability3
local ability3name = ability3.DisplayName
local ability3cooldown = ability3.Cooldown
local ability3indicator = ability3.CooldownIndicator

round.OnClientEvent:Connect(function()
	task.wait(1)
	if inRound.Value == true then
		abilityDisplay.Visible = true
	end
end)

intermission.OnClientEvent:Connect(function()
	task.wait(1)
	abilityDisplay.Visible = false
end)

pickTeams.OnClientEvent:Connect(function()
	if team.Value == "Juggernaut" then
		if equippedJuggernaut.Value == "Butcher" then
			ability1name.Text = "Slash"
			ability2name.Text = "Leap"
			ability3name.Text = "Pin"
		end
	elseif team.Value == "Survivor" then
		if equippedCharacter.Value == "Default" then
			ability2name.Text = "Cola"
			ability3name.Text = "Swing"
		end
	end
end)

while true do
	task.wait(0.1)
	
	ability1cooldown.Text = math.ceil(cooldown1.Value * 10) / 10
	ability2cooldown.Text = math.ceil(cooldown2.Value * 10) / 10
	ability3cooldown.Text = math.ceil(cooldown3.Value * 10) / 10
	
	if cooldown1.Value <= 0 then
		ability1cooldown.Visible = false
	else
		ability1cooldown.Visible = true
	end
	
	if cooldown2.Value <= 0 then
		ability2cooldown.Visible = false
	else
		ability2cooldown.Visible = true
	end
	
	if cooldown3.Value <= 0 then
		ability3cooldown.Visible = false
	else
		ability3cooldown.Visible = true
	end
	
	ability1indicator.Visible = cooldown1.Value > 0
	ability2indicator.Visible = cooldown2.Value > 0
	ability3indicator.Visible = cooldown3.Value > 0
	
	ability1indicator.Size = UDim2.new(1, 0, cooldown1.Value / cooldown1max.Value, 0)
	ability2indicator.Size = UDim2.new(1, 0, cooldown2.Value / cooldown2max.Value, 0)
	ability3indicator.Size = UDim2.new(1, 0, cooldown3.Value / cooldown3max.Value, 0)
end
