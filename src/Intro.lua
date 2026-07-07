--// Intro (Wind + Letter Fade Animation) --------------------------------------

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

	-- Title container — centered row of character labels
	local titleContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, -20),
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

		local label = Create("TextLabel", {
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Pixel,
			Text = char,
			TextColor3 = Theme.Text,
			TextSize = 42,
			TextTransparency = 1, -- start hidden
			LayoutOrder = i,
			Parent = titleContainer,
		})

		-- tiny glow behind the letters
		Create("UIStroke", {
			Color = Theme.AccentGlow,
			Thickness = 1,
			Transparency = 0.85,
			Parent = label,
		})

		-- Padding for offset animation
		local pad = Create("UIPadding", {
			PaddingLeft = UDim.new(0, 40), -- wind offset
			Parent = label,
		})

		table.insert(charLabels, { label = label, pad = pad })
	end

	-- Subtitle container
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

		local label = Create("TextLabel", {
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Medium,
			Text = char,
			TextColor3 = Theme.SubText,
			TextSize = 16,
			TextTransparency = 1, -- start hidden
			LayoutOrder = i,
			Parent = subContainer,
		})

		local pad = Create("UIPadding", {
			PaddingLeft = UDim.new(0, 30), -- wind offset
			Parent = label,
		})

		table.insert(subLabels, { label = label, pad = pad })
	end

	-- Fade backdrop in
	Tween(backdrop, { BackgroundTransparency = 0 }, 0.35)
	task.wait(0.35)

	-- Wind-in title characters (staggered)
	for i, data in ipairs(charLabels) do
		Tween(data.pad, { PaddingLeft = UDim.new(0, 0) }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		Tween(data.label, { TextTransparency = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.05)
	end

	-- Wait then wind-in subtitle characters
	task.wait(0.3)
	for i, data in ipairs(subLabels) do
		Tween(data.pad, { PaddingLeft = UDim.new(0, 0) }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		Tween(data.label, { TextTransparency = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.03)
	end

	-- Hold
	task.wait(1.5)

	-- Drift out simultaneously (upward + fade)
	for _, data in ipairs(charLabels) do
		Tween(data.pad, { PaddingTop = UDim.new(0, 20) }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		Tween(data.label, { TextTransparency = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	for _, data in ipairs(subLabels) do
		Tween(data.pad, { PaddingTop = UDim.new(0, 15) }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		Tween(data.label, { TextTransparency = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	task.wait(0.38)

	-- Fade backdrop out
	Tween(backdrop, { BackgroundTransparency = 1 }, 0.4)
	task.wait(0.45)
	introGui:Destroy()
end
