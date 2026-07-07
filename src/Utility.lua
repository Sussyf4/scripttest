--// Utility ------------------------------------------------------------------

local function Create(class, props, children)
	local obj = Instance.new(class)
	for k, v in pairs(props or {}) do
		if k == "FontFace" then
			local success = pcall(function()
				obj.FontFace = v
			end)
			if not success then
				local fontName = tostring(v)
				local fallback = Enum.Font.Gotham
				if string.find(fontName, "PressStart2P") or string.find(fontName, "Pixel") then
					fallback = Enum.Font.Code
				elseif string.find(fontName, "VT323") or string.find(fontName, "Terminal") then
					fallback = Enum.Font.Code
				elseif string.find(fontName, "SourGummy") then
					fallback = Enum.Font.GothamMedium
				end
				pcall(function()
					obj.Font = fallback
				end)
			end
		else
			obj[k] = v
		end
	end
	for _, child in ipairs(children or {}) do
		child.Parent = obj
	end
	return obj
end

local function Tween(obj, props, duration, style, dir)
	local tween = TweenService:Create(
		obj,
		TweenInfo.new(duration or 0.25, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
		props
	)
	tween:Play()
	return tween
end

local function Round(frame, radius)
	return Create("UICorner", { CornerRadius = UDim.new(0, radius or 6), Parent = frame })
end

local function Stroke(frame, color, thickness, transparency)
	return Create("UIStroke", {
		Color = color or Theme.Stroke,
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = frame,
	})
end

-- subtle vertical sheen so surfaces don't look flat (pure UIGradient, no assets)
local function Sheen(frame, intensity)
	return Create("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
		}),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1 - (intensity or 0.04)),
			NumberSequenceKeypoint.new(1, 1),
		}),
		Parent = frame,
	})
end

-- fake drop shadow: black frame offset +3,+3 behind the target (no assets)
local function Shadow(frame, radius, transparency)
	local shadow = Create("Frame", {
		Name = "Shadow",
		AnchorPoint = frame.AnchorPoint,
		Position = frame.Position + UDim2.new(0, 3, 0, 3),
		Size = frame.Size,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = transparency or 0.8,
		BorderSizePixel = 0,
		ZIndex = math.max(1, (frame.ZIndex or 1) - 1),
		Parent = frame.Parent,
	})
	Round(shadow, radius or 6)
	return shadow
end

local function GetParentGui()
	local ok, gui = pcall(function()
		if gethui then return gethui() end
		return CoreGui
	end)
	if ok and gui then return gui end
	return LocalPlayer:WaitForChild("PlayerGui")
end

local function ProtectGui(gui)
	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(gui)
			gui.Parent = CoreGui
		elseif gethui then
			gui.Parent = gethui()
		else
			gui.Parent = GetParentGui()
		end
	end)
	if not gui.Parent then
		gui.Parent = GetParentGui()
	end
end

local function MakeDraggable(dragHandle, moveTarget, connections)
	local dragging, dragStart, startPos

	local beganConn = dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = moveTarget.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	-- set position directly (no tweens) so dragging stays perfectly smooth
	local changedConn = UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			moveTarget.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)

	if connections then
		table.insert(connections, beganConn)
		table.insert(connections, changedConn)
	end
end

local function CreateIcon(parent, iconName, color, size)
	local iconId = NovaLib:GetIcon(iconName)
	if not iconId then return nil end
	local img = Create("ImageLabel", {
		Name = iconName .. "Icon",
		Size = UDim2.new(0, size or 16, 0, size or 16),
		BackgroundTransparency = 1,
		Image = iconId,
		ImageColor3 = color or Theme.Text,
		Parent = parent,
	})
	return img
end


