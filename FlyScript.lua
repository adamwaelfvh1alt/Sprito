-- Fly Script with Mobile Support (UI Buttons for Speed and Movement Control)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local speed = 50  -- Default fly speed
local bodyVelocity
local flyingUp = false
local flyingDown = false

-- Create GUI for mobile devices
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "FlyGUI"

local function createButton(name, position, func)
    local button = Instance.new("TextButton", screenGui)
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 24
    button.TextButton.TextTransparency = 0.5

    -- TouchInput for mobile
    button.TouchTap:Connect(func)

    return button
end

-- Start flying
local function startFlying()
    if flying then return end
    flying = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.new(0, speed, 0)  -- Controls the vertical speed
    bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")

    humanoid.PlatformStand = true
end

-- Stop flying
local function stopFlying()
    if not flying then return end
    flying = false

    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    humanoid.PlatformStand = false
end

-- Fly up
local function flyUp()
    if not flying then
        startFlying()
    end
    bodyVelocity.Velocity = Vector3.new(0, speed, 0)
    flyingUp = true
    flyingDown = false
end

-- Fly down
local function flyDown()
    if not flying then
        startFlying()
    end
    bodyVelocity.Velocity = Vector3.new(0, -speed, 0)
    flyingDown = true
    flyingUp = false
end

-- Change speed
local function changeSpeed(newSpeed)
    speed = newSpeed
    if flying then
        bodyVelocity.Velocity = Vector3.new(0, speed, 0)
    end
end

-- Create buttons for UI controls
createButton("Fly Up", UDim2.new(0, 50, 0, 50), flyUp)
createButton("Fly Down", UDim2.new(0, 50, 0, 150), flyDown)
createButton("Stop Flying", UDim2.new(0, 50, 0, 250), stopFlying)

-- Create speed control buttons
createButton("Speed +", UDim2.new(0, 300, 0, 50), function()
    changeSpeed(speed + 10)
end)

createButton("Speed -", UDim2.new(0, 300, 0, 150), function()
    if speed > 10 then
        changeSpeed(speed - 10)
    end
end)

