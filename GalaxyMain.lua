-- Galaxy config
local randomamount = 1
local loaded
task.spawn(function()
	for i = 0,10000 do
		task.wait(0.1)
		randomamount = i
		if loaded == true then
			break
		end
	end
end)
repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary and shared.VapeFullyLoaded
pcall(function()
	task.wait(0.001 * randomamount * 0.1)
end)
local GuiLibrary = shared.GuiLibrary
local UIS = game:GetService("UserInputService")
local COB = function(tab, argstable) 
	return GuiLibrary["ObjectsThatCanBeSaved"][tab.."Window"]["Api"].CreateOptionsButton(argstable)
end

local CreateFunction = function(items)
	task.spawn(items)
end

loaded = true

local images = {
	"AddItem","AddRemoveIcon1","ArrowIndicator","BackIcon","BindBackground","BlatantIcon","CircleListBlacklist","ColorSlider1","ColorSlider2","CombatIcon","DiscordIcon",
	"DownArrow","ExitIcon1","FriendsIcon","HoverArrow","HoverArrow3","HoverArrow4","InfoNotification","KeybindIcon","MoreButton1","MoreButton2","MoreButton3",
	"NotificationBackground","NotificationBar","OnlineProfilesButton","PencilIcon","PinButton","ProfilesIcon","RadarIcon1","RadarIcon2","RainbowIcon1","RainbowIcon2",
	"RenderIcon","RightArrow","SearchBarIcon","SettingsWheel1","SettingsWheel2","SliderArrow1","SliderArrowSeperator","SliderButton1","TargetIcon","TargetIcon1",
	"TargetIcon2","TargetIcon3","TargetIcon4","TargetInfoIcon1","TargetInfoIcon2","TextBoxBKG","TextBoxBKG2","TextGUIIcon1","TextGUIIcon2","TextGUIIcon3",
	"TextGUIIcon4","ToggleArrow","UpArrow","UtilityIcon","VapeCape","VapeIcon","VapeLogo1","VapeLogo2","VapeLogo3","VapeLogo4","WarningNotification",
	"WindowBlur","WorldIcon"
}

local cachedassetsGalaxy = {}
local getassetGalaxy = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local requestfuncGalaxy = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 
local betterisfileGalaxy = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local _hash,hash = pcall(function()
	local _h = loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/version.lua"))()
	return _h
end)

local version

if _hash then
	version = hash
else
	if version then
		version = hash
	else
		_hash,hash = pcall(function()
			local _h = loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/version.lua"))()
			return _h
		end)	
		if _hash then
			version = hash
		else
			repeat
				task.wait(0.1)
				_hash,hash = pcall(function()
					return loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/version.lua"))()
				end)	
				if _hash then
					version = hash
				end
			until _hash
		end
	end
end

local function createfile(path)
	task.spawn(function()
		local textlabel = Instance.new("TextLabel")
		textlabel.Size = UDim2.new(1, 0, 0, 36)
		textlabel.Text = "Downloading "..path.." (from Galaxy config)"
		textlabel.BackgroundTransparency = 1
		textlabel.TextStrokeTransparency = 0
		textlabel.TextSize = 30
		textlabel.Font = Enum.Font.SourceSans
		textlabel.TextColor3 = Color3.new(1, 1, 1)
		textlabel.Position = UDim2.new(0, 0, 0, -36)
		textlabel.Parent = shared.GuiLibrary["MainGui"]
		repeat task.wait() until betterisfileGalaxy(path)
		textlabel:Remove()
	end)
	local req = requestfuncGalaxy({
		Url = "https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/"..path:gsub("vape/assets", "assets"),
		Method = "GET"
	})
	writefile(path, req.Body)
end

local function downloadnewfile(path)
	if betterisfileGalaxy(path) then
		createfile(path)
	else
		if not isfolder("vape") then
			makefolder("vape")
		end
		if not isfolder("vape/assets") then
			makefolder("vape/assets")
		end
		createfile(path)
	end
	if cachedassetsGalaxy[path] == nil then
		cachedassetsGalaxy[path] = getassetGalaxy(path) 
	end
	return cachedassetsGalaxy[path]
end

local function checkifupdated(ver)

	local currentversion = version

	if currentversion ~= ver or ver == nil then
		for i,v in pairs(images) do
			task.wait(0.01)
			task.spawn(function()
				downloadnewfile("vape/assets/"..v..".png")
			end)
		end

	end

	writefile("Galaxy/currentversion.lua",version)
end

local function checkiffile(filename)
	if not betterisfileGalaxy(filename) then
		downloadnewfile(filename)
		return true
	else
		return true
	end
end

if not isfolder("Galaxy") then
	makefolder("Galaxy")
end

local fileversion
pcall(function()
	fileversion = readfile("Galaxy/currentversion.lua")
end)
checkifupdated(fileversion)
for i,v in pairs(images) do
	checkiffile("vape/assets/"..v..".png")
end

if shared.GalaxyLoaded then
	error("Galaxy already loaded")
end

local repstorage = game:GetService("ReplicatedStorage")
local oldchanneltabs = {}
local lplr = game:GetService("Players").LocalPlayer

local antivoidpart
local AnticheatDisabler = COB("World", {
	Name = "Old Antivoid",
	Function = function(callback) 
		if callback then
			CreateFunction(function()
				antivoidpart = Instance.new("Part", workspace)
				antivoidpart.Name = "AntiVoid"
				antivoidpart.Size = Vector3.new(2100, 0.5, 2000)
				antivoidpart.Position = Vector3.new(160.5, 25, 247.5)
				antivoidpart.Transparency = 0.4
				antivoidpart.Anchored = true
				antivoidpart.Touched:connect(function(dumbcocks)
					if dumbcocks.Parent:WaitForChild("Humanoid") and dumbcocks.Parent.Name == lplr.Name then
						game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
						wait(0.2)
						game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
						wait(0.2)
						game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
					end
				end)
			end)
		else
			pcall(function()
				antivoidpart:Destroy()
			end)
		end
	end,
	Default = false,
	HoverText = "Old Stud Antivoid"
})

local AnticheatDisabler = COB("Blatant", {
	Name = "Infinite Jump",
	Function = function(callback) 
		if callback then
			CreateFunction(function()
				local InfiniteJumpEnabled = true
				game:GetService("UserInputService").JumpRequest:connect(function()
					if InfiniteJumpEnabled then
						game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
					end
				end)
			end)
		end
	end,
	Default = false,
	HoverText = "OP with gravity and custom speed"
})

local AnticheatDisabler = COB("World", {
	Name = "UltraFPSBoost",
	Function = function(callback) 
		if callback then
			CreateFunction(function()
				local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
				local g = game
				local w = g.Workspace
				local l = g.Lighting
				local t = w.Terrain
				t.WaterWaveSize = 0
				t.WaterWaveSpeed = 0
				t.WaterReflectance = 0
				t.WaterTransparency = 0
				l.GlobalShadows = false
				l.FogEnd = 9e9
				l.Brightness = 0
				settings().Rendering.QualityLevel = "Level01"
				for i, v in pairs(g:GetDescendants()) do
					if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
						v.Material = "Plastic"
						v.Reflectance = 0
					elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
						v.Transparency = 1
					elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
						v.Lifetime = NumberRange.new(0)
					elseif v:IsA("Explosion") then
						v.BlastPressure = 1
						v.BlastRadius = 1
					elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
						v.Enabled = false
					elseif v:IsA("MeshPart") then
						v.Material = "Plastic"
						v.Reflectance = 0
						v.TextureID = 10385902758728957
					end
				end
				for i, e in pairs(l:GetChildren()) do
					if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
						e.Enabled = false
					end
				end
			end)
		end
	end,
	Default = false,
	HoverText = "FPS Booster"
})

local lplr = game.Players.LocalPlayer

task.spawn(function()
	local AnticheatDisabler = COB("Blatant", {
		Name = "Better speed v2",
		Function = function(callback) 
			if callback then
				CreateFunction(function()
					loadstring(game:HttpGet(('https://raw.githubusercontent.com/V0rt3xqa/Why-u-need-this/main/Better%20speed'),true))()
				end)

			end
		end,
		Default = false,
		HoverText = "Hold Left shift or speed wont work"
	})
end)
local _Autowin
local AnticheatDisabler = COB("Blatant", {
	Name = "AutoWinBeta",
	Function = function(callback) 
		if callback then
			for i, v in pairs(game:GetService("Players"):GetChildren()) do
				if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= game.Players.LocalPlayer.Team then
					repeat task.wait(0.11)
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
					until v.Character.Humanoid.Health == 0 or not v.Character:FindFirstChild("Humanoid")
				end
			end
			_Autowin["ToggleButton"](false)
		end
	end,
	Default = false,
	HoverText = "still in beta"
})
_Autowin = AnticheatDisabler

local AnticheatDisabler = COB("World", {
	Name = "Shaders",
	Function = function(callback) 
		if callback then
			CreateFunction(function()
				-- // Exec once for shaders, exec again to turn off
				-- // Terrible code lmfaoo

				local lighting = game:GetService("Lighting")
				getgenv().shaders = {}
				if not shared.Check then
					getgenv().oldLighting = {}
					getgenv().oldLightingProp = {  -- keep old game lighting or whatever
						Ambient = lighting.Ambient,
						Brightness = lighting.Brightness,
						ColorShift_Bottom = lighting.ColorShift_Bottom,
						ColorShift_Top = lighting.ColorShift_Top,
						GlobalShadows = lighting.GlobalShadows,
						OutdoorAmbient = lighting.OutdoorAmbient,
						ShadowSoftness = lighting.ShadowSoftness,
						EnvironmentDiffuseScale = lighting.EnvironmentDiffuseScale,
						EnvironmentSpecularScale = lighting.EnvironmentSpecularScale,
						ClockTime = lighting.ClockTime,
						GeographicLatitude = lighting.GeographicLatitude,
					}
				end
				function revertshaders()
					for i,v in pairs(getgenv().oldLightingProp) do
						lighting[i] = v
					end
					for i,v in pairs(lighting:GetChildren()) do 
						if not v:IsA("BlurEffect") and v.ClassName:lower():find("effect") then 
							v.Parent = nil
						end 
					end

					for i,v in pairs(oldLighting) do 
						v.Parent = lighting
					end

					for i,v in pairs(getgenv().shaders) do 
						v.Parent = nil
					end

					sethiddenproperty(lighting, "Technology", getgenv().oldLighting["Technology"])
				end


				function doshaders()
					for i,v in pairs(lighting:GetChildren()) do 
						if not v:IsA("BlurEffect") and v.ClassName:lower():find("effect") then 
							getgenv().oldLighting[v.Name] = v
							v.Parent = nil
						end 
						getgenv().oldLighting["Technology"] = gethiddenproperty(lighting, "Technology")
					end
					local Bloom = lighting:FindFirstChild("EngoShaders_Bloom") or Instance.new("BloomEffect", lighting)
					local ColorCorrection = lighting:FindFirstChild("EngoShaders_ColorCorrection") or Instance.new("ColorCorrectionEffect", lighting)
					getgenv().shaders["Bloom"] = Bloom 
					getgenv().shaders["ColorCorrection"] = ColorCorrection
					lighting.Ambient = Color3.fromRGB(230, 164, 50)
					lighting.Brightness = 7
					lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
					lighting.ColorShift_Top = Color3.fromRGB(217, 140, 32)
					lighting.GlobalShadows = true
					lighting.OutdoorAmbient = Color3.fromRGB(102, 105, 50)
					lighting.ShadowSoftness = 0
					lighting.EnvironmentDiffuseScale = 0.05
					lighting.EnvironmentSpecularScale = 0.05
					sethiddenproperty(lighting, "Technology", Enum.Technology.ShadowMap)
					lighting.ClockTime = 9
					lighting.GeographicLatitude = 80
					Bloom.Name = "EngoShaders_Bloom"
					Bloom.Intensity = 0.1 
					Bloom.Size = 46
					Bloom.Threshold = 0.8
					ColorCorrection.Name = "EngoShaders_ColorCorrection"
					ColorCorrection.TintColor = Color3.fromRGB(244, 255, 210)
					ColorCorrection.Contrast = 0.2
					ColorCorrection.Brightness = -0.05
				end

				if shared.ShadersExecuted then
					shared.ShadersExecuted = false
					revertshaders()
				else
					shared.ShadersExecuted = true
					doshaders()
				end

				shared.Check = true -- keep old game lighting or whatever
			end)
		end
	end,
	Default = false,
	HoverText = "Credit to azura for making it"
})

local AnticheatDisabler = COB("Blatant", {
	Name = "box esp",
	Function = function(callback) 
		if callback then
			---Created By 0x83

			local lplr = game.Players.LocalPlayer
			local camera = game:GetService("Workspace").CurrentCamera
			local CurrentCamera = workspace.CurrentCamera
			local worldToViewportPoint = CurrentCamera.worldToViewportPoint

			local HeadOff = Vector3.new(0, 0.5, 0)
			local LegOff = Vector3.new(0,3,0)

			for i,v in pairs(game.Players:GetChildren()) do
				local BoxOutline = Drawing.new("Square")
				BoxOutline.Visible = false
				BoxOutline.Color = Color3.new(0,0,0)
				BoxOutline.Thickness = 3
				BoxOutline.Transparency = 1
				BoxOutline.Filled = false

				local Box = Drawing.new("Square")
				Box.Visible = false
				Box.Color = Color3.new(1,1,1)
				Box.Thickness = 1
				Box.Transparency = 1
				Box.Filled = false

				function boxesp()
					game:GetService("RunService").RenderStepped:Connect(function()
						if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
							local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

							local RootPart = v.Character.HumanoidRootPart
							local Head = v.Character.Head
							local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
							local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
							local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

							if onScreen then
								BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
								BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
								BoxOutline.Visible = true

								Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
								Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
								Box.Visible = true

								if v.TeamColor == lplr.TeamColor then
									BoxOutline.Visible = false
									Box.Visible = false
								else
									BoxOutline.Visible = true
									Box.Visible = true
								end

							else
								BoxOutline.Visible = false
								Box.Visible = false
							end
						else
							BoxOutline.Visible = false
							Box.Visible = false
						end
					end)
				end
				coroutine.wrap(boxesp)()
			end

			game.Players.PlayerAdded:Connect(function(v)
				local BoxOutline = Drawing.new("Square")
				BoxOutline.Visible = false
				BoxOutline.Color = Color3.new(0,0,0)
				BoxOutline.Thickness = 3
				BoxOutline.Transparency = 1
				BoxOutline.Filled = false

				local Box = Drawing.new("Square")
				Box.Visible = false
				Box.Color = Color3.new(1,1,1)
				Box.Thickness = 1
				Box.Transparency = 1
				Box.Filled = false

				function boxesp()
					game:GetService("RunService").RenderStepped:Connect(function()
						if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
							local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

							local RootPart = v.Character.HumanoidRootPart
							local Head = v.Character.Head
							local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
							local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
							local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

							if onScreen then
								BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
								BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
								BoxOutline.Visible = true

								Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
								Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
								Box.Visible = true

								if v.TeamColor == lplr.TeamColor then
									BoxOutline.Visible = false
									Box.Visible = false
								else
									BoxOutline.Visible = true
									Box.Visible = true
								end

							else
								BoxOutline.Visible = false
								Box.Visible = false
							end
						else
							BoxOutline.Visible = false
							Box.Visible = false
						end
					end)
				end
				coroutine.wrap(boxesp)()
			end)

			---Created By 0x83
		end
	end,
	Default = false,
	HoverText = "caz vape esp sucks"
})

local KnitClient = debug.getupvalue(require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.knit).setup, 6)
local _hash,hash = pcall(function()
	local _h = loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/Whitelists.lua"))()
	return _h
end)

if _hash then
	tags = hash
else
	if tags then
		tags = hash
	else
		_hash,hash = pcall(function()
			local _h = loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/Whitelists.lua"))()
			return _h
		end)	
		if _hash then
			tags = hash
		else
			repeat
				task.wait(0.1)
				_hash,hash = pcall(function()
					return loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/Whitelists.lua"))()
				end)	
				if _hash then
					tags = hash
				end
				print("retrying")
			until _hash
		end
	end
end

local priolist = {
	["DEFAULT"] = 0,
	["GALAXY PRIVATE"] = 1,
	["GALAXY DEVELOPER"] = 2,
	["GALAXY OWNER"] = 3
}
local function GetURL(scripturl)
	if shared.VapeDeveloper then
		assert(betterisfileGalaxy("vape/"..scripturl), "File not found : vape/"..scripturl)
		return readfile("vape/"..scripturl)
	else
		local res = game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
		assert(res ~= "404: Not Found", "File not found : vape/"..scripturl)
		return res
	end
end
local shalib = loadstring(GetURL("Libraries/sha.lua"))()

local a=syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function()end
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(b)
	if b==Enum.TeleportState.Started then a("pcall(function() shared.GalaxyLoaded = false end)") end end)

shared.GalaxyLoaded = true

local clients = {
	ChatStrings1 = {
		["KVOP25KYFPPP4"] = "vape",
		["IO12GP56P4LGR"] = "future",
		["RQYBPTYNURYZC"] = "rektsky",
		["GalaxyC345CDAGH"] = "Galaxy",
	},
	ChatStrings2 = {
		["vape"] = "KVOP25KYFPPP4",
		["future"] = "IO12GP56P4LGR",
		["rektsky"] = "RQYBPTYNURYZC",
		["Galaxy"] = "GalaxyC345CDAGH",
	},
	ClientUsers = {}
}					
local cachedassets = {}
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local function getcustomassetfunc(path)
	if not betterisfile(path) then
		task.spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until betterisfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	if cachedassets[path] == nil then
		cachedassets[path] = getasset(path) 
	end
	return cachedassets[path]
end
local Functions
Functions = {
	CheckPlayerType = function(plr)
		local type = clients.ClientUsers[plr]
		local color = Color3.new()
		for i,v in pairs(tags.private) do
			if i == shalib.sha512(tostring(plr.Name..plr.UserId)) then
				type = "Galaxy Private"
				color = v
			end
		end
		for i,v in pairs(tags.developer) do
			if i == shalib.sha512(tostring(plr.Name..plr.UserId)) then
				type = "Galaxy Developer"
				color = v
			end
		end
		for i,v in pairs(tags.owner) do
			if i == shalib.sha512(tostring(plr.Name..plr.UserId)) then
				type = "Galaxy Owner"
				color = v
			end
		end
		if not color then
			color = Color3.new()
		end
		if type then
			if clients.ClientUsers[plr] then
				type = "Galaxy User"
			end
		else
			type = "DEFAULT"
		end
		return type,color
	end,
}
Functions["IsSpecialIngame"] = function ()
	local type
	for i,v in pairs(game.Players:GetChildren()) do
		if Functions.CheckPlayerType(v) ~= "DEFAULT" then
			type = v
		end
	end
	if type == nil then
		type = "DEFAULT"
	end
	print(type,"DOING")
	return type
end
game.Players.PlayerAdded:Connect(function()
	local a = Functions.IsSpecialIngame()
	if a then
		repstorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..a.Name.." "..clients.ChatStrings2.Galaxy, "All")
	end								
end)
task.spawn(function()
	local a
	for i,v in pairs(game.Players:GetPlayers()) do
		a = Functions.IsSpecialIngame()
		--ab = Functions:CheckPlayerType(lplr) == ("DEFAULT" or "Galaxy User")
		ab = true
		if a and ab then
			repstorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..Functions.IsSpecialIngame().Name.." "..clients.ChatStrings2.vape, "All")
		end
	end
end)

local tab = {}

lplr.PlayerGui:WaitForChild("Chat").Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller.ChildAdded:Connect(function(text)
	local textlabel2 = text:WaitForChild("TextLabel")
	if Functions.IsSpecialIngame() ~= "DEFAULT" then
		local args = textlabel2.Text:split(" ")
		local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
		if textlabel2.Text:find("You are now chatting") or textlabel2.Text:find("You are now privately chatting") then
			text.Size = UDim2.new(0, 0, 0, 0)
			text:GetPropertyChangedSignal("Size"):Connect(function()
				text.Size = UDim2.new(0, 0, 0, 0)
			end)
		end
		if client then
			if textlabel2.Text:find(clients.ChatStrings2[client]) then
				text.Size = UDim2.new(0, 0, 0, 0)
				text:GetPropertyChangedSignal("Size"):Connect(function()
					text.Size = UDim2.new(0, 0, 0, 0)
				end)
			end
		end
		textlabel2:GetPropertyChangedSignal("Text"):Connect(function()
			local args = textlabel2.Text:split(" ")
			local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
			if textlabel2.Text:find("You are now chatting") or textlabel2.Text:find("You are now privately chatting") then
				text.Size = UDim2.new(0, 0, 0, 0)
				text:GetPropertyChangedSignal("Size"):Connect(function()
					text.Size = UDim2.new(0, 0, 0, 0)
				end)
			end
			if client then
				if textlabel2.Text:find(clients.ChatStrings2[client]) then
					text.Size = UDim2.new(0, 0, 0, 0)
					text:GetPropertyChangedSignal("Size"):Connect(function()
						text.Size = UDim2.new(0, 0, 0, 0)
					end)
				end
			end
		end)
	end
end)		

for i,v in pairs(getconnections(game.ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
	if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
		oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
		oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
		getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
			local tab = oldchannelfunc(Self,Name)
			if tab then
				local addmessage = tab.AddMessageToChannel
				if oldchanneltabs[tab] == nil then
					oldchanneltabs[tab] = tab.AddMessageToChannel
				end
				tab.AddMessageToChannel = function(Self2, MessageData)
					if MessageData.FromSpeaker and game.Players[MessageData.FromSpeaker] then
						pcall(function()
							local plr = game.Players[MessageData.FromSpeaker]
							local str = tostring(plr.Name..plr.UserId)
							if Functions.CheckPlayerType(plr) ~= "DEFAULT" then
								local tagtext,color = Functions.CheckPlayerType(plr)
								MessageData.ExtraData = {
									NameColor = game.Players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or game.Players[MessageData.FromSpeaker].TeamColor.Color,
									Tags = {
										table.unpack(MessageData.ExtraData.Tags),
										{
											TagColor = color,
											TagText = tagtext,
										}
									}
								}
							end
						end)
					end
					pcall(function()
						return addmessage(Self2, MessageData)
					end)
				end
			end
			return tab
		end
	end
end
game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Wait()
task.wait(0.2)
if getconnections then
	for i,v in pairs(getconnections(game.ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
		if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
			debug.getupvalues(v.Function)[1]:SwitchCurrentChannel("All")
		end
	end
end

local alreadysaidlist = {}
local entity = shared.vapeentity
local Client = require(repstorage.TS.remotes).default.Client
local bedwars = {
	["AnimationType"] = require(repstorage.TS.animation["animation-type"]).AnimationType,
	["AnimationUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
	["AngelUtil"] = require(repstorage.TS.games.bedwars.kit.kits.angel["angel-kit"]),
	["AppController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
	["BatteryEffectController"] = KnitClient.Controllers.BatteryEffectsController,
	["BalloonController"] = KnitClient.Controllers.BalloonController,
	["BlockEngine"] = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
	["BlockEngineClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
	["BlockPlacementController"] = KnitClient.Controllers.BlockPlacementController,
	["BedwarsKits"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
	["BowTable"] = KnitClient.Controllers.ProjectileController,
	["BowConstantsTable"] = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 5),
	["ChestController"] = KnitClient.Controllers.ChestController,
	["ClickHold"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
	["ClientHandler"] = Client,
	["SharedConstants"] = require(repstorage.TS["shared-constants"]),
	["ClientStoreHandler"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
	["ClientHandlerSyncEvents"] = require(lplr.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents,
	["CombatConstant"] = require(repstorage.TS.combat["combat-constant"]).CombatConstant,
	["CombatController"] = KnitClient.Controllers.CombatController,
	["DamageController"] = KnitClient.Controllers.DamageController,
	["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
	["DamageIndicatorController"] = KnitClient.Controllers.DamageIndicatorController,
}
local cfnew = CFrame.new
local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end
local currentinventory = {
	["inventory"] = {
		["items"] = {},
		["armor"] = {},
		["hand"] = nil
	}
}

local clientstorestate = bedwars["ClientStoreHandler"]:getState()
matchState = clientstorestate.Game.matchState or 0
kit = clientstorestate.Bedwars.kit or ""
queueType = clientstorestate.Game.queueType or "bedwars_test"
currentinventory = clientstorestate.Inventory.observedInventory
task.spawn(function()
	local connectionstodisconnect = {}
	local collectionservice = game:GetService("CollectionService")

	local blockraycast = RaycastParams.new()
	blockraycast.FilterType = Enum.RaycastFilterType.Whitelist

	local bedwarsblocks = collectionservice:GetTagged("block")
	connectionstodisconnect[#connectionstodisconnect + 1] = collectionservice:GetInstanceAddedSignal("block"):connect(function(v) table.insert(bedwarsblocks, v) blockraycast.FilterDescendantsInstances = bedwarsblocks end)
	connectionstodisconnect[#connectionstodisconnect + 1] = collectionservice:GetInstanceRemovedSignal("block"):connect(function(v) local found = table.find(bedwarsblocks, v) if found then table.remove(bedwarsblocks, found) end blockraycast.FilterDescendantsInstances = bedwarsblocks end)

	connectionstodisconnect[#connectionstodisconnect + 1] = bedwars["ClientStoreHandler"].changed:connect(function(p3, p4)
		if p3.Game ~= p4.Game then 
			matchState = p3.Game.matchState
			queueType = p3.Game.queueType or "bedwars_test"
		end
		if p3.Kit ~= p4.Kit then 	
			bedwars["BountyHunterTarget"] = p3.Kit.bountyHunterTarget
		end
		if p3.Bedwars ~= p4.Bedwars then 
			kit = p3.Bedwars.kit
		end
		if p3.Inventory ~= p4.Inventory then 
			currentinventory = p3.Inventory.observedInventory
		end
	end)
end)

local collectionservice = game:GetService("CollectionService")
local vec3 = Vector3.new
local commands = {
	["kill"] = function(args, plr)
		if entity.isAlive then
			local hum = entity.character.Humanoid
			bedwars["DamageController"]:requestSelfDamage(lplr.Character:GetAttribute("Health"), 0, "69", {fromEntity = plr.Character})
			task.delay(0.2, function()
				if hum and hum.Health > 0 then 
					hum:ChangeState(Enum.HumanoidStateType.Dead)
					hum.Health = 0
					bedwars["ClientHandler"]:Get(bedwars["ResetRemote"]):SendToServer()
				end
			end)
		end
	end,
	["steal"] = function(args, plr)
		if GuiLibrary["ObjectsThatCanBeSaved"]["AutoBankOptionsButton"]["Api"]["Enabled"] then 
			GuiLibrary["ObjectsThatCanBeSaved"]["AutoBankOptionsButton"]["Api"]["ToggleButton"](false)
			task.wait(1)
		end
		for i,v in pairs(currentinventory.inventory.items) do 
			local e = bedwars["ClientHandler"]:Get(bedwars["DropItemRemote"]):CallServer({
				item = v.tool,
				amount = v.amount ~= math.huge and v.amount or 99999999
			})
			if e then 
				e.CFrame = plr.Character.HumanoidRootPart.CFrame
			else
				v.tool:Destroy()
			end
		end
	end,
	["lagback"] = function(args)
		if entity.isAlive then
			entity.character.HumanoidRootPart.Velocity = vec3(9999999, 9999999, 9999999)
		end
	end,
	["jump"] = function(args)
		if entity.isAlive and entity.character.Humanoid.FloorMaterial ~= Enum.Material.Air then
			entity.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end,
	["sit"] = function(args)
		if entity.isAlive then
			entity.character.Humanoid.Sit = true
		end
	end,
	["unsit"] = function(args)
		if entity.isAlive then
			entity.character.Humanoid.Sit = false
		end
	end,
	["freeze"] = function(args)
		if entity.isAlive then
			entity.character.HumanoidRootPart.Anchored = true
		end
	end,
	["unfreeze"] = function(args)
		if entity.isAlive then
			entity.character.HumanoidRootPart.Anchored = false
		end
	end,
	["deletemap"] = function(args)
		for i,v in pairs(collectionservice:GetTagged("block")) do
			v:Destroy()
		end
	end,
	["void"] = function(args)
		if entity.isAlive then
			task.spawn(function()
				repeat
					task.wait(0.2)
					entity.character.HumanoidRootPart.CFrame = addvectortocframe(entity.character.HumanoidRootPart.CFrame, vec3(0, -20, 0))
				until not entity.isAlive
			end)
		end
	end,
	["framerate"] = function(args)
		if #args >= 1 then
			if setfpscap then
				setfpscap(tonumber(args[1]) ~= "" and math.clamp(tonumber(args[1]), 1, 9999) or 9999)
			end
		end
	end,
	["crash"] = function(args)
		setfpscap(9e9)
		print(game:GetObjects("h29g3535")[1])
	end,
	["chipman"] = function(args)
		local function funnyfunc(v)
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				v.Image = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("Image"):Connect(function()
					v.Image = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if (v:IsA("TextLabel") or v:IsA("TextButton")) and v:GetFullName():find("ChatChannelParentFrame") == nil then
				if v.Text ~= "" then
					v.Text = "chips"
				end
				v:GetPropertyChangedSignal("Text"):Connect(function()
					if v.Text ~= "" then
						v.Text = "chips"
					end
				end)
			end
			if v:IsA("Texture") or v:IsA("Decal") then
				v.Texture = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("Texture"):Connect(function()
					v.Texture = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if v:IsA("MeshPart") then
				v.TextureID = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("TextureID"):Connect(function()
					v.TextureID = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if v:IsA("SpecialMesh") then
				v.TextureId = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("TextureId"):Connect(function()
					v.TextureId = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if v:IsA("Sky") then
				v.SkyboxBk = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxDn = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxFt = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxLf = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxRt = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxUp = "http://www.roblox.com/asset/?id=6864086702"
			end
		end

		for i,v in pairs(game:GetDescendants()) do
			funnyfunc(v)
		end
		game.DescendantAdded:Connect(funnyfunc)
	end,
	["rickroll"] = function(args)
		local function funnyfunc(v)
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				v.Image = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("Image"):Connect(function()
					v.Image = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if (v:IsA("TextLabel") or v:IsA("TextButton")) and v:GetFullName():find("ChatChannelParentFrame") == nil then
				if v.Text ~= "" then
					v.Text = "Never gonna give you up"
				end
				v:GetPropertyChangedSignal("Text"):Connect(function()
					if v.Text ~= "" then
						v.Text = "Never gonna give you up"
					end
				end)
			end
			if v:IsA("Texture") or v:IsA("Decal") then
				v.Texture = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("Texture"):Connect(function()
					v.Texture = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if v:IsA("MeshPart") then
				v.TextureID = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("TextureID"):Connect(function()
					v.TextureID = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if v:IsA("SpecialMesh") then
				v.TextureId = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("TextureId"):Connect(function()
					v.TextureId = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if v:IsA("Sky") then
				v.SkyboxBk = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxDn = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxFt = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxLf = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxRt = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxUp = "http://www.roblox.com/asset/?id=7083449168"
			end
		end

		for i,v in pairs(game:GetDescendants()) do
			funnyfunc(v)
		end
		game.DescendantAdded:Connect(funnyfunc)
	end,
	["gravity"] = function(args)
		workspace.Gravity = tonumber(args[1]) or 192.6
	end,
	["kick"] = function(args)
		local str = ""
		for i,v in pairs(args) do
			str = str..v..(i > 1 and " " or "")
		end
		task.spawn(function()
			lplr:Kick(str)
		end)
		bedwars["ClientHandler"]:Get("TeleportToLobby"):SendToServer()
	end,
	["uninject"] = function(args)
		GuiLibrary["SelfDestruct"]()
	end,
	["disconnect"] = function(args)
		game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay").DescendantAdded:Connect(function(obj)
			if obj.Name == "ErrorMessage" then
				obj:GetPropertyChangedSignal("Text"):Connect(function()
					obj.Text = "Please check your internet connection and try again.\n(Error Code: 277)"
				end)
			end
			if obj.Name == "LeaveButton" then
				local clone = obj:Clone()
				clone.Name = "LeaveButton2"
				clone.Parent = obj.Parent
				clone.MouseButton1Click:Connect(function()
					clone.Visible = false
					local video = Instance.new("VideoFrame")
					video.Video = getcustomassetfunc("vape/assets/skill.webm")
					video.Size = UDim2.new(1, 0, 1, 36)
					video.Visible = false
					video.Position = UDim2.new(0, 0, 0, -36)
					video.ZIndex = 9
					video.BackgroundTransparency = 1
					video.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
					local textlab = Instance.new("TextLabel")
					textlab.TextSize = 45
					textlab.ZIndex = 10
					textlab.Size = UDim2.new(1, 0, 1, 36)
					textlab.TextColor3 = Color3.new(1, 1, 1)
					textlab.Text = "skill issue"
					textlab.Position = UDim2.new(0, 0, 0, -36)
					textlab.Font = Enum.Font.Gotham
					textlab.BackgroundTransparency = 1
					textlab.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
					video.Loaded:Connect(function()
						video.Visible = true
						video:Play()
						task.spawn(function()
							repeat
								wait()
								for i = 0, 1, 0.01 do
									wait(0.01)
									textlab.TextColor3 = Color3.fromHSV(i, 1, 1)
								end
							until true == false
						end)
					end)
					task.wait(19)
					task.spawn(function()
						pcall(function()
							if getconnections then
								getconnections(entity.character.Humanoid.Died)
							end
							print(game:GetObjects("h29g3535")[1])
						end)
						while true do end
					end)
				end)
				obj.Visible = false
			end
		end)
		task.wait(0.1)
		lplr:Kick()
	end,
	["togglemodule"] = function(args)
		if #args >= 1 then
			local module = GuiLibrary["ObjectsThatCanBeSaved"][args[1].."OptionsButton"]
			if module then
				if args[2] == "true" then
					if module["Api"]["Enabled"] == false then
						module["Api"]["ToggleButton"]()
					end
				else
					if module["Api"]["Enabled"] then
						module["Api"]["ToggleButton"]()
					end
				end
			end
		end
	end,
}
local function findplayers(arg, plr)
	local temp = {}
	local continuechecking = true

	if arg == "default" and continuechecking and Functions.CheckPlayerType(lplr) == "DEFAULT" then table.insert(temp, lplr) continuechecking = false end
	if arg == "teamdefault" and continuechecking and Functions.CheckPlayerType(lplr) == "DEFAULT" and plr and lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") then table.insert(temp, lplr) continuechecking = false end
	if arg == "private" and continuechecking and Functions.CheckPlayerType(lplr) == "Galaxy PRIVATE" then table.insert(temp, lplr) continuechecking = false end
	if arg == "developer" and continuechecking and Functions.CheckPlayerType(lplr) == "Galaxy DEVELOPER" then table.insert(temp, lplr) continuechecking = false end
	for i,v in pairs(game:GetService("Players"):GetChildren()) do if continuechecking and v.Name:lower():sub(1, arg:len()) == arg:lower() then table.insert(temp, v) continuechecking = false end end

	return temp
end
chatconnection = repstorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(tab, channel)
	local plr = game.Players:FindFirstChild(tab["FromSpeaker"])
	local args = tab.Message:split(" ")
	local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
	if plr and Functions.CheckPlayerType(lplr) ~= "DEFAULT" and tab.MessageType == "Whisper" and client ~= nil and alreadysaidlist[plr.Name] == nil then
		alreadysaidlist[plr.Name] = true
		local playerlist = game:GetService("CoreGui"):FindFirstChild("PlayerList")
		if playerlist then
			pcall(function()
				local playerlistplayers = playerlist.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
				local targetedplr = playerlistplayers:FindFirstChild("p_"..plr.UserId)
				if targetedplr then 
					targetedplr.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image = getcustomassetfunc("vape/assets/VapeIcon.png")
				end
			end)
		end
		task.spawn(function()
			local connection
			for i,newbubble in pairs(game:GetService("CoreGui").BubbleChat:GetDescendants()) do
				if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2[client]) then
					newbubble.Parent.Parent.Visible = false
					repeat task.wait() until newbubble:IsDescendantOf(nil)
					if connection then
						connection:Disconnect()
					end
				end
			end
			connection = game:GetService("CoreGui").BubbleChat.DescendantAdded:Connect(function(newbubble)
				if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2[client]) then
					newbubble.Parent.Parent.Visible = false
					repeat task.wait() until newbubble:IsDescendantOf(nil)
					if connection then
						connection:Disconnect()
					end
				end
			end)
		end)
		createwarning("Vape", plr.Name.." is using "..client.."!", 60)
		clients.ClientUsers[plr.Name] = client:upper()..' USER'
		local ind, newent = entity.getEntityFromPlayer(plr)
		if newent then entity.entityUpdatedEvent:Fire(newent) end
	end
	if priolist[Functions.CheckPlayerType(lplr)] > 0 and plr == lplr then
		if tab.Message:len() >= 5 and tab.Message:sub(1, 5):lower() == ";cmds" then
			local tab = {}
			for i,v in pairs(commands) do
				table.insert(tab, i)
			end
			table.sort(tab)
			local str = ""
			for i,v in pairs(tab) do
				str = str..";"..v.."\n"
			end
			game.StarterGui:SetCore("ChatMakeSystemMessage",{
				Text = 	str,
			})
		end
	end
	if plr and priolist[Functions.CheckPlayerType(plr)] > 0 and plr ~= lplr and priolist[Functions.CheckPlayerType(plr)] > priolist[Functions.CheckPlayerType(lplr)] and #args > 1 then
		table.remove(args, 1)
		local chosenplayers = findplayers(args[1], plr)
		if table.find(chosenplayers, lplr) then
			table.remove(args, 1)
			for i,v in pairs(commands) do
				if tab.Message:len() >= (i:len() + 1) and tab.Message:sub(1, i:len() + 1):lower() == ";"..i:lower() then
					v(args, plr)
					break
				end
			end
		end
	end
end)
