--// Tab Creation Component ---------------------------------------------------

function WindowProto:CreateTab(tabOptions)
	tabOptions = tabOptions or {}
	local tabName = tabOptions.Name or "Tab"

	local TabObj = setmetatable({}, Tab)
	TabObj.Name = tabName
	TabObj.Window = self

	local tabButton = Create("TextButton", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = Theme.Tertiary,
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = self.TabList,
	})
	Round(tabButton, 8)

	local indicator = Create("Frame", {
		Size = UDim2.new(0, 3, 0, 0),
		Position = UDim2.new(0, 3, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Accent,
		Parent = tabButton,
	})
	Round(indicator, 2)

	-- Optional customizable tab icon from Lucide
	local tabIconId = tabOptions.Icon and NovaLib:GetIcon(tabOptions.Icon) or nil
	local tabLabelOffset = 14
	local tabIconImg
	if tabIconId then
		tabLabelOffset = 36
		tabIconImg = Create("ImageLabel", {
			Name = "TabIcon",
			Size = UDim2.new(0, 16, 0, 16),
			Position = UDim2.new(0, 14, 0.5, -8),
			BackgroundTransparency = 1,
			Image = tabIconId,
			ImageColor3 = Theme.SubText,
			Parent = tabButton,
		})
	end

	local tabLabel = Create("TextLabel", {
		Size = UDim2.new(1, -tabLabelOffset - 10, 1, 0),
		Position = UDim2.new(0, tabLabelOffset, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = tabName,
		TextColor3 = Theme.SubText,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = tabButton,
	})

	local page = Create("ScrollingFrame", {
		Name = tabName,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageTransparency = 0.5,
		ScrollBarImageColor3 = Theme.StrokeLight,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Visible = false,
		Parent = self.Content,
	}, {
		Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		}),
		Create("UIPadding", {
			PaddingRight = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 6),
		}),
	})

	local function Activate()
		for _, other in ipairs(self.Tabs) do
			other.Page.Visible = false
			other.Button.BackgroundTransparency = 1
			Tween(other.Label, { TextColor3 = Theme.SubText }, 0.2)
			Tween(other.Indicator, { Size = UDim2.new(0, 3, 0, 0) }, 0.2)
			if other.IconImage then
				Tween(other.IconImage, { ImageColor3 = Theme.SubText }, 0.2)
			end
		end
		page.Visible = true
		self.ActiveTab = TabObj
		tabButton.BackgroundTransparency = 0
		Tween(tabLabel, { TextColor3 = Theme.Text }, 0.2)
		Tween(indicator, { Size = UDim2.new(0, 3, 1, -10) }, 0.25)
		if tabIconImg then
			Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.25)
		end
	end

	tabButton.MouseButton1Click:Connect(Activate)
	tabButton.MouseEnter:Connect(function()
		if self.ActiveTab ~= TabObj then
			Tween(tabLabel, { TextColor3 = Theme.Text }, 0.15)
			if tabIconImg then
				Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.15)
			end
		end
	end)
	tabButton.MouseLeave:Connect(function()
		if self.ActiveTab ~= TabObj then
			Tween(tabLabel, { TextColor3 = Theme.SubText }, 0.15)
			if tabIconImg then
				Tween(tabIconImg, { ImageColor3 = Theme.SubText }, 0.15)
			end
		end
	end)

	TabObj.Button = tabButton
	TabObj.Label = tabLabel
	TabObj.Indicator = indicator
	TabObj.IconImage = tabIconImg
	TabObj.Page = page
	table.insert(self.Tabs, TabObj)

	if #self.Tabs == 1 then
		Activate()
	end

	return TabObj
end
