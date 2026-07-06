--// Button Element -----------------------------------------------------------

function Tab:CreateButton(bOptions)
	bOptions = bOptions or {}
	local page = self.Page
	local callback = bOptions.Callback or function() end

	local frame = ElementBase(page, NovaLib.Sizes.Small)

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
