

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
local option=1

local Players=Services.Players
local RunService=Services.RunService
local TweenService=Services.TweenService
local lp = Players.LocalPlayer
local hiddenfling=false

local SkidFling = function(TargetPlayer)
    local Character = lp.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        workspace.FallenPartsDestroyHeight = 0/0

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        end
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    end
end

local function spamFling(plr)
    while loopTp==true do
        SkidFling(plr)
        RunService.Stepped:Wait()
    end
end

local function fling()
	local c, hrp, vel, movel = nil, nil, nil, 0.1
	
	while hiddenfling do
		RunService.Heartbeat:Wait()
		c = lp.Character
		hrp = c and c:FindFirstChild("HumanoidRootPart")
	
		if hrp then
			vel = hrp.Velocity
			hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
			RunService.RenderStepped:Wait()
			hrp.Velocity = vel
			RunService.Stepped:Wait()
			hrp.Velocity = vel + Vector3.new(0, movel, 0)
			movel = -movel
		end
	end
end

local spawnConnection
local runConnection
local localConnection

local function spamTP()
    local settings = {
        Distance = 5,   
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
        
            local oscillation = math.sin((os.clock() - startTime) * (math.pi / settings.Speed))
            local offset = oscillation * settings.Distance
            localChar.HumanoidRootPart.CFrame=targetChar.HumanoidRootPart.CFrame*CFrame.new(0, 0, offset)
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
UI.DisplayOrder = 2147483647
UI.ResetOnSpawn = false
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.Name = "UI"

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(85, 0, 163)
Frame.BorderColor = BrickColor.new("Really black")
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0.45, 0, 0.32, 0)

local UIDragDetector = Instance.new("UIDragDetector")

local UICorner = Instance.new("UICorner")
UICorner.BottomLeftRadius = UDim.new(0.1, 0)
UICorner.BottomRightRadius = UDim.new(0.1, 0)
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.TopLeftRadius = UDim.new(0.1, 0)
UICorner.TopRightRadius = UDim.new(0.1, 0)

local TextLabel = Instance.new("TextLabel")
TextLabel.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel.Text = "Target Fling"
--TextLabel.TextColor = BrickColor.new("Institutional white")
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

local ToggleButton = Instance.new("Frame")
ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(119, 41, 204)
ToggleButton.BorderColor = BrickColor.new("Really black")
ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.5, 0, 0.85, 0)
ToggleButton.Size = UDim2.new(0.52, 0, 0.2, 0)
ToggleButton.ZIndex = 2
ToggleButton.Name = "ToggleButton"

local hitbox = Instance.new("TextButton")
hitbox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox.Text = ""
hitbox.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox.TextScaled = true
hitbox.TextSize = 14
hitbox.TextTransparency = 1
hitbox.TextWrapped = true
hitbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox.BackgroundTransparency = 1
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
--onoff.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
onoff.BackgroundTransparency = 1
--onoff.BorderColor = BrickColor.new("Really black")
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
TextLabel_2.TextTransparency = 0

local UIStroke_3 = Instance.new("UIStroke")
UIStroke_3.Thickness = 3

local Player = Instance.new("Frame")
Player.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Player.BorderColor = BrickColor.new("Really black")
Player.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player.BorderSizePixel = 0
Player.Position = UDim2.new(0.12, 0, 0.24, 0)
Player.Size = UDim2.new(0.77, 0, 0.22, 0)
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
Pattern_2.Position = UDim2.new(0, 0, 0, 0)
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
--TextLabel_3.TextColor = BrickColor.new("Institutional white")
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14
TextLabel_3.TextWrapped = true
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1
--TextLabel_3.BorderColor = BrickColor.new("Really black")
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.16, 0, 0.22, 0)
TextLabel_3.Size = UDim2.new(0.67, 0, 0.53, 0)
TextLabel_3.Transparency = 1
TextLabel_3.ZIndex = 2
TextLabel_3.TextTransparency = 0

local UIStroke_4 = Instance.new("UIStroke")
UIStroke_4.Thickness = 3

local hitbox_2 = Instance.new("TextButton")
hitbox_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox_2.Text = ""
hitbox_2.TextColor = BrickColor.new("Really black")
hitbox_2.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox_2.TextScaled = true
hitbox_2.TextSize = 14
hitbox_2.TextTransparency = 1
hitbox_2.TextWrapped = true
hitbox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox_2.BackgroundTransparency = 1
hitbox_2.BorderColor = BrickColor.new("Really black")
hitbox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox_2.BorderSizePixel = 0
hitbox_2.Size = UDim2.new(1, 0, 1, 0)
hitbox_2.Transparency = 1
hitbox_2.Name = "hitbox"

local PlayerSelection = Instance.new("Frame")
PlayerSelection.BackgroundColor3 = Color3.fromRGB(85, 0, 163)
PlayerSelection.BorderColor = BrickColor.new("Really black")
PlayerSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerSelection.BorderSizePixel = 0
PlayerSelection.Position = UDim2.new(1.02, 0, -0.25, 0)
PlayerSelection.Size = UDim2.new(0.55, 0, 1.49, 0)
PlayerSelection.Visible = false
PlayerSelection.ZIndex = 2
PlayerSelection.Name = "PlayerSelection"

local UICorner_6 = Instance.new("UICorner")
UICorner_6.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_6.BottomRightRadius = UDim.new(0.1, 0)
UICorner_6.CornerRadius = UDim.new(0.1, 0)
UICorner_6.TopLeftRadius = UDim.new(0.1, 0)
UICorner_6.TopRightRadius = UDim.new(0.1, 0)

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

local UICorner_7 = Instance.new("UICorner")
UICorner_7.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_7.BottomRightRadius = UDim.new(0.1, 0)
UICorner_7.CornerRadius = UDim.new(0.1, 0)
UICorner_7.TopLeftRadius = UDim.new(0.1, 0)
UICorner_7.TopRightRadius = UDim.new(0.1, 0)

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
hitbox_3.TextTransparency = 1
hitbox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox_3.BackgroundTransparency = 1
hitbox_3.BorderColor = BrickColor.new("Really black")
hitbox_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox_3.BorderSizePixel = 0
hitbox_3.Size = UDim2.new(1, 0, 1, 0)
hitbox_3.Transparency = 1
hitbox_3.Name = "hitbox"

local UICorner_8 = Instance.new("UICorner")
UICorner_8.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_8.BottomRightRadius = UDim.new(0.3, 0)
UICorner_8.CornerRadius = UDim.new(0.3, 0)
UICorner_8.TopLeftRadius = UDim.new(0.3, 0)
UICorner_8.TopRightRadius = UDim.new(0.3, 0)

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
TextLabel_4.TextTransparency = 0

local UIStroke_5 = Instance.new("UIStroke")
UIStroke_5.Thickness = 3

local Pattern_4 = Instance.new("ImageLabel")
Pattern_4.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_4.ImageTransparency = 0.6
Pattern_4.ScaleType = Enum.ScaleType.Tile
Pattern_4.TileSize = UDim2.new(0, 25, 0, 25)
Pattern_4.BackgroundTransparency = 1
Pattern_4.Size = UDim2.new(1, 0, 1, 0)
Pattern_4.Transparency = 1
Pattern_4.Name = "Pattern"

local UICorner_9 = Instance.new("UICorner")
UICorner_9.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_9.BottomRightRadius = UDim.new(0.3, 0)
UICorner_9.CornerRadius = UDim.new(0.3, 0)
UICorner_9.TopLeftRadius = UDim.new(0.3, 0)
UICorner_9.TopRightRadius = UDim.new(0.3, 0)

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

local UICorner_10 = Instance.new("UICorner")
UICorner_10.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_10.BottomRightRadius = UDim.new(0.3, 0)
UICorner_10.CornerRadius = UDim.new(0.3, 0)
UICorner_10.TopLeftRadius = UDim.new(0.3, 0)
UICorner_10.TopRightRadius = UDim.new(0.3, 0)

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

local UICorner_11 = Instance.new("UICorner")
UICorner_11.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_11.BottomRightRadius = UDim.new(0.3, 0)
UICorner_11.CornerRadius = UDim.new(0.3, 0)
UICorner_11.TopLeftRadius = UDim.new(0.3, 0)
UICorner_11.TopRightRadius = UDim.new(0.3, 0)

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
TextLabel_5.TextTransparency = 0

local UIStroke_6 = Instance.new("UIStroke")
UIStroke_6.Thickness = 3

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05, 0)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local bg = Instance.new("CanvasGroup")
bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bg.BackgroundTransparency = 1
bg.BorderColor = BrickColor.new("Really black")
bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
bg.BorderSizePixel = 0
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Transparency = 1
bg.Name = "bg"

local Pattern_6 = Instance.new("ImageLabel")
Pattern_6.Image = "rbxassetid://121480522"
--[[ Unsupported Type: Content For : ImageContent ]]
Pattern_6.ImageTransparency = 0.8
Pattern_6.ScaleType = Enum.ScaleType.Tile
Pattern_6.TileSize = UDim2.new(0, 52, 0, 52)
Pattern_6.BackgroundTransparency = 1
Pattern_6.Position = UDim2.new(0, -52, 0, -52)
Pattern_6.Size = UDim2.new(1, 52, 1, 52)
Pattern_6.Transparency = 1
Pattern_6.Name = "Pattern"

local UICorner_12 = Instance.new("UICorner")
UICorner_12.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_12.BottomRightRadius = UDim.new(0.1, 0)
UICorner_12.CornerRadius = UDim.new(0.1, 0)
UICorner_12.TopLeftRadius = UDim.new(0.1, 0)
UICorner_12.TopRightRadius = UDim.new(0.1, 0)

local UICorner_13 = Instance.new("UICorner")
UICorner_13.BottomLeftRadius = UDim.new(0.1, 0)
UICorner_13.BottomRightRadius = UDim.new(0.1, 0)
UICorner_13.CornerRadius = UDim.new(0.1, 0)
UICorner_13.TopLeftRadius = UDim.new(0.1, 0)
UICorner_13.TopRightRadius = UDim.new(0.1, 0)

local SelectFling = Instance.new("CanvasGroup")
SelectFling.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SelectFling.BackgroundTransparency = 0.8
SelectFling.BorderColor = BrickColor.new("Really black")
SelectFling.BorderColor3 = Color3.fromRGB(0, 0, 0)
SelectFling.BorderSizePixel = 0
SelectFling.Position = UDim2.new(0.13, 0, 0.49, 0)
SelectFling.Size = UDim2.new(0.74, 0, 0.18, 0)
SelectFling.Transparency = 0.8
SelectFling.Name = "SelectFling"

local UICorner_14 = Instance.new("UICorner")
UICorner_14.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_14.BottomRightRadius = UDim.new(0.3, 0)
UICorner_14.CornerRadius = UDim.new(0.3, 0)
UICorner_14.TopLeftRadius = UDim.new(0.3, 0)
UICorner_14.TopRightRadius = UDim.new(0.3, 0)

local SkidFling = Instance.new("Frame")
SkidFling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SkidFling.BackgroundTransparency = 1
SkidFling.BorderColor = BrickColor.new("Really black")
SkidFling.BorderColor3 = Color3.fromRGB(0, 0, 0)
SkidFling.BorderSizePixel = 0
SkidFling.Position = UDim2.new(0.5, 0, 0, 0)
SkidFling.Size = UDim2.new(0.5, 0, 1, 0)
SkidFling.Transparency = 1
SkidFling.ZIndex = 3
SkidFling.Name = "SkidFling"

local hitbox_4 = Instance.new("TextButton")
hitbox_4.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox_4.Text = ""
hitbox_4.TextColor = BrickColor.new("Really black")
hitbox_4.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox_4.TextScaled = true
hitbox_4.TextSize = 14
hitbox_4.TextTransparency = 1
hitbox_4.TextWrapped = true
hitbox_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox_4.BackgroundTransparency = 1
hitbox_4.BorderColor = BrickColor.new("Really black")
hitbox_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox_4.BorderSizePixel = 0
hitbox_4.Size = UDim2.new(1, 0, 1, 0)
hitbox_4.Transparency = 1
hitbox_4.Name = "hitbox"

local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
UITextSizeConstraint_2.MaxTextSize = 14

local TextLabel_6 = Instance.new("TextLabel")
TextLabel_6.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_6.Text = "Skid Fling"
TextLabel_6.TextColor = BrickColor.new("Institutional white")
TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 14
TextLabel_6.TextWrapped = true
TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.BackgroundTransparency = 1
TextLabel_6.BorderColor = BrickColor.new("Really black")
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.BorderSizePixel = 0
TextLabel_6.Position = UDim2.new(0.16, 0, 0.22, 0)
TextLabel_6.Size = UDim2.new(0.67, 0, 0.53, 0)
TextLabel_6.Transparency = 1
TextLabel_6.ZIndex = 2
TextLabel_6.TextTransparency = 0

local UIStroke_7 = Instance.new("UIStroke")
UIStroke_7.Thickness = 3

local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
UITextSizeConstraint_3.MaxTextSize = 22

local TouchFling = Instance.new("Frame")
TouchFling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TouchFling.BackgroundTransparency = 1
TouchFling.BorderColor = BrickColor.new("Really black")
TouchFling.BorderColor3 = Color3.fromRGB(0, 0, 0)
TouchFling.BorderSizePixel = 0
TouchFling.Size = UDim2.new(0.5, 0, 1, 0)
TouchFling.Transparency = 1
TouchFling.ZIndex = 3
TouchFling.Name = "TouchFling"

local hitbox_5 = Instance.new("TextButton")
hitbox_5.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
hitbox_5.Text = ""
hitbox_5.TextColor = BrickColor.new("Really black")
hitbox_5.TextColor3 = Color3.fromRGB(0, 0, 0)
hitbox_5.TextScaled = true
hitbox_5.TextSize = 14
hitbox_5.TextTransparency = 1
hitbox_5.TextWrapped = true
hitbox_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitbox_5.BackgroundTransparency = 1
hitbox_5.BorderColor = BrickColor.new("Really black")
hitbox_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
hitbox_5.BorderSizePixel = 0
hitbox_5.Size = UDim2.new(1, 0, 1, 0)
hitbox_5.Transparency = 1
hitbox_5.Name = "hitbox"

local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
UITextSizeConstraint_4.MaxTextSize = 14

local TextLabel_7 = Instance.new("TextLabel")
TextLabel_7.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_7.Text = "Touch Fling"
TextLabel_7.TextColor = BrickColor.new("Institutional white")
TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.TextScaled = true
TextLabel_7.TextSize = 14
TextLabel_7.TextWrapped = true
TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.BackgroundTransparency = 1
TextLabel_7.BorderColor = BrickColor.new("Really black")
TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_7.BorderSizePixel = 0
TextLabel_7.Position = UDim2.new(0.16, 0, 0.22, 0)
TextLabel_7.Size = UDim2.new(0.67, 0, 0.53, 0)
TextLabel_7.Transparency = 1
TextLabel_7.ZIndex = 2
TextLabel_7.TextTransparency = 0

local UIStroke_8 = Instance.new("UIStroke")
UIStroke_8.Thickness = 3

local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
UITextSizeConstraint_5.MaxTextSize = 22

local Selector = Instance.new("Frame")
Selector.BackgroundColor3 = Color3.fromRGB(69, 82, 255)
Selector.BorderColor = BrickColor.new("Really black")
Selector.BorderColor3 = Color3.fromRGB(0, 0, 0)
Selector.BorderSizePixel = 0
Selector.Size = UDim2.new(0.5, 0, 1, 0)
Selector.Name = "Selector"

local UICorner_15 = Instance.new("UICorner")
UICorner_15.BottomLeftRadius = UDim.new(0.3, 0)
UICorner_15.BottomRightRadius = UDim.new(0.3, 0)
UICorner_15.CornerRadius = UDim.new(0.3, 0)
UICorner_15.TopLeftRadius = UDim.new(0.3, 0)
UICorner_15.TopRightRadius = UDim.new(0.3, 0)

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.AspectRatio = 1.54
UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

UI.Parent = lp.PlayerGui
UI.Enabled=true
Frame.Visible=true
Frame.Parent = UI
UIDragDetector.Parent = Frame
UICorner.Parent = Frame
TextLabel.Parent = Frame
UIStroke.Parent = TextLabel
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
PlayerSelection.Parent = Frame
UICorner_6.Parent = PlayerSelection
Pattern_3.Parent = PlayerSelection
UICorner_7.Parent = Pattern_3
Close.Parent = PlayerSelection
hitbox_3.Parent = Close
UICorner_8.Parent = Close
TextLabel_4.Parent = Close
UIStroke_5.Parent = TextLabel_4
Pattern_4.Parent = Close
UICorner_9.Parent = Pattern_4
ScrollingFrame.Parent = PlayerSelection
templat.Parent = ScrollingFrame
UICorner_10.Parent = templat
Pattern_5.Parent = templat
UICorner_11.Parent = Pattern_5
TextLabel_5.Parent = templat
UIStroke_6.Parent = TextLabel_5
UIListLayout.Parent = ScrollingFrame
bg.Parent = Frame
Pattern_6.Parent = bg
UICorner_12.Parent = Pattern_6
UICorner_13.Parent = bg
SelectFling.Parent = Frame
UICorner_14.Parent = SelectFling
SkidFling.Parent = SelectFling
hitbox_4.Parent = SkidFling
UITextSizeConstraint_2.Parent = hitbox_4
TextLabel_6.Parent = SkidFling
UIStroke_7.Parent = TextLabel_6
UITextSizeConstraint_3.Parent = TextLabel_6
TouchFling.Parent = SelectFling
hitbox_5.Parent = TouchFling
UITextSizeConstraint_4.Parent = hitbox_5
TextLabel_7.Parent = TouchFling
UIStroke_8.Parent = TextLabel_7
UITextSizeConstraint_5.Parent = TextLabel_7
Selector.Parent = SelectFling
UICorner_15.Parent = Selector
UIAspectRatioConstraint.Parent = UI


ToggleButton.hitbox.MouseButton1Click:Connect(function ()
    if loopTp then
        loopTp=false
        hiddenfling=false
        STOP()
        onoff.Text="Off"
    else
        if tpPerson~="" then
            loopTp=true
            spamTP()
            onoff.Text="On"
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

local d1=false

TouchFling.hitbox.MouseButton1Click:Connect(function ()
    if tpPerson or option==1 then return end
    if d1 then return end
    d1=true
    task.spawn(function ()
        task.wait(0.42)
        d1=false
    end)
    option=1
    TweenService:Create(Selector,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0)}):Play()
    wait(0.2)
    TweenService:Create(Selector,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {Position=UDim2.new(0,0,0,0),Size=UDim2.new(0.5,0,1,0)}):Play()
end)

SkidFling.hitbox.MouseButton1Click:Connect(function ()
    if tpPerson or option==2 then return end
    if d1 then return end
    d1=true
    task.spawn(function ()
        task.wait(0.42)
        d1=false
    end)
    option=2
    TweenService:Create(Selector,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0)}):Play()
    wait(0.2)
    TweenService:Create(Selector,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {Position=UDim2.new(0.5,0,0,0),Size=UDim2.new(0.5,0,1,0)}):Play()
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

Players.PlayerRemoving:Connect(function(plr)
    playerStuff[plr]:Destroy()
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child.Name == "Entry_" .. plr.UserId then
            child:Destroy() -- just in case :)
        end
    end
end)
