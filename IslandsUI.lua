print("HI")
warn("HI")
for i = 1, 50 do
  print("战斗++")
end

-- This is a pretty old script so dont joke abt the source type (its older than 90% of Roblox comminity) --

repeat wait() until game:IsLoaded()

local IsPremium = true 
local DidKey = false
local ScriptVersion = "V4"

local FileName = "战斗++"
local GameName = "Islands"
local DeveloperVersion = true

local NotificationIcon = "rbxassetid://1234567890"

function SendNotification(Title, Text)
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = Title,
		Text = Text,
		Icon = NotificationIcon
	})
end	

SendNotification("Welcome!", "Welcome to "..FileName .. " " .. ScriptVersion.."!")

local PremiumText1 = "Premium is only 2$ Lifetime. Go buy it in discord.gg/MbsxuDEzgT"

if isfolder(FileName) then
else
	makefolder(FileName)
end

if isfolder(FileName.."/"..GameName) then
else
	makefolder(FileName.."/"..GameName)
end

function IsFile(Name)
	return isfile(FileName.."/"..GameName.."/"..Name)
end	

function IsFolder(Name)
	return isfolder(FileName.."/"..GameName.."/"..Name)
end	

function ReadFile(Name) 
	if isfile(FileName.."/"..GameName.."/"..Name) == true then
		return readfile(FileName.."/"..GameName.."/"..Name)
	else
		return readfile(FileName.."/"..GameName..Name)
	end
	return readfile(FileName.."/"..GameName.."/"..Name)
end

function CreateFolder(Name)
	makefolder(FileName.."/"..GameName.."/"..Name)
end	

function CreateFile(Name, Data, CheckIfFile)
	if CheckIfFile == true then
		if isfile(FileName.."/"..GameName.."/"..Name) then
		else
			writefile(FileName.."/"..GameName.."/"..Name, Data)
		end
	else
		writefile(FileName.."/"..GameName.."/"..Name, Data)
	end
end	

task.wait(1)

function GetSchematicaFiles()
	local Path = FileName.."/"..GameName.."/".."Schematica"
	local Files = listfiles(Path)
	if not Files or (#Files == 0) then
		local TemplateFile = game:HttpGet("https://pastebin.com/raw/yQUgfbZy")
		CreateFile("/Schematica/Template", TemplateFile, false)
		task.wait(1)
		local Files = listfiles(Path)
		return Files
	else
		return Files
	end
end

CreateFolder("Schematica")
CreateFolder("ello")

if IsPremium == false then
	IsPremium = true
	DidKey = true
else
	DidKey = false
end

local CloneFolder
if game:GetService("Workspace"):FindFirstChild("Clones/战斗++") then
	CloneFolder = game:GetService("Workspace"):FindFirstChild("Clones/战斗++")
else
	local F = Instance.new("Model")
	F.Parent = game:GetService("Workspace")
	F.Name = "Clones/战斗++"
	CloneFolder = F
end

-- Islands UI Script
-- Author: 战斗++
-- Version: 1.1

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 初始化设置
if not getgenv().IslandsSettings then
    getgenv().IslandsSettings = {
        AutoFarm = {
            Enabled = false,
            Target = "Trees",  -- Trees, Rocks, Crops
            Range = 10,
            AutoCollect = true
        },
        Mining = {
            Enabled = false,
            Target = "Stone", -- Stone, Iron, Gold
            Range = 15,
            AutoCollect = true
        },
        AutoCollect = {
            Enabled = false,
            Range = 15
        },
        AutoSell = {
            Enabled = false,
            Items = {}
        },
        SafeMode = true -- 防检测模式
    }
end

-- Create ScreenGui
local IslandsUI = Instance.new("ScreenGui")
IslandsUI.Name = "IslandsUI"
IslandsUI.Parent = PlayerGui
IslandsUI.IgnoreGuiInset = true
IslandsUI.ResetOnSpawn = false

-- Create main frame with dark theme
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = IslandsUI

-- Add corner radius
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Title text
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Islands Hub v1.1 By 战斗++"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

-- Left sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

-- Main content area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -120, 1, -40)
ContentArea.Position = UDim2.new(0, 120, 0, 40)
ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

-- Create sidebar buttons
local function CreateSidebarButton(text, position)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, position)
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamSemibold
    Button.Parent = Sidebar
    
    -- Add hover effect
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    
    return Button
end

-- Add sidebar buttons
local FarmingButton = CreateSidebarButton("Farming", 0)
local MiningButton = CreateSidebarButton("Mining", 40)
local SettingsButton = CreateSidebarButton("Settings", 80)

-- Create toggle function
local function CreateToggle(text, position, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.Position = UDim2.new(0, 10, 0, position)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentArea
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(0, 10)
    ToggleButtonCorner.Parent = ToggleButton
    
    local isEnabled = false
    ToggleButton.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        ToggleButton.BackgroundColor3 = isEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        if callback then
            callback(isEnabled)
        end
    end)
    
    return ToggleButton
end

-- Add farming toggles
local function ShowFarmingPage()
    for _, child in pairs(ContentArea:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    CreateToggle("Auto Farm Trees", 10, function(enabled)
        getgenv().IslandsSettings.AutoFarm.Enabled = enabled
        getgenv().IslandsSettings.AutoFarm.Target = "Trees"
    end)
    
    CreateToggle("Auto Farm Crops", 60, function(enabled)
        getgenv().IslandsSettings.AutoFarm.Enabled = enabled
        getgenv().IslandsSettings.AutoFarm.Target = "Crops"
    end)
    
    CreateToggle("Auto Collect", 110, function(enabled)
        getgenv().IslandsSettings.AutoCollect.Enabled = enabled
    end)
end

-- Add mining toggles
local function ShowMiningPage()
    for _, child in pairs(ContentArea:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    CreateToggle("Auto Mine Stone", 10, function(enabled)
        getgenv().IslandsSettings.Mining.Enabled = enabled
        getgenv().IslandsSettings.Mining.Target = "Stone"
    end)
    
    CreateToggle("Auto Mine Iron", 60, function(enabled)
        getgenv().IslandsSettings.Mining.Enabled = enabled
        getgenv().IslandsSettings.Mining.Target = "Iron"
    end)
    
    CreateToggle("Auto Mine Gold", 110, function(enabled)
        getgenv().IslandsSettings.Mining.Enabled = enabled
        getgenv().IslandsSettings.Mining.Target = "Gold"
    end)
end

-- Connect sidebar buttons
FarmingButton.MouseButton1Click:Connect(ShowFarmingPage)
MiningButton.MouseButton1Click:Connect(ShowMiningPage)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    IslandsUI.Enabled = false
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

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Create toggle button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "I"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = IslandsUI

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 20)
ToggleCorner.Parent = ToggleButton

-- Make toggle button draggable
local toggleDragging
local toggleDragInput
local toggleDragStart
local toggleStartPos

local function updateTogglePosition(input)
    local delta = input.Position - toggleDragStart
    ToggleButton.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then  -- 右键拖动
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                toggleDragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        toggleDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == toggleDragInput and toggleDragging then
        updateTogglePosition(input)
    end
end)

-- Default hide main frame
MainFrame.Visible = false

-- Add show/hide functionality
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Show farming page by default
ShowFarmingPage()

-- 添加自动采集功能
local function startAutoCollect()
    if not getgenv().IslandsSettings.AutoCollect.Enabled then return end
    
    RunService.Heartbeat:Connect(function()
        if not getgenv().IslandsSettings.AutoCollect.Enabled then return end
        
        local range = getgenv().IslandsSettings.AutoCollect.Range
        local items = workspace:GetChildren()
        
        for _, item in pairs(items) do
            if item:IsA("BasePart") and item.Name == "DroppedItem" then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - item.Position).Magnitude
                if distance <= range then
                    -- 使用安全的远程事件来收集物品
                    game:GetService("ReplicatedStorage").Events.CollectItem:FireServer(item)
                end
            end
        end
    end)
end

-- 添加自动采矿功能
local function startAutoMining()
    if not getgenv().IslandsSettings.Mining.Enabled then return end
    
    RunService.Heartbeat:Connect(function()
        if not getgenv().IslandsSettings.Mining.Enabled then return end
        
        local range = getgenv().IslandsSettings.Mining.Range
        local target = getgenv().IslandsSettings.Mining.Target
        local blocks = workspace:GetChildren()
        
        for _, block in pairs(blocks) do
            if block:IsA("BasePart") and block.Name:lower():find(target:lower()) then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - block.Position).Magnitude
                if distance <= range then
                    -- 使用安全的远程事件来挖矿
                    game:GetService("ReplicatedStorage").Events.MineBlock:FireServer(block)
                end
            end
        end
    end)
end

-- 添加防检测系统
local function initSafetySystem()
    if not getgenv().IslandsSettings.SafeMode then return end
    
    -- 随机延迟
    local function randomDelay()
        wait(math.random(1, 3) / 10)
    end
    
    -- 检测游戏管理员
    Players.PlayerAdded:Connect(function(player)
        if player:GetRankInGroup(12345) >= 100 then -- 替换为实际的群组ID
            getgenv().IslandsSettings.AutoFarm.Enabled = false
            getgenv().IslandsSettings.Mining.Enabled = false
            getgenv().IslandsSettings.AutoCollect.Enabled = false
        end
    end)
end

-- 初始化所有系统
startAutoCollect()
startAutoMining()
initSafetySystem()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("战斗++ "..ScriptVersion, "DarkTheme")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")
local FarmingTab = Window:NewTab("Farming")
local FarmingSection = FarmingTab:NewSection("Farming")
local MiscTab = Window:NewTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")
local SchematicaTab = Window:NewTab("Schematica")
local SchematicaSection = SchematicaTab:NewSection("Schematica")
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Settings")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local function GetRoot()
	return LocalPlayer.Character.HumanoidRootPart
end

local function GetCharacter()
	return LocalPlayer.Character
end

local function GetHumanoid()
	return LocalPlayer.Character.Humanoid
end

local function GetPosition()
	return GetRoot().Position
end

local function GetMagnitude(pos1, pos2)
	return (pos1 - pos2).Magnitude
end

local function GetDistance(pos)
	return GetMagnitude(GetPosition(), pos)
end

local function TweenTo(CF)
	local Time = (GetRoot().Position - CF.Position).Magnitude/100
	local Tween = TweenService:Create(GetRoot(), TweenInfo.new(Time, Enum.EasingStyle.Linear), {CFrame = CF})
	Tween:Play()
	Tween.Completed:Wait()
end

local function GetClosest(List)
	local Target = nil
	local Distance = math.huge
	for i,v in pairs(List) do
		if GetDistance(v.Position) < Distance then
			Distance = GetDistance(v.Position)
			Target = v
		end
	end
	return Target
end

local function GetClosestWithName(List, Name)
	local Target = nil
	local Distance = math.huge
	for i,v in pairs(List) do
		if v.Name == Name and GetDistance(v.Position) < Distance then
			Distance = GetDistance(v.Position)
			Target = v
		end
	end
	return Target
end

local function GetClosestWithNameAndDistance(List, Name, MaxDistance)
	local Target = nil
	local Distance = math.huge
	for i,v in pairs(List) do
		if v.Name == Name and GetDistance(v.Position) < Distance and GetDistance(v.Position) <= MaxDistance then
			Distance = GetDistance(v.Position)
			Target = v
		end
	end
	return Target
end

local function GetClosestWithNameList(List, Names)
	local Target = nil
	local Distance = math.huge
	for i,v in pairs(List) do
		for _,Name in pairs(Names) do
			if v.Name == Name and GetDistance(v.Position) < Distance then
				Distance = GetDistance(v.Position)
				Target = v
			end
		end
	end
	return Target
end

local function GetClosestWithNameListAndDistance(List, Names, MaxDistance)
	local Target = nil
	local Distance = math.huge
	for i,v in pairs(List) do
		for _,Name in pairs(Names) do
			if v.Name == Name and GetDistance(v.Position) < Distance and GetDistance(v.Position) <= MaxDistance then
				Distance = GetDistance(v.Position)
				Target = v
			end
		end
	end
	return Target
end

local function GetAllWithName(List, Name)
	local Targets = {}
	for i,v in pairs(List) do
		if v.Name == Name then
			table.insert(Targets, v)
		end
	end
	return Targets
end

local function GetAllWithNameList(List, Names)
	local Targets = {}
	for i,v in pairs(List) do
		for _,Name in pairs(Names) do
			if v.Name == Name then
				table.insert(Targets, v)
			end
		end
	end
	return Targets
end

local function GetAllWithNameAndDistance(List, Name, MaxDistance)
	local Targets = {}
	for i,v in pairs(List) do
		if v.Name == Name and GetDistance(v.Position) <= MaxDistance then
			table.insert(Targets, v)
		end
	end
	return Targets
end

local function GetAllWithNameListAndDistance(List, Names, MaxDistance)
	local Targets = {}
	for i,v in pairs(List) do
		for _,Name in pairs(Names) do
			if v.Name == Name and GetDistance(v.Position) <= MaxDistance then
				table.insert(Targets, v)
			end
		end
	end
	return Targets
end

-- Main Tab Functions
MainSection:NewToggle("Auto Farm", "Automatically farms resources", function(state)
    getgenv().AutoFarm = state
    while getgenv().AutoFarm do
        wait()
        local target = GetClosestWithNameList(workspace:GetChildren(), {"Tree", "Stone", "Iron", "Gold"})
        if target then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:MoveTo(target.Position)
                wait(1)
                local tool = LocalPlayer.Backpack:FindFirstChild("Axe") or LocalPlayer.Character:FindFirstChild("Axe")
                if tool then
                    humanoid:EquipTool(tool)
                    wait(0.5)
                    tool:Activate()
                end
            end
        end
    end
end)

MainSection:NewToggle("Auto Collect", "Automatically collects dropped items", function(state)
    getgenv().AutoCollect = state
    while getgenv().AutoCollect do
        wait()
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                wait()
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
end)

-- Farming Tab Functions
FarmingSection:NewToggle("Auto Plant", "Automatically plants seeds", function(state)
    getgenv().AutoPlant = state
    while getgenv().AutoPlant do
        wait()
        local plot = GetClosestWithName(workspace:GetChildren(), "Plot")
        if plot then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:MoveTo(plot.Position)
                wait(1)
                local tool = LocalPlayer.Backpack:FindFirstChild("Seed") or LocalPlayer.Character:FindFirstChild("Seed")
                if tool then
                    humanoid:EquipTool(tool)
                    wait(0.5)
                    tool:Activate()
                end
            end
        end
    end
end)

FarmingSection:NewToggle("Auto Harvest", "Automatically harvests crops", function(state)
    getgenv().AutoHarvest = state
    while getgenv().AutoHarvest do
        wait()
        local crop = GetClosestWithNameList(workspace:GetChildren(), {"Wheat", "Carrot", "Potato"})
        if crop then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:MoveTo(crop.Position)
                wait(1)
                local tool = LocalPlayer.Backpack:FindFirstChild("Sickle") or LocalPlayer.Character:FindFirstChild("Sickle")
                if tool then
                    humanoid:EquipTool(tool)
                    wait(0.5)
                    tool:Activate()
                end
            end
        end
    end
end)

-- Misc Tab Functions
MiscSection:NewButton("Teleport to Base", "Teleports you to your base", function()
    local base = workspace:FindFirstChild("Base")
    if base then
        LocalPlayer.Character:MoveTo(base.Position)
    end
end)

MiscSection:NewButton("Collect All", "Collects all dropped items", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
            wait()
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
        end
    end
end)

-- Schematica Tab Functions
SchematicaSection:NewDropdown("Load Schematic", "Loads a schematic", GetSchematicaFiles(), function(currentOption)
    local schematic = ReadFile("/Schematica/"..currentOption)
    -- Add your schematic loading logic here
end)

SchematicaSection:NewButton("Save Current Build", "Saves current build as schematic", function()
    -- Add your schematic saving logic here
end)

-- Settings Tab Functions
SettingsSection:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

SettingsSection:NewColorPicker("UI Color", "Changes the UI color", Color3.fromRGB(0,1,1), function(color)
    -- Add your color changing logic here
end)

-- Initialize Safety System
local function initSafetySystem()
    local function checkRank()
        local rank = LocalPlayer:GetRankInGroup(123456) -- Replace with actual group ID
        return rank >= 0 -- Allow all ranks
    end
    
    if not checkRank() then
        Library:Destroy()
        LocalPlayer:Kick("Unauthorized")
    end
end

-- Start Auto Mining
local function startAutoMining()
    spawn(function()
        while wait() do
            if getgenv().AutoFarm then
                local target = GetClosestWithNameList(workspace:GetChildren(), {"Stone", "Iron", "Gold"})
                if target then
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:MoveTo(target.Position)
                        wait(1)
                        local tool = LocalPlayer.Backpack:FindFirstChild("Pickaxe") or LocalPlayer.Character:FindFirstChild("Pickaxe")
                        if tool then
                            humanoid:EquipTool(tool)
                            wait(0.5)
                            tool:Activate()
                        end
                    end
                end
            end
        end
    end)
end

-- Initialize
initSafetySystem()
startAutoMining()

print("Islands UI Script Loaded Successfully!")
