-- AlviHub — Elegant Gold UI
-- Safe UI scaffold for Roblox Studio (your own experience).
-- Place as a LocalScript in StarterPlayer > StarterPlayerScripts.
-- Gameplay-cheat actions (aimbot, silent aim, auto-kill, exploit movement,
-- auto-farm, anti-cheat bypass, remote executor loaders) are intentionally
-- not implemented. Add legitimate systems for your own game where appropriate.

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GOLD = Color3.fromRGB(212, 175, 55)
local BG = Color3.fromRGB(15, 15, 18)
local PANEL = Color3.fromRGB(24, 24, 28)
local TEXT = Color3.fromRGB(240, 237, 226)
local MUTED = Color3.fromRGB(160, 157, 148)

local gui = Instance.new("ScreenGui")
gui.Name = "AlviHubElegantGold"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 520, 0, 350)
main.Position = UDim2.new(0.5, -260, 0.5, -175)
main.BackgroundColor3 = BG
main.BackgroundTransparency = 0.08
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = GOLD
stroke.Transparency = 0.22
stroke.Thickness = 1.25
stroke.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundColor3 = PANEL
top.BorderSizePixel = 0
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 16, 0, 0)
title.Size = UDim2.new(1, -80, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "ALVIHUB  /  ELEGANT GOLD"
title.TextColor3 = GOLD
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 34, 0, 30)
close.Position = UDim2.new(1, -42, 0, 9)
close.BackgroundColor3 = Color3.fromRGB(45, 38, 22)
close.Text = "×"
close.TextColor3 = GOLD
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.Parent = top
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Drag support (mouse and touch)
local dragging, dragInput, dragStart, startPos
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.new(0, 12, 0, 60)
sidebar.Size = UDim2.new(0, 132, 1, -72)
sidebar.BackgroundColor3 = PANEL
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 9)

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 6)
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Parent = sidebar

local navPad = Instance.new("UIPadding")
navPad.PaddingTop = UDim.new(0, 10)
navPad.PaddingLeft = UDim.new(0, 8)
navPad.PaddingRight = UDim.new(0, 8)
navPad.Parent = sidebar

local content = Instance.new("ScrollingFrame")
content.Position = UDim2.new(0, 156, 0, 60)
content.Size = UDim2.new(1, -168, 1, -72)
content.BackgroundColor3 = PANEL
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = GOLD
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 9)

local contentPad = Instance.new("UIPadding")
contentPad.PaddingTop = UDim.new(0, 12)
contentPad.PaddingBottom = UDim.new(0, 12)
contentPad.PaddingLeft = UDim.new(0, 12)
contentPad.PaddingRight = UDim.new(0, 12)
contentPad.Parent = content

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child ~= contentPad and child ~= contentLayout then
            child:Destroy()
        end
    end
end

local function heading(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 26)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = GOLD
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
end

local function note(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 42)
    label.BackgroundTransparency = 1
    label.TextWrapped = true
    label.Text = text
    label.TextColor3 = MUTED
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.Parent = content
end

local function toggleRow(labelText, defaultValue, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = Color3.fromRGB(31, 31, 36)
    row.BorderSizePixel = 0
    row.Parent = content
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

    local label = Instance.new("TextLabel")
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(1, -64, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = TEXT
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 42, 0, 23)
    button.Position = UDim2.new(1, -50, 0.5, -11)
    button.BackgroundColor3 = defaultValue and GOLD or Color3.fromRGB(62, 62, 68)
    button.Text = defaultValue and "ON" or "OFF"
    button.TextColor3 = defaultValue and BG or TEXT
    button.Font = Enum.Font.GothamBold
    button.TextSize = 10
    button.Parent = row
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

    local state = defaultValue
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = state and "ON" or "OFF"
        button.BackgroundColor3 = state and GOLD or Color3.fromRGB(62, 62, 68)
        button.TextColor3 = state and BG or TEXT
        if callback then callback(state) end
    end)
end

local function sliderRow(labelText, minValue, maxValue, initial, callback)
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(1, 0, 0, 58)
    wrap.BackgroundColor3 = Color3.fromRGB(31, 31, 36)
    wrap.BorderSizePixel = 0
    wrap.Parent = content
    Instance.new("UICorner", wrap).CornerRadius = UDim.new(0, 7)

    local label = Instance.new("TextLabel")
    label.Position = UDim2.new(0, 10, 0, 4)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = TEXT
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = wrap

    local bar = Instance.new("TextButton")
    bar.Position = UDim2.new(0, 10, 0, 32)
    bar.Size = UDim2.new(1, -20, 0, 12)
    bar.BackgroundColor3 = Color3.fromRGB(62, 62, 68)
    bar.Text = ""
    bar.AutoButtonColor = false
    bar.Parent = wrap
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.BackgroundColor3 = GOLD
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((initial-minValue)/(maxValue-minValue), 0, 1, 0)
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local value = initial
    local function setFromX(x)
        local pct = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(minValue + pct * (maxValue - minValue) + 0.5)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        label.Text = labelText .. ": " .. tostring(value)
        if callback then callback(value) end
    end
    label.Text = labelText .. ": " .. tostring(value)
    bar.MouseButton1Click:Connect(function() setFromX(UserInputService:GetMouseLocation().X) end)
    bar.TouchTap:Connect(function(points)
        if points and points[1] then setFromX(points[1].X) end
    end)
end

local pages = {
    ["Home"] = function()
        heading("WELCOME")
        note("ORYN Elegant Gold — clean, compact UI for your own Roblox experience.")
        heading("QUICK SETTINGS")
        toggleRow("Show interface", true, function(on)
            sidebar.Visible = on
            content.Visible = on
        end)
        note("Use the tabs on the left to explore settings.")
    end,
    ["Visual"] = function()
        heading("VISUAL SETTINGS")
        toggleRow("FullBright (local lighting)", false, function(on)
            if on then
                Lighting.Brightness = 3
                Lighting.ClockTime = 14
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 100000
            else
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.GlobalShadows = true
                Lighting.FogEnd = 100000
            end
        end)
        toggleRow("No Fog (local)", false, function(on)
            Lighting.FogEnd = on and 100000 or 1000
        end)
        toggleRow("Shadows", true, function(on)
            Lighting.GlobalShadows = on
        end)
        sliderRow("Clock Time", 0, 24, math.floor(Lighting.ClockTime), function(v)
            Lighting.ClockTime = v
        end)
        note("Lighting changes are local presentation settings. Use in your own game or where permitted.")
    end,
    ["Player"] = function()
        heading("PLAYER SETTINGS")
        sliderRow("Field of View", 50, 100, 70, function(v)
            local camera = workspace.CurrentCamera
            if camera then camera.FieldOfView = v end
        end)
        note("Movement exploit, noclip, speed hacks, auto-farm and teleport-cheat controls are not implemented.")
    end,
    ["Utilities"] = function()
        heading("UTILITIES")
        toggleRow("Show status message", false, function(on)
            if on then
                note("Status: interface is running.")
            end
        end)
        note("Remote script loaders, webhooks, server hopping and automated gameplay actions are omitted for safety.")
    end,
    ["Survivor"] = function()
        heading("SURVIVOR")
        note("Original script mentions skill-check automation, auto-heal, parry, escape and anti-carry actions. These are listed here for reference only and are not active.")
    end,
    ["Killer"] = function()
        heading("KILLER")
        note("Original script mentions aimbot, silent aim, auto-kill, auto-attack, infinite lunge and cooldown bypass. These gameplay-cheat actions are not implemented.")
    end,
    ["Info"] = function()
        heading("ABOUT THIS BUILD")
        note("This is a safe UI scaffold, not a drop-in replacement for the original executor script. It does not load third-party code or contact external URLs.")
        note("To implement game mechanics legitimately, build them into your own Roblox experience with server-side validation.")
    end
}

local selectedButton
local function openPage(name, button)
    if selectedButton then
        selectedButton.BackgroundColor3 = Color3.fromRGB(31, 31, 36)
        selectedButton.TextColor3 = TEXT
    end
    selectedButton = button
    button.BackgroundColor3 = Color3.fromRGB(55, 45, 24)
    button.TextColor3 = GOLD
    clearContent()
    pages[name]()
    content.CanvasPosition = Vector2.new(0, 0)
end

for index, name in ipairs({"Home", "Player", "Visual", "Utilities", "Survivor", "Killer", "Info"}) do
    local button = Instance.new("TextButton")
    button.LayoutOrder = index
    button.Size = UDim2.new(1, 0, 0, 34)
    button.BackgroundColor3 = Color3.fromRGB(31, 31, 36)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = TEXT
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 11
    button.Parent = sidebar
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)
    button.MouseButton1Click:Connect(function() openPage(name, button) end)
    if index == 1 then task.defer(function() openPage(name, button) end) end
end

-- Scale down on narrow screens such as phones.
local function fitScreen()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    local scale = gui:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    scale.Parent = gui
    scale.Scale = math.min(1, viewport.X / 560, viewport.Y / 390)
end
fitScreen()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fitScreen)
end
