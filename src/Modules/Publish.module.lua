-- Madonox
local http = require(script.Parent.Parent.Internal.http)
return function(packName,data)
	task.spawn(function()
		local encodedDat = game:GetService("HttpService"):JSONEncode(data)
		local res = http:Post("/packageFetch/"..packName,encodedDat)
		print("Roblox Package Manager | [HTTP]: Package publish response data: "..res)
	end)
end
