local Sunshine = require(game:GetService("ReplicatedStorage"):WaitForChild("Sunshine"))
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")
local player = game:GetService("Players").LocalPlayer

game:GetService("StarterGui"):SetCore("TopbarEnabled", false)

Sunshine:addSystemFolder(script:WaitForChild("systems"))
Sunshine:setComponentInterfaces(require(script:WaitForChild("componentInterfaces")))
Sunshine:loadScene(require(Assets:WaitForChild("scenes").CrossroadsDay))
Sunshine:loadScene(require(Assets.scenes.uiScene), 2)

game:GetService("RunService").Heartbeat:Connect(function()
	if player:FindFirstChild("PlayerGui") then
		if player.PlayerGui:FindFirstChild("Freecam") then
			player.PlayerGui.Freecam:Destroy()
		end
	end
end)