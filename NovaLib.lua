--[[
	NovaLib UI Library
	BUNLDED PRODUCTION BUILD
	Generated at: 2026-07-05 15:31:33
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
--// Icons (@generated by Tarmac / Lucide icon mappings)
NovaLib.Icons = {
	assets = {
		["lucide-accessibility"] = "rbxassetid://10709751939",
		["lucide-activity"] = "rbxassetid://10709752035",
		["lucide-air-vent"] = "rbxassetid://10709752131",
		["lucide-airplay"] = "rbxassetid://10709752254",
		["lucide-alarm-check"] = "rbxassetid://10709752405",
		["lucide-alarm-clock"] = "rbxassetid://10709752630",
		["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
		["lucide-alarm-minus"] = "rbxassetid://10709752732",
		["lucide-alarm-plus"] = "rbxassetid://10709752825",
		["lucide-album"] = "rbxassetid://10709752906",
		["lucide-alert-circle"] = "rbxassetid://10709752996",
		["lucide-alert-octagon"] = "rbxassetid://10709753064",
		["lucide-alert-triangle"] = "rbxassetid://10709753149",
		["lucide-align-center"] = "rbxassetid://10709753570",
		["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
		["lucide-align-center-vertical"] = "rbxassetid://10709753421",
		["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
		["lucide-align-end-vertical"] = "rbxassetid://10709753808",
		["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
		["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
		["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
		["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
		["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
		["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
		["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
		["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
		["lucide-align-justify"] = "rbxassetid://10709759610",
		["lucide-align-left"] = "rbxassetid://10709759764",
		["lucide-align-right"] = "rbxassetid://10709759895",
		["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
		["lucide-align-start-vertical"] = "rbxassetid://10709760244",
		["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
		["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
		["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
		["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
		["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
		["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
		["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
		["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
		["lucide-anchor"] = "rbxassetid://10709761530",
		["lucide-angry"] = "rbxassetid://10709761629",
		["lucide-annoyed"] = "rbxassetid://10709761722",
		["lucide-aperture"] = "rbxassetid://10709761813",
		["lucide-apple"] = "rbxassetid://10709761889",
		["lucide-archive"] = "rbxassetid://10709762233",
		["lucide-archive-restore"] = "rbxassetid://10709762058",
		["lucide-armchair"] = "rbxassetid://10709762327",
		["lucide-arrow-big-down"] = "rbxassetid://10747796644",
		["lucide-arrow-big-left"] = "rbxassetid://10709762574",
		["lucide-arrow-big-right"] = "rbxassetid://10709762727",
		["lucide-arrow-big-up"] = "rbxassetid://10709762879",
		["lucide-arrow-down"] = "rbxassetid://10709767827",
		["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
		["lucide-arrow-down-left"] = "rbxassetid://10709767656",
		["lucide-arrow-down-right"] = "rbxassetid://10709767750",
		["lucide-arrow-left"] = "rbxassetid://10709768114",
		["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
		["lucide-arrow-left-right"] = "rbxassetid://10709768019",
		["lucide-arrow-right"] = "rbxassetid://10709768347",
		["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
		["lucide-arrow-up"] = "rbxassetid://10709768939",
		["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
		["lucide-arrow-up-down"] = "rbxassetid://10709768538",
		["lucide-arrow-up-left"] = "rbxassetid://10709768661",
		["lucide-arrow-up-right"] = "rbxassetid://10709768787",
		["lucide-asterisk"] = "rbxassetid://10709769095",
		["lucide-at-sign"] = "rbxassetid://10709769286",
		["lucide-award"] = "rbxassetid://10709769406",
		["lucide-axe"] = "rbxassetid://10709769508",
		["lucide-axis-3d"] = "rbxassetid://10709769598",
		["lucide-baby"] = "rbxassetid://10709769732",
		["lucide-backpack"] = "rbxassetid://10709769841",
		["lucide-baggage-claim"] = "rbxassetid://10709769935",
		["lucide-banana"] = "rbxassetid://10709770005",
		["lucide-banknote"] = "rbxassetid://10709770178",
		["lucide-bar-chart"] = "rbxassetid://10709773755",
		["lucide-bar-chart-2"] = "rbxassetid://10709770317",
		["lucide-bar-chart-3"] = "rbxassetid://10709770431",
		["lucide-bar-chart-4"] = "rbxassetid://10709770560",
		["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
		["lucide-barcode"] = "rbxassetid://10747360675",
		["lucide-baseline"] = "rbxassetid://10709773863",
		["lucide-bath"] = "rbxassetid://10709773963",
		["lucide-battery"] = "rbxassetid://10709774640",
		["lucide-battery-charging"] = "rbxassetid://10709774068",
		["lucide-battery-full"] = "rbxassetid://10709774206",
		["lucide-battery-low"] = "rbxassetid://10709774370",
		["lucide-battery-medium"] = "rbxassetid://10709774513",
		["lucide-beaker"] = "rbxassetid://10709774756",
		["lucide-bed"] = "rbxassetid://10709775036",
		["lucide-bed-double"] = "rbxassetid://10709774864",
		["lucide-bed-single"] = "rbxassetid://10709774968",
		["lucide-beer"] = "rbxassetid://10709775167",
		["lucide-bell"] = "rbxassetid://10709775704",
		["lucide-bell-minus"] = "rbxassetid://10709775241",
		["lucide-bell-off"] = "rbxassetid://10709775320",
		["lucide-bell-plus"] = "rbxassetid://10709775448",
		["lucide-bell-ring"] = "rbxassetid://10709775560",
		["lucide-bike"] = "rbxassetid://10709775894",
		["lucide-binary"] = "rbxassetid://10709776050",
		["lucide-bitcoin"] = "rbxassetid://10709776126",
		["lucide-bluetooth"] = "rbxassetid://10709776655",
		["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
		["lucide-bluetooth-off"] = "rbxassetid://10709776344",
		["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
		["lucide-bold"] = "rbxassetid://10747813908",
		["lucide-bomb"] = "rbxassetid://10709781460",
		["lucide-bone"] = "rbxassetid://10709781605",
		["lucide-book"] = "rbxassetid://10709781824",
		["lucide-book-open"] = "rbxassetid://10709781717",
		["lucide-bookmark"] = "rbxassetid://10709782154",
		["lucide-bookmark-minus"] = "rbxassetid://10709781919",
		["lucide-bookmark-plus"] = "rbxassetid://10709782044",
		["lucide-bot"] = "rbxassetid://10709782230",
		["lucide-box"] = "rbxassetid://10709782497",
		["lucide-box-select"] = "rbxassetid://10709782342",
		["lucide-boxes"] = "rbxassetid://10709782582",
		["lucide-briefcase"] = "rbxassetid://10709782662",
		["lucide-brush"] = "rbxassetid://10709782758",
		["lucide-bug"] = "rbxassetid://10709782845",
		["lucide-building"] = "rbxassetid://10709783051",
		["lucide-building-2"] = "rbxassetid://10709782939",
		["lucide-bus"] = "rbxassetid://10709783137",
		["lucide-cake"] = "rbxassetid://10709783217",
		["lucide-calculator"] = "rbxassetid://10709783311",
		["lucide-calendar"] = "rbxassetid://10709789505",
		["lucide-calendar-check"] = "rbxassetid://10709783474",
		["lucide-calendar-check-2"] = "rbxassetid://10709783392",
		["lucide-calendar-clock"] = "rbxassetid://10709783577",
		["lucide-calendar-days"] = "rbxassetid://10709783673",
		["lucide-calendar-heart"] = "rbxassetid://10709783835",
		["lucide-calendar-minus"] = "rbxassetid://10709783959",
		["lucide-calendar-off"] = "rbxassetid://10709788784",
		["lucide-calendar-plus"] = "rbxassetid://10709788937",
		["lucide-calendar-range"] = "rbxassetid://10709789053",
		["lucide-calendar-search"] = "rbxassetid://10709789200",
		["lucide-calendar-x"] = "rbxassetid://10709789407",
		["lucide-calendar-x-2"] = "rbxassetid://10709789329",
		["lucide-camera"] = "rbxassetid://10709789686",
		["lucide-camera-off"] = "rbxassetid://10747822677",
		["lucide-car"] = "rbxassetid://10709789810",
		["lucide-carrot"] = "rbxassetid://10709789960",
		["lucide-cast"] = "rbxassetid://10709790097",
		["lucide-charge"] = "rbxassetid://10709790202",
		["lucide-check"] = "rbxassetid://10709790644",
		["lucide-check-circle"] = "rbxassetid://10709790387",
		["lucide-check-circle-2"] = "rbxassetid://10709790298",
		["lucide-check-square"] = "rbxassetid://10709790537",
		["lucide-chef-hat"] = "rbxassetid://10709790757",
		["lucide-cherry"] = "rbxassetid://10709790875",
		["lucide-chevron-down"] = "rbxassetid://10709790948",
		["lucide-chevron-first"] = "rbxassetid://10709791015",
		["lucide-chevron-last"] = "rbxassetid://10709791130",
		["lucide-chevron-left"] = "rbxassetid://10709791281",
		["lucide-chevron-right"] = "rbxassetid://10709791437",
		["lucide-chevron-up"] = "rbxassetid://10709791523",
		["lucide-chevrons-down"] = "rbxassetid://10709796864",
		["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
		["lucide-chevrons-left"] = "rbxassetid://10709797151",
		["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
		["lucide-chevrons-right"] = "rbxassetid://10709797382",
		["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
		["lucide-chevrons-up"] = "rbxassetid://10709797622",
		["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
		["lucide-chrome"] = "rbxassetid://10709797725",
		["lucide-circle"] = "rbxassetid://10709798174",
		["lucide-circle-dot"] = "rbxassetid://10709797837",
		["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
		["lucide-circle-slashed"] = "rbxassetid://10709798100",
		["lucide-citrus"] = "rbxassetid://10709798276",
		["lucide-clapperboard"] = "rbxassetid://10709798350",
		["lucide-clipboard"] = "rbxassetid://10709799288",
		["lucide-clipboard-check"] = "rbxassetid://10709798443",
		["lucide-clipboard-copy"] = "rbxassetid://10709798574",
		["lucide-clipboard-edit"] = "rbxassetid://10709798682",
		["lucide-clipboard-list"] = "rbxassetid://10709798792",
		["lucide-clipboard-signature"] = "rbxassetid://10709798890",
		["lucide-clipboard-type"] = "rbxassetid://10709798999",
		["lucide-clipboard-x"] = "rbxassetid://10709799124",
		["lucide-clock"] = "rbxassetid://10709805144",
		["lucide-clock-1"] = "rbxassetid://10709799535",
		["lucide-clock-10"] = "rbxassetid://10709799718",
		["lucide-clock-11"] = "rbxassetid://10709799818",
		["lucide-clock-12"] = "rbxassetid://10709799962",
		["lucide-clock-2"] = "rbxassetid://10709803876",
		["lucide-clock-3"] = "rbxassetid://10709803989",
		["lucide-clock-4"] = "rbxassetid://10709804164",
		["lucide-clock-5"] = "rbxassetid://10709804291",
		["lucide-clock-6"] = "rbxassetid://10709804435",
		["lucide-clock-7"] = "rbxassetid://10709804599",
		["lucide-clock-8"] = "rbxassetid://10709804784",
		["lucide-clock-9"] = "rbxassetid://10709804996",
		["lucide-cloud"] = "rbxassetid://10709806740",
		["lucide-cloud-cog"] = "rbxassetid://10709805262",
		["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
		["lucide-cloud-fog"] = "rbxassetid://10709805477",
		["lucide-cloud-hail"] = "rbxassetid://10709805596",
		["lucide-cloud-lightning"] = "rbxassetid://10709805727",
		["lucide-cloud-moon"] = "rbxassetid://10709805942",
		["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
		["lucide-cloud-off"] = "rbxassetid://10709806060",
		["lucide-cloud-rain"] = "rbxassetid://10709806277",
		["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
		["lucide-cloud-snow"] = "rbxassetid://10709806374",
		["lucide-cloud-sun"] = "rbxassetid://10709806631",
		["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
		["lucide-cloudy"] = "rbxassetid://10709806859",
		["lucide-clover"] = "rbxassetid://10709806995",
		["lucide-code"] = "rbxassetid://10709810463",
		["lucide-code-2"] = "rbxassetid://10709807111",
		["lucide-codepen"] = "rbxassetid://10709810534",
		["lucide-codesandbox"] = "rbxassetid://10709810676",
		["lucide-coffee"] = "rbxassetid://10709810814",
		["lucide-cog"] = "rbxassetid://10709810948",
		["lucide-coins"] = "rbxassetid://10709811110",
		["lucide-columns"] = "rbxassetid://10709811261",
		["lucide-command"] = "rbxassetid://10709811365",
		["lucide-compass"] = "rbxassetid://10709811445",
		["lucide-component"] = "rbxassetid://10709811595",
		["lucide-concierge-bell"] = "rbxassetid://10709811706",
		["lucide-connection"] = "rbxassetid://10747361219",
		["lucide-contact"] = "rbxassetid://10709811834",
		["lucide-contrast"] = "rbxassetid://10709811939",
		["lucide-cookie"] = "rbxassetid://10709812067",
		["lucide-copy"] = "rbxassetid://10709812159",
		["lucide-copyleft"] = "rbxassetid://10709812251",
		["lucide-copyright"] = "rbxassetid://10709812311",
		["lucide-corner-down-left"] = "rbxassetid://10709812396",
		["lucide-corner-down-right"] = "rbxassetid://10709812485",
		["lucide-corner-left-down"] = "rbxassetid://10709812632",
		["lucide-corner-left-up"] = "rbxassetid://10709812784",
		["lucide-corner-right-down"] = "rbxassetid://10709812939",
		["lucide-corner-right-up"] = "rbxassetid://10709813094",
		["lucide-corner-up-left"] = "rbxassetid://10709813185",
		["lucide-corner-up-right"] = "rbxassetid://10709813281",
		["lucide-cpu"] = "rbxassetid://10709813383",
		["lucide-croissant"] = "rbxassetid://10709818125",
		["lucide-crop"] = "rbxassetid://10709818245",
		["lucide-cross"] = "rbxassetid://10709818399",
		["lucide-crosshair"] = "rbxassetid://10709818534",
		["lucide-crown"] = "rbxassetid://10709818626",
		["lucide-cup-soda"] = "rbxassetid://10709818763",
		["lucide-curly-braces"] = "rbxassetid://10709818847",
		["lucide-currency"] = "rbxassetid://10709818931",
		["lucide-database"] = "rbxassetid://10709818996",
		["lucide-delete"] = "rbxassetid://10709819059",
		["lucide-diamond"] = "rbxassetid://10709819149",
		["lucide-dice-1"] = "rbxassetid://10709819266",
		["lucide-dice-2"] = "rbxassetid://10709819361",
		["lucide-dice-3"] = "rbxassetid://10709819508",
		["lucide-dice-4"] = "rbxassetid://10709819670",
		["lucide-dice-5"] = "rbxassetid://10709819801",
		["lucide-dice-6"] = "rbxassetid://10709819896",
		["lucide-dices"] = "rbxassetid://10723343321",
		["lucide-diff"] = "rbxassetid://10723343416",
		["lucide-disc"] = "rbxassetid://10723343537",
		["lucide-divide"] = "rbxassetid://10723343805",
		["lucide-divide-circle"] = "rbxassetid://10723343636",
		["lucide-divide-square"] = "rbxassetid://10723343737",
		["lucide-dollar-sign"] = "rbxassetid://10723343958",
		["lucide-download"] = "rbxassetid://10723344270",
		["lucide-download-cloud"] = "rbxassetid://10723344088",
		["lucide-droplet"] = "rbxassetid://10723344432",
		["lucide-droplets"] = "rbxassetid://10734883356",
		["lucide-drumstick"] = "rbxassetid://10723344737",
		["lucide-edit"] = "rbxassetid://10734883598",
		["lucide-edit-2"] = "rbxassetid://10723344885",
		["lucide-edit-3"] = "rbxassetid://10723345088",
		["lucide-egg"] = "rbxassetid://10723345518",
		["lucide-egg-fried"] = "rbxassetid://10723345347",
		["lucide-electricity"] = "rbxassetid://10723345749",
		["lucide-electricity-off"] = "rbxassetid://10723345643",
		["lucide-equal"] = "rbxassetid://10723345990",
		["lucide-equal-not"] = "rbxassetid://10723345866",
		["lucide-eraser"] = "rbxassetid://10723346158",
		["lucide-euro"] = "rbxassetid://10723346372",
		["lucide-expand"] = "rbxassetid://10723346553",
		["lucide-external-link"] = "rbxassetid://10723346684",
		["lucide-eye"] = "rbxassetid://10723346959",
		["lucide-eye-off"] = "rbxassetid://10723346871",
		["lucide-factory"] = "rbxassetid://10723347051",
		["lucide-fan"] = "rbxassetid://10723354359",
		["lucide-fast-forward"] = "rbxassetid://10723354521",
		["lucide-feather"] = "rbxassetid://10723354671",
		["lucide-figma"] = "rbxassetid://10723354801",
		["lucide-file"] = "rbxassetid://10723374641",
		["lucide-file-archive"] = "rbxassetid://10723354921",
		["lucide-file-audio"] = "rbxassetid://10723355148",
		["lucide-file-audio-2"] = "rbxassetid://10723355026",
		["lucide-file-axis-3d"] = "rbxassetid://10723355272",
		["lucide-file-badge"] = "rbxassetid://10723355622",
		["lucide-file-badge-2"] = "rbxassetid://10723355451",
		["lucide-file-bar-chart"] = "rbxassetid://10723355887",
		["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
		["lucide-file-box"] = "rbxassetid://10723355989",
		["lucide-file-check"] = "rbxassetid://10723356210",
		["lucide-file-check-2"] = "rbxassetid://10723356100",
		["lucide-file-clock"] = "rbxassetid://10723356329",
		["lucide-file-code"] = "rbxassetid://10723356507",
		["lucide-file-cog"] = "rbxassetid://10723356830",
		["lucide-file-cog-2"] = "rbxassetid://10723356676",
		["lucide-file-diff"] = "rbxassetid://10723357039",
		["lucide-file-digit"] = "rbxassetid://10723357151",
		["lucide-file-down"] = "rbxassetid://10723357322",
		["lucide-file-edit"] = "rbxassetid://10723357495",
		["lucide-file-heart"] = "rbxassetid://10723357637",
		["lucide-file-image"] = "rbxassetid://10723357790",
		["lucide-file-input"] = "rbxassetid://10723357933",
		["lucide-file-json"] = "rbxassetid://10723364435",
		["lucide-file-json-2"] = "rbxassetid://10723364361",
		["lucide-file-key"] = "rbxassetid://10723364605",
		["lucide-file-key-2"] = "rbxassetid://10723364515",
		["lucide-file-line-chart"] = "rbxassetid://10723364725",
		["lucide-file-lock"] = "rbxassetid://10723364957",
		["lucide-file-lock-2"] = "rbxassetid://10723364861",
		["lucide-file-minus"] = "rbxassetid://10723365254",
		["lucide-file-minus-2"] = "rbxassetid://10723365086",
		["lucide-file-output"] = "rbxassetid://10723365457",
		["lucide-file-pie-chart"] = "rbxassetid://10723365598",
		["lucide-file-plus"] = "rbxassetid://10723365877",
		["lucide-file-plus-2"] = "rbxassetid://10723365766",
		["lucide-file-question"] = "rbxassetid://10723365987",
		["lucide-file-scan"] = "rbxassetid://10723366167",
		["lucide-file-search"] = "rbxassetid://10723366550",
		["lucide-file-search-2"] = "rbxassetid://10723366340",
		["lucide-file-signature"] = "rbxassetid://10723366741",
		["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
		["lucide-file-symlink"] = "rbxassetid://10723367098",
		["lucide-file-terminal"] = "rbxassetid://10723367244",
		["lucide-file-text"] = "rbxassetid://10723367380",
		["lucide-file-type"] = "rbxassetid://10723367606",
		["lucide-file-type-2"] = "rbxassetid://10723367509",
		["lucide-file-up"] = "rbxassetid://10723367734",
		["lucide-file-video"] = "rbxassetid://10723373884",
		["lucide-file-video-2"] = "rbxassetid://10723367834",
		["lucide-file-volume"] = "rbxassetid://10723374172",
		["lucide-file-volume-2"] = "rbxassetid://10723374030",
		["lucide-file-warning"] = "rbxassetid://10723374276",
		["lucide-file-x"] = "rbxassetid://10723374544",
		["lucide-file-x-2"] = "rbxassetid://10723374378",
		["lucide-files"] = "rbxassetid://10723374759",
		["lucide-film"] = "rbxassetid://10723374981",
		["lucide-filter"] = "rbxassetid://10723375128",
		["lucide-fingerprint"] = "rbxassetid://10723375250",
		["lucide-flag"] = "rbxassetid://10723375890",
		["lucide-flag-off"] = "rbxassetid://10723375443",
		["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
		["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
		["lucide-flame"] = "rbxassetid://10723376114",
		["lucide-flashlight"] = "rbxassetid://10723376471",
		["lucide-flashlight-off"] = "rbxassetid://10723376365",
		["lucide-flask-conical"] = "rbxassetid://10734883986",
		["lucide-flask-round"] = "rbxassetid://10723376614",
		["lucide-flip-horizontal"] = "rbxassetid://10723376884",
		["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
		["lucide-flip-vertical"] = "rbxassetid://10723377138",
		["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
		["lucide-flower"] = "rbxassetid://10747830374",
		["lucide-flower-2"] = "rbxassetid://10723377305",
		["lucide-focus"] = "rbxassetid://10723377537",
		["lucide-folder"] = "rbxassetid://10723387563",
		["lucide-folder-archive"] = "rbxassetid://10723384478",
		["lucide-folder-check"] = "rbxassetid://10723384605",
		["lucide-folder-clock"] = "rbxassetid://10723384731",
		["lucide-folder-closed"] = "rbxassetid://10723384893",
		["lucide-folder-cog"] = "rbxassetid://10723385213",
		["lucide-folder-cog-2"] = "rbxassetid://10723385036",
		["lucide-folder-down"] = "rbxassetid://10723385338",
		["lucide-folder-edit"] = "rbxassetid://10723385445",
		["lucide-folder-heart"] = "rbxassetid://10723385545",
		["lucide-folder-input"] = "rbxassetid://10723385721",
		["lucide-folder-key"] = "rbxassetid://10723385848",
		["lucide-folder-lock"] = "rbxassetid://10723386005",
		["lucide-folder-minus"] = "rbxassetid://10723386127",
		["lucide-folder-open"] = "rbxassetid://10723386277",
		["lucide-folder-output"] = "rbxassetid://10723386386",
		["lucide-folder-plus"] = "rbxassetid://10723386531",
		["lucide-folder-search"] = "rbxassetid://10723386787",
		["lucide-folder-search-2"] = "rbxassetid://10723386674",
		["lucide-folder-symlink"] = "rbxassetid://10723386930",
		["lucide-folder-tree"] = "rbxassetid://10723387085",
		["lucide-folder-up"] = "rbxassetid://10723387265",
		["lucide-folder-x"] = "rbxassetid://10723387448",
		["lucide-folders"] = "rbxassetid://10723387721",
		["lucide-form-input"] = "rbxassetid://10723387841",
		["lucide-forward"] = "rbxassetid://10723388016",
		["lucide-frame"] = "rbxassetid://10723394389",
		["lucide-framer"] = "rbxassetid://10723394565",
		["lucide-frown"] = "rbxassetid://10723394681",
		["lucide-fuel"] = "rbxassetid://10723394846",
		["lucide-function-square"] = "rbxassetid://10723395041",
		["lucide-gamepad"] = "rbxassetid://10723395457",
		["lucide-gamepad-2"] = "rbxassetid://10723395215",
		["lucide-gauge"] = "rbxassetid://10723395708",
		["lucide-gavel"] = "rbxassetid://10723395896",
		["lucide-gem"] = "rbxassetid://10723396000",
		["lucide-ghost"] = "rbxassetid://10723396107",
		["lucide-gift"] = "rbxassetid://10723396402",
		["lucide-gift-card"] = "rbxassetid://10723396225",
		["lucide-git-branch"] = "rbxassetid://10723396676",
		["lucide-git-branch-plus"] = "rbxassetid://10723396542",
		["lucide-git-commit"] = "rbxassetid://10723396812",
		["lucide-git-compare"] = "rbxassetid://10723396954",
		["lucide-git-fork"] = "rbxassetid://10723397049",
		["lucide-git-merge"] = "rbxassetid://10723397165",
		["lucide-git-pull-request"] = "rbxassetid://10723397431",
		["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
		["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
		["lucide-glass"] = "rbxassetid://10723397788",
		["lucide-glass-2"] = "rbxassetid://10723397529",
		["lucide-glass-water"] = "rbxassetid://10723397678",
		["lucide-glasses"] = "rbxassetid://10723397895",
		["lucide-globe"] = "rbxassetid://10723404337",
		["lucide-globe-2"] = "rbxassetid://10723398002",
		["lucide-grab"] = "rbxassetid://10723404472",
		["lucide-graduation-cap"] = "rbxassetid://10723404691",
		["lucide-grape"] = "rbxassetid://10723404822",
		["lucide-grid"] = "rbxassetid://10723404936",
		["lucide-grip-horizontal"] = "rbxassetid://10723405089",
		["lucide-grip-vertical"] = "rbxassetid://10723405236",
		["lucide-hammer"] = "rbxassetid://10723405360",
		["lucide-hand"] = "rbxassetid://10723405649",
		["lucide-hand-metal"] = "rbxassetid://10723405508",
		["lucide-hard-drive"] = "rbxassetid://10723405749",
		["lucide-hard-hat"] = "rbxassetid://10723405859",
		["lucide-hash"] = "rbxassetid://10723405975",
		["lucide-haze"] = "rbxassetid://10723406078",
		["lucide-headphones"] = "rbxassetid://10723406165",
		["lucide-heart"] = "rbxassetid://10723406885",
		["lucide-heart-crack"] = "rbxassetid://10723406299",
		["lucide-heart-handshake"] = "rbxassetid://10723406480",
		["lucide-heart-off"] = "rbxassetid://10723406662",
		["lucide-heart-pulse"] = "rbxassetid://10723406795",
		["lucide-help-circle"] = "rbxassetid://10723406988",
		["lucide-hexagon"] = "rbxassetid://10723407092",
		["lucide-highlighter"] = "rbxassetid://10723407192",
		["lucide-history"] = "rbxassetid://10723407335",
		["lucide-home"] = "rbxassetid://10723407389",
		["lucide-hourglass"] = "rbxassetid://10723407498",
		["lucide-ice-cream"] = "rbxassetid://10723414308",
		["lucide-image"] = "rbxassetid://10723415040",
		["lucide-image-minus"] = "rbxassetid://10723414487",
		["lucide-image-off"] = "rbxassetid://10723414677",
		["lucide-image-plus"] = "rbxassetid://10723414827",
		["lucide-import"] = "rbxassetid://10723415205",
		["lucide-inbox"] = "rbxassetid://10723415335",
		["lucide-indent"] = "rbxassetid://10723415494",
		["lucide-indian-rupee"] = "rbxassetid://10723415642",
		["lucide-infinity"] = "rbxassetid://10723415766",
		["lucide-info"] = "rbxassetid://10723415903",
		["lucide-inspect"] = "rbxassetid://10723416057",
		["lucide-italic"] = "rbxassetid://10723416195",
		["lucide-japanese-yen"] = "rbxassetid://10723416363",
		["lucide-joystick"] = "rbxassetid://10723416527",
		["lucide-key"] = "rbxassetid://10723416652",
		["lucide-keyboard"] = "rbxassetid://10723416765",
		["lucide-lamp"] = "rbxassetid://10723417513",
		["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
		["lucide-lamp-desk"] = "rbxassetid://10723417016",
		["lucide-lamp-floor"] = "rbxassetid://10723417131",
		["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
		["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
		["lucide-landmark"] = "rbxassetid://10723417608",
		["lucide-languages"] = "rbxassetid://10723417703",
		["lucide-laptop"] = "rbxassetid://10723423881",
		["lucide-laptop-2"] = "rbxassetid://10723417797",
		["lucide-lasso"] = "rbxassetid://10723424235",
		["lucide-lasso-select"] = "rbxassetid://10723424058",
		["lucide-laugh"] = "rbxassetid://10723424372",
		["lucide-layers"] = "rbxassetid://10723424505",
		["lucide-layout"] = "rbxassetid://10723425376",
		["lucide-layout-dashboard"] = "rbxassetid://10723424646",
		["lucide-layout-grid"] = "rbxassetid://10723424838",
		["lucide-layout-list"] = "rbxassetid://10723424963",
		["lucide-layout-template"] = "rbxassetid://10723425187",
		["lucide-leaf"] = "rbxassetid://10723425539",
		["lucide-library"] = "rbxassetid://10723425615",
		["lucide-life-buoy"] = "rbxassetid://10723425685",
		["lucide-lightbulb"] = "rbxassetid://10723425852",
		["lucide-lightbulb-off"] = "rbxassetid://10723425762",
		["lucide-line-chart"] = "rbxassetid://10723426393",
		["lucide-link"] = "rbxassetid://10723426722",
		["lucide-link-2"] = "rbxassetid://10723426595",
		["lucide-link-2-off"] = "rbxassetid://10723426513",
		["lucide-list"] = "rbxassetid://10723433811",
		["lucide-list-checks"] = "rbxassetid://10734884548",
		["lucide-list-end"] = "rbxassetid://10723426886",
		["lucide-list-minus"] = "rbxassetid://10723426986",
		["lucide-list-music"] = "rbxassetid://10723427081",
		["lucide-list-ordered"] = "rbxassetid://10723427199",
		["lucide-list-plus"] = "rbxassetid://10723427334",
		["lucide-list-start"] = "rbxassetid://10723427494",
		["lucide-list-video"] = "rbxassetid://10723427619",
		["lucide-list-x"] = "rbxassetid://10723433655",
		["lucide-loader"] = "rbxassetid://10723434070",
		["lucide-loader-2"] = "rbxassetid://10723433935",
		["lucide-locate"] = "rbxassetid://10723434557",
		["lucide-locate-fixed"] = "rbxassetid://10723434236",
		["lucide-locate-off"] = "rbxassetid://10723434379",
		["lucide-lock"] = "rbxassetid://10723434711",
		["lucide-log-in"] = "rbxassetid://10723434830",
		["lucide-log-out"] = "rbxassetid://10723434906",
		["lucide-luggage"] = "rbxassetid://10723434993",
		["lucide-magnet"] = "rbxassetid://10723435069",
		["lucide-mail"] = "rbxassetid://10734885430",
		["lucide-mail-check"] = "rbxassetid://10723435182",
		["lucide-mail-minus"] = "rbxassetid://10723435261",
		["lucide-mail-open"] = "rbxassetid://10723435342",
		["lucide-mail-plus"] = "rbxassetid://10723435443",
		["lucide-mail-question"] = "rbxassetid://10723435515",
		["lucide-mail-search"] = "rbxassetid://10734884739",
		["lucide-mail-warning"] = "rbxassetid://10734885015",
		["lucide-mail-x"] = "rbxassetid://10734885247",
		["lucide-mails"] = "rbxassetid://10734885614",
		["lucide-map"] = "rbxassetid://10734886202",
		["lucide-map-pin"] = "rbxassetid://10734886004",
		["lucide-map-pin-off"] = "rbxassetid://10734885803",
		["lucide-maximize"] = "rbxassetid://10734886735",
		["lucide-maximize-2"] = "rbxassetid://10734886496",
		["lucide-medal"] = "rbxassetid://10734887072",
		["lucide-megaphone"] = "rbxassetid://10734887454",
		["lucide-megaphone-off"] = "rbxassetid://10734887311",
		["lucide-meh"] = "rbxassetid://10734887603",
		["lucide-menu"] = "rbxassetid://10734887784",
		["lucide-message-circle"] = "rbxassetid://10734888000",
		["lucide-message-square"] = "rbxassetid://10734888228",
		["lucide-mic"] = "rbxassetid://10734888864",
		["lucide-mic-2"] = "rbxassetid://10734888430",
		["lucide-mic-off"] = "rbxassetid://10734888646",
		["lucide-microscope"] = "rbxassetid://10734889106",
		["lucide-microwave"] = "rbxassetid://10734895076",
		["lucide-milestone"] = "rbxassetid://10734895310",
		["lucide-minimize"] = "rbxassetid://10734895698",
		["lucide-minimize-2"] = "rbxassetid://10734895530",
		["lucide-minus"] = "rbxassetid://10734896206",
		["lucide-minus-circle"] = "rbxassetid://10734895856",
		["lucide-minus-square"] = "rbxassetid://10734896029",
		["lucide-monitor"] = "rbxassetid://10734896881",
		["lucide-monitor-off"] = "rbxassetid://10734896360",
		["lucide-monitor-speaker"] = "rbxassetid://10734896512",
		["lucide-moon"] = "rbxassetid://10734897102",
		["lucide-more-horizontal"] = "rbxassetid://10734897250",
		["lucide-more-vertical"] = "rbxassetid://10734897387",
		["lucide-mountain"] = "rbxassetid://10734897956",
		["lucide-mountain-snow"] = "rbxassetid://10734897665",
		["lucide-mouse"] = "rbxassetid://10734898592",
		["lucide-mouse-pointer"] = "rbxassetid://10734898476",
		["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
		["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
		["lucide-move"] = "rbxassetid://10734900011",
		["lucide-move-3d"] = "rbxassetid://10734898756",
		["lucide-move-diagonal"] = "rbxassetid://10734899164",
		["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
		["lucide-move-horizontal"] = "rbxassetid://10734899414",
		["lucide-move-vertical"] = "rbxassetid://10734899821",
		["lucide-music"] = "rbxassetid://10734905958",
		["lucide-music-2"] = "rbxassetid://10734900215",
		["lucide-music-3"] = "rbxassetid://10734905665",
		["lucide-music-4"] = "rbxassetid://10734905823",
		["lucide-navigation"] = "rbxassetid://10734906744",
		["lucide-navigation-2"] = "rbxassetid://10734906332",
		["lucide-navigation-2-off"] = "rbxassetid://10734906144",
		["lucide-navigation-off"] = "rbxassetid://10734906580",
		["lucide-network"] = "rbxassetid://10734906975",
		["lucide-newspaper"] = "rbxassetid://10734907168",
		["lucide-octagon"] = "rbxassetid://10734907361",
		["lucide-option"] = "rbxassetid://10734907649",
		["lucide-outdent"] = "rbxassetid://10734907933",
		["lucide-package"] = "rbxassetid://10734909540",
		["lucide-package-2"] = "rbxassetid://10734908151",
		["lucide-package-check"] = "rbxassetid://10734908384",
		["lucide-package-minus"] = "rbxassetid://10734908626",
		["lucide-package-open"] = "rbxassetid://10734908793",
		["lucide-package-plus"] = "rbxassetid://10734909016",
		["lucide-package-search"] = "rbxassetid://10734909196",
		["lucide-package-x"] = "rbxassetid://10734909375",
		["lucide-paint-bucket"] = "rbxassetid://10734909847",
		["lucide-paintbrush"] = "rbxassetid://10734910187",
		["lucide-paintbrush-2"] = "rbxassetid://10734910030",
		["lucide-palette"] = "rbxassetid://10734910430",
		["lucide-palmtree"] = "rbxassetid://10734910680",
		["lucide-paperclip"] = "rbxassetid://10734910927",
		["lucide-party-popper"] = "rbxassetid://10734918735",
		["lucide-pause"] = "rbxassetid://10734919336",
		["lucide-pause-circle"] = "rbxassetid://10735024209",
		["lucide-pause-octagon"] = "rbxassetid://10734919143",
		["lucide-pen-tool"] = "rbxassetid://10734919503",
		["lucide-pencil"] = "rbxassetid://10734919691",
		["lucide-percent"] = "rbxassetid://10734919919",
		["lucide-person-standing"] = "rbxassetid://10734920149",
		["lucide-phone"] = "rbxassetid://10734921524",
		["lucide-phone-call"] = "rbxassetid://10734920305",
		["lucide-phone-forwarded"] = "rbxassetid://10734920508",
		["lucide-phone-incoming"] = "rbxassetid://10734920694",
		["lucide-phone-missed"] = "rbxassetid://10734920845",
		["lucide-phone-off"] = "rbxassetid://10734921077",
		["lucide-phone-outgoing"] = "rbxassetid://10734921288",
		["lucide-pie-chart"] = "rbxassetid://10734921727",
		["lucide-piggy-bank"] = "rbxassetid://10734921935",
		["lucide-pin"] = "rbxassetid://10734922324",
		["lucide-pin-off"] = "rbxassetid://10734922180",
		["lucide-pipette"] = "rbxassetid://10734922497",
		["lucide-pizza"] = "rbxassetid://10734922774",
		["lucide-plane"] = "rbxassetid://10734922971",
		["lucide-play"] = "rbxassetid://10734923549",
		["lucide-play-circle"] = "rbxassetid://10734923214",
		["lucide-plus"] = "rbxassetid://10734924532",
		["lucide-plus-circle"] = "rbxassetid://10734923868",
		["lucide-plus-square"] = "rbxassetid://10734924219",
		["lucide-podcast"] = "rbxassetid://10734929553",
		["lucide-pointer"] = "rbxassetid://10734929723",
		["lucide-pound-sterling"] = "rbxassetid://10734929981",
		["lucide-power"] = "rbxassetid://10734930466",
		["lucide-power-off"] = "rbxassetid://10734930257",
		["lucide-printer"] = "rbxassetid://10734930632",
		["lucide-puzzle"] = "rbxassetid://10734930886",
		["lucide-quote"] = "rbxassetid://10734931234",
		["lucide-radio"] = "rbxassetid://10734931596",
		["lucide-radio-receiver"] = "rbxassetid://10734931402",
		["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
		["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
		["lucide-recycle"] = "rbxassetid://10734932295",
		["lucide-redo"] = "rbxassetid://10734932822",
		["lucide-redo-2"] = "rbxassetid://10734932586",
		["lucide-refresh-ccw"] = "rbxassetid://10734933056",
		["lucide-refresh-cw"] = "rbxassetid://10734933222",
		["lucide-refrigerator"] = "rbxassetid://10734933465",
		["lucide-regex"] = "rbxassetid://10734933655",
		["lucide-repeat"] = "rbxassetid://10734933966",
		["lucide-repeat-1"] = "rbxassetid://10734933826",
		["lucide-reply"] = "rbxassetid://10734934252",
		["lucide-reply-all"] = "rbxassetid://10734934132",
		["lucide-rewind"] = "rbxassetid://10734934347",
		["lucide-rocket"] = "rbxassetid://10734934585",
		["lucide-rocking-chair"] = "rbxassetid://10734939942",
		["lucide-rotate-3d"] = "rbxassetid://10734940107",
		["lucide-rotate-ccw"] = "rbxassetid://10734940376",
		["lucide-rotate-cw"] = "rbxassetid://10734940654",
		["lucide-rss"] = "rbxassetid://10734940825",
		["lucide-ruler"] = "rbxassetid://10734941018",
		["lucide-russian-ruble"] = "rbxassetid://10734941199",
		["lucide-sailboat"] = "rbxassetid://10734941354",
		["lucide-save"] = "rbxassetid://10734941499",
		["lucide-scale"] = "rbxassetid://10734941912",
		["lucide-scale-3d"] = "rbxassetid://10734941739",
		["lucide-scaling"] = "rbxassetid://10734942072",
		["lucide-scan"] = "rbxassetid://10734942565",
		["lucide-scan-face"] = "rbxassetid://10734942198",
		["lucide-scan-line"] = "rbxassetid://10734942351",
		["lucide-scissors"] = "rbxassetid://10734942778",
		["lucide-screen-share"] = "rbxassetid://10734943193",
		["lucide-screen-share-off"] = "rbxassetid://10734942967",
		["lucide-scroll"] = "rbxassetid://10734943448",
		["lucide-search"] = "rbxassetid://10734943674",
		["lucide-send"] = "rbxassetid://10734943902",
		["lucide-separator-horizontal"] = "rbxassetid://10734944115",
		["lucide-separator-vertical"] = "rbxassetid://10734944326",
		["lucide-server"] = "rbxassetid://10734949856",
		["lucide-server-cog"] = "rbxassetid://10734944444",
		["lucide-server-crash"] = "rbxassetid://10734944554",
		["lucide-server-off"] = "rbxassetid://10734944668",
		["lucide-settings"] = "rbxassetid://10734950309",
		["lucide-settings-2"] = "rbxassetid://10734950020",
		["lucide-share"] = "rbxassetid://10734950813",
		["lucide-share-2"] = "rbxassetid://10734950553",
		["lucide-sheet"] = "rbxassetid://10734951038",
		["lucide-shield"] = "rbxassetid://10734951847",
		["lucide-shield-alert"] = "rbxassetid://10734951173",
		["lucide-shield-check"] = "rbxassetid://10734951367",
		["lucide-shield-close"] = "rbxassetid://10734951535",
		["lucide-shield-off"] = "rbxassetid://10734951684",
		["lucide-shirt"] = "rbxassetid://10734952036",
		["lucide-shopping-bag"] = "rbxassetid://10734952273",
		["lucide-shopping-cart"] = "rbxassetid://10734952479",
		["lucide-shovel"] = "rbxassetid://10734952773",
		["lucide-shower-head"] = "rbxassetid://10734952942",
		["lucide-shrink"] = "rbxassetid://10734953073",
		["lucide-shrub"] = "rbxassetid://10734953241",
		["lucide-shuffle"] = "rbxassetid://10734953451",
		["lucide-sidebar"] = "rbxassetid://10734954301",
		["lucide-sidebar-close"] = "rbxassetid://10734953715",
		["lucide-sidebar-open"] = "rbxassetid://10734954000",
		["lucide-sigma"] = "rbxassetid://10734954538",
		["lucide-signal"] = "rbxassetid://10734961133",
		["lucide-signal-high"] = "rbxassetid://10734954807",
		["lucide-signal-low"] = "rbxassetid://10734955080",
		["lucide-signal-medium"] = "rbxassetid://10734955336",
		["lucide-signal-zero"] = "rbxassetid://10734960878",
		["lucide-siren"] = "rbxassetid://10734961284",
		["lucide-skip-back"] = "rbxassetid://10734961526",
		["lucide-skip-forward"] = "rbxassetid://10734961809",
		["lucide-skull"] = "rbxassetid://10734962068",
		["lucide-slack"] = "rbxassetid://10734962339",
		["lucide-slash"] = "rbxassetid://10734962600",
		["lucide-slice"] = "rbxassetid://10734963024",
		["lucide-sliders"] = "rbxassetid://10734963400",
		["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
		["lucide-smartphone"] = "rbxassetid://10734963940",
		["lucide-smartphone-charging"] = "rbxassetid://10734963671",
		["lucide-smile"] = "rbxassetid://10734964441",
		["lucide-smile-plus"] = "rbxassetid://10734964188",
		["lucide-snowflake"] = "rbxassetid://10734964600",
		["lucide-sofa"] = "rbxassetid://10734964852",
		["lucide-sort-asc"] = "rbxassetid://10734965115",
		["lucide-sort-desc"] = "rbxassetid://10734965287",
		["lucide-speaker"] = "rbxassetid://10734965419",
		["lucide-sprout"] = "rbxassetid://10734965572",
		["lucide-square"] = "rbxassetid://10734965702",
		["lucide-star"] = "rbxassetid://10734966248",
		["lucide-star-half"] = "rbxassetid://10734965897",
		["lucide-star-off"] = "rbxassetid://10734966097",
		["lucide-stethoscope"] = "rbxassetid://10734966384",
		["lucide-sticker"] = "rbxassetid://10734972234",
		["lucide-sticky-note"] = "rbxassetid://10734972463",
		["lucide-stop-circle"] = "rbxassetid://10734972621",
		["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
		["lucide-stretch-vertical"] = "rbxassetid://10734973130",
		["lucide-strikethrough"] = "rbxassetid://10734973290",
		["lucide-subscript"] = "rbxassetid://10734973457",
		["lucide-sun"] = "rbxassetid://10734974297",
		["lucide-sun-dim"] = "rbxassetid://10734973645",
		["lucide-sun-medium"] = "rbxassetid://10734973778",
		["lucide-sun-moon"] = "rbxassetid://10734973999",
		["lucide-sun-snow"] = "rbxassetid://10734974130",
		["lucide-sunrise"] = "rbxassetid://10734974522",
		["lucide-sunset"] = "rbxassetid://10734974689",
		["lucide-superscript"] = "rbxassetid://10734974850",
		["lucide-swiss-franc"] = "rbxassetid://10734975024",
		["lucide-switch-camera"] = "rbxassetid://10734975214",
		["lucide-sword"] = "rbxassetid://10734975486",
		["lucide-swords"] = "rbxassetid://10734975692",
		["lucide-syringe"] = "rbxassetid://10734975932",
		["lucide-table"] = "rbxassetid://10734976230",
		["lucide-table-2"] = "rbxassetid://10734976097",
		["lucide-tablet"] = "rbxassetid://10734976394",
		["lucide-tag"] = "rbxassetid://10734976528",
		["lucide-tags"] = "rbxassetid://10734976739",
		["lucide-target"] = "rbxassetid://10734977012",
		["lucide-tent"] = "rbxassetid://10734981750",
		["lucide-terminal"] = "rbxassetid://10734982144",
		["lucide-terminal-square"] = "rbxassetid://10734981995",
		["lucide-text-cursor"] = "rbxassetid://10734982395",
		["lucide-text-cursor-input"] = "rbxassetid://10734982297",
		["lucide-thermometer"] = "rbxassetid://10734983134",
		["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
		["lucide-thermometer-sun"] = "rbxassetid://10734982771",
		["lucide-thumbs-down"] = "rbxassetid://10734983359",
		["lucide-thumbs-up"] = "rbxassetid://10734983629",
		["lucide-ticket"] = "rbxassetid://10734983868",
		["lucide-timer"] = "rbxassetid://10734984606",
		["lucide-timer-off"] = "rbxassetid://10734984138",
		["lucide-timer-reset"] = "rbxassetid://10734984355",
		["lucide-toggle-left"] = "rbxassetid://10734984834",
		["lucide-toggle-right"] = "rbxassetid://10734985040",
		["lucide-tornado"] = "rbxassetid://10734985247",
		["lucide-toy-brick"] = "rbxassetid://10747361919",
		["lucide-train"] = "rbxassetid://10747362105",
		["lucide-trash"] = "rbxassetid://10747362393",
		["lucide-trash-2"] = "rbxassetid://10747362241",
		["lucide-tree-deciduous"] = "rbxassetid://10747362534",
		["lucide-tree-pine"] = "rbxassetid://10747362748",
		["lucide-trees"] = "rbxassetid://10747363016",
		["lucide-trending-down"] = "rbxassetid://10747363205",
		["lucide-trending-up"] = "rbxassetid://10747363465",
		["lucide-triangle"] = "rbxassetid://10747363621",
		["lucide-trophy"] = "rbxassetid://10747363809",
		["lucide-truck"] = "rbxassetid://10747364031",
		["lucide-tv"] = "rbxassetid://10747364593",
		["lucide-tv-2"] = "rbxassetid://10747364302",
		["lucide-type"] = "rbxassetid://10747364761",
		["lucide-umbrella"] = "rbxassetid://10747364971",
		["lucide-underline"] = "rbxassetid://10747365191",
		["lucide-undo"] = "rbxassetid://10747365484",
		["lucide-undo-2"] = "rbxassetid://10747365359",
		["lucide-unlink"] = "rbxassetid://10747365771",
		["lucide-unlink-2"] = "rbxassetid://10747397871",
		["lucide-unlock"] = "rbxassetid://10747366027",
		["lucide-upload"] = "rbxassetid://10747366434",
		["lucide-upload-cloud"] = "rbxassetid://10747366266",
		["lucide-usb"] = "rbxassetid://10747366606",
		["lucide-user"] = "rbxassetid://10747373176",
		["lucide-user-check"] = "rbxassetid://10747371901",
		["lucide-user-cog"] = "rbxassetid://10747372167",
		["lucide-user-minus"] = "rbxassetid://10747372346",
		["lucide-user-plus"] = "rbxassetid://10747372702",
		["lucide-user-x"] = "rbxassetid://10747372992",
		["lucide-users"] = "rbxassetid://10747373426",
		["lucide-utensils"] = "rbxassetid://10747373821",
		["lucide-utensils-crossed"] = "rbxassetid://10747373629",
		["lucide-venetian-mask"] = "rbxassetid://10747374003",
		["lucide-verified"] = "rbxassetid://10747374131",
		["lucide-vibrate"] = "rbxassetid://10747374489",
		["lucide-vibrate-off"] = "rbxassetid://10747374269",
		["lucide-video"] = "rbxassetid://10747374938",
		["lucide-video-off"] = "rbxassetid://10747374721",
		["lucide-view"] = "rbxassetid://10747375132",
		["lucide-voicemail"] = "rbxassetid://10747375281",
		["lucide-volume"] = "rbxassetid://10747376008",
		["lucide-volume-1"] = "rbxassetid://10747375450",
		["lucide-volume-2"] = "rbxassetid://10747375679",
		["lucide-volume-x"] = "rbxassetid://10747375880",
		["lucide-wallet"] = "rbxassetid://10747376205",
		["lucide-wand"] = "rbxassetid://10747376565",
		["lucide-wand-2"] = "rbxassetid://10747376349",
		["lucide-watch"] = "rbxassetid://10747376722",
		["lucide-waves"] = "rbxassetid://10747376931",
		["lucide-webcam"] = "rbxassetid://10747381992",
		["lucide-wifi"] = "rbxassetid://10747382504",
		["lucide-wifi-off"] = "rbxassetid://10747382268",
		["lucide-wind"] = "rbxassetid://10747382750",
		["lucide-wrap-text"] = "rbxassetid://10747383065",
		["lucide-wrench"] = "rbxassetid://10747383470",
		["lucide-x"] = "rbxassetid://10747384394",
		["lucide-x-circle"] = "rbxassetid://10747383819",
		["lucide-x-octagon"] = "rbxassetid://10747384037",
		["lucide-x-square"] = "rbxassetid://10747384217",
		["lucide-zoom-in"] = "rbxassetid://10747384552",
		["lucide-zoom-out"] = "rbxassetid://10747384679",
	},
}

function NovaLib:GetIcon(name)
	if not name then return nil end
	if name:sub(1, 7) == "rbxasset" then
		return name
	end
	if name:sub(1, 7) ~= "lucide-" then
		name = "lucide-" .. name
	end
	return NovaLib.Icons.assets[name]
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


--// File: src/Elements.lua //--
--// Tab Elements -------------------------------------------------------------

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
		TextSize = 14, -- element titles size 14
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

--// Button (Lucide icon support)
function Tab:CreateButton(bOptions)
	bOptions = bOptions or {}
	local page = self.Page
	local callback = bOptions.Callback or function() end

	local frame = ElementBase(page, NovaLib.Sizes.Small)

	-- If icon is specified, we place it next to the button text
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

	-- selected value in a pill badge for clean alignment
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

--// Color Picker (RGB sliders, asset-free)
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
