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
