--// Color Picker Element (RGB sliders) ----------------------------------------

function Tab:CreateColorPicker(cOptions)
	cOptions = cOptions or {}
	local page = self.Page
	local window = self.Window
	local flag = cOptions.Flag
	local callback = cOptions.Callback or function() end
	local color = cOptions.Default or Theme.Accent
	local open = false

	local frame = Create("Frame", {
		Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small),
		BackgroundColor3 = Theme.Secondary,
		ClipsDescendants = true,
		Parent = page,
	})
	Round(frame, 9)
	local frameStroke = Stroke(frame, Theme.Stroke, 1, 0.4)
	Sheen(frame, 0.03)

	local header = Create("TextButton", {
		Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})

	Create("TextLabel", {
		Size = UDim2.new(0.6, -14, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = cOptions.Name or "Color",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = header,
	})

	local preview = Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 38, 0, 22),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundColor3 = color,
		Parent = header,
	})
	Round(preview, 6)
	Stroke(preview, Theme.StrokeLight, 1, 0.2)

	local channels = { "R", "G", "B" }
	local channelValues = {
		R = math.floor(color.R * 255),
		G = math.floor(color.G * 255),
		B = math.floor(color.B * 255),
	}
	local channelFills = {}
	local channelLabels = {}

	local function ApplyColor()
		color = Color3.fromRGB(channelValues.R, channelValues.G, channelValues.B)
		preview.BackgroundColor3 = color
		if flag then NovaLib.Flags[flag] = color end
		task.spawn(callback, color)
	end

	for i, ch in ipairs(channels) do
		local yOff = NovaLib.Sizes.Small + 8 + (i - 1) * 30
		Create("TextLabel", {
			Size = UDim2.new(0, 16, 0, 20),
			Position = UDim2.new(0, 14, 0, yOff),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Bold,
			Text = ch,
			TextColor3 = Theme.SubText,
			TextSize = 13,
			Parent = frame,
		})

		local track = Create("TextButton", {
			Size = UDim2.new(1, -104, 0, 6),
			Position = UDim2.new(0, 36, 0, yOff + 7),
			BackgroundColor3 = Theme.Tertiary,
			Text = "",
			AutoButtonColor = false,
			Parent = frame,
		})
		Round(track, 3)

		local chColor = ch == "R" and Color3.fromRGB(235, 87, 87)
			or ch == "G" and Color3.fromRGB(80, 200, 120)
			or Color3.fromRGB(90, 140, 255)

		local fill = Create("Frame", {
			Size = UDim2.new(channelValues[ch] / 255, 0, 1, 0),
			BackgroundColor3 = chColor,
			Parent = track,
		})
		Round(fill, 3)
		channelFills[ch] = fill

		local valLabel = Create("TextLabel", {
			Size = UDim2.new(0, 40, 0, 20),
			Position = UDim2.new(1, -54, 0, yOff),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Bold,
			Text = tostring(channelValues[ch]),
			TextColor3 = Theme.Text,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Right,
			Parent = frame,
		})
		channelLabels[ch] = valLabel

		local sliding = false
		local function UpdateFromInput(inputPos)
			local rel = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
			channelValues[ch] = math.floor(rel * 255 + 0.5)
			fill.Size = UDim2.new(rel, 0, 1, 0)
			valLabel.Text = tostring(channelValues[ch])
			ApplyColor()
		end

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				sliding = true
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
				sliding = false
			end
		end))
	end

	header.MouseButton1Click:Connect(function()
		open = not open
		Tween(frame, { Size = open and UDim2.new(1, 0, 0, NovaLib.Sizes.Small + 104) or UDim2.new(1, 0, 0, NovaLib.Sizes.Small) }, 0.3)
		Tween(frameStroke, {
			Color = open and Theme.StrokeLight or Theme.Stroke,
			Transparency = open and 0.1 or 0.4,
		}, 0.3)
	end)

	local function Set(newColor)
		channelValues.R = math.floor(newColor.R * 255)
		channelValues.G = math.floor(newColor.G * 255)
		channelValues.B = math.floor(newColor.B * 255)
		for _, ch in ipairs(channels) do
			channelFills[ch].Size = UDim2.new(channelValues[ch] / 255, 0, 1, 0)
			channelLabels[ch].Text = tostring(channelValues[ch])
		end
		ApplyColor()
	end

	if flag then
		NovaLib.Flags[flag] = color
		window.Callbacks[flag] = Set
	end

	local ColorPicker = {}
	ColorPicker.Set = function(_, v) Set(v) end
	ColorPicker.Get = function() return color end
	return ColorPicker
end
