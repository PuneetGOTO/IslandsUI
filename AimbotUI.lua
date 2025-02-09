--// Cache

local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

--// Preventing Multiple Processes

pcall(function()
	getgenv().Aimbot.Functions:Exit()
end)

--// Environment

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Variables

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

--// Script Settings

Environment.Settings = {
	Enabled = true,
	TeamCheck = false,
	AliveCheck = true,
	WallCheck = false, -- Laggy
	Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
	ThirdPerson = false, -- Uses mousemoverel instead of CFrame to support locking in third person (could be choppy)
	ThirdPersonSensitivity = 3, -- Boundary: 0.1 - 5
	TriggerKey = "MouseButton2",
	Toggle = false,
	LockPart = "Head" -- Body part to lock on
}

Environment.FOVSettings = {
	Enabled = true,
	Visible = true,
	Amount = 90,
	Color = Color3.fromRGB(255, 255, 255),
	LockedColor = Color3.fromRGB(255, 70, 70),
	Transparency = 0.5,
	Sides = 60,
	Thickness = 1,
	Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")

--// Functions

local function CancelLock()
	Environment.Locked = nil
	if Animation then Animation:Cancel() end
	Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
	if not Environment.Locked then
		RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)

		for _, v in next, Players:GetPlayers() do
			if v ~= LocalPlayer then
				if v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
					if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
					if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
					if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

					local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
					local Distance = (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude

					if Distance < RequiredDistance and OnScreen then
						RequiredDistance = Distance
						Environment.Locked = v
					end
				end
			end
		end
	elseif (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
		CancelLock()
	end
end

--// Typing Check

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
	Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
	Typing = false
end)

--// Main

local function Load()
	ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
		if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
			Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
			Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
			Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
			Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
			Environment.FOVCircle.Color = Environment.FOVSettings.Color
			Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
			Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
			Environment.FOVCircle.Position = Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
		else
			Environment.FOVCircle.Visible = false
		end

		if Running and Environment.Settings.Enabled then
			GetClosestPlayer()

			if Environment.Locked then
				if Environment.Settings.ThirdPerson then
					Environment.Settings.ThirdPersonSensitivity = mathclamp(Environment.Settings.ThirdPersonSensitivity, 0.1, 5)

					local Vector = Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
					mousemoverel((Vector.X - UserInputService:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
				else
					if Environment.Settings.Sensitivity > 0 then
						Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
						Animation:Play()
					else
						Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
					end
				end

			Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor

			end
		end
	end)

	ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
		if not Typing then
			pcall(function()
				if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)

			pcall(function()
				if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)
		end
	end)

	ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
		if not Typing then
			if not Environment.Settings.Toggle then
				pcall(function()
					if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)

				pcall(function()
					if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)
			end
		end
	end)
end

--// Functions

Environment.Functions = {}

function Environment.Functions:Exit()
	for _, v in next, ServiceConnections do
		v:Disconnect()
	end

	if Environment.FOVCircle.Remove then Environment.FOVCircle:Remove() end

	getgenv().Aimbot.Functions = nil
	getgenv().Aimbot = nil
	
	Load = nil; GetClosestPlayer = nil; CancelLock = nil
end

function Environment.Functions:Restart()
	for _, v in next, ServiceConnections do
		v:Disconnect()
	end

	Load()
end

function Environment.Functions:ResetSettings()
	Environment.Settings = {
		Enabled = true,
		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,
		Sensitivity = 0,
		ThirdPerson = false,
		ThirdPersonSensitivity = 3,
		TriggerKey = "MouseButton2",
		Toggle = false,
		LockPart = "Head"
	}

	Environment.FOVSettings = {
		Enabled = true,
		Visible = true,
		Amount = 90,
		Color = Color3.fromRGB(255, 255, 255),
		LockedColor = Color3.fromRGB(255, 70, 70),
		Transparency = 0.5,
		Sides = 60,
		Thickness = 1,
		Filled = false
	}
end

--// Load

Load()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 安全检查：确保 getgenv() 存在，如果不存在则创建
if not getgenv then
    function getgenv()
        return _G  -- 使用 _G 作为后备方案
    end
end

-- 初始化 Aimbot 环境
if not getgenv().Aimbot then
    getgenv().Aimbot = {
        Settings = {
            Enabled = true,
            TeamCheck = false,
            AliveCheck = true,
            WallCheck = false,
            Sensitivity = 0,
            ThirdPerson = false,
            ThirdPersonSensitivity = 3,
            TriggerKey = "MouseButton2",
            LockPart = "Head"
        },
        FOVSettings = {
            Enabled = true,
            Visible = true,
            Amount = 90,
            Color = Color3.fromRGB(255, 255, 255),
            LockedColor = Color3.fromRGB(255, 70, 70),
            Transparency = 0.5,
            Sides = 60,
            Thickness = 1,
            Filled = false
        },
        Functions = {
            Restart = function() print("Restart function not implemented") end,
            ResetSettings = function() print("Reset Settings function not implemented") end
        }
    }
end

-- Create ScreenGui
local AimbotUI = Instance.new("ScreenGui")
AimbotUI.Name = "AimbotUI"
AimbotUI.Parent = PlayerGui
AimbotUI.IgnoreGuiInset = true
AimbotUI.ResetOnSpawn = false

-- Create main frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 600)
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = AimbotUI

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Text = "Aimbot Settings"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.BorderSizePixel = 0
Title.Parent = MainFrame

-- Author Credit
local AuthorCredit = Instance.new("TextLabel")
AuthorCredit.Size = UDim2.new(1, 0, 0, 30)
AuthorCredit.Position = UDim2.new(0, 0, 0, 60)
AuthorCredit.Text = "由Lorain制作"
AuthorCredit.Font = Enum.Font.GothamSemibold
AuthorCredit.TextSize = 16
AuthorCredit.TextColor3 = Color3.fromRGB(200, 200, 200)
AuthorCredit.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AuthorCredit.BorderSizePixel = 0
AuthorCredit.Parent = MainFrame

-- Function to create a toggle
local function CreateToggle(parent, text, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 50)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = ToggleFrame

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.2, 0, 0.6, 0)
    Toggle.Position = UDim2.new(0.8, -10, 0.2, 0)
    Toggle.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    Toggle.Text = default and "ON" or "OFF"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ToggleFrame

    local isOn = default
    Toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        Toggle.BackgroundColor3 = isOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        Toggle.Text = isOn and "ON" or "OFF"
        callback(isOn)
    end)

    return ToggleFrame
end

-- Function to create a slider
local function CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -20, 0, 70)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 25)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = SliderFrame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.2, 0, 0, 25)
    ValueLabel.Position = UDim2.new(0.8, -10, 0, 0)
    ValueLabel.Text = string.format("%.2f", default)
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.TextSize = 12
    ValueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Parent = SliderFrame

    local Slider = Instance.new("Slider")
    Slider.Size = UDim2.new(1, -20, 0, 20)
    Slider.Position = UDim2.new(0, 10, 0, 40)
    Slider.MinValue = min
    Slider.MaxValue = max
    Slider.Value = default
    Slider.Parent = SliderFrame

    Slider.Changed:Connect(function(value)
        ValueLabel.Text = string.format("%.2f", value)
        callback(value)
    end)

    return SliderFrame
end

-- Populate the frame with settings
local SettingsContainer = Instance.new("ScrollingFrame")
SettingsContainer.Size = UDim2.new(1, -20, 1, -150)  -- Adjusted size
SettingsContainer.Position = UDim2.new(0, 10, 0, 90)  -- Adjusted position
SettingsContainer.BackgroundTransparency = 1
SettingsContainer.ScrollBarThickness = 5
SettingsContainer.CanvasSize = UDim2.new(0, 0, 0, 600)  -- 设置固定的画布大小
SettingsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y  -- 自动调整画布大小
SettingsContainer.ScrollingDirection = Enum.ScrollingDirection.Y
SettingsContainer.Parent = MainFrame

-- 用于跟踪垂直位置的变量
local currentY = 0
local spacing = 60  -- 每个元素之间的间距

-- 创建一个函数来添加元素并自动调整位置
local function AddElement(element)
    element.Position = UDim2.new(0, 0, 0, currentY)
    currentY = currentY + element.Size.Y.Offset + spacing
    element.Parent = SettingsContainer
end

-- Enabled Toggle
local enabledToggle = CreateToggle(SettingsContainer, "Aimbot Enabled", getgenv().Aimbot.Settings.Enabled, function(value)
    getgenv().Aimbot.Settings.Enabled = value
end)
AddElement(enabledToggle)

-- Team Check Toggle
local teamCheckToggle = CreateToggle(SettingsContainer, "Team Check", getgenv().Aimbot.Settings.TeamCheck, function(value)
    getgenv().Aimbot.Settings.TeamCheck = value
end)
AddElement(teamCheckToggle)

-- Alive Check Toggle
local aliveCheckToggle = CreateToggle(SettingsContainer, "Alive Check", getgenv().Aimbot.Settings.AliveCheck, function(value)
    getgenv().Aimbot.Settings.AliveCheck = value
end)
AddElement(aliveCheckToggle)

-- Wall Check Toggle
local wallCheckToggle = CreateToggle(SettingsContainer, "Wall Check", getgenv().Aimbot.Settings.WallCheck, function(value)
    getgenv().Aimbot.Settings.WallCheck = value
end)
AddElement(wallCheckToggle)

-- Third Person Toggle
local thirdPersonToggle = CreateToggle(SettingsContainer, "Third Person", getgenv().Aimbot.Settings.ThirdPerson, function(value)
    getgenv().Aimbot.Settings.ThirdPerson = value
end)
AddElement(thirdPersonToggle)

-- Sensitivity Slider
local sensitivitySlider = CreateSlider(SettingsContainer, "Sensitivity", 0, 1, getgenv().Aimbot.Settings.Sensitivity, function(value)
    getgenv().Aimbot.Settings.Sensitivity = value
end)
AddElement(sensitivitySlider)

-- Third Person Sensitivity Slider
local thirdPersonSensitivitySlider = CreateSlider(SettingsContainer, "Third Person Sensitivity", 0.1, 5, getgenv().Aimbot.Settings.ThirdPersonSensitivity, function(value)
    getgenv().Aimbot.Settings.ThirdPersonSensitivity = value
end)
AddElement(thirdPersonSensitivitySlider)

-- FOV Amount Slider
local fovAmountSlider = CreateSlider(SettingsContainer, "FOV Amount", 0, 360, getgenv().Aimbot.FOVSettings.Amount, function(value)
    getgenv().Aimbot.FOVSettings.Amount = value
end)
AddElement(fovAmountSlider)

-- UI Visibility Toggle
local UIVisible = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then  -- 使用右Ctrl键作为开关
        UIVisible = not UIVisible
        AimbotUI.Enabled = UIVisible
    end
end)

-- Restart Button
local RestartButton = Instance.new("TextButton")
RestartButton.Size = UDim2.new(1, -20, 0, 50)
RestartButton.Position = UDim2.new(0, 10, 1, -60)
RestartButton.Text = "Restart Aimbot"
RestartButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
RestartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RestartButton.Parent = MainFrame
RestartButton.MouseButton1Click:Connect(function()
    getgenv().Aimbot.Functions:Restart()
end)

-- Reset Settings Button
local ResetButton = Instance.new("TextButton")
ResetButton.Size = UDim2.new(1, -20, 0, 50)
ResetButton.Position = UDim2.new(0, 10, 1, -120)
ResetButton.Text = "Reset to Default Settings"
ResetButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Parent = MainFrame
ResetButton.MouseButton1Click:Connect(function()
    getgenv().Aimbot.Functions:ResetSettings()
end)

-- Make the frame draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 在脚本末尾添加调试信息
print("Aimbot UI Script Loaded")
print("PlayerGui:", PlayerGui)
print("Aimbot Environment:", getgenv().Aimbot)

-- 添加错误处理
pcall(function()
    if not AimbotUI.Parent then
        warn("AimbotUI could not be parented to PlayerGui")
    end
    
    if not MainFrame.Parent then
        warn("MainFrame could not be parented to AimbotUI")
    end
end)
--请勿盗窃Lorain作品，谢谢😍