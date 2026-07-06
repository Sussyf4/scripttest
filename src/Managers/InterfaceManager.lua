--// Interface theme and settings manager -------------------------------------

function WindowProto:SetTheme(name)
	local newTheme = NovaLib.Themes[name]
	if not newTheme then return end
	local oldTheme = Theme
	Theme = newTheme

	local map = {}
	for key, color in pairs(oldTheme) do
		if typeof(color) == "Color3" then
			map[tostring(color)] = key
		end
	end

	local function Remap(color)
		local key = map[tostring(color)]
		return key and newTheme[key] or nil
	end

	for _, obj in ipairs(self.Gui:GetDescendants()) do
		pcall(function()
			if obj:IsA("GuiObject") then
				local bg = Remap(obj.BackgroundColor3)
				if bg then obj.BackgroundColor3 = bg end
			end
			if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
				local tc = Remap(obj.TextColor3)
				if tc then obj.TextColor3 = tc end
			end
			if obj:IsA("ImageLabel") then
				local ic = Remap(obj.ImageColor3)
				if ic then obj.ImageColor3 = ic end
			end
			if obj:IsA("TextBox") then
				local pc = Remap(obj.PlaceholderColor3)
				if pc then obj.PlaceholderColor3 = pc end
			end
			if obj:IsA("UIStroke") then
				local sc = Remap(obj.Color)
				if sc then obj.Color = sc end
			end
			if obj:IsA("ScrollingFrame") then
				local sb = Remap(obj.ScrollBarImageColor3)
				if sb then obj.ScrollBarImageColor3 = sb end
			end
		end)
	end

	NovaLib:Notify({
		Title = "Theme",
		Content = "Theme set to " .. name .. ".",
		Type = "Info",
	})
end
