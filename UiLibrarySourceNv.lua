local Library = {}

local VERSION = "v1.3A"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Limpar UIs antigas
for _, v in pairs(CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "Neverlose" then
        v:Destroy() 
    end
end

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Funções utilitárias
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

local function Dragify(frame, parent)
    parent = parent or frame
    
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(
                framePos.X.Scale, 
                framePos.X.Offset + delta.X, 
                framePos.Y.Scale, 
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

local function Round(num, bracket)
    bracket = bracket or 1
    local a = math.floor(num / bracket + (math.sign(num) * 0.5)) * bracket
    if a < 0 then
        a = a + bracket
    end
    return a
end

local function ButtonEffect(options)
    pcall(function()
        options.entered.MouseEnter:Connect(function()
            if options.frame.TextColor3 ~= Color3.fromRGB(234, 239, 246) then
                TweenService:Create(options.frame, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    TextColor3 = Color3.fromRGB(234, 239, 245)
                }):Play()
            end
        end)
        options.entered.MouseLeave:Connect(function()
            if options.frame.TextColor3 ~= Color3.fromRGB(157, 171, 182) and options.frame.TextColor3 ~= Color3.fromRGB(234, 239, 246) then
                TweenService:Create(options.frame, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    TextColor3 = Color3.fromRGB(157, 171, 182)
                }):Play()
            end
        end)
    end)
end

local function ClickEffect(options)
    options.button.MouseButton1Click:Connect(function()
        local new = options.button.TextSize - tonumber(options.amount)
        local revert = new + tonumber(options.amount)
        TweenService:Create(options.button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextSize = new}):Play()
        wait(0.1)
        TweenService:Create(options.button, TweenInfo.new(0.1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextSize = revert}):Play()
    end)
end

function Library:Toggle(value)
    if CoreGui:FindFirstChild("Neverlose") == nil then return end
    local enabled = (type(value) == "boolean" and value) or CoreGui:FindFirstChild("Neverlose").Enabled
    CoreGui:FindFirstChild("Neverlose").Enabled = not enabled
end

function Library:Window(options)
    options.text = options.text or "NEVERLOSE"
    options.icon = options.icon or "rbxassetid://7733955511"

    local SG = Instance.new("ScreenGui")
    local Body = Instance.new("Frame")
    local BodyCorner = Instance.new("UICorner")
    local SideBar = Instance.new("Frame")
    local SidebarCorner = Instance.new("UICorner")
    local SbLine = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local TbLine = Instance.new("Frame")
    local TitleFrame = Instance.new("Frame")
    local TitleIcon = Instance.new("ImageLabel")
    local Title = Instance.new("TextLabel")
    local VersionLabel = Instance.new("TextLabel")
    local AllPages = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")

    -- ScreenGui
    SG.Parent = CoreGui
    SG.Name = "Neverlose"
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Body
    Body.Name = "Body"
    Body.Parent = SG
    Body.AnchorPoint = Vector2.new(0.5, 0.5)
    Body.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0.5, 0, 0.5, 0)
    Body.Size = UDim2.new(0, 658, 0, 516)
    Body.ClipsDescendants = true
    Dragify(Body, Body)

    BodyCorner.CornerRadius = UDim.new(0, 4)
    BodyCorner.Name = "BodyCorner"
    BodyCorner.Parent = Body

    -- SideBar
    SideBar.Name = "SideBar"
    SideBar.Parent = Body
    SideBar.BackgroundColor3 = Color3.fromRGB(26, 36, 48)
    SideBar.BorderSizePixel = 0
    SideBar.Size = UDim2.new(0, 187, 0, 516)

    SidebarCorner.CornerRadius = UDim.new(0, 4)
    SidebarCorner.Name = "SidebarCorner"
    SidebarCorner.Parent = SideBar

    SbLine.Name = "SbLine"
    SbLine.Parent = SideBar
    SbLine.BackgroundColor3 = Color3.fromRGB(15, 23, 36)
    SbLine.BorderSizePixel = 0
    SbLine.Position = UDim2.new(0.995, 0, 0, 0)
    SbLine.Size = UDim2.new(0, 3, 0, 516)

    -- TopBar
    TopBar.Name = "TopBar"
    TopBar.Parent = Body
    TopBar.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
    TopBar.BackgroundTransparency = 1
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0.252, 0, 0, 0)
    TopBar.Size = UDim2.new(0, 562, 0, 49)

    TbLine.Name = "TbLine"
    TbLine.Parent = TopBar
    TbLine.BackgroundColor3 = Color3.fromRGB(15, 23, 36)
    TbLine.BorderSizePixel = 0
    TbLine.Position = UDim2.new(0.04, 0, 1, 0)
    TbLine.Size = UDim2.new(0, 469, 0, 3)

    -- Title Frame com Icon
    TitleFrame.Name = "TitleFrame"
    TitleFrame.Parent = SideBar
    TitleFrame.BackgroundColor3 = Color3.fromRGB(26, 36, 48)
    TitleFrame.BackgroundTransparency = 1
    TitleFrame.BorderSizePixel = 0
    TitleFrame.Position = UDim2.new(0.061, 0, 0.021, 0)
    TitleFrame.Size = UDim2.new(0, 162, 0, 40)

    TitleIcon.Name = "TitleIcon"
    TitleIcon.Parent = TitleFrame
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Position = UDim2.new(0, 0, 0, 0)
    TitleIcon.Size = UDim2.new(0, 32, 0, 32)
    TitleIcon.Image = options.icon
    TitleIcon.ImageColor3 = Color3.fromRGB(43, 154, 198)

    Title.Name = "Title"
    Title.Parent = TitleFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 38, 0, 0)
    Title.Size = UDim2.new(0, 124, 0, 28)
    Title.Font = Enum.Font.GothamBold
    Title.Text = options.text
    Title.TextColor3 = Color3.fromRGB(234, 239, 245)
    Title.TextSize = 22
    Title.TextXAlignment = Enum.TextXAlignment.Left

    VersionLabel.Name = "VersionLabel"
    VersionLabel.Parent = TitleFrame
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Position = UDim2.new(0, 38, 0, 26)
    VersionLabel.Size = UDim2.new(0, 124, 0, 14)
    VersionLabel.Font = Enum.Font.Gotham
    VersionLabel.Text = VERSION
    VersionLabel.TextColor3 = Color3.fromRGB(79, 107, 126)
    VersionLabel.TextSize = 11
    VersionLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- AllPages
    AllPages.Name = "AllPages"
    AllPages.Parent = Body
    AllPages.BackgroundTransparency = 1
    AllPages.BorderSizePixel = 0
    AllPages.Position = UDim2.new(0.295, 0, 0.101, 0)
    AllPages.Size = UDim2.new(0, 463, 0, 464)

    -- TabContainer
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = SideBar
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0.12, 0)
    TabContainer.Size = UDim2.new(0, 187, 0, 454)

    local TabSections = {}

    function TabSections:TabSection(options)
        options.text = options.text or "Tab Section"

        local TabLayout = Instance.new("UIListLayout")
        local TabSection = Instance.new("Frame")
        local TabSectionLabel = Instance.new("TextLabel")
        local TabSectionLayout = Instance.new("UIListLayout")

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = TabContainer

        TabSection.Name = "TabSection"
        TabSection.Parent = TabContainer
        TabSection.BackgroundTransparency = 1
        TabSection.BorderSizePixel = 0
        TabSection.Size = UDim2.new(0, 189, 0, 22)

        local function ResizeTS(num)
            TabSection.Size = TabSection.Size + UDim2.new(0, 0, 0, num)
        end

        TabSectionLabel.Name = "TabSectionLabel"
        TabSectionLabel.Parent = TabSection
        TabSectionLabel.BackgroundTransparency = 1
        TabSectionLabel.BorderSizePixel = 0
        TabSectionLabel.Size = UDim2.new(0, 190, 0, 22)
        TabSectionLabel.Font = Enum.Font.Gotham
        TabSectionLabel.Text = "     " .. options.text
        TabSectionLabel.TextColor3 = Color3.fromRGB(79, 107, 126)
        TabSectionLabel.TextSize = 17
        TabSectionLabel.TextXAlignment = Enum.TextXAlignment.Left

        TabSectionLayout.Name = "TabSectionLayout"
        TabSectionLayout.Parent = TabSection
        TabSectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabSectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabSectionLayout.Padding = UDim.new(0, 7)

        local Tabs = {}

        function Tabs:Tab(options)
            options.text = options.text or "New Tab"
            options.icon = options.icon or "rbxassetid://7999345313"

            local TabButton = Instance.new("TextButton")
            local TabButtonCorner = Instance.new("UICorner")
            local TabIcon = Instance.new("ImageLabel")
            local NewPage = Instance.new("ScrollingFrame")
            local PageLayout = Instance.new("UIGridLayout")

            TabButton.Name = "TabButton"
            TabButton.Parent = TabSection
            TabButton.BackgroundColor3 = Color3.fromRGB(13, 57, 84)
            TabButton.BorderSizePixel = 0
            TabButton.Position = UDim2.new(0.071, 0, 0.403, 0)
            TabButton.Size = UDim2.new(0, 165, 0, 30)
            TabButton.AutoButtonColor = false
            TabButton.Font = Enum.Font.GothamSemibold
            TabButton.Text = "         " .. options.text
            TabButton.TextColor3 = Color3.fromRGB(234, 239, 245)
            TabButton.TextSize = 14
            TabButton.BackgroundTransparency = 1
            TabButton.TextXAlignment = Enum.TextXAlignment.Left

            TabButton.MouseButton1Click:Connect(function()
                for _, v in pairs(AllPages:GetChildren()) do
                    v.Visible = false
                end

                NewPage.Visible = true

                for _, v in pairs(SideBar:GetDescendants()) do
                    if v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                            BackgroundTransparency = 1
                        }):Play()
                    end
                end

                TweenService:Create(TabButton, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    BackgroundTransparency = 0
                }):Play()
            end)

            TabButtonCorner.CornerRadius = UDim.new(0, 4)
            TabButtonCorner.Name = "TabButtonCorner"
            TabButtonCorner.Parent = TabButton

            TabIcon.Name = "TabIcon"
            TabIcon.Parent = TabButton
            TabIcon.BackgroundTransparency = 1
            TabIcon.BorderSizePixel = 0
            TabIcon.Position = UDim2.new(0.041, 0, 0.133, 0)
            TabIcon.Size = UDim2.new(0, 21, 0, 21)
            TabIcon.Image = options.icon
            TabIcon.ImageColor3 = Color3.fromRGB(43, 154, 198)

            NewPage.Name = "NewPage"
            NewPage.Parent = AllPages
            NewPage.Visible = false
            NewPage.BackgroundTransparency = 1
            NewPage.BorderSizePixel = 0
            NewPage.ClipsDescendants = false
            NewPage.Position = UDim2.new(0.022, 0, 0.024, 0)
            NewPage.Size = UDim2.new(0, 442, 0, 440)
            NewPage.ScrollBarThickness = 4
            NewPage.CanvasSize = UDim2.new(0, 0, 0, 0)

            PageLayout.Name = "PageLayout"
            PageLayout.Parent = NewPage
            PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
            PageLayout.CellPadding = UDim2.new(0, 12, 0, 12)
            PageLayout.CellSize = UDim2.new(0, 215, 0, -10)
            
            PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                NewPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y) 
            end)

            ResizeTS(50)

            local Sections = {}

            function Sections:Section(options)
                options.text = options.text or "Section"
                options.icon = options.icon or nil

                local SectionFrame = Instance.new("Frame")
                local SectionLabelFrame = Instance.new("Frame")
                local SectionIcon = Instance.new("ImageLabel")
                local SectionLabel = Instance.new("TextLabel")
                local SectionFrameCorner = Instance.new("UICorner")
                local SectionLayout = Instance.new("UIListLayout")
                local SLine = Instance.new("Frame")
                local SectionSizeConstraint = Instance.new("UISizeConstraint")

                SectionFrame.Name = "SectionFrame"
                SectionFrame.Parent = NewPage
                SectionFrame.BackgroundColor3 = Color3.fromRGB(0, 15, 30)
                SectionFrame.BorderSizePixel = 0
                SectionFrame.Size = UDim2.new(0, 215, 0, 134)

                SectionLabelFrame.Name = "SectionLabelFrame"
                SectionLabelFrame.Parent = SectionFrame
                SectionLabelFrame.BackgroundTransparency = 1
                SectionLabelFrame.BorderSizePixel = 0
                SectionLabelFrame.Position = UDim2.new(0.012, 0, 0, 0)
                SectionLabelFrame.Size = UDim2.new(0, 213, 0, 25)

                if options.icon then
                    SectionIcon.Name = "SectionIcon"
                    SectionIcon.Parent = SectionLabelFrame
                    SectionIcon.BackgroundTransparency = 1
                    SectionIcon.Position = UDim2.new(0, 5, 0, 2)
                    SectionIcon.Size = UDim2.new(0, 20, 0, 20)
                    SectionIcon.Image = options.icon
                    SectionIcon.ImageColor3 = Color3.fromRGB(43, 154, 198)

                    SectionLabel.Name = "SectionLabel"
                    SectionLabel.Parent = SectionLabelFrame
                    SectionLabel.BackgroundTransparency = 1
                    SectionLabel.Position = UDim2.new(0, 30, 0, 0)
                    SectionLabel.Size = UDim2.new(0, 183, 0, 25)
                    SectionLabel.Font = Enum.Font.GothamSemibold
                    SectionLabel.Text = options.text
                    SectionLabel.TextColor3 = Color3.fromRGB(234, 239, 245)
                    SectionLabel.TextSize = 14
                    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
                else
                    SectionLabel.Name = "SectionLabel"
                    SectionLabel.Parent = SectionLabelFrame
                    SectionLabel.BackgroundTransparency = 1
                    SectionLabel.Position = UDim2.new(0, 5, 0, 0)
                    SectionLabel.Size = UDim2.new(0, 208, 0, 25)
                    SectionLabel.Font = Enum.Font.GothamSemibold
                    SectionLabel.Text = options.text
                    SectionLabel.TextColor3 = Color3.fromRGB(234, 239, 245)
                    SectionLabel.TextSize = 14
                    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
                end

                SectionFrameCorner.CornerRadius = UDim.new(0, 4)
                SectionFrameCorner.Name = "SectionFrameCorner"
                SectionFrameCorner.Parent = SectionFrame

                SectionLayout.Name = "SectionLayout"
                SectionLayout.Parent = SectionFrame
                SectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                SectionLayout.Padding = UDim.new(0, 2)

                SLine.Name = "SLine"
                SLine.Parent = SectionFrame
                SLine.BackgroundColor3 = Color3.fromRGB(13, 28, 44)
                SLine.BorderSizePixel = 0
                SLine.Position = UDim2.new(0.026, 0, 0.415, 0)
                SLine.Size = UDim2.new(0, 202, 0, 3)

                SectionSizeConstraint.Name = "SectionSizeConstraint"
                SectionSizeConstraint.Parent = SectionFrame
                SectionSizeConstraint.MinSize = Vector2.new(215, 35)

                local function Resize(num)
                    SectionSizeConstraint.MinSize = SectionSizeConstraint.MinSize + Vector2.new(0, num)
                end

                local Elements = {}

                function Elements:Button(options)
                    if not options.text or not options.callback then 
                        Notify("Button", "Missing arguments!") 
                        return 
                    end

                    local TextButton = Instance.new("TextButton")

                    TextButton.Parent = SectionFrame
                    TextButton.BackgroundColor3 = Color3.fromRGB(13, 57, 84)
                    TextButton.BorderSizePixel = 0
                    TextButton.Position = UDim2.new(0.035, 0, 0.356, 0)
                    TextButton.Size = UDim2.new(0, 200, 0, 22)
                    TextButton.AutoButtonColor = false
                    TextButton.Text = options.text
                    TextButton.Font = Enum.Font.Gotham
                    TextButton.TextColor3 = Color3.fromRGB(157, 171, 182)
                    TextButton.TextSize = 14
                    TextButton.BackgroundTransparency = 1
                    
                    ButtonEffect({frame = TextButton, entered = TextButton})
                    ClickEffect({button = TextButton, amount = 5})
                    
                    TextButton.MouseButton1Click:Connect(function()
                        options.callback()
                    end)

                    Resize(25)
                end

                function Elements:Toggle(options)
                    if not options.text or not options.callback then 
                        Notify("Toggle", "Missing arguments!") 
                        return 
                    end

                    local ToggleLabel = Instance.new("TextLabel")
                    local ToggleFrame = Instance.new("TextButton")
                    local TogFrameCorner = Instance.new("UICorner")
                    local ToggleButton = Instance.new("TextButton")
                    local TogBtnCorner = Instance.new("UICorner")

                    local State = options.state or false

                    if options.state then
                        ToggleButton.Position = UDim2.new(0.74, 0, 0.5, 0)
                        ToggleLabel.TextColor3 = Color3.fromRGB(234, 239, 246)
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(2, 162, 243)
                        ToggleFrame.BackgroundColor3 = Color3.fromRGB(2, 23, 49)
                    end

                    ToggleLabel.Name = "ToggleLabel"
                    ToggleLabel.Parent = SectionFrame
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Position = UDim2.new(0.035, 0, 0.966, 0)
                    ToggleLabel.Size = UDim2.new(0, 200, 0, 22)
                    ToggleLabel.Font = Enum.Font.Gotham
                    ToggleLabel.Text = " " .. options.text
                    ToggleLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    ToggleLabel.TextSize = 14
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ButtonEffect({frame = ToggleLabel, entered = ToggleLabel})

                    local function PerformToggle()
                        State = not State
                        options.callback(State)
                        
                        TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                            Position = State and UDim2.new(0.74, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
                        }):Play()
                        
                        TweenService:Create(ToggleLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                            TextColor3 = State and Color3.fromRGB(234, 239, 246) or Color3.fromRGB(157, 171, 182)
                        }):Play()
                        
                        TweenService:Create(ToggleButton, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                            BackgroundColor3 = State and Color3.fromRGB(2, 162, 243) or Color3.fromRGB(77, 77, 77)
                        }):Play()
                        
                        TweenService:Create(ToggleFrame, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                            BackgroundColor3 = State and Color3.fromRGB(2, 23, 49) or Color3.fromRGB(4, 4, 11)
                        }):Play()
                    end

                    ToggleFrame.Name = "ToggleFrame"
                    ToggleFrame.Parent = ToggleLabel
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(4, 4, 11)
                    ToggleFrame.BorderSizePixel = 0
                    ToggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    ToggleFrame.Position = UDim2.new(0.9, 0, 0.5, 0)
                    ToggleFrame.Size = UDim2.new(0, 38, 0, 18)
                    ToggleFrame.AutoButtonColor = false
                    ToggleFrame.Font = Enum.Font.SourceSans
                    ToggleFrame.Text = ""
                    ToggleFrame.MouseButton1Click:Connect(PerformToggle)

                    TogFrameCorner.CornerRadius = UDim.new(0, 50)
                    TogFrameCorner.Parent = ToggleFrame

                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.Parent = ToggleFrame
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                    ToggleButton.BorderSizePixel = 0
                    ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
                    ToggleButton.Position = UDim2.new(0.25, 0, 0.5, 0)
                    ToggleButton.Size = UDim2.new(0, 16, 0, 16)
                    ToggleButton.AutoButtonColor = false
                    ToggleButton.Font = Enum.Font.SourceSans
                    ToggleButton.Text = ""
                    ToggleButton.MouseButton1Click:Connect(PerformToggle)

                    TogBtnCorner.CornerRadius = UDim.new(0, 50)
                    TogBtnCorner.Parent = ToggleButton

                    Resize(25)
                end

                function Elements:Slider(options)
                    if not options.text or not options.min or not options.max or not options.callback then 
                        Notify("Slider", "Missing arguments!") 
                        return 
                    end

                    local Slider = Instance.new("Frame")
                    local SliderLabel = Instance.new("TextLabel")
                    local SliderFrame = Instance.new("TextButton")
                    local SliderBall = Instance.new("TextButton")
                    local SliderBallCorner = Instance.new("UICorner")
                    local SliderTextBox = Instance.new("TextBox")
                    
                    ButtonEffect({frame = SliderLabel, entered = Slider})

                    local Value
                    local Held = false
                    local Percentage = 0
                    local Step = 0.01

                    local function Snap(number, factor)
                        if factor == 0 then
                            return number
                        else
                            return math.floor(number / factor + 0.5) * factor
                        end
                    end

                    UserInputService.InputEnded:Connect(function()
                        Held = false
                    end)

                    Slider.Name = "Slider"
                    Slider.Parent = SectionFrame
                    Slider.BackgroundTransparency = 1
                    Slider.Position = UDim2.new(0.04, 0, 0.947, 0)
                    Slider.Size = UDim2.new(0, 200, 0, 22)

                    SliderLabel.Name = "SliderLabel"
                    SliderLabel.Parent = Slider
                    SliderLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderLabel.BackgroundTransparency = 1
                    SliderLabel.Position = UDim2.new(0.2, 0, 0.5, 0)
                    SliderLabel.Size = UDim2.new(0, 77, 0, 22)
                    SliderLabel.Font = Enum.Font.Gotham
                    SliderLabel.Text = " " .. options.text
                    SliderLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    SliderLabel.TextSize = 14
                    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    SliderLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
                        if SliderLabel.TextBounds.X > 75 then
                            SliderLabel.TextScaled = true
                        else
                            SliderLabel.TextScaled = false
                        end
                    end)

                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = SliderLabel
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(29, 87, 118)
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderFrame.Position = UDim2.new(1.6, 0, 0.5, 0)
                    SliderFrame.Size = UDim2.new(0, 72, 0, 2)
                    SliderFrame.Text = ""
                    SliderFrame.AutoButtonColor = false
                    SliderFrame.MouseButton1Down:Connect(function()
                        Held = true
                    end)

                    SliderBall.Name = "SliderBall"
                    SliderBall.Parent = SliderFrame
                    SliderBall.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBall.BackgroundColor3 = Color3.fromRGB(67, 136, 231)
                    SliderBall.BorderSizePixel = 0
                    SliderBall.Position = UDim2.new(0, 0, 0.5, 0)
                    SliderBall.Size = UDim2.new(0, 14, 0, 14)
                    SliderBall.AutoButtonColor = false
                    SliderBall.Font = Enum.Font.SourceSans
                    SliderBall.Text = ""
                    SliderBall.MouseButton1Down:Connect(function()
                        Held = true
                    end)

                    RunService.RenderStepped:Connect(function()
                        if Held then
                            local BtnPos = SliderBall.Position
                            local MousePos = UserInputService:GetMouseLocation().X
                            local FrameSize = SliderFrame.AbsoluteSize.X
                            local FramePos = SliderFrame.AbsolutePosition.X
                            local pos = Snap((MousePos - FramePos) / FrameSize, Step)
                            Percentage = math.clamp(pos, 0, 0.9)

                            Value = ((((tonumber(options.max) - tonumber(options.min)) / 0.9) * Percentage)) + tonumber(options.min)
                            Value = Round(Value, options.float)
                            Value = math.clamp(Value, options.min, options.max)
                            SliderTextBox.Text = Value
                            options.callback(Value)
                            SliderBall.Position = UDim2.new(Percentage, 0, BtnPos.Y.Scale, BtnPos.Y.Offset)
                        end
                    end)

                    SliderBallCorner.CornerRadius = UDim.new(0, 50)
                    SliderBallCorner.Parent = SliderBall

                    SliderTextBox.Name = "SliderTextBox"
                    SliderTextBox.Parent = SliderLabel
                    SliderTextBox.BackgroundColor3 = Color3.fromRGB(1, 7, 17)
                    SliderTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderTextBox.Position = UDim2.new(2.4, 0, 0.5, 0)
                    SliderTextBox.Size = UDim2.new(0, 31, 0, 15)
                    SliderTextBox.Font = Enum.Font.Gotham
                    SliderTextBox.Text = options.min
                    SliderTextBox.TextColor3 = Color3.fromRGB(234, 239, 245)
                    SliderTextBox.TextSize = 11
                    SliderTextBox.TextWrapped = true

                    SliderTextBox.Focused:Connect(function()
                        TweenService:Create(SliderLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(234, 239, 246)
                        }):Play()
                    end)

                    SliderTextBox.FocusLost:Connect(function(Enter)
                        TweenService:Create(SliderLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(157, 171, 182)
                        }):Play()
                        
                        if Enter then
                            if SliderTextBox.Text ~= nil and SliderTextBox.Text ~= "" then
                                local num = tonumber(SliderTextBox.Text)
                                if num then
                                    if num > options.max then
                                        SliderTextBox.Text = tostring(options.max)
                                        options.callback(options.max)
                                    elseif num < options.min then
                                        SliderTextBox.Text = tostring(options.min)
                                        options.callback(options.min)
                                    else
                                        options.callback(num)
                                    end
                                end
                            end
                        end
                    end)

                    Resize(25)
                end

                function Elements:Dropdown(options)
                    if not options.text or not options.default or not options.list or not options.callback then 
                        Notify("Dropdown", "Missing arguments!") 
                        return 
                    end

                    local DropYSize = 0
                    local Dropped = false

                    local Dropdown = Instance.new("Frame")
                    local DropdownLabel = Instance.new("TextLabel")
                    local DropdownText = Instance.new("TextLabel")
                    local DropdownArrow = Instance.new("ImageButton")
                    local DropdownList = Instance.new("Frame")
                    local DropListLayout = Instance.new("UIListLayout")
                    
                    ButtonEffect({frame = DropdownLabel, entered = Dropdown})

                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = SectionFrame
                    Dropdown.BackgroundTransparency = 1
                    Dropdown.BorderSizePixel = 0
                    Dropdown.Position = UDim2.new(0.07, 0, 0.237, 0)
                    Dropdown.Size = UDim2.new(0, 200, 0, 22)
                    Dropdown.ZIndex = 2

                    DropdownLabel.Name = "DropdownLabel"
                    DropdownLabel.Parent = Dropdown
                    DropdownLabel.BackgroundTransparency = 1
                    DropdownLabel.BorderSizePixel = 0
                    DropdownLabel.Size = UDim2.new(0, 105, 0, 22)
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.Text = " " .. options.text
                    DropdownLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    DropdownLabel.TextSize = 14
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.TextWrapped = true

                    DropdownText.Name = "DropdownText"
                    DropdownText.Parent = DropdownLabel
                    DropdownText.BackgroundColor3 = Color3.fromRGB(2, 5, 12)
                    DropdownText.Position = UDim2.new(1.086, 0, 0.091, 0)
                    DropdownText.Size = UDim2.new(0, 87, 0, 18)
                    DropdownText.Font = Enum.Font.Gotham
                    DropdownText.Text = " " .. options.default
                    DropdownText.TextColor3 = Color3.fromRGB(234, 239, 245)
                    DropdownText.TextSize = 12
                    DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownText.TextWrapped = true

                    DropdownArrow.Name = "DropdownArrow"
                    DropdownArrow.Parent = DropdownText
                    DropdownArrow.BackgroundColor3 = Color3.fromRGB(2, 5, 12)
                    DropdownArrow.BorderSizePixel = 0
                    DropdownArrow.Position = UDim2.new(0.874, 0, 0.139, 0)
                    DropdownArrow.Size = UDim2.new(0, 11, 0, 13)
                    DropdownArrow.AutoButtonColor = false
                    DropdownArrow.Image = "rbxassetid://8008296380"
                    DropdownArrow.ImageColor3 = Color3.fromRGB(157, 171, 182)

                    DropdownArrow.MouseButton1Click:Connect(function()
                        Dropped = not Dropped
                        
                        if Dropped then
                            if DropdownLabel.TextColor3 ~= Color3.fromRGB(234, 239, 245) then
                                TweenService:Create(DropdownLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    TextColor3 = Color3.fromRGB(234, 239, 246)
                                }):Play()
                            end
                            TweenService:Create(DropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Size = UDim2.new(0, 87, 0, DropYSize)
                            }):Play()
                            TweenService:Create(DropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                BorderSizePixel = 1
                            }):Play()
                        else
                            if DropdownLabel.TextColor3 ~= Color3.fromRGB(157, 171, 182) then
                                TweenService:Create(DropdownLabel, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    TextColor3 = Color3.fromRGB(157, 171, 182)
                                }):Play()
                            end
                            TweenService:Create(DropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Size = UDim2.new(0, 87, 0, 0)
                            }):Play()
                            TweenService:Create(DropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                BorderSizePixel = 0
                            }):Play()
                        end
                    end)

                    DropdownList.Name = "DropdownList"
                    DropdownList.Parent = DropdownText
                    DropdownList.BackgroundColor3 = Color3.fromRGB(2, 5, 12)
                    DropdownList.Position = UDim2.new(0, 0, 1, 0)
                    DropdownList.Size = UDim2.new(0, 87, 0, 0)
                    DropdownList.ClipsDescendants = true
                    DropdownList.BorderSizePixel = 0
                    DropdownList.ZIndex = 10

                    DropListLayout.Name = "DropListLayout"
                    DropListLayout.Parent = DropdownList
                    DropListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    
                    Resize(25)

                    for _, v in pairs(options.list) do
                        local DropdownBtn = Instance.new("TextButton")

                        DropdownBtn.Name = "DropdownBtn"
                        DropdownBtn.Parent = DropdownList
                        DropdownBtn.BackgroundTransparency = 1
                        DropdownBtn.BorderSizePixel = 0
                        DropdownBtn.Position = UDim2.new(-0.011, 0, 0.031, 0)
                        DropdownBtn.Size = UDim2.new(0, 87, 0, 18)
                        DropdownBtn.AutoButtonColor = false
                        DropdownBtn.Font = Enum.Font.Gotham
                        DropdownBtn.TextColor3 = Color3.fromRGB(234, 239, 245)
                        DropdownBtn.TextSize = 12
                        DropdownBtn.Text = v
                        DropdownBtn.ZIndex = 15
                        
                        ClickEffect({button = DropdownBtn, amount = 5})

                        DropYSize = DropYSize + 18

                        DropdownBtn.MouseButton1Click:Connect(function()
                            DropdownText.Text = " " .. v
                            options.callback(v)
                        end)
                    end
                end

                function Elements:Textbox(options)
                    if not options.text or not options.value or not options.callback then 
                        Notify("Textbox", "Missing arguments!") 
                        return 
                    end

                    local Textbox = Instance.new("Frame")
                    local TextBoxLabel = Instance.new("TextLabel")
                    local TextBox = Instance.new("TextBox")

                    Textbox.Name = "Textbox"
                    Textbox.Parent = SectionFrame
                    Textbox.BackgroundTransparency = 1
                    Textbox.BorderSizePixel = 0
                    Textbox.Position = UDim2.new(0.035, 0, 0.945, 0)
                    Textbox.Size = UDim2.new(0, 200, 0, 22)
                    
                    ButtonEffect({frame = TextBoxLabel, entered = Textbox})

                    TextBoxLabel.Name = "TextBoxLabel"
                    TextBoxLabel.Parent = Textbox
                    TextBoxLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    TextBoxLabel.BackgroundTransparency = 1
                    TextBoxLabel.Position = UDim2.new(0.237, 0, 0.5, 0)
                    TextBoxLabel.Size = UDim2.new(0, 99, 0, 22)
                    TextBoxLabel.Font = Enum.Font.Gotham
                    TextBoxLabel.Text = "  " .. options.text
                    TextBoxLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    TextBoxLabel.TextSize = 14
                    TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

                    TextBox.Name = "TextBox"
                    TextBox.Parent = Textbox
                    TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                    TextBox.BackgroundColor3 = Color3.fromRGB(1, 7, 17)
                    TextBox.Position = UDim2.new(0.85, 0, 0.5, 0)
                    TextBox.Size = UDim2.new(0, 53, 0, 15)
                    TextBox.Font = Enum.Font.Gotham
                    TextBox.Text = options.value
                    TextBox.TextColor3 = Color3.fromRGB(234, 239, 245)
                    TextBox.TextSize = 11
                    TextBox.TextWrapped = true

                    Resize(25)

                    TextBox.Focused:Connect(function()
                        TweenService:Create(TextBoxLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(234, 239, 246)
                        }):Play()
                    end)

                    TextBox.FocusLost:Connect(function(Enter)
                        TweenService:Create(TextBoxLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(157, 171, 182)
                        }):Play()
                        
                        if Enter then
                            if TextBox.Text ~= nil and TextBox.Text ~= "" then
                                options.callback(TextBox.Text)
                            end
                        end
                    end)
                end

                function Elements:Colorpicker(options)
                    if not options.text or not options.color or not options.callback then 
                        Notify("Colorpicker", "Missing arguments!") 
                        return 
                    end

                    local hue, sat, val = Color3.toHSV(options.color)

                    local Colorpicker = Instance.new("Frame")
                    local ColorpickerLabel = Instance.new("TextLabel")
                    local ColorpickerButton = Instance.new("ImageButton")
                    local ColorpickerFrame = Instance.new("Frame")
                    local RGB = Instance.new("ImageButton")
                    local RGBCircle = Instance.new("ImageLabel")
                    local Darkness = Instance.new("ImageButton")
                    local DarknessCircle = Instance.new("Frame")
                    local ColorHex = Instance.new("TextLabel")
                    local Copy = Instance.new("TextButton")
                    
                    ButtonEffect({frame = ColorpickerLabel, entered = Colorpicker})

                    local vis = false 

                    Colorpicker.Name = "Colorpicker"
                    Colorpicker.Parent = SectionFrame
                    Colorpicker.BackgroundTransparency = 1
                    Colorpicker.BorderSizePixel = 0
                    Colorpicker.Position = UDim2.new(0.035, 0, 0.945, 0)
                    Colorpicker.Size = UDim2.new(0, 200, 0, 22)
                    Colorpicker.ZIndex = 2

                    ColorpickerLabel.Name = "ColorpickerLabel"
                    ColorpickerLabel.Parent = Colorpicker
                    ColorpickerLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    ColorpickerLabel.BackgroundTransparency = 1
                    ColorpickerLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                    ColorpickerLabel.Size = UDim2.new(0, 200, 0, 22)
                    ColorpickerLabel.Font = Enum.Font.Gotham
                    ColorpickerLabel.Text = " " .. options.text
                    ColorpickerLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    ColorpickerLabel.TextSize = 14
                    ColorpickerLabel.TextXAlignment = Enum.TextXAlignment.Left

                    ColorpickerButton.Name = "ColorpickerButton"
                    ColorpickerButton.Parent = ColorpickerLabel
                    ColorpickerButton.AnchorPoint = Vector2.new(0.5, 0.5)
                    ColorpickerButton.BackgroundTransparency = 1
                    ColorpickerButton.BorderSizePixel = 0
                    ColorpickerButton.Position = UDim2.new(0.92, 0, 0.57, 0)
                    ColorpickerButton.Size = UDim2.new(0, 15, 0, 15)
                    ColorpickerButton.Image = "rbxassetid://8023491332"
                    ColorpickerButton.MouseButton1Click:Connect(function()
                        ColorpickerFrame.Visible = not ColorpickerFrame.Visible
                        vis = not vis
                        TweenService:Create(ColorpickerLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                            TextColor3 = vis and Color3.fromRGB(234, 239, 246) or Color3.fromRGB(157, 171, 182)
                        }):Play()
                    end)

                    ColorpickerFrame.Name = "ColorpickerFrame"
                    ColorpickerFrame.Parent = Colorpicker
                    ColorpickerFrame.Visible = false
                    ColorpickerFrame.BackgroundColor3 = Color3.fromRGB(0, 10, 21)
                    ColorpickerFrame.Position = UDim2.new(1.15, 0, 0.5, 0)
                    ColorpickerFrame.Size = UDim2.new(0, 251, 0, 221)
                    ColorpickerFrame.ZIndex = 15
                    Dragify(ColorpickerFrame, Colorpicker)

                    RGB.Name = "RGB"
                    RGB.Parent = ColorpickerFrame
                    RGB.BackgroundTransparency = 1
                    RGB.BorderSizePixel = 0
                    RGB.Position = UDim2.new(0.067, 0, 0.068, 0)
                    RGB.Size = UDim2.new(0, 179, 0, 161)
                    RGB.AutoButtonColor = false
                    RGB.Image = "rbxassetid://6523286724"
                    RGB.ZIndex = 16

                    RGBCircle.Name = "RGBCircle"
                    RGBCircle.Parent = RGB
                    RGBCircle.BackgroundTransparency = 1
                    RGBCircle.BorderSizePixel = 0
                    RGBCircle.Size = UDim2.new(0, 14, 0, 14)
                    RGBCircle.Image = "rbxassetid://3926309567"
                    RGBCircle.ImageRectOffset = Vector2.new(628, 420)
                    RGBCircle.ImageRectSize = Vector2.new(48, 48)
                    RGBCircle.ZIndex = 16

                    Darkness.Name = "Darkness"
                    Darkness.Parent = ColorpickerFrame
                    Darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Darkness.BorderSizePixel = 0
                    Darkness.Position = UDim2.new(0.832, 0, 0.068, 0)
                    Darkness.Size = UDim2.new(0, 33, 0, 161)
                    Darkness.AutoButtonColor = false
                    Darkness.Image = "rbxassetid://156579757"
                    Darkness.ZIndex = 16

                    DarknessCircle.Name = "DarknessCircle"
                    DarknessCircle.Parent = Darkness
                    DarknessCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DarknessCircle.BorderSizePixel = 0
                    DarknessCircle.Position = UDim2.new(0, 0, 0, 0)
                    DarknessCircle.Size = UDim2.new(0, 33, 0, 5)
                    DarknessCircle.ZIndex = 16

                    ColorHex.Name = "ColorHex"
                    ColorHex.Parent = ColorpickerFrame
                    ColorHex.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
                    ColorHex.Position = UDim2.new(0.072, 0, 0.851, 0)
                    ColorHex.Size = UDim2.new(0, 94, 0, 24)
                    ColorHex.Font = Enum.Font.GothamSemibold
                    ColorHex.Text = "#FFFFFF"
                    ColorHex.TextColor3 = Color3.fromRGB(234, 239, 245)
                    ColorHex.TextSize = 14
                    ColorHex.ZIndex = 16

                    Copy.Parent = ColorpickerFrame
                    Copy.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
                    Copy.Position = UDim2.new(0.721, 0, 0.851, 0)
                    Copy.Size = UDim2.new(0, 60, 0, 24)
                    Copy.AutoButtonColor = false
                    Copy.Font = Enum.Font.GothamSemibold
                    Copy.Text = "Copy"
                    Copy.TextColor3 = Color3.fromRGB(234, 239, 245)
                    Copy.TextSize = 14
                    Copy.ZIndex = 16
                    
                    Resize(25)
                    
                    Copy.MouseButton1Click:Connect(function()
                        if setclipboard then
                            setclipboard(tostring(ColorHex.Text))
                            Notify("Neverlose", "Copied: " .. tostring(ColorHex.Text))
                        else
                            print(tostring(ColorHex.Text))
                            Notify("Neverlose", "Printed to console: " .. tostring(ColorHex.Text))
                        end
                    end)

                    local WheelDown = false
                    local SlideDown = false
                    local color = {1, 1, 1}

                    local function ToHex(color)
                        return string.format("#%02X%02X%02X", color.R * 255, color.G * 255, color.B * 255)
                    end
                    
                    local function Update()
                        local r, g, b = color[1], color[2], color[3]
                        local c = Color3.fromHSV(r, g, b)
                        ColorHex.Text = tostring(ToHex(c))
                    end
                    
                    local function UpdateSlide()   
                        local ml = Mouse
                        local y = ml.Y - Darkness.AbsolutePosition.Y
                        local maxY = Darkness.AbsoluteSize.Y
                        if y < 0 then y = 0 end
                        if y > maxY then y = maxY end
                        y = y / maxY
                        local cy = DarknessCircle.AbsoluteSize.Y / 2
                        color = {color[1], color[2], 1 - y}
                        local realcolor = Color3.fromHSV(color[1], color[2], color[3])
                        DarknessCircle.BackgroundColor3 = realcolor
                        DarknessCircle.Position = UDim2.new(0, 0, y, -cy)
                        options.callback(realcolor)
                        Update()
                    end
                    
                    local function UpdateRing()
                        local ml = Mouse
                        local x = ml.X - RGB.AbsolutePosition.X
                        local y = ml.Y - RGB.AbsolutePosition.Y
                        local maxX, maxY = RGB.AbsoluteSize.X, RGB.AbsoluteSize.Y
                        if x < 0 then x = 0 end
                        if x > maxX then x = maxX end
                        if y < 0 then y = 0 end
                        if y > maxY then y = maxY end
                        x = x / maxX
                        y = y / maxY

                        local cx = RGBCircle.AbsoluteSize.X / 2
                        local cy = RGBCircle.AbsoluteSize.Y / 2

                        RGBCircle.Position = UDim2.new(x, -cx, y, -cy)

                        color = {1 - x, 1 - y, color[3]}
                        local realcolor = Color3.fromHSV(color[1], color[2], color[3])
                        Darkness.BackgroundColor3 = realcolor
                        DarknessCircle.BackgroundColor3 = realcolor
                        options.callback(realcolor)
                        Update()
                    end

                    RGB.MouseButton1Down:Connect(function()
                        WheelDown = true
                        UpdateRing()
                    end)
                    
                    Darkness.MouseButton1Down:Connect(function()
                        SlideDown = true
                        UpdateSlide()
                    end)

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            WheelDown = false
                            SlideDown = false
                        end
                    end)

                    RGB.MouseMoved:Connect(function()
                        if WheelDown then UpdateRing() end
                    end)
                    
                    Darkness.MouseMoved:Connect(function()
                        if SlideDown then UpdateSlide() end
                    end)

                    local function SetColor(tbl)
                        local realcolor = Color3.fromHSV(tbl[1], tbl[2], tbl[3])
                        ColorHex.Text = tostring(ToHex(realcolor))
                        DarknessCircle.BackgroundColor3 = realcolor
                    end
                    
                    SetColor({hue, sat, val})
                end

                function Elements:Keybind(options)
                    if not options.text or not options.default or not options.callback then 
                        Notify("Keybind", "Missing arguments") 
                        return 
                    end

                    Resize(25)

                    local Blacklisted = {
                        Return = true, Space = true, Tab = true,
                        W = true, A = true, S = true, D = true,
                        I = true, O = true, Unknown = true
                    }

                    local Short = {
                        RightControl = "RCtrl",
                        LeftControl = "LCtrl",
                        LeftShift = "LShift",
                        RightShift = "RShift",
                        MouseButton1 = "M1",
                        MouseButton2 = "M2",
                        LeftAlt = "LAlt",
                        RightAlt = "RAlt"
                    }

                    local oldKey = options.default.Name
                    local Keybind = Instance.new("Frame")
                    local KeybindButton = Instance.new("TextButton")
                    local KeybindLabel = Instance.new("TextLabel")

                    Keybind.Name = "Keybind"
                    Keybind.Parent = SectionFrame
                    Keybind.BackgroundTransparency = 1
                    Keybind.BorderSizePixel = 0
                    Keybind.Position = UDim2.new(0.035, 0, 0.945, 0)
                    Keybind.Size = UDim2.new(0, 200, 0, 22)
                    Keybind.ZIndex = 2
                    
                    ButtonEffect({frame = KeybindButton, entered = Keybind})

                    KeybindButton.Name = "KeybindButton"
                    KeybindButton.Parent = Keybind
                    KeybindButton.AnchorPoint = Vector2.new(0.5, 0.5)
                    KeybindButton.BackgroundTransparency = 1
                    KeybindButton.BorderSizePixel = 0
                    KeybindButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                    KeybindButton.Size = UDim2.new(0, 200, 0, 22)
                    KeybindButton.AutoButtonColor = false
                    KeybindButton.Font = Enum.Font.Gotham
                    KeybindButton.Text = " " .. options.text
                    KeybindButton.TextColor3 = Color3.fromRGB(157, 171, 182)
                    KeybindButton.TextSize = 14
                    KeybindButton.TextXAlignment = Enum.TextXAlignment.Left
                    
                    KeybindButton.MouseButton1Click:Connect(function()
                        KeybindLabel.Text = "... "
                        TweenService:Create(KeybindButton, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(234, 239, 246)
                        }):Play()
                        TweenService:Create(KeybindLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(234, 239, 246)
                        }):Play()
                        
                        local inputbegan = UserInputService.InputBegan:Wait()
                        
                        if not Blacklisted[inputbegan.KeyCode.Name] then
                            TweenService:Create(KeybindLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            TweenService:Create(KeybindButton, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            KeybindLabel.Text = Short[inputbegan.KeyCode.Name] or inputbegan.KeyCode.Name
                            oldKey = inputbegan.KeyCode.Name
                        else
                            TweenService:Create(KeybindButton, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            TweenService:Create(KeybindLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            KeybindLabel.Text = Short[oldKey] or oldKey
                        end
                    end)

                    UserInputService.InputBegan:Connect(function(key, focused)
                        if not focused then
                            if key.KeyCode.Name == oldKey then
                                options.callback(oldKey)
                            end
                        end
                    end)

                    KeybindLabel.Name = "KeybindLabel"
                    KeybindLabel.Parent = KeybindButton
                    KeybindLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    KeybindLabel.BackgroundTransparency = 1
                    KeybindLabel.Position = UDim2.new(0.91, 0, 0.5, 0)
                    KeybindLabel.Size = UDim2.new(0, 36, 0, 22)
                    KeybindLabel.Font = Enum.Font.Gotham
                    KeybindLabel.Text = oldKey .. " "
                    KeybindLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    KeybindLabel.TextSize = 14
                    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Right
                end

                return Elements
            end

            return Sections
        end

        return Tabs
    end

    return TabSections
end

return Library

--[[
═══════════════════════════════════════════════════════════════════
    NEVERLOSE UI LIBRARY - EXEMPLO DE USO COMPLETO
═══════════════════════════════════════════════════════════════════

local Library = loadstring(game:HttpGet("YOUR_SCRIPT_URL"))()

-- Criar janela principal com ícone
local Window = Library:Window({
    text = "MY SCRIPT",
    icon = "rbxassetid://7733955511"
})

-- Criar seção de abas
local MainTab = Window:TabSection({text = "MAIN"})

-- Criar aba de combate com ícone
local CombatTab = MainTab:Tab({
    text = "Combat",
    icon = "rbxassetid://7733960981"
})

-- Seção de Aimbot com ícone
local AimbotSection = CombatTab:Section({
    text = "Aimbot",
    icon = "rbxassetid://7733779610"
})

-- Toggle de Aimbot
AimbotSection:Toggle({
    text = "Enable Aimbot",
    state = false,
    callback = function(value)
        print("Aimbot:", value)
    end
})

-- Slider de FOV
AimbotSection:Slider({
    text = "FOV",
    min = 0,
    max = 360,
    float = 1,
    callback = function(value)
        print("FOV:", value)
    end
})

-- Dropdown de parte do alvo
AimbotSection:Dropdown({
    text = "Target Part",
    default = "Head",
    list = {"Head", "Torso", "HumanoidRootPart", "Random"},
    callback = function(value)
        print("Target:", value)
    end
})

-- Botão de reset
AimbotSection:Button({
    text = "Reset Settings",
    callback = function()
        print("Settings Reset!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Aimbot",
            Text = "Settings have been reset!",
            Duration = 3
        })
    end
})

-- Seção de ESP com ícone
local VisualsSection = CombatTab:Section({
    text = "ESP",
    icon = "rbxassetid://7733715400"
})

-- Toggle de Box ESP
VisualsSection:Toggle({
    text = "Box ESP",
    state = false,
    callback = function(value)
        print("Box ESP:", value)
    end
})

-- Toggle de Name ESP
VisualsSection:Toggle({
    text = "Name ESP",
    state = false,
    callback = function(value)
        print("Name ESP:", value)
    end
})

-- Colorpicker de cor do box
VisualsSection:Colorpicker({
    text = "Box Color",
    color = Color3.fromRGB(255, 0, 0),
    callback = function(color)
        print("Color:", color)
    end
})

-- Textbox de distância máxima
VisualsSection:Textbox({
    text = "Max Distance",
    value = "1000",
    callback = function(text)
        print("Distance:", text)
    end
})

-- Criar aba de Misc
local MiscTab = MainTab:Tab({
    text = "Misc",
    icon = "rbxassetid://7733920644"
})

-- Seção de Player com ícone
local PlayerSection = MiscTab:Section({
    text = "Player",
    icon = "rbxassetid://7733954760"
})

-- Slider de velocidade
PlayerSection:Slider({
    text = "Walk Speed",
    min = 16,
    max = 100,
    float = 1,
    callback = function(value)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
})

-- Slider de altura de pulo
PlayerSection:Slider({
    text = "Jump Power",
    min = 50,
    max = 200,
    float = 1,
    callback = function(value)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end
})

-- Toggle de voo infinito
PlayerSection:Toggle({
    text = "Infinite Jump",
    state = false,
    callback = function(value)
        print("Infinite Jump:", value)
    end
})

-- Keybind para toggle da UI
PlayerSection:Keybind({
    text = "Toggle UI",
    default = Enum.KeyCode.RightControl,
    callback = function(key)
        Library:Toggle()
        print("UI Toggled with key:", key)
    end
})

-- Seção de Teleports
local TeleportSection = MiscTab:Section({
    text = "Teleports",
    icon = "rbxassetid://7734068321"
})

-- Dropdown de locais
TeleportSection:Dropdown({
    text = "Location",
    default = "Spawn",
    list = {"Spawn", "Base", "Arena", "Shop"},
    callback = function(value)
        print("Teleporting to:", value)
    end
})

-- Botão de teleporte
TeleportSection:Button({
    text = "Teleport",
    callback = function()
        print("Teleported!")
    end
})

═══════════════════════════════════════════════════════════════════
    ÍCONES DISPONÍVEIS (Roblox Asset IDs)
═══════════════════════════════════════════════════════════════════

rbxassetid://7733955511  - Logo/Home (Casa)
rbxassetid://7733960981  - Sword/Combat (Espada)
rbxassetid://7733779610  - Target/Aim (Mira)
rbxassetid://7733715400  - Eye/Vision (Olho)
rbxassetid://7733920644  - Settings/Misc (Engrenagem)
rbxassetid://7733954760  - Person/Player (Pessoa)
rbxassetid://7734053426  - Shield/Protection (Escudo)
rbxassetid://7734068321  - Star/Favorite (Estrela)
rbxassetid://7743871002  - Crown (Coroa)
rbxassetid://7733964126  - Lightning (Raio)
rbxassetid://7733919743  - Heart (Coração)
rbxassetid://7733965118  - Lock (Cadeado)

═══════════════════════════════════════════════════════════════════
    RECURSOS DA BIBLIOTECA
═══════════════════════════════════════════════════════════════════

✅ Button - Botões clicáveis com animação
✅ Toggle - Interruptores on/off com animação suave
✅ Slider - Controles deslizantes com entrada de texto
✅ Dropdown - Menus suspensos animados
✅ Textbox - Campos de entrada de texto
✅ Colorpicker - Seletor de cores com visualização hex
✅ Keybind - Configurador de teclas de atalho
✅ Ícones personalizáveis em títulos e seções
✅ Sistema de abas e seções organizadas
✅ Interface arrastável e responsiva
✅ Animações suaves com TweenService
✅ Efeitos visuais em hover e click

═══════════════════════════════════════════════════════════════════
]]
