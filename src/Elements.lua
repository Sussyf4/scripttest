--// Tab Elements -------------------------------------------------------------

local function ElementBase(page, height)
	local frame = Create("Frame", {
		Size = UDim2.new(1, 0, 0, height),
		BackgroundColor3 = Theme.Secondary,
		Parent = page,
	})
	Round(frame, 9)
	Stroke(frame, Theme.Stroke, 1, 0.4)
	Sheen(frame, 0.03)
	return frame
end

local function ElementTitle(parent, text, widthOffset)
	return Create("TextLabel", {
		Size = UDim2.new(1, widthOffset or -70, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = text,
		TextColor3 = Theme.Text,
		TextSize = 14, -- element titles size 14
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = parent,
	})
end

--// Section (accent pill + title + divider line)
function Tab:CreateSection(text)
	local page = self.Page
	local window = self.Window

	local holder = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		Parent = page,
	})
	holder:SetAttribute("NovaKeepTransparent", true)

	local pill = Create("Frame", {
		Size = UDim2.new(0, 3, 0, 12),
		Position = UDim2.new(0, 2, 0.5, -6),
		BackgroundColor3 = Theme.SubText,
		Parent = holder,
	})
	Round(pill, 2)

	local secLabel = Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Position = UDim2.new(0, 12, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Mono,
		Text = string.upper(text),
		TextColor3 = Theme.SubText,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Parent = holder,
	})

	local divider = Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -2, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 1),
		BackgroundColor3 = Theme.Stroke,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Parent = holder,
	})

	local function UpdateDivider()
		divider.Size = UDim2.new(0, math.max(0, holder.AbsoluteSize.X - secLabel.AbsoluteSize.X - 32), 0, 1)
	end
	table.insert(window.Connections, holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateDivider))
	table.insert(window.Connections, secLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateDivider))
	task.defer(UpdateDivider)

	return holder
end

--// Label (auto-height, wraps long text cleanly)
function Tab:CreateLabel(text)
	local page = self.Page
	local frame = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Secondary,
		Parent = page,
	})
	Round(frame, 9)
	Stroke(frame, Theme.Stroke, 1, 0.4)
	Create("UIPadding", {
		PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14),
		Parent = frame,
	})

	local label = Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = text,
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextWrapped = true,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame,
	})

	local Label = {}
	function Label:Set(newText) label.Text = newText end
	return Label
end

--// Paragraph
function Tab:CreateParagraph(pOptions)
	pOptions = pOptions or {}
	local page = self.Page
	local frame = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Secondary,
		Parent = page,
	})
	Round(frame, 9)
	Stroke(frame, Theme.Stroke, 1, 0.4)
	Sheen(frame, 0.03)
	Create("UIPadding", {
		PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14),
		Parent = frame,
	})
	Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 5),
		Parent = frame,
	})
	local titleL = Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Bold,
		Text = pOptions.Title or "Paragraph",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 1,
		Parent = frame,
	})
	local bodyL = Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Body,
		Text = pOptions.Content or "",
		TextColor3 = Theme.SubText,
		TextSize = 13,
		TextWrapped = true,
		LineHeight = 1.25,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
		Parent = frame,
	})
	local Paragraph = {}
	function Paragraph:Set(t, c)
		if t then titleL.Text = t end
		if c then bodyL.Text = c end
	end
	return Paragraph
end

--// Button (Lucide icon support)
function Tab:CreateButton(bOptions)
	bOptions = bOptions or {}
	local page = self.Page
	local callback = bOptions.Callback or function() end

	local frame = ElementBase(page, NovaLib.Sizes.Small)

	-- If icon is specified, we place it next to the button text
	local btnLabel = Create("TextLabel", {
		Size = UDim2.new(1, -40, 1, 0),
		Position = UDim2.new(0, bOptions.Icon and 36 or 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = bOptions.Name or "Button",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame,
	})

	local btn = Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})

	if bOptions.Icon then
		local icon = CreateIcon(frame, bOptions.Icon, Theme.Text, 16)
		if icon then
			icon.AnchorPoint = Vector2.new(0, 0.5)
			icon.Position = UDim2.new(0, 14, 0.5, 0)
		end
	end

	-- chevron hint on the right
	local hint = Create("Frame", {
		Size = UDim2.new(0, 20, 1, 0),
		Position = UDim2.new(1, -30, 0, 0),
		BackgroundTransparency = 1,
		Parent = frame,
	})
	local chevron = CreateIcon(hint, "chevron-right", Theme.SubText, 14)
	if chevron then
		chevron.AnchorPoint = Vector2.new(0.5, 0.5)
		chevron.Position = UDim2.new(0.5, 0, 0.5, 0)
		chevron.ImageTransparency = 0.4
	end

	local pressScale = Create("UIScale", { Scale = 1, Parent = frame })
	local frameStroke = frame:FindFirstChildOfClass("UIStroke")

	btn.MouseEnter:Connect(function()
		Tween(frame, { BackgroundColor3 = Theme.Hover }, 0.15)
		if frameStroke then
			Tween(frameStroke, { Transparency = 0.2 }, 0.15)
		end
	end)
	btn.MouseLeave:Connect(function()
		Tween(frame, { BackgroundColor3 = Theme.Secondary }, 0.15)
		if frameStroke then
			Tween(frameStroke, { Transparency = 0.4 }, 0.15)
		end
	end)
	btn.MouseButton1Click:Connect(function()
		Tween(pressScale, { Scale = 0.97 }, 0.08)
		task.delay(0.09, function()
			Tween(pressScale, { Scale = 1 }, 0.12)
		end)
		task.spawn(callback)
	end)

	local Button = {}
	function Button:Set(newText) btnLabel.Text = newText end
	return Button
end

--// Toggle
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

--// Slider
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

--// Dropdown
function Tab:CreateDropdown(dOptions)
	dOptions = dOptions or {}
	local page = self.Page
	local items = dOptions.Options or {}
	local flag = dOptions.Flag
	local callback = dOptions.Callback or function() end
	local selected = dOptions.Default or nil
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
		Size = UDim2.new(0.45, -14, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = dOptions.Name or "Dropdown",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = header,
	})

	-- selected value in a pill badge for clean alignment
	local selBadge = Create("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -34, 0.5, 0),
		BackgroundColor3 = Theme.Tertiary,
		Parent = header,
	})
	Round(selBadge, 11)
	Stroke(selBadge, Theme.Stroke, 1, 0.4)
	local selectedLabel = Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = selected and tostring(selected) or "Select...",
		TextColor3 = Theme.SubText,
		TextSize = 13,
		Parent = selBadge,
	})
	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9),
		Parent = selBadge,
	})

	-- Dropdown chevron arrow
	local arrow = Create("Frame", {
		Name = "Arrow",
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(1, -24, 0.5, -10),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		Parent = header,
	})
	local chevron = CreateIcon(arrow, "chevron-down", Theme.SubText, 14)
	if chevron then
		chevron.AnchorPoint = Vector2.new(0.5, 0.5)
		chevron.Position = UDim2.new(0.5, 0, 0.5, 0)
	end

	local listHolder = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 0),
		Position = UDim2.new(0, 10, 0, NovaLib.Sizes.Small + 6),
		BackgroundTransparency = 1,
		Parent = frame,
	}, {
		Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 3),
		}),
	})

	local optionButtons = {}

	local function CloseList()
		open = false
		Tween(frame, { Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small) }, 0.28)
		Tween(arrow, { Rotation = 0 }, 0.28)
		Tween(frameStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.28)
	end

	local function Set(value)
		selected = value
		selectedLabel.Text = tostring(value)
		if flag then NovaLib.Flags[flag] = value end
		task.spawn(callback, value)
	end

	local function BuildOptions()
		for _, b in ipairs(optionButtons) do b:Destroy() end
		table.clear(optionButtons)
		for _, item in ipairs(items) do
			local optBtn = Create("TextButton", {
				Size = UDim2.new(1, 0, 0, 28),
				BackgroundColor3 = Theme.Tertiary,
				BackgroundTransparency = 0.35,
				FontFace = NovaLib.Fonts.Medium,
				Text = "",
				AutoButtonColor = false,
				Parent = listHolder,
			})
			Round(optBtn, 7)

			Create("TextLabel", {
				Name = "Label",
				Size = UDim2.new(1, -40, 1, 0),
				Position = UDim2.new(0, 12, 0, 0),
				BackgroundTransparency = 1,
				FontFace = NovaLib.Fonts.Medium,
				Text = tostring(item),
				TextColor3 = Theme.Text,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = optBtn,
			})

			local checkContainer = Create("Frame", {
				Name = "Check",
				Size = UDim2.new(0, 20, 1, 0),
				Position = UDim2.new(1, -26, 0, 0),
				BackgroundTransparency = 1,
				Parent = optBtn,
			})
			local checkIcon = CreateIcon(checkContainer, "check", Theme.Text, 14)
			if checkIcon then
				checkIcon.Name = "CheckIcon"
				checkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				checkIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
			end

			local isSelected = tostring(item) == tostring(selected)
			if checkIcon then
				checkIcon.ImageTransparency = isSelected and 0 or 1
			end

			optBtn.MouseEnter:Connect(function()
				Tween(optBtn, { BackgroundTransparency = 0, BackgroundColor3 = Theme.Hover }, 0.15)
			end)
			optBtn.MouseLeave:Connect(function()
				Tween(optBtn, { BackgroundTransparency = 0.35, BackgroundColor3 = Theme.Tertiary }, 0.15)
			end)
			optBtn.MouseButton1Click:Connect(function()
				Set(item)
				for _, b in ipairs(optionButtons) do
					local otherCheck = b:FindFirstChild("Check")
					local otherIcon = otherCheck and otherCheck:FindFirstChild("CheckIcon")
					if otherIcon then
						otherIcon.ImageTransparency = 1
					end
				end
				if checkIcon then
					checkIcon.ImageTransparency = 0
				end
				CloseList()
			end)
			table.insert(optionButtons, optBtn)
		end
	end
	BuildOptions()

	header.MouseButton1Click:Connect(function()
		open = not open
		if open then
			local listHeight = #items * 31 + 10
			Tween(frame, { Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small + 6 + listHeight) }, 0.3, Enum.EasingStyle.Quint)
			Tween(arrow, { Rotation = 180 }, 0.28)
			Tween(frameStroke, { Color = Theme.StrokeLight, Transparency = 0.1 }, 0.28)

			for i, optBtn in ipairs(optionButtons) do
				optBtn.BackgroundTransparency = 1
				local optLabel = optBtn:FindFirstChild("Label")
				local optCheck = optBtn:FindFirstChild("Check")
				local optIcon = optCheck and optCheck:FindFirstChild("CheckIcon")
				local checkVisible = tostring(items[i]) == tostring(selected)

				if optLabel then optLabel.TextTransparency = 1 end
				if optIcon then optIcon.ImageTransparency = 1 end

				task.delay((i - 1) * 0.02, function()
					if not open then return end
					Tween(optBtn, { BackgroundTransparency = 0.35 }, 0.2)
					if optLabel then Tween(optLabel, { TextTransparency = 0 }, 0.2) end
					if optIcon and checkVisible then
						Tween(optIcon, { ImageTransparency = 0 }, 0.2)
					end
				end)
			end
		else
			CloseList()
		end
	end)

	if flag then
		NovaLib.Flags[flag] = selected
		self.Window.Callbacks[flag] = Set
	end

	local Dropdown = {}
	Dropdown.Set = function(_, v) Set(v) end
	Dropdown.Get = function() return selected end
	Dropdown.Refresh = function(_, newItems)
		items = newItems
		BuildOptions()
	end
	return Dropdown
end

--// TextBox / Input
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

--// Keybind
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

--// Color Picker (RGB sliders, asset-free)
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
