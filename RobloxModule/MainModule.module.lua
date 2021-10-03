-- Madonox
-- ID: 7642306654

-- RPM automatic updating files, normally used to push critical updates.

local RPMAutoContent = {}

function RPMAutoContent:Get(filename)
	if script.PackagedFiles:FindFirstChild(filename) then
		return script.PackagedFiles[filename]
	end
end

return RPMAutoContent
