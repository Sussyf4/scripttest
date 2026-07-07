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
NovaLib.NotificationPosition = "BottomRight"
NovaLib.NotificationLimit = 3

--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer and LocalPlayer:GetMouse()

--// Tab metatable (used by all element files)
local Tab = {}
Tab.__index = Tab

--// Window metatable (used to modularize window functions)
local WindowProto = {}
WindowProto.__index = WindowProto

--// Fonts
NovaLib.Fonts = {
	Title  = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold), -- Title (Arimo Bold)
	Medium = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular), -- UI Medium (FredokaOne)
	Body   = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular), -- UI Body (FredokaOne)
	Bold   = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold), -- UI Bold (FredokaOne)
	Mono   = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular), -- UI Mono (FredokaOne)
	Pixel  = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular), -- Intro Pixel (PressStart2P)
	Terminal = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular), -- Monospace (PressStart2P)
	Config = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.SemiBold),
}

--// Standardized control heights
NovaLib.Sizes = {
    Small  = 34,
    Normal = 42,
    Large  = 54,
}
