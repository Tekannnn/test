


local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end
end


-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = "Mount Auto Summit [VIP VERSION]",
    Author = "by Unknwser •Man",
    NewElements = true,
    --Size = UDim2.fromOffset(700,700),
    
    HideSearchBar = false,
    
    OpenButton = {
        Title = "VIP Unknwser", -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = false,
        
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#89CFF0"), 
            Color3.fromHex("BD2A0B")
        )
    }
})

-- */  Tags  /* --
do
    Window:Tag({
        Title = "V1.0" ,
        Color = Color3.fromHex("D1310F")
    })
end

-- */  Theme (soon)  /* --
do
    WindUI:AddTheme({
        Name = "Stylish",
        
        Accent = Color3.fromHex("#3b82f6"), 
        Dialog = Color3.fromHex("#1a1a1a"), 
        Outline = Color3.fromHex("#3b82f6"),
        Text = Color3.fromHex("#f8fafc"),  
        Placeholder = Color3.fromHex("#94a3b8"),
        Button = Color3.fromHex("#334155"), 
        Icon = Color3.fromHex("#60a5fa"), 
        
        WindowBackground = Color3.fromHex("#0f172a"),
        
        TopbarButtonIcon = Color3.fromHex("#60a5fa"),
        TopbarTitle = Color3.fromHex("#f8fafc"),
        TopbarAuthor = Color3.fromHex("#94a3b8"),
        TopbarIcon = Color3.fromHex("#3b82f6"),
        
        TabBackground = Color3.fromHex("#1e293b"),    
        TabTitle = Color3.fromHex("#f8fafc"),
        TabIcon = Color3.fromHex("#60a5fa"),
        
        ElementBackground = Color3.fromHex("#1e293b"),
        ElementTitle = Color3.fromHex("#f8fafc"),
        ElementDesc = Color3.fromHex("#cbd5e1"),
        ElementIcon = Color3.fromHex("#60a5fa"),
    })
    
    
end



-- */ Other Functions /* --
local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end


-- */  Abo ut Tab  /* --
do
    local AboutTab = Window:Tab({
        Title = "About",
        Icon = "info",
    })
    
    local AboutSection = AboutTab:Section({
        Title = "Click Here",
    })
    
    AboutSection:Image({
        Image = "https://raw.githubusercontent.com/Tekannnn/script/main/beautiful-anime-kid-cartoon-scene.jpg",
        AspectRatio = "16:9",
        Radius = 9,
    })
    
    AboutSection:Space({ Columns = 3 })
    
    AboutSection:Section({
        Title = "Welcome Users!",
        TextSize = 24,
        FontWeight = Enum.FontWeight.SemiBold,
    })

    AboutSection:Space()
    
    AboutSection:Section({
        Title = [[You can resize this UI by clicking and dragging the bottom-right corner & freely moving it by holding and dragging the top section of the interface.]],
        TextSize = 18,
        TextTransparency = .35,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space({ Columns = 4 }) 
    

    
end

-- */  Elements Section  /* --
local ElementsSection = Window:Section({
    Title = "Features",
})

local MiscSection = Window:Section({
    Title = "Misc",
})
local ConfigUsageSection = Window:Section({
    Title = "Config Usage",
})


-- */ Using Nebula Icons /* --
do
    local NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()
    
    -- Adding icons (e.g. Fluency)
    WindUI.Creator.AddIcons("fluency",    NebulaIcons.Fluency)
    --               ^ Icon name          ^ Table of Icons
    
    -- You can also add nebula icons
    WindUI.Creator.AddIcons("nebula",    NebulaIcons.nebulaIcons)
    
    -- Usage ↑ ↓
    
    local TestSection = Window:Section({
        Title = "Enjoy!!!",
        Icon = "nebula:nebula",
    })
end

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local autoRejoinEnabled = false 

do
local ToggleTab = ElementsSection:Tab({
    Title = "Auto Summit",
    Icon = "arrow-left-right"
})

ToggleTab:Toggle({
    Title = "Mount Atin",
    Desc = "Auto Summit + Auto Rejoin [undetected]",
    Callback = function(enabled)
        if enabled then
            task.spawn(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                local cframe1 = CFrame.new(
                    624.730652, 1799.73059, 3432.02881,
                    0.990095973, -0.140392154, -1.42259523e-05,
                    0.137154281, 0.967239797, 0.21362561,
                    -0.0299775973, -0.211511821, 0.976915598
                )

            
                local cframe2 = CFrame.new(
                    780.575073, 2176.61157, 3922.71777,
                    1, 0, 0,
                    0, 1, 0,
                    0, 0, 1
                )

                hrp.CFrame = cframe1
                task.wait(1.5)

                hrp.CFrame = cframe2
                task.wait(2)

              local gui = Instance.new("ScreenGui")
                gui.Name = "RejoinNotify"
                gui.ResetOnSpawn = false
                gui.IgnoreGuiInset = true
                gui.Parent = player:WaitForChild("PlayerGui")

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0, 280, 0, 50)
                label.Position = UDim2.new(0.5, 0, 0.5, 0)
                label.AnchorPoint = Vector2.new(0.5, 0.5)
                label.BackgroundTransparency = 0.3
                label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                label.Text = "🔁 Auto Rejoining… Please wait"
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                label.TextWrapped = true
                label.Parent = gui
                Instance.new("UICorner", label).CornerRadius = UDim.new(0, 10)

                print("🔁 Rejoining same server...")
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
            end)
        end
    end
})



    
    ToggleTab:Space()
    
    local MountYahayukActive = false

ToggleTab:Toggle({
    Title = "Mount Yahayuk",
    Desc = "Auto Summit + Auto basecamp",
    Callback = function(enabled)
        MountYahayukActive = enabled

        if enabled then
            task.spawn(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                local gui = Instance.new("ScreenGui")
                gui.Name = "CountdownGui"
                gui.ResetOnSpawn = false
                gui.Parent = player:WaitForChild("PlayerGui")

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0, 200, 0, 30)
                label.Position = UDim2.new(0.5, -100, 0.1, 0)
                label.BackgroundTransparency = 1
                label.TextScaled = false
                label.TextSize = 18
                label.TextColor3 = Color3.new(1, 1, 1)
                label.Font = Enum.Font.SourceSansBold
                label.Text = ""
                label.Parent = gui

                local checkpoints = {
                    {cf = CFrame.new(-417.470642, 254.306625, 786.611694), delay = 20},
                    {cf = CFrame.new(-336.968018, 393.534241, 524.400024), delay = 11},
                    {cf = CFrame.new(294.790833, 435.087494, 494.530945), delay = 17},
                    {cf = CFrame.new(320.641327, 495.220337, 344.041077), delay = 6},
                    {cf = CFrame.new(232.317169, 319.144928, -144.600006), delay = 37},
                    {cf = CFrame.new(-615.762634, 909.040649, -541.110474), delay = 47},
                    {cf = CFrame.new(324.5, 486.15802, 367.5), delay = 1}
                }

                while MountYahayukActive do
                    for i, data in ipairs(checkpoints) do
                        for t = data.delay, 1, -1 do
                            if not MountYahayukActive then break end
                            label.Text = (i == 6 and "Guaranteed fastest summit " or "Teleporting in ") .. t .. "s..."
                            task.wait(1)
                        end
                        if not MountYahayukActive then break end
                        hrp.CFrame = data.cf
                    end
                end

                label.Text = ""
                gui:Destroy()
            end)
        end
    end
})



    
    ToggleTab:Space()
    
    
    ToggleTab:Toggle({
        Title = "Soon",
        Locked = true,
    })
    
    ToggleTab:Toggle({
        Title = "Soon",
        Desc = "",
        Locked = true,
    })
end


-- */  Button Tab  /* --
do
    local ButtonTab = ElementsSection:Tab({
        Title = "Teleport Checkpoint",
        Icon = "mouse-pointer-click",
    })


    
    ButtonTab:Dropdown({ 
        Flag = "DropdownTest",
        Title = "Mount Yahayuk",
        Values = {
            { Title = "Checkpoint 1" },
            { Title = "Checkpoint 2" },
            { Title = "Checkpoint 3" },
            { Title = "Checkpoint 4" },
            { Title = "Checkpoint 5" },
        },
        Value = "Checkpoint 1",
        Callback = function(option)
            selectedCheckpoint = option.Title
        end
    })


    ButtonTab:Button({
        Title = "Teleport",
        Callback = function()
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            local cframes = {
                ["Checkpoint 1"] = CFrame.new(-417.470642, 254.306625, 786.611694, -1.1920929e-07, -0, -1.00000012, 0, 1, -0, 1.00000012, 0, -1.1920929e-07),
                ["Checkpoint 2"] = CFrame.new(-336.968018, 393.534241, 524.400024, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                ["Checkpoint 3"] = CFrame.new(294.790833, 435.087494, 494.530945, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                ["Checkpoint 4"] = CFrame.new(320.641327, 495.220337, 344.041077, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                ["Checkpoint 5"] = CFrame.new(232.317169, 319.144928, -144.600006, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            }

            local targetCF = cframes[selectedCheckpoint]
            if targetCF then
                hrp.CFrame = targetCF
            end
        end
    })
end

do
    local CFspeed = 10
    local Walkspeed = 16
    local CFloop = nil
    local FlyActive = false
    local TeleportTarget = ""

    local FlyTab = MiscSection:Tab({
        Title = "FlightModule",
        Icon = "feather",
    })

    FlyTab:Toggle({
        Title = "Enable Fly Mode",
        Default = false,
        Callback = function(enabled)
            FlyActive = enabled
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local player = Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local Head = char:WaitForChild("Head")

            if enabled then
                humanoid.PlatformStand = true
                Head.Anchored = true

                if CFloop then CFloop:Disconnect() end
                CFloop = RunService.Heartbeat:Connect(function(deltaTime)
                    local moveDirection = humanoid.MoveDirection * (CFspeed * deltaTime)
                    local headCFrame = Head.CFrame
                    local camera = workspace.CurrentCamera
                    local cameraCFrame = camera.CFrame
                    local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
                    cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
                    local cameraPosition = cameraCFrame.Position
                    local headPosition = headCFrame.Position

                    local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
                    Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
                end)
            else
                if CFloop then CFloop:Disconnect() end
                humanoid.PlatformStand = false
                Head.Anchored = false
            end
        end
    })

    FlyTab:Slider({
        Flag = "FlySpeed",
        Title = "Fly Speed",
        Step = 1,
        Value = {
            Min = 10,
            Max = 600,
            Default = CFspeed,
        },
        Callback = function(value)
            CFspeed = value
        end
    })

    FlyTab:Slider({
        Flag = "Walkspeed",
        Title = "Walkspeed",
        Step = 1,
        Value = {
            Min = 8,
            Max = 100,
            Default = Walkspeed,
        },
        Callback = function(value)
            Walkspeed = value
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = value
                end
            end
        end
    })

    FlyTab:Textbox({
        Flag = "TeleportTarget",
        Title = "Target Player",
        Placeholder = "Enter player name...",
        Callback = function(value)
            TeleportTarget = value
        end
    })

    FlyTab:Button({
        Title = "Teleport to Player",
        Callback = function()
            local Players = game:GetService("Players")
            local speaker = Players.LocalPlayer
            local target = Players:FindFirstChild(TeleportTarget)

            if target and target.Character and speaker.Character then
                local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.SeatPart then
                    humanoid.Sit = false
                    task.wait(0.1)
                end

                local speakerRoot = speaker.Character:FindFirstChild("HumanoidRootPart")
                local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                if speakerRoot and targetRoot then
                    speakerRoot.CFrame = targetRoot.CFrame + Vector3.new(3, 1, 0)
                end

                if execCmd then
                    execCmd("breakvelocity")
                end
            end
        end
    })
end





do -- config panel
    local ConfigTab = ConfigUsageSection:Tab({
        Title = "Config Usage",
        Icon = "folder",
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Save Config",
        Icon = "",
        Justify = "Center",
        Callback = function()
            Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
            if Window.CurrentConfig:Save() then
                WindUI:Notify({
                    Title = "Config Saved",
                    Desc = "Config '" .. ConfigName .. "' saved",
                    Icon = "check",
                })
            end
        end
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Load Config",
        Icon = "",
        Justify = "Center",
        Callback = function()
            Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
            if Window.CurrentConfig:Load() then
                WindUI:Notify({
                    Title = "Config Loaded",
                    Desc = "Config '" .. ConfigName .. "' loaded",
                    Icon = "refresh-cw",
                })
            end
        end
    })
end