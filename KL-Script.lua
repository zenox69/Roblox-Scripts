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

local function TPtoTOP(e)
    if e == 'TP' then
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

bind.OnInvoke = TPtoTOP

starter:SetCore("SendNotification", {
    Title = 'ZenGod Script Loaded',
    Text = currTime,
    Duration = 5
})




local function checker()
    for i,v in pairs(game:GetService("Workspace").GhostMonster:GetChildren())do
        if string.match(v.Name, 'Ghost Ship') then
            
            starter:SetCore("SendNotification", {
                Title = 'Ghost Ship',
                Text = v.Name,
                Duration = 10,
                Callback = bind,
                Button1 = "TP"
            })
            wait(0.5)
            starter:SetCore("SendNotification", {
                Title = 'Ghost Ship HP',
                Text = tostring(v.Humanoid.Health),
                Duration = 10,
                Callback = bind,
                Button1 = "TP"
            })

            return true
        end
    end

    for i,v in pairs(game:GetService("Workspace").SeaMonster:GetChildren())do
        starter:SetCore("SendNotification", {
            Title = v.Name,
            Text = tostring(v.Humanoid.Health),
            Duration = 10,
            Callback = bind,
            Button1 = "TP"
        })
    end

    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Legacy') then
            starter:SetCore("SendNotification", {
                Title = 'Sea King',
                Text = v.Name,
                Duration = 10,
                Callback = bind,
                Button1 = "TP"
            })
            return true
        end
    end

    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Sea King') then
            starter:SetCore("SendNotification", {
                Title = 'Hydra',
                Text = v.Name,
                Duration = 10,
                Callback = bind,
                Button1 = "TP"
            })

            return true
        end
    end

    for i,v in pairs(game:GetService("Workspace"):GetChildren())do
        if string.match(v.Name, 'Chest') then
            starter:SetCore("SendNotification", {
                Title = 'GS Chest',
                Text = v.Name,
                Duration = 5
            })
        end
    end
end

local function SpawnSK()
    local originalPos = pLoc()
    for i,v in pairs(game:GetService("Workspace"):GetChildren())do
        if string.match(v.Name, 'Chest') then
            TpPlayeTo(v.RootPart.CFrame)
            wait(0.2)
            TpPlayeTo(originalPos)
            starter:SetCore("SendNotification", {
                Title = 'ZenGod HD',
                Text = v.Name,
                Duration = 5
            })
        end
    end
    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Legacy') then
            TpPlayeTo(v.ChestSpawner.CFrame)
            wait(0.2)
            TpPlayeTo(originalPos)
            starter:SetCore("SendNotification", {
                Title = 'SK Steal :D',
                Text = 'Stealing Chest',
                Duration = 5
            })
        end
    end
    for i,v in pairs(game:GetService("Workspace").Island:GetChildren())do
        if string.match(v.Name, 'Sea King') then
            TpPlayeTo(v.Main.CFrame)
            wait(0.2)
            TpPlayeTo(originalPos)
            starter:SetCore("SendNotification", {
                Title = 'HD Steal :D',
                Text = 'Awwwww Men',
                Duration = 5
            })
        end
    end
end

function HPboss()
    spawn(function()
        while wait() do
            if _G.settings.checkbosshealth == true then
                for i,v in pairs(game:GetService("Workspace").SeaMonster:GetChildren())do
                    starter:SetCore("SendNotification", {
                        Title = v.Name,
                        Text = tostring(v.Humanoid.Health),
                        Duration = 10,
                        Callback = bind,
                        Button1 = "TP"
                    })
                end
            end
        end
    end)
end

function serverHop()
    starter:SetCore("SendNotification", {
        Title = 'ZenGod',
        Text = 'Warping',
        Duration = 5
    })
    local Player = game.Players.LocalPlayer    
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"

    local _place,_id = game.PlaceId, game.JobId
    local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
    end

    local Next; repeat
    local Servers = ListServers(Next)
    for i,v in next, Servers.data do
        if v.playing < v.maxPlayers and v.id ~= _id then
            local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
            if s then break end
        end
    end
    
    Next = Servers.nextPageCursor
    until not Next
end

if not checker() then
    starter:SetCore("SendNotification", {
        Title = 'Boss Checker',
        Text = 'Nothing Spawned',
        Duration = 5
    })
end

function AutoHopBoss()
    spawn(function()
        while wait() do
            if _G.settings.autoserverhop == true then
                if not checker() then
                    wait(5)
                    serverHop()
                else
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


UserInputService.InputBegan:Connect(function(Key) 
    if Key.KeyCode == Enum.KeyCode.F1 then
        _G.settings.autoserverhop = true
        AutoHopBoss()
    end
    if Key.KeyCode == Enum.KeyCode.F2 then
        if _G.settings.checkbosshealth = true then
            _G.settings.checkbosshealth = false
        else
            _G.settings.checkbosshealth = true
            HPboss()
        end
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
        Player.PlayerStats.ArmamentColor.Value = 'Arc'
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
        TPtoTOP('TP')
    end
end)
