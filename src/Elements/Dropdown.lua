--// Dropdown Element ----------------------------------------------------------

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

	-- selected value in a pill badge
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
