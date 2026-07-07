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

	local totalTitleWidth = 0
	for i = 1, #titleText do
		local char = string.sub(titleText, i, i)
		totalTitleWidth = totalTitleWidth + ((char == " ") and 16 or 32)
	end

	local subText = _subText or "Loading interface..."
	local totalSubWidth = 0
	for i = 1, #subText do
		local char = string.sub(subText, i, i)
		totalSubWidth = totalSubWidth + ((char == " ") and 8 or 12)
	end

	local titleContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, -20),
		Size = UDim2.new(0, totalTitleWidth, 0, 32),
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
		local assetId = NovaLib.FontMaps and NovaLib.FontMaps.PressStart2P and (
			NovaLib.FontMaps.PressStart2P[char] 
			or NovaLib.FontMaps.PressStart2P[string.lower(char)] 
			or NovaLib.FontMaps.PressStart2P[string.upper(char)]
		)
		
		local charWidth = 32
		local charHeight = 32
		if char == " " then
			charWidth = 16
		end

		local wrapper = Create("Frame", {
			Size = UDim2.new(0, charWidth, 0, charHeight),
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = titleContainer,
		})
		
		local label
		if assetId then
			label = Create("ImageLabel", {
				Position = UDim2.new(0, 40, 0, 0), -- 40 X offset
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Image = assetId,
				ImageColor3 = Theme.Text,
				ImageTransparency = 1, -- start hidden
				Parent = wrapper,
			})
		else
			label = Create("TextLabel", {
				Position = UDim2.new(0, 40, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = char,
				TextColor3 = Theme.Text,
				TextSize = 42,
				TextTransparency = 1,
				Parent = wrapper,
			})
		end
		
		-- tiny glow behind the letters
		Create("UIStroke", {
			Color = Theme.AccentGlow,
			Thickness = 1,
			Transparency = 0.85,
			Parent = label,
		})
		
		table.insert(charLabels, label)
	end

	local subContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 20),
		Size = UDim2.new(0, totalSubWidth, 0, 18),
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
		local assetId = NovaLib.FontMaps and NovaLib.FontMaps.SourGummy and (
			NovaLib.FontMaps.SourGummy[char] 
			or NovaLib.FontMaps.SourGummy[string.lower(char)] 
			or NovaLib.FontMaps.SourGummy[string.upper(char)]
		)
		
		local charWidth = 12
		local charHeight = 18
		if char == " " then
			charWidth = 8
		end

		local wrapper = Create("Frame", {
			Size = UDim2.new(0, charWidth, 0, charHeight),
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = subContainer,
		})
		
		local label
		if assetId then
			label = Create("ImageLabel", {
				Position = UDim2.new(0, 30, 0, 0), -- 30 X offset
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Image = assetId,
				ImageColor3 = Theme.SubText,
				ImageTransparency = 1, -- start hidden
				Parent = wrapper,
			})
		else
			label = Create("TextLabel", {
				Position = UDim2.new(0, 30, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = char,
				TextColor3 = Theme.SubText,
				TextSize = 16,
				TextTransparency = 1,
				Parent = wrapper,
			})
		end
		
		table.insert(subLabels, label)
	end

	-- Fade backdrop in
	Tween(backdrop, { BackgroundTransparency = 0 }, 0.35)
	task.wait(0.35)

	-- Wind-in title characters
	for i, label in ipairs(charLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, 0), [propName] = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.05)
	end

	-- Wait then wind-in subtitle characters
	task.wait(0.3)
	for i, label in ipairs(subLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, 0), [propName] = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.03)
	end

	-- Hold
	task.wait(1.5)

	-- Drift out simultaneously
	for _, label in ipairs(charLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, -20), [propName] = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	for _, label in ipairs(subLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, -15), [propName] = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	task.wait(0.38)

	-- Fade backdrop out
	Tween(backdrop, { BackgroundTransparency = 1 }, 0.4)
	task.wait(0.45)
	introGui:Destroy()
end
