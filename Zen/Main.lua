-- ZenXNight Hub V10 - 100% WORKING ON DELTA / FLUXUS / VNG / ANY EXECUTOR (2025)
-- Key: O-Pe8JdDev_9Clax01-1
-- Link: https://sub2unlock.io/AOc07
-- Tested & working on Delta, Fluxus, VNG Krnl, Arceus X, Hydrogen

if not table.find({2753915549,4442272183,7449423635},game.PlaceId)then return end
local SEA=game.PlaceId==2753915549 and 1 or game.PlaceId==4442272183 and 2 or 3
 local LP=game.Players.LocalPlayer
local Char=LP.Character or LP.CharacterAdded:Wait()
local HRP=Char:WaitForChild("HumanoidRootPart")
local TS=game:GetService("TweenService")
local VU=game:GetService("VirtualUser")
local CommF=game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local TP=game:GetService("TeleportService")

local T={F=false,A=false,S=false,Stat="Melee",Spd=350,R=false,SE=false,H=false}

local Spots={[1]=CFrame.new(1059,16,1548),[2]=CFrame.new(424,73,10),[3]=CFrame.new(5582,619,31)}

local function N(t,text)game.StarterGui:SetCore("SendNotification",{Title=t,Text=text,Duration=5})end

local function Mob()
    local c,d=nil,math.huge
    for _,v in workspace.Enemies:GetChildren()do
        if v:FindFirstChild("HumanoidRootPart")and v.Humanoid.Health>0 then
            local m=(v.HumanoidRootPart.Position-HRP.Position).Magnitude
            if m<d then c=v d=m end
        end
    end
    return c
end

local function Go(cf)
    TS:Create(HRP,TweenInfo.new((HRP.Position-cf.Position).Magnitude/T.Spd,Enum.EasingStyle.Linear),{CFrame=cf}):Play()
end

-- MAIN LOOPS
spawn(function()
    while task.wait(0.1)do
        if T.F then
            local m=Mob()
            if m then Go(m.HumanoidRootPart.CFrame*CFrame.new(0,10,0))
            else Go(Spots[SEA]*CFrame.new(0,10,0))end
        end
        if T.A then VU:ClickButton1(Vector2.new())end
    end
end)

spawn(function()
    while task.wait(5)do
        if T.S then pcall(function()CommF:InvokeServer("AddPoint",T.Stat,1)end)end
        if T.R and SEA>=2 then pcall(function()CommF:InvokeServer("RaidsNpc","Select",10)CommF:InvokeServer("RaidsNpc","Join")end)end
        if T.SE and SEA>=2 then pcall(function()CommF:InvokeServer("BuyBoat","PirateBasic")end)end
        if T.H and #game.Players:GetPlayers()<=3 then TP:Teleport(game.PlaceId,LP)end
    end
end)

-- SUPER SIMPLE UI (WORKS ON EVERY EXECUTOR INCLUDING VNG)
local SG=Instance.new("ScreenGui",game.CoreGui)
SG.Name="ZenXNight"
local Frame=Instance.new("Frame",SG)
Frame.Size=UDim2.new(0,320,0,380); Frame.Position=UDim2.new(0.5,-160,0.5,-190)
Frame.BackgroundColor3=Color3.fromRGB(20,20,20); Frame.BorderSizePixel=2; Frame.BorderColor3=Color3.fromRGB(0,170,255)

local Title=Instance.new("TextLabel",Frame)
Title.Size=UDim2.new(1,0,0,40); Title.BackgroundColor3=Color3.fromRGB(0,170,255)
Title.Text="ZenXNight Hub V10 - Sea "..SEA; Title.TextColor3=Color3.new(1,1,1); Title.Font=Enum.Font.GothamBold; Title.TextSize=20

local y=50
local function Btn(name,callback)
    local b=Instance.new("TextButton",Frame)
    b.Size=UDim2.new(0,290,0,40); b.Position=UDim2.new(0,15,0,y)
    b.BackgroundColor3=Color3.fromRGB(40,40,40); b.Text=name.." [OFF]"; b.TextColor3=Color3.new(1,1,1)
    local on=false
    b.MouseButton1Click:Connect(function()
        on=not on
        b.Text=name.." ["..(on and "ON" or "OFF").."]"
        b.BackgroundColor3=on and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
        callback(on)
    end)
    y=y+50
end

Btn("Auto Farm",function(v)T.F=v end)
Btn("Auto Attack",function(v)T.A=v end)
Btn("Auto Stats",function(v)T.S=v end)
if SEA>=2 then
    Btn("Auto Raid",function(v)T.R=v end)
    Btn("Auto Sea Event",function(v)T.SE=v end)
end
Btn("Auto Hop",function(v)T.H=v end)

-- Stat & Speed
local StatBtn=Instance.new("TextButton",Frame)
StatBtn.Size=UDim2.new(0,290,0,40); StatBtn.Position=UDim2.new(0,15,0,y)
StatBtn.BackgroundColor3=Color3.fromRGB(40,40,40); StatBtn.Text="Stat: Melee"
StatBtn.TextColor3=Color3.new(1,1,1)
local stats={"Melee","Defense","Sword","Gun","Fruit"} local i=1
StatBtn.MouseButton1Click:Connect(function()
    i=i+1 if i>#stats then i=1 end
    StatBtn.Text="Stat: "..stats[i]
    T.Stat=stats[i]
end)
y=y+50

local SpeedBtn=Instance.new("TextButton",Frame)
SpeedBtn.Size=UDim2.new(0,290,0,40); SpeedBtn.Position=UDim2.new(0,15,0,y)
SpeedBtn.BackgroundColor3=Color3.fromRGB(40,40,40); SpeedBtn.Text="Speed: 350"
SpeedBtn.TextColor3=Color3.new(1,1,1)
SpeedBtn.MouseButton1Click:Connect(function()
    T.Spd=T.Spd+50 if T.Spd>600 then T.Spd=100 end
    SpeedBtn.Text="Speed: "..T.Spd
end)

-- KEY
local KEY="O-Pe8JdDev_9Clax01-1"
if not isfile("ZenXKey.txt")or readfile("ZenXKey.txt")~=KEY then
    setclipboard("https://sub2unlock.io/AOc07")
    N("ZenXNight","Key required - link copied!")
    repeat task.wait()until isfile("ZenXKey.txt")and readfile("ZenXKey.txt")==KEY
end

N("ZenXNight V10","Loaded 100% - works on Delta / Fluxus / VNG / Krnl")
