--// Section Component ---------------------------------------------------------

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
