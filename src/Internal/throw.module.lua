-- Madonox
return function(method,dat)
	if method == "error" then
		warn("Roblox Package Manager | [ERROR]: "..dat)
	elseif method == "warn" then
		warn("Roblox Package Manager | [WARNING]: "..dat)
	elseif method == "print" then
		print("Roblox Package Manager | [LOG]: "..dat)
	end
end
