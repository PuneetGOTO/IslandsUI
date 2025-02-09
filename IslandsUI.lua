-- Islands UI Script
-- Author: 战斗++
-- Version: 1.1

print("正在加载Islands UI脚本...")
warn("初始化中...")

-- 等待游戏加载
repeat wait() until game:IsLoaded()
print("游戏已加载完成")

-- 基本设置
local IsPremium = true 
local DidKey = false
local ScriptVersion = "V4"
local FileName = "战斗++"
local GameName = "Islands"
local NotificationIcon = "rbxassetid://1234567890"

-- 确保我们在正确的游戏中
if game.PlaceId ~= 4872321990 then
    warn("错误: 这个脚本只能在Islands中使用!")
    return
end

-- 获取服务
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 通知函数
local function SendNotification(Title, Text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = Title,
            Text = Text,
            Icon = NotificationIcon,
            Duration = 5
        })
    end)
end

SendNotification("Loading", "正在加载UI库...")

-- 尝试加载UI库
local Library

-- 尝试加载Orion UI库
local success = pcall(function()
    Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
end)

if not success then
    SendNotification("Error", "主UI库加载失败，尝试备用UI库...")
    -- 尝试加载Rayfield UI库
    success = pcall(function()
        Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    end)
    
    if not success then
        SendNotification("Error", "所有UI库加载失败!")
        warn("错误: 无法加载任何UI库!")
        return
    end
end

-- 创建窗口
local Window = Library:MakeWindow({
    Name = "战斗++ "..ScriptVersion,
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "战斗++"
})

SendNotification("Success", "UI库加载成功!")

-- 创建标签页
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local FarmingTab = Window:MakeTab({
    Name = "Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

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

-- Main Tab Functions
MainTab:AddToggle({
    Name = "Auto Farm",
    Default = getgenv().IslandsSettings.AutoFarm.Enabled,
    Callback = function(state)
        getgenv().IslandsSettings.AutoFarm.Enabled = state
        while getgenv().IslandsSettings.AutoFarm.Enabled do
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
    end
})

MainTab:AddToggle({
    Name = "Auto Collect",
    Default = getgenv().IslandsSettings.AutoCollect.Enabled,
    Callback = function(state)
        getgenv().IslandsSettings.AutoCollect.Enabled = state
        while getgenv().IslandsSettings.AutoCollect.Enabled do
            wait()
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                    wait()
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
                end
            end
        end
    end
})

-- Farming Tab Functions
FarmingTab:AddToggle({
    Name = "Auto Plant",
    Default = getgenv().IslandsSettings.AutoFarm.Enabled,
    Callback = function(state)
        getgenv().IslandsSettings.AutoFarm.Enabled = state
        while getgenv().IslandsSettings.AutoFarm.Enabled do
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
    end
})

FarmingTab:AddToggle({
    Name = "Auto Harvest",
    Default = getgenv().IslandsSettings.AutoFarm.Enabled,
    Callback = function(state)
        getgenv().IslandsSettings.AutoFarm.Enabled = state
        while getgenv().IslandsSettings.AutoFarm.Enabled do
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
    end
})

-- Misc Tab Functions
MiscTab:AddButton({
    Name = "Teleport to Base",
    Callback = function()
        local base = workspace:FindFirstChild("Base")
        if base then
            LocalPlayer.Character:MoveTo(base.Position)
        end
    end
})

MiscTab:AddButton({
    Name = "Collect All",
    Callback = function()
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                wait()
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
})

-- Settings Tab Functions
SettingsTab:AddToggle({
    Name = "Safe Mode",
    Default = getgenv().IslandsSettings.SafeMode,
    Callback = function(state)
        getgenv().IslandsSettings.SafeMode = state
    end
})

SettingsTab:AddKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        Library:ToggleUI()
    end
})

SettingsTab:AddColorPicker({
    Name = "UI Color",
    Default = Color3.fromRGB(0,1,1),
    Callback = function(color)
        -- Add your color changing logic here
    end
})

-- 初始化所有系统
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

print("Islands UI Script Loaded Successfully!")
