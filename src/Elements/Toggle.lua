--// Toggle Element ------------------------------------------------------------

function Tab:CreateToggle(tOptions)
	tOptions = tOptions or {}
	local page = self.Page
	local flag = tOptions.Flag
	local callback = tOptions.Callback or function() end
	local state = tOptions.Default or false

	local frame = ElementBase(page, NovaLib.Sizes.Small)
	ElementTitle(frame, tOptions.Name or "Toggle", -76)

	local switch = Create("Frame", {
		Size = UDim2.new(0, 42, 0, 22),
		Position = UDim2.new(1, -54, 0.5, -11),
		BackgroundColor3 = state and Theme.Accent or Theme.Tertiary,
		Parent = frame,
	})
	Round(switch, 11)
	local switchStroke = Stroke(switch, state and Theme.Accent or Theme.Stroke, 1, state and 0.4 or 0.3)

	local knob = Create("Frame", {
		Size = UDim2.new(0, 16, 0, 16),
		Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
		BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Theme.SubText,
		Parent = switch,
	})
	Round(knob, 8)
	local knobScale = Create("UIScale", {
		Scale = 1,
		Parent = knob,
	})

	local clickArea = Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})

	local function Render()
		Tween(switch, { BackgroundColor3 = state and Theme.Accent or Theme.Tertiary }, 0.22)
		Tween(switchStroke, {
			Color = state and Theme.AccentGlow or Theme.Stroke,
			Transparency = state and 0.4 or 0.3,
		}, 0.22)
		Tween(knob, {
			Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
			BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Theme.SubText,
		}, 0.25, Enum.EasingStyle.Circular)
		
		-- Knob pop tactile animation
		Tween(knobScale, { Scale = 1.25 }, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.delay(0.1, function()
			Tween(knobScale, { Scale = 1.0 }, 0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end)
	end

	local function Set(value)
		state = value and true or false
		if flag then NovaLib.Flags[flag] = state end
		Render()
		task.spawn(callback, state)
	end

	clickArea.MouseButton1Click:Connect(function() Set(not state) end)

	local frameStroke = frame:FindFirstChildOfClass("UIStroke")
	clickArea.MouseEnter:Connect(function()
		Tween(frame, { BackgroundColor3 = Theme.Hover }, 0.15)
		if frameStroke then
			Tween(frameStroke, { Transparency = 0.2 }, 0.15)
		end
	end)
	clickArea.MouseLeave:Connect(function()
		Tween(frame, { BackgroundColor3 = Theme.Secondary }, 0.15)
		if frameStroke then
			Tween(frameStroke, { Transparency = 0.4 }, 0.15)
		end
	end)

	if flag then
		NovaLib.Flags[flag] = state
		self.Window.Callbacks[flag] = Set
	end
	if state then task.spawn(callback, state) end

	local Toggle = {}
	Toggle.Set = function(_, v) Set(v) end
	Toggle.Get = function() return state end
	return Toggle
end
