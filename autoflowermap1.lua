local player = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
local runservice = game:GetService("RunService")
local force = Instance.new("BodyVelocity")
force.Velocity = Vector3.new(0, 0, 0)
workspace.DayNNight.Is_Night.Value = false
runservice.Stepped:Connect(function()
    workspace.DayNNight.Value = 10
end)

function tween(P1)
    Distance = (P1.Position - player.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 150 then
        Speed = 20000
    elseif Distance < 200 then
        Speed = 5000
    elseif Distance < 300 then
        Speed = 1030
    elseif Distance < 500 then
        Speed = 725
    elseif Distance < 1000 then
        Speed = 365
    elseif Distance >= 1000 then
        Speed = 365
    end
    local twen = ts:Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    )

    twen:Play()
    force.Parent = player.Character.HumanoidRootPart
    wait(Distance/Speed)
    force.Parent = nil
        
        
        for i, v in pairs(workspace.Demon_Flowers_Spawn:GetDescendants()) do
            if v.Name == "Cube.002" then
                for i, v in pairs(workspace.Demon_Flowers_Spawn:GetDescendants()) do
                    if v.Name == "Cancel" then
                        v:Destroy()
                    end
                end
                ts:Create(player.Character.HumanoidRootPart,
                TweenInfo.new(1, Enum.EasingStyle.Linear),
                {CFrame = CFrame.new(v.Position)}):Play()
                force.Parent = player.Character.HumanoidRootPart
                wait(1.2)
                pcall(function()
                    fireproximityprompt(v.Pick_Demon_Flower_Thing)
                end)
                wait(.3)
                force.Parent = nil
                v.Parent:Destroy()
            end
        end
end


local function idletween()
    task.spawn(function()
        while task.wait() do
            tween(CFrame.new(118, 282, -1630))
            
            tween(CFrame.new(1466, 297, -3025))
            
            tween(CFrame.new(1871, 317, -3120))

            tween(CFrame.new(3083, 317, -3287))
            
            tween(CFrame.new(3245, 317, -2720))

            tween(CFrame.new(3869, 343, -3121))
            
            tween(CFrame.new(5186, 365, -2435))
            
            tween(CFrame.new(123, 275, -3275))
            
            tween(CFrame.new(-328, 426, -2188))
        end
    end)
end

local function noclip()
    task.spawn(function()
        while task.wait() do
            for i, v in pairs(player.Character:GetChildren()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end)
end

idletween()

noclip()
