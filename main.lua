-- local variables

local player = game.Players.LocalPlayer
local player_name = player.Name
local player_data = nil
local player_value = nil
local webhook = ""
local vfx = game:GetService("ReplicatedStorage").Assets.Particles:FindFirstChild("Parts")
local ts = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local tpservice = game:GetService("TeleportService")

-- small start script

for i, v in pairs(game:GetService("ReplicatedStorage").Player_Data:GetChildren()) do
    if v.Name == player_name then
        player_data = v
    end
end

for i, v in pairs(game:GetService("ReplicatedStorage").PlayerValues:GetChildren()) do
    if v.Name == player_name then
        player_value = v
    end
end
-- tables

local bosses = {"Inosuke", "Akeza", "Enme", "Rengoku", "Muichiro Tokito", "Sound Trainee", "Tengen",  "Douma", "Renpeke", "Swampy",}
local serverboss = {"Akaza", "Douma", "Enmu", "Flame_Trainee", "Inosuke", "Muichiro", "Rengoku", "Snow_Trainee", "Sound_Trainee", "Swampy", "Tengen"}
local bossCFrame = {
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

local wbhookrar = {
    "Rare"
}

local selectedorbs = {}

-- toggle status

local godmode = false
local godmodemethod = nil
local tweenspeed = 300
local infinitestamina = true
local killaura = false
local akeza_invible = false
local method = "fist_combat"
local allbossfarm = false
local collectchest = false
local thunderka = false
local webhooktog = false
local autoorb = false
local alwaysday = false

-- remotes args
local killaurargs1 = {
    [1] = "fist_combat",
    [2] = game:GetService("Players").LocalPlayer,
    [3] = game:GetService("Players").LocalPlayer.Character,
    [4] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
    [5] = game:GetService("Players").LocalPlayer.Character.Humanoid,
    [6] = 919,
    [7] = "ground_slash"
}

local killaurargs2 = {
    [1] = "fist_combat",
    [2] = game:GetService("Players").LocalPlayer,
    [3] = game:GetService("Players").LocalPlayer.Character,
    [4] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
    [5] = game:GetService("Players").LocalPlayer.Character.Humanoid,
    [6] = math.huge,
    [7] = "ground_slash"
}

local godmodeargs = {
    [1] = "skil_ting_asd",
    [2] = game:GetService("Players").LocalPlayer,
    [3] = nil,
    [4] = 1
}

-- functions

function charexist()
    task.spawn(function()
        if player_char then
            return true
        end
    end)
end

function noclip()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide == true then
            v.CanCollide = false
        end
    end
end

function tpto(p1)
    task.spawn(function()
        pcall(function()
            player.Character.HumanoidRootPart.CFrame = p1
        end)
    end)
end

function checkdistance(obj)
    task.spawn(function()
        return (obj.Position - game.Players.LocalPlayer.HumanoidRootPart.Position).Magnitude
    end)
end

function tweento(obj)
    local Distance = (obj.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local Speed = Distance/tweenspeed

    local tween = ts:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Speed, Enum.EasingStyle.Linear),
        { CFrame = obj}
    )

    tween:Play()

    return tween
end

function findMob(hrp)
    for i, v in pairs(workspace.Mobs:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
            if hrp then
                if v:FindFirstChild('HumanoidRootPart') then
                    return v
                end
            else
                return v
            end
        end
    end
end

function findPlayer(hrp)
    for i, target in pairs(game.Players:GetPlayers()) do
        if target ~= player and target.Character:FindFirstChild("HumanoidRootPart") then
            return target.Character
        end
    end
end

function closestMob()
    local closestMob
    local closestDistance = math.huge
    for _, mob in ipairs(workspace.Mobs:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
            local distance = (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestMob = mob
                closestDistance = distance
            end
        end
    end
    return closestMob
end

function webhookf(message)
        task.spawn(function()
            request({
            Url = webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game.HttpService:JSONEncode({
                content = message
           })
        })
    end)
end

function findBoss(name, hrp)
    for i, v in pairs(workspace.Mobs:GetDescendants()) do
        if v:IsA("Model") and v.Name == name and v:FindFirstChild("Humanoid") then
            if hrp then
                if v:FindFirstChild('HumanoidRootPart') then
                    return v
                end
            else
                return v
            end
        end
    end
end

-- upd function

function updweapon(weapon)
    task.spawn(function()
        if weapon == "Combat" then
            method = "fist_combat"
        elseif weapon == "Scythe" then
            method = "Scythe_Combat_Slash"
        elseif weapon == "Sword" then
            method = "Sword_Combat_Slash"
        elseif weapon == "War Fans" then
            method = "fans_combat_slash"
        elseif weapon == "Claws" then
            method = "claw_Combat_Slash"
        end
        killaurargs1[1] = method
        killaurargs2[2] = method
    end)
end

function updgodmode(godmodem)
    task.spawn(function()
        if godmodem == "Scythe -- Mas 28 + Equipped" then
            godmodemethod = "scythe_asteroid_reap"
        elseif godmodem == "Water Breathing -- Mas 1" then
            godmodemethod = "Water_Surface_Slash"
        elseif godmodem == "Insect Breating -- Mas 28" then
            godmodemethod = "insect_breathing_dance_of_the_centipede"
        elseif godmodem == "Blood Burst Bda -- Mas 20" then
            godmodemethod = "blood_burst_explosive_choke_slam"
        elseif godmodem == "Wind Breathing -- Mas 30" then
            godmodemethod = "Wind_breathing_black_wind_mountain_mist"
        elseif godmodem == "Snow Breathing -- Mas 1" then
            godmodemethod = "snow_breatihng_layers_frost"
        elseif godmodem == "Flame Breathing -- Mas 32" then
            godmodemethod = "flame_breathing_flaming_eruption"
        elseif godmodem == "Beast Breathing -- Mas 40" then
            godmodemethod = "Beast_breathing_devouring_slash"
        elseif godmodem == "Shockwave Bda -- Mas 44" then
            godmodemethod = "akaza_flashing_williow_skillasd"
        elseif godmodem == "Dream Bda -- Ult Unlocked" then
            godmodemethod = "dream_bda_flesh_monster"
        elseif godmodem == "Swamp Bda -- Ult Unlocked" then
            godmodemethod = "swamp_bda_swamp_domain"
        elseif godmodem == "Sound Breathing -- Mas 50" then
            godmodemethod = "sound_breathing_smoke_screen"
        elseif godmodem == "Ice Bda -- Ult Unlocked" then
            godmodemethod = "ice_demon_art_bodhisatva"
        end
        godmodeargs[3] = godmodemethod
    end)
end

function updfarmpos(method)
    task.spawn(function()
        if method == "Above" then
            ydistancefromboss = distancefromboss
            zdistancefromboss = 0
        elseif method == "Below" then
            ydistancefromboss = -distancefromboss
            zdistancefromboss = 0
        elseif method == "Behind" then
            ydistancefromboss = 0
            zdistancefromboss = distancefromboss
        end
    end)
end
-- const running functions


task.spawn(function()
    while task.wait(0.3) do
        if godmode then
            local args = {
                [1] = "skil_ting_asd",
                [2] = player,
                [3] = godmodemethod,
                [4] = 1
            }
            
            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))                                         
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if killaura then
            for i = 1, 8 do
                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(killaurargs1))
                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(killaurargs2))
            end
            task.wait(1)
            repeat task.wait()
            until player.combotangasd123.Value == 0
        end
    end
end)


task.spawn(function()
    while task.wait() do
        if collectchest then
            repeat task.wait()
                if collectchest then
                    pcall(function()
                        for a, b in pairs(game.Workspace.Debree:GetChildren()) do
                            if b.Name == "Loot_Chest" then
                                for c, d in pairs(b.Drops:GetChildren()) do
                                    b.Add_To_Inventory:InvokeServer(d.Name)
                                    if webhooktog and not table.find(wbhookrar, d.Value) then
                                        webhookf("||"..player.Name.."|| collected a "..d.Name.. ", rarity ".. d.Value)
                                    end
                                end
                                b:Destroy()
                            end
                        end 
                    end)
                end
            until not collectchest
        end
    end
end)


--[[------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
]]

-- ANNOYING GUI PART


local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "OniHub|Project Slayers🎆🥶", HidePremium = false, SaveConfig = false, ConfigFolder = "OniSave"})

local AutoFarm = Window:MakeTab({
    Name = "AutoFarm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local KillAuras = Window:MakeTab({
    Name = "Kill Auras",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Misc = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Buffs = Window:MakeTab({
    Name = "Buffs",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local WebHook = Window:MakeTab({
    Name = "Webhook settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local UISettings = Window:MakeTab({
    Name = "UI Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- ui tab
local tabsettingsgb = UISettings:AddSection({
        Name = "Unload"
})



tabsettingsgb:AddButton({
	Name = "Unload GUI",
	Callback = function()
        OrionLib:Destroy()
  	end    
})


-- farming tab
local farmsettingsgb = AutoFarm:AddSection({
	Name = "Farm Settings"
})

farmsettingsgb:AddDropdown({
	Name = "weapon selection",
	Default = "Combat",
	Options = {"Combat", "Scythe", "Sword", "War Fans", "Claws"},
	Callback = function(Value)
		updweapon(Value)
	end    
})


farmsettingsgb:AddSlider({
	Name = "Tween Speed",
	Min = 100,
	Max = 500,
	Default = 300,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "TweenSpeed",
	Callback = function(Value)
		tweenspeed = Value
	end    
})


local autofarmgb = AutoFarm:AddSection({
	Name = "Auto Farm Main"
})

autofarmgb:AddToggle({
	Name = "auto boss",
	Default = false,
	Callback = function(state)
		allbossfarm = state
        task.spawn(function()
            while allbossfarm do
                noclip()
                task.wait(1)
            end
        end)
        task.spawn(function()
            local antifall = Instance.new("BodyVelocity")
            antifall.Velocity = Vector3.new(0, 0, 0)
            antifall.Parent = player.Character.HumanoidRootPart
            while allbossfarm do
                for _, boss in pairs(bosses) do
                    if allbossfarm then
                        local cframe = bossCFrame[boss]
                        local tween = tweento(cframe)
                        tween.Completed:Wait()
                        local boboss = findBoss(boss, true)
                        if boboss ~= nil  and allbossfarm then
                            while boboss:FindFirstChild("Humanoid").Health > 0 and allbossfarm do
                                pcall(function()
                                    tpto(boboss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 10))
                                end)
                                task.wait()
                            end
                        end
                    end
                end
                task.wait()
            end
            antifall:Destroy()
        end)
	end    
})




autofarmgb:AddToggle({
    Name = 'killaura (m1)',
    Default = false,

    Callback = function(Value)
        if Value then
            killaura = true
        else
            killaura = false
        end
    end
})

autofarmgb:AddToggle({
    Name = 'auto collect chests',
    Default = false,

    Callback = function(Value)
        if Value then
            collectchest = true
        else
            collectchest = false
        end
    end
})


-- KA TAB

local arrowgb = KillAuras:AddSection({
	Name = "Arrow KA (11/10)"
})

local ArrowKA = false
local BringMobs = false
local BreakBossesArrow = false
local PlayerKA = false

arrowgb:AddToggle({
    Name = 'Arrow KA',
    Default = false,
    Callback = function(state)
        ArrowKA = state
        task.spawn(function()
            while ArrowKA do 
                local target =  findMob(true)
                if target then
                    local args = {
                        [1] = "arrow_knock_back_damage",
                        [2] = player.Character,
                        [3] = target:GetModelCFrame(),
                        [4] = target,
                        [5] = math.huge,
                        [6] = math.huge
                    }

                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                end
                task.wait()
            end
        end)
        task.spawn(function()
            while ArrowKA do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = player,
                    [3] = "arrow_knock_back",
                    [4] = 5
                }

                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                task.wait(6)
            end
        end)
    end
})

arrowgb:AddToggle({
    Name = 'Bring Mobs',
    Default = false,
    Callback = function(state)
    BringMobs = state
    task.spawn(function()
        while BringMobs do 
            local target = findMob(true)
            if target then
                repeat task.wait()
                    local args = {
                        [1] = "piercing_arrow_damage",
                        [2] = player,
                        [3] = target:GetModelCFrame(),
                        [4] = math.huge
                    }
                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                until target.Humanoid.Health <= 0 or not BringMobs
            end
            task.wait()
        end
    end)
    task.spawn(function()
        while BringMobs do
            local args = {
                [1] = "skil_ting_asd",
                [2] = player,
                [3] = "arrow_knock_back",
                [4] = 5
            }
            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            task.wait(6)
        end
    end)
end})

arrowgb:AddToggle({
    Name = 'Player KA',
    Default = false,
    Callback = function(state)
        PlayerKA = state
        task.spawn(function()
            while PlayerKA do 
                local target = findPlayer(true)
                if target then
                    local args = {
                        [1] = "arrow_knock_back_damage",
                        [2] = player.Character,
                        [3] = target:GetModelCFrame(),
                        [4] = target,
                        [5] = math.huge,
                        [6] = math.huge
                    }
                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                end
                task.wait(0.01)
            end
        end)
        task.spawn(function()
            while PlayerKA do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = player,
                    [3] = "arrow_knock_back",
                    [4] = 5
                }

                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                task.wait(6)
            end
        end)
    end
})


arrowgb:AddButton({
    Name = 'Break Bosses',
    Callback = function()
        BreakBossesArrow = true
        task.spawn(function()
            if BreakBossesArrow then
                for _, mob in pairs(game:GetService("ReplicatedStorage").Npcs:GetChildren()) do
                    if table.find(serverboss, mob.Name) then
                        repeat task.wait()
                            local args = {
                                [1] = "arrow_knock_back_damage",
                                [2] = player.Character,
                                [3] = mob:GetModelCFrame(),
                                [4] = mob,
                                [5] = 300,
                                [6] = 300
                            }

                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                            task.wait(0.1)
                        until mob.Humanoid.Health <= 0
                    end
                end
                BreakBossesArrow = false
            end
        end)
        task.spawn(function()
            while breakserver do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = player,
                    [3] = "arrow_knock_back",
                    [4] = 5
                }

                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                task.wait(6)
            end
        end)
    end
})

local swampgb = KillAuras:AddSection({
	Name = "Swamp KA (7/10)"
})

local PuddleKA = false

swampgb:AddToggle({
    Name = 'Swamp KA',
    Default = false,
    Callback = function(state)
    PuddleKA = state
    task.spawn(function()
        while PuddleKA do 
            local target = findMob(true)
            if target then
                local args = {
                    [1] = "swamp_puddle_damage",
                    [2] = player.Character,
                    [3] = target:GetModelCFrame()
                }          
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))                
            end
            task.wait(0.3)
        end
    end)
    task.spawn(function()
        while PuddleKA do
            local args = {
                [1] = "skil_ting_asd",
                [2] = player,
                [3] = "swampbda_swamp_puddle",
                [4] = 5
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))        
            task.wait(9.5)
        end
    end)
end})

local bloodbgb = KillAuras:AddSection({
	Name = "Blood Burst KA (5/10)"
})

local MineKA = false

bloodbgb:AddToggle({
    Name = 'Mines KA',
    Default = false,
    Callback = function(state)
    MineKA = state
    task.spawn(function()
        task.wait(0.5)
        while MineKA do 
            local target = closestMob()
            if target then
                local args = {
                    [1] = "land_mines_place",
                    [2] = player.Character,
                    [3] = target:GetModelCFrame()
                }    
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                local folder = workspace.Debree:WaitForChild(player.Name .. "'s explosive land mines")
                task.wait(0.2)
                for i, mine in pairs(folder:GetChildren()) do
                    mine.DetonateEvent:FireServer()
                end
            end
            task.wait()
        end
    end)
    task.spawn(function()
        while MineKA do
            local args = {
                [1] = "skil_ting_asd",
                [2] = game:GetService("Players").LocalPlayer,
                [3] = "blood_burst_explosive_land_mines",
                [4] = 5
            }    
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))    
            task.wait(30)
        end
    end)
end})

local icegb = KillAuras:AddSection({
	Name = "Ice KA (1/10)"
})

local IceKA1 = false

icegb:AddToggle({
    Name = '1st Ice Atk KA',
    Default = false,
    Callback = function(state)
        IceKA1 = state
        task.spawn(function()
            while IceKA1 do
                local target = findMob(true)
                if target then
                    local args = {
                        [1] = "skil_ting_asd",
                        [2] = player,
                        [3] = "ice_demon_art_wintry_iciles",
                        [4] = 5
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                    for i = 1, 7 do
                        local args = {
                            [1] = "ice_demon_art_wintry_iciles_damage",
                            [2] = player.Character,
                            [3] = target:GetModelCFrame()
                        }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                    end
                    task.wait(15)
                end
                task.wait()
            end
        end)
    end
})


--misc tab

local miscgb = Misc:AddSection({
	Name = "Misc"
})
miscgb:AddToggle({
    Name = 'Remove FX',
    Default = false,
    Callback = function(state)
        if state then
            vfx.Parent = nil
        else
            vfx.Parent = game:GetService("ReplicatedStorage").Assets.Particles
        end
    end
})

miscgb:AddButton({
    Name = 'Delete map, PERF BOOST',
    Callback = function()
        workspace.Map:Destroy()
        workspace.Terrain.Water_Regions:Destroy()
    end
})


miscgb:AddToggle({
    Name = 'always day (visual only)',
    Default = false,
    Callback = function(state)
        alwaysday = state
        if state then 
            task.spawn(function()
                while alwaysday do
                    workspace.DayNNight.Value = 10
                    task.wait()
                end
            end)
        end
    end
})


local wbhook = WebHook:AddSection({
	Name = "Webhook Settings"
})

wbhook:AddTextbox({
	Name = "webhook url",
	Default = "enter url",
	TextDisappear = true,
	Callback = function(Value)
        webhook = Value
	end	  
})

wbhook:AddToggle({
    Text = 'webhook tog',
    Default = false,

    Callback = function(state)
        webhooktog = state
    end
})

local teleportgb = Misc:AddSection({
	Name = "Teleport"
})

teleportgb:AddButton({
    Name = 'Rejoin',
    Callback = function()
        tpservice:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end,

})

-- DUNGEON TAB
--[[
local orbgb = Tabs['Dungeon']:AddLeftGroupbox('Orbs')

orbgb:AddDropdown('Select Orb ', {
    Values = {
    "DoublePoints",
    "StaminaRegen",
    "HealthRegen", 
    "BloodMoney",
    "InstaKill",
    "MobCamouflage"},
    Default = 0,
    Multi = true,

    Text = 'Select the Method you want',
    Tooltip = nil,

    Callback = function(Value)
        selectedorbs = Value
    end
})

orbgb:AddToggle('AutoOrb', {
    Text = 'Auto Collect Orbs',
    Default = false,
    Tooltip = 'select an option above ',

    Callback = function(state)
        autoorb = state
        task.spawn(function()
            while autoorb do
                for _, v in pairs(game:GetService("Workspace").Map:GetChildren()) do
                    if v:IsA("Model") and selectedorbs[v.Name] == true then 
                        local oldpos = player.Character.HumanoidRootPart.CFrame
                        tpto(v:GetModelCFrame())
                        v:Destroy()
                        task.wait(0.1)
                        tpto(oldpos)
                    end
                end 
                task.wait()
            end
        end)
    end
})

local dungutilgb = Tabs['Dungeon']:AddRightGroupbox('Utility')

dungutilgb:AddButton({
    Text = 'Delete Map (perf boost)',
    Func = function()
        for i, v in pairs(workspace.Map:GetChildren()) do
            if v.Name ~= "Baseplate" then
                if v:FindFirstChild("InvisibleWalls") then
                    v:Destroy()
                    local antifall = Instance.new("BodyVelocity")
                    antifall.Velocity = Vector3.new(0, 0, 0)
                    antifall.Name = "DungAntiFall"
                    antifall.Parent = player.Character.HumanoidRootPart
                    break
                end
            end
        end
    end,
    DoubleClick = true,
    Tooltip = 'double click to delete map'
})

dungutilgb:AddButton({
    Text = 'Tp To Shop',
    Func = function()
        tpto(CFrame.new(6488.36816, -38.9678726, -863.29425, 0.998610556, -3.65335211e-08, 0.0526972376, 3.64273056e-08, 1, 2.97606695e-09, -0.0526972376, -1.05231357e-09, 0.998610556))
        if player.Character.HumanoidRootPart:FindFirstChild("DungAntiFall") then
            player.Character.HumanoidRootPart:FindFirstChild("DungAntiFall"):Destroy()
        end
    end,
    DoubleClick = false,
    Tooltip = nil
})

dungutilgb:AddButton({
    Text = 'Tp To Entrance',
    Func = function()
        tpto(CFrame.new(5132.93799, -140.089478, 2030.97461, -0.244579792, -9.08212812e-08, 0.969629169, -5.66264582e-08, 1, 7.93825095e-08, -0.969629169, -3.54913077e-08, -0.244579792))
        if player.Character.HumanoidRootPart:FindFirstChild("DungAntiFall") then
            player.Character.HumanoidRootPart:FindFirstChild("DungAntiFall"):Destroy()
        end
    end,
    DoubleClick = false,
    Tooltip = nil
})
]]

-- BUFF TAB

local godmodegb = Buffs:AddSection({
	Name = "God Mode"
})
godmodegb:AddDropdown({
	Name = "Select the Method you want",
	Default = nil,
	Options = {
        "Scythe -- Mas 28 + Equipped",
        "Water Breathing -- Mas 1",
        "Insect Breating -- Mas 28", 
        "Blood Burst Bda -- Mas 20", 
        "Wind Breathing -- Mas 30",
        "Snow Breathing -- Mas 1", 
        "Flame Breathing -- Mas 32",
        "Beast Breathing -- Mas 40", 
        "Shockwave Bda -- Mas 44",
        "Dream Bda -- Ult Unlocked", 
        "Swamp Bda -- Ult Unlocked", 
        "Sound Breathing -- Mas 50",
        "Ice Bda -- Ult Unlocked"},
	Callback = function(Value)
		updgodmode(Value)
	end    
})

godmodegb:AddToggle({
    Text = 'GodMode',
    Default = false,

    Callback = function(Value)
        if Value then
            godmode = true
        else
            godmode = false
        end
    end
})

local buffgb = Buffs:AddSection({
	Name = "Buffs"
})


buffgb:AddButton({
    Name = "ThunderMode [Human]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.thundertang123:FireServer(true)
    end
})
buffgb:AddButton({
    Name = "Mist Clone",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.immense_reflexes_asd123:FireServer()
    end
})
buffgb:AddButton({
    Name = "Rengoku Mode [Human]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.heart_ablaze_mode_remote:FireServer(true)
    end
})
buffgb:AddButton({
    Name = "God Kamado [Kamado Clan]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.heal_tang123asd:FireServer(true)
    end
})
buffgb:AddButton({
    Name = "WarDrums [Damage+Speed Boost]",
    Callback = function()
        local remote = game:GetService("ReplicatedStorage").Remotes.war_Drums_remote

    while true do
        remote:FireServer(true)
        wait(20)
    end
    end
})
buffgb:AddButton({
    Name = "Health Regen",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.regeneration_breathing_remote:FireServer(true)
    end
})
buffgb:AddButton({
    Name = "Sun Immunity",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerScripts.Small_Scripts.Gameplay.Sun_Damage.Disabled = true
    end
})
buffgb:AddButton({
    Name = "Furiosity",
    Callback = function()
        while true do
            print("Toggle On")
            game:GetService("ReplicatedStorage").Remotes.clan_furiosity_add:FireServer(true)
            wait(24)
        end
    end
})
buffgb:AddButton({
    Name = "Spacial Awareness",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.spacial_awareness_remote:FireServer(true)
    end
})
