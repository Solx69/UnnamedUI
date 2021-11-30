local valid_chars = {}

local function set_valid(x, y)
    for i = string.byte(x), string.byte(y) do
        table.insert(valid_chars, string.char(i))
    end
end

local function random_string(length)
    local s = {}

    for i = 1, length do s[i] = valid_chars[math.random(1, #valid_chars)] end

    return table.concat(s)
end

set_valid('a', 'z')
set_valid('A', 'Z')
set_valid('0', '9')

local UnnamedLib = {}
local utility = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local pfp
local user
local tag
local toggle_key
local userinfo = {}

pcall(function()
	userinfo = HttpService:JSONDecode(readfile("AhegaoHubUserInfo.txt"));
end)

pfp = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"
user =  userinfo["user"] or game.Players.LocalPlayer.Name
toggle_key = userinfo["toggle_key"] or "T"

local function SaveInfo()
	userinfo["pfp"] = pfp
	userinfo["user"] = user
	userinfo["tag"] = tag
    userinfo["toggle_key"] = toggle_key
	writefile("AhegaoHubUserInfo.txt", HttpService:JSONEncode(userinfo));
end

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new

function utility:Tween(instance, properties, duration, ...)
	tween:Create(instance, tweeninfo(duration, ...), properties):Play()
end

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		object.Position = pos
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

function UnnamedLib:Window(text)
    local CurrentPage = ""
    local UI_Hidden = false
    local UnnamedUI = Instance.new("ScreenGui")

    UnnamedUI.Name = random_string(20)
    UnnamedUI.Parent = game:GetService("CoreGui")
    UnnamedUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// MainFrame and TopBar

    local MainFrame = Instance.new("Frame")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = UnnamedUI
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
    MainFrame.Position = UDim2.new(0.5, 0, 0.390184075, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ClipsDescendants = true

    local TopBar = Instance.new("Frame")

    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
    TopBar.BackgroundTransparency = 1.000
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0.5, 0, 0.04, 0)
    TopBar.Size = UDim2.new(1, 0, 0.091, 0)
    TopBar.AnchorPoint = Vector2.new(0.5,0.5)

    local Buttons = Instance.new("Folder")

    Buttons.Name = "Buttons"
    Buttons.Parent = TopBar

    local CloseButton = Instance.new("ImageButton")

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Buttons
    CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0.975, 0, 0.5, 0)
    CloseButton.Size = UDim2.new(0.03, 0, 0.63, 0)
    CloseButton.Image = "http://www.roblox.com/asset/?id=6035047409"
    CloseButton.ImageColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.MouseButton1Click:Connect(function ()
        UnnamedUI:Destroy()
    end)
    CloseButton.MouseEnter:Connect(function ()
        CloseButton.ImageColor3 = Color3.fromRGB(255, 0, 0)
        CloseButton.BackgroundTransparency = 0.7
    end)
    CloseButton.MouseLeave:Connect(function ()
        CloseButton.ImageColor3 = Color3.fromRGB(0, 0, 0)
        CloseButton.BackgroundTransparency = 1
    end)

    local Title = Instance.new("TextLabel")

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.13, 0, 0.5, 0)
    Title.Size = UDim2.new(0.232, 0, 0.63, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20.000
    Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    Title.TextStrokeTransparency = 0.300
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local UICorner = Instance.new("UICorner")

    UICorner.Parent = MainFrame

    local UIScale = Instance.new("UIScale")

    UIScale.Parent = MainFrame

    local Pages = Instance.new("Folder")

    Pages.Name = "Pages"
    Pages.Parent = MainFrame

--// Sidebar

    local Sidebar = Instance.new("Frame")

    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(5,5,5)
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0.125, 0, 0.54, 0)
    Sidebar.Size = UDim2.new(0.232, 0, 0.9, 0)
    Sidebar.AnchorPoint = Vector2.new(0.5,0.5)

    local UICorner = Instance.new("UICorner")

    UICorner.Parent = Sidebar
    UICorner.CornerRadius = UDim.new(0,15)

    local PageButtonsContainer = Instance.new("ScrollingFrame")
    local PageButtonsContainerUIPadding = Instance.new("UIPadding")
    local PageButtons = Instance.new("Folder")
    local PageButtonsUIListLayout = Instance.new("UIListLayout")

    PageButtonsContainer.Name = "PageButtonsContainer"
    PageButtonsContainer.Parent = Sidebar
    PageButtonsContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    PageButtonsContainer.BackgroundTransparency = 1.000
    PageButtonsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PageButtonsContainer.Position = UDim2.new(0.0115607399, 0, 0.0218700133, 0)
    PageButtonsContainer.Size = UDim2.new(0, 198, 0, 340)
    PageButtonsContainer.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
    PageButtonsContainer.ScrollBarThickness = 0
    PageButtonsContainer.VerticalScrollBarInset = Enum.ScrollBarInset.Always

    PageButtonsContainerUIPadding.Parent = PageButtonsContainer
    PageButtonsContainerUIPadding.PaddingBottom = UDim.new(0, 10)
    PageButtonsContainerUIPadding.PaddingTop = UDim.new(0, 10)

    PageButtons.Name = "PageButtons"
    PageButtons.Parent = PageButtonsContainer

    PageButtonsUIListLayout.Parent = PageButtons
    PageButtonsUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PageButtonsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageButtonsUIListLayout.Padding = UDim.new(0, 10)
    PageButtonsContainer.PageButtons.ChildAdded:Connect(function ()
        PageButtonsContainer.CanvasSize = UDim2.new(0,0,0,PageButtonsUIListLayout.AbsoluteContentSize.Y + 10)
    end)

    --// Settings

    local SettingsPage = Instance.new("Frame")
    local SettingsUICorner = Instance.new("UICorner")
    local SettingsSection = Instance.new("Frame")
    local SettingsUIListLayout = Instance.new("UIListLayout")
    local SectionUICorner = Instance.new("UICorner")
    local SettingsTitle = Instance.new("TextLabel")

    SettingsPage.Name = "SettingsPage"
    SettingsPage.Parent = Pages
    SettingsPage.AnchorPoint = Vector2.new(0.5, 0.5)
    SettingsPage.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
    SettingsPage.BackgroundTransparency = 1
    SettingsPage.Position = UDim2.new(1.38, 0, 0.537, 0)
    SettingsPage.Size = UDim2.new(0.752,0,0.89,0)
    SettingsPage.Visible = false
    SettingsPage.ClipsDescendants = true

    SettingsUICorner.Parent = SettingsPage

    SettingsSection.Name = "Section"
    SettingsSection.Parent = SettingsPage
    SettingsSection.AnchorPoint = Vector2.new(0.5, 0.5)
    SettingsSection.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SettingsSection.BorderSizePixel = 0
    SettingsSection.BackgroundTransparency = 0
    SettingsSection.Position = UDim2.new(0.5, 0, 0.5, 0)
    SettingsSection.Size = UDim2.new(0.97,0,0.9,0)
    SettingsSection.ClipsDescendants = true

    SettingsUIListLayout.Parent = SettingsSection
    SettingsUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SettingsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsUIListLayout.Padding = UDim.new(0, 10)

    SectionUICorner.Parent = SettingsSection

    SettingsTitle.Name = "Title"
    SettingsTitle.Parent = SettingsSection
    SettingsTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTitle.BackgroundTransparency = 1.000
    SettingsTitle.BorderSizePixel = 0
    SettingsTitle.Position = UDim2.new(0.00317964936, 0, 0, 0)
    SettingsTitle.Size = UDim2.new(0, 625, 0, 50)
    SettingsTitle.Font = Enum.Font.SourceSansBold
    SettingsTitle.Text = "UI Settings"
    SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTitle.TextSize = 25.000
    SettingsTitle.TextStrokeTransparency = 0.400

    local SettingsContainer = Instance.new("Frame")

    SettingsContainer.Name = "SettingsContainer"
    SettingsContainer.Parent = Sidebar
    SettingsContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    SettingsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SettingsContainer.BackgroundTransparency = 1.000
    SettingsContainer.Position = UDim2.new(0.5030725, 0, 0.943609118, 0)
    SettingsContainer.Size = UDim2.new(0, 198, 0, 55)

    local AvatarForeground = Instance.new("ImageLabel")

    AvatarForeground.Name = "AvatarForeground"
    AvatarForeground.Parent = SettingsContainer
    AvatarForeground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AvatarForeground.BackgroundTransparency = 1
    AvatarForeground.BorderColor3 = Color3.fromRGB(27, 42, 53)
    AvatarForeground.AnchorPoint = Vector2.new(0.5,0.5)
    AvatarForeground.Position = UDim2.new(0.11, 0, 0.5, 0)
    AvatarForeground.Size = UDim2.new(0, 40, 0, 40)
    AvatarForeground.Image = "http://www.roblox.com/asset/?id=8001997950"
    AvatarForeground.ImageColor3 = Color3.fromRGB(102, 81, 220)
    AvatarForeground.SliceScale = 0.000
    AvatarForeground.ZIndex = 2

    local UICorner = Instance.new("UICorner")

    UICorner.Parent = AvatarForeground
    UICorner.CornerRadius = UDim.new(0, 50)

    local Avatar = Instance.new("ImageLabel")

    Avatar.Name = "Avatar"
    Avatar.Parent = AvatarForeground
    Avatar.AnchorPoint = Vector2.new(0.5, 0.5)
    Avatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Avatar.BackgroundTransparency = 1.000
    Avatar.BorderSizePixel = 0
    Avatar.AnchorPoint = Vector2.new(0.5,0.5)
    Avatar.Position = UDim2.new(0.5, 0, 0.5, 0)
    Avatar.Size = UDim2.new(0, 30, 0, 30)
    Avatar.Image = pfp
    Avatar.ScaleType = Enum.ScaleType.Slice
    Avatar.SliceCenter = Rect.new(1, 1, 1, 1)

    local UICorner = Instance.new("UICorner")

    UICorner.Parent = Avatar
    UICorner.CornerRadius = UDim.new(0, 50)

    local Name = Instance.new("TextLabel")

    Name.Name = "Name"
    Name.Parent = SettingsContainer
    Name.AnchorPoint = Vector2.new(0.5, 0.5)
    Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Name.BackgroundTransparency = 1.000
    Name.Position = UDim2.new(0.550000012, 0, 0.5, 0)
    Name.Size = UDim2.new(0, 109, 0, 22)
    Name.Font = Enum.Font.SourceSansSemibold
    Name.Text = user
    Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Name.TextScaled = true
    Name.TextSize = 20.000
    Name.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
    Name.TextStrokeTransparency = 0.400
    Name.TextWrapped = true
    Name.TextXAlignment = Enum.TextXAlignment.Left

    local SettingsButton = Instance.new("ImageButton")

    SettingsButton.Name = "SettingsButton"
    SettingsButton.Parent = SettingsContainer
    SettingsButton.AnchorPoint = Vector2.new(0.5, 0.5)
    SettingsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SettingsButton.BackgroundTransparency = 1.000
    SettingsButton.Position = UDim2.new(0.899999976, 0, 0.5, 0)
    SettingsButton.Size = UDim2.new(0, 35, 0, 35)
    SettingsButton.Image = "http://www.roblox.com/asset/?id=7059346373"
    SettingsButton.ImageColor3 = Color3.fromRGB(102, 81, 220)
    SettingsButton.MouseButton1Click:Connect(function ()
        if CurrentPage ~= "" and CurrentPage ~= "SettingsPage" and Pages:FindFirstChild(CurrentPage) then
            utility:Tween(Pages[CurrentPage],{
                Position = UDim2.new(1.38,0,0.537,0)
            },0.2,Enum.EasingStyle.Linear)
            wait(0.2)
            Pages[CurrentPage].Visible = false
        end
        CurrentPage = "SettingsPage"
        SettingsPage.Visible = true
        utility:Tween(SettingsPage,{
            Position = UDim2.new(0.616,0,0.537,0)
        },0.2,Enum.EasingStyle.Linear)
        utility:Tween(SettingsSection,{
            Position = UDim2.new(0.5,0,0.5,0)
        },0.2,Enum.EasingStyle.Linear)
    end)

    local KeybindFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local KeybindButton = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Desc = Instance.new("TextLabel")

    KeybindFrame.Name = "KeybindFrame"
    KeybindFrame.Parent = SettingsSection
    KeybindFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
    KeybindFrame.BackgroundTransparency = 0.3
    KeybindFrame.Size = UDim2.new(0, 598, 0, 50)
    KeybindFrame.AnchorPoint = Vector2.new(0.5,0.5)
    KeybindFrame.Position = UDim2.new(0.5,0,0,0)

    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = KeybindFrame

    KeybindButton.Name = "KeybindButton"
    KeybindButton.Parent = KeybindFrame
    KeybindButton.AnchorPoint = Vector2.new(0.5, 0.5)
    KeybindButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    KeybindButton.Position = UDim2.new(0.850000024, 25, 0.5, 0)
    KeybindButton.Size = UDim2.new(0, 75, 0, 35)
    KeybindButton.Font = Enum.Font.SourceSansBold
    KeybindButton.Text = toggle_key
    KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindButton.TextSize = 18.000
    KeybindButton.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
    KeybindButton.TextStrokeTransparency = 0.750
    KeybindButton.TextWrapped = true

    UICorner_2.CornerRadius = UDim.new(0, 15)
    UICorner_2.Parent = KeybindButton

    Title.Name = "Title"
    Title.Parent = KeybindFrame
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.150000006, 0, 0.5, 0)
    Title.Size = UDim2.new(0.300000012, -25, 1, 0)
    Title.Font = Enum.Font.SourceSansSemibold
    Title.Text = "Toggle UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16.000
    Title.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
    Title.TextStrokeTransparency = 0.750
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Desc.Name = "Desc"
    Desc.Parent = KeybindFrame
    Desc.AnchorPoint = Vector2.new(0.5, 0.5)
    Desc.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Desc.BackgroundTransparency = 1.000
    Desc.Position = UDim2.new(0.5, 0, 0.5, 0)
    Desc.Size = UDim2.new(0.449999988, 0, 0.899999976, 0)
    Desc.Font = Enum.Font.SourceSansItalic
    Desc.Text = "This is a keybind that toggles the UI's visibility"
    Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    Desc.TextSize = 15
    Desc.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
    Desc.TextStrokeTransparency = 0.750
    Desc.TextWrapped = true

    KeybindButton.MouseButton1Click:Connect(function ()
        KeybindButton.Text = "..."
        local inputwait = game:GetService("UserInputService").InputBegan:wait()
        if inputwait.KeyCode.Name ~= "Unknown" then
            KeybindButton.Text = inputwait.KeyCode.Name
            toggle_key = inputwait.KeyCode.Name
            SaveInfo()
        end
    end)
    game:GetService("UserInputService").InputBegan:Connect(function (current,pressed)
        if not pressed then
            if current.KeyCode.Name == toggle_key then
                if UI_Hidden then
                    UI_Hidden = not UI_Hidden
                    MainFrame.Visible = true
                    utility:Tween(MainFrame,{
                        Size = UDim2.new(0, 865, 0, 440)
                    },0.2,Enum.EasingStyle.Linear)
                else
                    UI_Hidden = not UI_Hidden
                    utility:Tween(MainFrame,{
                        Size = UDim2.new(0, 0, 0, 0)
                    },0.2,Enum.EasingStyle.Linear)
                    wait(0.2)
                    MainFrame.Visible = false
                end
            end
        end
    end)

    local PageHolder = {}
    function PageHolder:Page(text)
        local Page = Instance.new("ScrollingFrame")

        Page.Name = text
        Page.Parent = Pages
        Page.AnchorPoint = Vector2.new(0.5, 0.5)
        Page.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
        Page.BackgroundTransparency = 1.000
        Page.BorderSizePixel = 0
        Page.Position = UDim2.new(1.38, 0, 0.537, 0)
        Page.Selectable = false
        Page.Size = UDim2.new(0.752,0,0.89,0)
        Page.Visible = false
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Color3.new(0,0,0)
        Page.ClipsDescendants = true

        local UIListLayout = Instance.new("UIListLayout")

        UIListLayout.Parent = Page
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 10)

        local UIPadding = Instance.new("UIPadding")

        UIPadding.Parent = Page
        UIPadding.PaddingBottom = UDim.new(0, 10)
        UIPadding.PaddingTop = UDim.new(0, 10)

        task.spawn(function ()
            while true do
                if Page.CanvasSize ~= UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 15) then
                    utility:Tween(Page,{
                        CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 15)
                    },0.05,Enum.EasingStyle.Linear)
                end
                wait()
            end
        end)

        local PageButtonFrame = Instance.new("Frame")

        PageButtonFrame.Name = text
        PageButtonFrame.Parent = PageButtons
        PageButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        PageButtonFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
        PageButtonFrame.Position = UDim2.new(0.24494949, 0, 0.0294118542, 0)
        PageButtonFrame.Size = UDim2.new(0, 176, 0, 56)

        local PageButton = Instance.new("TextButton")

        PageButton.Name = "PageButton"
        PageButton.Parent = PageButtonFrame
        PageButton.AnchorPoint = Vector2.new(0.5, 0.5)
        PageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        PageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
        PageButton.Size = UDim2.new(0, 170, 0, 50)
        PageButton.Font = Enum.Font.SourceSans
        PageButton.Text = text
        PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PageButton.TextSize = 16.000
        PageButton.TextStrokeTransparency = 0.750

        PageButton.MouseButton1Click:Connect(function ()
            if CurrentPage ~= "" and CurrentPage ~= text and CurrentPage ~= "SettingsPage" and Pages:FindFirstChild(CurrentPage) then
                PageButtons[CurrentPage].PageButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
                utility:Tween(Pages[CurrentPage],{
                    Position = UDim2.new(1.38, 0, 0.537, 0)
                },0.2,Enum.EasingStyle.Linear)
                wait(0.2)
                Pages[CurrentPage].Visible = false
            elseif CurrentPage == "SettingsPage" then
                utility:Tween(SettingsSection,{
                    Position = UDim2.new(1.38, 0, 0.537, 0)
                },0.2,Enum.EasingStyle.Linear)
                utility:Tween(SettingsPage,{
                    Position = UDim2.new(1.38, 0, 0.537, 0)
                },0.2,Enum.EasingStyle.Linear)
                wait(0.2)
                SettingsPage.Visible = false
            end
            CurrentPage = text
            PageButton.BackgroundColor3 = Color3.fromRGB(102,81,220)
            Pages[CurrentPage].Visible = true
            utility:Tween(Pages[CurrentPage],{
                Position = UDim2.new(0.616, 0, 0.537, 0)
            },0.2,Enum.EasingStyle.Linear)
        end)

        local UICorner = Instance.new("UICorner")

        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = PageButton

        local UICorner = Instance.new("UICorner")

        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = PageButtonFrame

        local SectionHolder = {}
        function SectionHolder:Section(text)
            local Section = Instance.new("Frame")

            Section.Name = text
            Section.Parent = Page
            Section.AnchorPoint = Vector2.new(0.5, 0.5)
            Section.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Section.Position = UDim2.new(0.5, 0, 0.631713569, 0)
            Section.Size = UDim2.new(0.97,0,0,0)
            Section.ClipsDescendants = true
            Section.BackgroundTransparency = 0

            local UIListLayout = Instance.new("UIListLayout")

            UIListLayout.Parent = Section
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 10)

            local UICorner = Instance.new("UICorner")

            UICorner.Parent = Section

            local UIPadding = Instance.new("UIPadding")

            UIPadding.Parent = Section
            UIPadding.PaddingBottom = UDim.new(0, 10)
            UIPadding.PaddingTop = UDim.new(0, 10)

            task.spawn(function ()
                while true do
                    if Section.Size ~= UDim2.new(1,-10,0,UIListLayout.AbsoluteContentSize.Y + 20) then
                        Section.Size = UDim2.new(1,-10,0,UIListLayout.AbsoluteContentSize.Y + 20)
                    end
                    wait()
                end
            end)
            
            local Title = Instance.new("TextLabel")

            Title.Name = text
            Title.Parent = Section
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.00317964936, 0, 0, 0)
            Title.Size = UDim2.new(0, 625, 0, 50)
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 25.000
            Title.TextStrokeTransparency = 0.400

            local SectionContent = {}
            function SectionContent:Toggle(...)
                local options = ...
                options.toggled = options.toggled or false

                local Toggle = Instance.new("TextButton")

                Toggle.Name = "Toggle"
                Toggle.Parent = Section
                Toggle.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                Toggle.BackgroundTransparency = 0.3
                Toggle.Position = UDim2.new(-0.291732907, 0, 0.147928998, 0)
                Toggle.Size = UDim2.new(0, 600, 0, 50)
                Toggle.Font = Enum.Font.SourceSans
                Toggle.Text = ""
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.TextSize = 14.000
                Toggle.TextWrapped = true

                local UICorner = Instance.new("UICorner")

                UICorner.CornerRadius = UDim.new(0,20)
                UICorner.Parent = Toggle

                local Title = Instance.new("TextLabel")

                Title.Name = "Title"
                Title.Parent = Toggle
                Title.AnchorPoint = Vector2.new(0.5,0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.5, 0, 0.5, 0)
                Title.Size = UDim2.new(1, -25, 1, 0)
                Title.Font = Enum.Font.SourceSansSemibold
                Title.Text = options.title or ""
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextSize = 16.000
                Title.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Title.TextStrokeTransparency = 0.750
                Title.TextXAlignment = Enum.TextXAlignment.Left

                if options.desc then
                    local Desc = Instance.new("TextLabel")

                    Desc.Name = "Desc"
                    Desc.Parent = Toggle
                    Desc.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Desc.BackgroundTransparency = 1
                    Desc.AnchorPoint = Vector2.new(0.5,0.5)
                    Desc.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Desc.Size = UDim2.new(0.25, 0, 0.75, 0)
                    Desc.Font = Enum.Font.SourceSansItalic
                    Desc.Text = options.desc
                    Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Desc.TextSize = 15
                    Desc.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                    Desc.TextStrokeTransparency = 0.9
                    Desc.TextWrapped = true
                end

                local DisplayFrame = Instance.new("Frame")
                local Display = Instance.new("ImageLabel")
                local DisplayFrameUICorner = Instance.new("UICorner")

                if options.toggled then
                    DisplayFrame.Name = "DisplayFrame"
                    DisplayFrame.Parent = Toggle
                    DisplayFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    DisplayFrame.AnchorPoint = Vector2.new(0.5,0.5)
                    DisplayFrame.Position = UDim2.new(0.9, 10, 0.5, 0)
                    DisplayFrame.Size = UDim2.new(0, 75, 0, 30)
                    DisplayFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)

                    DisplayFrameUICorner.CornerRadius = UDim.new(0, 15)
                    DisplayFrameUICorner.Parent = DisplayFrame

                    Display.Name = "Display"
                    Display.Parent = DisplayFrame
                    Display.AnchorPoint = Vector2.new(0.5, 0.5)
                    Display.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Display.BackgroundTransparency = 1.000
                    Display.BorderSizePixel = 0
                    Display.Position = UDim2.new(0.75, 0, 0.5, 0)
                    Display.Size = UDim2.new(0, 25, 0, 20)
                    Display.Image = "rbxassetid://1917243547"
                    Display.ImageColor3 = Color3.new(0,0,0)
                else
                    DisplayFrame.Name = "DisplayFrame"
                    DisplayFrame.Parent = Toggle
                    DisplayFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    DisplayFrame.AnchorPoint = Vector2.new(0.5,0.5)
                    DisplayFrame.Position = UDim2.new(0.9, 10, 0.5, 0)
                    DisplayFrame.Size = UDim2.new(0, 75, 0, 30)

                    DisplayFrameUICorner.CornerRadius = UDim.new(0, 15)
                    DisplayFrameUICorner.Parent = DisplayFrame

                    Display.Name = "Display"
                    Display.Parent = DisplayFrame
                    Display.AnchorPoint = Vector2.new(0.5, 0.5)
                    Display.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Display.BackgroundTransparency = 1.000
                    Display.BorderSizePixel = 0
                    Display.Position = UDim2.new(0.25, 0, 0.5, 0)
                    Display.Size = UDim2.new(0, 25, 0, 20)
                    Display.Image = "rbxassetid://1917243547"
                    Display.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end

                Toggle.MouseButton1Click:Connect(function ()
                    options.toggled = not options.toggled
                    pcall(options.callback,options.toggled)
                    if options.toggled then
                        Display.ImageColor3 = Color3.new(0,0,0)
                        DisplayFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                        utility:Tween(Display, {
                            Position = UDim2.new(0.75, 0, 0.5, 0),
                        }, 0.2)
                    else
                        Display.ImageColor3 = Color3.new(255,255,255)
                        DisplayFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        utility:Tween(Display,{
                            Position = UDim2.new(0.25, 0, 0.5, 0),
                        },0.2)
                    end
                end)

                function options:Update(...)
                    for i,v in pairs(...) do
                        options[i] = v
                    end
                    Title.Text = options.title
                    if options.toggled then
                        Display.ImageColor3 = Color3.new(0,0,0)
                        DisplayFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                        utility:Tween(Display, {
                            Position = UDim2.new(0.75, 0, 0.5, 0),
                            Rotation = 180
                        }, 0.2)
                    else
                        Display.ImageColor3 = Color3.new(255,255,255)
                        DisplayFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        utility:Tween(Display,{
                            Position = UDim2.new(0.25, 0, 0.5, 0),
                            Rotation = 0
                        },0.2)
                    end
                end
                return options
            end

            function SectionContent:Keybind(...)
                local options = ...

                local KeybindFrame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local KeybindButton = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")

                KeybindFrame.Name = "KeybindFrame"
                KeybindFrame.Parent = Section
                KeybindFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                KeybindFrame.BackgroundTransparency = 0.3
                KeybindFrame.Size = UDim2.new(0, 600, 0, 50)
                KeybindFrame.AnchorPoint = Vector2.new(0.5,0.5)
                KeybindFrame.Position = UDim2.new(0.5,0,0,0)

                UICorner.CornerRadius = UDim.new(0, 20)
                UICorner.Parent = KeybindFrame

                KeybindButton.Name = "KeybindButton"
                KeybindButton.Parent = KeybindFrame
                KeybindButton.AnchorPoint = Vector2.new(0.5, 0.5)
                KeybindButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                KeybindButton.Position = UDim2.new(0.9, 10, 0.5, 0)
                KeybindButton.Size = UDim2.new(0, 75, 0, 35)
                KeybindButton.Font = Enum.Font.SourceSansBold
                KeybindButton.Text = options.key
                KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindButton.TextSize = 18.000
                KeybindButton.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                KeybindButton.TextStrokeTransparency = 0.750
                KeybindButton.TextWrapped = true

                UICorner_2.CornerRadius = UDim.new(0, 15)
                UICorner_2.Parent = KeybindButton

                Title.Name = "Title"
                Title.Parent = KeybindFrame
                Title.AnchorPoint = Vector2.new(0.5, 0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.Position = UDim2.new(0.150000006, 0, 0.5, 0)
                Title.Size = UDim2.new(0.300000012, -25, 1, 0)
                Title.Font = Enum.Font.SourceSansSemibold
                Title.Text = options.title
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextSize = 16.000
                Title.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Title.TextStrokeTransparency = 0.750
                Title.TextWrapped = true
                Title.TextXAlignment = Enum.TextXAlignment.Left

                if options.desc ~= nil and options.desc ~= "" then
                    Desc.Name = "Desc"
                    Desc.Parent = KeybindFrame
                    Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                    Desc.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                    Desc.BackgroundTransparency = 0.800
                    Desc.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Desc.Size = UDim2.new(0, 238, 0, 35)
                    Desc.Font = Enum.Font.SourceSans
                    Desc.Text = options.desc
                    Desc.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Desc.TextSize = 15
                end

                KeybindButton.MouseButton1Click:Connect(function ()
                    KeybindButton.Text = "..."
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        KeybindButton.Text = inputwait.KeyCode.Name
                        options.key = inputwait.KeyCode.Name
                        SaveInfo()
                    end
                end)
                game:GetService("UserInputService").InputBegan:Connect(function (current,pressed)
                    if not pressed then
                        if current.KeyCode.Name == options.key then
                            pcall(options.callback,options.key)
                        end
                    end
                end)
                function options:Update(...)
                    for i,v in pairs(...) do
                        options[i] = v
                    end
                    Title.Text = options.title
                    KeybindButton.Text = options.key
                end
                return options
            end

            function SectionContent:Dropdown(...)
                local options = ...
                local toggled = options.toggled or false

                local DropdownFrame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextboxFrame = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local Desc = Instance.new("TextLabel")
                local ImageButton = Instance.new("ImageButton")
                local UICorner_3 = Instance.new("UICorner")
                local Dropdown = Instance.new("Frame")
                local UIListLayout = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                --Properties:

                DropdownFrame.Name = "DropdownFrame"
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                DropdownFrame.BackgroundTransparency = 0.3
                DropdownFrame.Size = UDim2.new(0, 600, 0, 50)

                UICorner.CornerRadius = UDim.new(0, 20)
                UICorner.Parent = DropdownFrame

                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = DropdownFrame
                TextboxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextboxFrame.Position = UDim2.new(0, 80, 0, 25)
                TextboxFrame.Size = UDim2.new(0, 150, 0, 35)
                TextboxFrame.ZIndex = 2

                UICorner_2.CornerRadius = UDim.new(0, 20)
                UICorner_2.Parent = TextboxFrame

                TextBox.Parent = TextboxFrame
                TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextBox.BackgroundTransparency = 1.000
                TextBox.Position = UDim2.new(0.51, 0, 0.5, 0)
                TextBox.Size = UDim2.new(0, 140, 0, 30)
                TextBox.Font = Enum.Font.SourceSansSemibold
                TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.Text = options.default or options.title
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 16.000
                TextBox.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                TextBox.TextStrokeTransparency = 0.750
                TextBox.TextWrapped = false
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                TextBox.ClipsDescendants = true
                
                Desc.Name = "Desc"
                Desc.Parent = DropdownFrame
                Desc.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BackgroundTransparency = 1.000
                Desc.Position = UDim2.new(0.301003337, 0, 0, 25)
                Desc.Size = UDim2.new(0, 238, 0, 35)
                Desc.Font = Enum.Font.SourceSansItalic
                Desc.Text = options.desc or ""
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextSize = 15
                Desc.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Desc.TextStrokeTransparency = 0.9
                Desc.TextWrapped = true

                ImageButton.Parent = DropdownFrame
                ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                ImageButton.BackgroundTransparency = 1
                ImageButton.Position = UDim2.new(0.949000001, 0, 0, 25)
                ImageButton.Size = UDim2.new(0, 20, 0, 20)
                ImageButton.Image = "http://www.roblox.com/asset/?id=3192533593"

                UICorner_3.CornerRadius = UDim.new(0, 20)
                UICorner_3.Parent = ImageButton

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = DropdownFrame
                Dropdown.Active = false
                Dropdown.AnchorPoint = Vector2.new(0.5, 0)
                Dropdown.BackgroundColor3 = Color3.fromRGB(40, 28, 84)
                Dropdown.BackgroundTransparency = 1
                Dropdown.BorderSizePixel = 0
                Dropdown.Position = UDim2.new(0.5, 0, 0, 50)
                Dropdown.Size = UDim2.new(0.95, 0, 0, UIListLayout.AbsoluteContentSize.Y)
                Dropdown.Visible = false

                UIListLayout.Parent = Dropdown
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 1)

                UIPadding.Parent = Dropdown
                UIPadding.PaddingBottom = UDim.new(0, 5)
                UIPadding.PaddingTop = UDim.new(0, 5)

                local function Toggle()
                    if toggled then
                        toggled = not toggled
                        ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        Dropdown.Visible = toggled
                        for i,v in pairs(Dropdown:GetChildren()) do
                            if v:IsA("TextButton") then
                                v.Visible = false
                            end
                        end
                        utility:Tween(DropdownFrame,{
                            Size = UDim2.new(0,600,0,50)
                        },0.2)
                        utility:Tween(ImageButton,{
                            Rotation = 0
                        },0.2,Enum.EasingStyle.Linear)
                    else
                        toggled = not toggled
                        ImageButton.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                        Dropdown.Visible = toggled
                        for i,v in pairs(Dropdown:GetChildren()) do
                            if v:IsA("TextButton") then
                                v.Visible = true
                            end
                        end
                        utility:Tween(DropdownFrame,{
                            Size = UDim2.new(0,600,0,60 + UIListLayout.AbsoluteContentSize.Y)
                        },0.2)
                        utility:Tween(ImageButton,{
                            Rotation = 180
                        },0.2,Enum.EasingStyle.Linear)
                    end
                end

                ImageButton.MouseButton1Click:Connect(Toggle)
                local selected = options.default or nil
                local focused = false

                TextBox.Focused:Connect(function ()
                    focused = true
                    if not toggled then
                        Toggle()
                    end
                end)

                TextBox.FocusLost:Connect(function ()
                    focused = false
                    if toggled then
                        TextBox.Text = options.title
                        for i,v in pairs(Dropdown:GetChildren()) do
                            if v:IsA("TextButton") then
                                v.Visible = true
                            end
                        end
                        utility:Tween(DropdownFrame,{
                            Size = UDim2.new(0,600,0,60 + UIListLayout.AbsoluteContentSize.Y)
                        },0.1)
                    end
                end)

                TextBox:GetPropertyChangedSignal("Text"):Connect(function ()
                    if toggled and focused then
                        for i,v in pairs(Dropdown:GetChildren()) do
                            if v:IsA("TextButton") and not string.match(v.Text,TextBox.Text) and TextBox.Text ~= "" then
                                v.Visible = false
                            elseif v:IsA("TextButton") and string.match(v.Text,TextBox.Text) and TextBox.Text ~= "" then
                                v.Visible = true
                            elseif TextBox.Text == "" then
                                if v:IsA("TextButton") then
                                    v.Visible = true
                                end
                            end
                        end
                        utility:Tween(DropdownFrame,{
                            Size = UDim2.new(0,600,0,60 + UIListLayout.AbsoluteContentSize.Y)
                        },0.1)
                    end
                end)

                local function CreateList()
                    for i,item in pairs(options.list) do
                        local TextButton = Instance.new("TextButton")
                        local UICorner = Instance.new("UICorner")

                        TextButton.Parent = Dropdown
                        TextButton.Name = tostring(item)
                        TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        TextButton.Size = UDim2.new(1, 0, 0, 40)
                        TextButton.Font = Enum.Font.SourceSans
                        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        if options.default ~= nil and tostring(item) == options.default then
                            TextButton.TextColor3 = Color3.fromRGB(102, 81, 220)
                        end
                        TextButton.TextSize = 16.000
                        TextButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                        TextButton.TextStrokeTransparency = 0.950
                        TextButton.Text = tostring(item)
                        TextButton.Font = Enum.Font.SourceSansSemibold

                        UICorner.CornerRadius = UDim.new(0, 15)
                        UICorner.Parent = TextButton

                        TextButton.MouseButton1Click:Connect(function ()
                            Toggle()
                            TextBox.Text = tostring(item)
                            if selected ~= nil then
                                Dropdown[selected].TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                            selected = tostring(item)
                            TextButton.TextColor3 = Color3.fromRGB(102, 81, 220)
                            pcall(options.callback,tostring(item))
                        end)
                    end
                end
                CreateList()
                Dropdown.Size = UDim2.new(0.95, 0, 0, UIListLayout.AbsoluteContentSize.Y)

                function options:Clear()
                    for i,v in pairs(Dropdown) do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                end

                function options:Add(text)
                    local TextButton = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")

                    TextButton.Parent = Dropdown
                    TextButton.Name = text
                    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    TextButton.Size = UDim2.new(1, 0, 0, 40)
                    TextButton.Font = Enum.Font.SourceSans
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.TextSize = 16.000
                    TextButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.TextStrokeTransparency = 0.950
                    TextButton.Text = tostring(text)
                    TextButton.Font = Enum.Font.SourceSansSemibold

                    UICorner.CornerRadius = UDim.new(0, 15)
                    UICorner.Parent = TextButton

                    TextButton.MouseButton1Click:Connect(function ()
                        Toggle()
                        TextBox.Text = text
                        if selected ~= nil then
                            Dropdown[selected].TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                        selected = text
                        TextButton.TextColor3 = Color3.fromRGB(102, 81, 220)
                        pcall(options.callback,text)
                    end)
                end

                function options:Update(...)
                    local aOptions = ...
                    for i,v in pairs(...) do
                        options[i] = v
                    end
                    TextBox.Text = options.title
                    if aOptions.list then
                        options:Clear()
                        CreateList()
                    end
                end
                return options
            end

            function SectionContent:Slider(...)
                local options = ...

                options.value = options.default or options.min

                local SliderFrame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Slider = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local ValueFrame = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local SliderDragger = Instance.new("ImageButton")
                local UICorner_4 = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local UICorner_5 = Instance.new("UICorner")

                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = Section
                SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                SliderFrame.BackgroundTransparency = 0.3
                SliderFrame.Size = UDim2.new(0, 600, 0, 50)

                UICorner.CornerRadius = UDim.new(0, 20)
                UICorner.Parent = SliderFrame

                Title.Name = "Title"
                Title.Parent = SliderFrame
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.0250836015, 0, 0.140000001, 0)
                Title.Size = UDim2.new(0, 130, 0, 35)
                Title.Font = Enum.Font.SourceSansSemibold
                Title.Text = options.title
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextSize = 16.000
                Title.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Title.TextStrokeTransparency = 0.750
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Slider.Name = "Slider"
                Slider.Parent = SliderFrame
                Slider.AnchorPoint = Vector2.new(0.5, 0.5)
                Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Slider.Position = UDim2.new(0.5, 0, 0.5, 0)
                Slider.Size = UDim2.new(0, 300, 0, 7)

                UICorner_2.CornerRadius = UDim.new(0, 50)
                UICorner_2.Parent = Slider

                ValueFrame.Name = "ValueFrame"
                ValueFrame.Parent = Slider
                ValueFrame.AnchorPoint = Vector2.new(0, 0.5)
                ValueFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                ValueFrame.Position = UDim2.new(0, 1, 0.5, 0)
                ValueFrame.Size = UDim2.new((options.value - options.min) / (options.max - options.min), 0, 0, 5)

                UICorner_3.CornerRadius = UDim.new(0, 50)
                UICorner_3.Parent = ValueFrame

                SliderDragger.Parent = ValueFrame
                SliderDragger.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderDragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderDragger.Position = UDim2.new(1, 0, 0.5, 0)
                SliderDragger.Size = UDim2.new(0, 5, 0, 10)
                SliderDragger.Image = ""

                function options:Change(value)
                    if value <= options.max and value >= options.min then
                        options.value = value
                        local percent = (options.value - options.min) / (options.max - options.min)
                        ValueFrame.Size = UDim2.new(percent,0,0,5)
                        TextBox.Text = tostring(options.value)
                        pcall(options.callback,options.value)
                    else
                        TextBox.Text = "error!"
                        wait(0.5)
                        TextBox.Text = tostring(options.value)
                    end
                end

                TextBox.FocusLost:Connect(function ()
                    if TextBox.Text == "" then
                        options:Change(tonumber(options.value))
                    else
                        options:Change(tonumber(TextBox.Text))
                    end
                end)

                local dragging = false

                SliderDragger.MouseButton1Down:Connect(function ()
                    dragging = true
                end)

                game:GetService("UserInputService").InputEnded:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
                        pcall(options.callback,options.value)
					end
				end)

                local function move(input)
                    if input and input.Position ~= nil then
                        local percent = (input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
                        percent = math.clamp(percent, 0, 1)
                        options.value = math.floor(options.min + (options.max - options.min) * percent)

                        ValueFrame.Size = UDim2.new(percent,0,0,5)

                        TextBox.Text = tostring(options.value)
                    end
				end

                game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)

                UICorner_4.CornerRadius = UDim.new(0, 50)
                UICorner_4.Parent = SliderDragger

                TextBox.Parent = Slider
                TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(1.365, 0, 0.5, 0)
                TextBox.Size = UDim2.new(0, 50, 0, 30)
                TextBox.Font = Enum.Font.SourceSans
                TextBox.Text = tostring(options.value)
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 14.000
                TextBox.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                TextBox.TextStrokeTransparency = 0.600

                UICorner_5.CornerRadius = UDim.new(0, 15)
                UICorner_5.Parent = TextBox
                return options
            end

            function SectionContent:Textbox(...)
                local options = ...

                local TextboxFrame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local TextBox = Instance.new("TextBox")
                local UICorner_2 = Instance.new("UICorner")

                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = Section
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                TextboxFrame.BackgroundTransparency = 0.3
                TextboxFrame.Size = UDim2.new(0, 600, 0, 50)

                UICorner.CornerRadius = UDim.new(0, 20)
                UICorner.Parent = TextboxFrame

                Title.Name = "Title"
                Title.Parent = TextboxFrame
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.0250836015, 0, 0.140000001, 0)
                Title.Size = UDim2.new(0, 128, 0, 35)
                Title.Font = Enum.Font.SourceSansSemibold
                Title.Text = options.title or ""
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextSize = 16.000
                Title.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Title.TextStrokeTransparency = 0.750
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = TextboxFrame
                Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                Desc.BackgroundTransparency = 1.000
                Desc.ClipsDescendants = true
                Desc.Position = UDim2.new(0.5, 0, 0.5, 0)
                Desc.Size = UDim2.new(0, 238, 0, 35)
                Desc.Font = Enum.Font.SourceSansItalic
                Desc.Text = options.desc or ""
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextSize = 15
                Desc.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Desc.TextStrokeTransparency = 0.9
                Desc.TextWrapped = true

                TextBox.Parent = TextboxFrame
                TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextBox.Position = UDim2.new(0.850000024, 0, 0.5, 0)
                TextBox.Size = UDim2.new(0, 150, 0, 30)
                TextBox.Font = Enum.Font.SourceSans
                TextBox.Text = options.default or ""
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 14.000
                TextBox.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                TextBox.TextStrokeTransparency = 0.650
                TextBox.TextWrapped = true

                TextBox.FocusLost:Connect(function ()
                    if TextBox.Text ~= "" then
                        pcall(options.callback,TextBox.Text)
                        TextBox.TextColor3 = Color3.fromRGB(102, 81, 220)
                        wait(0.1)
                        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end)

                UICorner_2.CornerRadius = UDim.new(0, 15)
                UICorner_2.Parent = TextBox
                return options
            end

            function SectionContent:Checklist(...)
                local options = ...
                local toggled = options.toggled or false

                local ChecklistFrame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextboxFrame = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local Desc = Instance.new("TextLabel")
                local ImageButton = Instance.new("ImageButton")
                local UICorner_3 = Instance.new("UICorner")
                local Checklist = Instance.new("Frame")
                local UIListLayout = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                ChecklistFrame.Name = "ChecklistFrame"
                ChecklistFrame.Parent = Section
                ChecklistFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                ChecklistFrame.BackgroundTransparency = 0.3
                ChecklistFrame.Size = UDim2.new(0, 600, 0, 50)

                UICorner.CornerRadius = UDim.new(0, 20)
                UICorner.Parent = ChecklistFrame

                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = ChecklistFrame
                TextboxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextboxFrame.Position = UDim2.new(0, 80, 0, 25)
                TextboxFrame.Size = UDim2.new(0, 150, 0, 35)
                TextboxFrame.ZIndex = 2

                UICorner_2.CornerRadius = UDim.new(0, 20)
                UICorner_2.Parent = TextboxFrame

                TextBox.Parent = TextboxFrame
                TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextBox.BackgroundTransparency = 1.000
                TextBox.Position = UDim2.new(0.51, 0, 0.5, 0)
                TextBox.Size = UDim2.new(0, 140, 0, 30)
                TextBox.Font = Enum.Font.SourceSansSemibold
                TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.Text = options.default or options.title
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 16.000
                TextBox.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                TextBox.TextStrokeTransparency = 0.750
                TextBox.TextWrapped = false
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                TextBox.ClipsDescendants = true
                
                Desc.Name = "Desc"
                Desc.Parent = ChecklistFrame
                Desc.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BackgroundTransparency = 1.000
                Desc.Position = UDim2.new(0.301003337, 0, 0, 25)
                Desc.Size = UDim2.new(0, 238, 0, 35)
                Desc.Font = Enum.Font.SourceSansItalic
                Desc.Text = options.desc or ""
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextSize = 15
                Desc.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Desc.TextStrokeTransparency = 0.9
                Desc.TextWrapped = true

                ImageButton.Parent = ChecklistFrame
                ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                ImageButton.BackgroundTransparency = 1
                ImageButton.Position = UDim2.new(0.949000001, 0, 0, 25)
                ImageButton.Size = UDim2.new(0, 20, 0, 20)
                ImageButton.Image = "http://www.roblox.com/asset/?id=3192533593"

                UICorner_3.CornerRadius = UDim.new(0, 20)
                UICorner_3.Parent = ImageButton

                Checklist.Name = "Checklist"
                Checklist.Parent = ChecklistFrame
                Checklist.Active = false
                Checklist.AnchorPoint = Vector2.new(0.5, 0)
                Checklist.BackgroundColor3 = Color3.fromRGB(40, 28, 84)
                Checklist.BackgroundTransparency = 1
                Checklist.BorderSizePixel = 0
                Checklist.Position = UDim2.new(0.5, 0, 0, 50)
                Checklist.Size = UDim2.new(0.95, 0, 0, UIListLayout.AbsoluteContentSize.Y)
                Checklist.Visible = false

                UIListLayout.Parent = Checklist
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 1)

                UIPadding.Parent = Checklist
                UIPadding.PaddingBottom = UDim.new(0, 5)
                UIPadding.PaddingTop = UDim.new(0, 5)

                local function Toggle()
                    if toggled then
                        toggled = not toggled
                        ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        Checklist.Visible = toggled
                        for i,v in pairs(Checklist:GetChildren()) do
                            if v:IsA("TextButton") then
                                v.Visible = false
                            end
                        end
                        utility:Tween(ChecklistFrame,{
                            Size = UDim2.new(0,600,0,50)
                        },0.2)
                        utility:Tween(ImageButton,{
                            Rotation = 0
                        },0.2,Enum.EasingStyle.Linear)
                    else
                        toggled = not toggled
                        ImageButton.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                        Checklist.Visible = toggled
                        for i,v in pairs(Checklist:GetChildren()) do
                            if v:IsA("TextButton") then
                                v.Visible = true
                            end
                        end
                        utility:Tween(ChecklistFrame,{
                            Size = UDim2.new(0,600,0,60 + UIListLayout.AbsoluteContentSize.Y)
                        },0.2)
                        utility:Tween(ImageButton,{
                            Rotation = 180
                        },0.2,Enum.EasingStyle.Linear)
                    end
                end

                ImageButton.MouseButton1Click:Connect(Toggle)
                local focused = false

                TextBox.Focused:Connect(function ()
                    focused = true
                    if not toggled then
                        Toggle()
                    end
                end)

                TextBox.FocusLost:Connect(function ()
                    focused = false
                    if toggled then
                        TextBox.Text = options.title
                        for i,v in pairs(Checklist:GetChildren()) do
                            if v:IsA("TextButton") then
                                v.Visible = true
                            end
                        end
                        utility:Tween(ChecklistFrame,{
                            Size = UDim2.new(0,600,0,60 + UIListLayout.AbsoluteContentSize.Y)
                        },0.1)
                    end
                end)

                TextBox:GetPropertyChangedSignal("Text"):Connect(function ()
                    if toggled and focused then
                        for i,v in pairs(Checklist:GetChildren()) do
                            if v:IsA("TextButton") and not string.match(v.Text,TextBox.Text) and TextBox.Text ~= "" then
                                v.Visible = false
                            elseif v:IsA("TextButton") and string.match(v.Text,TextBox.Text) and TextBox.Text ~= "" then
                                v.Visible = true
                            elseif TextBox.Text == "" then
                                if v:IsA("TextButton") then
                                    v.Visible = true
                                end
                            end
                        end
                        utility:Tween(ChecklistFrame,{
                            Size = UDim2.new(0,600,0,60 + UIListLayout.AbsoluteContentSize.Y)
                        },0.1)
                    end
                end)

                local function CreateList()
                    for i,item in pairs(options.list) do
                        local TextButton = Instance.new("TextButton")
                        local UICorner = Instance.new("UICorner")
                        local BooleanValue = Instance.new("BoolValue")

                        TextButton.Parent = Checklist
                        TextButton.Name = tostring(item)
                        TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        TextButton.Size = UDim2.new(1, 0, 0, 40)
                        TextButton.Font = Enum.Font.SourceSans
                        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextButton.TextSize = 16.000
                        TextButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                        TextButton.TextStrokeTransparency = 0.950
                        TextButton.Text = tostring(item)
                        TextButton.Font = Enum.Font.SourceSansSemibold

                        UICorner.CornerRadius = UDim.new(0, 15)
                        UICorner.Parent = TextButton

                        BooleanValue.Parent = TextButton
                        BooleanValue.Name = "Value"
                        if table.find(options.whitelist,tostring(item)) then
                            BooleanValue.Value = true
                            TextButton.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        else
                            BooleanValue.Value = false
                        end

                        TextButton.MouseButton1Click:Connect(function ()
                            BooleanValue.Value = not BooleanValue.Value
                            if BooleanValue.Value then
                                if not table.find(options.whitelist,tostring(item)) then
                                    table.insert(options.whitelist,tostring(item))
                                end
                                TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                                TextButton.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                            else
                                if table.find(options.whitelist,tostring(item)) then
                                    local num = table.find(options.whitelist,tostring(item))
                                    table.remove(options.whitelist,num)
                                end
                                TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            end
                            pcall(options.callback,tostring(item),BooleanValue.Value)
                        end)
                    end
                end
                CreateList()
                Checklist.Size = UDim2.new(0.95, 0, 0, UIListLayout.AbsoluteContentSize.Y)

                function options:Clear()
                    for i,v in pairs(Checklist) do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                end

                function options:Add(text)
                    local TextButton = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")
                    local BooleanValue = Instance.new("BoolValue")

                    TextButton.Parent = Checklist
                    TextButton.Name = tostring(text)
                    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    TextButton.Size = UDim2.new(1, 0, 0, 40)
                    TextButton.Font = Enum.Font.SourceSans
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.TextSize = 16.000
                    TextButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.TextStrokeTransparency = 0.950
                    TextButton.Text = tostring(text)
                    TextButton.Font = Enum.Font.SourceSansSemibold

                    UICorner.CornerRadius = UDim.new(0, 15)
                    UICorner.Parent = TextButton

                    BooleanValue.Parent = TextButton
                    BooleanValue.Name = "Value"
                    if table.find(options.whitelist,tostring(text)) then
                        BooleanValue.Value = true
                        TextButton.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                        TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    else
                        BooleanValue.Value = false
                    end

                    TextButton.MouseButton1Click:Connect(function ()
                        BooleanValue.Value = not BooleanValue.Value
                        if BooleanValue.Value then
                            if not table.find(options.whitelist,tostring(text)) then
                                table.insert(options.whitelist,tostring(text))
                            end
                            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                            TextButton.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                        else
                            if table.find(options.whitelist,tostring(text)) then
                                local num = table.find(options.whitelist,tostring(text))
                                table.remove(options.whitelist,num)
                            end
                            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                            TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        end
                        pcall(options.callback,tostring(text),BooleanValue.Value)
                    end)
                end

                function options:Update(...)
                    local aOptions = ...
                    for i,v in pairs(...) do
                        options[i] = v
                    end
                    TextBox.Text = options.title
                    if aOptions.list then
                        options:Clear()
                        CreateList()
                    end
                end
                return options
            end

            function SectionContent:Button(...)
                local options = ...

                local Button = Instance.new("TextButton")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                Button.Name = "Button"
                Button.Parent = Section
                Button.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                Button.BackgroundTransparency = 0.3
                Button.Position = UDim2.new(-0.291732907, 0, 0.147928998, 0)
                Button.Size = UDim2.new(0, 600, 0, 50)
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14.000
                Button.TextWrapped = true

                Button.MouseButton1Click:Connect(function ()
                    pcall(options.callback)
                end)

                Title.Name = "Title"
                Title.Parent = Button
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.0250836015, 0, 0.140000001, 0)
                Title.Size = UDim2.new(0, 128, 0, 35)
                Title.Font = Enum.Font.SourceSansSemibold
                Title.Text = options.title
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextSize = 16.000
                Title.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Title.TextStrokeTransparency = 0.750
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = Button
                Desc.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
                Desc.BackgroundTransparency = 1.000
                Desc.Position = UDim2.new(0.301003337, 0, 0.140000001, 0)
                Desc.Size = UDim2.new(0, 238, 0, 35)
                Desc.Font = Enum.Font.SourceSansItalic
                Desc.Text = options.desc or ""
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextSize = 15
                Desc.TextStrokeColor3 = Color3.fromRGB(102, 81, 220)
                Desc.TextStrokeTransparency = 0.9
                Desc.TextWrapped = true

                UICorner.CornerRadius = UDim.new(0, 20)
                UICorner.Parent = Button
                return options
            end
            return SectionContent
        end
        return SectionHolder
    end
    function PageHolder:SetPage(text)
        if CurrentPage ~= "" and Pages:FindFirstChild(CurrentPage) then
            PageButtons[CurrentPage].PageButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
            utility:Tween(Pages[CurrentPage],{
                Position = UDim2.new(1.38, 0, 0.537, 0)
            },0.2,Enum.EasingStyle.Linear)
            wait(0.2)
            Pages[CurrentPage].Visible = false
        end
        CurrentPage = text
        if Pages:FindFirstChild(CurrentPage) then
            Pages[CurrentPage].Visible = true
            PageButtons[CurrentPage].PageButton.BackgroundColor3 = Color3.fromRGB(102,81,220)
            utility:Tween(Pages[CurrentPage],{
                Position = UDim2.new(0.616, 0, 0.537, 0)
            },0.2,Enum.EasingStyle.Linear)
        else
            repeat wait() until Pages:FindFirstChild(CurrentPage)
            PageButtons[CurrentPage].PageButton.BackgroundColor3 = Color3.fromRGB(102,81,220)
            Pages[CurrentPage].Visible = true
            utility:Tween(Pages[CurrentPage],{
                Position = UDim2.new(0.616, 0, 0.537, 0)
            },0.2,Enum.EasingStyle.Linear)
        end
    end
    MakeDraggable(TopBar, MainFrame)
    utility:Tween(MainFrame,{
        Size = UDim2.new(0, 865, 0, 440)
    },0.2,Enum.EasingStyle.Linear)
    return PageHolder
end
function UnnamedLib:Notify(text,callback)
    local Notification = Instance.new("ScreenGui")
    local OuterFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local InnerFrame = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local title = Instance.new("TextLabel")
    local ButtonFrame = Instance.new("Frame")
    local X = Instance.new("ImageButton")
    local Check = Instance.new("ImageButton")
    local UICorner_3 = Instance.new("UICorner")
    local desc = Instance.new("TextLabel")

    Notification.Name = random_string(5)
    Notification.Parent = game:GetService("CoreGui")
    Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    OuterFrame.Name = "OuterFrame"
    OuterFrame.Parent = Notification
    OuterFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    OuterFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OuterFrame.Position = UDim2.new(0.5, 0, 0, 0)
    OuterFrame.Size = UDim2.new(0, 500, 0, 100)
    OuterFrame.Visible = true

    UICorner.Parent = OuterFrame

    InnerFrame.Name = "InnerFrame"
    InnerFrame.Parent = OuterFrame
    InnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    InnerFrame.BackgroundColor3 = Color3.fromRGB(102, 81, 220)
    InnerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    InnerFrame.Size = UDim2.new(0, 490, 0, 90)

    UICorner_2.Parent = InnerFrame

    title.Name = "title"
    title.Parent = InnerFrame
    title.AnchorPoint = Vector2.new(0.5, 0.5)
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1.000
    title.ClipsDescendants = true
    title.Position = UDim2.new(0.5, 0, 0.150000006, 0)
    title.Size = UDim2.new(0.5, 0, 0.200000003, 0)
    title.Font = Enum.Font.SourceSans
    title.Text = "Ahegao Hub Notification"
    title.TextColor3 = Color3.fromRGB(0, 0, 0)
    title.TextSize = 16.000
    title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    title.TextStrokeTransparency = 0.950
    title.TextWrapped = true

    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.Parent = InnerFrame
    ButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ButtonFrame.Position = UDim2.new(0.899999976, 0, 0.5, 0)
    ButtonFrame.Size = UDim2.new(0.100000001, 0, 0.75, 0)

    X.Name = "X"
    X.Parent = ButtonFrame
    X.AnchorPoint = Vector2.new(0.5, 0.5)
    X.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    X.BackgroundTransparency = 1.000
    X.Position = UDim2.new(0.5, 0, 0.699999988, 0)
    X.Size = UDim2.new(0.300000012, 0, 0.300000012, 0)
    X.SizeConstraint = Enum.SizeConstraint.RelativeYY
    X.Image = "http://www.roblox.com/asset/?id=4458805208"

    X.MouseEnter:Connect(function ()
        X.ImageColor3 = Color3.new(255,0,0)
    end)

    X.MouseLeave:Connect(function ()
        X.ImageColor3 = Color3.new(255,255,255)
    end)

    X.MouseButton1Click:Connect(function ()
        local bool = false
        pcall(callback,bool)
        Notification:Destroy()
    end)

    Check.Name = "Check"
    Check.Parent = ButtonFrame
    Check.AnchorPoint = Vector2.new(0.5, 0.5)
    Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Check.BackgroundTransparency = 1.000
    Check.Position = UDim2.new(0.5, 0, 0.300000012, 0)
    Check.Size = UDim2.new(0.300000012, 0, 0.300000012, 0)
    Check.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Check.Image = "http://www.roblox.com/asset/?id=6972569034"

    Check.MouseButton1Click:Connect(function ()
        local bool = true
        pcall(callback,bool)
        Notification:Destroy()
    end)

    Check.MouseEnter:Connect(function ()
        Check.ImageColor3 = Color3.new(0,255,0)
    end)

    Check.MouseLeave:Connect(function ()
        Check.ImageColor3 = Color3.new(255,255,255)
    end)

    UICorner_3.Parent = ButtonFrame

    desc.Name = "desc"
    desc.Parent = InnerFrame
    desc.AnchorPoint = Vector2.new(0.5, 0.5)
    desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    desc.BackgroundTransparency = 1.000
    desc.Position = UDim2.new(0.5, 0, 0.600000024, 0)
    desc.Size = UDim2.new(0.649999976, 0, 0.649999976, 0)
    desc.Font = Enum.Font.SourceSans
    desc.Text = text
    desc.TextColor3 = Color3.fromRGB(0, 0, 0)
    desc.TextSize = 14.000
    desc.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    desc.TextStrokeTransparency = 0.950
    desc.TextWrapped = true

    utility:Tween(OuterFrame,{
        Position = UDim2.new(0.5,0,0.5,0)
    },0.2,Enum.EasingStyle.Linear)
end
return UnnamedLib
