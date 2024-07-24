local CoreGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local function isNumber(str)
  if tonumber(str) ~= nil or str == 'inf' then
    return true
  end
end

getgenv().HitboxSize = 15
getgenv().HitboxTransparency = 0.9

getgenv().HitboxStatus = true
getgenv().TeamCheck = true

getgenv().Walkspeed = game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed
getgenv().Jumppower = game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower

getgenv().TPSpeed = 3
getgenv().TPWalk = false

--// UI

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/UI-Library/main/Source/MyUILib(Unamed).lua"))();
local Window = Library:Create(".攻击范围")

local ToggleGui = Instance.new("ScreenGui")
local Toggle = Instance.new("TextButton")

ToggleGui.Name = "ToggleGui_HE"
ToggleGui.Parent = game.CoreGui

Toggle.Name = "Toggle"
Toggle.Parent = ToggleGui
Toggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Toggle.BackgroundTransparency = 0.660
Toggle.Position = UDim2.new(0, 0, 0.454706937, 0)
Toggle.Size = UDim2.new(0.0650164187, 0, 0.0888099447, 0)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = "显示/隐藏"
Toggle.TextScaled = true
Toggle.TextColor3 = Color3.fromRGB(40, 40, 40)
Toggle.TextSize = 24.000
Toggle.TextXAlignment = Enum.TextXAlignment.Left
Toggle.Active = true
Toggle.Draggable = true
Toggle.MouseButton1Click:connect(function()
    Library:ToggleUI()
end)

local HomeTab = Window:Tab("主页","rbxassetid://10888331510")
local PlayerTab = Window:Tab("玩家","rbxassetid://12296135476")
local VisualTab = Window:Tab("显示","rbxassetid://12308581351")

HomeTab:InfoLabel("仅适用于某些游戏")

HomeTab:Section("数值")

HomeTab:TextBox("攻击范围大小", function(value)
    getgenv().HitboxSize = value
end)

HomeTab:TextBox("透明度", function(number)
    getgenv().HitboxTransparency = number
end)

HomeTab:Section("主要")

HomeTab:Toggle("状态: ", function(state)
	getgenv().HitboxStatus = state
    game:GetService('RunService').RenderStepped:connect(function()
		if HitboxStatus == true and TeamCheck == false then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						v.Character.HumanoidRootPart.Transparency = HitboxTransparency
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		elseif HitboxStatus == true and TeamCheck == true then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if game:GetService('Players').LocalPlayer.Team ~= v.Team then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						v.Character.HumanoidRootPart.Transparency = HitboxTransparency
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		else
		    for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
						v.Character.HumanoidRootPart.Transparency = 1
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
						v.Character.HumanoidRootPart.Material = "Plastic"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		end
	end)
end)

HomeTab:Toggle("Team Check", function(state)
    getgenv().TeamCheck = state
end)

HomeTab:Keybind("电脑显示/隐藏ui", Enum.KeyCode.F, function()
    Library:ToggleUI()
end)

PlayerTab:TextBox("行走速度", function(value)
    getgenv().Walkspeed = value
    pcall(function()
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = value
    end)
end)

PlayerTab:Toggle("循环行走速度", function(state)
    getgenv().loopW = state
    game:GetService("RunService").Heartbeat:Connect(function()
        if loopW == true then
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Walkspeed
            end)
        end
    end)
end)

PlayerTab:TextBox("跳跃力量", function(value)
    getgenv().Jumppower = value
    pcall(function()
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = value
    end)
end)

PlayerTab:Toggle("循环跳跃力量", function(state)
    getgenv().loopJ = state
    game:GetService("RunService").Heartbeat:Connect(function()
        if loopJ == true then
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Jumppower
            end)
        end
    end)
end)

PlayerTab:TextBox("TP移动", function(value)
getgenv().TPSpeed = value
end)

PlayerTab:Toggle("启用", function(s)
getgenv().TPWalk = s
local hb = game:GetService("RunService").Heartbeat
local player = game:GetService("Players")
local lplr = player.LocalPlayer
local chr = lplr.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
while getgenv().TPWalk and hb:Wait() and chr and hum and hum.Parent do
  if hum.MoveDirection.Magnitude > 0 then
    if getgenv().TPSpeed and isNumber(getgenv().TPSpeed) then
      chr:TranslateBy(hum.MoveDirection * tonumber(getgenv().TPSpeed))
    else
      chr:TranslateBy(hum.MoveDirection)
    end
  end
end
end)

PlayerTab:Slider("视野", game.Workspace.CurrentCamera.FieldOfView,240, function(v)
     game.Workspace.CurrentCamera.FieldOfView = v
end)

PlayerTab:Toggle("穿墙", function(s)
    getgenv().Noclip = s
    game:GetService("RunService").Heartbeat:Connect(function()
        if Noclip == true then
            game:GetService("RunService").Stepped:wait()
            game.Players.LocalPlayer.Character.Head.CanCollide = false
            game.Players.LocalPlayer.Character.Torso.CanCollide = false
        end
    end)
end)

PlayerTab:Toggle("无限跳跃", function(s)
getgenv().InfJ = s
    game:GetService("UserInputService").JumpRequest:connect(function()
        if InfJ == true then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
end)

PlayerTab:Button("重新加入", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

VisualTab:InfoLabel("等待2秒")

VisualTab:Toggle("内透", function(state)
getgenv().enabled = state --Toggle on/off
getgenv().filluseteamcolor = true --Toggle fill color using player team color on/off
getgenv().outlineuseteamcolor = true --Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(0, 0, 0) --Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(1, 1, 1) --Change outline color, no need to edit if using team color
getgenv().filltrans = 0.7 --Change fill transparency
getgenv().outlinetrans = 0 --Change outline transparency

loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
end)

VisualTab:Toggle("Name display", function(state)
local bb = Instance.new('BillboardGui', game.CoreGui)
  bb.Adornee = base
  bb.ExtentsOffset = Vector3.new(0,1,0)
  bb.AlwaysOnTop = true
  bb.Size = UDim2.new(0,5,0,5)
  bb.StudsOffset = Vector3.new(0,1,0)
  bb.Name = 'tracker'
  local frame = Instance.new('Frame',bb)
  frame.ZIndex = 10
  frame.BackgroundTransparency = 0.3
  frame.Size = UDim2.new(1,0,1,0)
  local txtlbl = Instance.new('TextLabel',bb)
  txtlbl.ZIndex = 10
  txtlbl.BackgroundTransparency = 1
  txtlbl.Position = UDim2.new(0,0,0,-35)
  txtlbl.Size = UDim2.new(1,0,10,0)
  txtlbl.Font = 'ArialBold'
  txtlbl.FontSize = 'Size12'
  txtlbl.Text = base.Parent.Name:upper()
  txtlbl.TextStrokeTransparency = 0.5
  if team then
      txtlbl.TextColor3 = Color3.new(0,1,1)
      frame.BackgroundColor3 = Color3.new(0,1,1)
  else
      txtlbl.TextColor3 = Color3.new(1,0,0)
      frame.BackgroundColor3 = Color3.new(1,0,0)
  end
end

function Clear()
  for _,v in pairs(game.CoreGui:children()) do
      if v.Name == 'tracker' and v:isA('BillboardGui') then
          v:Destroy()
      end
  end
end

function Find()
  Clear()
  track = true
  spawn(function()
      while wait(1) do
          if track then
              Clear()
              for _,v in pairs(game.Players:players()) do
                  if v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
                      if v.Character and v.Character.Head then
                          Create(v.Character.Head, false)
                      end
                  end
              end
          end
          wait(1)
      end
  end)
end


if game.PlaceId == 3082002798 then
    local GamesTab = Window:Tab("Games","rbxassetid://15426471035")
	GamesTab:InfoLabel("Game: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
	GamesTab:Button("No Cooldown", function()
	    for i, v in pairs(game:GetService('ReplicatedStorage')['Shared_Modules'].Tools:GetDescendants()) do
		    if v:IsA('ModuleScript') then
			    local Module = require(v)
				Module.DEBOUNCE = 0
			end
		end
	end)
end