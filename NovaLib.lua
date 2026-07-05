--[[
	NovaLib UI Library
	BUNDLED PRODUCTION BUILD
	Generated at: 2026-07-05 23:18:51
]]

--// File: src/init.lua //--
--[[
	███╗   ██╗ ██████╗ ██╗   ██╗ █████╗ ██╗     ██╗██████╗
	████╗  ██║██╔═══██╗██║   ██║██╔══██╗██║     ██║██╔══██╗
	██╔██╗ ██║██║   ██║██║   ██║███████║██║     ██║██████╔╝
	██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║██║     ██║██╔══██╗
	██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║███████╗██║██████╔╝
	╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚══════╝╚═╝╚═════╝

	NovaLib UI Library v2.3.0 — "Obsidian"
	- Modular development source code
]]

local NovaLib = {}
NovaLib.__index = NovaLib
NovaLib.Version = "2.3.0"
NovaLib.Flags = {}

--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer and LocalPlayer:GetMouse()


--// File: src/Themes.lua //--
--// Themes (pure colors, no assets)
NovaLib.Themes = {
	Black = {
		Background   = Color3.fromRGB(2, 2, 3),
		Secondary    = Color3.fromRGB(9, 9, 11),
		Tertiary     = Color3.fromRGB(17, 17, 21),
		Hover        = Color3.fromRGB(23, 23, 28),
		Border       = Color3.fromRGB(26, 26, 32),
		Card         = Color3.fromRGB(9, 9, 11),
		Surface      = Color3.fromRGB(17, 17, 21),
		Input        = Color3.fromRGB(5, 5, 7),
		Disabled     = Color3.fromRGB(70, 70, 80),
		Accent       = Color3.fromRGB(0, 160, 255),
		AccentDark   = Color3.fromRGB(0, 110, 195),
		AccentGlow   = Color3.fromRGB(60, 190, 255),
		Text         = Color3.fromRGB(245, 245, 250),
		SubText      = Color3.fromRGB(125, 125, 140),
		Stroke       = Color3.fromRGB(26, 26, 32),
		StrokeLight  = Color3.fromRGB(38, 38, 46),
		Success      = Color3.fromRGB(70, 215, 125),
		Error        = Color3.fromRGB(245, 85, 85),
		Warning      = Color3.fromRGB(250, 185, 60),
	},
	Dark = {
		Background   = Color3.fromRGB(14, 14, 18),
		Secondary    = Color3.fromRGB(22, 22, 28),
		Tertiary     = Color3.fromRGB(30, 30, 38),
		Hover        = Color3.fromRGB(38, 38, 48),
		Border       = Color3.fromRGB(44, 44, 55),
		Card         = Color3.fromRGB(22, 22, 28),
		Surface      = Color3.fromRGB(30, 30, 38),
		Input        = Color3.fromRGB(18, 18, 23),
		Disabled     = Color3.fromRGB(90, 90, 105),
		Accent       = Color3.fromRGB(90, 140, 255),
		AccentDark   = Color3.fromRGB(60, 100, 200),
		AccentGlow   = Color3.fromRGB(130, 170, 255),
		Text         = Color3.fromRGB(235, 235, 245),
		SubText      = Color3.fromRGB(150, 150, 165),
		Stroke       = Color3.fromRGB(44, 44, 55),
		StrokeLight  = Color3.fromRGB(58, 58, 72),
		Success      = Color3.fromRGB(80, 200, 120),
		Error        = Color3.fromRGB(235, 87, 87),
		Warning      = Color3.fromRGB(240, 180, 60),
	},
	Light = {
		Background   = Color3.fromRGB(242, 242, 247),
		Secondary    = Color3.fromRGB(230, 230, 237),
		Tertiary     = Color3.fromRGB(216, 216, 226),
		Hover        = Color3.fromRGB(205, 205, 216),
		Border       = Color3.fromRGB(190, 190, 200),
		Card         = Color3.fromRGB(230, 230, 237),
		Surface      = Color3.fromRGB(216, 216, 226),
		Input        = Color3.fromRGB(250, 250, 253),
		Disabled     = Color3.fromRGB(150, 150, 160),
		Accent       = Color3.fromRGB(70, 120, 240),
		AccentDark   = Color3.fromRGB(50, 90, 190),
		AccentGlow   = Color3.fromRGB(110, 155, 250),
		Text         = Color3.fromRGB(25, 25, 35),
		SubText      = Color3.fromRGB(100, 100, 115),
		Stroke       = Color3.fromRGB(190, 190, 200),
		StrokeLight  = Color3.fromRGB(175, 175, 188),
		Success      = Color3.fromRGB(50, 170, 95),
		Error        = Color3.fromRGB(220, 70, 70),
		Warning      = Color3.fromRGB(220, 160, 40),
	},
	Midnight = {
		Background   = Color3.fromRGB(7, 9, 16),
		Secondary    = Color3.fromRGB(13, 17, 28),
		Tertiary     = Color3.fromRGB(21, 27, 42),
		Hover        = Color3.fromRGB(28, 36, 55),
		Border       = Color3.fromRGB(34, 42, 64),
		Card         = Color3.fromRGB(13, 17, 28),
		Surface      = Color3.fromRGB(21, 27, 42),
		Input        = Color3.fromRGB(10, 13, 22),
		Disabled     = Color3.fromRGB(90, 96, 120),
		Accent       = Color3.fromRGB(130, 90, 255),
		AccentDark   = Color3.fromRGB(95, 60, 200),
		AccentGlow   = Color3.fromRGB(165, 130, 255),
		Text         = Color3.fromRGB(230, 230, 245),
		SubText      = Color3.fromRGB(140, 145, 170),
		Stroke       = Color3.fromRGB(34, 42, 64),
		StrokeLight  = Color3.fromRGB(48, 58, 86),
		Success      = Color3.fromRGB(80, 200, 120),
		Error        = Color3.fromRGB(235, 87, 87),
		Warning      = Color3.fromRGB(240, 180, 60),
	},
}

local Theme = NovaLib.Themes.Black


--// File: src/Icons.lua //--
--// Icons — PNG assets hosted on GitHub (loaded via HttpGet)
--// The base URL points to the /assets/ folder in your repo.
--// Change ICON_BASE_URL if you host elsewhere.

local ICON_BASE_URL = "https://raw.githubusercontent.com/Sussyf4/scripttest/main/assets/"

--// All available icons.
--// Format: short-name → PNG filename (no path, just filename).
--// Usage: NovaLib:GetIcon("name") returns the full URL.
NovaLib.Icons = {
	--// Window Controls
	["x"]                   = "x.png",
	["minus"]               = "minus.png",
	["plus"]                = "plus.png",
	["maximize"]            = "maximize.png",
	["maximize-2"]          = "maximize-2.png",
	["minimize"]            = "minimize.png",
	["minimize-2"]          = "minimize-2.png",
	["menu"]                = "menu.png",
	["expand"]              = "expand.png",
	["move-horizontal"]     = "move-horizontal.png",
	["move-vertical"]       = "move-vertical.png",
	["move-diagonal"]       = "move-diagonal.png",
	["move-diagonal-2"]     = "move-diagonal-2.png",

	--// Element Indicators
	["check"]               = "check.png",
	["check-circle"]        = "check-circle.png",
	["check-circle-2"]      = "check-circle-2.png",
	["check-square"]        = "check-square.png",
	["chevron-down"]        = "chevron-down.png",
	["chevron-up"]          = "chevron-up.png",
	["chevron-left"]        = "chevron-left.png",
	["chevron-right"]       = "chevron-right.png",
	["chevron-first"]       = "chevron-first.png",
	["chevron-last"]        = "chevron-last.png",
	["chevrons-down"]       = "chevrons-down.png",
	["chevrons-up"]         = "chevrons-up.png",
	["chevrons-left"]       = "chevrons-left.png",
	["chevrons-right"]      = "chevrons-right.png",
	["chevrons-down-up"]    = "chevrons-down-up.png",
	["chevrons-up-down"]    = "chevrons-up-down.png",
	["chevrons-left-right"] = "chevrons-left-right.png",
	["chevrons-right-left"] = "chevrons-right-left.png",

	--// Notifications & Status
	["info"]                = "info.png",
	["alert-circle"]        = "alert-circle.png",
	["alert-octagon"]       = "alert-octagon.png",
	["alert-triangle"]      = "alert-triangle.png",
	["x-circle"]            = "x-circle.png",
	["minus-circle"]        = "minus-circle.png",
	["plus-circle"]         = "plus-circle.png",
	["plus-square"]         = "plus-square.png",
	["verified"]            = "verified.png",
	["shield"]              = "shield.png",
	["shield-check"]        = "shield-check.png",
	["shield-alert"]        = "shield-alert.png",
	["shield-close"]        = "shield-close.png",

	--// Tabs & Buttons
	["eye"]                 = "eye.png",
	["eye-off"]             = "eye-off.png",
	["settings"]            = "settings.png",
	["settings-2"]          = "settings-2.png",
	["cog"]                 = "cog.png",
	["home"]                = "home.png",
	["search"]              = "search.png",
	["filter"]              = "filter.png",
	["bell"]                = "bell.png",
	["bell-off"]            = "bell-off.png",
	["star"]                = "star.png",
	["heart"]               = "heart.png",
	["sparkles"]            = "star.png",
	["flame"]               = "flame.png",
	["lightbulb"]           = "lightbulb.png",
	["lightbulb-off"]       = "lightbulb-off.png",
	["gem"]                 = "gem.png",
	["rocket"]              = "rocket.png",
	["sword"]               = "sword.png",
	["wand"]                = "wand.png",
	["skull"]               = "skull.png",
	["bomb"]                = "bomb.png",
	["bug"]                 = "bug.png",

	--// User & People
	["user"]                = "user.png",
	["users"]               = "users.png",
	["user-plus"]           = "user-plus.png",
	["user-minus"]          = "user-minus.png",
	["user-check"]          = "user-check.png",
	["bot"]                 = "bot.png",

	--// Actions
	["save"]                = "save.png",
	["download"]            = "download.png",
	["download-cloud"]      = "download-cloud.png",
	["upload"]              = "upload.png",
	["trash"]               = "trash.png",
	["trash-2"]             = "trash-2.png",
	["edit"]                = "edit.png",
	["edit-2"]              = "edit-2.png",
	["edit-3"]              = "edit-3.png",
	["copy"]                = "copy.png",
	["scissors"]            = "scissors.png",
	["clipboard"]           = "clipboard.png",
	["clipboard-check"]     = "clipboard-check.png",
	["clipboard-copy"]      = "clipboard-copy.png",
	["clipboard-x"]         = "clipboard-x.png",
	["undo"]                = "undo.png",
	["undo-2"]              = "undo-2.png",
	["redo"]                = "redo.png",
	["redo-2"]              = "redo-2.png",
	["refresh-cw"]          = "refresh-cw.png",
	["delete"]              = "delete.png",
	["eraser"]              = "eraser.png",
	["import"]              = "import.png",

	--// Arrows & Navigation
	["arrow-up"]            = "arrow-up.png",
	["arrow-down"]          = "arrow-down.png",
	["arrow-left"]          = "arrow-left.png",
	["arrow-right"]         = "arrow-right.png",
	["arrow-up-left"]       = "arrow-up-left.png",
	["arrow-up-right"]      = "arrow-up-right.png",
	["arrow-down-left"]     = "arrow-down-left.png",
	["arrow-down-right"]    = "arrow-down-right.png",
	["arrow-up-circle"]     = "arrow-up-circle.png",
	["arrow-down-circle"]   = "arrow-down-circle.png",
	["arrow-left-circle"]   = "arrow-left-circle.png",
	["arrow-right-circle"]  = "arrow-right-circle.png",
	["arrow-left-right"]    = "arrow-left-right.png",
	["arrow-up-down"]       = "arrow-up-down.png",
	["arrow-big-left"]      = "arrow-big-left.png",
	["arrow-big-right"]     = "arrow-big-right.png",
	["arrow-big-up"]        = "arrow-big-up.png",
	["corner-up-left"]      = "corner-up-left.png",
	["corner-up-right"]     = "corner-up-right.png",
	["corner-down-left"]    = "corner-down-left.png",
	["corner-down-right"]   = "corner-down-right.png",
	["corner-left-up"]      = "corner-left-up.png",
	["corner-left-down"]    = "corner-left-down.png",
	["corner-right-up"]     = "corner-right-up.png",
	["corner-right-down"]   = "corner-right-down.png",
	["navigation"]          = "navigation.png",
	["navigation-2"]        = "navigation-2.png",
	["compass"]             = "compass.png",
	["locate"]              = "locate.png",
	["locate-fixed"]        = "locate-fixed.png",
	["locate-off"]          = "locate-off.png",
	["map"]                 = "map.png",
	["crosshair"]           = "crosshair.png",
	["target"]              = "target.png",
	["focus"]               = "focus.png",
	["mouse-pointer"]       = "mouse-pointer-2.png",
	["mouse-pointer-click"] = "mouse-pointer-click.png",

	--// Files & Folders
	["file"]                = "file.png",
	["folder"]              = "folder.png",
	["folder-open"]         = "folder-open.png",
	["image"]               = "image.png",
	["link"]                = "link.png",
	["link-2"]              = "link-2.png",
	["link-2-off"]          = "link-2-off.png",
	["unlink"]              = "unlink.png",
	["unlink-2"]            = "unlink-2.png",
	["external-link"]       = "external-link.png",
	["inbox"]               = "inbox.png",

	--// Communication
	["message-circle"]      = "message-circle.png",
	["message-square"]      = "message-square.png",
	["phone"]               = "phone.png",
	["mail"]                = "mail.png",
	["mail-open"]           = "mail-open.png",
	["send"]                = "send.png",
	["share"]               = "share.png",
	["share-2"]             = "share-2.png",

	--// Scheduling & Time
	["calendar"]            = "calendar.png",
	["clock"]               = "clock.png",
	["alarm-check"]         = "alarm-check.png",
	["alarm-clock"]         = "alarm-clock.png",
	["alarm-clock-off"]     = "alarm-clock-off.png",
	["alarm-minus"]         = "alarm-minus.png",
	["alarm-plus"]          = "alarm-plus.png",

	--// Labels & Tags
	["tag"]                 = "tag.png",
	["bookmark"]            = "bookmark.png",
	["flag"]                = "flag.png",
	["pin"]                 = "pin.png",

	--// Media & Playback
	["play"]                = "play.png",
	["pause"]               = "pause.png",
	["volume"]              = "volume.png",
	["mic"]                 = "mic.png",
	["camera"]              = "camera.png",
	["rss"]                 = "rss.png",

	--// Data & Infrastructure
	["database"]            = "database.png",
	["server"]              = "server.png",
	["server-cog"]          = "server-cog.png",
	["server-crash"]        = "server-crash.png",
	["server-off"]          = "server-off.png",
	["hard-drive"]          = "hard-drive.png",
	["cpu"]                 = "cpu.png",
	["terminal"]            = "terminal.png",
	["code"]                = "code.png",
	["code-2"]              = "code-2.png",
	["command"]             = "command.png",
	["key"]                 = "key.png",
	["fingerprint"]         = "fingerprint.png",
	["lock"]                = "lock.png",
	["unlock"]              = "unlock.png",
	["wifi"]                = "wifi.png",
	["wifi-off"]            = "wifi-off.png",
	["bluetooth"]           = "bluetooth.png",
	["signal"]              = "signal.png",
	["signal-high"]         = "signal-high.png",
	["signal-medium"]       = "signal-medium.png",
	["signal-low"]          = "signal-low.png",
	["signal-zero"]         = "signal-zero.png",
	["cloud"]               = "cloud.png",
	["cloud-cog"]           = "cloud-cog.png",
	["cloud-drizzle"]       = "cloud-drizzle.png",
	["cloud-fog"]           = "cloud-fog.png",
	["cloud-hail"]          = "cloud-hail.png",
	["cloud-lightning"]     = "cloud-lightning.png",
	["cloud-moon"]          = "cloud-moon.png",
	["cloud-moon-rain"]     = "cloud-moon-rain.png",
	["cloud-off"]           = "cloud-off.png",
	["cloud-rain"]          = "cloud-rain.png",
	["cloud-rain-wind"]     = "cloud-rain-wind.png",
	["cloud-snow"]          = "cloud-snow.png",
	["cloud-sun"]           = "cloud-sun.png",
	["cloud-sun-rain"]      = "cloud-sun-rain.png",
	["cloudy"]              = "cloudy.png",
	["snowflake"]           = "snowflake.png",
	["sun"]                 = "sun.png",
	["sun-dim"]             = "sun-dim.png",
	["moon"]                = "moon.png",
	["power"]               = "power.png",
	["power-off"]           = "power-off.png",
	["electricity"]         = "electricity.png",
	["electricity-off"]     = "electricity-off.png",
	["loader"]              = "loader.png",
	["loader-2"]            = "loader-2.png",

	--// Layout & UI
	["layers"]              = "layers.png",
	["layout"]              = "layout.png",
	["grid"]                = "grid.png",
	["list"]                = "list.png",
	["list-ordered"]        = "list-ordered.png",
	["sliders"]             = "sliders.png",
	["sliders-horizontal"]  = "sliders-horizontal.png",
	["toggle-left"]         = "toggle-left.png",
	["toggle-right"]        = "toggle-right.png",
	["separator-horizontal"] = "separator-horizontal.png",
	["separator-vertical"]  = "separator-vertical.png",
	["sort-asc"]            = "sort-asc.png",
	["sort-desc"]           = "sort-desc.png",
	["scroll"]              = "scroll.png",

	--// Misc
	["accessibility"]       = "accessibility.png",
	["activity"]            = "activity.png",
	["baseline"]            = "baseline.png",
	["bus"]                 = "bus.png",
	["cake"]                = "cake.png",
	["clover"]              = "clover.png",
	["coffee"]              = "coffee.png",
	["copyleft"]            = "copyleft.png",
	["copyright"]           = "copyright.png",
	["crop"]                = "crop.png",
	["gamepad-2"]           = "gamepad-2.png",
	["globe"]               = "globe.png",
	["globe-2"]             = "globe-2.png",
	["inspect"]             = "inspect.png",
	["log-in"]              = "log-in.png",
	["log-out"]             = "log-out.png",
	["package"]             = "package-2.png",
	["palette"]             = "palette.png",
	["plane"]               = "plane.png",
	["wrench"]              = "wrench.png",
	["circle"]              = "circle.png",
	["circle-dot"]          = "circle-dot.png",
	["circle-ellipsis"]     = "circle-ellipsis.png",
	["circle-slashed"]      = "circle-slashed.png",
	["box"]                 = "box.png",
	["boxes"]               = "boxes.png",
	["box-select"]          = "box-select.png",
	["alert-octagon"]       = "alert-octagon.png",
}

--// Base URL setter (call before CreateWindow if you self-host)
function NovaLib:SetIconBaseURL(url)
	ICON_BASE_URL = url
end

function NovaLib:GetIcon(name)
	if not name then return nil end
	-- If it's already a full URL or rbxassetid, pass through
	if name:sub(1, 4) == "http" or name:sub(1, 7) == "rbxasset" then
		return name
	end
	local filename = NovaLib.Icons[name]
	if not filename then return nil end
	return ICON_BASE_URL .. filename
end


--// File: src/Utility.lua //--
--// Utility ------------------------------------------------------------------

local function Create(class, props, children)
	local obj = Instance.new(class)
	for k, v in pairs(props or {}) do
		obj[k] = v
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

--// Config saving ------------------------------------------------------------

local ConfigFolder = "NovaLib"

local function CanUseFiles()
	return writefile ~= nil and readfile ~= nil and isfile ~= nil and makefolder ~= nil and isfolder ~= nil
end

function NovaLib:SaveConfig(name)
	if not CanUseFiles() then return false end
	if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
	local data = {}
	for flag, value in pairs(NovaLib.Flags) do
		if typeof(value) == "Color3" then
			data[flag] = { __type = "Color3", R = value.R, G = value.G, B = value.B }
		elseif typeof(value) == "EnumItem" then
			data[flag] = { __type = "EnumItem", Value = tostring(value) }
		else
			data[flag] = value
		end
	end
	writefile(ConfigFolder .. "/" .. name .. ".json", HttpService:JSONEncode(data))
	return true
end

function NovaLib:LoadConfig(name, applyCallbacks)
	if not CanUseFiles() then return nil end
	local path = ConfigFolder .. "/" .. name .. ".json"
	if not isfile(path) then return nil end
	local ok, data = pcall(function()
		return HttpService:JSONDecode(readfile(path))
	end)
	if not ok then return nil end
	for flag, value in pairs(data) do
		if type(value) == "table" and value.__type == "Color3" then
			value = Color3.new(value.R, value.G, value.B)
		end
		NovaLib.Flags[flag] = value
		if applyCallbacks and applyCallbacks[flag] then
			pcall(applyCallbacks[flag], value)
		end
	end
	return data
end


--// File: src/Intro.lua //--
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


--// File: src/Notifications.lua //--
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


--// File: src/ElementsBase.lua //--
--// Element Base Helpers + Section, Label, Paragraph, Button -----------------

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

--// Section (accent pill + title + divider line)
function Tab:CreateSection(text)
	local page = self.Page
	local window = self.Window

	local holder = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		Parent = page,
	})
	holder:SetAttribute("NovaKeepTransparent", true)

	local pill = Create("Frame", {
		Size = UDim2.new(0, 3, 0, 12),
		Position = UDim2.new(0, 2, 0.5, -6),
		BackgroundColor3 = Theme.SubText,
		Parent = holder,
	})
	Round(pill, 2)

	local secLabel = Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Position = UDim2.new(0, 12, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Mono,
		Text = string.upper(text),
		TextColor3 = Theme.SubText,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Parent = holder,
	})

	local divider = Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -2, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 1),
		BackgroundColor3 = Theme.Stroke,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Parent = holder,
	})

	local function UpdateDivider()
		divider.Size = UDim2.new(0, math.max(0, holder.AbsoluteSize.X - secLabel.AbsoluteSize.X - 32), 0, 1)
	end
	table.insert(window.Connections, holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateDivider))
	table.insert(window.Connections, secLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateDivider))
	task.defer(UpdateDivider)

	return holder
end

--// Label (auto-height, wraps long text cleanly)
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

--// Paragraph
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

--// Button (icon support)
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


--// File: src/ElementsInput.lua //--
--// Toggle & Slider ----------------------------------------------------------

--// Toggle
function Tab:CreateToggle(tOptions)
	tOptions = tOptions or {}
	local page = self.Page
	local flag = tOptions.Flag
	local callback = tOptions.Callback or function() end
	local state = tOptions.Default or false

	local frame = ElementBase(page, NovaLib.Sizes.Small)
	ElementTitle(frame, tOptions.Name or "Toggle", -76)

	local switch = Create("Frame", {
		Size = UDim2.new(0, 42, 0, 22),
		Position = UDim2.new(1, -54, 0.5, -11),
		BackgroundColor3 = state and Theme.Accent or Theme.Tertiary,
		Parent = frame,
	})
	Round(switch, 11)
	local switchStroke = Stroke(switch, state and Theme.Accent or Theme.Stroke, 1, state and 0.4 or 0.3)

	local knob = Create("Frame", {
		Size = UDim2.new(0, 16, 0, 16),
		Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
		BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Theme.SubText,
		Parent = switch,
	})
	Round(knob, 8)

	local clickArea = Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})

	local function Render()
		Tween(switch, { BackgroundColor3 = state and Theme.Accent or Theme.Tertiary }, 0.22)
		Tween(switchStroke, {
			Color = state and Theme.AccentGlow or Theme.Stroke,
			Transparency = state and 0.4 or 0.3,
		}, 0.22)
		Tween(knob, {
			Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
			BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Theme.SubText,
		}, 0.25, Enum.EasingStyle.Circular)
	end

	local function Set(value)
		state = value and true or false
		if flag then NovaLib.Flags[flag] = state end
		Render()
		task.spawn(callback, state)
	end

	clickArea.MouseButton1Click:Connect(function() Set(not state) end)

	local frameStroke = frame:FindFirstChildOfClass("UIStroke")
	clickArea.MouseEnter:Connect(function()
		Tween(frame, { BackgroundColor3 = Theme.Hover }, 0.15)
		if frameStroke then
			Tween(frameStroke, { Transparency = 0.2 }, 0.15)
		end
	end)
	clickArea.MouseLeave:Connect(function()
		Tween(frame, { BackgroundColor3 = Theme.Secondary }, 0.15)
		if frameStroke then
			Tween(frameStroke, { Transparency = 0.4 }, 0.15)
		end
	end)

	if flag then
		NovaLib.Flags[flag] = state
		self.Window.Callbacks[flag] = Set
	end
	if state then task.spawn(callback, state) end

	local Toggle = {}
	Toggle.Set = function(_, v) Set(v) end
	Toggle.Get = function() return state end
	return Toggle
end

--// Slider
function Tab:CreateSlider(sOptions)
	sOptions = sOptions or {}
	local page = self.Page
	local window = self.Window
	local min = sOptions.Min or 0
	local max = sOptions.Max or 100
	local increment = sOptions.Increment or 1
	local flag = sOptions.Flag
	local callback = sOptions.Callback or function() end
	local value = math.clamp(sOptions.Default or min, min, max)

	local frame = ElementBase(page, NovaLib.Sizes.Large)
	Create("TextLabel", {
		Size = UDim2.new(1, -90, 0, 20),
		Position = UDim2.new(0, 14, 0, 8),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = sOptions.Name or "Slider",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = frame,
	})

	local valueBadge = Create("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 20),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -12, 0, 8),
		BackgroundColor3 = Theme.Tertiary,
		Parent = frame,
	})
	Round(valueBadge, 10)
	Stroke(valueBadge, Theme.Stroke, 1, 0.4)
	local valueLabel = Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Bold,
		Text = tostring(value),
		TextColor3 = Theme.Text,
		TextSize = 13,
		Parent = valueBadge,
	})
	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9),
		Parent = valueBadge,
	})

	local track = Create("TextButton", {
		Size = UDim2.new(1, -28, 0, 6),
		Position = UDim2.new(0, 14, 1, -18),
		BackgroundColor3 = Theme.Tertiary,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})
	Round(track, 3)

	local fill = Create("Frame", {
		Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = Theme.Accent,
		Parent = track,
	})
	Round(fill, 3)
	Create("UIGradient", {
		Color = ColorSequence.new(Theme.AccentDark, Theme.Accent),
		Parent = fill,
	})

	local knob = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = 2,
		Parent = fill,
	})
	Round(knob, 6)
	Stroke(knob, Theme.StrokeLight, 2, 0)

	local knobScale = Create("UIScale", { Scale = 1, Parent = knob })

	local function Set(newValue)
		newValue = math.clamp(newValue, min, max)
		newValue = math.floor(newValue / increment + 0.5) * increment
		newValue = tonumber(string.format("%.4f", newValue))
		value = newValue
		valueLabel.Text = tostring(value)
		fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
		if flag then NovaLib.Flags[flag] = value end
		task.spawn(callback, value)
	end

	local sliding = false
	local function UpdateFromInput(inputPos)
		local rel = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		Set(min + (max - min) * rel)
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			sliding = true
			Tween(knobScale, { Scale = 16 / 12 }, 0.15)
			UpdateFromInput(input.Position)
		end
	end)
	table.insert(window.Connections, UserInputService.InputChanged:Connect(function(input)
		if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			UpdateFromInput(input.Position)
		end
	end))
	table.insert(window.Connections, UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			if sliding then
				Tween(knobScale, { Scale = 1 }, 0.15)
			end
			sliding = false
		end
	end))

	if flag then
		NovaLib.Flags[flag] = value
		window.Callbacks[flag] = Set
	end

	local Slider = {}
	Slider.Set = function(_, v) Set(v) end
	Slider.Get = function() return value end
	return Slider
end


--// File: src/ElementsSelect.lua //--
--// Dropdown, Input, Keybind, ColorPicker ------------------------------------

--// Dropdown
function Tab:CreateDropdown(dOptions)
	dOptions = dOptions or {}
	local page = self.Page
	local items = dOptions.Options or {}
	local flag = dOptions.Flag
	local callback = dOptions.Callback or function() end
	local selected = dOptions.Default or nil
	local open = false

	local frame = Create("Frame", {
		Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small),
		BackgroundColor3 = Theme.Secondary,
		ClipsDescendants = true,
		Parent = page,
	})
	Round(frame, 9)
	local frameStroke = Stroke(frame, Theme.Stroke, 1, 0.4)
	Sheen(frame, 0.03)

	local header = Create("TextButton", {
		Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})

	Create("TextLabel", {
		Size = UDim2.new(0.45, -14, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = dOptions.Name or "Dropdown",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = header,
	})

	-- selected value in a pill badge
	local selBadge = Create("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -34, 0.5, 0),
		BackgroundColor3 = Theme.Tertiary,
		Parent = header,
	})
	Round(selBadge, 11)
	Stroke(selBadge, Theme.Stroke, 1, 0.4)
	local selectedLabel = Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = selected and tostring(selected) or "Select...",
		TextColor3 = Theme.SubText,
		TextSize = 13,
		Parent = selBadge,
	})
	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9),
		Parent = selBadge,
	})

	-- Dropdown chevron arrow
	local arrow = Create("Frame", {
		Name = "Arrow",
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(1, -24, 0.5, -10),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		Parent = header,
	})
	local chevron = CreateIcon(arrow, "chevron-down", Theme.SubText, 14)
	if chevron then
		chevron.AnchorPoint = Vector2.new(0.5, 0.5)
		chevron.Position = UDim2.new(0.5, 0, 0.5, 0)
	end

	local listHolder = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 0),
		Position = UDim2.new(0, 10, 0, NovaLib.Sizes.Small + 6),
		BackgroundTransparency = 1,
		Parent = frame,
	}, {
		Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 3),
		}),
	})

	local optionButtons = {}

	local function CloseList()
		open = false
		Tween(frame, { Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small) }, 0.28)
		Tween(arrow, { Rotation = 0 }, 0.28)
		Tween(frameStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.28)
	end

	local function Set(value)
		selected = value
		selectedLabel.Text = tostring(value)
		if flag then NovaLib.Flags[flag] = value end
		task.spawn(callback, value)
	end

	local function BuildOptions()
		for _, b in ipairs(optionButtons) do b:Destroy() end
		table.clear(optionButtons)
		for _, item in ipairs(items) do
			local optBtn = Create("TextButton", {
				Size = UDim2.new(1, 0, 0, 28),
				BackgroundColor3 = Theme.Tertiary,
				BackgroundTransparency = 0.35,
				FontFace = NovaLib.Fonts.Medium,
				Text = "",
				AutoButtonColor = false,
				Parent = listHolder,
			})
			Round(optBtn, 7)

			Create("TextLabel", {
				Name = "Label",
				Size = UDim2.new(1, -40, 1, 0),
				Position = UDim2.new(0, 12, 0, 0),
				BackgroundTransparency = 1,
				FontFace = NovaLib.Fonts.Medium,
				Text = tostring(item),
				TextColor3 = Theme.Text,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = optBtn,
			})

			local checkContainer = Create("Frame", {
				Name = "Check",
				Size = UDim2.new(0, 20, 1, 0),
				Position = UDim2.new(1, -26, 0, 0),
				BackgroundTransparency = 1,
				Parent = optBtn,
			})
			local checkIcon = CreateIcon(checkContainer, "check", Theme.Text, 14)
			if checkIcon then
				checkIcon.Name = "CheckIcon"
				checkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				checkIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
			end

			local isSelected = tostring(item) == tostring(selected)
			if checkIcon then
				checkIcon.ImageTransparency = isSelected and 0 or 1
			end

			optBtn.MouseEnter:Connect(function()
				Tween(optBtn, { BackgroundTransparency = 0, BackgroundColor3 = Theme.Hover }, 0.15)
			end)
			optBtn.MouseLeave:Connect(function()
				Tween(optBtn, { BackgroundTransparency = 0.35, BackgroundColor3 = Theme.Tertiary }, 0.15)
			end)
			optBtn.MouseButton1Click:Connect(function()
				Set(item)
				for _, b in ipairs(optionButtons) do
					local otherCheck = b:FindFirstChild("Check")
					local otherIcon = otherCheck and otherCheck:FindFirstChild("CheckIcon")
					if otherIcon then
						otherIcon.ImageTransparency = 1
					end
				end
				if checkIcon then
					checkIcon.ImageTransparency = 0
				end
				CloseList()
			end)
			table.insert(optionButtons, optBtn)
		end
	end
	BuildOptions()

	header.MouseButton1Click:Connect(function()
		open = not open
		if open then
			local listHeight = #items * 31 + 10
			Tween(frame, { Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small + 6 + listHeight) }, 0.3, Enum.EasingStyle.Quint)
			Tween(arrow, { Rotation = 180 }, 0.28)
			Tween(frameStroke, { Color = Theme.StrokeLight, Transparency = 0.1 }, 0.28)

			for i, optBtn in ipairs(optionButtons) do
				optBtn.BackgroundTransparency = 1
				local optLabel = optBtn:FindFirstChild("Label")
				local optCheck = optBtn:FindFirstChild("Check")
				local optIcon = optCheck and optCheck:FindFirstChild("CheckIcon")
				local checkVisible = tostring(items[i]) == tostring(selected)

				if optLabel then optLabel.TextTransparency = 1 end
				if optIcon then optIcon.ImageTransparency = 1 end

				task.delay((i - 1) * 0.02, function()
					if not open then return end
					Tween(optBtn, { BackgroundTransparency = 0.35 }, 0.2)
					if optLabel then Tween(optLabel, { TextTransparency = 0 }, 0.2) end
					if optIcon and checkVisible then
						Tween(optIcon, { ImageTransparency = 0 }, 0.2)
					end
				end)
			end
		else
			CloseList()
		end
	end)

	if flag then
		NovaLib.Flags[flag] = selected
		self.Window.Callbacks[flag] = Set
	end

	local Dropdown = {}
	Dropdown.Set = function(_, v) Set(v) end
	Dropdown.Get = function() return selected end
	Dropdown.Refresh = function(_, newItems)
		items = newItems
		BuildOptions()
	end
	return Dropdown
end

--// TextBox / Input
function Tab:CreateInput(iOptions)
	iOptions = iOptions or {}
	local page = self.Page
	local flag = iOptions.Flag
	local callback = iOptions.Callback or function() end

	local frame = ElementBase(page, NovaLib.Sizes.Normal)
	Create("TextLabel", {
		Size = UDim2.new(0.42, -14, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = iOptions.Name or "Input",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = frame,
	})

	local boxHolder = Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0.52, -20, 0, 28),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundColor3 = Theme.Background,
		Parent = frame,
	})
	Round(boxHolder, 7)
	local boxStroke = Stroke(boxHolder, Theme.Stroke, 1, 0.4)

	local box = Create("TextBox", {
		Size = UDim2.new(1, -18, 1, 0),
		Position = UDim2.new(0, 9, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Body,
		PlaceholderText = iOptions.Placeholder or "Type here...",
		PlaceholderColor3 = Theme.SubText,
		Text = iOptions.Default or "",
		TextColor3 = Theme.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = iOptions.ClearOnFocus or false,
		Parent = boxHolder,
	})

	box.Focused:Connect(function()
		Tween(boxStroke, { Color = Theme.StrokeLight, Transparency = 0 }, 0.2)
	end)
	box.FocusLost:Connect(function(enterPressed)
		Tween(boxStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.2)
		if flag then NovaLib.Flags[flag] = box.Text end
		task.spawn(callback, box.Text, enterPressed)
	end)

	if flag then
		NovaLib.Flags[flag] = box.Text
		self.Window.Callbacks[flag] = function(v) box.Text = tostring(v) end
	end

	local Input = {}
	Input.Set = function(_, v) box.Text = tostring(v) end
	Input.Get = function() return box.Text end
	return Input
end

--// Keybind
function Tab:CreateKeybind(kOptions)
	kOptions = kOptions or {}
	local page = self.Page
	local window = self.Window
	local flag = kOptions.Flag
	local callback = kOptions.Callback or function() end
	local currentKey = kOptions.Default or Enum.KeyCode.E
	local listening = false

	local frame = ElementBase(page, NovaLib.Sizes.Small)
	ElementTitle(frame, kOptions.Name or "Keybind", -120)

	local keyBtn = Create("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 92, 0, 26),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundColor3 = Theme.Background,
		FontFace = NovaLib.Fonts.Bold,
		Text = currentKey.Name,
		TextColor3 = Theme.SubText,
		TextSize = 13,
		AutoButtonColor = false,
		Parent = frame,
	})
	Round(keyBtn, 7)
	local keyStroke = Stroke(keyBtn, Theme.Stroke, 1, 0.4)

	keyBtn.MouseButton1Click:Connect(function()
		listening = true
		keyBtn.Text = "Press key..."
		Tween(keyStroke, { Color = Theme.StrokeLight, Transparency = 0 }, 0.2)
	end)

	table.insert(window.Connections, UserInputService.InputBegan:Connect(function(input, processed)
		if listening and input.UserInputType == Enum.UserInputType.Keyboard then
			listening = false
			currentKey = input.KeyCode
			keyBtn.Text = currentKey.Name
			Tween(keyBtn, { BackgroundColor3 = Theme.Background, TextColor3 = Theme.SubText }, 0.2)
			Tween(keyStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.2)
			if flag then NovaLib.Flags[flag] = currentKey.Name end
		elseif not processed and input.KeyCode == currentKey and not listening then
			task.spawn(callback, currentKey)
		end
	end))

	if flag then NovaLib.Flags[flag] = currentKey.Name end

	local Keybind = {}
	Keybind.Set = function(_, keyCode)
		currentKey = keyCode
		keyBtn.Text = keyCode.Name
	end
	Keybind.Get = function() return currentKey end
	return Keybind
end

--// Color Picker (RGB sliders)
function Tab:CreateColorPicker(cOptions)
	cOptions = cOptions or {}
	local page = self.Page
	local window = self.Window
	local flag = cOptions.Flag
	local callback = cOptions.Callback or function() end
	local color = cOptions.Default or Theme.Accent
	local open = false

	local frame = Create("Frame", {
		Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small),
		BackgroundColor3 = Theme.Secondary,
		ClipsDescendants = true,
		Parent = page,
	})
	Round(frame, 9)
	local frameStroke = Stroke(frame, Theme.Stroke, 1, 0.4)
	Sheen(frame, 0.03)

	local header = Create("TextButton", {
		Size = UDim2.new(1, 0, 0, NovaLib.Sizes.Small),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})

	Create("TextLabel", {
		Size = UDim2.new(0.6, -14, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Medium,
		Text = cOptions.Name or "Color",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = header,
	})

	local preview = Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 38, 0, 22),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundColor3 = color,
		Parent = header,
	})
	Round(preview, 6)
	Stroke(preview, Theme.StrokeLight, 1, 0.2)

	local channels = { "R", "G", "B" }
	local channelValues = {
		R = math.floor(color.R * 255),
		G = math.floor(color.G * 255),
		B = math.floor(color.B * 255),
	}
	local channelFills = {}
	local channelLabels = {}

	local function ApplyColor()
		color = Color3.fromRGB(channelValues.R, channelValues.G, channelValues.B)
		preview.BackgroundColor3 = color
		if flag then NovaLib.Flags[flag] = color end
		task.spawn(callback, color)
	end

	for i, ch in ipairs(channels) do
		local yOff = NovaLib.Sizes.Small + 8 + (i - 1) * 30
		Create("TextLabel", {
			Size = UDim2.new(0, 16, 0, 20),
			Position = UDim2.new(0, 14, 0, yOff),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Bold,
			Text = ch,
			TextColor3 = Theme.SubText,
			TextSize = 13,
			Parent = frame,
		})

		local track = Create("TextButton", {
			Size = UDim2.new(1, -104, 0, 6),
			Position = UDim2.new(0, 36, 0, yOff + 7),
			BackgroundColor3 = Theme.Tertiary,
			Text = "",
			AutoButtonColor = false,
			Parent = frame,
		})
		Round(track, 3)

		local chColor = ch == "R" and Color3.fromRGB(235, 87, 87)
			or ch == "G" and Color3.fromRGB(80, 200, 120)
			or Color3.fromRGB(90, 140, 255)

		local fill = Create("Frame", {
			Size = UDim2.new(channelValues[ch] / 255, 0, 1, 0),
			BackgroundColor3 = chColor,
			Parent = track,
		})
		Round(fill, 3)
		channelFills[ch] = fill

		local valLabel = Create("TextLabel", {
			Size = UDim2.new(0, 40, 0, 20),
			Position = UDim2.new(1, -54, 0, yOff),
			BackgroundTransparency = 1,
			FontFace = NovaLib.Fonts.Bold,
			Text = tostring(channelValues[ch]),
			TextColor3 = Theme.Text,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Right,
			Parent = frame,
		})
		channelLabels[ch] = valLabel

		local sliding = false
		local function UpdateFromInput(inputPos)
			local rel = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
			channelValues[ch] = math.floor(rel * 255 + 0.5)
			fill.Size = UDim2.new(rel, 0, 1, 0)
			valLabel.Text = tostring(channelValues[ch])
			ApplyColor()
		end

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				sliding = true
				UpdateFromInput(input.Position)
			end
		end)
		table.insert(window.Connections, UserInputService.InputChanged:Connect(function(input)
			if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
				UpdateFromInput(input.Position)
			end
		end))
		table.insert(window.Connections, UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				sliding = false
			end
		end))
	end

	header.MouseButton1Click:Connect(function()
		open = not open
		Tween(frame, { Size = open and UDim2.new(1, 0, 0, NovaLib.Sizes.Small + 104) or UDim2.new(1, 0, 0, NovaLib.Sizes.Small) }, 0.3)
		Tween(frameStroke, {
			Color = open and Theme.StrokeLight or Theme.Stroke,
			Transparency = open and 0.1 or 0.4,
		}, 0.3)
	end)

	local function Set(newColor)
		channelValues.R = math.floor(newColor.R * 255)
		channelValues.G = math.floor(newColor.G * 255)
		channelValues.B = math.floor(newColor.B * 255)
		for _, ch in ipairs(channels) do
			channelFills[ch].Size = UDim2.new(channelValues[ch] / 255, 0, 1, 0)
			channelLabels[ch].Text = tostring(channelValues[ch])
		end
		ApplyColor()
	end

	if flag then
		NovaLib.Flags[flag] = color
		window.Callbacks[flag] = Set
	end

	local ColorPicker = {}
	ColorPicker.Set = function(_, v) Set(v) end
	ColorPicker.Get = function() return color end
	return ColorPicker
end


--// File: src/Window.lua //--
--// Window and Tab Logic ------------------------------------------------------

function NovaLib:CreateWindow(options)
	options = options or {}
	local windowTitle = options.Title or "NovaLib"
	local windowSize = options.Size or UDim2.new(0, 600, 0, 420)
	local themeName = options.Theme or "Black"
	local toggleKey = options.ToggleKey or Enum.KeyCode.RightControl
	local showIntro = options.Intro ~= false

	if NovaLib.Themes[themeName] then
		Theme = NovaLib.Themes[themeName]
	end

	if showIntro then
		PlayIntro(windowTitle, options.IntroText or "Loading interface...")
	end

	local Window = {}
	Window.Tabs = {}
	Window.ActiveTab = nil
	Window.Minimized = false
	Window.Callbacks = {} -- flag -> setter, used for config loading
	Window.Connections = {} -- disconnected on Destroy

	--// Root ScreenGui
	local screenGui = Create("ScreenGui", {
		Name = "NovaLib_" .. HttpService:GenerateGUID(false):sub(1, 8),
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(screenGui)
	Window.Gui = screenGui

	-- CanvasGroup main window container
	local main = Create("CanvasGroup", {
		Name = "Main",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 8),
		Size = windowSize,
		BackgroundColor3 = Theme.Background,
		BackgroundTransparency = 0,
		GroupTransparency = 1,
		Parent = screenGui,
	})
	Round(main, 12)
	local mainStroke = Stroke(main, Theme.StrokeLight, 1, 0.25)

	-- Fake drop shadow
	main.ZIndex = 2
	local windowShadow = Shadow(main, 12, 1)
	windowShadow.ZIndex = 1
	table.insert(Window.Connections, main:GetPropertyChangedSignal("Position"):Connect(function()
		windowShadow.Position = main.Position + UDim2.new(0, 3, 0, 3)
	end))
	table.insert(Window.Connections, main:GetPropertyChangedSignal("Size"):Connect(function()
		windowShadow.Size = main.Size
	end))

	-- Open transition
	Tween(main, {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		GroupTransparency = 0,
	}, 0.4, Enum.EasingStyle.Quint)
	Tween(windowShadow, { BackgroundTransparency = 0.8 }, 0.45)

	--// Top Bar
	local topBar = Create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = Theme.Secondary,
		Parent = main,
	})
	Round(topBar, 12)
	Sheen(topBar, 0.05)
	-- square off bottom
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.new(0, 0, 1, -12),
		BackgroundColor3 = Theme.Secondary,
		BorderSizePixel = 0,
		Parent = topBar,
	})
	-- hairline
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Theme.Stroke,
		BorderSizePixel = 0,
		Parent = topBar,
	})

	local titleHolder = Create("Frame", {
		Size = UDim2.new(1, -110, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		Parent = topBar,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
		}),
	})

	Create("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		FontFace = NovaLib.Fonts.Bold,
		Text = windowTitle,
		TextColor3 = Theme.Text,
		TextSize = 16, -- Title text size 16
		LayoutOrder = 1,
		Parent = titleHolder,
	})

	-- Window control buttons (Close / Minimize) using Lucide assets
	local function WindowButton(iconName, xOffset)
		local btn = Create("TextButton", {
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(1, xOffset, 0.5, -14),
			BackgroundColor3 = Theme.Tertiary,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			Parent = topBar,
		})
		Round(btn, 7)

		local icon = CreateIcon(btn, iconName, Theme.SubText, 14)
		if icon then
			icon.AnchorPoint = Vector2.new(0.5, 0.5)
			icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		end

		btn.MouseEnter:Connect(function()
			Tween(btn, { BackgroundTransparency = 0 }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.Text }, 0.15)
			end
		end)
		btn.MouseLeave:Connect(function()
			Tween(btn, { BackgroundTransparency = 1 }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.SubText }, 0.15)
			end
		end)
		return btn
	end

	local closeBtn = WindowButton("x", -38)
	local minBtn = WindowButton("minus", -70)

	closeBtn.MouseButton1Click:Connect(function()
		Tween(main, {
			Position = main.Position + UDim2.new(0, 0, 0, 8),
			GroupTransparency = 1,
		}, 0.3, Enum.EasingStyle.Quint)
		Tween(windowShadow, { BackgroundTransparency = 1 }, 0.3)
		task.wait(0.35)
		Window:Destroy()
	end)

	local storedSize = windowSize
	minBtn.MouseButton1Click:Connect(function()
		Window.Minimized = not Window.Minimized
		if Window.Minimized then
			storedSize = main.Size
			Tween(main, { Size = UDim2.new(0, storedSize.X.Offset, 0, 44) }, 0.35)
		else
			Tween(main, { Size = storedSize }, 0.35, Enum.EasingStyle.Back)
		end
	end)

	MakeDraggable(topBar, main, Window.Connections)

	table.insert(Window.Connections, UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == toggleKey then
			screenGui.Enabled = not screenGui.Enabled
		end
	end))

	--// Tab Sidebar
	local sidebar = Create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 152, 1, -55),
		Position = UDim2.new(0, 10, 0, 51),
		BackgroundColor3 = Theme.Secondary,
		Parent = main,
	})
	Round(sidebar, 10)
	Stroke(sidebar, Theme.Stroke, 1, 0.5)
	Sheen(sidebar, 0.03)

	local tabList = Create("ScrollingFrame", {
		Size = UDim2.new(1, -10, 1, -10),
		Position = UDim2.new(0, 5, 0, 5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageTransparency = 0.5,
		ScrollBarImageColor3 = Theme.StrokeLight,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Parent = sidebar,
	}, {
		Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		}),
	})

	--// Content Area
	local content = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -182, 1, -55),
		Position = UDim2.new(0, 172, 0, 51),
		BackgroundTransparency = 1,
		Parent = main,
	})

	--// Tab API
	function Window:CreateTab(tabOptions)
		tabOptions = tabOptions or {}
		local tabName = tabOptions.Name or "Tab"

		local TabObj = setmetatable({}, Tab)
		TabObj.Name = tabName
		TabObj.Window = Window

		local tabButton = Create("TextButton", {
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = Theme.Tertiary,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			Parent = tabList,
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
			TextSize = 14, -- Tab text size 14
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
			Parent = content,
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
			for _, other in ipairs(Window.Tabs) do
				other.Page.Visible = false
				other.Button.BackgroundTransparency = 1
				Tween(other.Label, { TextColor3 = Theme.SubText }, 0.2)
				Tween(other.Indicator, { Size = UDim2.new(0, 3, 0, 0) }, 0.2)
				if other.IconImage then
					Tween(other.IconImage, { ImageColor3 = Theme.SubText }, 0.2)
				end
			end
			page.Visible = true
			Window.ActiveTab = TabObj
			tabButton.BackgroundTransparency = 0
			Tween(tabLabel, { TextColor3 = Theme.Text }, 0.2)
			Tween(indicator, { Size = UDim2.new(0, 3, 1, -10) }, 0.25)
			if tabIconImg then
				Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.25)
			end
		end

		tabButton.MouseButton1Click:Connect(Activate)
		tabButton.MouseEnter:Connect(function()
			if Window.ActiveTab ~= TabObj then
				Tween(tabLabel, { TextColor3 = Theme.Text }, 0.15)
				if tabIconImg then
					Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.15)
				end
			end
		end)
		tabButton.MouseLeave:Connect(function()
			if Window.ActiveTab ~= TabObj then
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
		table.insert(Window.Tabs, TabObj)

		if #Window.Tabs == 1 then
			Activate()
		end

		return TabObj
	end

	--// Window-level Helpers
	function Window:Notify(opts) NovaLib:Notify(opts) end

	function Window:SaveConfig(name)
		local ok = NovaLib:SaveConfig(name or "default")
		NovaLib:Notify({
			Title = ok and "Config Saved" or "Save Failed",
			Content = ok and ("Saved to " .. ConfigFolder .. "/" .. (name or "default") .. ".json")
				or "Your executor does not support file functions.",
			Type = ok and "Success" or "Error",
		})
		return ok
	end

	function Window:LoadConfig(name)
		local data = NovaLib:LoadConfig(name or "default", Window.Callbacks)
		NovaLib:Notify({
			Title = data and "Config Loaded" or "Load Failed",
			Content = data and "Your settings have been applied." or "No config found or executor unsupported.",
			Type = data and "Success" or "Error",
		})
		return data
	end

	-- live theme switching remapping
	function Window:SetTheme(name)
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

		for _, obj in ipairs(screenGui:GetDescendants()) do
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

	function Window:Destroy()
		for _, conn in ipairs(Window.Connections) do
			pcall(function() conn:Disconnect() end)
		end
		table.clear(Window.Connections)
		screenGui:Destroy()
	end

	return Window
end


return NovaLib
