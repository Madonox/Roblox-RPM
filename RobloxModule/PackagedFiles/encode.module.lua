-- Madonox

return function(inst)
	if inst:FindFirstChild("package.rpm") then
		local pack = require(inst["package.rpm"])
		if pack then
			local baseScript = "if not game.ServerScriptService:FindFirstChild('RPMPackages') then Instance.new('Folder',game.ServerScriptService).Name='RPMPackages'; end; Instance.new('Folder',game.ServerScriptService.RPMPackages).Name='"..pack.packageName.."'; Instance.new('Folder',game.ServerScriptService.RPMPackages."..pack.packageName..").Name='Modules';"
			for i,v in ipairs(inst:GetChildren()) do
				if v:IsA("Script") then
					local compressedScript = "local "..tostring("_script"..i).." = Instance.new('Script');"
					local scriptBlankSource = v.Source
					scriptBlankSource = string.gsub(scriptBlankSource,"--","")
					compressedScript = compressedScript..tostring("_script"..i)..".Name='"..v.Name.."';"
					compressedScript = compressedScript..tostring("_script"..i)..".Source=[["..string.gsub(scriptBlankSource,'"',"'").."]];"
					compressedScript = compressedScript..tostring("_script"..i)..".Parent=game.ServerScriptService.RPMPackages."..pack.packageName..";"
					baseScript = baseScript.." "..compressedScript
				elseif v:IsA("ModuleScript") then
					local compressedScript = "local "..tostring("_Modulescript"..i).." = Instance.new('ModuleScript');"
					local scriptBlankSource = v.Source
					scriptBlankSource = string.gsub(scriptBlankSource,"--","")
					compressedScript = compressedScript..tostring("_Modulescript"..i)..".Name='"..v.Name.."';"
					compressedScript = compressedScript..tostring("_Modulescript"..i)..".Source=[["..string.gsub(scriptBlankSource,'"',"'").."]];"
					compressedScript = compressedScript..tostring("_Modulescript"..i)..".Parent=game.ServerScriptService.RPMPackages."..pack.packageName..";"
					baseScript = baseScript.." "..compressedScript
				elseif v.Name == "Modules" then
					for i2,v2 in ipairs(v:GetChildren()) do
						if v2:IsA("ModuleScript") then
							local compressedScript = "local "..tostring("_ModulescriptE"..i).." = Instance.new('ModuleScript');"
							local scriptBlankSource = v.Source
							scriptBlankSource = string.gsub(scriptBlankSource,"--","")
							compressedScript = compressedScript..tostring("_ModulescriptE"..i)..".Name='"..v.Name.."';"
							compressedScript = compressedScript..tostring("_ModulescriptE"..i)..".Source=[["..string.gsub(scriptBlankSource,'"',"'").."]];"
							compressedScript = compressedScript..tostring("_ModulescriptE"..i)..".Parent=game.ServerScriptService.RPMPackages."..pack.packageName..".Modules;"
							baseScript = baseScript.." "..compressedScript
						end
					end
				end
			end
			return {
				["source"] = baseScript;
			}
		end
	end
end
