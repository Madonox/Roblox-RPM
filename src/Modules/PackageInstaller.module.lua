-- Madonox
local http = require(script.Parent.Parent.Internal.http)
local Loadstring = require(script.Parent.Parent.Dependencies.Loadstring)
return function(packName)
	local packScript = http:Get("/packages/"..packName)
	if packScript then
		Loadstring(packScript)()
	end
end
