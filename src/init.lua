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

--// Tab metatable (used by all element files)
local Tab = {}
Tab.__index = Tab

--// Window metatable (used to modularize window functions)
local WindowProto = {}
WindowProto.__index = WindowProto

--// Fonts
NovaLib.Fonts = {
    Title  = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
    Body   = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular),
    Medium = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
    Bold   = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
    Mono   = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular),
    Pixel  = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular),
    Config = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
}

--// Standardized control heights
NovaLib.Sizes = {
    Small  = 34,
    Normal = 42,
    Large  = 54,
}
