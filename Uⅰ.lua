-- 美观带启动动画的Roblox UI脚本
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- 基础设置
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FancyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- 主面板（玻璃拟态风格）
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 180)
MainFrame.Position = UDim2.new(1, -290, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.85
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- 圆角+阴影+模糊
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIShadow = Instance.new("UIShadow")
UIShadow.Color = Color3.fromRGB(0, 0, 0)
UIShadow.Transparency = 0.7
UIShadow.Size = 10
UIShadow.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 245, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 230, 255))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "✨ 高级功能面板"
TitleLabel.TextColor3 = Color3.fromRGB(50, 80, 200)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Parent = TitleBar

-- 功能开关按钮
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.7, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.15, 0, 0, 55)
ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "开启功能"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.GothamMedium
ToggleButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = ToggleButton

local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 100, 240))
})
ButtonGradient.Parent = ToggleButton

-- 状态提示
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 105)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "状态：未激活"
StatusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- 版本信息
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 135)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v1.0 | 美观增强版"
VersionLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
VersionLabel.TextSize = 11
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextXAlignment = Enum.TextXAlignment.Center
VersionLabel.Parent = MainFrame

-- 启动动画（渐变+缩放）
MainFrame.Transparency = 1
MainFrame.Size = UDim2.new(0, 280, 0, 0)
local openTween = TweenService:Create(
    MainFrame,
    TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    { Transparency = 0.15, Size = UDim2.new(0, 280, 0, 180) }
)
openTween:Play()

-- 按钮hover动画
local function setupButtonHover(btn)
    local normalColor = btn.BackgroundColor3
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(120, 160, 255),
            Size = UDim2.new(0.75, 0, 0, 45)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = normalColor,
            Size = UDim2.new(0.7, 0, 0, 40)
        }):Play()
    end)
end
setupButtonHover(ToggleButton)

-- 功能逻辑（示例：无限跳+速度增强）
 local isEnabled = false
 local normalSpeed = 16
 local boostSpeed = 60
 local humanoid = Players.LocalPlayer.Character:WaitForChild("Humanoid")
 local jumpConnection = nil
 ToggleButton.MouseButton1Click:Connect(function()
     isEnabled = not isEnabled
     if isEnabled then
         -- 开启功能
         humanoid.WalkSpeed = boostSpeed
         ToggleButton.Text = "关闭功能"
         ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
         ButtonGradient.Color = ColorSequence.new({
             ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
             ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 60, 60))
         })
         StatusLabel.Text = "状态：已激活（速度60+无限跳）"
         StatusLabel.TextColor3 = Color3.fromRGB(0, 200, 0)
         
         -- 无限跳
         jumpConnection = UserInputService.JumpRequest:Connect(function()
             if humanoid.Health > 0 then
                 humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
             end
         end)
     else
         -- 关闭功能
         humanoid.WalkSpeed = normalSpeed
         ToggleButton.Text = "开启功能"
         ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
         ButtonGradient.Color = ColorSequence.new({
             ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 140, 255)),
             ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 100, 240))
         })
         StatusLabel.Text = "状态：未激活"
         StatusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
         
         if jumpConnection then
             jumpConnection:Disconnect()
         end
     end
 end)
 -- 角色重生重置
 Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
     humanoid = newChar:WaitForChild("Humanoid")
     if isEnabled then
         humanoid.WalkSpeed = boostSpeed
     end
 end)
