--[[
	NovaLib UI Library
	BUNDLED PRODUCTION BUILD
	Generated at: 2026-07-07 18:22:51
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


--// File: src/Themes/init.lua //--
--// Central Theme Management
NovaLib.Themes = {}
local Theme


--// File: src/Themes/Dark.lua //--
NovaLib.Themes.Dark = {
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
}


--// File: src/Themes/Darker.lua //--
NovaLib.Themes.Darker = {
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
}


--// File: src/Themes/Light.lua //--
NovaLib.Themes.Light = {
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
}


--// File: src/Themes/Amethyst.lua //--
NovaLib.Themes.Amethyst = {
	Background   = Color3.fromRGB(13, 10, 24),
	Secondary    = Color3.fromRGB(20, 16, 36),
	Tertiary     = Color3.fromRGB(28, 23, 50),
	Hover        = Color3.fromRGB(36, 30, 64),
	Border       = Color3.fromRGB(44, 38, 76),
	Card         = Color3.fromRGB(20, 16, 36),
	Surface      = Color3.fromRGB(28, 23, 50),
	Input        = Color3.fromRGB(15, 12, 28),
	Disabled     = Color3.fromRGB(100, 95, 125),
	Accent       = Color3.fromRGB(160, 90, 255),
	AccentDark   = Color3.fromRGB(120, 60, 210),
	AccentGlow   = Color3.fromRGB(190, 130, 255),
	Text         = Color3.fromRGB(240, 235, 255),
	SubText      = Color3.fromRGB(160, 150, 185),
	Stroke       = Color3.fromRGB(44, 38, 76),
	StrokeLight  = Color3.fromRGB(60, 52, 100),
	Success      = Color3.fromRGB(80, 200, 120),
	Error        = Color3.fromRGB(235, 87, 87),
	Warning      = Color3.fromRGB(240, 180, 60),
}


--// File: src/Themes/Aqua.lua //--
NovaLib.Themes.Aqua = {
	Background   = Color3.fromRGB(6, 14, 20),
	Secondary    = Color3.fromRGB(11, 23, 31),
	Tertiary     = Color3.fromRGB(17, 33, 44),
	Hover        = Color3.fromRGB(22, 41, 54),
	Border       = Color3.fromRGB(28, 50, 65),
	Card         = Color3.fromRGB(11, 23, 31),
	Surface      = Color3.fromRGB(17, 33, 44),
	Input        = Color3.fromRGB(8, 17, 24),
	Disabled     = Color3.fromRGB(90, 110, 120),
	Accent       = Color3.fromRGB(0, 206, 209),
	AccentDark   = Color3.fromRGB(0, 150, 150),
	AccentGlow   = Color3.fromRGB(100, 240, 240),
	Text         = Color3.fromRGB(230, 245, 245),
	SubText      = Color3.fromRGB(140, 165, 175),
	Stroke       = Color3.fromRGB(28, 50, 65),
	StrokeLight  = Color3.fromRGB(40, 70, 90),
	Success      = Color3.fromRGB(80, 200, 120),
	Error        = Color3.fromRGB(235, 87, 87),
	Warning      = Color3.fromRGB(240, 180, 60),
}


--// File: src/Themes/Rose.lua //--
NovaLib.Themes.Rose = {
	Background   = Color3.fromRGB(20, 8, 12),
	Secondary    = Color3.fromRGB(31, 13, 20),
	Tertiary     = Color3.fromRGB(44, 19, 29),
	Hover        = Color3.fromRGB(54, 24, 36),
	Border       = Color3.fromRGB(65, 29, 44),
	Card         = Color3.fromRGB(31, 13, 20),
	Surface      = Color3.fromRGB(44, 19, 29),
	Input        = Color3.fromRGB(24, 10, 15),
	Disabled     = Color3.fromRGB(120, 90, 100),
	Accent       = Color3.fromRGB(255, 105, 180),
	AccentDark   = Color3.fromRGB(200, 70, 130),
	AccentGlow   = Color3.fromRGB(255, 150, 200),
	Text         = Color3.fromRGB(255, 235, 240),
	SubText      = Color3.fromRGB(180, 140, 155),
	Stroke       = Color3.fromRGB(65, 29, 44),
	StrokeLight  = Color3.fromRGB(90, 40, 60),
	Success      = Color3.fromRGB(80, 200, 120),
	Error        = Color3.fromRGB(235, 87, 87),
	Warning      = Color3.fromRGB(240, 180, 60),
}

Theme = NovaLib.Themes.Darker


--// File: src/Icons.lua //--
--// Icons — Roblox Image assets mapped to asset IDs
--// Usage: NovaLib:GetIcon("name") returns the rbxassetid:// URL.

NovaLib.Icons = {
	["accessibility"]       = "rbxassetid://86577806044774",
	["activity"]            = "rbxassetid://124718278159062",
	["alarm-check"]         = "rbxassetid://88443439659882",
	["alarm-clock"]         = "rbxassetid://94254533292407",
	["alarm-clock-off"]     = "rbxassetid://76522020859435",
	["alarm-minus"]         = "rbxassetid://103224203864320",
	["alarm-plus"]          = "rbxassetid://112903777535386",
	["alert-circle"]        = "rbxassetid://96622501885182",
	["alert-octagon"]       = "rbxassetid://113153027306372",
	["alert-triangle"]      = "rbxassetid://97614016517317",
	["arrow-big-left"]      = "rbxassetid://81223172012895",
	["arrow-big-right"]     = "rbxassetid://95946185689958",
	["arrow-big-up"]        = "rbxassetid://110679523642425",
	["arrow-down"]          = "rbxassetid://139934229465997",
	["arrow-down-circle"]   = "rbxassetid://134115521696959",
	["arrow-down-left"]     = "rbxassetid://132156409078786",
	["arrow-down-right"]    = "rbxassetid://101572283920640",
	["arrow-left"]          = "rbxassetid://117631502963585",
	["arrow-left-circle"]   = "rbxassetid://85104103038704",
	["arrow-left-right"]    = "rbxassetid://77726657456467",
	["arrow-right"]         = "rbxassetid://91225393330210",
	["arrow-right-circle"]  = "rbxassetid://129995786596546",
	["arrow-up"]            = "rbxassetid://136210647857533",
	["arrow-up-circle"]     = "rbxassetid://81985527791320",
	["arrow-up-down"]       = "rbxassetid://82617685428039",
	["arrow-up-left"]       = "rbxassetid://124145629940318",
	["arrow-up-right"]      = "rbxassetid://132200403964480",
	["baseline"]            = "rbxassetid://74429010951903",
	["bell"]                = "rbxassetid://131040003021065",
	["bell-off"]            = "rbxassetid://137347611690315",
	["bluetooth"]           = "rbxassetid://134275907691960",
	["bomb"]                = "rbxassetid://106146379411030",
	["bookmark"]            = "rbxassetid://78910713058457",
	["bot"]                 = "rbxassetid://136025658665641",
	["box"]                 = "rbxassetid://139127689990212",
	["boxes"]               = "rbxassetid://87753198550689",
	["box-select"]          = "rbxassetid://119473847007914",
	["bug"]                 = "rbxassetid://75805800263350",
	["bus"]                 = "rbxassetid://135687949432879",
	["cake"]                = "rbxassetid://95676980372932",
	["calendar"]            = "rbxassetid://76060491031137",
	["camera"]              = "rbxassetid://100844908025390",
	["check"]               = "rbxassetid://107610873117077",
	["check-circle"]        = "rbxassetid://131590629416870",
	["check-circle-2"]      = "rbxassetid://100658438766213",
	["check-square"]        = "rbxassetid://122667727839512",
	["chevron-down"]        = "rbxassetid://134991530011546",
	["chevron-first"]       = "rbxassetid://87209392159574",
	["chevron-last"]        = "rbxassetid://127722664350171",
	["chevron-left"]        = "rbxassetid://77853814810743",
	["chevron-right"]       = "rbxassetid://116254008577770",
	["chevrons-down"]       = "rbxassetid://134841329010524",
	["chevrons-down-up"]    = "rbxassetid://91792392983584",
	["chevrons-left"]       = "rbxassetid://116929636987016",
	["chevrons-left-right"] = "rbxassetid://122710881836088",
	["chevrons-right"]      = "rbxassetid://106649254766552",
	["chevrons-right-left"] = "rbxassetid://107654049585383",
	["chevrons-up"]         = "rbxassetid://111874102387214",
	["chevrons-up-down"]    = "rbxassetid://82898921713890",
	["chevron-up"]          = "rbxassetid://81789844454964",
	["circle"]              = "rbxassetid://118057098979863",
	["circle-dot"]          = "rbxassetid://118839761100554",
	["circle-ellipsis"]     = "rbxassetid://74821046526800",
	["circle-slashed"]      = "rbxassetid://116094741323493",
	["clipboard"]           = "rbxassetid://113289884390452",
	["clipboard-check"]     = "rbxassetid://95988127941813",
	["clipboard-copy"]      = "rbxassetid://118644028963638",
	["clipboard-x"]         = "rbxassetid://105062056111571",
	["clock"]               = "rbxassetid://120194987523679",
	["cloud"]               = "rbxassetid://71740362790765",
	["cloud-cog"]           = "rbxassetid://76741768619857",
	["cloud-drizzle"]       = "rbxassetid://80627992420948",
	["cloud-fog"]           = "rbxassetid://73646839819012",
	["cloud-hail"]          = "rbxassetid://86963473578471",
	["cloud-lightning"]     = "rbxassetid://77119516149315",
	["cloud-moon"]          = "rbxassetid://135943620257187",
	["cloud-moon-rain"]     = "rbxassetid://121171976865905",
	["cloud-off"]           = "rbxassetid://136396466736739",
	["cloud-rain"]          = "rbxassetid://114457403773492",
	["cloud-rain-wind"]     = "rbxassetid://94901778292323",
	["cloud-snow"]          = "rbxassetid://95733249447613",
	["cloud-sun"]           = "rbxassetid://95344439777009",
	["cloud-sun-rain"]      = "rbxassetid://135861500523518",
	["cloudy"]              = "rbxassetid://138223049179345",
	["clover"]              = "rbxassetid://101124990722172",
	["code"]                = "rbxassetid://80057761961128",
	["code-2"]              = "rbxassetid://74727274892893",
	["coffee"]              = "rbxassetid://106208702026407",
	["cog"]                 = "rbxassetid://102049722634534",
	["command"]             = "rbxassetid://80885004913569",
	["compass"]             = "rbxassetid://82282214088461",
	["copy"]                = "rbxassetid://80677896670661",
	["copyleft"]            = "rbxassetid://129334586665596",
	["copyright"]           = "rbxassetid://128161242246995",
	["corner-down-left"]    = "rbxassetid://100471957374022",
	["corner-down-right"]   = "rbxassetid://120386526135649",
	["corner-left-down"]    = "rbxassetid://127886445366427",
	["corner-left-up"]      = "rbxassetid://129921597102415",
	["corner-right-down"]   = "rbxassetid://91425519924359",
	["corner-right-up"]     = "rbxassetid://132933357346568",
	["corner-up-left"]      = "rbxassetid://97392992315106",
	["corner-up-right"]     = "rbxassetid://95400510088753",
	["cpu"]                 = "rbxassetid://114175929297028",
	["crop"]                = "rbxassetid://138101739462516",
	["crosshair"]           = "rbxassetid://99168526073704",
	["database"]            = "rbxassetid://99244421515108",
	["delete"]              = "rbxassetid://120164731780413",
	["download"]            = "rbxassetid://116553827990388",
	["download-cloud"]      = "rbxassetid://132699449873424",
	["edit"]                = "rbxassetid://117419829725279",
	["edit-2"]              = "rbxassetid://130538400147028",
	["edit-3"]              = "rbxassetid://137315486129862",
	["electricity"]         = "rbxassetid://93210576778058",
	["electricity-off"]     = "rbxassetid://115468637194708",
	["eraser"]              = "rbxassetid://138787307190849",
	["expand"]              = "rbxassetid://132641882147542",
	["external-link"]       = "rbxassetid://128574553678689",
	["eye"]                 = "rbxassetid://70643287021568",
	["eye-off"]             = "rbxassetid://104057296344988",
	["file"]                = "rbxassetid://80713255430986",
	["filter"]              = "rbxassetid://120397209454067",
	["fingerprint"]         = "rbxassetid://129004334305138",
	["flag"]                = "rbxassetid://93898795081107",
	["flame"]               = "rbxassetid://102692696988821",
	["focus"]               = "rbxassetid://118704633596060",
	["folder"]              = "rbxassetid://88470693133086",
	["folder-open"]         = "rbxassetid://109979142447482",
	["forward"]             = "rbxassetid://109223581546267",
	["gamepad-2"]           = "rbxassetid://113912432145082",
	["gem"]                 = "rbxassetid://122039614231973",
	["globe"]               = "rbxassetid://106045997668731",
	["globe-2"]             = "rbxassetid://75392059901643",
	["grid"]                = "rbxassetid://92374808665407",
	["hard-drive"]          = "rbxassetid://115874719417252",
	["heart"]               = "rbxassetid://90843982238327",
	["home"]                = "rbxassetid://138336007807517",
	["image"]               = "rbxassetid://77526753811349",
	["import"]              = "rbxassetid://75834207260490",
	["inbox"]               = "rbxassetid://71024142770099",
	["info"]                = "rbxassetid://117540852833261",
	["inspect"]             = "rbxassetid://138752306955980",
	["key"]                 = "rbxassetid://111741478621082",
	["layers"]              = "rbxassetid://103897702316342",
	["layout"]              = "rbxassetid://91157288604829",
	["lightbulb"]           = "rbxassetid://133504269053111",
	["lightbulb-off"]       = "rbxassetid://132933746573531",
	["link"]                = "rbxassetid://91755181673292",
	["link-2"]              = "rbxassetid://74021297508234",
	["link-2-off"]          = "rbxassetid://126457611273268",
	["list"]                = "rbxassetid://120952307270177",
	["list-ordered"]        = "rbxassetid://105928960530744",
	["loader"]              = "rbxassetid://123787715187262",
	["loader-2"]            = "rbxassetid://86745900648098",
	["locate"]              = "rbxassetid://124835736755248",
	["locate-fixed"]        = "rbxassetid://77799747163687",
	["locate-off"]          = "rbxassetid://129731313283874",
	["lock"]                = "rbxassetid://79181521386751",
	["log-in"]              = "rbxassetid://121939047633490",
	["log-out"]             = "rbxassetid://98799638707366",
	["mail"]                = "rbxassetid://74446122154871",
	["mail-open"]           = "rbxassetid://97988002799152",
	["map"]                 = "rbxassetid://131779848774014",
	["maximize"]            = "rbxassetid://102609613179535",
	["maximize-2"]          = "rbxassetid://104419143262459",
	["menu"]                = "rbxassetid://131640836630622",
	["message-circle"]      = "rbxassetid://116748128282489",
	["message-square"]      = "rbxassetid://92232291277528",
	["mic"]                 = "rbxassetid://98706476785764",
	["minimize"]            = "rbxassetid://85911469421154",
	["minimize-2"]          = "rbxassetid://83600993144823",
	["minus"]               = "rbxassetid://80246713190225",
	["minus-circle"]        = "rbxassetid://93975848047961",
	["moon"]                = "rbxassetid://76518168921057",
	["mouse-pointer-2"]     = "rbxassetid://133711156120534",
	["mouse-pointer-click"] = "rbxassetid://108242866587681",
	["move-diagonal"]       = "rbxassetid://104780697639568",
	["move-diagonal-2"]     = "rbxassetid://88176512596821",
	["move-horizontal"]     = "rbxassetid://95717649021380",
	["move-vertical"]       = "rbxassetid://97622192561014",
	["navigation"]          = "rbxassetid://91453827974577",
	["navigation-2"]        = "rbxassetid://78053127601414",
	["package-2"]           = "rbxassetid://97611761627313",
	["palette"]             = "rbxassetid://109728443966747",
	["pause"]               = "rbxassetid://101809803158620",
	["phone"]               = "rbxassetid://93265716389607",
	["pin"]                 = "rbxassetid://138066191106147",
	["plane"]               = "rbxassetid://124671733529020",
	["play"]                = "rbxassetid://119128870764318",
	["plus"]                = "rbxassetid://84773826668367",
	["plus-circle"]         = "rbxassetid://135411796054975",
	["plus-square"]         = "rbxassetid://124672515362224",
	["power"]               = "rbxassetid://117635692765522",
	["power-off"]           = "rbxassetid://74561409634907",
	["redo"]                = "rbxassetid://116612808946891",
	["redo-2"]              = "rbxassetid://81159750535217",
	["refresh-cw"]          = "rbxassetid://98911090401219",
	["rocket"]              = "rbxassetid://100389968772950",
	["rss"]                 = "rbxassetid://73598987277411",
	["save"]                = "rbxassetid://126940374970901",
	["scissors"]            = "rbxassetid://94330181158930",
	["scroll"]              = "rbxassetid://108768581027484",
	["search"]              = "rbxassetid://72934798326215",
	["send"]                = "rbxassetid://102039923302634",
	["separator-horizontal"] = "rbxassetid://84037801088900",
	["separator-vertical"]  = "rbxassetid://76761978346006",
	["server"]              = "rbxassetid://75664757798446",
	["server-cog"]          = "rbxassetid://112101645533047",
	["server-crash"]        = "rbxassetid://95014747967844",
	["server-off"]          = "rbxassetid://96514009352888",
	["settings"]            = "rbxassetid://79890103097863",
	["settings-2"]          = "rbxassetid://82905434058372",
	["share"]               = "rbxassetid://104215879677241",
	["share-2"]             = "rbxassetid://85970485067799",
	["shield"]              = "rbxassetid://100583216763036",
	["shield-alert"]        = "rbxassetid://101107939984909",
	["shield-check"]        = "rbxassetid://83945529674378",
	["shield-close"]        = "rbxassetid://70747059868313",
	["signal"]              = "rbxassetid://97450412129258",
	["signal-high"]         = "rbxassetid://80489472999566",
	["signal-low"]          = "rbxassetid://94129075854090",
	["signal-medium"]       = "rbxassetid://137194189683381",
	["signal-zero"]         = "rbxassetid://103589719885970",
	["skull"]               = "rbxassetid://87577090489900",
	["sliders"]             = "rbxassetid://70907897856504",
	["sliders-horizontal"]  = "rbxassetid://85574415403603",
	["snowflake"]           = "rbxassetid://98461691859013",
	["sort-asc"]            = "rbxassetid://97393324013895",
	["sort-desc"]           = "rbxassetid://116689671729402",
	["star"]                = "rbxassetid://82225115058136",
	["sun"]                 = "rbxassetid://87196039593436",
	["sun-dim"]             = "rbxassetid://82479408651247",
	["sword"]               = "rbxassetid://117377912184895",
	["tag"]                 = "rbxassetid://73721513610706",
	["target"]              = "rbxassetid://120285992980806",
	["terminal"]            = "rbxassetid://81304759954068",
	["toggle-left"]         = "rbxassetid://113627064803722",
	["toggle-right"]        = "rbxassetid://91074620164539",
	["trash"]               = "rbxassetid://108651825728242",
	["trash-2"]             = "rbxassetid://93063159653818",
	["undo"]                = "rbxassetid://110861533873400",
	["undo-2"]              = "rbxassetid://83375010801060",
	["unlink"]              = "rbxassetid://117628557697253",
	["unlink-2"]            = "rbxassetid://140061988553151",
	["unlock"]              = "rbxassetid://88334597212605",
	["upload"]              = "rbxassetid://74526262584750",
	["user"]                = "rbxassetid://118393671216197",
	["user-check"]          = "rbxassetid://91119519400562",
	["user-minus"]          = "rbxassetid://97525341351869",
	["user-plus"]           = "rbxassetid://100808708500441",
	["users"]               = "rbxassetid://119735248132144",
	["verified"]            = "rbxassetid://99405098419465",
	["volume"]              = "rbxassetid://111014035867813",
	["wand"]                = "rbxassetid://103768858355562",
	["wifi"]                = "rbxassetid://85799223133613",
	["wifi-off"]            = "rbxassetid://71001250643809",
	["wrench"]              = "rbxassetid://75589939739234",
	["x"]                   = "rbxassetid://89000014910130",
	["x-circle"]            = "rbxassetid://70409904155359",
	["zoom-in"]             = "rbxassetid://129061738536125",
	["zoom-out"]            = "rbxassetid://89279935586876",
}

function NovaLib:GetIcon(name)
	if not name then return nil end
	-- If it's already a full URL or rbxassetid, pass through
	if name:sub(1, 4) == "http" or name:sub(1, 7) == "rbxasset" then
		return name
	end
	return NovaLib.Icons[name]
end


--// File: src/FontMaps.lua //--
--// Custom Image Font Character Maps ------------------------------------------

NovaLib.FontMaps = {
	PressStart2P = {
		[" "] = "rbxassetid://127076528250695",
		["!"] = "rbxassetid://140007452416617",
		["\""] = "rbxassetid://135784970369262",
		["#"] = "rbxassetid://70981570949146",
		["$"] = "rbxassetid://114394503755387",
		["%"] = "rbxassetid://122724180510101",
		["&"] = "rbxassetid://93072633810596",
		["'"] = "rbxassetid://113770742006595",
		["("] = "rbxassetid://111790298610413",
		[")"] = "rbxassetid://83360665857148",
		["*"] = "rbxassetid://86597112145750",
		["+"] = "rbxassetid://72927457701881",
		[","] = "rbxassetid://130011574556211",
		["-"] = "rbxassetid://86514518906235",
		["."] = "rbxassetid://94971929862256",
		["/"] = "rbxassetid://116996110477103",
		["0"] = "rbxassetid://131753403641030",
		["1"] = "rbxassetid://84804364239207",
		["2"] = "rbxassetid://103680748677075",
		["3"] = "rbxassetid://92533825274329",
		["4"] = "rbxassetid://112143064022810",
		["5"] = "rbxassetid://80245963202358",
		["6"] = "rbxassetid://87051280831458",
		["7"] = "rbxassetid://135481769007005",
		["8"] = "rbxassetid://87424522015921",
		["9"] = "rbxassetid://86309570897318",
		[":"] = "rbxassetid://73555104917029",
		[";"] = "rbxassetid://92487825940290",
		["<"] = "rbxassetid://114102660249734",
		["="] = "rbxassetid://101610535379832",
		[">"] = "rbxassetid://136856642466674",
		["?"] = "rbxassetid://134524603934693",
		["@"] = "rbxassetid://120715510759019",
		["A"] = "rbxassetid://98855435986138",
		["B"] = "rbxassetid://139189453085838",
		["C"] = "rbxassetid://133107750236507",
		["D"] = "rbxassetid://77482270543033",
		["E"] = "rbxassetid://120848016533642",
		["F"] = "rbxassetid://113219443249203",
		["G"] = "rbxassetid://85804005269629",
		["H"] = "rbxassetid://85624869648440",
		["I"] = "rbxassetid://85515318945976",
		["J"] = "rbxassetid://79060729047533",
		["K"] = "rbxassetid://110489698399263",
		["L"] = "rbxassetid://75595887330901",
		["M"] = "rbxassetid://114402063716321",
		["N"] = "rbxassetid://72976794119098",
		["O"] = "rbxassetid://105428410918549",
		["P"] = "rbxassetid://116877609092008",
		["Q"] = "rbxassetid://130290069566983",
		["R"] = "rbxassetid://99737820628678",
		["S"] = "rbxassetid://91285057732910",
		["T"] = "rbxassetid://129428046385103",
		["U"] = "rbxassetid://133890912554318",
		["V"] = "rbxassetid://132357833294496",
		["W"] = "rbxassetid://100283839658342",
		["X"] = "rbxassetid://86478840985692",
		["Y"] = "rbxassetid://102467281578197",
		["Z"] = "rbxassetid://139423730016085",
		["["] = "rbxassetid://92262647211414",
		["\\"] = "rbxassetid://119540700354167",
		["]"] = "rbxassetid://116862605233225",
		["^"] = "rbxassetid://97987636455121",
		["_"] = "rbxassetid://123099331334519",
		["`"] = "rbxassetid://101147049189840",
		["a"] = "rbxassetid://74424031529116",
		["b"] = "rbxassetid://111621948101883",
		["c"] = "rbxassetid://89441483153540",
		["d"] = "rbxassetid://124999690809564",
		["e"] = "rbxassetid://128584334482096",
		["f"] = "rbxassetid://71294348015430",
		["g"] = "rbxassetid://91274816903761",
		["h"] = "rbxassetid://124756338758706",
		["i"] = "rbxassetid://134238416475973",
		["j"] = "rbxassetid://121295406250579",
		["k"] = "rbxassetid://99955385326536",
		["l"] = "rbxassetid://128724748940144",
		["m"] = "rbxassetid://125852206741588",
		["n"] = "rbxassetid://130298175183089",
		["o"] = "rbxassetid://77239847239524",
		["p"] = "rbxassetid://83363329023861",
		["q"] = "rbxassetid://89650645574828",
		["r"] = "rbxassetid://127597541380980",
		["s"] = "rbxassetid://75679129876411",
		["t"] = "rbxassetid://140160693041231",
		["u"] = "rbxassetid://115125293453287",
		["v"] = "rbxassetid://93358331734424",
		["w"] = "rbxassetid://116038397070903",
		["x"] = "rbxassetid://128817828833574",
		["y"] = "rbxassetid://73368105635079",
		["z"] = "rbxassetid://82963045004985",
		["{"] = "rbxassetid://133720639679955",
		["|"] = "rbxassetid://99111766320798",
		["}"] = "rbxassetid://117343215239019",
		["~"] = "rbxassetid://111777372311094",
	},
	GothamSSm = {
		[" "] = "rbxassetid://117251533236031",
		["!"] = "rbxassetid://126682888116409",
		["\""] = "rbxassetid://119518348738225",
		["#"] = "rbxassetid://104939954351459",
		["$"] = "rbxassetid://130299295233970",
		["%"] = "rbxassetid://132317373586086",
		["&"] = "rbxassetid://105633316634350",
		["'"] = "rbxassetid://125387559204637",
		["("] = "rbxassetid://114630078586586",
		[")"] = "rbxassetid://134333666772042",
		["*"] = "rbxassetid://111131203644527",
		["+"] = "rbxassetid://115316004829991",
		[","] = "rbxassetid://80766644173445",
		["-"] = "rbxassetid://135505777474583",
		["."] = "rbxassetid://106365065347633",
		["/"] = "rbxassetid://81825445862329",
		["0"] = "rbxassetid://130541722893138",
		["1"] = "rbxassetid://109961150450669",
		["2"] = "rbxassetid://131645757641614",
		["3"] = "rbxassetid://75761513274976",
		["4"] = "rbxassetid://108045782007121",
		["5"] = "rbxassetid://133869908228322",
		["6"] = "rbxassetid://119089451485145",
		["7"] = "rbxassetid://136547254787256",
		["8"] = "rbxassetid://106546266234654",
		["9"] = "rbxassetid://105192517824287",
		[":"] = "rbxassetid://109145872039730",
		[";"] = "rbxassetid://72513639029885",
		["<"] = "rbxassetid://82674340374564",
		["="] = "rbxassetid://86965570821364",
		[">"] = "rbxassetid://135050601750632",
		["?"] = "rbxassetid://138735439932062",
		["@"] = "rbxassetid://126663415206083",
		["A"] = "rbxassetid://111829914517305",
		["B"] = "rbxassetid://107844642661627",
		["C"] = "rbxassetid://80744321511427",
		["D"] = "rbxassetid://92804624365288",
		["E"] = "rbxassetid://78311648416689",
		["F"] = "rbxassetid://76130513088078",
		["G"] = "rbxassetid://138921302812999",
		["H"] = "rbxassetid://75185723070537",
		["I"] = "rbxassetid://121124203462461",
		["J"] = "rbxassetid://71022699174988",
		["K"] = "rbxassetid://92144786909603",
		["L"] = "rbxassetid://135875577138420",
		["M"] = "rbxassetid://137389081513530",
		["N"] = "rbxassetid://80240165750732",
		["O"] = "rbxassetid://138293953215068",
		["P"] = "rbxassetid://107150730539618",
		["Q"] = "rbxassetid://105349962605831",
		["R"] = "rbxassetid://85190963742435",
		["S"] = "rbxassetid://104804820801904",
		["T"] = "rbxassetid://129685969645500",
		["U"] = "rbxassetid://91346066381865",
		["V"] = "rbxassetid://136559119238667",
		["W"] = "rbxassetid://110962916303188",
		["X"] = "rbxassetid://90020402255340",
		["Y"] = "rbxassetid://129958091443592",
		["Z"] = "rbxassetid://134224045609714",
		["["] = "rbxassetid://113121610984937",
		["\\"] = "rbxassetid://82170390761290",
		["]"] = "rbxassetid://100949810866258",
		["^"] = "rbxassetid://95850099911141",
		["_"] = "rbxassetid://116549888901395",
		["`"] = "rbxassetid://72922072801473",
		["a"] = "rbxassetid://131925147545280",
		["b"] = "rbxassetid://88423374742148",
		["c"] = "rbxassetid://117316527382663",
		["d"] = "rbxassetid://86794842256776",
		["e"] = "rbxassetid://119099053792959",
		["f"] = "rbxassetid://111085305483813",
		["g"] = "rbxassetid://133450414687236",
		["h"] = "rbxassetid://104604407325148",
		["i"] = "rbxassetid://123784528957590",
		["j"] = "rbxassetid://70741000891109",
		["k"] = "rbxassetid://114062390520615",
		["l"] = "rbxassetid://140385676483267",
		["m"] = "rbxassetid://108631905859444",
		["n"] = "rbxassetid://138310100216394",
		["o"] = "rbxassetid://94852638205510",
		["p"] = "rbxassetid://75712648734936",
		["q"] = "rbxassetid://98141658154643",
		["r"] = "rbxassetid://101072968612039",
		["s"] = "rbxassetid://92565398069499",
		["t"] = "rbxassetid://73133767138737",
		["u"] = "rbxassetid://101215680356485",
		["v"] = "rbxassetid://105477302043653",
		["w"] = "rbxassetid://109107040751159",
		["x"] = "rbxassetid://85460719171217",
		["y"] = "rbxassetid://110033687556644",
		["z"] = "rbxassetid://103044395341475",
		["{"] = "rbxassetid://72400962037966",
		["|"] = "rbxassetid://92523940964498",
		["}"] = "rbxassetid://134231463875596",
		["~"] = "rbxassetid://81873653150033",
	},
	SourGummy = {
		[" "] = "rbxassetid://84025329217107",
		["!"] = "rbxassetid://118859464949366",
		["\""] = "rbxassetid://121202361415957",
		["#"] = "rbxassetid://114006078809887",
		["$"] = "rbxassetid://124546132758738",
		["%"] = "rbxassetid://102588038471266",
		["&"] = "rbxassetid://78072151601016",
		["'"] = "rbxassetid://116722044598526",
		["("] = "rbxassetid://128864944447539",
		[")"] = "rbxassetid://74659727972380",
		["*"] = "rbxassetid://126426889686681",
		["+"] = "rbxassetid://117494290257356",
		[","] = "rbxassetid://95066743003205",
		["-"] = "rbxassetid://79569977182017",
		["."] = "rbxassetid://122580519922761",
		["/"] = "rbxassetid://118485564849379",
		["0"] = "rbxassetid://130510615965036",
		["1"] = "rbxassetid://70966912386236",
		["2"] = "rbxassetid://117519285075474",
		["3"] = "rbxassetid://98124872606647",
		["4"] = "rbxassetid://81622965190904",
		["5"] = "rbxassetid://71755043353146",
		["6"] = "rbxassetid://133904777791794",
		["7"] = "rbxassetid://75144013886024",
		["8"] = "rbxassetid://121781649684049",
		["9"] = "rbxassetid://109136130440462",
		[":"] = "rbxassetid://138671757700944",
		[";"] = "rbxassetid://72980327667687",
		["<"] = "rbxassetid://108961874783491",
		["="] = "rbxassetid://78971692021283",
		[">"] = "rbxassetid://136450659846403",
		["?"] = "rbxassetid://109182390424450",
		["@"] = "rbxassetid://134583992423156",
		["A"] = "rbxassetid://89507505999521",
		["B"] = "rbxassetid://107994179157279",
		["C"] = "rbxassetid://113697487366134",
		["D"] = "rbxassetid://107550351553711",
		["E"] = "rbxassetid://127729673335317",
		["F"] = "rbxassetid://101498518301393",
		["G"] = "rbxassetid://85634946702559",
		["H"] = "rbxassetid://120578282294453",
		["I"] = "rbxassetid://98585112617975",
		["J"] = "rbxassetid://78451020127931",
		["K"] = "rbxassetid://114616638346223",
		["L"] = "rbxassetid://86619493065818",
		["M"] = "rbxassetid://79966130155801",
		["N"] = "rbxassetid://132376284206993",
		["O"] = "rbxassetid://129360959300368",
		["P"] = "rbxassetid://120517053261945",
		["Q"] = "rbxassetid://106959072872100",
		["R"] = "rbxassetid://96255967728742",
		["S"] = "rbxassetid://71314757306362",
		["T"] = "rbxassetid://121170854775361",
		["U"] = "rbxassetid://78750315552009",
		["V"] = "rbxassetid://107541672797874",
		["W"] = "rbxassetid://75562458851238",
		["X"] = "rbxassetid://128905129410414",
		["Y"] = "rbxassetid://129129175291402",
		["Z"] = "rbxassetid://102807932812659",
		["["] = "rbxassetid://91855367711234",
		["\\"] = "rbxassetid://132246183823954",
		["]"] = "rbxassetid://126327452966020",
		["^"] = "rbxassetid://80691516287666",
		["_"] = "rbxassetid://83365622392398",
		["`"] = "rbxassetid://95044292654211",
		["a"] = "rbxassetid://139100374407042",
		["b"] = "rbxassetid://127109860253935",
		["c"] = "rbxassetid://136576507741367",
		["d"] = "rbxassetid://102621174692664",
		["e"] = "rbxassetid://123863551787387",
		["f"] = "rbxassetid://138198857894422",
		["g"] = "rbxassetid://83582576746860",
		["h"] = "rbxassetid://80070539255786",
		["i"] = "rbxassetid://91972482870502",
		["j"] = "rbxassetid://121274502120667",
		["k"] = "rbxassetid://104793308491793",
		["l"] = "rbxassetid://93637034449108",
		["m"] = "rbxassetid://106692765238801",
		["n"] = "rbxassetid://118664710952119",
		["o"] = "rbxassetid://102467503431240",
		["p"] = "rbxassetid://102928289357379",
		["q"] = "rbxassetid://104778801180282",
		["r"] = "rbxassetid://134698207756946",
		["s"] = "rbxassetid://136005343094759",
		["t"] = "rbxassetid://108787998442079",
		["u"] = "rbxassetid://77938684131463",
		["v"] = "rbxassetid://115856149888123",
		["w"] = "rbxassetid://93356431606305",
		["x"] = "rbxassetid://82461458374810",
		["y"] = "rbxassetid://72244245593165",
		["z"] = "rbxassetid://109308965978853",
		["{"] = "rbxassetid://107257773236125",
		["|"] = "rbxassetid://116656264749332",
		["}"] = "rbxassetid://118593322548576",
		["~"] = "rbxassetid://126746776101640",
	},
	VT323 = {
		[" "] = "rbxassetid://127076528250695", -- spaces fallback to standard spacing
		["!"] = "rbxassetid://128723223847775",
		["\""] = "rbxassetid://128723223847776",
		["#"] = "rbxassetid://128723223847777",
		["$"] = "rbxassetid://128723223847778",
		["%"] = "rbxassetid://128723223847779",
		["&"] = "rbxassetid://128723223847780",
		["'"] = "rbxassetid://128723223847781",
		["("] = "rbxassetid://128723223847782",
		[")"] = "rbxassetid://128723223847783",
		["*"] = "rbxassetid://128723223847784",
		["+"] = "rbxassetid://128723223847785",
		[","] = "rbxassetid://128723223847786",
		["-"] = "rbxassetid://128723223847787",
		["."] = "rbxassetid://128723223847788",
		["/"] = "rbxassetid://128723223847789",
		["0"] = "rbxassetid://128723223847790",
		["1"] = "rbxassetid://128723223847791",
		["2"] = "rbxassetid://128723223847792",
		["3"] = "rbxassetid://128723223847793",
		["4"] = "rbxassetid://128723223847794",
		["5"] = "rbxassetid://128723223847795",
		["6"] = "rbxassetid://128723223847796",
		["7"] = "rbxassetid://128723223847797",
		["8"] = "rbxassetid://128723223847798",
		["9"] = "rbxassetid://128723223847799",
		[":"] = "rbxassetid://128723223847800",
		[";"] = "rbxassetid://128723223847801",
		["<"] = "rbxassetid://128723223847802",
		["="] = "rbxassetid://128723223847803",
		[">"] = "rbxassetid://128723223847804",
		["?"] = "rbxassetid://128723223847805",
		["@"] = "rbxassetid://128723223847806",
		["A"] = "rbxassetid://128723223847807",
		["B"] = "rbxassetid://128723223847808",
		["C"] = "rbxassetid://128723223847809",
		["D"] = "rbxassetid://128723223847810",
		["E"] = "rbxassetid://128723223847811",
		["F"] = "rbxassetid://128723223847812",
		["G"] = "rbxassetid://128723223847813",
		["H"] = "rbxassetid://128723223847814",
		["I"] = "rbxassetid://128723223847815",
		["J"] = "rbxassetid://128723223847816",
		["K"] = "rbxassetid://128723223847817",
		["L"] = "rbxassetid://128723223847818",
		["M"] = "rbxassetid://128723223847819",
		["N"] = "rbxassetid://128723223847820",
		["O"] = "rbxassetid://128723223847821",
		["P"] = "rbxassetid://128723223847822",
		["Q"] = "rbxassetid://128723223847823",
		["R"] = "rbxassetid://128723223847824",
		["S"] = "rbxassetid://128723223847825",
		["T"] = "rbxassetid://128723223847826",
		["U"] = "rbxassetid://128723223847827",
		["V"] = "rbxassetid://128723223847828",
		["W"] = "rbxassetid://128723223847829",
		["X"] = "rbxassetid://128723223847830",
		["Y"] = "rbxassetid://128723223847831",
		["Z"] = "rbxassetid://128723223847832",
		["["] = "rbxassetid://128723223847833",
		["\\"] = "rbxassetid://128723223847834",
		["]"] = "rbxassetid://128723223847835",
		["^"] = "rbxassetid://128723223847836",
		["_"] = "rbxassetid://128723223847837",
		["`"] = "rbxassetid://128723223847838",
		["a"] = "rbxassetid://128723223847839",
		["b"] = "rbxassetid://128723223847840",
		["c"] = "rbxassetid://128723223847841",
		["d"] = "rbxassetid://128723223847842",
		["e"] = "rbxassetid://128723223847843",
		["f"] = "rbxassetid://128723223847844",
		["g"] = "rbxassetid://128723223847845",
		["h"] = "rbxassetid://128723223847846",
		["i"] = "rbxassetid://128723223847847",
		["j"] = "rbxassetid://128723223847848",
		["k"] = "rbxassetid://128723223847849",
		["l"] = "rbxassetid://128723223847850",
		["m"] = "rbxassetid://128723223847851",
		["n"] = "rbxassetid://128723223847852",
		["o"] = "rbxassetid://128723223847853",
		["p"] = "rbxassetid://128723223847854",
		["q"] = "rbxassetid://128723223847855",
		["r"] = "rbxassetid://128723223847856",
		["s"] = "rbxassetid://128723223847857",
		["t"] = "rbxassetid://128723223847858",
		["u"] = "rbxassetid://128723223847859",
		["v"] = "rbxassetid://128723223847860",
		["w"] = "rbxassetid://128723223847861",
		["x"] = "rbxassetid://128723223847862",
		["y"] = "rbxassetid://128723223847863",
		["z"] = "rbxassetid://128723223847864",
		["{"] = "rbxassetid://128723223847865",
		["|"] = "rbxassetid://128723223847866",
		["}"] = "rbxassetid://128723223847867",
		["~"] = "rbxassetid://128723223847868",
	}
}


--// File: src/Utility.lua //--
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
					fallback = Enum.Font.Gotham
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




--// File: src/Managers/SaveManager.lua //--
--// Config saving / loading manager -------------------------------------------

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


--// File: src/Managers/InterfaceManager.lua //--
--// Interface theme and settings manager -------------------------------------

function WindowProto:SetTheme(name)
	local newTheme = NovaLib.Themes[name]
	if not newTheme then
		if name == "Black" then
			newTheme = NovaLib.Themes.Darker
		elseif name == "Midnight" then
			newTheme = NovaLib.Themes.Amethyst
		end
	end
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


--// File: src/Intro.lua //--
--// Intro (Wind + Letter Fade Animation) --------------------------------------

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

	local titleContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, -30),
		Size = UDim2.new(0, 0, 0, 60),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = introGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local charLabels = {}
	for i = 1, #titleText do
		local char = string.sub(titleText, i, i)
		local assetId = NovaLib.FontMaps and NovaLib.FontMaps.PressStart2P and (
			NovaLib.FontMaps.PressStart2P[char] 
			or NovaLib.FontMaps.PressStart2P[string.lower(char)] 
			or NovaLib.FontMaps.PressStart2P[string.upper(char)]
		)
		
		local charWidth = 32
		local charHeight = 32
		if char == " " then
			charWidth = 16
		end

		local wrapper = Create("Frame", {
			Size = UDim2.new(0, charWidth, 0, charHeight),
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = titleContainer,
		})
		
		local label
		if assetId then
			label = Create("ImageLabel", {
				Position = UDim2.new(0, 40, 0, 0), -- 40 X offset
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Image = assetId,
				ImageColor3 = Theme.Text,
				ImageTransparency = 1, -- start hidden
				Parent = wrapper,
			})
		else
			label = Create("TextLabel", {
				Position = UDim2.new(0, 40, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = char,
				TextColor3 = Theme.Text,
				TextSize = 42,
				TextTransparency = 1,
				Parent = wrapper,
			})
		end
		
		-- tiny glow behind the letters
		Create("UIStroke", {
			Color = Theme.AccentGlow,
			Thickness = 1,
			Transparency = 0.85,
			Parent = label,
		})
		
		table.insert(charLabels, label)
	end

	local subText = _subText or "Loading interface..."
	local subContainer = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 30),
		Size = UDim2.new(0, 0, 0, 24),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = introGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local subLabels = {}
	for i = 1, #subText do
		local char = string.sub(subText, i, i)
		local assetId = NovaLib.FontMaps and NovaLib.FontMaps.SourGummy and (
			NovaLib.FontMaps.SourGummy[char] 
			or NovaLib.FontMaps.SourGummy[string.lower(char)] 
			or NovaLib.FontMaps.SourGummy[string.upper(char)]
		)
		
		local charWidth = 12
		local charHeight = 18
		if char == " " then
			charWidth = 8
		end

		local wrapper = Create("Frame", {
			Size = UDim2.new(0, charWidth, 0, charHeight),
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = subContainer,
		})
		
		local label
		if assetId then
			label = Create("ImageLabel", {
				Position = UDim2.new(0, 30, 0, 0), -- 30 X offset
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Image = assetId,
				ImageColor3 = Theme.SubText,
				ImageTransparency = 1, -- start hidden
				Parent = wrapper,
			})
		else
			label = Create("TextLabel", {
				Position = UDim2.new(0, 30, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = char,
				TextColor3 = Theme.SubText,
				TextSize = 16,
				TextTransparency = 1,
				Parent = wrapper,
			})
		end
		
		table.insert(subLabels, label)
	end

	-- Fade backdrop in
	Tween(backdrop, { BackgroundTransparency = 0 }, 0.35)
	task.wait(0.35)

	-- Wind-in title characters
	for i, label in ipairs(charLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, 0), [propName] = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.05)
	end

	-- Wait then wind-in subtitle characters
	task.wait(0.3)
	for i, label in ipairs(subLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, 0), [propName] = 0 }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.wait(0.03)
	end

	-- Hold
	task.wait(1.5)

	-- Drift out simultaneously
	for _, label in ipairs(charLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, -20), [propName] = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	for _, label in ipairs(subLabels) do
		local propName = label:IsA("ImageLabel") and "ImageTransparency" or "TextTransparency"
		Tween(label, { Position = UDim2.new(0, 0, 0, -15), [propName] = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	task.wait(0.38)

	-- Fade backdrop out
	Tween(backdrop, { BackgroundTransparency = 1 }, 0.4)
	task.wait(0.45)
	introGui:Destroy()
end


--// File: src/Components/Element.lua //--
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


--// File: src/Components/Notification.lua //--
--// Notification Component (Solid style + Queue stack) -----------------------

local NotifyGui, NotifyHolder
local activeCount = 0
local pendingQueue = {}

local function EnsureNotifyGui()
	if NotifyGui and NotifyGui.Parent then return end
	NotifyGui = Create("ScreenGui", {
		Name = "NovaNotify",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	ProtectGui(NotifyGui)

	local pos = NovaLib.NotificationPosition or "BottomRight"
	local anchor, position, vertAlign, horizAlign
	
	if pos == "TopRight" then
		anchor = Vector2.new(1, 0)
		position = UDim2.new(1, -24, 0, 24)
		vertAlign = Enum.VerticalAlignment.Top
		horizAlign = Enum.HorizontalAlignment.Right
	elseif pos == "TopLeft" then
		anchor = Vector2.new(0, 0)
		position = UDim2.new(0, 24, 0, 24)
		vertAlign = Enum.VerticalAlignment.Top
		horizAlign = Enum.HorizontalAlignment.Left
	elseif pos == "BottomLeft" then
		anchor = Vector2.new(0, 1)
		position = UDim2.new(0, 24, 1, -24)
		vertAlign = Enum.VerticalAlignment.Bottom
		horizAlign = Enum.HorizontalAlignment.Left
	else -- BottomRight
		anchor = Vector2.new(1, 1)
		position = UDim2.new(1, -24, 1, -24)
		vertAlign = Enum.VerticalAlignment.Bottom
		horizAlign = Enum.HorizontalAlignment.Right
	end

	NotifyHolder = Create("Frame", {
		Name = "Holder",
		AnchorPoint = anchor,
		Position = position,
		Size = UDim2.new(0, 300, 1, -48),
		BackgroundTransparency = 1,
		Parent = NotifyGui,
	}, {
		Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = horizAlign,
			VerticalAlignment = vertAlign,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		}),
	})
end

function NovaLib:Notify(options)
	options = options or {}
	
	-- Queue logic check
	if activeCount >= (NovaLib.NotificationLimit or 3) then
		table.insert(pendingQueue, options)
		return
	end
	
	activeCount = activeCount + 1
	EnsureNotifyGui()

	local title = options.Title or "Notification"
	local content = options.Content or ""
	local duration = options.Duration or 4
	local notifType = options.Type or "Info" -- Success, Error, Warning, Info

	-- Card container wrapper
	local wrapper = Create("Frame", {
		Name = "NotifWrapper",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = NotifyHolder,
	})

	local pos = NovaLib.NotificationPosition or "BottomRight"
	local isLeft = (pos == "TopLeft" or pos == "BottomLeft")
	local startOffset = isLeft and -120 or 120

	local card = Create("Frame", {
		Name = "Card",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.new(0, startOffset, 0, 0), -- slide offscreen offset
		BackgroundColor3 = Theme.Secondary,
		BackgroundTransparency = 0, -- solid background
		Parent = wrapper,
	})
	Round(card, 8)
	local cardStroke = Stroke(card, Theme.StrokeLight, 1, 0.3)
	Sheen(card, 0.03)

	local shadow = Shadow(card, 8, 0.85)

	-- Accent configuration
	local typeColor = Theme.Accent
	local iconName = "info"
	if notifType == "Success" or notifType == "success" then
		typeColor = Color3.fromRGB(25, 200, 80)
		iconName = "check-circle"
	elseif notifType == "Error" or notifType == "error" then
		typeColor = Color3.fromRGB(200, 50, 50)
		iconName = "alert-circle"
	elseif notifType == "Warning" or notifType == "warning" then
		typeColor = Color3.fromRGB(220, 140, 0)
		iconName = "alert-triangle"
	else -- Info / info
		typeColor = Color3.fromRGB(60, 120, 255)
		iconName = "info"
	end

	-- Accent left border strip
	local accentBar = Create("Frame", {
		Name = "AccentBar",
		Size = UDim2.new(0, 4, 0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = typeColor,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = card,
	})
	Round(accentBar, 4)
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

	-- Status icon
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

	-- Text frame (leave space for close button)
	local textFrame = Create("Frame", {
		Size = UDim2.new(1, -54, 0, 0),
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

	-- Progress bar
	local progressBar = Create("Frame", {
		Name = "ProgressBar",
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		BackgroundColor3 = typeColor,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = card,
	})
	Round(progressBar, 1)

	local isHovered = false
	card.MouseEnter:Connect(function() isHovered = true end)
	card.MouseLeave:Connect(function() isHovered = false end)

	card:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		accentBar.Size = UDim2.new(0, 4, 0, card.AbsoluteSize.Y)
		shadow.Size = UDim2.new(0, card.AbsoluteSize.X, 0, card.AbsoluteSize.Y)
	end)

	-- Slide in
	Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween(shadow, { Position = UDim2.new(0, 2, 0, 2) }, 0.4, Enum.EasingStyle.Quint)

	local connection
	local function Dismiss()
		if connection then
			connection:Disconnect()
			connection = nil
		end
		
		-- Slide out
		Tween(card, { Position = UDim2.new(0, startOffset, 0, 0) }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		Tween(shadow, { Position = UDim2.new(0, startOffset + 2, 0, 2) }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		task.wait(0.4)
		wrapper:Destroy()

		-- Dequeue next
		activeCount = activeCount - 1
		if #pendingQueue > 0 then
			local nextOptions = table.remove(pendingQueue, 1)
			NovaLib:Notify(nextOptions)
		end
	end

	-- Dismiss Button
	local dismissBtn = Create("TextButton", {
		Name = "DismissBtn",
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(1, -22, 0, 8),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 4,
		AutoButtonColor = false,
		Parent = card,
	})
	local dismissIcon = CreateIcon(dismissBtn, "x", Theme.SubText, 10)
	if dismissIcon then
		dismissIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		dismissIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	end

	dismissBtn.MouseEnter:Connect(function()
		if dismissIcon then Tween(dismissIcon, { ImageColor3 = Theme.Text }, 0.15) end
	end)
	dismissBtn.MouseLeave:Connect(function()
		if dismissIcon then Tween(dismissIcon, { ImageColor3 = Theme.SubText }, 0.15) end
	end)
	dismissBtn.MouseButton1Click:Connect(Dismiss)

	-- Auto dismiss countdown
	local totalTime = duration
	local timeLeft = duration
	connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
		if not card or not card.Parent then
			if connection then connection:Disconnect() end
			return
		end
		if not isHovered then
			timeLeft = timeLeft - dt
			progressBar.Size = UDim2.new(math.clamp(timeLeft / totalTime, 0, 1), 0, 0, 2)
			if timeLeft <= 0 then
				if connection then connection:Disconnect() end
				Dismiss()
			end
		end
	end)
end


--// File: src/Components/Section.lua //--
--// Section Component ---------------------------------------------------------

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


--// File: src/Elements/init.lua //--
--// Tab Elements -------------------------------------------------------------


--// File: src/Elements/Button.lua //--
--// Button Element -----------------------------------------------------------

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


--// File: src/Elements/Paragraph.lua //--
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


--// File: src/Elements/Toggle.lua //--
--// Toggle Element ------------------------------------------------------------

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
	local knobScale = Create("UIScale", {
		Scale = 1,
		Parent = knob,
	})

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
		
		-- Knob pop tactile animation
		Tween(knobScale, { Scale = 1.25 }, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		task.delay(0.1, function()
			Tween(knobScale, { Scale = 1.0 }, 0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end)
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


--// File: src/Elements/Slider.lua //--
--// Slider Element ------------------------------------------------------------

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


--// File: src/Elements/Dropdown.lua //--
--// Dropdown Element ----------------------------------------------------------

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


--// File: src/Elements/Input.lua //--
--// Input (TextBox) Element ---------------------------------------------------

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


--// File: src/Elements/Keybind.lua //--
--// Keybind Element -----------------------------------------------------------

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


--// File: src/Elements/Colorpicker.lua //--
--// Color Picker Element (RGB sliders) ----------------------------------------

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


--// File: src/Components/Tab.lua //--
--// Tab Creation Component ---------------------------------------------------

function WindowProto:CreateTab(tabOptions)
	tabOptions = tabOptions or {}
	local tabName = tabOptions.Name or "Tab"

	local TabObj = setmetatable({}, Tab)
	TabObj.Name = tabName
	TabObj.Window = self

	local tabButton = Create("TextButton", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = Theme.Tertiary,
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = self.TabList,
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
		TextSize = 14,
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
		Parent = self.Content,
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
		for _, other in ipairs(self.Tabs) do
			other.Page.Visible = false
			other.Button.BackgroundTransparency = 1
			Tween(other.Label, { TextColor3 = Theme.SubText }, 0.2)
			Tween(other.Indicator, { Size = UDim2.new(0, 3, 0, 0) }, 0.2)
			if other.IconImage then
				Tween(other.IconImage, { ImageColor3 = Theme.SubText }, 0.2)
			end
		end
		page.Visible = true
		self.ActiveTab = TabObj
		tabButton.BackgroundTransparency = 0
		Tween(tabLabel, { TextColor3 = Theme.Text }, 0.2)
		Tween(indicator, { Size = UDim2.new(0, 3, 1, -10) }, 0.25)
		if tabIconImg then
			Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.25)
		end
	end

	tabButton.MouseButton1Click:Connect(Activate)
	tabButton.MouseEnter:Connect(function()
		if self.ActiveTab ~= TabObj then
			Tween(tabLabel, { TextColor3 = Theme.Text }, 0.15)
			if tabIconImg then
				Tween(tabIconImg, { ImageColor3 = Theme.Text }, 0.15)
			end
		end
	end)
	tabButton.MouseLeave:Connect(function()
		if self.ActiveTab ~= TabObj then
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
	table.insert(self.Tabs, TabObj)

	if #self.Tabs == 1 then
		Activate()
	end

	return TabObj
end


--// File: src/Components/Window.lua //--
--// Window Component -----------------------------------------------------------

function NovaLib:CreateWindow(options)
	options = options or {}
	local windowTitle = options.Title or "NovaLib"
	local windowSize = options.Size or UDim2.new(0, 600, 0, 420)
	local themeName = options.Theme or "Black"
	local toggleKey = options.ToggleKey or Enum.KeyCode.RightControl
	local showIntro = options.Intro ~= false

	if themeName == "Black" then
		Theme = NovaLib.Themes.Darker
	elseif themeName == "Midnight" then
		Theme = NovaLib.Themes.Amethyst
	elseif NovaLib.Themes[themeName] then
		Theme = NovaLib.Themes[themeName]
	else
		Theme = NovaLib.Themes.Darker or NovaLib.Themes.Dark
	end

	if showIntro then
		PlayIntro(windowTitle, options.IntroText or "Loading interface...")
	end

	local Window = setmetatable({}, WindowProto)
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

	local windowScale = Create("UIScale", {
		Scale = 0.95,
		Parent = main,
	})

	-- Open transition
	Tween(main, {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		GroupTransparency = 0,
	}, 0.4, Enum.EasingStyle.Quint)
	Tween(windowScale, { Scale = 1 }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween(windowShadow, { BackgroundTransparency = 0.8 }, 0.45)

	--// Top Bar
	local topBar = Create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = Theme.Secondary,
		Parent = main,
	})
	Round(topBar, 12)
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
	local function WindowButton(iconName, xOffset, fallbackText)
		local btn = Create("TextButton", {
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(1, xOffset, 0.5, -14),
			BackgroundColor3 = Theme.Tertiary,
			BackgroundTransparency = 1,
			Text = fallbackText or "",
			FontFace = NovaLib.Fonts.Bold,
			TextColor3 = Theme.SubText,
			TextSize = 14,
			AutoButtonColor = false,
			Parent = topBar,
		})
		Round(btn, 7)

		local icon = CreateIcon(btn, iconName, Theme.SubText, 14)
		if icon then
			btn.Text = "" -- Hide text if icon loaded successfully
			icon.AnchorPoint = Vector2.new(0.5, 0.5)
			icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		end

		btn.MouseEnter:Connect(function()
			Tween(btn, { BackgroundTransparency = 0, TextColor3 = Theme.Text }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.Text }, 0.15)
			end
		end)
		btn.MouseLeave:Connect(function()
			Tween(btn, { BackgroundTransparency = 1, TextColor3 = Theme.SubText }, 0.15)
			if icon then
				Tween(icon, { ImageColor3 = Theme.SubText }, 0.15)
			end
		end)
		return btn
	end

	local closeBtn = WindowButton("x", -38, "✕")
	local minBtn = WindowButton("minus", -70, "—")

	closeBtn.MouseButton1Click:Connect(function()
		Tween(main, {
			Position = main.Position + UDim2.new(0, 0, 0, 20),
			GroupTransparency = 1,
		}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		Tween(windowScale, { Scale = 0.92 }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		Tween(windowShadow, { BackgroundTransparency = 1 }, 0.3)
		task.wait(0.38)
		Window:Destroy()
	end)

	local storedSize = windowSize
	minBtn.MouseButton1Click:Connect(function()
		Window.Minimized = not Window.Minimized
		if Window.Minimized then
			storedSize = main.Size
			Tween(main, { Size = UDim2.new(0, storedSize.X.Offset, 0, 44) }, 0.35)
			local icon = minBtn:FindFirstChild("minusIcon") or minBtn:FindFirstChild("plusIcon")
			if icon then
				icon.Name = "plusIcon"
				icon.Image = NovaLib:GetIcon("plus")
			else
				minBtn.Text = "+"
			end
		else
			Tween(main, { Size = storedSize }, 0.35, Enum.EasingStyle.Back)
			local icon = minBtn:FindFirstChild("plusIcon") or minBtn:FindFirstChild("minusIcon")
			if icon then
				icon.Name = "minusIcon"
				icon.Image = NovaLib:GetIcon("minus")
			else
				minBtn.Text = "—"
			end
		end
	end)

	MakeDraggable(topBar, main, Window.Connections)

	-- Window Resizing
	local resizeHandle = Create("Frame", {
		Name = "ResizeHandle",
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(1, -16, 1, -16),
		BackgroundTransparency = 1,
		ZIndex = 10,
		Parent = main,
	})
	local resizeIcon = CreateIcon(resizeHandle, "move-diagonal-2", Theme.SubText, 10)
	if resizeIcon then
		resizeIcon.Position = UDim2.new(0.5, -5, 0.5, -5)
	end

	local resizing = false
	local dragStart = Vector2.new()
	local startSize = Vector2.new()

	local resizeBegan = resizeHandle.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not Window.Minimized then
			resizing = true
			dragStart = input.Position
			startSize = Vector2.new(main.Size.X.Offset, main.Size.Y.Offset)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	local resizeChanged = UserInputService.InputChanged:Connect(function(input)
		if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			local newX = math.max(450, startSize.X + delta.X)
			local newY = math.max(300, startSize.Y + delta.Y)
			main.Size = UDim2.new(0, newX, 0, newY)
		end
	end)

	table.insert(Window.Connections, resizeBegan)
	table.insert(Window.Connections, resizeChanged)

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

	Window.TabList = tabList
	Window.Content = content

	return Window
end

--// Window-level OOP Methods ---------------------------------------------------

function WindowProto:Notify(opts)
	NovaLib:Notify(opts)
end

function WindowProto:SaveConfig(name)
	local ok = NovaLib:SaveConfig(name or "default")
	NovaLib:Notify({
		Title = ok and "Config Saved" or "Save Failed",
		Content = ok and ("Saved to " .. ConfigFolder .. "/" .. (name or "default") .. ".json")
			or "Your executor does not support file functions.",
		Type = ok and "Success" or "Error",
	})
	return ok
end

function WindowProto:LoadConfig(name)
	local data = NovaLib:LoadConfig(name or "default", self.Callbacks)
	NovaLib:Notify({
		Title = data and "Config Loaded" or "Load Failed",
		Content = data and "Your settings have been applied." or "No config found or executor unsupported.",
		Type = data and "Success" or "Error",
	})
	return data
end

function WindowProto:Destroy()
	for _, conn in ipairs(self.Connections) do
		pcall(function() conn:Disconnect() end)
	end
	table.clear(self.Connections)
	self.Gui:Destroy()
end


return NovaLib
