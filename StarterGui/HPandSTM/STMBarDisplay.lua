local bar = script.Parent
local bg = bar.Parent
local stmnum = bg.STMNUM
local stmcap = bg.STMCAP
local player = game.Players.LocalPlayer
local stamina = player.PlayerAttributes.Stamina
local maxStamina = player.PlayerAttributes.MaxStamina

bg.Visible = true

while true do
	bar.Size = UDim2.new(stamina.Value / maxStamina.Value, 0, 1, 0)
	if stamina.Value * 2 <= maxStamina.Value then
		--bar.BackgroundColor3 = Color3.fromRGB((155 - (310 * stamina.Value / maxStamina.Value)), 0, 0 + (510 * stamina.Value / maxStamina.Value))
		bar.BackgroundColor3 = Color3.fromHSV(0.65, (1.8 * stamina.Value / maxStamina.Value), 0.25 + (1.5 * stamina.Value / maxStamina.Value))
		bg.BackgroundColor3 = Color3.fromHSV(0.65, (2 * stamina.Value / maxStamina.Value), 0.1 + (0.6 * stamina.Value / maxStamina.Value))
	else
		--bar.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		bar.BackgroundColor3 = Color3.fromHSV(0.65, 0.9, 1)
		bg.BackgroundColor3 = Color3.fromHSV(0.65, 1, 0.4)
	end
	stmnum.Text = math.floor(stamina.Value)
	stmcap.Text = math.floor(maxStamina.Value)
	if stamina.Value == 0 then
		stmnum.TextColor3 = Color3.fromHSV(0, 1, 1)
	else
		stmnum.TextColor3 = Color3.fromHSV(0, 0, 1)
	end
	task.wait(0.025)
end
