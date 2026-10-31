-- Universal Fly Script with GUI for Roblox (Lua)
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local rep = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local flying = false
local speed = 50

local torso = nil
local head = nil
local humanoid = nil

local function getCharacterParts()
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        torso = plr.Character.HumanoidRootPart
        head = plr.Character.Head
        humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    end
end

plr.CharacterAdded:Connect(function()
    flying = false
    task.wait(1)
    getCharacterParts()
end)

getCharacterParts()

-- Create ScreenGui and Button
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = plr:WaitForChild("PlayerGui")

local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Size = UDim2.new(0, 120, 0, 50)
flyButton.Position = UDim2.new(0.8, 0, 0.2, 0) -- Position on the screen
flyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
flyButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
flyButton.BorderSizePixel = 2
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 18
flyButton.Font = Enum.Font.SourceSansBold
flyButton.Text = "Fly: OFF"
flyButton.Parent = screenGui

-- Toggle fly function
local function toggleFly()
    flying = not flying
    if flying then
        if humanoid then humanoid.PlatformStand = true end
        flyButton.Text = "Fly: ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        if humanoid then humanoid.PlatformStand = false end
        flyButton.Text = "Fly: OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end

-- Button click event
flyButton.MouseButton1Click:Connect(toggleFly)

-- Keyboard toggle (Key F)
uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)

-- Movement logic
local keys = {w = 0, s = 0, a = 0, d = 0, q = 0, e = 0}

uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.w = 1
    elseif input.KeyCode == Enum.KeyCode.S then keys.s = 1
    elseif input.KeyCode == Enum.KeyCode.A then keys.a = 1
    elseif input.KeyCode == Enum.KeyCode.D then keys.d = 1
    elseif input.KeyCode == Enum.KeyCode.E then keys.e = 1
    elseif input.KeyCode == Enum.KeyCode.Q then keys.q = 1
    end
end)

uis.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then keys.w = 0
    elseif input.KeyCode == Enum.KeyCode.S then keys.s = 0
    
