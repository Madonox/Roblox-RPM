-- Madonox
local http = require(script.Parent.Parent.Internal.http)
return function()
	local responses = http:Get("/packageList")
	return responses
end
