visible through walls

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserId = LocalPlayer.UserId

effect
local function createESP(player)
    if player == LocalPlayer then return end

    local function applyESP(character)
        if character then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    -- Create a neon outline visible through walls
                    local highlight = Instance.new("BoxHandleAdornment")
                    highlight.Adornee = part
                    highlight.AlwaysOnTop = true
                    highlight.ZIndex = 10
                    highlight.Size = part.Size
                    highlight.Color3 = Color3.fromRGB(0, 255, 0) -- Neon green color
                    highlight.Transparency = 0.7
                    highlight.Parent = part
                end
            end

            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = character:WaitForChild("Head")
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = billboard
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.Font = Enum.Font.FredokaOne
            nameLabel.TextSize = 20
            nameLabel.TextYAlignment = Enum.TextYAlignment.Bottom

            billboard.Parent = character:WaitForChild("Head")
        end
    end

    player.CharacterAdded:Connect(applyESP)
    if player.Character then
        applyESP(player.Character)
    end
end

-- UI setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 450)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.3
Frame.BorderMode = Enum.BorderMode.Inset
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = Frame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.7

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Frame
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Padding = UDim.new(0, 10)

local avatarImage = Instance.new("ImageLabel")
avatarImage.Parent = Frame
avatarImage.Size = UDim2.new(0, 100, 0, 100)
avatarImage.Position = UDim2.new(0.5, -50, 0, 10)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..UserId.."&width=420&height=420&format=png"
avatarImage.ZIndex = 2

local avatarUICorner = Instance.new("UICorner")
avatarUICorner.Parent = avatarImage
avatarUICorner.CornerRadius = UDim.new(1, 0)

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = Frame
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "玩家ESP"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextSize = 24
titleLabel.TextStrokeTransparency = 0.8

local toggleButton = Instance.new("TextButton")
toggleButton.Parent = Frame
toggleButton.Size = UDim2.new(1, 0, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.BorderSizePixel = 0
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.TextSize = 20
toggleButton.Text = "启用"

local buttonUICorner = Instance.new("UICorner")
buttonUICorner.Parent = toggleButton
buttonUICorner.CornerRadius = UDim.new(0, 8)

local exitButton = Instance.new("TextButton")
exitButton.Parent = Frame
exitButton.Size = UDim2.new(1, 0, 0, 50)
exitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
exitButton.BorderSizePixel = 0
exitButton.TextColor3 = Color3.new(1, 1, 1)
exitButton.Font = Enum.Font.FredokaOne
exitButton.TextSize = 20
exitButton.Text = "关闭"

local exitButtonUICorner = Instance.new("UICorner")
exitButtonUICorner.Parent = exitButton
exitButtonUICorner.CornerRadius = UDim.new(0, 8)

local creditsLabel = Instance.new("TextLabel")
creditsLabel.Parent = Frame
creditsLabel.Size = UDim2.new(1, 0, 0, 50)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "by huh QQ号1759437335"
creditsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
creditsLabel.Font = Enum.Font.FredokaOne
creditsLabel.TextSize = 16
creditsLabel.TextStrokeTransparency = 0

local function toggleESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    for _, child in ipairs(head:GetChildren()) do
                        if child:IsA("BillboardGui") or child:IsA("BoxHandleAdornment") then
                            child.Enabled = not child.Enabled
                        end
                    end
                end
            end
        end
    end
end

toggleButton.MouseButton1Click:Connect(toggleESP)

exitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end

Players.PlayerAdded:Connect(function(player)
    createESP(player)
end)