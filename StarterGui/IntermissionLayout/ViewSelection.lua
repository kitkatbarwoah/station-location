local selection = script.Parent
local selectionMenu = selection.SelectionMenu
local selectionButton = selection.SelectionButton
local selectionDisplay = selection.SelectionDisplay
local displayedName = selectionDisplay.CharName
local equip = selectionDisplay.Equip
local moreInfo = selectionDisplay.MoreInfo
local selectionInformation = selection.SelectionInformation

local replicatedStorage = game.ReplicatedStorage
local intermission = replicatedStorage.TimerFires.BeginIntermission
local round = replicatedStorage.TimerFires.BeginRound

local idTab = "Selection"
local guiFunctions = require(replicatedStorage.ModuleScripts.GuiFunctions)

local player = game.Players.LocalPlayer
local selectedCharacter = player.PlayerAttributes.SelectedCharacterName
local equippedCharacter = player.PlayerAttributes.EquippedCharacterName

local archerButton = selectionMenu.ArcherButton
local doctorButton = selectionMenu.DoctorButton
local guardianButton = selectionMenu.GuardianButton
local knightButton = selectionMenu.KnightButton

local inRound = player.PlayerAttributes.InRound

selectionMenu.Visible = false
selectionButton.Visible = true

round.OnClientEvent:Connect(function()
	task.wait(1)
	if inRound.Value == true then
		selectionMenu.Visible = false
		selectionButton.Visible = false
		selectionDisplay.Visible = false
		selectionInformation.Visible = false
	end
end)

intermission.OnClientEvent:Connect(function()
	task.wait(1)
	selectionButton.Visible = true
end)

selectionButton.MouseButton1Click:Connect(function()
	if selectionMenu.Visible == false then
		guiFunctions.closeTabs(idTab)
	else
		guiFunctions.closeTabs(nil)
	end
end)

equip.MouseButton1Click:Connect(function()
	if equippedCharacter.Value ~= selectedCharacter.Value then
		equippedCharacter.Value = selectedCharacter.Value
		equip.Text = "Equipped"
	end
	
end)

moreInfo.MouseButton1Click:Connect(function()
	if moreInfo.Text == "More Info" then
		selectionInformation.Visible = true
		moreInfo.Text = "Return"
	else
		selectionInformation.Visible = false
		moreInfo.Text = "More Info"
	end
end)

archerButton.MouseButton1Click:Connect(function()
	selectedCharacter.Value = "Archer"
	displayedName.Text = "Archer"
	if equippedCharacter.Value == "Archer" then
		equip.Text = "Equipped"
	else
		equip.Text = "Equip"
	end
end)

doctorButton.MouseButton1Click:Connect(function()
	selectedCharacter.Value = "Doctor"
	displayedName.Text = "Doctor"
	if equippedCharacter.Value == "Doctor" then
		equip.Text = "Equipped"
	else
		equip.Text = "Equip"
	end
end)

guardianButton.MouseButton1Click:Connect(function()
	selectedCharacter.Value = "Guardian"
	displayedName.Text = "Guardian"
	if equippedCharacter.Value == "Guardian" then
		equip.Text = "Equipped"
	else
		equip.Text = "Equip"
	end
end)

knightButton.MouseButton1Click:Connect(function()
	selectedCharacter.Value = "Knight"
	displayedName.Text = "Knight"
	if equippedCharacter.Value == "Knight" then
		equip.Text = "Equipped"
	else
		equip.Text = "Equip"
	end
end)
