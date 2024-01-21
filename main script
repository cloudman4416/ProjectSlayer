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
local tweenspeed = 400
local infinitestamina = true
local killaura = false
local akeza_invible = false
local method = "fist_combat"
local allbossfarm = false
local collectchest = false
local arrowgka = false
local bringmob = false
local thunderka = false
local webhooktog = false
local autoorb = false

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
        if v:IsA("Model") and v.Name == name and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
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
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

local Window = Library:CreateWindow({
    Title = 'CloudHub Project Slayer',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    ['Autofarm'] = Window:AddTab('Autofarm Section'),
    ['Misc'] = Window:AddTab('Misc'),
    ['Dungeon'] = Window:AddTab('Dungeon'),
    ['Buffs'] = Window:AddTab('Buffs'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- ui tab
local tabsettingsgb = Tabs['UI Settings']:AddLeftGroupbox('Ui Settings')

tabsettingsgb:AddButton('Unload', function() Library:Unload() end)

-- farming tab
local farmsettingsgb = Tabs['Autofarm']:AddLeftGroupbox('farm settings')
farmsettingsgb:AddDropdown('weapon selection', {
    Values = {"Combat", "Scythe", "Sword", "War Fans", "Claws"},
    Default = 1,
    Multi = false,

    Text = 'Select the weapon you want',
    Tooltip = '',

    Callback = function(Value)
        updweapon(Value)
    end
})


farmsettingsgb:AddSlider('Tween Speed', {
    Text = 'Tween Speed',
    Default = 400,
    Min = 100,
    Max = 500,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        tweenspeed = Value
    end
})

farmsettingsgb:AddDropdown('farmpos', {
    Values = {"Above", "Below", "Behind"},
    Default = 3,
    Multi = false,

    Text = 'farming position',
    Tooltip = '',

    Callback = function(Value)
        updfarmpos(Value)
    end
})


local farmingtab = Tabs['Autofarm']:AddLeftGroupbox('           [autofarm]')

farmingtab:AddToggle('auto boss', {
    Text = 'auto boss',
    Default = false,
    Tooltip = nil,

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
                            while boboss.Humanoid.Health > 0 and allbossfarm do
                                tpto(boboss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 10))
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



farmingtab:AddToggle('kill aura', {
    Text = 'killaura (m1)',
    Default = false,
    Tooltip = '',

    Callback = function(Value)
        if Value then
            killaura = true
        else
            killaura = false
        end
    end
})

farmingtab:AddToggle('arrow ka', {
    Text = 'Arrow KA',
    Default = false,
    Tooltip = 'dont activate using bring mobs',
    Callback = function(state)
        arrowgka = state
        task.spawn(function()
            while arrowgka do 
                local target = findMob(true)
                if target then
                    local args = {
                        [1] = "arrow_knock_back_damage",
                        [2] = player.Character,
                        [3] = target:GetModelCFrame(),
                        [4] = target,
                        [5] = 300,
                        [6] = 300
                    }

                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))

                end
                task.wait(0.1)
            end
        end)
        spawn(function()
            while arrowgka do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = player,
                    [3] = "arrow_knock_back",
                    [4] = 5
                }

                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                task.wait(10)
            end
        end)
    end
})

if workspace:FindFirstChild("PrivateServerDummies") then
    farmingtab:AddToggle('arrow ka (ps dummie)', {
        Text = 'Arrow KA (ps dummies)',
        Default = false,
        Tooltip = 'farm damages on dummies',
        Callback = function(state)
            arrowgka = state
            task.spawn(function()
                while arrowgka do 
                    local target = workspace.PrivateServerDummies["Dummy (Infinite Hp)"]
                    if target then
                        local args = {
                            [1] = "arrow_knock_back_damage",
                            [2] = player.Character,
                            [3] = target:GetModelCFrame(),
                            [4] = target,
                            [5] = 300,
                            [6] = 300
                        }

                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))

                    end
                    task.wait(0.1)
                end
            end)
            spawn(function()
                while arrowgka do
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
end

farmingtab:AddToggle('Bring Mobs (Arrow)', {
    Text = 'Bring Mobs (Arrow)',
    Default = false,
    Tooltip = 'dont activate using arrow ka',

    Callback = function(state)
    bringmob = state
    task.spawn(function()
        while bringmob do 
            local target = findMob(true)
            if target then
                local args = {
                    [1] = "piercing_arrow_damage",
                    [2] = player,
                    [3] = target:GetModelCFrame(),
                    [4] = 50000
                }
                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            end
            task.wait(0.3)
        end
    end)
    spawn(function()
        while bringmob do
            local args = {
                [1] = "skil_ting_asd",
                [2] = player,
                [3] = "arrow_knock_back",
                [4] = 5
            }
            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            task.wait(15)
        end
    end)
end})

farmingtab:AddToggle('Thunder KA', {
    Text = 'ThunderKA',
    Default = false,
    Tooltip = 'very unstable, report any error at Cloudman789#3700',

    Callback = function(state)
    thunderka = state
    task.spawn(function()
        while thunderka do 
            local target = findMob(true)
            if target then
                local args = {
                    [1] = "ricespiritdamage",
                    [2] = player,
                    [3] = target:GetModelCFrame(),
                    [4] = 150
                }
                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            end
            task.wait(0.5)
        end
    end)
    spawn(function()
        while thunderka do
            local args = {
                [1] = "skil_ting_asd",
                [2] = player,
                [3] = "Thunderbreathingrapidslashes",
                [4] = 5
            }
            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
            task.wait(15)
        end
    end)
end})

farmingtab:AddToggle('auto collect chest', {
    Text = 'auto collect chests',
    Default = false,
    Tooltip = '',

    Callback = function(Value)
        if Value then
            collectchest = true
        else
            collectchest = false
        end
    end
})



--misc tab

local miscgb = Tabs['Misc']:AddLeftGroupbox('Misc')
miscgb:AddToggle('no vfx', {
    Text = 'remove the fx of the attack',
    Default = false,
    Tooltip = 'good to save cpu and be less laggy',

    Callback = function(state)
        if state then
            vfx.Parent = nil
        else
            vfx.Parent = game:GetService("ReplicatedStorage").Assets.Particles
        end
    end
})

miscgb:AddButton({
    Text = 'Delete map, PERF BOOST',
    Func = function()
        workspace.Map:Destroy()

    end,
    DoubleClick = true,
    Tooltip = 'delete the entire map (use for long farm so you dont lag)'
})

miscgb:AddToggle('always day', {
    Text = 'always day (visual only)',
    Default = false,
    Tooltip = 'demon still spawn dont worry',

    Callback = function(state)
        if state then
            day = game:GetService("RunService").Stepped:Connect(function()
                workspace.DayNNight.Value = 10
            end)
        else
            day:Disconnect()
        end
    end
})


local wbhook = Tabs['Misc']:AddLeftGroupbox('Webhook')
wbhook:AddInput('WebHook', {
    Default = nil,
    Numeric = false,
    Finished = false,

    Text = 'Webhook',
    Tooltip = nil,

    Placeholder = 'Waiting For Your Webhook',
    

    Callback = function(Value)
        webhook = Value
        print(webhook)
    end
})

wbhook:AddToggle('webhook tog', {
    Text = 'send a message when you get a drop',
    Default = false,
    Tooltip = 'make sure you entered the good url',

    Callback = function(state)
        webhooktog = state
    end
})

local teleportgb = Tabs['Misc']:AddRightGroupbox('Teleport')

teleportgb:AddButton({
    Text = 'Rejoin',
    Func = function()
        tpservice:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end,
    DoubleClick = true,
    Tooltip = 'double click to rejoin'
})

-- DUNGEON TAB
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


-- BUFF TAB

local godmodegb = Tabs['Buffs']:AddLeftGroupbox('God Mode')

godmodegb:AddDropdown('godmode method ', {
    Values = {
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
    Default = 0,
    Multi = false,

    Text = 'Select the Method you want',
    Tooltip = 'cant use with arrow ka',

    Callback = function(Value)
        updgodmode(Value)

    end
})

godmodegb:AddToggle('GodMode', {
    Text = 'GodMode',
    Default = false,
    Tooltip = 'select an option above ',

    Callback = function(Value)
        if Value then
            godmode = true
        else
            godmode = false
        end
    end
})

local buffgb = Tabs['Buffs']:AddRightGroupbox('Buffs')

buffgb:AddButton({
    Text = 'inf war drum (dont need fans)',
    Func = function()
    local remote = game:GetService("ReplicatedStorage").Remotes.war_Drums_remote
    while true do
        remote:FireServer(true)
        task.wait(20)
    end
    end,
    DoubleClick = false,
    Tooltip = 'free buff you should always use it'
})
