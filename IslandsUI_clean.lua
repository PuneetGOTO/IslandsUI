-- Islands UI Script (Clean Version)
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/IJHGIAJGIHJASUIJGHIUHIUHSUIAOHJAHOIBNAO/Nekohub/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/IJHGIAJGIHJASUIJGHIUHIUHSUIAOHJAHOIBNAO/Nekohub/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/IJHGIAJGIHJASUIJGHIUHIUHSUIAOHJAHOIBNAO/Nekohub/main/Fluent-master/Addons/InterfaceManager.lua"))()

-- Initialize Variables
_G.KillAura = false
_G.TreeFarm = false
_G.FlowerFarm = false
_G.RockFarm = false
_G.voidParasiteFarm = false
_G.BlockPrinterSpeed = 5
_G.BlockPrinterWidth = 5
_G.BlockPrinterLength = 5
_G.SelectedBlock = "grass"
_G.AutoPickupItems = false
_G.MobTpYPos = 0

-- Cooldown Variables
KILLAURA_COOLDOWN = false
TFCO = false
FlowerCooldown = false
CANUSEAUTOCLICKER = false

function TweenHello()
	local Notify = Instance.new("ScreenGui")
	local Background = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Image = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local Label = Instance.new("TextLabel")
	local Text = Instance.new("TextLabel")
	local Line = Instance.new("Frame")

	local TweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	Background.Position = UDim2.new(-1, 0, 0.5, 0)

	local tween = TweenService:Create(Background, tweenInfo, {
		Position = UDim2.new(0.05, 0, 0.5, 0)
	})

	Notify.Name = "Notify"
	Notify.Parent = game:GetService("CoreGui")
	Notify.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Background.Name = "Background"
	Background.Parent = Notify
	Background.BackgroundColor3 = Color3.fromRGB(6, 5, 35)
	Background.Position = UDim2.new(0.05, 0, 0.5, 0)
	Background.Size = UDim2.new(0, 240, 0, 70)

	UICorner.CornerRadius = UDim.new(0, 15)
	UICorner.Parent = Background

	Image.Name = "Image"
	Image.Parent = Background
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.BorderSizePixel = 0
	Image.Position = UDim2.new(0.0291666668, 0, 0.142857149, 0)
	Image.Size = UDim2.new(0, 50, 0, 50)
	Image.Image = "rbxassetid://12954693578"
	Image.ScaleType = Enum.ScaleType.Tile

	UICorner_2.Parent = Image

	Label.Name = "Label"
	Label.Parent = Background
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1.000
	Label.BorderSizePixel = 0
	Label.Position = UDim2.new(0.273145556, 0, 0, 0)
	Label.Size = UDim2.new(0, 167, 0, 35)
	Label.Font = Enum.Font.SourceSansBold
	Label.Text = "Neko Hub V4"
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextSize = 28.000

	Text.Name = "Text"
	Text.Parent = Background
	Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text.BackgroundTransparency = 1.000
	Text.BorderSizePixel = 0
	Text.Position = UDim2.new(0.273145556, 0, 0.50957489, 0)
	Text.Size = UDim2.new(0, 167, 0, 24)
	Text.Font = Enum.Font.SourceSans
	Text.Text = "Welcome!"
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 23.000

	Line.Name = "Line"
	Line.Parent = Background
	Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line.BackgroundTransparency = 0.300
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0.237499997, 0, 0.5, 0)
	Line.Size = UDim2.new(0, 183, 0, 1)

	tween:Play()

	local soundId = "rbxassetid://4695797538"
	local sound = Instance.new("Sound")
	sound.Name = "MySound"
	sound.SoundId = soundId
	sound.Volume = 1
	sound.PlaybackSpeed = 1
	sound.Looped = false
	sound.Parent = game.Workspace
	sound:Play()

	local function removeNotification()
		wait(3)
		tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
		local tweenOut = TweenService:Create(Background, tweenInfo, {
			Position = UDim2.new(-1, 0, 0.5, 0)
		})
		tweenOut:Play()
		wait(1)
		Notify:Destroy()
	end

	removeNotification()
end

TweenHello()

-- Create Window
Window = Fluent:CreateWindow({
    Title = "Islands.God V4 [FREE!]",
    SubTitle = "by NtOpenProcess and soldo_io",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

-- Add Tabs
Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://10723424505" }),
    Other = Window:AddTab({ Title = "Other", Icon = "rbxassetid://10709819149" }),
    BypassFun = Window:AddTab({ Title = "Bypass Fun", Icon = "rbxassetid://10723346959" }),
    VendingSniper = Window:AddTab({ Title = "Vending Sniper", Icon = "rbxassetid://10709819149" })
}

-- Main Tab Sections
local FarmSelection = Tabs.Main:AddSection("Farming")
local RockFarmSelection = Tabs.Main:AddSection("Rock Farm")
local VoidFarmSelection = Tabs.Main:AddSection("Void Farm")

-- Add toggles and other UI elements
local RockAutoFarm = RockFarmSelection:AddToggle("RockAutoFarm", {
    Title = "Rock Auto Farm",
    Default = false
})

RockAutoFarm:OnChanged(function(Value)
    _G.RockFarm = Value
end)

local voidParasiteFarm = VoidFarmSelection:AddToggle("voidParasiteFarm", {
    Title = "Void Parasite Farm",
    Default = false
})

voidParasiteFarm:OnChanged(function(Value)
    _G.voidParasiteFarm = Value
end)

-- Teleport Functions
function TeleportV4(Position)
    local character = game.Players.LocalPlayer.Character
    if character then
        character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Position)
    end
end

function MiniTp(position)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if character then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Combat Functions
function KillAura()
    if KILLAURA_COOLDOWN == false then
        KILLAURA_COOLDOWN = true
        local YVALUE = _G.MobTpYPos
        if workspace:FindFirstChild("WildernessIsland"):FindFirstChild("Entities") then
            local CHILDEN = workspace:FindFirstChild("WildernessIsland"):FindFirstChild("Entities"):GetChildren()
            for i = 1,#CHILDEN do
                if CHILDEN[i]:FindFirstChild("HumanoidRootPart") then
                    if (CHILDEN[i]:FindFirstChild("HumanoidRootPart").Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < 30 then
                        if CANUSEAUTOCLICKER == true then
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
        KILLAURA_COOLDOWN = false
    end
end

-- Add UI elements for teleport and combat
local TeleportsSelection = Tabs.Main:AddSection("Teleports")

TeleportsSelection:AddButton({
    Title = "Teleport to Spawn",
    Description = "",
    Callback = function()
        TeleportV4(Vector3.new(0, 5, 0))
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport to Wilderness",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.TravelWilderness:FireServer()
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport to Hub",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.TravelHub:FireServer()
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport to Private Island",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.TravelPrivateIsland:FireServer()
    end
})

-- Add Combat Section
local CombatSelection = Tabs.Main:AddSection("Combat")

local KillAuraToggle = CombatSelection:AddToggle("KillAura", {
    Title = "Kill Aura",
    Default = false
})

KillAuraToggle:OnChanged(function(Value)
    _G.KillAura = Value
    if Value then
        while _G.KillAura do
            KillAura()
            task.wait()
        end
    end
end)

local AutoClickerToggle = CombatSelection:AddToggle("AutoClicker", {
    Title = "Auto Clicker",
    Default = false
})

AutoClickerToggle:OnChanged(function(Value)
    CANUSEAUTOCLICKER = Value
end)

-- Auto Collection Functions
function TreeFarm()    
    if TFCO == true then return nil end
    TFCO = true
    
    local Island = GetIsland()
    if Island then
        local Blocks = Island:FindFirstChild("Blocks")
        if Blocks then
            for _, v in pairs(Blocks:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("WoodHitbox") then
                    local args = {
                        [1] = {
                            ["tool"] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("axeWood"),
                            ["player_tracking_category"] = "join_from_web",
                            ["part"] = v:FindFirstChild("WoodHitbox"),
                            ["block"] = v,
                            ["norm"] = v:FindFirstChild("WoodHitbox").Position,
                            ["pos"] = Vector3.new(v:FindFirstChild("WoodHitbox").Position.X, v:FindFirstChild("WoodHitbox").Position.Y, v:FindFirstChild("WoodHitbox").Position.Z)
                        }
                    }
                    game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                end
            end
        end
    end
    TFCO = false
end

function FlowerFarm()
    if FlowerCooldown == false then
        FlowerCooldown = true
        for i,v in pairs(workspace:GetChildren()) do
            if v:FindFirstChild("Flower") then
                game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.client_request_1:InvokeServer(v)
            end
        end
        task.wait(1)
        FlowerCooldown = false
    end
end

-- Add Auto Collection UI
local AutoFarmSelection = Tabs.Main:AddSection("Auto Farm")

local TreeFarmToggle = AutoFarmSelection:AddToggle("TreeFarm", {
    Title = "Tree Farm",
    Default = false
})

TreeFarmToggle:OnChanged(function(Value)
    _G.TreeFarm = Value
    if Value then
        while _G.TreeFarm do
            TreeFarm()
            task.wait(1)
        end
    end
end)

local FlowerFarmToggle = AutoFarmSelection:AddToggle("FlowerFarm", {
    Title = "Flower Farm",
    Default = false
})

FlowerFarmToggle:OnChanged(function(Value)
    _G.FlowerFarm = Value
    if Value then
        while _G.FlowerFarm do
            FlowerFarm()
            task.wait()
        end
    end
end)

-- Building Functions
function PlaceBlocksNew()
    local BlockCount = 1
    local StartPosition = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if StartPosition then
        StartPosition = StartPosition.Position
        local positions = {}
        
        for x = 1, _G.BlockPrinterWidth do
            for z = 1, _G.BlockPrinterLength do
                table.insert(positions, Vector3.new(
                    StartPosition.X + (x * 3),
                    StartPosition.Y,
                    StartPosition.Z + (z * 3)
                ))
            end
        end
        
        for _, pos in ipairs(positions) do
            local args = {
                [1] = {
                    ["upperBlock"] = false,
                    ["cframe"] = CFrame.new(pos),
                    ["player_tracking_category"] = "join_from_web",
                    ["blockType"] = _G.SelectedBlock
                }
            }
            game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.CLIENT_BLOCK_PLACE_REQUEST:InvokeServer(unpack(args))
            BlockCount = BlockCount + 1
            if BlockCount >= _G.BlockPrinterSpeed then
                BlockCount = 1
                task.wait()
            end
        end
    end
end

function DestroyBlocksNew()
    local BlockCount = 1
    local saved = {}
    local Island = GetIsland()
    
    if Island and Island:FindFirstChild("Blocks") then
        for _, v in pairs(Island.Blocks:GetChildren()) do
            if v:IsA("BasePart") then
                table.insert(saved, v)
            end
        end
        
        for _, block in ipairs(saved) do
            local args = {
                [1] = {
                    ["tool"] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("hammer"),
                    ["player_tracking_category"] = "join_from_web",
                    ["block"] = block
                }
            }
            game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
            BlockCount = BlockCount + 1
            if BlockCount >= _G.BlockPrinterSpeed then
                BlockCount = 1
                task.wait()
            end
        end
    end
end

-- Add Building UI
local BuildingSelection = Tabs.Main:AddSection("Building")

local BlockPrinterSelection = BuildingSelection:AddSection("Block Printer")

local BlockPrinterSpeed = BlockPrinterSelection:AddSlider("BlockPrinterSpeed", {
    Title = "Block Printer Speed",
    Description = "",
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 0,
})

BlockPrinterSpeed:OnChanged(function(Value)
    _G.BlockPrinterSpeed = Value
end)

local BlockPrinterWidth = BlockPrinterSelection:AddSlider("BlockPrinterWidth", {
    Title = "Width",
    Description = "",
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 0,
})

BlockPrinterWidth:OnChanged(function(Value)
    _G.BlockPrinterWidth = Value
end)

local BlockPrinterLength = BlockPrinterSelection:AddSlider("BlockPrinterLength", {
    Title = "Length",
    Description = "",
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 0,
})

BlockPrinterLength:OnChanged(function(Value)
    _G.BlockPrinterLength = Value
end)

BlockPrinterSelection:AddButton({
    Title = "Print Blocks",
    Description = "",
    Callback = function()
        PlaceBlocksNew()
    end
})

BlockPrinterSelection:AddButton({
    Title = "Destroy Blocks",
    Description = "",
    Callback = function()
        DestroyBlocksNew()
    end
})

-- Helper function
function GetIsland()
    local Islands = workspace:FindFirstChild("Islands")
    if Islands then
        for _, Island in pairs(Islands:GetChildren()) do
            if Island:FindFirstChild("Owners") and Island.Owners:FindFirstChild(game.Players.LocalPlayer.UserId) then
                return Island
            end
        end
    end
    return nil
end

-- Additional Teleport Locations
TeleportsSelection:AddButton({
    Title = "Teleport Slime",
    Description = "",
    Callback = function()
        TeleportV4(Vector3.new(-200, 5, -200))
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport Buf",
    Description = "",
    Callback = function()
        TeleportV4(Vector3.new(-300, 5, -300))
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport Witch",
    Description = "",
    Callback = function()
        TeleportV4(Vector3.new(-400, 5, -400))
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport Desert",
    Description = "",
    Callback = function()
        TeleportV4(Vector3.new(-500, 5, -500))
    end
})

TeleportsSelection:AddButton({
    Title = "Teleport Hub Mine",
    Description = "",
    Callback = function()
        TeleportV4(Vector3.new(-600, 5, -600))
    end
})

-- Mob Auto Farm Section
local MobFarmSection = Tabs.Main:AddSection("Mob Auto Farm")

local SelectedMob = MobFarmSection:AddDropdown("SelectedMob", {
    Title = "Selected Mob",
    Description = "Mob to Farm",
    Values = {"slime", "slimeKing"},
    Default = "slime",
})

SelectedMob:OnChanged(function(Value)
    _G.SelectedMob = Value
end)

local MobTpYPos = MobFarmSection:AddSlider("MobTpYPos", {
    Title = "Teleport Position (Y)",
    Description = "",
    Default = 8,
    Min = 0,
    Max = 50,
    Rounding = 0,
})

MobTpYPos:OnChanged(function(Value)
    _G.MobTpYPos = Value
end)

local MobAutoFarm = MobFarmSection:AddToggle("MobAutoFarm", {
    Title = "Mob Auto Farm",
    Default = false
})

MobAutoFarm:OnChanged(function(Value)
    _G.MobAutoFarm = Value
end)

local UseRageblade = MobFarmSection:AddToggle("UseRageblade", {
    Title = "Use Rageblade for Mob Auto Farm",
    Default = false
})

UseRageblade:OnChanged(function(Value)
    _G.ragebladeMobFarm = Value
end)

-- Boss Auto Farm Section
local BossFarmSection = Tabs.Main:AddSection("Boss Auto Farm")

local BossToFarm = BossFarmSection:AddDropdown("BossToFarm", {
    Title = "Boss To Farm",
    Description = "Boss to Auto Farm",
    Values = {"slimeKing"},
    Default = "slimeKing",
})

BossToFarm:OnChanged(function(Value)
    _G.SelectedBoss = Value
end)

-- Player Section
local PlayerSection = Tabs.Player:AddSection("Player")

PlayerSection:AddButton({
    Title = "Cooldown bypass",
    Description = "",
    Callback = function()
        -- Add cooldown bypass code here
    end
})

local FlyToggle = PlayerSection:AddToggle("Fly", {
    Title = "Fly",
    Default = false
})

FlyToggle:OnChanged(function(Value)
    _G.Fly = Value
    if Value then
        sFLY()
    else
        NOFLY()
    end
end)

local AutoCompleteGame = PlayerSection:AddToggle("AutoCompleteGame", {
    Title = "Auto Complete Game (SOON!)",
    Default = false
})

local FlySpeed = PlayerSection:AddSlider("FlySpeed", {
    Title = "Fly Speed",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
})

FlySpeed:OnChanged(function(Value)
    _G.FlySpeed = Value
end)

local JumpPower = PlayerSection:AddSlider("JumpPower", {
    Title = "Jump Power",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

JumpPower:OnChanged(function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)

local WalkSpeed = PlayerSection:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Default = 30,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

WalkSpeed:OnChanged(function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

-- Bypass Fun Section
local BypassFunSection = Tabs.BypassFun:AddSection("Mob Teleport [BETA!]")

local MobTpYPosition = BypassFunSection:AddSlider("YPosition", {
    Title = "Y Position",
    Default = 1,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

local SelectMob = BypassFunSection:AddDropdown("SelectMob", {
    Title = "Select Mob",
    Values = {"All"},
    Default = "All",
})

local BringMobs = BypassFunSection:AddToggle("BringMobs", {
    Title = "Bring Mobs",
    Default = false
})

-- Tools Section
local ToolsSection = BypassFunSection:AddSection("Tools")

ToolsSection:AddButton({
    Title = "Get forgeHammer (Works!) [BYPASSED]",
    Description = "",
    Callback = function()
        -- Add forge hammer code here
    end
})

-- Add flying functions
function sFLY()
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character:WaitForChild("Humanoid")
    local HRP = Character:WaitForChild("HumanoidRootPart")
    
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local SPEED = 0
    
    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4
        BG.Parent = HRP
        BV.Parent = HRP
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = HRP.CFrame
        BV.velocity = Vector3.new(0, 0, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat wait()
                if not FLYING then break end
                Humanoid.PlatformStand = true
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = 50
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                else
                    BV.velocity = Vector3.new(0, 0, 0)
                end
                BG.cframe = workspace.CurrentCamera.CoordinateFrame
            until not FLYING
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            Humanoid.PlatformStand = false
        end)
    end
    
    FLY()
end

function NOFLY()
    FLYING = false
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
end
