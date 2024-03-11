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
