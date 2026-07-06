--// Input (TextBox) Element ---------------------------------------------------

function Tab:CreateInput(iOptions)
	iOptions = iOptions or {}
	local page = self.Page
	local flag = iOptions.Flag
	local callback = iOptions.Callback or function() end

	local frame = ElementBase(page, NovaLib.Sizes.Normal)
	Create("TextLabel", {
		Size = UDim2.new(0.42, -14, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = iOptions.Name or "Input",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = frame,
	})

	local boxHolder = Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0.52, -20, 0, 28),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundColor3 = Theme.Background,
		Parent = frame,
	})
	Round(boxHolder, 7)
	local boxStroke = Stroke(boxHolder, Theme.Stroke, 1, 0.4)

	local box = Create("TextBox", {
		Size = UDim2.new(1, -18, 1, 0),
		Position = UDim2.new(0, 9, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Body,
		PlaceholderText = iOptions.Placeholder or "Type here...",
		PlaceholderColor3 = Theme.SubText,
		Text = iOptions.Default or "",
		TextColor3 = Theme.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = iOptions.ClearOnFocus or false,
		Parent = boxHolder,
	})

	box.Focused:Connect(function()
		Tween(boxStroke, { Color = Theme.StrokeLight, Transparency = 0 }, 0.2)
	end)
	box.FocusLost:Connect(function(enterPressed)
		Tween(boxStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.2)
		if flag then NovaLib.Flags[flag] = box.Text end
		task.spawn(callback, box.Text, enterPressed)
	end)

	if flag then
		NovaLib.Flags[flag] = box.Text
		self.Window.Callbacks[flag] = function(v) box.Text = tostring(v) end
	end

	local Input = {}
	Input.Set = function(_, v) box.Text = tostring(v) end
	Input.Get = function() return box.Text end
	return Input
end
