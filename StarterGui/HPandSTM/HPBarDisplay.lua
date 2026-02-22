local bar = script.Parent
local bg = bar.Parent
local hpnum = bg.HPNUM
local hpcap = bg.HPCAP
local player = game.Players.LocalPlayer
local health = player.PlayerAttributes.Health
local maxHealth = player.PlayerAttributes.MaxHealth

bg.Visible = true

while true do
	bar.Size = UDim2.new(health.Value / maxHealth.Value, 0, 1, 0)
	if health.Value * 2 <= maxHealth.Value then
		--bar.BackgroundColor3 = Color3.fromRGB((155 - (310 * health.Value / maxHealth.Value)), 0, 0 + (510 * health.Value / maxHealth.Value))
		bar.BackgroundColor3 = Color3.fromHSV(0.4, (1.8 * health.Value / maxHealth.Value), 0.25 + (0.9 * health.Value / maxHealth.Value))
		bg.BackgroundColor3 = Color3.fromHSV(0.4, (2 * health.Value / maxHealth.Value), 0.1 + (0.2 * health.Value / maxHealth.Value))
	else
		--bar.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		bar.BackgroundColor3 = Color3.fromHSV(0.4, 0.9, 0.7)
		bg.BackgroundColor3 = Color3.fromHSV(0.4, 1, 0.2)
	end
	hpnum.Text = math.floor(health.Value)
	hpcap.Text = math.floor(maxHealth.Value)
	if health.Value == 0 then
		hpnum.TextColor3 = Color3.fromHSV(0, 1, 1)
	else
		hpnum.TextColor3 = Color3.fromHSV(0, 0, 1)
	end
	task.wait(0.025)
end
