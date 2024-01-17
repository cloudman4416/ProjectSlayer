
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "OniHub|Project Slayers🎆🥶", HidePremium = false, SaveConfig = false, ConfigFolder = "OniSave"})

--AutoFarm
local AutoFarm = Window:MakeTab({
	Name = "AutoFarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--Kill Aura
local KillAura = Window:MakeTab({
	Name = "Kill Aura",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--GlobalGKA
local GlobalGKA = Window:MakeTab({
	Name = "Global KillAura",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--GodMode
local GodMode = Window:MakeTab({
	Name = "God Modes",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--Teleport
local PortTele = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--Collect Chest
AutoFarm:AddToggle({
    Name = "AutoCollect Chest",
    Default = false,
    Callback = function(Value)
        getgenv().AutoCollectChest = Value
     end  
})
spawn(function()
    while wait() do
        if getgenv().AutoCollectChest then
            for _, v in ipairs(game:GetService("Workspace").Debree:GetChildren()) do
                if v.Name == "Loot_Chest" then
                    local drops = v:FindFirstChild("Drops")
                    if drops then
                        local inventory = game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].Inventory.Items
                        for _, c in ipairs(drops:GetChildren()) do
                            if inventory:FindFirstChild(c.Name) then
                                v.Add_To_Inventory:InvokeServer(c.Name)
                                wait(0.5)
                                c:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end
end)
--Auto Collect Flowers
AutoFarm:AddToggle({
    Name = "AutoCollect Flowers",
    Default = false,
    Callback = function(Value)
    getgenv().TP = Value -- Assign the value to the global variable TP
            getgenv().speed = 260
            getgenv().delay = 1 -- increase this if you get stuck
    
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local chr = Player.Character
            local root = chr.HumanoidRootPart
    
            local TeleportSpeed = speed or 250
            local NextFrame = RunService.Heartbeat
    
            local function fireproximityprompt(ProximityPrompt, Amount, Skip)
                assert(ProximityPrompt, "Argument #1 Missing or nil")
                assert(
                    typeof(ProximityPrompt) == "Instance" and ProximityPrompt:IsA("ProximityPrompt"),
                    "Attempted to fire a Value that is not a ProximityPrompt"
                )
                local HoldDuration = ProximityPrompt.HoldDuration
                if Skip then
                    ProximityPrompt.HoldDuration = 0
                end
                for i = 1, Amount or 1 do
                    ProximityPrompt:InputHoldBegin()
                    if Skip then
                        local Start = os.time()
                        repeat
                            NextFrame:Wait(0.1)
                        until os.time() - Start > HoldDuration
                    end
                    ProximityPrompt:InputHoldEnd()
                end
                ProximityPrompt.HoldDuration = HoldDuration
            end
    
            local function ImprovedTeleport(Target)
                if typeof(Target) == "Instance" and Target:IsA("BasePart") then
                    Target = Target.Position
                end
                if typeof(Target) == "CFrame" then
                    Target = Target.p
                end
                local HRP = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                if not HRP then
                    return
                end
                local StartingPosition = HRP.Position
                local PositionDelta = Target - StartingPosition
                local StartTime = tick()
                local TotalDuration = (StartingPosition - Target).magnitude / TeleportSpeed
                repeat
                    NextFrame:Wait()
                    local Delta = tick() - StartTime
                    local Progress = math.min(Delta / TotalDuration, 1)
                    local MappedPosition = StartingPosition + PositionDelta * Progress
                    HRP.Velocity = Vector3.new()
                    HRP.CFrame = CFrame.new(MappedPosition)
                until (HRP.Position - Target).magnitude <= TeleportSpeed / 2
                HRP.Anchored = false
                HRP.CFrame = CFrame.new(Target)
            end
    
            local function getClosestFlower()
                local flowers = game:GetService("Workspace").Demon_Flowers_Spawn:GetChildren()
                local closestFlower, closestDistance
                for i, flower in ipairs(flowers) do
                    if flower:IsA("Model") then
                        local distance = (root.Position - flower.WorldPivot.Position).magnitude
                        if not closestDistance or distance < closestDistance then
                            closestFlower = flower
                            closestDistance = distance
                        end
                    end
                end
                return closestFlower
            end
    
            spawn(function()
                while wait() do
                    pcall(function()
                        if TP then
                            repeat
                                local currentFlower = getClosestFlower()
                                if not currentFlower then
                                    break
                                end
                                local pickedUp = false
                                local startTime = tick()
                                local elapsedTime = 0
                                repeat
                                    wait()
                                    ImprovedTeleport(currentFlower.WorldPivot.Position)
                                    wait(delay)
                                    for i, v in ipairs(currentFlower:GetDescendants()) do
                                        if v:IsA("ProximityPrompt") then
                                            fireproximityprompt(v, 1, true)
                                            pickedUp = true
                                        end
                                    end
                                    elapsedTime = elapsedTime + delay
                                    if elapsedTime >= 3 then
                                        local nextFlower = getClosestFlower()
                                        if nextFlower then
                                            ImprovedTeleport(nextFlower.WorldPivot.Position)
                                            currentFlower = nextFlower -- Set the current flower to the next one
                                        end
                                        elapsedTime = 0
                                    end
                                until pickedUp or tick() - startTime > 5
                            until not getClosestFlower() or not TP
                        end
                    end)
                end
            end)
end})

--fistkillayura
local isToggled = false
KillAura:AddToggle({
    Name = "Fist KillAura",
    Default = false,
    Callback = function(state)
        isToggled = state 

        if state then
            print("On")
        end
    end
})
local function invokeServer(args)
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
end
task.spawn(function()
    while true do
        task.wait()
        if isToggled then
            local args = {
                [1] = "fist_combat",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = workspace:WaitForChild(game.Players.LocalPlayer.Name),
                [4] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                [5] = game:GetService("Players").LocalPlayer.Character.Humanoid,
                [6] = 1
            }
            invokeServer(args)

            args[6] = 2
            invokeServer(args)

            args[6] = 3
            invokeServer(args)

            args[6] = 4
            invokeServer(args)

            args[6] = 919
            invokeServer(args)

            args[6] = 1
            invokeServer(args)

            args[6] = 2
            invokeServer(args)

            args[6] = 3
            invokeServer(args)

            args[6] = 4
            invokeServer(args)

            args[6] = 919
            invokeServer(args)

            wait(2) -- Add a delay before the next iteration
        end
    end
end)

local isToggled = false
KillAura:AddToggle({
    Name = "Sword KillAura",
    Default = false,
    Callback = function(state)
        isToggled = state 

        if state then
            print("On")
        end
    end
})
local function invokeServer(args)
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
end
task.spawn(function()
    while true do
        task.wait()
        if isToggled then
            local args = {
                [1] = "Sword_Combat_Slash",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = workspace:WaitForChild(game.Players.LocalPlayer.Name),
                [4] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                [5] = game:GetService("Players").LocalPlayer.Character.Humanoid,
                [6] = 1
            }
            invokeServer(args)

            args[6] = 2
            invokeServer(args)

            args[6] = 3
            invokeServer(args)

            args[6] = 4
            invokeServer(args)

            args[6] = 919
            invokeServer(args)

            args[6] = 1
            invokeServer(args)

            args[6] = 2
            invokeServer(args)

            args[6] = 3
            invokeServer(args)

            args[6] = 4
            invokeServer(args)

            args[6] = 919
            invokeServer(args)

            wait(2) -- Add a delay before the next iteration
        end
    end
end)


--GlobalGKA
GlobalGKA:AddToggle({
    Name = "Arrow GKA",
    Default = false,
    Callback = function(state)
    ArrowKA = state
    while ArrowKA do 
        local target = findMob()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local args = {
                [1] = "arrow_knock_back_damage",
                [2] = game:GetService("Players").LocalPlayer.Character,
                [3] = target.HumanoidRootPart.CFrame,
                [4] = target,
                [5] = 300,
                [6] = 300
            }

            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))

        end
        wait(0.1)
    end
end})
spawn(function()
while task.wait() do
    if ArrowKA == true then
        while ArrowKA do
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "arrow_knock_back",
                [4] = 5
            }

            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            wait(15)
        end
    end
end
end)

--Bring Mobs
local BringMobs = false
GlobalGKA:AddToggle({
    Name = "Bring Mobs (Arrow)",
    Default = false,
    Callback = function(state)
        BringMobs = state
    while BringMobs do 
        local target = findMob()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local args = {
                [1] = "piercing_arrow_damage",
                [2] = game:GetService("Players").LocalPlayer.Character,
                [3] = target:GetModelCFrame(),
                [4] = 50000
            }
            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
        end
        wait(0.3)
    end
end})

spawn(function()
while true do
    if BringMobs == true then
        while BringMobs do
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "arrow_knock_back",
                [4] = 5
            }
            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            wait(15)
        end
    end
    wait()
end
end)
function findMob()
    local largest = math.huge
    local closestChild = nil
    local HumanoidRootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart 
    for i, v in pairs(workspace.Mobs:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
            local magnitude = (HumanoidRootPart.Position - v:GetBoundingBox().Position).magnitude 
            if magnitude < largest then
                closestChild = v
                largest = magnitude
                dis = magnitude 
            end
        end
    end
    return closestChild
end
--Thunder Gka
GlobalGKA:AddToggle({
    Name = "Thunder Gka",
    Default = false,
    Callback = function(state)
    thunderKA = state
    while thunderKA do
    wait(0.75)
    
    local ohString1 = "skil_ting_asd"
    local ohInstance2 = game:GetService("Players").LocalPlayer
    local ohString3 = "Thunderbreathingrapidslashes"
    local ohNumber4 = 5
    
    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, ohString3, ohNumber4)
    
    for i = 1, 7 do
        wait(0.95)
        local ohString1 = "ricespiritdamage"
        local ohInstance2 = workspace:FindFirstChild(tostring(game.Players.LocalPlayer))
        local ohNumber4 = 150
    
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(ohString1, ohInstance2, workspace:FindFirstChild(tostring(game.Players.LocalPlayer)).HumanoidRootPart.CFrame, ohNumber4)
    end
    end
end})

local function autoEatSouls(value)
    spawn(function()
        while true do
            task.wait()
            if value then
                for i, v in pairs(game:GetService("Workspace").Debree:GetChildren()) do
                    if v.Name == "Soul" then
                        pcall(function()
                            v.Handle.Eatthedamnsoul:FireServer()
                        end)
                    end
                end
            end
        end
    end)
end

--DemonSoul
GlobalGKA:AddToggle({
    Name = "autoEatSouls",
    Default = false,
    Callback = autoEatSouls
})


--Farm Near
local DungeonFarmToggle = false
local TpDistance = 1
local TweenSpeed = 200 
local MobsFolder = game:GetService("Workspace").Mobs
AutoFarm:AddToggle({
    Name = "AutoFarm Closest",
    Default = false,
    Callback = function(value)
        DungeonFarmToggle = value
        if not DungeonFarmToggle then

            local tweenHelp = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("TweenHelp")
            if tweenHelp then
                tweenHelp:Destroy()
            end
        end
    end
})

local TweenService = game:GetService("TweenService")
spawn(function()
    while wait() do
        pcall(function()
            if DungeonFarmToggle then
                local tweenHelp = Instance.new("BodyVelocity")
                tweenHelp.Name = "TweenHelp"
                tweenHelp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                tweenHelp.Velocity = Vector3.new(0, -10, 0) 
                tweenHelp.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

                while DungeonFarmToggle do
                    local closestMob = nil
                    local closestDistance = math.huge

                    for _, mob in ipairs(MobsFolder:GetDescendants()) do
                        if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                            local distance = (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if distance < closestDistance then
                                closestMob = mob
                                closestDistance = distance
                            end
                        end
                    end

                    if closestMob then
                        local humanoidRootPart = closestMob.HumanoidRootPart
                        local targetPosition = humanoidRootPart.Position + Vector3.new(0, TpDistance, 7.1)
                        local tweenInfo = TweenInfo.new((targetPosition - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / TweenSpeed, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                end

                tweenHelp:Destroy() 
            else
                wait(1)
            end
        end)
    end
end)

function findMob()
local largest = math.huge
local closestChild = nil
local HumanoidRootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart 
for i, v in pairs(workspace.Mobs:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
        local magnitude = (HumanoidRootPart.Position - v:GetBoundingBox().Position).magnitude 
        if magnitude < largest then
            closestChild = v
            largest = magnitude
            dis = magnitude 
        end
    end
end
return closestChild
end

--Ice God Mode
GodMode:AddToggle({
	Name = "Ice God Mode",
	Default = false,
	Callback = function(Value)
		if Value then
            local running = true
            while running do
                task.wait(0.9)
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = game:GetService("Players").LocalPlayer,
                    [3] = "ice_demon_art_bodhisatva",
                    [4] = 1
                }
    
                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
            end
        end
	end    
})
--Sound God Mode
GodMode:AddToggle({
	Name = "Sound God Mode",
	Default = false,
	Callback = function(Value)
if Value then
    local running = true
    while running do
        task.wait(0.9)
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "sound_breathing_smoke_screen",
                [4] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
            
        
    end
end
end})
--Swamp God Mode
GodMode:AddToggle({
	Name = "Swamp God Mode",
	Default = false,
	Callback = function(Value)
if Value then
    local running = true
    while running do
        task.wait(0.9)
        local args = {
            [1] = "skil_ting_asd",
            [2] = game:GetService("Players").LocalPlayer,
            [3] = "swamp_bda_swamp_domain",
            [4] = 1
        }
        
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
    end
end
end})
--Scythe God Mode
GodMode:AddToggle({
	Name = "Scythe God Mode",
	Default = false,
	Callback = function(Value)
if value then
    local running = true
    while running do
        task.wait(0.1)
        local args = {
            [1] = "skil_ting_asd",
            [2] = game:GetService("Players").LocalPlayer,
            [3] = "scythe_asteroid_reap",
            [4] = 1
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
    end
end
end})
--ShockWave God Mode
GodMode:AddToggle({
	Name = "ShockWave God Mode",
	Default = false,
	Callback = function(v)
_G.Invicibility = v
    if _G.Invicibility then
        isLooping = true
        while isLooping do
            local A_1 = "skil_ting_asd"
            local A_2 = game:GetService("Players").LocalPlayer
            local A_3 = "akaza_bda_compass_needle"
            local A_4 = 1
            local Event = game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_
            Event:InvokeServer(A_1, A_2, A_3, A_4)
            task.wait(0.5)
        end
    end
end})
--Thunder God Mode
GodMode:AddToggle({
	Name = "Thunder God Mode",
	Default = false,
	Callback = function(Value)
local thunderGodMode = Value
    
        while thunderGodMode do
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "thunderbreathingricespirit",
                [4] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
    
    
            wait(0.76) 
        end

end})



local function TeleportToLocation(scriptName, position, locationName)
    local args = {
        [1] = scriptName,
        [2] = position,
        [3] = locationName
    }
    game:GetService("ReplicatedStorage"):WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
end

local TeleportButtons = {
    {
        Name = "Devourers Jaw",
        Position = 10018.7545821,
        LocationName = "Devourers Jaw"
    },
    {
        Name = "Akeza Cave",
        Position = 10243.5112577,
        LocationName = "Akeza Cave"
    },
    {
        Name = "Sound Cave",
        Position = 10354.5884468,
        LocationName = "Sound Cave"
    },
    {
        Name = "Mist trainer location",
        Position = 10410.372289699999,
        LocationName = "Mist trainer location"
    },
    {
        Name = "MuganTrain",
        Position = 10454.0531015,
        LocationName = "Mugen Train Station"
    }
}

for _, buttonData in ipairs(TeleportButtons) do
    PortTele:AddButton({
        Name = buttonData.Name,
        Callback = function()
            TeleportToLocation("Players.Keyftybozo.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript", buttonData.Position, buttonData.LocationName)
        end
    })
end
