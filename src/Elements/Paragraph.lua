--// Paragraph & Label Elements -----------------------------------------------

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
