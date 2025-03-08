local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function highlightPlayer(player)
    local character = player.Character or player.CharacterAdded:Wait()
    if character then
        local highlight = Instance.new("Highlight")
        highlight.Parent = character
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 150, 0, 100)
        billboardGui.Adornee = character:WaitForChild("Head")
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)

        local distanceText = Instance.new("TextLabel")
        distanceText.Size = UDim2.new(1, 0, 0.5, 0)
        distanceText.BackgroundTransparency = 1
        distanceText.TextColor3 = Color3.new(0, 0, 0)
        distanceText.TextScaled = true
        distanceText.Position = UDim2.new(0, 0, 0.5, 0)
        distanceText.Parent = billboardGui
        
        local nameText = Instance.new("TextLabel")
        nameText.Size = UDim2.new(1, 0, 0.5, 0)
        nameText.BackgroundTransparency = 1
        nameText.TextColor3 = Color3.new(0, 0, 0)
        nameText.TextScaled = true
        nameText.Text = player.Name
        nameText.Position = UDim2.new(0, 0, 0, 0)

        nameText.Parent = billboardGui
        billboardGui.Parent = character.Head
        
        RunService.RenderStepped:Connect(function()
            if character.PrimaryPart then
                local distance = (LocalPlayer.Character.PrimaryPart.Position - character.PrimaryPart.Position).magnitude
                distanceText.Text = string.format("Расстояние: %.1f", distance)
            end
        end)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        highlightPlayer(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        highlightPlayer(player)
    end)
end)