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

local mainmenu = Window:MakeTab({
    Name = "Main Menu",
    Icon =  "rbxassetid://4483345998",
    PremiumOnly = false
})
local extras = Window:MakeTab({
    Name = "Extra",
    Icon =  "rbxassetid://4483345998",
    PremiumOnly = false
})
local miscs = Window:MakeTab({
    Name = "Misc",
    Icon =  "rbxassetid://4483345998",
    PremiumOnly = false
})
local mugan = Window:MakeTab({
    Name = "Mugan Train",
    Icon =  "rbxassetid://4483345998",
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

function noclip()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide == true then
            v.CanCollide = false
        end
    end
end
local vim = game:GetService('VirtualInputManager')
function pressKey(key)
    vim:SendKeyEvent(true, key, false, game)
    vim:SendKeyEvent(false, key, false, game)
end

function tweento(obj)
    local tweenspeed = 200
    local Speed
    Distance = (obj.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 150 then
        Speed = 6*tweenspeed
    elseif Distance < 200 then
        Speed = 5*tweenspeed
    elseif Distance < 300 then
        Speed = 4*tweenspeed
    elseif Distance < 500 then
        Speed = 3*tweenspeed
    elseif Distance < 1000 then
        Speed = 2*tweenspeed
    elseif Distance >= 1000 then
        Speed = 1*tweenspeed
    end

    local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,
    TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
    {CFrame = obj})
    local RunService = game:GetService("RunService")
    noclipE = RunService.Stepped:Connect(noclip) 

    tween:Play()
    local antifall = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
    antifall.Velocity = Vector3.new(0, 0, 0)

    tween.Completed:Connect(function()
        noclipE:Disconnect()
        antifall:Destroy()
    end)
end

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
        if target then
            local args = {
                [1] = "arrow_knock_back_damage",
                [2] = game:GetService("Players").LocalPlayer.Character,
                [3] = target:GetModelCFrame(),
                [4] = target,
                [5] = 300,
                [6] = 300
            }

            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))

        end
        wait(0.2)
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
                [3] = target.HumanoidRootPart.CFrame,
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
local TpDistance = 6
local TweenSpeed = 60 
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
                        local targetPosition = humanoidRootPart.Position + Vector3.new(0, TpDistance, 0)
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





mainmenu:AddButton({
	Name = "Random OutFit",
	Callback = function()
        local players = game:GetService("Players"):GetPlayers()
        local targetPlayer = players[math.random(1, #players)]
        local playerName = targetPlayer.Name

        local customization = game:GetService("ReplicatedStorage").Player_Data[playerName].Customization

        customization.Body_Scaling.Width:FireServer("Change_Value", math.random(1, 10))
        customization.Hairs.Hair1.Index:FireServer("Change_Value", math.random(1, 67))
        customization.Hairs.Hair2.Index:FireServer("Change_Value", math.random(1, 67))
        customization.Shoes.Index:FireServer("Change_Value", math.random(1, 9))
        customization.Clothes.Shirt.Index:FireServer("Change_Value", math.random(1, 34))
        customization.Clothes.Pants.Index:FireServer("Change_Value", math.random(1, 22))
    end,
})

mainmenu:AddButton({
	Name = "Auto Daily Spin",
	Callback = function()
        game:GetService("ReplicatedStorage").spins_thing_remote:InvokeServer()
    end,
})

mainmenu:AddButton({
	Name = "Spin Clan",
	Callback = function()
        local args = {"check_can_spin"}
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
    end,
})

extras:AddButton({
	Name = "Spin BDA",
	Callback = function()
        local args = {"check_can_spin_demon_art"}
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
    end,
})

mainmenu:AddButton({
	Name = "Spin For Superme",
	Callback = function()
        local clans = {"Kamado", "Uzui", "Agatsuma", "Rengoku"}
        local handleSpin = game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_

        while task.wait() do
            local clanValue = game:GetService("ReplicatedStorage").Player_Data[game:GetService("Players").LocalPlayer.Name].Clan.Value
            if game.PlaceId ~= 5956785391 then
                game:GetService("Players").LocalPlayer:Kick("Use the script in the main menu")
            else
                if not table.find(clans, clanValue) then
                    handleSpin:InvokeServer("check_can_spin")
                end
            end
        end
    end,
})



miscs:AddButton({
	Name = "ThunderMode [Human]",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.thundertang123:FireServer(true)
    end
})
miscs:AddButton({
	Name = "Mist Clone",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.immense_reflexes_asd123:FireServer()
    end
})
miscs:AddButton({
	Name = "Rengoku Mode [Human]",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.heart_ablaze_mode_remote:FireServer(true)
    end
})
miscs:AddButton({
	Name = "God Kamado [Kamado Clan]",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.heal_tang123asd:FireServer(true)
    end
})
miscs:AddButton({
	Name = "WarDrums [Damage+Speed Boost]",
	Callback = function()
        local remote = game:GetService("ReplicatedStorage").Remotes.war_Drums_remote

    while true do
        remote:FireServer(true)
        wait(20)
    end
    end
})

miscs:AddButton({
	Name = "Health Regen",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.regeneration_breathing_remote:FireServer(true)
    end
})

miscs:AddButton({
	Name = "Sun Immunity",
	Callback = function()
        game:GetService("Players").LocalPlayer.PlayerScripts.Small_Scripts.Gameplay.Sun_Damage.Disabled = true
    end
})

miscs:AddButton({
	Name = "Furiosity",
	Callback = function()
        while true do
            print("Toggle On")
            game:GetService("ReplicatedStorage").Remotes.clan_furiosity_add:FireServer(true)
            wait(24)
        end
    end
})

miscs:AddButton({
	Name = "Spacial Awareness",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.spacial_awareness_remote:FireServer(true)
    end
})


-- ServerHop
extras:AddButton({
	Name = "Private Server",
	Callback = function()
        local TPS = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"))

        if servers.nextPageCursor ~= nil then
            repeat
                local server = servers.data[1]
                TPS:TeleportToPlaceInstance(placeId, server.id)
                servers = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..servers.nextPageCursor))
            until server
        else
            local server = servers.data[1]
            TPS:TeleportToPlaceInstance(placeId, server.id)
        end
    end
})


extras:AddButton({
	Name = "FPS BOOST",
	Callback = function()
        local decalsyeeted = true

        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain

        sethiddenproperty(l, "Technology", 2)
        sethiddenproperty(t, "Decoration", false)
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = 0
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"

        local function modifyPart(part)
            part.Material = "Plastic"
            part.Reflectance = 0
        end

        local function modifyDecal(decal)
            if decalsyeeted then
                decal.Transparency = 1
            end
        end

        for i, v in pairs(w:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                modifyPart(v)
            elseif (v:IsA("Decal") or v:IsA("Texture")) then
                modifyDecal(v)
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                modifyPart(v)
                if decalsyeeted then
                    v.TextureID = 10385902758728957
                end
            elseif v:IsA("SpecialMesh") and decalsyeeted then
                v.TextureId = 0
            elseif v:IsA("ShirtGraphic") and decalsyeeted then
                v.Graphic = 0
            elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
                v[v.ClassName .. "Template"] = 0
            end
        end

        local function modifyEffect(effect)
            effect.Enabled = false
        end

        for i, effect in ipairs(l:GetChildren()) do
            if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or
                effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect") then
                modifyEffect(effect)
            end
        end

        w.DescendantAdded:Connect(function(v)
            wait()
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                modifyPart(v)
            elseif (v:IsA("Decal") or v:IsA("Texture")) then
                modifyDecal(v)
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                modifyPart(v)
                if decalsyeeted then
                    v.TextureID = 10385902758728957
                end
            elseif v:IsA("SpecialMesh") and decalsyeeted then
                v.TextureId = 0
            elseif v:IsA("ShirtGraphic") and decalsyeeted then
                v.ShirtGraphic = 0
            elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
                v[v.ClassName .. "Template"] = 0
            end
        end)
    end,
})

mugan:AddButton({
    Name = "Auto Clash",
    Callback = function()
        spawn(function()
            repeat task.wait()
                pressKey(game:GetService("Players").LocalPlayer.PlayerGui.universal_client_scripts.Clashing2.Clash_Ui2.Holder.Front.Text)
                task.wait()
            until game:GetService("Players").LocalPlayer.PlayerGui.universal_client_scripts.Clashing2.Clash_Ui2.Enabled ~= true
        end)
    end
})

mugan:AddButton({
    Name = "Insta Clash",
    Callback = function()
        spawn(function()
            local args = {
                [1] = "Change_Value",
                [2] = workspace:WaitForChild("Debree"):WaitForChild("clash_folder"):WaitForChild(game.Players.LocalPlayer.Name.."vsEnmu"):WaitForChild(game.Players.LocalPlayer.Name),
                [3] = 10000
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
        end)
    end
})

extras:AddButton({
    Name = "Anti Afk",
    Callback = function(value)
local vu = game:GetService("VirtualUser")
    if value then
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
end})

local NoCToggle = false
extras:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function (value)
        NoCToggle = value
    end
})

spawn(function()
    while wait() do
        pcall(function()
            if NoCToggle then
                for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
end)

local bosCFTable = {
    ["Susamaru"] = CFrame.new(1415.65686, 315.908813, -4571.56445, 0.546769679, 9.56999102e-08, -0.837283075, -3.89699188e-08, 1, 8.88496885e-08, 0.837283075, -1.59514606e-08, 0.546769679),
    ["Sabito"] = CFrame.new(1257.60046, 275.351685, -2834.26611, -0.999906898, 0, 0.0136531433, 0, 1, 0, -0.0136531433, 0, -0.999906898),
    ["Zanegutsu Kuuchie"] = CFrame.new(-336.3461, 425.857422, -2271.75513, -0.698250651, 1.51218398e-08, 0.715853333, -2.08847464e-08, 1, -4.1495408e-08, -0.715853333, -4.39246115e-08, -0.698250651),
    ["Yahaba"] = CFrame.new(1415.65686, 315.908813, -4571.56445, 0.546769679, 9.56999102e-08, -0.837283075, -3.89699188e-08, 1, 8.88496885e-08, 0.837283075, -1.59514606e-08, 0.546769679),
    ["Bandit Kaden"] = CFrame.new(-569.584351, 304.46698, -2827.55371, 0.480675608, -1.73434103e-08, 0.876898468, 1.14556499e-07, 1, -4.30165024e-08, -0.876898468, 1.21131407e-07, 0.480675608),
    ["Shiron"] = CFrame.new(3203.10229, 370.884155, -3953.36035, 0.839348018, 3.06273158e-08, -0.54359442, -9.09106301e-09, 1, 4.23049826e-08, 0.54359442, -3.05667527e-08, 0.839348018),
    ["Nezuko"] = CFrame.new(3549.86816, 342.214478, -4595.73145, 0.869256139, 6.38721716e-08, -0.494362026, -6.77404373e-08, 1, 1.00905426e-08, 0.494362026, 2.47170338e-08, 0.869256139),
    ["Bandit Zoku"] = CFrame.new(174.656708, 283.257355, -1969.98572, -0.814278841, -6.32300328e-08, 0.5804739, -9.84254598e-08, 1, -2.91412618e-08, -0.5804739, -8.08625273e-08, -0.814278841),
    ["Slasher"] =  CFrame.new(4355.59082, 342.214478, -4386.90527, -0.943093359, 9.45450722e-08, -0.332528085, 7.62970487e-08, 1, 6.79336054e-08, 0.332528085, 3.86968253e-08, -0.943093359),
    ["Giyu"] = CFrame.new(3013.30884, 316.95871, -2916.32202, 0.76092875, 3.55993954e-08, 0.648835421, -1.75982926e-08, 1, -3.4228016e-08, -0.648835421, 1.46266848e-08, 0.76092875),
    ["Sanemi"] = CFrame.new(1619.91357, 348.461884, -3717.00464, 0.995524168, -1.20393835e-07, 0.0945073739, 1.19773844e-07, 1, 1.22327712e-08, -0.0945073739, -8.58508931e-10, 0.995524168)
}

local BossesTable = {"Sabito", "Susamaru", "Zanegutsu Kuuchie", "Yahaba", "Bandit Kaden", "Bandit Zoku", "Shiron", "Nezuko", "Slasher", "Giyu", "Sanemi"}

AutoFarm:AddToggle({
    Name = "Farm All Bosses [Map 1]",
    Default = false,
    Callback = function(toggled)
        if toggled then
            for _, bossName in ipairs(BossesTable) do
                local targetPosition = bosCFTable[bossName]
                
                if targetPosition then
                    local speed = 120
                    local time = (targetPosition.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / speed
                    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
                    local tween = game:GetService("TweenService"):Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        tweenInfo,
                        {CFrame = targetPosition}
                    )
                    tween:Play()
                    wait(time)
                    
                   
                    local playerHeight = game.Players.LocalPlayer.Character.HumanoidRootPart.Size.Y
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPosition * CFrame.new(0, playerHeight/2, 0)
                    
                   
                    repeat
                        wait(3)
                    until not bossIsPresent(bossName)
                else
                    warn("Invalid boss name:", bossName)
                end
            end
        end
    end
})


function bossIsPresent(bossName)
    local MobsFolder = game:GetService("Workspace").Mobs
    local bossModel = MobsFolder:FindFirstChild(bossName)
    return bossModel ~= nil
end





local BossesTable2 = {"Rengoku", "Inosuke", "Renpeke", "Muichiro Tokito", "Enme", "Swampy", "Akeza", "Douma", "Tengen", "Sound Trainee"}
local bosCFTable2 = {
    ["Rengoku"] = CFrame.new(3656, 673, -345),
    ["Akeza"] = CFrame.new(2010, 556, -128),
    ["Renpeke"] = CFrame.new(-1258, 601, -650),
    ["Muichiro Tokito"] = CFrame.new(4513, 673, -544),
    ["Enme"] = CFrame.new(1591, 484, -690),
    ["Swampy"] = CFrame.new(-1377, 601, -202),
    ["Douma"] = CFrame.new(-5, 513, -1689),
    ["Tengen"] = CFrame.new(1464, 486, -3118),
    ["Sound Trainee"] = CFrame.new(1897, 663, -2805),
    ["Inosuke"] = CFrame.new(1585, 300, -389),
}

AutoFarm:AddToggle({
    Name = "Farm All Bosses [Map 2]",
    Default = false,
    Callback = function(toggled)
        if toggled then
            for _, bossName in ipairs(BossesTable2) do
                local targetPosition = bosCFTable2[bossName]
                
                tweento(targetPosition)
            end
        end
    end
})

function bossIsPresent(bossName)
    local MobsFolder = game:GetService("Workspace").Mobs
    local bossModel = MobsFolder:FindFirstChild(bossName)
    return bossModel ~= nil
end


