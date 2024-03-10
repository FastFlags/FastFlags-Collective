> [!IMPORTANT]
> MSG &nbsp; <br> [![Discord Presence](https://lanyard.cnrad.dev/api/996636510088601650?theme=dark&bg=00000&animated=false&hideDiscrim=true&borderRadius=30px&idleMessage=I'm%20currently%20beating%20my%20dick~&showDisplayName=true)](https://discord.com/users/996636510088601650) for submissions

<h1 align="center"><img src="https://i.imgur.com/O5jfEFH.png" width="28"/> Scripts Collective</h1>

<h3 align="center">https://discord.gg/Q5JKyzuNRC</h3>

<h6 align="center">https://discord.gg/fastflags</h6>

##### [3/1/2024]
* **2 Currently Listed**

## How to Use:
### BUY KRAMPUS FROM [BloxProducts](https://bloxproducts.com/#f0)
* Instant Delivery
* Cheapest
* Purchase with Robux
* Popular Payment Methods

 # List Navigation
* **[Harmful](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#Harmful)**
* **[Non-Harmful](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#)**

<img src="assets/images/bitdancer.png" width="888"/>

### 

<h3 align="center">══════⊹⊱≼≽⊰⊹══════</h3>


<h1 align="center">Harmful</h1>

### Phantom Forces: Silent Aim, ESP
```lua
local scriptSource = [[
    local silentaim = {
        enabled = true,
        fovEnabled = true,
        fovSize = 500,
        fovCircleEnabled = true,
        fovCircleColor = Color3.fromRGB(255, 255, 255),
        hitPercent = 100,
        headShotPercent = 100
    }
    local enemyesp = {
        boxCorners = true,
        boxLineSize = 0.33, -- 0.5 max
        boxColor = Color3.fromRGB(255, 99, 99),
        boxCornerOutline = true,
        names = true,
        nameSize = 12,
        nameOffset = 6,
        nameColor = Color3.fromRGB(255, 255, 255),
        nameOutline = true,
        healthBars = true,
        healthBarOffset = -5,
        healthBarThickness = 2,
        healthBarOutline = true,
        skeleton = true,
        skeletonThickness = 1,
        skeletonColor = Color3.fromRGB(255, 255, 255)
    }

    local requireModule
    for i, v in next, getgc(false) do
        if type(v) == "function" and debug.getinfo(v).name == "require" and islclosure(v) then
            requireModule = v
            break
        end
    end

    local publicSettings = requireModule("PublicSettings")
    local replication = requireModule("ReplicationInterface")
    local bulletObject = requireModule("BulletObject")
    local network = requireModule("NetworkClient")

    local runService = game:GetService("RunService")
    local workspace = game:GetService("Workspace")
    local players = game:GetService("Players")

    local currentCamera = workspace.CurrentCamera
    local localplayer = players.LocalPlayer
    local ignore = workspace.Ignore
    local new = bulletObject.new
    local zero = Vector3.zero
    local send = network.send
    local dot = zero.Dot

    local espData = {}
    local healthbarData = game:HttpGet("https://i.imgur.com/FpnD6XG.png")
    local defaultProperties = {
        Thickness = 1,
        Filled = false,
        Transparency = 1,
        Outline = false,
        Center = true,
        Visible = false
    }

    local fovCircle = Drawing.new("Circle")
    fovCircle.Position = currentCamera.ViewportSize * 0.5
    fovCircle.Visible = silentaim.fovCircleEnabled
    fovCircle.Color = silentaim.fovCircleColor
    fovCircle.Radius = silentaim.fovSize
    fovCircle.Transparency = 1
    fovCircle.Filled = false
    fovCircle.NumSides = 32

    local function getClosest(partName, fov)
        local distance, position, closestPlayer, part = fov or math.huge, nil, nil, nil
        fovCircle.Position = currentCamera.ViewportSize * 0.5
    
        replication.operateOnAllEntries(function(player, entry)
            local character = entry._thirdPersonObject and entry._thirdPersonObject._characterHash

            if character and player.Team ~= localplayer.Team then
                local screenPosition, onscreen = currentCamera:WorldToViewportPoint(character[partName].Position)
                local screenDistance = (Vector2.new(screenPosition.X, screenPosition.Y) - fovCircle.Position).Magnitude
    
                if screenPosition.Z > 0 and screenDistance < distance then
                    part = character[partName]
                    position = part.Position
                    distance = screenDistance
                    closestPlayer = entry
                end
            end
        end)

        return position, closestPlayer, part
    end

    local function trajectory(o, a, t, s, e)
        local f = -a
        local ld = t - o
        local a = dot(f, f)
        local b = 4 * dot(ld, ld)
        local k = (4 * (dot(f, ld) + s * s)) / (2 * a)
        local v = (k * k - b / a) ^ 0.5
        local t, t0 = k - v, k + v

        t = t < 0 and t0 or t; t = t ^ 0.5
        return f * t / 2 + (e or zero) + ld / t, t
    end

    local missChance
    local headChance
    function network:send(name, ...)
        if name == "newbullets" and silentaim.enabled and missChance <= silentaim.hitPercent then
            local position, entry, head = getClosest(headChance > silentaim.headShotPercent and "Torso" or "Head", silentaim.fovEnabled and silentaim.fovSize)

            if position then
                local a, data, time, b = ...
                local velocity = trajectory(data.firepos, publicSettings.bulletAcceleration, position, data.bullets[1][1].Magnitude, entry._velspring.t)

                for i = 1, #data.bullets do
                    data.bullets[i][1] = velocity
                end

                return send(self, name, a, data, time, b)
            end
        end

        return send(self, name, ...)
    end

    function bulletObject.new(data)
        if silentaim.enabled and data.onplayerhit and missChance <= silentaim.hitPercent then
            local position, entry, head = getClosest(headChance > silentaim.headShotPercent and "Torso" or "Head", silentaim.fovEnabled and silentaim.fovSize)

            if position then
                data.velocity = trajectory(data.position, publicSettings.bulletAcceleration, position, data.velocity.Magnitude, entry._velspring.t)
            end
        end

        return new(data)
    end

    task.spawn(function()
        while task.wait(0.1) do
            missChance = math.random(1, 100)
            headChance = math.random(1, 100)
        end
    end)

    function draw(shape)
        local drawing = Drawing.new(shape)

        for i, v in pairs(defaultProperties) do
            pcall(function()
                drawing[i] = v
            end)
        end

        return drawing
    end

    function getSquarePositions(character)
        local top = currentCamera:WorldToViewportPoint(character.Head.Position + Vector3.yAxis)
        local middle = currentCamera:WorldToViewportPoint(character.Torso.Position)
        local left = currentCamera:WorldToViewportPoint(character["Left Arm"].Position)
        local right = currentCamera:WorldToViewportPoint(character["Right Arm"].Position)

        local leftSize, rightSize
        if left.X < right.X then
            leftSize = "Left Arm"
            rightSize = "Right Arm"
        else
            leftSize = "Left Arm"
            rightSize = "Right Arm"
        end

        left = currentCamera:WorldToViewportPoint(character[leftSize].Position - currentCamera.CFrame.RightVector)
        right = currentCamera:WorldToViewportPoint(character[leftSize].Position + currentCamera.CFrame.RightVector)

        local size = Vector2.new(math.abs(left.X - right.X) * 2, (middle.Y - top.Y) * 2.2)

        return Vector2.new(middle.X - size.X * 0.5, top.Y), size
    end

    runService.Heartbeat:Connect(function()
        local alive = ignore:FindFirstChild("RefPlayer")

        replication.operateOnAllEntries(function(player, entry)
            local data = espData[player]

            if not data then
                data = {}
                data.visible = false
                data.entry = entry
                data.drawings = {
                    line100 = draw("Line"),
                    line101 = draw("Line"),
                    line110 = draw("Line"),
                    line111 = draw("Line"),
                    line120 = draw("Line"),
                    line121 = draw("Line"),
                    line130 = draw("Line"),
                    line131 = draw("Line"),
                    line000 = draw("Line"),
                    line001 = draw("Line"),
                    line010 = draw("Line"),
                    line011 = draw("Line"),
                    line020 = draw("Line"),
                    line021 = draw("Line"),
                    line030 = draw("Line"),
                    line031 = draw("Line"),
                    name = draw("Text"),
                    skeletonhead = draw("Line"),
                    skeletonlarm = draw("Line"),
                    skeletonrarm = draw("Line"),
                    skeletonlleg = draw("Line"),
                    skeletonrleg = draw("Line"),
                    healthbaroutline = draw("Square"),
                    healthbarimage = draw("Image"),
                    healthbarsquare = draw("Square"),
                }
                for drawingName, drawing in next, data.drawings do
                    if string.find(drawingName, "line1") then
                        drawing.Thickness = 3
                        drawing.Color = Color3.fromRGB(0, 0, 0)
                    end
                end
                data.drawings.name.Text = player.Name
                data.drawings.healthbarsquare.Filled = true
                data.drawings.healthbaroutline.Filled = true
                data.drawings.healthbaroutline.Color = Color3.fromRGB(0, 0, 0)
                data.drawings.healthbarimage.Data = healthbarData
                data.drawings.healthbarimage.Visible = true
                data.setVisibility = function(visible)
                    data.drawings.name.Visible = visible and enemyesp.names
                    data.drawings.line000.Visible = visible and enemyesp.boxCorners
                    data.drawings.line001.Visible = visible and enemyesp.boxCorners
                    data.drawings.line010.Visible = visible and enemyesp.boxCorners
                    data.drawings.line011.Visible = visible and enemyesp.boxCorners
                    data.drawings.line020.Visible = visible and enemyesp.boxCorners
                    data.drawings.line021.Visible = visible and enemyesp.boxCorners
                    data.drawings.line030.Visible = visible and enemyesp.boxCorners
                    data.drawings.line031.Visible = visible and enemyesp.boxCorners
                    data.drawings.line100.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line101.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line110.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line111.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line120.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line121.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line130.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.line131.Visible = visible and enemyesp.boxCorners and enemyesp.boxCornerOutline
                    data.drawings.skeletonhead.Visible = visible and enemyesp.skeleton
                    data.drawings.skeletonlarm.Visible = visible and enemyesp.skeleton
                    data.drawings.skeletonrarm.Visible = visible and enemyesp.skeleton
                    data.drawings.skeletonlleg.Visible = visible and enemyesp.skeleton
                    data.drawings.skeletonrleg.Visible = visible and enemyesp.skeleton
                    data.drawings.healthbaroutline.Visible = visible and enemyesp.healthBars and enemyesp.healthBarOutline
                    data.drawings.healthbarimage.Transparency = visible and enemyesp.healthBars and 1 or 0
                    data.drawings.healthbarimage.Visible = visible and enemyesp.healthBars
                    data.drawings.healthbarsquare.Visible = visible and enemyesp.healthBars
                    data.visible = visible
                end

                espData[player] = data
            end

            if (not entry._alive and data.visible) or not alive then
                data.setVisibility(false)
            end
        end)

        if alive and alive:FindFirstChild("HumanoidRootPart") then
            for player, data in next, espData do
                if data.entry._alive and data.entry._player.Team ~= players.LocalPlayer.Team then
                    local character = data.entry._thirdPersonObject and data.entry._thirdPersonObject._characterHash

                    if character then
                        local screenPosition, onScreen = currentCamera:WorldToViewportPoint(character.Head.Position)

                        if onScreen and screenPosition.Z > 0 then
                            if not data.visible then
                                data.setVisibility(true)
                            end
                            
                            local boxPosition, boxSize, middle
                            if enemyesp.boxCorners or enemyesp.names or enemyesp.healthBars then
                                boxPosition, boxSize = getSquarePositions(character)
                                middle = boxPosition + boxSize * 0.5
                            end

                            local p0, p1, p2, p3, sx, sy, p00, p01, p10, p11, p20, p21, p30, p31
                            if enemyesp.boxCorners then
                                sx, sy = Vector2.new(boxSize.X, 0), Vector2.new(0, boxSize.Y)
                                p0, p1, p2, p3 = boxPosition, boxPosition + sx, boxPosition + sy, boxPosition + sx + sy
                                sx, sy = sx * enemyesp.boxLineSize, sy * enemyesp.boxLineSize
                                p00, p01, p10, p11, p20, p21, p30, p31 = p0 + sx, p0 + sy, p1 - sx, p1 + sy, p2 + sx, p2 - sy, p3 - sx, p3 - sy

                                data.drawings.line000.From = p0
                                data.drawings.line001.From = p0
                                data.drawings.line000.To = p00
                                data.drawings.line001.To = p01
                                data.drawings.line010.From = p1
                                data.drawings.line011.From = p1
                                data.drawings.line010.To = p10
                                data.drawings.line011.To = p11
                                data.drawings.line020.From = p2
                                data.drawings.line021.From = p2
                                data.drawings.line020.To = p20
                                data.drawings.line021.To = p21
                                data.drawings.line030.From = p3
                                data.drawings.line031.From = p3
                                data.drawings.line030.To = p30
                                data.drawings.line031.To = p31

                                for drawingName, drawing in next, data.drawings do
                                    if string.find(drawingName, "line0") then
                                        drawing.Color = enemyesp.boxColor
                                    end
                                end
                            end
                            
                            if data.drawings.line100.Visible then
                                data.drawings.line100.From = p0
                                data.drawings.line101.From = p0
                                data.drawings.line100.To = p00
                                data.drawings.line101.To = p01
                                data.drawings.line110.From = p1
                                data.drawings.line111.From = p1
                                data.drawings.line110.To = p10
                                data.drawings.line111.To = p11
                                data.drawings.line120.From = p2
                                data.drawings.line121.From = p2
                                data.drawings.line120.To = p20
                                data.drawings.line121.To = p21
                                data.drawings.line130.From = p3
                                data.drawings.line131.From = p3
                                data.drawings.line130.To = p30
                                data.drawings.line131.To = p31
                            end

                            if enemyesp.names then
                                local name = data.drawings.name
                                name.Position = Vector2.new(middle.X, boxPosition.Y + (enemyesp.nameOffset < 0 and boxSize.Y or 0) - enemyesp.nameOffset - enemyesp.nameSize * 0.5)
                                name.Size = enemyesp.nameSize
                                name.Color = enemyesp.nameColor
                                name.Outline = enemyesp.nameOutline
                            end

                            if enemyesp.healthBars then
                                local healthbarimage = data.drawings.healthbarimage
                                local healthbarsquare = data.drawings.healthbarsquare
                                local health = (data.entry._healthstate.health0 ~= 0 and data.entry._healthstate.health0 or 100) * 0.01
                                local squareSize = boxSize.Y * (1 - health)
                                healthbarimage.Position = Vector2.new(boxPosition.X + (enemyesp.healthBarOffset > 0 and boxSize.X or 0) + enemyesp.healthBarOffset - enemyesp.healthBarThickness * 0.5, boxPosition.Y)
                                healthbarimage.Size = Vector2.new(enemyesp.healthBarThickness, boxSize.Y)
                                healthbarsquare.Position = healthbarimage.Position
                                healthbarsquare.Size = Vector2.new(enemyesp.healthBarThickness, squareSize)
                            end

                            if data.drawings.healthbaroutline.Visible then
                                local healthbaroutline = data.drawings.healthbaroutline
                                healthbaroutline.Position = data.drawings.healthbarimage.Position - Vector2.new(1, 1)
                                healthbaroutline.Size = data.drawings.healthbarimage.Size + Vector2.new(2, 2)
                            end

                            if enemyesp.skeleton then
                                local rootPos = currentCamera:WorldToViewportPoint(character.Torso.Position)
                                local larmPos = currentCamera:WorldToViewportPoint(character["Left Arm"].Position)
                                local rarmPos = currentCamera:WorldToViewportPoint(character["Right Arm"].Position)
                                local llegPos = currentCamera:WorldToViewportPoint(character["Left Leg"].Position)
                                local rlegPos = currentCamera:WorldToViewportPoint(character["Right Leg"].Position)
                                
                                local drawings = data.drawings
                                drawings.skeletonhead.To = Vector2.new(screenPosition.X, screenPosition.Y)
                                drawings.skeletonlarm.To = Vector2.new(larmPos.X, larmPos.Y)
                                drawings.skeletonrarm.To = Vector2.new(rarmPos.X, rarmPos.Y)
                                drawings.skeletonlleg.To = Vector2.new(llegPos.X, llegPos.Y)
                                drawings.skeletonrleg.To = Vector2.new(rlegPos.X, rlegPos.Y)

                                local fromPos = Vector2.new(rootPos.X, rootPos.Y)
                                for drawingName, drawing in next, drawings do
                                    if string.find(drawingName, "skeleton") then
                                        drawing.Thickness = enemyesp.skeletonThickness
                                        drawing.Color = enemyesp.skeletonColor
                                        drawing.From = fromPos
                                    end
                                end
                            end
                        elseif data.visible then
                            data.setVisibility(false)
                        end
                    end
                end
            end
        end
    end)

    players.PlayerRemoving:Connect(function(player)
        player = espData[player]

        if player then
            player.setVisibility(false)

            for _, drawing in next, player.drawings do
                drawing:Remove()
            end

            espData[player] = nil
        end
    end)
]]

local requireModule
for i, v in next, getgc(false) do
    if type(v) == "function" and debug.getinfo(v).name == "require" and islclosure(v) then
        requireModule = v
        break
    end
end

if requireModule then
    loadstring(scriptSource)()
else
    queue_on_teleport("task.wait(5);" .. scriptSource)
    setfflag("DebugRunParallelLuaOnMainThread", "True")
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end
```
### Universal: Eclipse Hub
#### https://eclipsehub.xyz/
```lua
getgenv().mainKey = "nil";

local a,b,c,d,e=loadstring,request or http_request or (http and http.request) or (syn and syn.request),assert,tostring,"https\58//api.eclipsehub.xyz/auth";c(a and b,"Executor not Supported")a(b({Url=e.."\?\107e\121\61"..d(mainKey),Headers={["User-Agent"]="Eclipse"}}).Body)()
```
### Criminality: Moonlight
#### https://moonhub.lol/
```lua
loadstring(game:HttpGet("https://hideout.one/api/cdn/loader"))()
```

<h4 align="center">Non-Harmful</h4>

### Universal: AntiChatLogger
#### https://github.com/AnthonyIsntHere/
```lua
if not game:IsLoaded() then
    game.Loaded:wait()
end

local ACL_LoadTime = tick()
local NotificationTitle = "Anthony's ACL"

local OldCoreTypeSettings = {}
local WhitelistedCoreTypes = {
    "Chat",
    "All",
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.All
}

local OldCoreSetting = nil

local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local Notify = function(_Title, _Text , Time)
    StarterGui:SetCore("SendNotification", {Title = _Title, Text = _Text, Icon = "rbxassetid://2541869220", Duration = Time})
end

local Tween = function(Object, Time, Style, Direction, Property)
    return TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle[Style], Enum.EasingDirection[Direction]), Property)
end

local PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") do
    if not PlayerGui then
        local Timer = tick() + 5
        repeat task.wait() until Player:FindFirstChildWhichIsA("PlayerGui") or (tick() > Timer)
        PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") or false
        if not PlayerGui then
            return Notify(NotificationTitle, "Failed to find PlayerGui!", 10)
        end
    end
end

if getgenv().AntiChatLogger then
    return Notify(NotificationTitle, "Anti Chat & Screenshot Logger already loaded!", 15)
else
    getgenv().AntiChatLogger = true
end

local Metatable = getrawmetatable(StarterGui)
setreadonly(Metatable, false)

local MessageEvent = Instance.new("BindableEvent")

if hookmetamethod then
    local CoreHook do
        CoreHook = hookmetamethod(StarterGui, "__namecall", newcclosure(function(self, ...)
            local Method = getnamecallmethod()
            local Arguments = {...}
            
            if self == StarterGui and not checkcaller() then
                if Method == "SetCoreGuiEnabled" then
                    local CoreType = Arguments[1]
                    local Enabled = Arguments[2]
                    
                    if table.find(WhitelistedCoreTypes, CoreType) and Enabled == false then -- Thanks Harun for correcting me on the second argument
                        OldCoreTypeSettings[CoreType] = Enabled
                        return
                    end
                elseif Method == "SetCore" then
                    local Core = Arguments[1]
                    local Connection = Arguments[2]
                    
                    if Core == "CoreGuiChatConnections" then
                        OldCoreSetting = Connection
                        return
                    end
                end
            end
            
            return CoreHook(self, ...)
        end))
    end

    if not getgenv().ChattedFix then
        getgenv().ChattedFix = true

        local ChattedFix do
            ChattedFix = hookmetamethod(Player, "__index", newcclosure(function(self, index)
                if self == Player and tostring(index):lower():match("chatted") and MessageEvent.Event then
                    return MessageEvent.Event
                end

                return ChattedFix(self, index)
            end))
        end

        local AnimateChattedFix = task.spawn(function()
            local ChattedSignal = false

            for _, x in next, getgc() do
                if type(x) == "function" and getfenv(x).script ~= nil and tostring(getfenv(x).script) == "Animate" then
                    if islclosure(x) then
                        local Constants = getconstants(x)

                        for _, v in next, Constants do
                            if v == "Chatted" then
                                ChattedSignal = x
                            end
                        end
                    end
                end
            end

            if ChattedSignal then
                ChattedSignal()
            end
        end)
    end
end

local EnabledChat = task.spawn(function()
    repeat
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        task.wait()
    until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end)

local WarningGuiThread = task.spawn(function()
    WarningUI = Instance.new("ScreenGui")
    Main = Instance.new("Frame")
    BackgroundHolder = Instance.new("Frame")
    Background = Instance.new("Frame")
    TopBar = Instance.new("Frame")
    UIGradient = Instance.new("UIGradient")
    TitleHolder = Instance.new("Frame")
    Title = Instance.new("TextLabel")
    Holder = Instance.new("Frame")
    UIListLayout = Instance.new("UIListLayout")
    Reason_1 = Instance.new("TextLabel")
    Reason_2 = Instance.new("TextLabel")
    Reason_3 = Instance.new("TextLabel")
    WarningText = Instance.new("TextLabel")
    Exit = Instance.new("TextButton")
    ImageLabel = Instance.new("ImageLabel")
    
    WarningUI.Enabled = false
    WarningUI.Name = "WarningUI"
    WarningUI.Parent = CoreGui
    
    Main.Name = "Main"
    Main.Parent = WarningUI
    Main.AnchorPoint = Vector2.new(.5, .5)
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BackgroundTransparency = 1
    Main.Position = UDim2.new(.5, 0, .5, 0)
    Main.Size = UDim2.new(0, 400, 0, 400)
    
    BackgroundHolder.Name = "BackgroundHolder"
    BackgroundHolder.Parent = Main
    BackgroundHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    BackgroundHolder.BackgroundTransparency = .25
    BackgroundHolder.BorderSizePixel = 0
    BackgroundHolder.Size = UDim2.new(1, 0, 1, 0)
    
    Background.Name = "Background"
    Background.Parent = BackgroundHolder
    Background.AnchorPoint = Vector2.new(.5, .5)
    Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Background.BorderSizePixel = 0
    Background.Position = UDim2.new(.5, 0, .5, 0)
    Background.Size = UDim2.new(.96, 0, .96, 0)
    
    TopBar.Name = "TopBar"
    TopBar.Parent = Background
    TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 2)
    
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 149, 146)), ColorSequenceKeypoint.new(.29, Color3.fromRGB(93, 86, 141)), ColorSequenceKeypoint.new(.50, Color3.fromRGB(126, 64, 138)), ColorSequenceKeypoint.new(.75, Color3.fromRGB(143, 112, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(159, 159, 80))}
    UIGradient.Parent = TopBar
    
    TitleHolder.Name = "TitleHolder"
    TitleHolder.Parent = Background
    TitleHolder.AnchorPoint = Vector2.new(.5, .5)
    TitleHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleHolder.BorderColor3 = Color3.fromRGB(44, 44, 44)
    TitleHolder.BorderSizePixel = 2
    TitleHolder.Position = UDim2.new(.5, 0, .5, 0)
    TitleHolder.Size = UDim2.new(.9, 0, .9, 0)
    
    Title.Name = "Title"
    Title.Parent = TitleHolder
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 15, 0, -12)
    Title.Size = UDim2.new(0, 75, 0, 20)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Warning"
    Title.TextColor3 = Color3.fromRGB(235, 235, 235)
    Title.TextScaled = true
    Title.TextWrapped = true
    
    Holder.Name = "Holder"
    Holder.Parent = TitleHolder
    Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Holder.BackgroundTransparency = 1
    Holder.Position = UDim2.new(0, 30, .125, 0)
    Holder.Size = UDim2.new(1, -30, .875, 0)
    
    UIListLayout.Parent = Holder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    Reason_1.Name = "Reason_1"
    Reason_1.Parent = Holder
    Reason_1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Reason_1.BackgroundTransparency = 1
    Reason_1.BorderSizePixel = 0
    Reason_1.Size = UDim2.new(1, 0, 0, 20)
    Reason_1.Font = Enum.Font.SourceSans
    Reason_1.Text = "- TextChatService is enabled"
    Reason_1.TextColor3 = Color3.fromRGB(199, 40, 42)
    Reason_1.TextScaled = true
    Reason_1.TextWrapped = true
    Reason_1.TextXAlignment = Enum.TextXAlignment.Left
    Reason_1.Visible = false
    
    Reason_2.Name = "Reason_2"
    Reason_2.Parent = Holder
    Reason_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Reason_2.BackgroundTransparency = 1
    Reason_2.BorderSizePixel = 0
    Reason_2.Size = UDim2.new(1, 0, 0, 20)
    Reason_2.Font = Enum.Font.SourceSans
    Reason_2.Text = "- Legacy chat module was not found"
    Reason_2.TextColor3 = Color3.fromRGB(199, 40, 42)
    Reason_2.TextScaled = true
    Reason_2.TextWrapped = true
    Reason_2.TextXAlignment = Enum.TextXAlignment.Left
    Reason_2.Visible = false
    
    Reason_3.Name = "Reason_3"
    Reason_3.Parent = Holder
    Reason_3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Reason_3.BackgroundTransparency = 1
    Reason_3.BorderSizePixel = 0
    Reason_3.Size = UDim2.new(1, 0, 0, 20)
    Reason_3.Font = Enum.Font.SourceSans
    Reason_3.Text = "- MessagePosted function was not found"
    Reason_3.TextColor3 = Color3.fromRGB(199, 40, 42)
    Reason_3.TextScaled = true
    Reason_3.TextWrapped = true
    Reason_3.TextXAlignment = Enum.TextXAlignment.Left
    Reason_3.Visible = false
    
    WarningText.Name = "WarningText"
    WarningText.Parent = TitleHolder
    WarningText.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    WarningText.BackgroundTransparency = 1
    WarningText.BorderSizePixel = 0
    WarningText.Position = UDim2.new(0, 30, .05, 0)
    WarningText.RichText = true
    WarningText.Size = UDim2.new(1, -30, 0, 20)
    WarningText.Font = Enum.Font.SourceSans
    WarningText.Text = "> Anti-<font color=\"#6ea644\">Chat Logger</font> will not work here!"
    WarningText.TextColor3 = Color3.fromRGB(255, 255, 255)
    WarningText.TextScaled = true
    WarningText.TextWrapped = true
    WarningText.TextXAlignment = Enum.TextXAlignment.Left
    
    Exit.Name = "Exit"
    Exit.Parent = TitleHolder
    Exit.AnchorPoint = Vector2.new(.5, .5)
    Exit.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Exit.Position = UDim2.new(.5, 0, .899999976, 0)
    Exit.Size = UDim2.new(0, 250, 0, 20)
    Exit.Font = Enum.Font.SourceSans
    Exit.Text = "Ok"
    Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Exit.TextScaled = true
    Exit.TextWrapped = true
    
    ImageLabel.Parent = TitleHolder
    ImageLabel.AnchorPoint = Vector2.new(.5, .5)
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(.5, 0, .6, 0)
    ImageLabel.Size = UDim2.new(.3, 0, .3, 0)
    ImageLabel.ZIndex = 1
    ImageLabel.Image = "rbxassetid://12969025384"
    ImageLabel.ImageColor3 = Color3.fromRGB(40, 40, 40)
    ImageLabel.ImageTransparency = .5
    
    Exit.MouseButton1Down:Connect(function()
        WarningUI:Destroy()
    end)
end)

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    WarningUI.Enabled = true
    Reason_1.Visible = true
    return
end

local PlayerScripts = Player:WaitForChild("PlayerScripts")
local ChatMain = PlayerScripts:FindFirstChild("ChatMain", true) or false

if not ChatMain then
    local Timer = tick()
    
    repeat task.wait() until PlayerScripts:FindFirstChild("ChatMain", true) or tick() > (Timer + 3)
    ChatMain = PlayerScripts:FindFirstChild("ChatMain", true)
    
    if not ChatMain then
        WarningUI.Enabled = true
        Reason_2.Visible = true
        return
    end
end

local PostMessage = require(ChatMain).MessagePosted

if not PostMessage then
    WarningUI.Enabled = true
    Reason_3.Visible = true
    return
end

local OldFunctionHook; OldFunctionHook = hookfunction(PostMessage.fire, function(self, Message)
    if self == PostMessage then
        MessageEvent:Fire(Message)
        return
    end
    return OldFunctionHook(self, Message)
end)

if setfflag then
    pcall(function()
        setfflag("AbuseReportScreenshot", "False")
        setfflag("AbuseReportScreenshotPercentage", "0")
    end)
end -- To prevent roblox from taking screenshots of your client.

local Credits = task.spawn(function()
    local UserIds = {
        1414978355
    }
    
    if table.find(UserIds, Player.UserId) then
        return
    end
    
    local Tag = Instance.new("BillboardGui")
    local Title = Instance.new("TextLabel", Tag)
    local Rank = Instance.new("TextLabel", Tag)
    local Gradient = Instance.new("UIGradient", Title)
    
    Tag.Brightness = 2
    Tag.Size = UDim2.new(4, 0, 1, 0)
    Tag.StudsOffsetWorldSpace = Vector3.new(0, 5, 0)
    
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, .6, 0)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    
    Rank.AnchorPoint = Vector2.new(.5, 0)
    Rank.BackgroundTransparency = 1
    Rank.Position = UDim2.new(.5, 0, .65, 0)
    Rank.Size = UDim2.new(.75, 0, .5, 0)
    Rank.TextColor3 = Color3.fromRGB(0, 0, 0)
    Rank.TextScaled = true
    Rank.Text = "< Anti Chat-Logger >"
    
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(.75, .75, .75)),
        ColorSequenceKeypoint.new(.27, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(.5, Color3.new(.3, 0, .5)),
        ColorSequenceKeypoint.new(0.78, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(.75, .75, .75))
    })
    Gradient.Offset = Vector2.new(-1, 0)
    
    local GradientTeen = Tween(Gradient, 2, "Circular", "Out", {Offset = Vector2.new(1, 0)})
    
    function PlayAnimation()
    	GradientTeen:Play()
    	GradientTeen.Completed:Wait()
    	Gradient.Offset = Vector2.new(-1, 0)
    	task.wait(.75)
    	PlayAnimation()
    end
    
    local AddTitle = function(Character)
        repeat task.wait() until Character
        
        local Humanoid = Character and Character:WaitForChild("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        
        if Humanoid then
            Humanoid:GetPropertyChangedSignal("RootPart"):Connect(function()
                if Humanoid.RootPart then
                    Tag.Adornee = RootPart
                end
            end)
        end
        
        if RootPart then
            Tag.Adornee = RootPart
        end
    end
    
    task.spawn(PlayAnimation)
    
    for _, x in next, Players:GetPlayers() do
        if table.find(UserIds, x.UserId) then
            Tag.Parent = workspace.Terrain
            Title.Text = x.Name
            AddTitle(x.Character)
            x.CharacterAdded:Connect(AddTitle)
        end
    end
    
    Players.PlayerAdded:Connect(function(x)
        if table.find(UserIds, x.UserId) then
            Tag.Parent = workspace.Terrain
            Title.Text = x.Name
            x.CharacterAdded:Connect(AddTitle)
        end
    end)
    
    Players.PlayerRemoving:Connect(function(x)
        if table.find(UserIds, x.UserId) then
            Tag.Parent = game
        end
    end)
end)

task.delay(1, function() WarningUI:Destroy() end)

for _, x in next, OldCoreTypeSettings do
    if not x then
        StarterGui:SetCore("ChatActive", false)
    end
    StarterGui:SetCoreGuiEnabled(_, x)
end

if OldCoreSetting then
    StarterGui:SetCore("CoreGuiChatConnections", OldCoreSetting)
end

if StarterGui:GetCore("ChatActive") then
    StarterGui:SetCore("ChatActive", false)
    StarterGui:SetCore("ChatActive", true)
end

--Metatable.__namecall = CoreHook
if CoreHook then
    setmetatable(Metatable, {__namecall = CoreHook}) 
end
setreadonly(Metatable, true)

Notify(NotificationTitle, "Anti Chat & Screenshot Logger Loaded!", 15)
print(string.format("AnthonyIsntHere's Anti Chat-Logger has loaded in %s seconds.", string.format("%.2f", tostring(tick() - ACL_LoadTime))))
```
<h4 align="center">‧⁺̣˚̣̣*̣̩⋆̩·̩̩୨˚̣̣̣̣͙୧·̩̩⋆̩*̣̩˚̣̣⁺̣‧ You've reached the bottom of the list! ‧⁺̣˚̣̣*̣̩⋆̩·̩̩୨˚̣̣̣̣͙୧·̩̩⋆̩*̣̩˚̣̣⁺̣‧୨</h4>

# List Information

* Maintained by RFFC

<h3 align="center">FastFlags 2024®<sup>eal</sup></h3>
