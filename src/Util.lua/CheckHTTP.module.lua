-- Madonox
local http = game:GetService("HttpService")
local result = true
local e,err = pcall(function()
	http:GetAsync("https://RPMServiceProvider.madonox.repl.co")
end)
result = e
return function()
	return result
end
