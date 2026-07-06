--// Keybind Element -----------------------------------------------------------

function Tab:CreateKeybind(kOptions)
	kOptions = kOptions or {}
	local page = self.Page
	local window = self.Window
	local flag = kOptions.Flag
	local callback = kOptions.Callback or function() end
	local currentKey = kOptions.Default or Enum.KeyCode.E
	local listening = false

	local frame = ElementBase(page, NovaLib.Sizes.Small)
	ElementTitle(frame, kOptions.Name or "Keybind", -120)

	local keyBtn = Create("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 92, 0, 26),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundColor3 = Theme.Background,
		FontFace = NovaLib.Fonts.Bold,
		Text = currentKey.Name,
		TextColor3 = Theme.SubText,
		TextSize = 13,
		AutoButtonColor = false,
		Parent = frame,
	})
	Round(keyBtn, 7)
	local keyStroke = Stroke(keyBtn, Theme.Stroke, 1, 0.4)

	keyBtn.MouseButton1Click:Connect(function()
		listening = true
		keyBtn.Text = "Press key..."
		Tween(keyStroke, { Color = Theme.StrokeLight, Transparency = 0 }, 0.2)
	end)

	table.insert(window.Connections, UserInputService.InputBegan:Connect(function(input, processed)
		if listening and input.UserInputType == Enum.UserInputType.Keyboard then
			listening = false
			currentKey = input.KeyCode
			keyBtn.Text = currentKey.Name
			Tween(keyBtn, { BackgroundColor3 = Theme.Background, TextColor3 = Theme.SubText }, 0.2)
			Tween(keyStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.2)
			if flag then NovaLib.Flags[flag] = currentKey.Name end
		elseif not processed and input.KeyCode == currentKey and not listening then
			task.spawn(callback, currentKey)
		end
	end))

	if flag then NovaLib.Flags[flag] = currentKey.Name end

	local Keybind = {}
	Keybind.Set = function(_, keyCode)
		currentKey = keyCode
		keyBtn.Text = keyCode.Name
	end
	Keybind.Get = function() return currentKey end
	return Keybind
end
