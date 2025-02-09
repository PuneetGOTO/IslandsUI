print("Loading Islands UI...")
warn("Initializing...")

repeat wait() until game:IsLoaded()

local ScriptVersion = "V4"
local FileName = "Islands"
local GameName = "Islands"
local NotificationIcon = "rbxassetid://1234567890"

function SendNotification(Title, Text)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = Title,
        Text = Text,
        Icon = NotificationIcon
    })
end    

SendNotification("Welcome!", "Welcome to "..FileName .. " " .. ScriptVersion.."!")

local CloneFolder

if game:GetService("Workspace"):FindFirstChild("Clones") then
    CloneFolder = game:GetService("Workspace"):FindFirstChild("Clones")
else
    local F = Instance.new("Model")
    F.Parent = game:GetService("Workspace")
    F.Name = "Clones"
    CloneFolder = F
end

-- 加载UI库
local NofLibery = loadstring(game:HttpGet('https://raw.githubusercontent.com/NtReadVirtualMemory/Open-Source-Scripts/refs/heads/main/Rayfield.lua'))()
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/IJHGIAJGIHJASUIJGHIUHIUHSUIAOHJAHOIBNAO/Nekohub/main/Fluent-master/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/IJHGIAJGIHJASUIJGHIUHIUHSUIAOHJAHOIBNAO/Nekohub/main/Fluent-master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/IJHGIAJGIHJASUIJGHIUHIUHSUIAOHJAHOIBNAO/Nekohub/main/Fluent-master/Addons/InterfaceManager.lua"))()

_G.Island_USERID = game.Players.LocalPlayer.UserId

local CANUSEAUTOCLICKER = true
local MaxCropDis = 30

-- 浮动部分
local FloatRender
local FloatPart
local UseFloat = false

local Float_Part = Instance.new('Part')
Float_Part.Name = "floatName"
Float_Part.Parent = game.Players.LocalPlayer.Character
Float_Part.Transparency = 1
Float_Part.Size = Vector3.new(2,0.2,1.5)
Float_Part.Anchored = true
FloatPart = Float_Part

FloatRender = game:GetService("RunService").RenderStepped:Connect(function()
    if UseFloat == true then
        Float_Part.CanCollide = true
        Float_Part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.1,0) 
    else
        Float_Part.CanCollide = false
    end
end)

-- 防AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)

_G.TeleportSpeed = 30
