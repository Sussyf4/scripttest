local Nova = loadstring(game:HttpGet(
	"https://github.com/Sussyf4/scripttest/raw/refs/heads/main/NovaLib.lua"
))()

-- Create the window (intro loading animation plays automatically)
local Window = Nova:CreateWindow({
	Title = "Nova Hub",
	SubTitle = "by you",
	Theme = "Black",             -- "Black" | "Dark" | "Light" | "Midnight"
	ToggleKey = Enum.KeyCode.RightControl,
	Intro = true,
	IntroText = "Loading Nova Hub...",
})

--// ===================== MAIN TAB =====================
local MainTab = Window:CreateTab({ Name = "Main" })

MainTab:CreateSection("Player")

MainTab:CreateToggle({
	Name = "Speed Boost",
	Default = false,
	Flag = "SpeedBoost",
	Callback = function(state)
		local hum = game.Players.LocalPlayer.Character
			and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state and 50 or 16
		end
	end,
})

MainTab:CreateSlider({
	Name = "Walk Speed",
	Min = 16,
	Max = 200,
	Increment = 1,
	Default = 16,
	Flag = "WalkSpeed",
	Callback = function(value)
		local hum = game.Players.LocalPlayer.Character
			and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = value end
	end,
})

MainTab:CreateSlider({
	Name = "Jump Power",
	Min = 50,
	Max = 300,
	Increment = 5,
	Default = 50,
	Flag = "JumpPower",
	Callback = function(value)
		local hum = game.Players.LocalPlayer.Character
			and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = value
		end
	end,
})

MainTab:CreateButton({
	Name = "Reset Character",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if char then char:BreakJoints() end
		Window:Notify({ Title = "Reset", Content = "Character has been reset.", Type = "Success" })
	end,
})

--// ===================== VISUALS TAB =====================
local VisualsTab = Window:CreateTab({ Name = "Visuals" })

VisualsTab:CreateSection("Appearance")

VisualsTab:CreateDropdown({
	Name = "Time of Day",
	Options = { "Morning", "Noon", "Evening", "Night" },
	Default = "Noon",
	Flag = "TimeOfDay",
	Callback = function(option)
		local times = { Morning = 8, Noon = 12, Evening = 18, Night = 0 }
		game.Lighting.ClockTime = times[option] or 12
	end,
})

VisualsTab:CreateColorPicker({
	Name = "Ambient Color",
	Default = Color3.fromRGB(130, 130, 130),
	Flag = "AmbientColor",
	Callback = function(color)
		game.Lighting.Ambient = color
	end,
})

VisualsTab:CreateSlider({
	Name = "Field of View",
	Min = 70,
	Max = 120,
	Increment = 1,
	Default = 70,
	Flag = "FOV",
	Callback = function(value)
		workspace.CurrentCamera.FieldOfView = value
	end,
})

--// ===================== SETTINGS TAB =====================
local SettingsTab = Window:CreateTab({ Name = "Settings" })

SettingsTab:CreateSection("Interface")

SettingsTab:CreateKeybind({
	Name = "Test Keybind",
	Default = Enum.KeyCode.F,
	Flag = "TestBind",
	Callback = function(key)
		Window:Notify({ Title = "Keybind", Content = key.Name .. " was pressed!", Type = "Info" })
	end,
})

SettingsTab:CreateInput({
	Name = "Custom Message",
	Placeholder = "Type something...",
	Flag = "CustomMsg",
	Callback = function(text, enterPressed)
		if enterPressed then
			Window:Notify({ Title = "Input", Content = "You typed: " .. text, Type = "Info" })
		end
	end,
})

SettingsTab:CreateDropdown({
	Name = "Theme",
	Options = { "Black", "Dark", "Light", "Midnight" },
	Default = "Black",
	Flag = "UITheme",
	Callback = function(option)
		Window:SetTheme(option) -- applies live, no reopen needed
	end,
})

SettingsTab:CreateSection("Configuration")

SettingsTab:CreateButton({
	Name = "Save Config",
	Icon = "save",
	Callback = function() Window:SaveConfig("myconfig") end,
})

SettingsTab:CreateButton({
	Name = "Load Config",
	Icon = "file",
	Callback = function() Window:LoadConfig("myconfig") end,
})

SettingsTab:CreateParagraph({
	Title = "About",
	Content = "NovaLib v2.1.0 \"Obsidian\" — a fully asset-free UI library with a pure black theme, live theme switching, a centralized font/icon system, and a letter-by-letter pixel intro.",
})

-- Welcome notification
Window:Notify({
	Title = "Nova Hub",
	Content = "Loaded successfully! Press Right Ctrl to toggle the UI.",
	Duration = 6,
	Type = "Success",
})
