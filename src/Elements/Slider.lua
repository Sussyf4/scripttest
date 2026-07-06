--// Slider Element ------------------------------------------------------------

function Tab:CreateSlider(sOptions)
	sOptions = sOptions or {}
	local page = self.Page
	local window = self.Window
	local min = sOptions.Min or 0
	local max = sOptions.Max or 100
	local increment = sOptions.Increment or 1
	local flag = sOptions.Flag
	local callback = sOptions.Callback or function() end
	local value = math.clamp(sOptions.Default or min, min, max)

	local frame = ElementBase(page, NovaLib.Sizes.Large)
	Create("TextLabel", {
		Size = UDim2.new(1, -90, 0, 20),
		Position = UDim2.new(0, 14, 0, 8),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = sOptions.Name or "Slider",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = frame,
	})

	local valueBadge = Create("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 20),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -12, 0, 8),
		BackgroundColor3 = Theme.Tertiary,
		Parent = frame,
	})
	Round(valueBadge, 10)
	Stroke(valueBadge, Theme.Stroke, 1, 0.4)
	local valueLabel = Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Bold,
		Text = tostring(value),
		TextColor3 = Theme.Text,
		TextSize = 13,
		Parent = valueBadge,
	})
	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9),
		Parent = valueBadge,
	})

	local track = Create("TextButton", {
		Size = UDim2.new(1, -28, 0, 6),
		Position = UDim2.new(0, 14, 1, -18),
		BackgroundColor3 = Theme.Tertiary,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})
	Round(track, 3)

	local fill = Create("Frame", {
		Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = Theme.Accent,
		Parent = track,
	})
	Round(fill, 3)
	Create("UIGradient", {
		Color = ColorSequence.new(Theme.AccentDark, Theme.Accent),
		Parent = fill,
	})

	local knob = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = 2,
		Parent = fill,
	})
	Round(knob, 6)
	Stroke(knob, Theme.StrokeLight, 2, 0)

	local knobScale = Create("UIScale", { Scale = 1, Parent = knob })

	local function Set(newValue)
		newValue = math.clamp(newValue, min, max)
		newValue = math.floor(newValue / increment + 0.5) * increment
		newValue = tonumber(string.format("%.4f", newValue))
		value = newValue
		valueLabel.Text = tostring(value)
		fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
		if flag then NovaLib.Flags[flag] = value end
		task.spawn(callback, value)
	end

	local sliding = false
	local function UpdateFromInput(inputPos)
		local rel = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		Set(min + (max - min) * rel)
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			sliding = true
			Tween(knobScale, { Scale = 16 / 12 }, 0.15)
			UpdateFromInput(input.Position)
		end
	end)
	table.insert(window.Connections, UserInputService.InputChanged:Connect(function(input)
		if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			UpdateFromInput(input.Position)
		end
	end))
	table.insert(window.Connections, UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			if sliding then
				Tween(knobScale, { Scale = 1 }, 0.15)
			end
			sliding = false
		end
	end))

	if flag then
		NovaLib.Flags[flag] = value
		window.Callbacks[flag] = Set
	end

	local Slider = {}
	Slider.Set = function(_, v) Set(v) end
	Slider.Get = function() return value end
	return Slider
end
