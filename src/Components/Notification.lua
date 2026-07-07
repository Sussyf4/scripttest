--// Notification Component (Solid style + Queue stack) -----------------------

local NotifyGui, NotifyHolder
local activeCount = 0
local pendingQueue = {}

local function EnsureNotifyGui()
	if NotifyGui and NotifyGui.Parent then return end
	NotifyGui = Create("ScreenGui", {
		Name = "NovaNotify",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(NotifyGui)

	local pos = NovaLib.NotificationPosition or "BottomRight"
	local anchor, position, vertAlign, horizAlign
	
	if pos == "TopRight" then
		anchor = Vector2.new(1, 0)
		position = UDim2.new(1, -24, 0, 24)
		vertAlign = Enum.VerticalAlignment.Top
		horizAlign = Enum.HorizontalAlignment.Right
	elseif pos == "TopLeft" then
		anchor = Vector2.new(0, 0)
		position = UDim2.new(0, 24, 0, 24)
		vertAlign = Enum.VerticalAlignment.Top
		horizAlign = Enum.HorizontalAlignment.Left
	elseif pos == "BottomLeft" then
		anchor = Vector2.new(0, 1)
		position = UDim2.new(0, 24, 1, -24)
		vertAlign = Enum.VerticalAlignment.Bottom
		horizAlign = Enum.HorizontalAlignment.Left
	else -- BottomRight
		anchor = Vector2.new(1, 1)
		position = UDim2.new(1, -24, 1, -24)
		vertAlign = Enum.VerticalAlignment.Bottom
		horizAlign = Enum.HorizontalAlignment.Right
	end

	NotifyHolder = Create("Frame", {
		Name = "Holder",
		AnchorPoint = anchor,
		Position = position,
		Size = UDim2.new(0, 300, 1, -48),
		BackgroundTransparency = 1,
		Parent = NotifyGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = horizAlign,
			VerticalAlignment = vertAlign,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		}),
	})
end

function NovaLib:Notify(options)
	options = options or {}
	
	-- Queue logic check
	if activeCount >= (NovaLib.NotificationLimit or 3) then
		table.insert(pendingQueue, options)
		return
	end
	
	activeCount = activeCount + 1
	EnsureNotifyGui()

	local title = options.Title or "Notification"
	local content = options.Content or ""
	local duration = options.Duration or 4
	local notifType = options.Type or "Info" -- Success, Error, Warning, Info

	-- Card container wrapper
	local wrapper = Create("Frame", {
		Name = "NotifWrapper",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = NotifyHolder,
	})

	local pos = NovaLib.NotificationPosition or "BottomRight"
	local isLeft = (pos == "TopLeft" or pos == "BottomLeft")
	local startOffset = isLeft and -120 or 120

	local card = Create("Frame", {
		Name = "Card",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.new(0, startOffset, 0, 0), -- slide offscreen offset
		BackgroundColor3 = Theme.Secondary,
		BackgroundTransparency = 0, -- solid background
		Parent = wrapper,
	})
	Round(card, 8)
	local cardStroke = Stroke(card, Theme.StrokeLight, 1, 0.3)
	Sheen(card, 0.03)

	local shadow = Shadow(card, 8, 0.85)

	-- Accent configuration
	local typeColor = Theme.Accent
	local iconName = "info"
	if notifType == "Success" or notifType == "success" then
		typeColor = Color3.fromRGB(25, 200, 80)
		iconName = "check-circle"
	elseif notifType == "Error" or notifType == "error" then
		typeColor = Color3.fromRGB(200, 50, 50)
		iconName = "alert-circle"
	elseif notifType == "Warning" or notifType == "warning" then
		typeColor = Color3.fromRGB(220, 140, 0)
		iconName = "alert-triangle"
	else -- Info / info
		typeColor = Color3.fromRGB(60, 120, 255)
		iconName = "info"
	end

	-- Accent left border strip
	local accentBar = Create("Frame", {
		Name = "AccentBar",
		Size = UDim2.new(0, 4, 0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = typeColor,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = card,
	})
	Round(accentBar, 4)
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

	-- Status icon
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

	-- Text frame (leave space for close button)
	local textFrame = Create("Frame", {
		Size = UDim2.new(1, -54, 0, 0),
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

	-- Progress bar
	local progressBar = Create("Frame", {
		Name = "ProgressBar",
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		BackgroundColor3 = typeColor,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = card,
	})
	Round(progressBar, 1)

	local isHovered = false
	card.MouseEnter:Connect(function() isHovered = true end)
	card.MouseLeave:Connect(function() isHovered = false end)

	card:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		accentBar.Size = UDim2.new(0, 4, 0, card.AbsoluteSize.Y)
		shadow.Size = UDim2.new(0, card.AbsoluteSize.X, 0, card.AbsoluteSize.Y)
	end)

	-- Slide in
	Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween(shadow, { Position = UDim2.new(0, 2, 0, 2) }, 0.4, Enum.EasingStyle.Quint)

	local connection
	local function Dismiss()
		if connection then
			connection:Disconnect()
			connection = nil
		end
		
		-- Slide out
		Tween(card, { Position = UDim2.new(0, startOffset, 0, 0) }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		Tween(shadow, { Position = UDim2.new(0, startOffset + 2, 0, 2) }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		task.wait(0.4)
		wrapper:Destroy()

		-- Dequeue next
		activeCount = activeCount - 1
		if #pendingQueue > 0 then
			local nextOptions = table.remove(pendingQueue, 1)
			NovaLib:Notify(nextOptions)
		end
	end

	-- Dismiss Button
	local dismissBtn = Create("TextButton", {
		Name = "DismissBtn",
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(1, -22, 0, 8),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 4,
		AutoButtonColor = false,
		Parent = card,
	})
	local dismissIcon = CreateIcon(dismissBtn, "x", Theme.SubText, 10)
	if dismissIcon then
		dismissIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		dismissIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	end

	dismissBtn.MouseEnter:Connect(function()
		if dismissIcon then Tween(dismissIcon, { ImageColor3 = Theme.Text }, 0.15) end
	end)
	dismissBtn.MouseLeave:Connect(function()
		if dismissIcon then Tween(dismissIcon, { ImageColor3 = Theme.SubText }, 0.15) end
	end)
	dismissBtn.MouseButton1Click:Connect(Dismiss)

	-- Auto dismiss countdown
	local totalTime = duration
	local timeLeft = duration
	connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
		if not card or not card.Parent then
			if connection then connection:Disconnect() end
			return
		end
		if not isHovered then
			timeLeft = timeLeft - dt
			progressBar.Size = UDim2.new(math.clamp(timeLeft / totalTime, 0, 1), 0, 0, 2)
			if timeLeft <= 0 then
				if connection then connection:Disconnect() end
				Dismiss()
			end
		end
	end)
end
