--[[
	This line of code exists to swap the shiftlock activation from the shift button to the ctrl button.
	This exists to allow the shift keybind to be used for sprinting instead.
]]--

script.Parent:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController"):WaitForChild("BoundKeys").Value = "LeftControl"
--script originates from https://www.youtube.com/watch?v=Qy4XIasak38
