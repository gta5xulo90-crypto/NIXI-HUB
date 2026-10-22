-- NIXI HUB ♡ | PINK EDITION
-- Interfaz personalizada para Roblox Studio
-- Ubicación: StarterPlayer > StarterPlayerScripts
-- Crear como LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

local pink = Color3.fromRGB(255, 75, 180)
local dark = Color3.fromRGB(15, 12, 20)
local card = Color3.fromRGB(29, 23, 36)
local white = Color3.fromRGB(255, 240, 250)

local old = pg:FindFirstChild("NIXIHUB")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "NIXIHUB"
gui.ResetOnSpawn = false
gui.Parent = pg

local function create(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(320, 355),
    Position = UDim2.new(0.5, -160, 0.5, -177),
    BackgroundColor3 = dark,
    BorderSizePixel = 0,
}, gui)

create("UICorner", {
    CornerRadius = UDim.new(0, 16)
}, main)

create("UIStroke", {
    Color = pink,
    Thickness = 1.5,
    Transparency = 0.1,
}, main)

local scale = create("UIScale", {
    Scale = 0.75
}, main)

TweenService:Create(scale,
    TweenInfo.new(0.4, Enum.EasingStyle.Back),
    {Scale = 1}
):Play()

local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 76),
    BackgroundColor3 = card,
    BorderSizePixel = 0,
}, main)

create("UICorner", {
    CornerRadius = UDim.new(0, 16)
}, header)

create("TextLabel", {
    Size = UDim2.new(1, -60, 0, 36),
    Position = UDim2.fromOffset(17, 8),
    BackgroundTransparency = 1,
    Text = "♡ NIXI HUB",
    TextColor3 = pink,
    TextSize = 25,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

create("TextLabel", {
    Size = UDim2.new(1, -30, 0, 18),
    Position = UDim2.fromOffset(19, 45),
    BackgroundTransparency = 1,
    Text = "P I N K   E D I T I O N  •  V1.0",
    TextColor3 = white,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local close = create("TextButton", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(1, -42, 0, 13),
    BackgroundColor3 = Color3.fromRGB(87, 31, 66),
    Text = "×",
    TextColor3 = white,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
}, header)

create("UICorner", {
    CornerRadius = UDim.new(0, 9)
}, close)

-- Arrastrar el panel con el ratón
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType ==
        Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local function makeButton(text, y)
    local button = create("TextButton", {
        Size = UDim2.new(1, -30, 0, 43),
        Position = UDim2.fromOffset(15, y),
        BackgroundColor3 = card,
        Text = text,
        TextColor3 = white,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        BorderSizePixel = 0,
        AutoButtonColor = false,
    }, main)

    create("UICorner", {
        CornerRadius = UDim.new(0, 10)
    }, button)

    create("UIStroke", {
        Color = Color3.fromRGB(81, 48, 76),
        Thickness = 1,
    }, button)

    button.MouseEnter:Connect(function()
        TweenService:Create(button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(76, 32, 64)}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = card}
        ):Play()
    end)

    return button
end

local fly = makeButton("✈    FLY  •  CONFIGURACIÓN", 94)
local speed = makeButton("⚡    SPEED  •  CONFIGURACIÓN", 148)
local settings = makeButton("⚙    SETTINGS", 202)

create("TextLabel", {
    Size = UDim2.new(1, -30, 0, 46),
    Position = UDim2.fromOffset(15, 264),
    BackgroundColor3 = card,
    Text = "♡ Made with love by NIXI ♡",
    TextColor3 = pink,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    BorderSizePixel = 0,
}, main)

fly.Activated:Connect(function()
    fly.Text = "✈    FLIGHT CONFIGURATION"
end)

speed.Activated:Connect(function()
    speed.Text = "⚡    SPEED CONFIGURATION"
end)

settings.Activated:Connect(function()
    settings.Text = "⚙    NIXI SETTINGS"
end)

close.Activated:Connect(function()
    TweenService:Create(scale,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        {Scale = 0.75}
    ):Play()

    task.wait(0.2)
    main.Visible = false
end)

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible

        if main.Visible then
            scale.Scale = 0.8
            TweenService:Create(scale,
                TweenInfo.new(0.25, Enum.EasingStyle.Back),
                {Scale = 1}
            ):Play()
        end
    end
end)
