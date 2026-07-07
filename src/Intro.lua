--// Intro (Wind + Letter Fade Animation) --------------------------------------

local TextService = game:GetService("TextService")

local function PlayIntro(titleText, _subText)
	local introGui = Create("ScreenGui", {
		Name = "NovaIntro",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(introGui)

	local backdrop = Create("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = introGui,
	})

	local titleContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, -30),
		Size = UDim2.new(0, 0, 0, 60),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = introGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local charLabels = {}
	for i = 1, #titleText do
		local char = string.sub(titleText, i, i)
		local charSize = TextService:GetTextSize(char, 42, Enum.Font.Code, Vector2.new(1000, 1000))
		
		local wrapper = Create("Frame", {
			Size = UDim2.new(0, charSize.X, 0, charSize.Y),
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = titleContainer,
		})
		
		local label = Create("TextLabel", {
			Position = UDim2.new(0, 40, 0, 0), -- 40 X offset
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Pixel,
			Text = char,
			TextColor3 = Theme.Text,
			TextSize = 42,
			TextTransparency = 1, -- start hidden
			Parent = wrapper,
		})
		
		-- tiny glow behind the letters
		Create("UIStroke", {
			Color = Theme.AccentGlow,
			Thickness = 1,
			Transparency = 0.85,
			Parent = label,
		})
		
		table.insert(charLabels, label)
	end

	local subText = _subText or "Loading interface..."
	local subContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 30),
		Size = UDim2.new(0, 0, 0, 24),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = introGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local subLabels = {}
	for i = 1, #subText do
		local char = string.sub(subText, i, i)
		local charSize = TextService:GetTextSize(char, 16, Enum.Font.Gotham, Vector2.new(1000, 1000))
		
		local wrapper = Create("Frame", {
			Size = UDim2.new(0, charSize.X, 0, charSize.Y),
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = subContainer,
		})
		
		local label = Create("TextLabel", {
			Position = UDim2.new(0, 30, 0, 0), -- 30 X offset
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Medium,
			Text = char,
			TextColor3 = Theme.SubText,
			TextSize = 16,
			TextTransparency = 1, -- start hidden
			Parent = wrapper,
		})
		
		table.insert(subLabels, label)
	end

	-- Fade backdrop in
	Tween(backdrop, { BackgroundTransparency = 0 }, 0.35)
	task.wait(0.35)

	-- Wind-in title characters
	for i, label in ipairs(charLabels) do
		Tween(label, { Position = UDim2.new(0, 0, 0, 0), TextTransparency = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.05)
	end

	-- Wait then wind-in subtitle characters
	task.wait(0.3)
	for i, label in ipairs(subLabels) do
		Tween(label, { Position = UDim2.new(0, 0, 0, 0), TextTransparency = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.03)
	end

	-- Hold
	task.wait(1.5)

	-- Drift out simultaneously
	for _, label in ipairs(charLabels) do
		Tween(label, { Position = UDim2.new(0, 0, 0, -20), TextTransparency = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	for _, label in ipairs(subLabels) do
		Tween(label, { Position = UDim2.new(0, 0, 0, -15), TextTransparency = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	task.wait(0.38)

	-- Fade backdrop out
	Tween(backdrop, { BackgroundTransparency = 1 }, 0.4)
	task.wait(0.45)
	introGui:Destroy()
end
