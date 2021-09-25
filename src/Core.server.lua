-- Madonox

local Util = require(script.Parent.Util)
-- Gui setup --
local toolbar = plugin:CreateToolbar("RPM")
local btn = toolbar:CreateButton("Roblox Package Manager","Roblox Package Manager","rbxassetid://7559345607")
Util:FetchGuiLibrary():init()
local guiLib = Util:FetchGuiLibrary()
_G.RPMWidgetSystemStorage = nil
if guiLib:get("widgetLoaded") == nil then
	guiLib:define("widgetLoaded",true)
	require(script.Parent.Internal.throw)("print","RPM loading in progress...")
	delay(2,function()
		local widget = DockWidgetPluginGuiInfo.new(
			Enum.InitialDockState.Float,
			true,
			false,
			200,
			200,
			100,
			100
		)
		local widgetI = plugin:CreateDockWidgetPluginGui("RPM",widget)
		widgetI.Enabled = false
		widgetI.Title = "[RPM] Roblox Package Manager"
		local gui = guiLib:fetchGui()
		for i,v in pairs(gui:GetChildren()) do
			v.Parent = widgetI
		end
		_G.RPMWidgetSystemStorage = widgetI
		guiLib:define("widgetInstance",widgetI)
	end)
end
delay(3,function()
	local widget = Util:FetchGuiLibrary():get("widgetInstance")
	btn.ClickableWhenViewportHidden = true
	btn.Click:Connect(function()
		widget.Enabled = not widget.Enabled
	end)
end)
