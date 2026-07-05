--// Notifications ------------------------------------------------------------

local NotifyGui, NotifyHolder

local function EnsureNotifyGui()
	if NotifyGui and NotifyGui.Parent then return end
	NotifyGui = Create("ScreenGui", {
		Name = "NovaNotify",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(NotifyGui)

	-- cards stack bottom-right of the screen
	NotifyHolder = Create("Frame", {
		Name = "Holder",
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -24, 1, -24),
		Size = UDim2.new(0, 280, 1, -48),
		BackgroundTransparency = 1,
		Parent = NotifyGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
		}),
	})
end

function NovaLib:Notify(options)
	options = options or {}
	local title = options.Title or "Notification"
	local content = options.Content or ""
	local duration = options.Duration or 4
	local notifType = options.Type or "Info" -- Success, Error, Warning, Info

	EnsureNotifyGui()

	-- Card container wrapper (so UIListLayout works nicely with sliding animations)
	local wrapper = Create("Frame", {
		Name = "NotifWrapper",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = NotifyHolder,
	})

	local card = Create("Frame", {
		Name = "Card",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.new(1.2, 0, 0, 0), -- slide offscreen initially
		BackgroundColor3 = Theme.Secondary,
		BackgroundTransparency = 0.25, -- glass card toast look
		Parent = wrapper,
	})
	Round(card, 8)
	local cardStroke = Stroke(card, Theme.StrokeLight, 1, 0.3)
	Sheen(card, 0.03)

	local shadow = Shadow(card, 8, 0.85)

	-- Accent vertical strip on the left edge
	local typeColor = Theme.Accent
	local iconName = "info"
	if notifType == "Success" then
		typeColor = Theme.Success
		iconName = "check-circle"
	elseif notifType == "Error" then
		typeColor = Theme.Error
		iconName = "x-circle"
	elseif notifType == "Warning" then
		typeColor = Theme.Warning
		iconName = "alert-triangle"
	end

	local accentBar = Create("Frame", {
		Name = "AccentBar",
		Size = UDim2.new(0, 4, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = typeColor,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = card,
	})
	Round(accentBar, 4)
	-- square off the right side of the accent bar so it fits the card left edge
	Create("Frame", {
		Size = UDim2.new(0, 2, 1, 0),
		Position = UDim2.new(1, -2, 0, 0),
		BackgroundColor3 = typeColor,
		BorderSizePixel = 0,
		Parent = accentBar,
	})

	-- Content frame with padding
	local contentFrame = Create("Frame", {
		Name = "ContentFrame",
		Size = UDim2.new(1, -12, 0, 0),
		Position = UDim2.new(0, 12, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = card,
	})
	Create("UIPadding", {
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 10),
		Parent = contentFrame,
	})
	Create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 10),
		Parent = contentFrame,
	})

	-- Status Lucide icon
	local iconCircle = Create("Frame", {
		Size = UDim2.new(0, 26, 0, 26),
		BackgroundColor3 = typeColor,
		BackgroundTransparency = 0.85,
		LayoutOrder = 1,
		Parent = contentFrame,
	})
	Round(iconCircle, 13)
	Stroke(iconCircle, typeColor, 1, 0.4)

	local icon = CreateIcon(iconCircle, iconName, typeColor, 14)
	if icon then
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	end

	-- Text frame containing title & description
	local textFrame = Create("Frame", {
		Size = UDim2.new(1, -36, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Parent = contentFrame,
	})
	Create("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 2),
		Parent = textFrame,
	})

	local titleLabel = Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Bold,
		Text = title,
		TextColor3 = Theme.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		LayoutOrder = 1,
		Parent = textFrame,
	})

	if content ~= "" then
		Create("TextLabel", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Body,
			Text = content,
			TextColor3 = Theme.SubText,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			LayoutOrder = 2,
			Parent = textFrame,
		})
	end

	-- Slide & Fade In
	Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.4, Enum.EasingStyle.Quint)
	Tween(shadow, { Position = UDim2.new(0, 2, 0, 2) }, 0.4, Enum.EasingStyle.Quint)

	-- Hold, then Slide & Fade Out
	task.delay(duration, function()
		Tween(card, { Position = UDim2.new(1.2, 0, 0, 0) }, 0.35, Enum.EasingStyle.Quint)
		Tween(shadow, { Position = UDim2.new(1.2, 2, 0, 2) }, 0.35, Enum.EasingStyle.Quint)
		task.wait(0.4)
		wrapper:Destroy()
	end)
end
