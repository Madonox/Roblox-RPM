-- Madonox

local http = {}
local hService = game:GetService("HttpService")
local base = "https://RPMServiceProvider.madonox.repl.co"
function http:Post(subURL,json)
	return hService:PostAsync(base..subURL,json,Enum.HttpContentType.ApplicationJson)
end
function http:Get(subURL)
	return hService:GetAsync(base..subURL)
end
return http
