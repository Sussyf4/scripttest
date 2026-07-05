--// Intro (letter-by-letter pixel reveal on black, no loading indicators) -----

local function PlayIntro(titleText, _subText)
	local introGui = Create("ScreenGui", {
		Name = "NovaIntro",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(introGui)

	local backdrop = Create("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = introGui,
	})

	local logo = Create("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -40, 0, 60),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Pixel,
		Text = "",
		TextColor3 = Theme.Text,
		TextSize = 42,
		Parent = introGui,
	})

	-- tiny glow behind the letters (soft accent stroke, no assets)
	Create("UIStroke", {
		Color = Theme.AccentGlow,
		Thickness = 1,
		Transparency = 0.85,
		Parent = logo,
	})

	-- black backdrop fades in first
	Tween(backdrop, { BackgroundTransparency = 0 }, 0.35)
	task.wait(0.35)

	-- letters appear one by one: N -> No -> Nov -> Nova
	for i = 1, #titleText do
		logo.Text = string.sub(titleText, 1, i)
		task.wait(0.05)
	end

	-- hold
	task.wait(1.2)

	-- letters disappear one by one: Nova -> Nov -> No -> N
	for i = #titleText - 1, 0, -1 do
		logo.Text = string.sub(titleText, 1, i)
		task.wait(0.05)
	end

	-- fade the backdrop away
	Tween(backdrop, { BackgroundTransparency = 1 }, 0.4)
	task.wait(0.45)
	introGui:Destroy()
end
