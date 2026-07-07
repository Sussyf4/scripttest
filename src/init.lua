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
	Title  = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), -- Window & Intro title
	Medium = Font.fromName("SourGummy", Enum.FontWeight.Medium), -- main UI Medium
	Body   = Font.fromName("SourGummy", Enum.FontWeight.Regular), -- main UI Regular
	Bold   = Font.fromName("SourGummy", Enum.FontWeight.Bold), -- main UI Bold
	Mono   = Font.fromName("SourGummy", Enum.FontWeight.Regular), -- main UI Mono
	Pixel  = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular), -- Intro Pixel
	Terminal = Font.fromName("VT323"), -- Monospace retro terminal for KeySystem
	Config = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
}

--// Standardized control heights
NovaLib.Sizes = {
    Small  = 34,
    Normal = 42,
    Large  = 54,
}
