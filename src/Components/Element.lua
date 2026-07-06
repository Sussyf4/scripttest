--// Element Base Helpers --------------------------------------------------------

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
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = parent,
	})
end
