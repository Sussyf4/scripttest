--// Window Component -----------------------------------------------------------

function NovaLib:CreateWindow(options)
	options = options or {}
	local windowTitle = options.Title or "NovaLib"
	local windowSize = options.Size or UDim2.new(0, 600, 0, 420)
	local themeName = options.Theme or "Black"
	local toggleKey = options.ToggleKey or Enum.KeyCode.RightControl
	local showIntro = options.Intro ~= false

	if themeName == "Black" then
		Theme = NovaLib.Themes.Darker
	elseif themeName == "Amethyst" then
		Theme = NovaLib.Themes.Amethyst
	elseif NovaLib.Themes[themeName] then
		Theme = NovaLib.Themes[themeName]
	else
		Theme = NovaLib.Themes.Darker or NovaLib.Themes.Dark
	end

	if showIntro then
		PlayIntro(windowTitle, options.IntroText or "Loading interface...")
	end

	local Window = setmetatable({}, WindowProto)
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

	local windowScale = Create("UIScale", {
		Scale = 0.95,
		Parent = main,
	})

	-- Open transition
	Tween(main, {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		GroupTransparency = 0,
	}, 0.4, Enum.EasingStyle.Quint)
	Tween(windowScale, { Scale = 1 }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween(windowShadow, { BackgroundTransparency = 0.8 }, 0.45)

	--// Top Bar
	local topBar = Create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = Theme.Secondary,
		Parent = main,
	})
	Round(topBar, 12)
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
	local function WindowButton(iconName, xOffset, fallbackText)
		local btn = Create("TextButton", {
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(1, xOffset, 0.5, -14),
			BackgroundColor3 = Theme.Tertiary,
			BackgroundTransparency = 1,
			Text = fallbackText or "",
			FontFace = NovaLib.Fonts.Bold,
			TextColor3 = Theme.SubText,
			TextSize = 14,
			AutoButtonColor = false,
			Parent = topBar,
		})
		Round(btn, 7)

		local icon = CreateIcon(btn, iconName, Theme.SubText, 14)
		if icon then
			btn.Text = "" -- Hide text if icon loaded successfully
			icon.AnchorPoint = Vector2.new(0.5, 0.5)
			icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		end

		btn.MouseEnter:Connect(function()
			Tween(btn, { BackgroundTransparency = 0, TextColor3 = Theme.Text }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.Text }, 0.15)
			end
		end)
		btn.MouseLeave:Connect(function()
			Tween(btn, { BackgroundTransparency = 1, TextColor3 = Theme.SubText }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.SubText }, 0.15)
			end
		end)
		return btn
	end

	local closeBtn = WindowButton("x", -38, "✕")
	local minBtn = WindowButton("minus", -70, "—")

	closeBtn.MouseButton1Click:Connect(function()
		Tween(main, {
			Position = main.Position + UDim2.new(0, 0, 0, 20),
			GroupTransparency = 1,
		}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		Tween(windowScale, { Scale = 0.92 }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		Tween(windowShadow, { BackgroundTransparency = 1 }, 0.3)
		task.wait(0.38)
		Window:Destroy()
	end)

	local storedSize = windowSize
	minBtn.MouseButton1Click:Connect(function()
		Window.Minimized = not Window.Minimized
		if Window.Minimized then
			storedSize = main.Size
			Tween(main, { Size = UDim2.new(0, storedSize.X.Offset, 0, 44) }, 0.35)
			local icon = minBtn:FindFirstChild("minusIcon") or minBtn:FindFirstChild("plusIcon")
			if icon then
				icon.Name = "plusIcon"
				icon.Image = NovaLib:GetIcon("plus")
			else
				minBtn.Text = "+"
			end
		else
			Tween(main, { Size = storedSize }, 0.35, Enum.EasingStyle.Back)
			local icon = minBtn:FindFirstChild("plusIcon") or minBtn:FindFirstChild("minusIcon")
			if icon then
				icon.Name = "minusIcon"
				icon.Image = NovaLib:GetIcon("minus")
			else
				minBtn.Text = "—"
			end
		end
	end)

	MakeDraggable(topBar, main, Window.Connections)

	-- Window Resizing
	local resizeHandle = Create("Frame", {
		Name = "ResizeHandle",
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(1, -16, 1, -16),
		BackgroundTransparency = 1,
		ZIndex = 10,
		Parent = main,
	})
	local resizeIcon = CreateIcon(resizeHandle, "move-diagonal-2", Theme.SubText, 10)
	if resizeIcon then
		resizeIcon.Position = UDim2.new(0.5, -5, 0.5, -5)
	end

	local resizing = false
	local dragStart = Vector2.new()
	local startSize = Vector2.new()

	local resizeBegan = resizeHandle.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not Window.Minimized then
			resizing = true
			dragStart = input.Position
			startSize = Vector2.new(main.Size.X.Offset, main.Size.Y.Offset)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	local resizeChanged = UserInputService.InputChanged:Connect(function(input)
		if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			local newX = math.max(450, startSize.X + delta.X)
			local newY = math.max(300, startSize.Y + delta.Y)
			main.Size = UDim2.new(0, newX, 0, newY)
		end
	end)

	table.insert(Window.Connections, resizeBegan)
	table.insert(Window.Connections, resizeChanged)

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

	Window.TabList = tabList
	Window.Content = content

	return Window
end

--// Window-level OOP Methods ---------------------------------------------------

function WindowProto:Notify(opts)
	NovaLib:Notify(opts)
end

function WindowProto:SaveConfig(name)
	local ok = NovaLib:SaveConfig(name or "default")
	NovaLib:Notify({
		Title = ok and "Config Saved" or "Save Failed",
		Content = ok and ("Saved to " .. ConfigFolder .. "/" .. (name or "default") .. ".json")
			or "Your executor does not support file functions.",
		Type = ok and "Success" or "Error",
	})
	return ok
end

function WindowProto:LoadConfig(name)
	local data = NovaLib:LoadConfig(name or "default", self.Callbacks)
	NovaLib:Notify({
		Title = data and "Config Loaded" or "Load Failed",
		Content = data and "Your settings have been applied." or "No config found or executor unsupported.",
		Type = data and "Success" or "Error",
	})
	return data
end

function WindowProto:Destroy()
	for _, conn in ipairs(self.Connections) do
		pcall(function() conn:Disconnect() end)
	end
	table.clear(self.Connections)
	self.Gui:Destroy()
end
