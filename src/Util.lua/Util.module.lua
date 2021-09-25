-- Madonox

local Util = {}
Util.loadedModules = {}
local loaded = false
local guiLib = nil
if loaded == false then
	loaded = true
	guiLib = require(script.UserInterface)
	if require(script.CheckHTTP)() == true then
		for i,v in pairs(script.Parent.Modules:GetChildren()) do
			if v:IsA("ModuleScript") then
				table.insert(Util.loadedModules,#Util.loadedModules+1,require(v))
			end
		end
	else
		require(script.Parent.Internal.throw)("error","HTTP service is not enabled!  Please enable it for this plugin to work!")
	end
end
function Util:RequestModule(moduleName)
	if #Util.loadedModules ~= 0 then
		return Util.loadedModules[moduleName]
	else
		return "noModule"
	end
end
function Util:FetchGuiLibrary()
	return guiLib
end
return Util
