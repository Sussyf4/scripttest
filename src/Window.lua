--// Window and Tab Logic ------------------------------------------------------

function NovaLib:CreateWindow(options)
	options = options or {}
	local windowTitle = options.Title or "NovaLib"
	local windowSize = options.Size or UDim2.new(0, 600, 0, 420)
	local themeName = options.Theme or "Black"
	local toggleKey = options.ToggleKey or Enum.KeyCode.RightControl
	local showIntro = options.Intro ~= false

	if NovaLib.Themes[themeName] then
		Theme = NovaLib.Themes[themeName]
	end

	if showIntro then
		PlayIntro(windowTitle, options.IntroText or "Loading interface...")
	end

	local Window = {}
	Window.Tabs = {}
	Window.ActiveTab = nil
	Window.Minimized = false
	Window.Callbacks = {} -- flag -> setter, used for config loading
	Window.Connections = {} -- disconnected on Destroy

	--// Root ScreenGui
	local screenGui = Create("ScreenGui", {
		Name = "NovaLib_" .. HttpService:GenerateGUID(false):sub(1, 8),
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(screenGui)
	Window.Gui = screenGui

	-- CanvasGroup main window container
	local main = Create("CanvasGroup", {
		Name = "Main",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 8),
		Size = windowSize,
		BackgroundColor3 = Theme.Background,
		BackgroundTransparency = 0,
		GroupTransparency = 1,
		Parent = screenGui,
	})
	Round(main, 12)
	local mainStroke = Stroke(main, Theme.StrokeLight, 1, 0.25)

	-- Fake drop shadow
	main.ZIndex = 2
	local windowShadow = Shadow(main, 12, 1)
	windowShadow.ZIndex = 1
	table.insert(Window.Connections, main:GetPropertyChangedSignal("Position"):Connect(function()
		windowShadow.Position = main.Position + UDim2.new(0, 3, 0, 3)
	end))
	table.insert(Window.Connections, main:GetPropertyChangedSignal("Size"):Connect(function()
		windowShadow.Size = main.Size
	end))

	-- Open transition
	Tween(main, {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		GroupTransparency = 0,
	}, 0.4, Enum.EasingStyle.Quint)
	Tween(windowShadow, { BackgroundTransparency = 0.8 }, 0.45)

	--// Top Bar
	local topBar = Create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = Theme.Secondary,
		Parent = main,
	})
	Round(topBar, 12)
	Sheen(topBar, 0.05)
	-- square off bottom
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.new(0, 0, 1, -12),
		BackgroundColor3 = Theme.Secondary,
		BorderSizePixel = 0,
		Parent = topBar,
	})
	-- hairline
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Theme.Stroke,
		BorderSizePixel = 0,
		Parent = topBar,
	})

	local titleHolder = Create("Frame", {
		Size = UDim2.new(1, -110, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		Parent = topBar,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
		}),
	})

	Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Bold,
		Text = windowTitle,
		TextColor3 = Theme.Text,
		TextSize = 16, -- Title text size 16
		LayoutOrder = 1,
		Parent = titleHolder,
	})

	-- Window control buttons (Close / Minimize) using Lucide assets
	local function WindowButton(iconName, xOffset)
		local btn = Create("TextButton", {
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(1, xOffset, 0.5, -14),
			BackgroundColor3 = Theme.Tertiary,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			Parent = topBar,
		})
		Round(btn, 7)

		local icon = CreateIcon(btn, iconName, Theme.SubText, 14)
		if icon then
			icon.AnchorPoint = Vector2.new(0.5, 0.5)
			icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		end

		btn.MouseEnter:Connect(function()
			Tween(btn, { BackgroundTransparency = 0 }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.Text }, 0.15)
			end
		end)
		btn.MouseLeave:Connect(function()
			Tween(btn, { BackgroundTransparency = 1 }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.SubText }, 0.15)
			end
		end)
		return btn
	end

	local closeBtn = WindowButton("x", -38)
	local minBtn = WindowButton("minus", -70)

	closeBtn.MouseButton1Click:Connect(function()
		Tween(main, {
			Position = main.Position + UDim2.new(0, 0, 0, 8),
			GroupTransparency = 1,
		}, 0.3, Enum.EasingStyle.Quint)
		Tween(windowShadow, { BackgroundTransparency = 1 }, 0.3)
		task.wait(0.35)
		Window:Destroy()
	end)

	local storedSize = windowSize
	minBtn.MouseButton1Click:Connect(function()
		Window.Minimized = not Window.Minimized
		if Window.Minimized then
			storedSize = main.Size
			Tween(main, { Size = UDim2.new(0, storedSize.X.Offset, 0, 44) }, 0.35)
		else
			Tween(main, { Size = storedSize }, 0.35, Enum.EasingStyle.Back)
		end
	end)

	MakeDraggable(topBar, main, Window.Connections)

	table.insert(Window.Connections, UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == toggleKey then
			screenGui.Enabled = not screenGui.Enabled
		end
	end))

	--// Tab Sidebar
	local sidebar = Create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 152, 1, -55),
		Position = UDim2.new(0, 10, 0, 51),
		BackgroundColor3 = Theme.Secondary,
		Parent = main,
	})
	Round(sidebar, 10)
	Stroke(sidebar, Theme.Stroke, 1, 0.5)
	Sheen(sidebar, 0.03)

	local tabList = Create("ScrollingFrame", {
		Size = UDim2.new(1, -10, 1, -10),
		Position = UDim2.new(0, 5, 0, 5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageTransparency = 0.5,
		ScrollBarImageColor3 = Theme.StrokeLight,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Parent = sidebar,
	}, {
		Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		}),
	})

	--// Content Area
	local content = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -182, 1, -55),
		Position = UDim2.new(0, 172, 0, 51),
		BackgroundTransparency = 1,
		Parent = main,
	})

	--// Tab API
	function Window:CreateTab(tabOptions)
		tabOptions = tabOptions or {}
		local tabName = tabOptions.Name or "Tab"

		local TabObj = setmetatable({}, Tab)
		TabObj.Name = tabName
		TabObj.Window = Window

		local tabButton = Create("TextButton", {
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = Theme.Tertiary,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			Parent = tabList,
		})
		Round(tabButton, 8)

		local indicator = Create("Frame", {
			Size = UDim2.new(0, 3, 0, 0),
			Position = UDim2.new(0, 3, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Theme.Accent,
			Parent = tabButton,
		})
		Round(indicator, 2)

		-- Optional customizable tab icon from Lucide
		local tabIconId = tabOptions.Icon and NovaLib:GetIcon(tabOptions.Icon) or nil
		local tabLabelOffset = 14
		local tabIconImg
		if tabIconId then
			tabLabelOffset = 36
			tabIconImg = Create("ImageLabel", {
				Name = "TabIcon",
				Size = UDim2.new(0, 16, 0, 16),
				Position = UDim2.new(0, 14, 0.5, -8),
				BackgroundTransparency = 1,
				Image = tabIconId,
				ImageColor3 = Theme.SubText,
				Parent = tabButton,
			})
		end

		local tabLabel = Create("TextLabel", {
			Size = UDim2.new(1, -tabLabelOffset - 10, 1, 0),
			Position = UDim2.new(0, tabLabelOffset, 0, 0),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Medium,
			Text = tabName,
			TextColor3 = Theme.SubText,
			TextSize = 14, -- Tab text size 14
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = tabButton,
		})

		local page = Create("ScrollingFrame", {
			Name = tabName,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 4,
			ScrollBarImageTransparency = 0.5,
			ScrollBarImageColor3 = Theme.StrokeLight,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			Visible = false,
			Parent = content,
		}, {
			Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			}),
			Create("UIPadding", {
				PaddingRight = UDim.new(0, 6),
				PaddingBottom = UDim.new(0, 6),
			}),
		})

		local function Activate()
			for _, other in ipairs(Window.Tabs) do
				other.Page.Visible = false
				other.Button.BackgroundTransparency = 1
				Tween(other.Label, { TextColor3 = Theme.SubText }, 0.2)
				Tween(other.Indicator, { Size = UDim2.new(0, 3, 0, 0) }, 0.2)
				if other.IconImage then
					Tween(other.IconImage, { ImageColor3 = Theme.SubText }, 0.2)
				end
			end
			page.Visible = true
			Window.ActiveTab = TabObj
			tabButton.BackgroundTransparency = 0
			Tween(tabLabel, { TextColor3 = Theme.Text }, 0.2)
			Tween(indicator, { Size = UDim2.new(0, 3, 1, -10) }, 0.25)
			if tabIconImg then
				Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.25)
			end
		end

		tabButton.MouseButton1Click:Connect(Activate)
		tabButton.MouseEnter:Connect(function()
			if Window.ActiveTab ~= TabObj then
				Tween(tabLabel, { TextColor3 = Theme.Text }, 0.15)
				if tabIconImg then
					Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.15)
				end
			end
		end)
		tabButton.MouseLeave:Connect(function()
			if Window.ActiveTab ~= TabObj then
				Tween(tabLabel, { TextColor3 = Theme.SubText }, 0.15)
				if tabIconImg then
					Tween(tabIconImg, { ImageColor3 = Theme.SubText }, 0.15)
				end
			end
		end)

		TabObj.Button = tabButton
		TabObj.Label = tabLabel
		TabObj.Indicator = indicator
		TabObj.IconImage = tabIconImg
		TabObj.Page = page
		table.insert(Window.Tabs, TabObj)

		if #Window.Tabs == 1 then
			Activate()
		end

		return TabObj
	end

	--// Window-level Helpers
	function Window:Notify(opts) NovaLib:Notify(opts) end

	function Window:SaveConfig(name)
		local ok = NovaLib:SaveConfig(name or "default")
		NovaLib:Notify({
			Title = ok and "Config Saved" or "Save Failed",
			Content = ok and ("Saved to " .. ConfigFolder .. "/" .. (name or "default") .. ".json")
				or "Your executor does not support file functions.",
			Type = ok and "Success" or "Error",
		})
		return ok
	end

	function Window:LoadConfig(name)
		local data = NovaLib:LoadConfig(name or "default", Window.Callbacks)
		NovaLib:Notify({
			Title = data and "Config Loaded" or "Load Failed",
			Content = data and "Your settings have been applied." or "No config found or executor unsupported.",
			Type = data and "Success" or "Error",
		})
		return data
	end

	-- live theme switching remapping
	function Window:SetTheme(name)
		local newTheme = NovaLib.Themes[name]
		if not newTheme then return end
		local oldTheme = Theme
		Theme = newTheme

		local map = {}
		for key, color in pairs(oldTheme) do
			if typeof(color) == "Color3" then
				map[tostring(color)] = key
			end
		end

		local function Remap(color)
			local key = map[tostring(color)]
			return key and newTheme[key] or nil
		end

		for _, obj in ipairs(screenGui:GetDescendants()) do
			pcall(function()
				if obj:IsA("GuiObject") then
					local bg = Remap(obj.BackgroundColor3)
					if bg then obj.BackgroundColor3 = bg end
				end
				if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
					local tc = Remap(obj.TextColor3)
					if tc then obj.TextColor3 = tc end
				end
				if obj:IsA("ImageLabel") then
					local ic = Remap(obj.ImageColor3)
					if ic then obj.ImageColor3 = ic end
				end
				if obj:IsA("TextBox") then
					local pc = Remap(obj.PlaceholderColor3)
					if pc then obj.PlaceholderColor3 = pc end
				end
				if obj:IsA("UIStroke") then
					local sc = Remap(obj.Color)
					if sc then obj.Color = sc end
				end
				if obj:IsA("ScrollingFrame") then
					local sb = Remap(obj.ScrollBarImageColor3)
					if sb then obj.ScrollBarImageColor3 = sb end
				end
			end)
		end

		NovaLib:Notify({
			Title = "Theme",
			Content = "Theme set to " .. name .. ".",
			Type = "Info",
		})
	end

	function Window:Destroy()
		for _, conn in ipairs(Window.Connections) do
			pcall(function() conn:Disconnect() end)
		end
		table.clear(Window.Connections)
		screenGui:Destroy()
	end

	return Window
end
