repeat wait() until game:IsLoaded()

_G.settings = {
    autoserverhop = false;
    checkbosshealth = false;
}


local function load_settings()
    local HttpService = game:GetService("HttpService")
    _G.settings = HttpService:JSONDecode(readfile("zen/savesettings.txt"))
end

local function save_settings()
    print('Saving Settings')
    local json
    local HttpService = game:GetService("HttpService")
    if writefile then
        json = HttpService:JSONEncode(_G.settings)
        makefolder("zen")
        writefile("zen/savesettings.txt", json)
        print(readfile("zen/savesettings.txt"))
    end
end

if isfile("zen/savesettings.txt") == false then 
    save_settings()
    print(readfile("zen/savesettings.txt"));
end

print(readfile("zen/savesettings.txt"));

load_settings()


game.Lighting.FogEnd = 100000
game.Lighting.FogStart = 0
game.Lighting.ClockTime = 14
game.Lighting.Brightness = 2
game.Lighting.GlobalShadows = false
local UserInputService = game:GetService("UserInputService")
local starter = game:GetService("StarterGui")
local Player = game:GetService("Players").LocalPlayer
local plr = game.Players.LocalPlayer
local bind = Instance.new("BindableFunction")
local ServerStart = os.time()
local currTime = "Server started: "..os.date("%c",ServerStart).." | Server uptime: "..math.floor(workspace.DistributedGameTime)

local LPlayer = game:GetService("Players").LocalPlayer
local LMouse = LPlayer:GetMouse()

local Camera = game:GetService("Workspace").CurrentCamera

local function GetClosestPlayer()
  local ClosestDistance, ClosestPlayer = math.huge, nil;
  for _,Player in next, game:GetService("Players"):GetPlayers() do
    if Player ~= LPlayer then
      local Character = Player.Character
      if Character and Character.Humanoid.Health > 1 then
        local ScreenPosition, IsVisibleOnViewPort = Camera:WorldToViewportPoint(Character.HumanoidRootPart.Position)
        if IsVisibleOnViewPort then
          local MDistance = (Vector2.new(LMouse.X, LMouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
          if MDistance < ClosestDistance then
            ClosestPlayer = Player
            ClosestDistance = MDistance
          end
        end
      end
    end
  end
  return ClosestPlayer, ClosestDistance
end

function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end


local function checkIfPlayer()
    return plr.Character ~= nil
end

local function pLoc()
    if not checkIfPlayer() then return end
    print(plr.Character.HumanoidRootPart.CFrame)
    return plr.Character.HumanoidRootPart.CFrame
end

local function TpPlayeTo(toCFrame)
    if not checkIfPlayer() then return end
    plr.Character.PrimaryPart.CFrame = toCFrame
end

local function newTPtoTOP(e)
    if e == 'SK' then
        starter:SetCore("SendNotification", {
            Title = 'SK and HD Scammer',
            Text = "Teleporting",
            Duration = 5
        })
        for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
            if string.match(v.Name, 'Legacy') then
                local landPos = v.Main.Position
                local newlandPos = CFrame.new(landPos.X, landPos.Y+1000, landPos.Z)
                TpPlayeTo(newlandPos)
            end
        end
        for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
            if string.match(v.Name, 'Sea King') then
                local landPos = v.Main.Position
                local newlandPos = CFrame.new(landPos.X, landPos.Y+1000, landPos.Z)
                TpPlayeTo(newlandPos)
            end
        end
    end
    if e == 'GS' then
        starter:SetCore("SendNotification", {
            Title = 'GS',
            Text = "Teleporting",
            Duration = 5
        })
        for i,v in pairs(game:GetService("Workspace").GhostMonster:GetChildren())do
            if string.match(v.Name, 'Ghost Ship') then
                local landPos = v.HumanoidRootPart.Position
                local newlandPos = CFrame.new(landPos.X, landPos.Y+1000, landPos.Z)
                TpPlayeTo(newlandPos)
                return true
            end
        end
    end
end

bind.OnInvoke = newTPtoTOP

starter:SetCore("SendNotification", {
    Title = 'ZenGod Script Loaded',
    Text = currTime,
    Duration = 5
})
local players = game.Players:GetPlayers()

starter:SetCore("SendNotification", {
    Title = 'Total Players:',
    Text = "Players: "..#players.." / 12",
    Duration = 5
})

local function checker()
    local check = false;
    for i,v in pairs(game:GetService("Workspace").GhostMonster:GetChildren())do
        if string.match(v.Name, 'Ghost Ship') then
            
            starter:SetCore("SendNotification", {
                Title = 'Ghost Ship',
                Text = v.Name,
                Duration = 10,
                Callback = bind,
                Button1 = "GS"
            })
            wait(0.5)
            starter:SetCore("SendNotification", {
                Title = 'Ghost Ship HP',
                Text = tostring(v.Humanoid.Health),
                Duration = 10,
                Callback = bind,
                Button1 = "GS"
            })

            check = true
        end
    end

    for i,v in pairs(game:GetService("Workspace").SeaMonster:GetChildren())do
        if string.match(v.Name, "Sea") then
            starter:SetCore("SendNotification", {
                Title = v.Name,
                Text = tostring(v.Humanoid.Health),
                Duration = 1
            })
            check = true
        end
    end

    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Legacy') then
            local number = v.ClockTime.SurfaceGui.Number.Text
            starter:SetCore("SendNotification", {
                Title = 'Sea King',
                Text = v.Name.." Next: "..number,
                Duration = 10,
                Callback = bind,
                Button1 = "SK"
            })
            check = true
        end
    end

    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Sea King') then
            starter:SetCore("SendNotification", {
                Title = 'Hydra',
                Text = v.Name,
                Duration = 10,
                Callback = bind,
                Button1 = "SK"
            })

            check = true
        end
    end

    for i,v in pairs(game:GetService("Workspace"):GetChildren())do
        if string.match(v.Name, 'Chest') then
            starter:SetCore("SendNotification", {
                Title = 'GS Chest',
                Text = v.Name,
                Duration = 5
            })

            check = true
        end
    end

    if check == true then return true end
end

local function SpawnSK()
    local originalPos = pLoc()
    for i,v in pairs(game:GetService("Workspace"):GetChildren())do
        if string.match(v.Name, 'Chest') then
            TpPlayeTo(v.RootPart.CFrame)
            starter:SetCore("SendNotification", {
                Title = 'ZenGod HD',
                Text = v.Name,
                Duration = 5
            })
            return true
        end
    end
    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Legacy') then
            for i, c in pairs(v.ChestSpawner:GetChildren())do
                TpPlayeTo(c.RootPart.CFrame)
                wait(0.5)
                TpPlayeTo(originalPos)
                starter:SetCore("SendNotification", {
                    Title = 'SK Steal :D',
                    Text = 'Stealing Chest',
                    Duration = 5
                })
            end
        end
    end
    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Sea King') then
            for i,c in pairs(v:GetChildren()) do
                if string.match(c.Name, "Chest")then
                    TpPlayeTo(c.RootPart.CFrame)
                    wait(0.5)
                    TpPlayeTo(originalPos)
                    starter:SetCore("SendNotification", {
                        Title = 'SK Steal :D',
                        Text = 'Stealing Chest',
                        Duration = 5
                    })
                end
            end
        end
    end
end

local function HPboss()
    spawn(function()
        local BoxHP = Instance.new("ScreenGui")
        local Main = Instance.new("Frame")
        local hpbar = Instance.new("Frame")
        local BOSSNAME = Instance.new("TextLabel")
        local BOSSHP = Instance.new("TextLabel")
        BoxHP.ResetOnSpawn = false

        BoxHP.Name = "BoxHP"
        BoxHP.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        Main.Name = "Main"
        Main.Parent = BoxHP
        Main.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Main.BorderSizePixel = 0
        Main.Position = UDim2.new(0, 0, 0.878900826, 0)
        Main.Size = UDim2.new(0, 271, 0, 69)
        Main.ZIndex = 1
        Main.Active = true
        Main.Draggable = true

        hpbar.Name = "hpbar"
        hpbar.Parent = Main
        hpbar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        hpbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        hpbar.BorderSizePixel = 0
        hpbar.Position = UDim2.new(0, 0, 0.479233891, 0)
        hpbar.Size = UDim2.new(1, 0, 0, 34)
        hpbar.ZIndex = 1

        BOSSNAME.Name = "BOSSNAME"
        BOSSNAME.Parent = Main
        BOSSNAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BOSSNAME.BackgroundTransparency = 1000.000
        BOSSNAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
        BOSSNAME.BorderSizePixel = 0
        BOSSNAME.Size = UDim2.new(0, 269, 0, 35)
        BOSSNAME.ZIndex = 1
        BOSSNAME.Font = Enum.Font.Unknown
        BOSSNAME.Text = "Boss Name"
        BOSSNAME.TextColor3 = Color3.fromRGB(0, 0, 0)
        BOSSNAME.TextSize = 14.000

        BOSSHP.Name = "BOSSHP"
        BOSSHP.Parent = Main
        BOSSHP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BOSSHP.BackgroundTransparency = 100.000
        BOSSHP.BorderColor3 = Color3.fromRGB(0, 0, 0)
        BOSSHP.BorderSizePixel = 0
        BOSSHP.Position = UDim2.new(-0.00369003695, 0, 0.454467773, 0)
        BOSSHP.Size = UDim2.new(0, 270, 0, 35)
        BOSSHP.ZIndex = 2
        BOSSHP.Font = Enum.Font.GothamBold
        BOSSHP.Text = "3478587234952375234"
        BOSSHP.TextColor3 = Color3.fromRGB(0, 0, 0)
        BOSSHP.TextSize = 14.000
        while wait() do
            wait(0.1)
            if _G.settings.checkbosshealth == true then
                BOSSNAME.Text = "NO BOSS XD"
                BOSSHP.Text = "Boss is DEAD!"
                for i,v in pairs(game:GetService("Workspace").SeaMonster:GetChildren())do
                    if string.match(v.Name, "Sea") then
                        if v.Name == 'SeaKing' then
                            BOSSNAME.Text = v.Name
                        else
                            BOSSNAME.Text = v.PartUI.NameUI.TextLabel.Text
                        end
                        BOSSHP.Text = comma_value(v.Humanoid.Health)
                        hpbar.Size = UDim2.new(
                            v.Humanoid.Health/v.Humanoid.MaxHealth,
                            1, 0, 34
                        )
                        
                    end
                end
                for i,v in pairs(game:GetService("Workspace").GhostMonster:GetChildren())do
                    if string.match(v.Name, 'Ghost Ship') then
                        BOSSNAME.Text = tostring(v.Name)
                        BOSSHP.Text = comma_value(v.Humanoid.Health)
                        hpbar.Size = UDim2.new(
                            v.Humanoid.Health/v.Humanoid.MaxHealth,
                            1, 0, 34
                        )
                    end
                end
            end
        end
    end)
end

local function serverHop()
    starter:SetCore("SendNotification", {
        Title = 'ZenGod',
        Text = 'Warping',
        Duration = 5
    })
    
    local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/zenox69/Roblox-Scripts/main/serverhop.lua")()

    module:Teleport(6381829480)
    -- local Player = game.Players.LocalPlayer    
    -- local Http = game:GetService("HttpService")
    -- local TPS = game:GetService("TeleportService")
    -- local Api = "https://games.roblox.com/v1/games/"

    -- local _place,_id = game.PlaceId, game.JobId
    -- local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
    -- function ListServers(cursor)
    -- local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    -- return Http:JSONDecode(Raw)
    -- end

    -- local Next; repeat
    -- local Servers = ListServers(Next)
    -- for i,v in next, Servers.data do
    --     if v.playing < v.maxPlayers and v.id ~= _id then
    --         local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
    --         if s then break end
    --     end
    -- end
    
    -- Next = Servers.nextPageCursor
    -- until not Next
end

local function serverHopLowest()
    starter:SetCore("SendNotification", {
        Title = 'ZenGod',
        Text = 'Warping Lowest',
        Duration = 5
    })
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"

    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
    end

    local Server, Next; repeat
    local Servers = ListServers(Next)
    Server = Servers.data[1]
    Next = Servers.nextPageCursor
    until Server

    TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end

if not checker() then
    starter:SetCore("SendNotification", {
        Title = 'Boss Checker',
        Text = 'Nothing Spawned',
        Duration = 5
    })
end

local function AutoHopBoss()
    spawn(function()
        while wait() do
            if _G.settings.autoserverhop == true then
                if not checker() then
                    starter:SetCore("SendNotification", {
                        Title = 'Auto HOP',
                        Text = "On",
                        Duration = 5
                    })
                    wait(3)
                    serverHop()
                else
                    starter:SetCore("SendNotification", {
                        Title = 'Auto HOP',
                        Text = "Off",
                        Duration = 5
                    })
                    _G.settings.autoserverhop = false
                    save_settings()
                end
            end
        end
    end)
end

print(_G.settings.autoserverhop)

if _G.settings.autoserverhop == true then
    AutoHopBoss()
end

if _G.settings.checkbosshealth == true then
    HPboss()
end

local checkbossenabled = 'IDK'


UserInputService.InputBegan:Connect(function(Key) 
    if Key.KeyCode == Enum.KeyCode.R then
        for i, child in ipairs(game:GetService("Workspace").PlayerCharacters:GetChildren()) do
            if child.Humanoid.Health > 0 and child.Name == GetClosestPlayer().Name then -- Change "Part" to the name which will trigger the line below
                TpPlayeTo(child.HumanoidRootPart.CFrame)
            end
        end
    end
    if Key.KeyCode == Enum.KeyCode.F1 then
        if _G.settings.autoserverhop == false then
            _G.settings.autoserverhop = true
            save_settings()
            AutoHopBoss()
        else
            _G.settings.autoserverhop = false
            save_settings()
        end
        starter:SetCore("SendNotification", {
            Title = 'AutoHOP',
            Text =  tostring(_G.settings.autoserverhop),
            Duration = 5
        })
    end
    if Key.KeyCode == Enum.KeyCode.F2 then
        if _G.settings.checkbosshealth == false then
            _G.settings.checkbosshealth = true
            save_settings()
            HPboss()
        else
            _G.settings.checkbosshealth = false
            save_settings()
            plr.PlayerGui.BoxHP:Destroy()
        end
        starter:SetCore("SendNotification", {
            Title = 'Check Boss HP',
            Text =  tostring(_G.settings.checkbosshealth),
            Duration = 5
        })
    end
    if Key.KeyCode == Enum.KeyCode.F3
    then
        serverHopLowest()
    end
    if Key.KeyCode == Enum.KeyCode.H
	then
		if not checker() then
            starter:SetCore("SendNotification", {
                Title = 'Boss Checker',
                Text = 'Nothing Spawned',
                Duration = 5
            })
        end
	end
	if Key.KeyCode == Enum.KeyCode.N
	then
		starter:SetCore("SendNotification", {
            Title = 'ZenGod',
            Text = 'Clearing Fog 😂',
            Duration = 1
        })
        save_settings()
        game.Lighting.FogEnd = 100000
        game.Lighting.FogStart = 0
        game.Lighting.ClockTime = 14
        game.Lighting.Brightness = 2
        game.Lighting.GlobalShadows = false 
	end
    if Key.KeyCode == Enum.KeyCode.RightBracket
    then
        serverHop()
    end
    if Key.KeyCode == Enum.KeyCode.LeftBracket
    then
        starter:SetCore("SendNotification", {
            Title = 'ZenGod',
            Text = 'Emergency Escape',
            Duration = 2
        })
        wait(0.1)
        local plyLocation = plr.Character.HumanoidRootPart.Position
        local NewCFrame = CFrame.new(plyLocation.X, plyLocation.Y+500, plyLocation.Z)
        plr.Character.HumanoidRootPart.CFrame = NewCFrame
    end
    if Key.KeyCode == Enum.KeyCode.Quote
    then
        SpawnSK()
    end
    if Key.KeyCode == Enum.KeyCode.Semicolon
    then
        newTPtoTOP('SK')
    end
end)
