

Services = setmetatable({}, {
	__index = function(self, name)
		local success, cache = pcall(function()
			return cloneref(game:GetService(name))
		end)
		if success then
			rawset(self, name, cache)
			return cache
		else
			error("Invalid Service: " .. tostring(name))
		end
	end
})

local loopTp=false
local tpPerson=""

local Players=Services.Players
local RunService=Services.RunService
local lp = Players.LocalPlayer
local hiddenfling=false

local function fling()
	local oink
	oink=RunService.Heartbeat:Connect(function()
        if loopTp == false then
            oink:Disconnect()
        end
        lp.Head.CanCollide = false
        lp.UpperTorso.CanCollide = false
        lp.LowerTorso.CanCollide = false
        lp.HumanoidRootPart.CanCollide = false
    end)
    wait(.1)
    local g = Instance.new("BodyThrust")
    g.Parent = lp.HumanoidRootPart
    g.Force = Vector3.new(999,999,999)
    g.Location = lp.HumanoidRootPart.Position
end

local spawnConnection
local runConnection
local localConnection

local function spamTP()
    local settings = {
        Distance = -5,   
        Speed = 0.3,     
        Smoothness = 0.2 
    }
    local p
    for _, pl in Players:GetPlayers() do
        if pl ~= lp then
            if string.lower(pl.Name) == string.lower(tpPerson) then
                p=pl
            end
        end
    end
    if p == nil then
        loopTp=false
        hiddenfling=false
        return
    end
    local targetChar = p.Character or p.CharacterAdded:Wait()
    local localChar = lp.Character or lp.CharacterAdded:Wait()

    spawnConnection = p.CharacterAdded:Connect(function(c)
        targetChar = c
    end)

    localConnection = lp.CharacterAdded:Connect(function(c)
        localChar = c
    end)
    
    local startTime = os.clock()

    local tped = false 

    runConnection = RunService.Heartbeat:Connect(function()

        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and localChar and localChar:FindFirstChild("HumanoidRootPart") then
        
        
            localChar.HumanoidRootPart.Position = targetChar.HumanoidRootPart.Position
        end
    end)
    hiddenfling=true
    loopTp=true
    task.spawn(fling)
end

local function STOP()
    spawnConnection:Disconnect()
    runConnection:Disconnect()
    localConnection:Disconnect()
end

local UI = Instance.new("ScreenGui")
UI.ResetOnSpawn = false
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.DisplayOrder=999999999999999
UI.Name = "UI"

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(85, 0, 163)
Frame.BorderColor = BrickColor.new("Really black")
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0.45, 0, 0.24, 0)

local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.DragUDim2 = UDim2.new(0, 59, 0, 19)
UIDragDetector.Enabled = true

local UICorner = Instance.new("UICorner")
UICorner.BottomLeftRadius = UDim.new(0.1, 0)
UICorner.BottomRightRadius = UDim.new(0.1, 0)
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.TopLeftRadius = UDim.new(0.1, 0)
UICorner.TopRightRadius = UDim.new(0.1, 0)

local TextLabel = Instance.new("TextLabel")
TextLabel.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel.Text = "Target Fling"
TextLabel.TextColor = BrickColor.new("Institutional white")
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor = BrickColor.new("Really black")
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.07, 0, 0.03, 0)
TextLabel.Size = UDim2.new(0.87, 0, 0.16, 0)
TextLabel.Transparency = 1
TextLabel.ZIndex = 2
TextLabel.TextTransparency=0

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.AspectRatio = 2.44

local ToggleButton = Instance.new("Frame")
ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(119, 41, 204)
ToggleButton.BorderColor = BrickColor.new("Really black")
ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.5, 0, 0.83, 0)
ToggleButton.Size = UDim2.new(0.52, 0, 0.24, 0)
ToggleButton.ZIndex = 2
ToggleButton.Name = "ToggleButton"

local hitbox = Instance.new("TextButton")
hitbox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox.Text = ""
hitbox.TextColor = BrickColor.new("Really black")
hitbox.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox.TextScaled = true
hitbox.TextSize = 14
hitbox.TextWrapped = true
hitbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox.BackgroundTransparency = 1
hitbox.BorderColor = BrickColor.new("Really black")
hitbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox.BorderSizePixel = 0
hitbox.Size = UDim2.new(1, 0, 1, 0)
hitbox.Transparency = 1
hitbox.Name = "hitbox"

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.MaxTextSize = 14

local Pattern = Instance.new("ImageLabel")
Pattern.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern.ImageTransparency = 0.6
Pattern.ScaleType = Enum.ScaleType.Tile
Pattern.TileSize = UDim2.new(0, 25, 0, 25)
Pattern.BackgroundTransparency = 1
Pattern.Size = UDim2.new(1, 0, 1, 0)
Pattern.Transparency = 1
Pattern.Name = "Pattern"

local UICorner_2 = Instance.new("UICorner")
UICorner_2.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_2.BottomRightRadius = UDim.new(0.3, 0)
UICorner_2.CornerRadius = UDim.new(0.3, 0)
UICorner_2.TopLeftRadius = UDim.new(0.3, 0)
UICorner_2.TopRightRadius = UDim.new(0.3, 0)

local UICorner_3 = Instance.new("UICorner")
UICorner_3.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_3.BottomRightRadius = UDim.new(0.3, 0)
UICorner_3.CornerRadius = UDim.new(0.3, 0)
UICorner_3.TopLeftRadius = UDim.new(0.3, 0)
UICorner_3.TopRightRadius = UDim.new(0.3, 0)

local onoff = Instance.new("TextLabel")
onoff.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
onoff.Text = "Off"
onoff.TextColor = BrickColor.new("Institutional white")
onoff.TextColor3 = Color3.fromRGB(255, 255, 255)
onoff.TextScaled = true
onoff.TextSize = 14
onoff.TextWrapped = true
onoff.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
onoff.BackgroundTransparency = 1
onoff.BorderColor = BrickColor.new("Really black")
onoff.BorderColor3 = Color3.fromRGB(0, 0, 0)
onoff.BorderSizePixel = 0
onoff.Position = UDim2.new(1.2, 0, 0.58, 0)
onoff.Size = UDim2.new(0.23, 0, 0.41, 0)
onoff.Transparency = 1
onoff.Name = "onoff"
onoff.TextTransparency=0

local UIStroke_2 = Instance.new("UIStroke")
UIStroke_2.Thickness = 3

local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_2.Text = "Toggle"
TextLabel_2.TextColor = BrickColor.new("Institutional white")
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14
TextLabel_2.TextWrapped = true
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.BorderColor = BrickColor.new("Really black")
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.3, 0, 0.22, 0)
TextLabel_2.Size = UDim2.new(0.4, 0, 0.53, 0)
TextLabel_2.Transparency = 1
TextLabel_2.TextTransparency=0

local UIStroke_3 = Instance.new("UIStroke")
UIStroke_3.Thickness = 3

local Player = Instance.new("Frame")
Player.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Player.BorderColor = BrickColor.new("Really black")
Player.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player.BorderSizePixel = 0
Player.Position = UDim2.new(0.12, 0, 0.33, 0)
Player.Size = UDim2.new(0.77, 0, 0.27, 0)
Player.ZIndex = 2
Player.Name = "Player"

local UICorner_4 = Instance.new("UICorner")
UICorner_4.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_4.BottomRightRadius = UDim.new(0.3, 0)
UICorner_4.CornerRadius = UDim.new(0.3, 0)
UICorner_4.TopLeftRadius = UDim.new(0.3, 0)
UICorner_4.TopRightRadius = UDim.new(0.3, 0)

local Pattern_2 = Instance.new("ImageLabel")
Pattern_2.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_2.ImageTransparency = 0.6
Pattern_2.ScaleType = Enum.ScaleType.Tile
Pattern_2.TileSize = UDim2.new(0, 25, 0, 25)
Pattern_2.BackgroundTransparency = 1
Pattern_2.Size = UDim2.new(1, 0, 1, 0)
Pattern_2.Transparency = 1
Pattern_2.Name = "Pattern"

local UICorner_5 = Instance.new("UICorner")
UICorner_5.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_5.BottomRightRadius = UDim.new(0.3, 0)
UICorner_5.CornerRadius = UDim.new(0.3, 0)
UICorner_5.TopLeftRadius = UDim.new(0.3, 0)
UICorner_5.TopRightRadius = UDim.new(0.3, 0)

local TextLabel_3 = Instance.new("TextLabel")
TextLabel_3.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_3.Text = "Click To Select"
TextLabel_3.TextColor = BrickColor.new("Institutional white")
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14
TextLabel_3.TextWrapped = true
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.BorderColor = BrickColor.new("Really black")
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.16, 0, 0.22, 0)
TextLabel_3.Size = UDim2.new(0.67, 0, 0.53, 0)
TextLabel_3.Transparency = 1
TextLabel_3.ZIndex = 2
TextLabel_3.TextTransparency=0

local UIStroke_4 = Instance.new("UIStroke")
UIStroke_4.Thickness = 3

local hitbox_2 = Instance.new("TextButton")
hitbox_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox_2.Text = ""
hitbox_2.TextColor = BrickColor.new("Really black")
hitbox_2.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox_2.TextScaled = true
hitbox_2.TextSize = 14
hitbox_2.TextWrapped = true
hitbox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox_2.BackgroundTransparency = 1
hitbox_2.BorderColor = BrickColor.new("Really black")
hitbox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox_2.BorderSizePixel = 0
hitbox_2.Size = UDim2.new(1, 0, 1, 0)
hitbox_2.Transparency = 1
hitbox_2.Name = "hitbox"

local Pattern_3 = Instance.new("ImageLabel")
Pattern_3.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_3.ImageTransparency = 0.8
Pattern_3.ScaleType = Enum.ScaleType.Tile
Pattern_3.TileSize = UDim2.new(0, 45, 0, 45)
Pattern_3.BackgroundTransparency = 1
Pattern_3.Size = UDim2.new(1, 0, 1, 0)
Pattern_3.Transparency = 1
Pattern_3.Name = "Pattern"

local UICorner_6 = Instance.new("UICorner")
UICorner_6.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_6.BottomRightRadius = UDim.new(0.1, 0)
UICorner_6.CornerRadius = UDim.new(0.1, 0)
UICorner_6.TopLeftRadius = UDim.new(0.1, 0)
UICorner_6.TopRightRadius = UDim.new(0.1, 0)

local PlayerSelection = Instance.new("Frame")
PlayerSelection.BackgroundColor3 = Color3.fromRGB(85, 0, 163)
PlayerSelection.BorderColor = BrickColor.new("Really black")
PlayerSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerSelection.BorderSizePixel = 0
PlayerSelection.Position = UDim2.new(1.02, 0, -0.25, 0)
PlayerSelection.Size = UDim2.new(0.547, 0,1.491, 0)
PlayerSelection.Visible = false
PlayerSelection.ZIndex = 2
PlayerSelection.Name = "PlayerSelection"

local UICorner_7 = Instance.new("UICorner")
UICorner_7.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_7.BottomRightRadius = UDim.new(0.1, 0)
UICorner_7.CornerRadius = UDim.new(0.1, 0)
UICorner_7.TopLeftRadius = UDim.new(0.1, 0)
UICorner_7.TopRightRadius = UDim.new(0.1, 0)

local Pattern_4 = Instance.new("ImageLabel")
Pattern_4.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_4.ImageTransparency = 0.8
Pattern_4.ScaleType = Enum.ScaleType.Tile
Pattern_4.TileSize = UDim2.new(0, 45, 0, 45)
Pattern_4.BackgroundTransparency = 1
Pattern_4.Size = UDim2.new(1, 0, 1, 0)
Pattern_4.Transparency = 1
Pattern_4.Name = "Pattern"

local UICorner_8 = Instance.new("UICorner")
UICorner_8.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_8.BottomRightRadius = UDim.new(0.1, 0)
UICorner_8.CornerRadius = UDim.new(0.1, 0)
UICorner_8.TopLeftRadius = UDim.new(0.1, 0)
UICorner_8.TopRightRadius = UDim.new(0.1, 0)

local Close = Instance.new("Frame")
Close.AnchorPoint = Vector2.new(0.5, 0.5)
Close.BackgroundColor3 = Color3.fromRGB(119, 41, 204)
Close.BorderColor = BrickColor.new("Really black")
Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.5, 0, 0.08, 0)
Close.Size = UDim2.new(0.37, 0, 0.11, 0)
Close.ZIndex = 2
Close.Name = "Close"

local hitbox_3 = Instance.new("TextButton")
hitbox_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox_3.Text = ""
hitbox_3.TextColor = BrickColor.new("Really black")
hitbox_3.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox_3.TextSize = 14
hitbox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox_3.BackgroundTransparency = 1
hitbox_3.BorderColor = BrickColor.new("Really black")
hitbox_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox_3.BorderSizePixel = 0
hitbox_3.Size = UDim2.new(1, 0, 1, 0)
hitbox_3.Transparency = 1
hitbox_3.Name = "hitbox"

local UICorner_9 = Instance.new("UICorner")
UICorner_9.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_9.BottomRightRadius = UDim.new(0.3, 0)
UICorner_9.CornerRadius = UDim.new(0.3, 0)
UICorner_9.TopLeftRadius = UDim.new(0.3, 0)
UICorner_9.TopRightRadius = UDim.new(0.3, 0)

local TextLabel_4 = Instance.new("TextLabel")
TextLabel_4.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_4.Text = "Close"
TextLabel_4.TextColor = BrickColor.new("Institutional white")
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14
TextLabel_4.TextWrapped = true
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.BorderColor = BrickColor.new("Really black")
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.3, 0, 0.22, 0)
TextLabel_4.Size = UDim2.new(0.4, 0, 0.53, 0)
TextLabel_4.Transparency = 1
TextLabel_4.TextTransparency=0

local UIStroke_5 = Instance.new("UIStroke")
UIStroke_5.Thickness = 3

local Pattern_5 = Instance.new("ImageLabel")
Pattern_5.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_5.ImageTransparency = 0.6
Pattern_5.ScaleType = Enum.ScaleType.Tile
Pattern_5.TileSize = UDim2.new(0, 25, 0, 25)
Pattern_5.BackgroundTransparency = 1
Pattern_5.Size = UDim2.new(1, 0, 1, 0)
Pattern_5.Transparency = 1
Pattern_5.Name = "Pattern"

local UICorner_10 = Instance.new("UICorner")
UICorner_10.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_10.BottomRightRadius = UDim.new(0.3, 0)
UICorner_10.CornerRadius = UDim.new(0.3, 0)
UICorner_10.TopLeftRadius = UDim.new(0.3, 0)
UICorner_10.TopRightRadius = UDim.new(0.3, 0)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 22, 0)
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.Active = true
ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderColor = BrickColor.new("Really black")
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.53, 0, 0.55, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.77, 0)
ScrollingFrame.Transparency = 1

local templat = Instance.new("Frame")
templat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
templat.BorderColor = BrickColor.new("Really black")
templat.BorderColor3 = Color3.fromRGB(0, 0, 0)
templat.BorderSizePixel = 0
templat.Size = UDim2.new(0.93, 0, 0.2, 0)
templat.Visible = false
templat.ZIndex = 2
templat.Name = "templat"

local UICorner_11 = Instance.new("UICorner")
UICorner_11.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_11.BottomRightRadius = UDim.new(0.3, 0)
UICorner_11.CornerRadius = UDim.new(0.3, 0)
UICorner_11.TopLeftRadius = UDim.new(0.3, 0)
UICorner_11.TopRightRadius = UDim.new(0.3, 0)

local Pattern_6 = Instance.new("ImageLabel")
Pattern_6.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_6.ImageTransparency = 0.6
Pattern_6.ScaleType = Enum.ScaleType.Tile
Pattern_6.TileSize = UDim2.new(0, 25, 0, 25)
Pattern_6.BackgroundTransparency = 1
Pattern_6.Size = UDim2.new(1, 0, 1, 0)
Pattern_6.Transparency = 1
Pattern_6.Name = "Pattern"

local UICorner_12 = Instance.new("UICorner")
UICorner_12.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_12.BottomRightRadius = UDim.new(0.3, 0)
UICorner_12.CornerRadius = UDim.new(0.3, 0)
UICorner_12.TopLeftRadius = UDim.new(0.3, 0)
UICorner_12.TopRightRadius = UDim.new(0.3, 0)

local TextLabel_5 = Instance.new("TextLabel")
TextLabel_5.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_5.Text = "TwentyOneCharacters"
TextLabel_5.TextColor = BrickColor.new("Institutional white")
TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14
TextLabel_5.TextWrapped = true
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 1
TextLabel_5.BorderColor = BrickColor.new("Really black")
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.06, 0, 0.22, 0)
TextLabel_5.Size = UDim2.new(0.89, 0, 0.53, 0)
TextLabel_5.Transparency = 1
TextLabel_5.ZIndex = 2
TextLabel_5.TextTransparency=0

local UIStroke_6 = Instance.new("UIStroke")
UIStroke_6.Thickness = 3

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05, 0)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

UI.Parent = lp.PlayerGui
Frame.Parent = UI
UIDragDetector.Parent = Frame
UICorner.Parent = Frame
TextLabel.Parent = Frame
UIStroke.Parent = TextLabel
UIAspectRatioConstraint.Parent = Frame
ToggleButton.Parent = Frame
hitbox.Parent = ToggleButton
UITextSizeConstraint.Parent = hitbox
Pattern.Parent = ToggleButton
UICorner_2.Parent = Pattern
UICorner_3.Parent = ToggleButton
onoff.Parent = ToggleButton
UIStroke_2.Parent = onoff
TextLabel_2.Parent = ToggleButton
UIStroke_3.Parent = TextLabel_2
Player.Parent = Frame
UICorner_4.Parent = Player
Pattern_2.Parent = Player
UICorner_5.Parent = Pattern_2
TextLabel_3.Parent = Player
UIStroke_4.Parent = TextLabel_3
hitbox_2.Parent = Player
Pattern_3.Parent = Frame
UICorner_6.Parent = Pattern_3
PlayerSelection.Parent = Frame
UICorner_7.Parent = PlayerSelection
Pattern_4.Parent = PlayerSelection
UICorner_8.Parent = Pattern_4
Close.Parent = PlayerSelection
hitbox_3.Parent = Close
UICorner_9.Parent = Close
TextLabel_4.Parent = Close
UIStroke_5.Parent = TextLabel_4
Pattern_5.Parent = Close
UICorner_10.Parent = Pattern_5
ScrollingFrame.Parent = PlayerSelection
templat.Parent = ScrollingFrame
UICorner_11.Parent = templat
Pattern_6.Parent = templat
UICorner_12.Parent = Pattern_6
TextLabel_5.Parent = templat
UIStroke_6.Parent = TextLabel_5
UIListLayout.Parent = ScrollingFrame

ToggleButton.hitbox.MouseButton1Click:Connect(function ()
    if loopTp then
        loopTp=false
        hiddenfling=false
        STOP()
    else
        loopTp=true
        if tpPerson~="" then
            spamTP()
        end
    end
end)

Close.hitbox.MouseButton1Click:Connect(function ()
    PlayerSelection.Visible=false
end)

Player.hitbox.MouseButton1Click:Connect(function ()
    if loopTp then
        return 
    end
    PlayerSelection.Visible=true
end)

local frame=Frame

frame.Active = true

local playerStuff={}

local function clearOldUI()
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child ~= templat and not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
    playerStuff = {}
end

local function createTemp(plr)
    if not templat or plr == lp then return end
    if playerStuff[plr] then return end 

    local t = templat:Clone()
    t.Name = "Entry_" .. plr.UserId
    
    local textLabel = t:FindFirstChild("TextLabel")
    if textLabel then textLabel.Text = plr.Name end

    local hitbox = Instance.new("TextButton")
    hitbox.Name = "hitbox"
    hitbox.Text = ""
    hitbox.BackgroundTransparency = 1
    hitbox.Size = UDim2.new(1, 0, 1, 0)
    hitbox.Parent = t

    hitbox.MouseButton1Click:Connect(function()
        tpPerson = plr.Name
        PlayerSelection.Visible = false
        if Player:FindFirstChild("TextLabel") then
            Player.TextLabel.Text = plr.Name
        end
    end)

    playerStuff[plr] = t
    t.Parent = ScrollingFrame
    t.Visible = true
end


clearOldUI()
for _, plr in ipairs(Players:GetPlayers()) do
    createTemp(plr)
end

Players.PlayerAdded:Connect(createTemp)

Players.PlayerRemoved:Connect(function(plr)
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child.Name == "Entry_" .. plr.UserId then
            child:Destroy()
        end
    end
end)
