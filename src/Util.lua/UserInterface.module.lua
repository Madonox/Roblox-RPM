-- Madonox
local UserInterface = {}
UserInterface.variables = {}
local tweService = game:GetService("TweenService")
local httpService = game:GetService("HttpService")
local plugin = plugin
local widgetGlobally = nil
function UserInterface:define(name,value)
	if not self.variables[name] then
		self.variables[name] = value
	end
end
function UserInterface:update(name,value)
	if self.variables[name] then
		self.variables[name] = value
	end
end
function UserInterface:get(name)
	return self.variables[name]
end
function UserInterface:fetchGui()
	return self:get("guiInstance")
end
function UserInterface:buildWidget()
	if self:get("widgetLoaded") == nil then
		self:define("widgetLoaded",true)
		local widget = DockWidgetPluginGuiInfo.new(
			Enum.InitialDockState.Float,
			true,
			false,
			100,
			200,
			50,
			100
		)
		local widgetI = plugin:CreateDockWidgetPluginGui("RPM",widget)
		widgetI.Title = "[RPM] Roblox Package Manager"
		local gui = self:fetchGui()
		for i,v in pairs(gui:GetChildren()) do
			if v.Name == "Core" then
				self:define("WidgetGuiCore",v)
			end
			v.Parent = widgetI
		end
		widgetGlobally = widgetI
		self:define("widgetInstance",widgetI)
	end
end
function UserInterface:setupButton(btnInstance,func)
	local twe1 = tweService:Create(btnInstance,TweenInfo.new(0.1),{Size=UDim2.new(btnInstance.Size.X.Scale/1.25,0,btnInstance.Size.Y.Scale/1.25,0)})
	local twe2 = tweService:Create(btnInstance,TweenInfo.new(0.1),{Size=btnInstance.Size})
	if btnInstance:IsA("GuiButton") then
		btnInstance.MouseButton1Down:Connect(function()
			twe1:Play()
		end)
		btnInstance.MouseLeave:Connect(function()
			twe2:Play()
		end)
		btnInstance.MouseButton1Up:Connect(function()
			func()
			twe2:Play()
		end)
	end
end
function UserInterface:showFrame(frameName,guiInstance)
	for i,v in pairs(guiInstance.Core.Frames:GetChildren()) do
		if v:IsA("Frame") then
			if v.Name == frameName then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end
end
function UserInterface:init()
	if self:get("loaded") == nil then
		self:define("loaded",true)
		self:define("guiInstance",script:WaitForChild("RPMUI"))
		
		local gui = self:fetchGui()
		local widgetI = UserInterface:get("widgetInstance")
		local widgetGuiCore = self:get("WidgetGuiCore")
		delay(1,function()
			local Util = require(script.Parent)
			local packageList = Util:RequestModule("PackageList")
			delay(4,function()
				local nonJso = require(script.Parent.Parent.Modules.PackageList)()
				local packArray = httpService:JSONDecode(nonJso)
				for i,v in ipairs(packArray) do
					local clo = _G.RPMWidgetSystemStorage.Core.Frames.PackageList.ScrollingFrame.Template:Clone()
					clo.Parent = _G.RPMWidgetSystemStorage.Core.Frames.PackageList.ScrollingFrame
					clo.Text = v
					clo.Name = v
				end
				
				local PackageInstall = Util:RequestModule("PackageInstaller")
				local PackagePublish = Util:RequestModule("Publish")
				self:setupButton(_G.RPMWidgetSystemStorage.Core.Frames.PackageInstall.TextButton,function()
					require(script.Parent.Parent.Modules.PackageInstaller)(_G.RPMWidgetSystemStorage.Core.Frames.PackageInstall.TextBox.Text)
					--PackageInstall()
				end)
				local Selection = game:GetService("Selection")
				self:setupButton(_G.RPMWidgetSystemStorage.Core.Frames.PackagePublish.TextButton,function()
					local packageFile = nil
					for i,v in ipairs(Selection:Get()) do
						if v:FindFirstChild("package.rpm") then
							packageFile = v
							break
						end
					end
					if packageFile then
						local data = require(script.Parent.Parent.Internal.encode)(packageFile)
						if data then
							require(script.Parent.Parent.Modules.Publish)(require(packageFile["package.rpm"]).packageName,data)
							require(script.Parent.Parent.Internal.throw)("print","Package published!  Name: "..require(packageFile["package.rpm"]).packageName)
						end
					end
				end)
				require(script.Parent.Parent.Internal.throw)("print","RPM loading complete!")
			end)
		end)
		self:setupButton(gui.Core.BtnFrame.Browse,function()
			UserInterface:showFrame("PackageList",_G.RPMWidgetSystemStorage)
			local nonJso = require(script.Parent.Parent.Modules.PackageList)()
			local packArray = httpService:JSONDecode(nonJso)
			for i,v in pairs(_G.RPMWidgetSystemStorage.Core.Frames.PackageList.ScrollingFrame:GetChildren()) do
				if v:IsA("TextLabel") then
					if v.Name ~= "Template" then
						v:Destroy()
					end
				end
			end
			for i,v in ipairs(packArray) do
				local clo = _G.RPMWidgetSystemStorage.Core.Frames.PackageList.ScrollingFrame.Template:Clone()
				clo.Parent = _G.RPMWidgetSystemStorage.Core.Frames.PackageList.ScrollingFrame
				clo.Text = v
				clo.Name = v
			end
		end)
		self:setupButton(gui.Core.BtnFrame.Install,function()
			UserInterface:showFrame("PackageInstall",_G.RPMWidgetSystemStorage)
		end)
		self:setupButton(gui.Core.BtnFrame.Publish,function()
			UserInterface:showFrame("PackagePublish",_G.RPMWidgetSystemStorage)
		end)
	end
end
return UserInterface
