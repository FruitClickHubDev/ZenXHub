-- ZenX Hub Fullscreen UI + Minimal UI (Draggable Main + Red FX + Auto Farm + Auto Attack for Blox Fruits)
-- Place in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local GUI_NAME = "ZenX_FullUI"
local TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Clean old GUI
local old = PlayerGui:FindFirstChild(GUI_NAME)
if old then old:Destroy() end

-- Colors
local COLORS = {
	BG = Color3.fromRGB(15, 15, 18),
	RED = Color3.fromRGB(255, 70, 70),
	STROKE = Color3.fromRGB(28, 28, 28),
	TEXT = Color3.fromRGB(240, 240, 240)
}

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = GUI_NAME
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

----------------------------------------------------
-- 🔻 Fullscreen Loading Screen
----------------------------------------------------
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.fromScale(1, 1)
loadingFrame.BackgroundColor3 = COLORS.BG
loadingFrame.Parent = gui

local glow = Instance.new("ImageLabel")
glow.Size = UDim2.fromScale(1.5, 1.5)
glow.Position = UDim2.fromScale(0.5, 0.5)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Image = "rbxassetid://11778771457"
glow.ImageColor3 = COLORS.RED
glow.ImageTransparency = 0.8
glow.BackgroundTransparency = 1
glow.ZIndex = 0
glow.Parent = loadingFrame

local loadingLabel = Instance.new("TextLabel")
loadingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLabel.Position = UDim2.fromScale(0.5, 0.45)
loadingLabel.Size = UDim2.fromOffset(300, 50)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Font = Enum.Font.GothamBlack
loadingLabel.Text = "Loading"
loadingLabel.TextSize = 40
loadingLabel.TextColor3 = COLORS.RED
loadingLabel.Parent = loadingFrame

task.spawn(function()
	local dots = 0
	while loadingFrame.Parent do
		dots = (dots + 1) % 4
		loadingLabel.Text = "Loading" .. string.rep(".", dots)
		task.wait(0.5)
	end
end)

local barContainer = Instance.new("Frame")
barContainer.AnchorPoint = Vector2.new(0.5, 0.5)
barContainer.Position = UDim2.fromScale(0.5, 0.55)
barContainer.Size = UDim2.fromOffset(400, 10)
barContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barContainer.BorderSizePixel = 0
barContainer.Parent = loadingFrame
Instance.new("UICorner", barContainer).CornerRadius = UDim.new(0, 8)

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.fromScale(0, 1)
progressBar.BackgroundColor3 = COLORS.RED
progressBar.BorderSizePixel = 0
progressBar.Parent = barContainer
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 8)

TweenService:Create(progressBar, TweenInfo.new(5, Enum.EasingStyle.Sine), {Size = UDim2.fromScale(1, 1)}):Play()
task.wait(5)

TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(loadingLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
TweenService:Create(barContainer, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(progressBar, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(glow, TweenInfo.new(1), {ImageTransparency = 1}):Play()
task.wait(1)
loadingFrame:Destroy()

----------------------------------------------------
-- 🔻 ZenX Hub Main UI
----------------------------------------------------
local icon = Instance.new("TextButton")
icon.Name = "ZenX_Hub_Icon"
icon.Size = UDim2.fromOffset(56, 56)
icon.Position = UDim2.new(1, -90, 0, 20)
icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
icon.Text = "ZenX Hub"
icon.Font = Enum.Font.GothamBlack
icon.TextSize = 14
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.Parent = gui
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)
local iconStroke = Instance.new("UIStroke", icon)
iconStroke.Color = Color3.fromRGB(255, 255, 255)
iconStroke.Thickness = 1

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(500, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = COLORS.BG
main.Visible = false
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = COLORS.STROKE
mainStroke.Thickness = 1

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 0.9
title.Font = Enum.Font.GothamBlack
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(20, 20, 20)
title.Text = "ZenX Hub"
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 28)
close.Position = UDim2.new(1, -38, 0, 6)
close.BackgroundTransparency = 1
close.Font = Enum.Font.GothamBold
close.Text = "✕"
close.TextSize = 18
close.TextColor3 = COLORS.RED
close.Parent = title

local content = Instance.new("TextLabel")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.fromOffset(10, 50)
content.BackgroundTransparency = 1
content.Font = Enum.Font.Gotham
content.TextSize = 14
content.TextColor3 = COLORS.TEXT
content.Text = "ZenX Hub ready.\nCinematic loading screen + Red FX + draggable panel!"
content.TextWrapped = true
content.Parent = main

----------------------------------------------------
-- 🔻 Toggle Buttons
----------------------------------------------------
local toggles = {}
local function createToggle(name, posY)
	local btn = Instance.new("TextButton")
	btn.Name = name .. "_Toggle"
	btn.Size = UDim2.new(0, 140, 0, 28)
	btn.Position = UDim2.new(0, 30, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamBold
	btn.Text = name .. ": OFF"
	btn.AutoButtonColor = false
	btn.Parent = main
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(255, 60, 60)
	stroke.Thickness = 2
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		if state then
			btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
			stroke.Color = Color3.fromRGB(0, 255, 0)
			btn.Text = name .. ": ON"
		else
			btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
			stroke.Color = Color3.fromRGB(255, 60, 60)
			btn.Text = name .. ": OFF"
		end
	end)
	toggles[name] = btn
end

createToggle("Auto Farm", 110)
createToggle("Farm Nearest", 145)
createToggle("Auto Attack", 180)

----------------------------------------------------
-- 🔻 Farm Nearest for Blox Fruits
----------------------------------------------------
local farmNearestToggle = toggles["Farm Nearest"]
local autoFarmEnabled = false

farmNearestToggle.MouseButton1Click:Connect(function()
	autoFarmEnabled = not autoFarmEnabled
end)

local function getBestStyle()
	local styles = {"Black Leg", "Dark Step", "Dragon Claw", "Electro", "Sharkman Karate"}
	for _, style in ipairs(styles) do
		if LocalPlayer.Backpack:FindFirstChild(style) or character:FindFirstChild(style) then
			return style
		end
	end
	return nil
end

local function getNearestNPC()
	local nearest = nil
	local dist = math.huge
	for _, npc in pairs(workspace.Enemies:GetChildren()) do
		if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
			local d = (npc.HumanoidRootPart.Position - hrp.Position).Magnitude
			if d < dist then
				dist = d
				nearest = npc
			end
		end
	end
	return nearest
end

local function autoAttack(npc)
	if not npc or not npc:FindFirstChild("Humanoid") then return end
	local attackStyle = getBestStyle()
	if attackStyle then
		local tool = LocalPlayer.Backpack:FindFirstChild(attackStyle) or character:FindFirstChild(attackStyle)
		if tool then
			tool.Parent = character
			tool:Activate()
		end
	end
end

spawn(function()
	while true do
		task.wait(0.1)
		if autoFarmEnabled then
			local npc = getNearestNPC()
			if npc then
				for i = 1, 6 do
					if not npc or npc.Humanoid.Health <= 0 then break end
					local angle = math.rad(i*60)
					local offset = Vector3.new(math.cos(angle),0,math.sin(angle))
					hrp.CFrame = CFrame.new(npc.HumanoidRootPart.Position + offset)
					autoAttack(npc)
					task.wait(0.1)
				end
			end
		end
	end
end)

----------------------------------------------------
-- 🔻 Auto Attack (Middle Screen Click Logic)
----------------------------------------------------
local autoAttackToggle = toggles["Auto Attack"]
local autoAttackEnabled = false

-- Detect Roblox menu and main menu states
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")

-- Toggle
autoAttackToggle.MouseButton1Click:Connect(function()
	autoAttackEnabled = not autoAttackEnabled
end)

-- Function to check if player is in Roblox menu or main menu
local function isMenuOpen()
	-- Roblox CoreGui menu open (Esc)
	if GuiService.MenuIsOpen then return true end
	-- Optional: if your game has a "MainMenu" GUI
	local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
	if pg then
		for _, g in ipairs(pg:GetChildren()) do
			if g:IsA("ScreenGui") and g.Enabled and g.Name:lower():find("mainmenu") then
				return true
			end
		end
	end
	return false
end

----------------------------------------------------
-- 🔻 Auto Attack Toggle Logic (Fixed)
----------------------------------------------------
local VirtualInputManager = game:GetService("VirtualInputManager")
local autoAttackToggle = toggles["Auto Attack"]
local autoAttackEnabled = false

autoAttackToggle.MouseButton1Click:Connect(function()
	autoAttackEnabled = not autoAttackEnabled
end)

local function getEquippedTool()
	local char = LocalPlayer.Character
	if not char then return nil end
	for _, tool in ipairs(char:GetChildren()) do
		if tool:IsA("Tool") then
			return tool
		end
	end
	return nil
end

task.spawn(function()
	while true do
		task.wait(0.08)
		if autoAttackEnabled then
			local tool = getEquippedTool()
			if tool and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword" or tool.ToolTip == "Gun" or tool:IsA("Tool")) then
				pcall(function()
					-- use tool:Activate() to simulate attack
					tool:Activate()

					-- Also simulate an actual click in the center of the screen
					local viewport = workspace.CurrentCamera.ViewportSize
					local centerX, centerY = viewport.X / 2, viewport.Y / 2
					VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
					task.wait(0.05)
					VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
				end)
			end
		end
	end
end)

----------------------------------------------------
-- 🔻 Animations + Controls
----------------------------------------------------
local function hover(btn, default)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(235, 80, 80)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = default}):Play()
	end)
end

hover(icon, icon.BackgroundColor3)

local function particleBurst()
	for i = 1, 40 do
		local p = Instance.new("Frame")
		p.Size = UDim2.fromOffset(math.random(4, 10), math.random(4, 10))
		p.Position = UDim2.new(0.5, math.random(-250, 250), 0.5, math.random(-150, 150))
		p.BackgroundColor3 = COLORS.RED
		p.BackgroundTransparency = 0.2
		p.BorderSizePixel = 0
		p.ZIndex = 5
		p.Parent = main
		TweenService:Create(p, TweenInfo.new(6.5, Enum.EasingStyle.Sine), {
			BackgroundTransparency = 1,
			Position = UDim2.new(p.Position.X.Scale, p.Position.X.Offset + math.random(-60, 60),
				p.Position.Y.Scale, p.Position.Y.Offset + math.random(-60, 60))
		}):Play()
		task.delay(6.5, function() p:Destroy() end)
	end
end

local function showMain()
	main.Visible = true
	main.Size = UDim2.fromOffset(480, 280)
	main.BackgroundTransparency = 1
	TweenService:Create(main, TWEEN_INFO, {
		BackgroundTransparency = 0,
		Size = UDim2.fromOffset(500, 300)
	}):Play()
	icon.Visible = false
	particleBurst()
end

local function hideMain()
	main.Visible = false
	icon.Visible = true
end

icon.MouseButton1Click:Connect(showMain)
close.MouseButton1Click:Connect(hideMain)

UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightShift then
		if main.Visible then hideMain() else showMain() end
	end
end)

warn("✅ ZenX Hub loaded with Auto Farm + Farm Nearest + Auto Attack integrated!")
