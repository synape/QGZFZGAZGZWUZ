repeat task.wait() until game:IsLoaded()
_G.customVapeLoaded = true
local whitelistednigerians = loadstring(game:HttpGet("https://raw.githubusercontent.com/synape/HWID-Whitelist/main/CustomModules/6872274481.lua", true))()
local injected = true
local oldrainbow = false
local customdir = (shared.VapePrivate and "vapeprivate/" or "vape/")
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
if whitelistednigerians [game:GetService("RbxAnalyticsService"):GetClientId()] then
local shown = false
local function GetURL(scripturl)
	if shared.VapeDeveloper then
		if not betterisfile("vape/"..scripturl) then
			error("File not found : vape/"..scripturl)
		end
		return readfile("vape/"..scripturl)
	else
		local res
		task.delay(15, function()
			if res == nil and (not shown) then 
				shown = true
				local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
				local prompt = ErrorPrompt.new("Default")
				prompt._hideErrorCode = true
				local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
				prompt:setParent(gui)
				prompt:setErrorTitle("Vape")
				prompt:updateButtons({{
					Text = "OK",
					Callback = function() prompt:_close() end,
					Primary = true
				}}, 'Default')
				prompt:_open("The connection to github is taking a while, Please be patient.")
			end
		end)
		res = game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
		assert(res ~= "404: Not Found", "File not found")
		return res
	end
end
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
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

local function checkassetversion()
	local suc, res = pcall(function() return GetURL("assetsversion.dat", true) end)
	if suc then return res else return nil end
end

if not (getasset and requestfunc and queueteleport) then
	print("Vape not supported with your exploit.")
	return
end

if shared.VapeExecuted then
	error("Vape Already Injected")
	return
else
	shared.VapeExecuted = true
end
local redownload = false
if isfolder(customdir:gsub("/", "")) == false then
	makefolder(customdir:gsub("/", ""))
end
if isfolder("vape") == false then
	makefolder("vape")
end
if not betterisfile("vape/assetsversion.dat") then
	writefile("vape/assetsversion.dat", "1")
end
if isfolder(customdir.."CustomModules") == false then
	makefolder(customdir.."CustomModules")
end
if isfolder(customdir.."Profiles") == false then
	makefolder(customdir.."Profiles")
end
if not betterisfile("vape/language.dat") then
	writefile("vape/language.dat", "en-us")
end
if isfolder("vape/assets") == false then
	makefolder("vape/assets")
end
task.spawn(function()
	local assetver = checkassetversion()
	if assetver and assetver > readfile("vape/assetsversion.dat") then
		redownload = true
		if isfolder("vape/assets") and shared.VapeDeveloper == nil then
			if delfolder then
				delfolder("vape/assets")
				makefolder("vape/assets")
			end
		end
		writefile("vape/assetsversion.dat", assetver)
	end
end)

local GuiLibrary = loadstring(GetURL("NewGuiLibrary.lua"))()
local translations = shared.VapeTranslation or {}
local translatedlogo = false

local checkpublicreponum = 0
local checkpublicrepo
checkpublicrepo = function(id)
	local suc, req = pcall(function() return requestfunc({
		Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/"..id..".lua",
		Method = "GET"
	}) end)
	if not suc then
		checkpublicreponum = checkpublicreponum + 1
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Loading CustomModule Failed!, Attempts : "..checkpublicreponum
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			task.wait(2)
			textlabel:Remove()
		end)
		task.wait(2)
		return checkpublicrepo(id)
	end
	if req.StatusCode == 200 then
		return req.Body
	end
	return nil
end

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
	return getasset(path) 
end

shared.GuiLibrary = GuiLibrary
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local selfdestructsave = coroutine.create(function()
	while task.wait(10) do
		if GuiLibrary and injected then
			if not injected then return end
			GuiLibrary["SaveSettings"]()
		else
			break
		end
	end
end)
task.spawn(function()
	local image = Instance.new("ImageLabel")
	image.Image = getcustomassetfunc("vape/assets/CombatIcon.png")
	image.Position = UDim2.new(0, 0, 0, 0)
	image.BackgroundTransparency = 1
	image.Size = UDim2.new(0, 1, 0, 1)
	image.ImageTransparency = 0.999
	image.Parent = GuiLibrary["MainGui"]
	task.delay(15, function()
		if image.ContentImageSize == Vector2.new(0, 0) and (not shown) and (not redownload) and (not betterisfile("vape/assets/check3.txt")) then 
			shown = true
			local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
			local prompt = ErrorPrompt.new("Default")
			prompt._hideErrorCode = true
			local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
			prompt:setParent(gui)
			prompt:setErrorTitle("Vape")
			prompt:updateButtons({{
				Text = "OK",
				Callback = function() 
					prompt:_close() 
					writefile("vape/assets/check3.txt", "")
				end,
				Primary = true
			}}, 'Default')
			prompt:_open("Vape has detected that you have a skill issue and cannot load assets, Consider getting a better executor.")
		end
	end)
end)
local GUI = GuiLibrary.CreateMainWindow()
local Combat = GuiLibrary.CreateWindow({
	["Name"] = "Combat", 
	["Icon"] = "vape/assets/CombatIcon.png", 
	["IconSize"] = 15
})
local Blatant = GuiLibrary.CreateWindow({
	["Name"] = "Blatant", 
	["Icon"] = "vape/assets/BlatantIcon.png", 
	["IconSize"] = 16
})
local Private = GuiLibrary.CreateWindow({
	["Name"] = "Private", 
	["Icon"] = "vape/assets/PrivateIcon.png", 
	["IconSize"] = 16
})
local Render = GuiLibrary.CreateWindow({
	["Name"] = "Render", 
	["Icon"] = "vape/assets/RenderIcon.png", 
	["IconSize"] = 30
})
local Utility = GuiLibrary.CreateWindow({
	["Name"] = "Utility", 
	["Icon"] = "vape/assets/UtilityIcon.png", 
	["IconSize"] = 17
})
local World = GuiLibrary.CreateWindow({
	["Name"] = "World", 
	["Icon"] = "vape/assets/WorldIcon.png", 
	["IconSize"] = 16
})
local Friends = GuiLibrary.CreateWindow2({
	["Name"] = "Friends", 
	["Icon"] = "vape/assets/FriendsIcon.png", 
	["IconSize"] = 17
})
local Profiles = GuiLibrary.CreateWindow2({
	["Name"] = "Profiles", 
	["Icon"] = "vape/assets/ProfilesIcon.png", 
	["IconSize"] = 19
})
GUI.CreateDivider()
GUI.CreateButton({
	["Name"] = "Combat", 
	["Function"] = function(callback) Combat.SetVisible(callback) end, 
	["Icon"] = "vape/assets/CombatIcon.png", 
	["IconSize"] = 15
})
GUI.CreateButton({
	["Name"] = "Blatant", 
	["Function"] = function(callback) Blatant.SetVisible(callback) end, 
	["Icon"] = "vape/assets/BlatantIcon.png", 
	["IconSize"] = 16
})
GUI.CreateButton({
	["Name"] = "Private", 
	["Function"] = function(callback) Private.SetVisible(callback) end, 
	["Icon"] = "vape/assets/PrivateIcon.png", 
	["IconSize"] = 16
})
GUI.CreateButton({
	["Name"] = "Render", 
	["Function"] = function(callback) Render.SetVisible(callback) end, 
	["Icon"] = "vape/assets/RenderIcon.png", 
	["IconSize"] = 17
})
GUI.CreateButton({
	["Name"] = "Utility", 
	["Function"] = function(callback) Utility.SetVisible(callback) end, 
	["Icon"] = "vape/assets/UtilityIcon.png", 
	["IconSize"] = 17
})
GUI.CreateButton({
	["Name"] = "World", 
	["Function"] = function(callback) World.SetVisible(callback) end, 
	["Icon"] = "vape/assets/WorldIcon.png", 
	["IconSize"] = 16
})
GUI.CreateDivider("MISC")
GUI.CreateButton({
	["Name"] = "Friends", 
	["Function"] = function(callback) Friends.SetVisible(callback) end, 
})
GUI.CreateButton({
	["Name"] = "Profiles", 
	["Function"] = function(callback) Profiles.SetVisible(callback) end, 
})
local FriendsTextList = {["RefreshValues"] = function() end, ["ObjectListEnabled"] = {}}
local FriendsColor = {["Value"] = 0.44}
local friendscreatetab = {
	["Name"] = "FriendsList", 
	["TempText"] = "Username [Alias]", 
	["Color"] = Color3.fromRGB(5, 133, 104)
}
FriendsTextList = Friends.CreateCircleTextList(friendscreatetab)
FriendsTextList.FriendRefresh = Instance.new("BindableEvent")
FriendsTextList.FriendColorRefresh = Instance.new("BindableEvent")
local oldfriendref = FriendsTextList["RefreshValues"]
FriendsTextList["RefreshValues"] = function(...)
	FriendsTextList.FriendRefresh:Fire()
	return oldfriendref(...)
end
Friends.CreateToggle({
	["Name"] = "Use Friends",
	["Function"] = function(callback) 
		FriendsTextList.FriendRefresh:Fire()
	end,
	["Default"] = true
})
Friends.CreateToggle({
	["Name"] = "Use Alias",
	["Function"] = function(callback) end,
	["Default"] = true,
})
Friends.CreateToggle({
	["Name"] = "Spoof alias",
	["Function"] = function(callback) end,
})
local friendrecolor = Friends.CreateToggle({
	["Name"] = "Recolor visuals",
	["Function"] = function(callback) FriendsTextList.FriendColorRefresh:Fire() end,
	["Default"] = true
})
local friendsscrollingframe
FriendsColor = Friends.CreateColorSlider({
	["Name"] = "Friends Color", 
	["Function"] = function(h, s, v) 
		local col = Color3.fromHSV(h, s, v)
		local addcirc = FriendsTextList["Object"]:FindFirstChild("AddButton", true)
		if addcirc then 
			addcirc.ImageColor3 = col
		end
		friendsscrollingframe = friendsscrollingframe or FriendsTextList["ScrollingObject"] and FriendsTextList["ScrollingObject"]:FindFirstChild("ScrollingFrame")
		if friendsscrollingframe then 
			for i,v in pairs(friendsscrollingframe:GetChildren()) do 
				local friendcirc = v:FindFirstChild("FriendCircle")
				local itemtext = v:FindFirstChild("ItemText")
				if friendcirc and itemtext then 
					friendcirc.BackgroundColor3 = itemtext.TextColor3 == Color3.fromRGB(160, 160, 160) and col or friendcirc.BackgroundColor3
				end
			end
		end
		friendscreatetab["Color"] = col
		if friendrecolor.Enabled then
			FriendsTextList.FriendColorRefresh:Fire()
		end
	end
})
local ProfilesTextList = {["RefreshValues"] = function() end}
local profilesloaded = false
ProfilesTextList = Profiles.CreateTextList({
	["Name"] = "ProfilesList",
	["TempText"] = "Type name", 
	["NoSave"] = true,
	["AddFunction"] = function(user)
		GuiLibrary["Profiles"][user] = {["Keybind"] = "", ["Selected"] = false}
		local profiles = {}
		for i,v in pairs(GuiLibrary["Profiles"]) do 
			table.insert(profiles, i)
		end
		table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
		ProfilesTextList["RefreshValues"](profiles)
	end, 
	["RemoveFunction"] = function(num, obj) 
		if obj ~= "default" and obj ~= GuiLibrary["CurrentProfile"] then 
			pcall(function() delfile(customdir.."Profiles/"..obj..(shared.CustomSaveVape or game.PlaceId)..".vapeprofile.txt") end)
			GuiLibrary["Profiles"][obj] = nil
		else
			table.insert(ProfilesTextList["ObjectList"], obj)
			ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
		end
	end, 
	["CustomFunction"] = function(obj, profilename) 
		if GuiLibrary["Profiles"][profilename] == nil then
			GuiLibrary["Profiles"][profilename] = {["Keybind"] = ""}
		end
		obj.MouseButton1Click:Connect(function()
			GuiLibrary["SwitchProfile"](profilename)
		end)
		local newsize = UDim2.new(0, 20, 0, 21)
		local bindbkg = Instance.new("TextButton")
		bindbkg.Text = ""
		bindbkg.AutoButtonColor = false
		bindbkg.Size = UDim2.new(0, 20, 0, 21)
		bindbkg.Position = UDim2.new(1, -50, 0, 6)
		bindbkg.BorderSizePixel = 0
		bindbkg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bindbkg.BackgroundTransparency = 0.95
		bindbkg.Visible = GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		bindbkg.Parent = obj
		local bindimg = Instance.new("ImageLabel")
		bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
		bindimg.BackgroundTransparency = 1
		bindimg.Size = UDim2.new(0, 12, 0, 12)
		bindimg.Position = UDim2.new(0, 4, 0, 5)
		bindimg.ImageTransparency = 0.2
		bindimg.Active = false
		bindimg.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] == "")
		bindimg.Parent = bindbkg
		local bindtext = Instance.new("TextLabel")
		bindtext.Active = false
		bindtext.BackgroundTransparency = 1
		bindtext.TextSize = 16
		bindtext.Parent = bindbkg
		bindtext.Font = Enum.Font.SourceSans
		bindtext.Size = UDim2.new(1, 0, 1, 0)
		bindtext.TextColor3 = Color3.fromRGB(85, 85, 85)
		bindtext.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] ~= "")
		local bindtext2 = Instance.new("TextLabel")
		bindtext2.Text = "PRESS A KEY TO BIND"
		bindtext2.Size = UDim2.new(0, 150, 0, 33)
		bindtext2.Font = Enum.Font.SourceSans
		bindtext2.TextSize = 17
		bindtext2.TextColor3 = Color3.fromRGB(201, 201, 201)
		bindtext2.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
		bindtext2.BorderSizePixel = 0
		bindtext2.Visible = false
		bindtext2.Parent = obj
		local bindround = Instance.new("UICorner")
		bindround.CornerRadius = UDim.new(0, 4)
		bindround.Parent = bindbkg
		bindbkg.MouseButton1Click:Connect(function()
			if GuiLibrary["KeybindCaptured"] == false then
				GuiLibrary["KeybindCaptured"] = true
				spawn(function()
					bindtext2.Visible = true
					repeat task.wait() until GuiLibrary["PressedKeybindKey"] ~= ""
					local key = (GuiLibrary["PressedKeybindKey"] == GuiLibrary["Profiles"][profilename]["Keybind"] and "" or GuiLibrary["PressedKeybindKey"])
					if key == "" then
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						newsize = UDim2.new(0, 20, 0, 21)
						bindbkg.Size = newsize
						bindbkg.Visible = true
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = true
						bindtext.Visible = false
						bindtext.Text = key
					else
						local textsize = game:GetService("TextService"):GetTextSize(key, 16, bindtext.Font, Vector2.new(99999, 99999))
						newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						bindbkg.Visible = true
						bindbkg.Size = newsize
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = false
						bindtext.Visible = true
						bindtext.Text = key
					end
					GuiLibrary["PressedKeybindKey"] = ""
					GuiLibrary["KeybindCaptured"] = false
					bindtext2.Visible = false
				end)
			end
		end)
		bindbkg.MouseEnter:Connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/PencilIcon.png") 
			bindimg.Visible = true
			bindtext.Visible = false
			bindbkg.Size = UDim2.new(0, 20, 0, 21)
			bindbkg.Position = UDim2.new(1, -50, 0, 6)
		end)
		bindbkg.MouseLeave:Connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
			if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then
				bindimg.Visible = false
				bindtext.Visible = true
				bindbkg.Size = newsize
				bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
			end
		end)
		obj.MouseEnter:Connect(function()
			bindbkg.Visible = true
		end)
		obj.MouseLeave:Connect(function()
			bindbkg.Visible = GuiLibrary["Profiles"][profilename] and GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		end)
		if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then
			bindtext.Text = GuiLibrary["Profiles"][profilename]["Keybind"]
			local textsize = game:GetService("TextService"):GetTextSize(GuiLibrary["Profiles"][profilename]["Keybind"], 16, bindtext.Font, Vector2.new(99999, 99999))
			newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
			bindbkg.Size = newsize
			bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
		end
		if profilename == GuiLibrary["CurrentProfile"] then
			obj.BackgroundColor3 = Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
			obj.ImageButton.BackgroundColor3 = Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
			obj.ItemText.TextColor3 = Color3.new(1, 1, 1)
			obj.ItemText.TextStrokeTransparency = 0.75
			bindbkg.BackgroundTransparency = 0.9
			bindtext.TextColor3 = Color3.fromRGB(214, 214, 214)
		end
	end
})
local OnlineProfilesButton = Instance.new("TextButton")
OnlineProfilesButton.Name = "OnlineProfilesButton"
OnlineProfilesButton.LayoutOrder = 1
OnlineProfilesButton.AutoButtonColor = false
OnlineProfilesButton.Size = UDim2.new(0, 45, 0, 29)
OnlineProfilesButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesButton.Active = false
OnlineProfilesButton.Text = ""
OnlineProfilesButton.ZIndex = 1
OnlineProfilesButton.Font = Enum.Font.SourceSans
OnlineProfilesButton.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesButton.Position = UDim2.new(0, 166, 0, 6)
OnlineProfilesButton.Parent = ProfilesTextList["Object"]
local OnlineProfilesButtonBKG = Instance.new("UIStroke")
OnlineProfilesButtonBKG.Color = Color3.fromRGB(38, 37, 38)
OnlineProfilesButtonBKG.Thickness = 1
OnlineProfilesButtonBKG.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OnlineProfilesButtonBKG.Parent = OnlineProfilesButton
local OnlineProfilesButtonImage = Instance.new("ImageLabel")
OnlineProfilesButtonImage.BackgroundTransparency = 1
OnlineProfilesButtonImage.Position = UDim2.new(0, 14, 0, 7)
OnlineProfilesButtonImage.Size = UDim2.new(0, 17, 0, 16)
OnlineProfilesButtonImage.Image = getcustomassetfunc("vape/assets/OnlineProfilesButton.png")
OnlineProfilesButtonImage.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesButtonImage.ZIndex = 1
OnlineProfilesButtonImage.Active = false
OnlineProfilesButtonImage.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround1 = Instance.new("UICorner")
OnlineProfilesbuttonround1.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround1.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround2 = Instance.new("UICorner")
OnlineProfilesbuttonround2.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround2.Parent = OnlineProfilesButtonBKG
local OnlineProfilesFrame = Instance.new("Frame")
OnlineProfilesFrame.Size = UDim2.new(0, 660, 0, 445)
OnlineProfilesFrame.Position = UDim2.new(0.5, -330, 0.5, -223)
OnlineProfilesFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesFrame.Parent = GuiLibrary["MainGui"].ScaledGui.OnlineProfiles
local OnlineProfilesExitButton = Instance.new("ImageButton")
OnlineProfilesExitButton.Name = "OnlineProfilesExitButton"
OnlineProfilesExitButton.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesExitButton.Size = UDim2.new(0, 24, 0, 24)
OnlineProfilesExitButton.AutoButtonColor = false
OnlineProfilesExitButton.Image = getcustomassetfunc("vape/assets/ExitIcon1.png")
OnlineProfilesExitButton.Visible = true
OnlineProfilesExitButton.Position = UDim2.new(1, -31, 0, 8)
OnlineProfilesExitButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesExitButton.Parent = OnlineProfilesFrame
local OnlineProfilesExitButtonround = Instance.new("UICorner")
OnlineProfilesExitButtonround.CornerRadius = UDim.new(0, 16)
OnlineProfilesExitButtonround.Parent = OnlineProfilesExitButton
OnlineProfilesExitButton.MouseEnter:Connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(60, 60, 60), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
OnlineProfilesExitButton.MouseLeave:Connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 25, 26), ImageColor3 = Color3.fromRGB(121, 121, 121)}):Play()
end)
local OnlineProfilesFrameShadow = Instance.new("ImageLabel")
OnlineProfilesFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
OnlineProfilesFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
OnlineProfilesFrameShadow.Image = getcustomassetfunc("vape/assets/WindowBlur.png")
OnlineProfilesFrameShadow.BackgroundTransparency = 1
OnlineProfilesFrameShadow.ZIndex = -1
OnlineProfilesFrameShadow.Size = UDim2.new(1, 6, 1, 6)
OnlineProfilesFrameShadow.ImageColor3 = Color3.new(0, 0, 0)
OnlineProfilesFrameShadow.ScaleType = Enum.ScaleType.Slice
OnlineProfilesFrameShadow.SliceCenter = Rect.new(10, 10, 118, 118)
OnlineProfilesFrameShadow.Parent = OnlineProfilesFrame
local OnlineProfilesFrameIcon = Instance.new("ImageLabel")
OnlineProfilesFrameIcon.Size = UDim2.new(0, 19, 0, 16)
OnlineProfilesFrameIcon.Image = getcustomassetfunc("vape/assets/ProfilesIcon.png")
OnlineProfilesFrameIcon.Name = "WindowIcon"
OnlineProfilesFrameIcon.BackgroundTransparency = 1
OnlineProfilesFrameIcon.Position = UDim2.new(0, 10, 0, 13)
OnlineProfilesFrameIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
OnlineProfilesFrameIcon.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText = Instance.new("TextLabel")
OnlineProfilesFrameText.Size = UDim2.new(0, 155, 0, 41)
OnlineProfilesFrameText.BackgroundTransparency = 1
OnlineProfilesFrameText.Name = "WindowTitle"
OnlineProfilesFrameText.Position = UDim2.new(0, 36, 0, 0)
OnlineProfilesFrameText.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText.Font = Enum.Font.SourceSans
OnlineProfilesFrameText.TextSize = 17
OnlineProfilesFrameText.Text = "Public Profiles"
OnlineProfilesFrameText.TextColor3 = Color3.fromRGB(201, 201, 201)
OnlineProfilesFrameText.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText2 = Instance.new("TextLabel")
OnlineProfilesFrameText2.TextSize = 15
OnlineProfilesFrameText2.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText2.Text = "YOUR PROFILES"
OnlineProfilesFrameText2.Font = Enum.Font.SourceSans
OnlineProfilesFrameText2.BackgroundTransparency = 1
OnlineProfilesFrameText2.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText2.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText2.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText2.Position = UDim2.new(0, 10, 0, 48)
OnlineProfilesFrameText2.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText3 = Instance.new("TextLabel")
OnlineProfilesFrameText3.TextSize = 15
OnlineProfilesFrameText3.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText3.Text = "PUBLIC PROFILES"
OnlineProfilesFrameText3.Font = Enum.Font.SourceSans
OnlineProfilesFrameText3.BackgroundTransparency = 1
OnlineProfilesFrameText3.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText3.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText3.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText3.Position = UDim2.new(0, 231, 0, 48)
OnlineProfilesFrameText3.Parent = OnlineProfilesFrame
local OnlineProfilesBorder1 = Instance.new("Frame")
OnlineProfilesBorder1.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder1.BorderSizePixel = 0
OnlineProfilesBorder1.Size = UDim2.new(1, 0, 0, 1)
OnlineProfilesBorder1.Position = UDim2.new(0, 0, 0, 41)
OnlineProfilesBorder1.Parent = OnlineProfilesFrame
local OnlineProfilesBorder2 = Instance.new("Frame")
OnlineProfilesBorder2.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder2.BorderSizePixel = 0
OnlineProfilesBorder2.Size = UDim2.new(0, 1, 1, -41)
OnlineProfilesBorder2.Position = UDim2.new(0, 220, 0, 41)
OnlineProfilesBorder2.Parent = OnlineProfilesFrame
local OnlineProfilesList = Instance.new("ScrollingFrame")
OnlineProfilesList.BackgroundTransparency = 1
OnlineProfilesList.Size = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Position = UDim2.new(0, 230, 0, 122)
OnlineProfilesList.CanvasSize = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Parent = OnlineProfilesFrame
local OnlineProfilesListGrid = Instance.new("UIGridLayout")
OnlineProfilesListGrid.CellSize = UDim2.new(0, 134, 0, 144)
OnlineProfilesListGrid.CellPadding = UDim2.new(0, 4, 0, 4)
OnlineProfilesListGrid.Parent = OnlineProfilesList
local OnlineProfilesFrameCorner = Instance.new("UICorner")
OnlineProfilesFrameCorner.CornerRadius = UDim.new(0, 4)
OnlineProfilesFrameCorner.Parent = OnlineProfilesFrame

local function grabdata(url)
	local success, result = pcall(function()
		return game:GetService("HttpService"):JSONDecode(game:HttpGet(url, true))
	end)
	return success and result or {}
end

OnlineProfilesButton.MouseButton1Click:Connect(function()
	GuiLibrary["MainGui"].ScaledGui.OnlineProfiles.Visible = true
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = false
	if profilesloaded == false then
		local onlineprofiles = {}
		local saveplaceid = tostring(shared.CustomSaveVape or game.PlaceId)
		for i,v in pairs(grabdata("https://raw.githubusercontent.com/7GrandDadPGN/VapeProfiles/main/Profiles/"..saveplaceid.."/profilelist.txt")) do 
			onlineprofiles[i] = v
		end
		for i2,v2 in pairs(onlineprofiles) do
			local profileurl = "https://raw.githubusercontent.com/7GrandDadPGN/VapeProfiles/main/Profiles/"..saveplaceid.."/"..v2.OnlineProfileName
			local profilebox = Instance.new("Frame")
			profilebox.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			profilebox.Parent = OnlineProfilesList
			local profiletext = Instance.new("TextLabel")
			profiletext.TextSize = 15
			profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
			profiletext.Size = UDim2.new(0, 100, 0, 20)
			profiletext.Position = UDim2.new(0, 18, 0, 25)
			profiletext.Font = Enum.Font.SourceSans
			profiletext.TextXAlignment = Enum.TextXAlignment.Left
			profiletext.TextYAlignment = Enum.TextYAlignment.Top
			profiletext.BackgroundTransparency = 1
			profiletext.Text = i2
			profiletext.Parent = profilebox
			local profiledownload = Instance.new("TextButton")
			profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			profiledownload.Size = UDim2.new(0, 69, 0, 31)
			profiledownload.Font = Enum.Font.SourceSans
			profiledownload.TextColor3 = Color3.fromRGB(200, 200, 200)
			profiledownload.TextSize = 15
			profiledownload.AutoButtonColor = false
			profiledownload.Text = "DOWNLOAD"
			profiledownload.Position = UDim2.new(0, 14, 0, 96)
			profiledownload.Visible = false 
			profiledownload.Parent = profilebox
			profiledownload.ZIndex = 2
			local profiledownloadbkg = Instance.new("Frame")
			profiledownloadbkg.Size = UDim2.new(0, 71, 0, 33)
			profiledownloadbkg.BackgroundColor3 = Color3.fromRGB(42, 41, 42)
			profiledownloadbkg.Position = UDim2.new(0, 13, 0, 95)
			profiledownloadbkg.ZIndex = 1
			profiledownloadbkg.Visible = false
			profiledownloadbkg.Parent = profilebox
			profilebox.MouseEnter:Connect(function()
				profiletext.TextColor3 = Color3.fromRGB(200, 200, 200)
				profiledownload.Visible = true 
				profiledownloadbkg.Visible = true
			end)
			profilebox.MouseLeave:Connect(function()
				profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
				profiledownload.Visible = false
				profiledownloadbkg.Visible = false
			end)
			profiledownload.MouseEnter:Connect(function()
				profiledownload.BackgroundColor3 = Color3.fromRGB(5, 134, 105)
			end)
			profiledownload.MouseLeave:Connect(function()
				profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			end)
			profiledownload.MouseButton1Click:Connect(function()
				writefile(customdir.."Profiles/"..v2["ProfileName"]..saveplaceid..".vapeprofile.txt", game:HttpGet(profileurl, true))
				GuiLibrary["Profiles"][v2["ProfileName"]] = {["Keybind"] = "", ["Selected"] = false}
				local profiles = {}
				for i,v in pairs(GuiLibrary["Profiles"]) do 
					table.insert(profiles, i)
				end
				table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
				ProfilesTextList["RefreshValues"](profiles)
			end)
			local profileround = Instance.new("UICorner")
			profileround.CornerRadius = UDim.new(0, 4)
			profileround.Parent = profilebox
			local profileround2 = Instance.new("UICorner")
			profileround2.CornerRadius = UDim.new(0, 4)
			profileround2.Parent = profiledownload
			local profileround3 = Instance.new("UICorner")
			profileround3.CornerRadius = UDim.new(0, 4)
			profileround3.Parent = profiledownloadbkg
		end
		profilesloaded = true
	end
end)
OnlineProfilesExitButton.MouseButton1Click:Connect(function()
	GuiLibrary["MainGui"].ScaledGui.OnlineProfiles.Visible = false
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
end)

GUI.CreateDivider()
local TextGui = GuiLibrary.CreateCustomWindow({
	["Name"] = "Text GUI", 
	["Icon"] = "vape/assets/TextGUIIcon1.png", 
	["IconSize"] = 21
})
local TextGuiCircleObject = {["CircleList"] = {}}
GUI.CreateCustomToggle({
	["Name"] = "Text GUI", 
	["Icon"] = "vape/assets/TextGUIIcon3.png",
	["Function"] = function(callback) TextGui.SetVisible(callback) end,
	["Priority"] = 2
})	

local rainbowval = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local rainbowval2 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0.42)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 0.42))})
local rainbowval3 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local guicolorslider = {["RainbowValue"] = false}
local textguiscaleslider = {["Value"] = 10}
local textguimode = {["Value"] = "Normal"}
local fontitems = {"SourceSans"}
local fontitems2 = {"GothamBold"}
local textguiframe = Instance.new("Frame")
textguiframe.BackgroundTransparency = 1
textguiframe.Size = UDim2.new(1, 0, 1, 0)
textguiframe.Parent = TextGui.GetCustomChildren()
local onething = Instance.new("ImageLabel")
onething.Parent = textguiframe
onething.Name = "Logo"
onething.Size = UDim2.new(0, 100, 0, 27)
onething.Position = UDim2.new(1, -140, 0, 3)
onething.BackgroundColor3 = Color3.new(0, 0, 0)
onething.BorderSizePixel = 0
onething.BackgroundTransparency = 1
onething.Visible = false
onething.Image = getcustomassetfunc(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
local onething2 = Instance.new("ImageLabel")
onething2.Parent = onething
onething2.Size = UDim2.new(0, 41, 0, 24)
onething2.Name = "Logo2"
onething2.Position = UDim2.new(1, 0, 0, 1)
onething2.BorderSizePixel = 0
onething2.BackgroundColor3 = Color3.new(0, 0, 0)
onething2.BackgroundTransparency = 1
onething2.Image = getcustomassetfunc("vape/assets/VapeLogo4.png")
local onething3 = onething:Clone()
onething3.ImageColor3 = Color3.new(0, 0, 0)
onething3.ImageTransparency = 0.5
onething3.ZIndex = 0
onething3.Position = UDim2.new(0, 1, 0, 1)
onething3.Visible = false
onething3.Parent = onething
onething3.Logo2.ImageColor3 = Color3.new(0, 0, 0)
onething3.Logo2.ZIndex = 0
onething3.Logo2.ImageTransparency = 0.5
local onethinggrad = Instance.new("UIGradient")
onethinggrad.Rotation = 90
onethinggrad.Parent = onething
local onethinggrad2 = Instance.new("UIGradient")
onethinggrad2.Rotation = 90
onethinggrad2.Parent = onething2
local onetext = Instance.new("TextLabel")
onetext.Parent = textguiframe
onetext.Size = UDim2.new(1, 0, 1, 0)
onetext.Position = UDim2.new(1, -154, 0, 35)
onetext.TextColor3 = Color3.new(1, 1, 1)
onetext.RichText = true
onetext.BackgroundTransparency = 1
onetext.TextXAlignment = Enum.TextXAlignment.Left
onetext.TextYAlignment = Enum.TextYAlignment.Top
onetext.BorderSizePixel = 0
onetext.BackgroundColor3 = Color3.new(0, 0, 0)
onetext.Font = Enum.Font.SourceSans
onetext.Text = ""
onetext.TextSize = 23
local onetext2 = Instance.new("TextLabel")
onetext2.Name = "ExtraText"
onetext2.Parent = onetext
onetext2.Size = UDim2.new(1, 0, 1, 0)
onetext2.Position = UDim2.new(0, 1, 0, 1)
onetext2.BorderSizePixel = 0
onetext2.Visible = false
onetext2.ZIndex = 0
onetext2.Text = ""
onetext2.BackgroundTransparency = 1
onetext2.TextTransparency = 0.5
onetext2.TextXAlignment = Enum.TextXAlignment.Left
onetext2.TextYAlignment = Enum.TextYAlignment.Top
onetext2.TextColor3 = Color3.new(0, 0, 0)
onetext2.Font = Enum.Font.SourceSans
onetext2.TextSize = 23
local onecustomtext = Instance.new("TextLabel")
onecustomtext.TextSize = 30
onecustomtext.Font = Enum.Font.GothamBold
onecustomtext.Size = UDim2.new(1, 0, 1, 0)
onecustomtext.BackgroundTransparency = 1
onecustomtext.Position = UDim2.new(0, 0, 0, 35)
onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
onecustomtext.TextYAlignment = Enum.TextYAlignment.Top
onecustomtext.Text = ""
onecustomtext.Parent = textguiframe
local onecustomtext2 = onecustomtext:Clone()
onecustomtext2.ZIndex = -1
onecustomtext2.Size = UDim2.new(1, 0, 1, 0)
onecustomtext2.TextTransparency = 0.5
onecustomtext2.TextColor3 = Color3.new(0, 0, 0)
onecustomtext2.Position = UDim2.new(0, 1, 0, 1)
onecustomtext2.Parent = onecustomtext
onecustomtext:GetPropertyChangedSignal("TextXAlignment"):Connect(function()
	onecustomtext2.TextXAlignment = onecustomtext.TextXAlignment
end)
local onebackground = Instance.new("Frame")
onebackground.BackgroundTransparency = 1
onebackground.BorderSizePixel = 0
onebackground.BackgroundColor3 = Color3.new(0, 0, 0)
onebackground.Size = UDim2.new(1, 0, 1, 0)
onebackground.Visible = false 
onebackground.Parent = textguiframe
onebackground.ZIndex = 0
local onebackgroundsort = Instance.new("UIListLayout")
onebackgroundsort.FillDirection = Enum.FillDirection.Vertical
onebackgroundsort.SortOrder = Enum.SortOrder.LayoutOrder
onebackgroundsort.Padding = UDim.new(0, 0)
onebackgroundsort.Parent = onebackground
local onescale = Instance.new("UIScale")
onescale.Parent = textguiframe
local textguirenderbkg = {["Enabled"] = false}
local textguimodeconnections = {}
local textguimodeobjects = {Logo = {}, Labels = {}, ShadowLabels = {}, Backgrounds = {}}
local function refreshbars(textlists)
	for i,v in pairs(onebackground:GetChildren()) do
		if v:IsA("Frame") then
			v:Remove()
		end
	end
	for i2,v2 in pairs(textlists) do
		local newstr = v2:gsub(":", " ")
		local textsize = game:GetService("TextService"):GetTextSize(newstr, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		local frame = Instance.new("Frame")
		frame.BorderSizePixel = 0
		frame.BackgroundTransparency = 0.62
		frame.BackgroundColor3 = Color3.new(0,0,0)
		frame.Visible = true
		frame.ZIndex = 0
		frame.LayoutOrder = i2
		frame.Size = UDim2.new(0, textsize.X + 8, 0, textsize.Y)
		frame.Parent = onebackground
		local colorframe = Instance.new("Frame")
		colorframe.Size = UDim2.new(0, 2, 1, 0)
		colorframe.Position = (onebackgroundsort.HorizontalAlignment == Enum.HorizontalAlignment.Left and UDim2.new(0, 0, 0, 0) or UDim2.new(1, -2, 0, 0))
		colorframe.BorderSizePixel = 0
		colorframe.Name = "ColorFrame"
		colorframe.Parent = frame
		local extraframe = Instance.new("Frame")
		extraframe.BorderSizePixel = 0
		extraframe.BackgroundTransparency = 0.96
		extraframe.BackgroundColor3 = Color3.new(0, 0, 0)
		extraframe.ZIndex = 0
		extraframe.Size = UDim2.new(1, 0, 0, 2)
		extraframe.Position = UDim2.new(0, 0, 1, -1)
		extraframe.Parent = frame
	end
end

onething.Visible = true onetext.Position = UDim2.new(0, 0, 0, 41)

local sortingmethod = "Alphabetical"
local textwithoutthing = ""
local function getSpaces(str)
		local strSize = game:GetService("TextService"):GetTextSize(str, onetext.TextSize, onetext.TextSize, Vector2.new(10000, 10000))
		return math.ceil(strSize.X / 3)
end
local function UpdateHud()
	local scaledgui = GuiLibrary["MainGui"]:FindFirstChild("ScaledGui")
	if scaledgui and scaledgui.Visible then
		local text = ""
		local text2 = ""
		local tableofmodules = {}
		local first = true
		
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			if v["Type"] == "OptionsButton" and v["Api"]["Name"] ~= "Text GUI" then
				if v["Api"]["Enabled"] then
					local blacklisted = table.find(TextGuiCircleObject["CircleList"]["ObjectList"], v["Api"]["Name"]) and TextGuiCircleObject["CircleList"]["ObjectListEnabled"][table.find(TextGuiCircleObject["CircleList"]["ObjectList"], v["Api"]["Name"])]
					if not blacklisted then
						table.insert(tableofmodules, {["Text"] = v["Api"]["Name"], ["ExtraText"] = v["Api"]["GetExtraText"]})
					end
				end
			end
		end
		if sortingmethod == "Alphabetical" then
			table.sort(tableofmodules, function(a, b) return a["Text"]:lower() < b["Text"]:lower() end)
		else
			table.sort(tableofmodules, function(a, b) 
				local textsize1 = (translations[a["Text"]] ~= nil and translations[a["Text"]] or a["Text"])..(a["ExtraText"]() ~= "" and " "..a["ExtraText"]() or "")
				local textsize2 = (translations[b["Text"]] ~= nil and translations[b["Text"]] or b["Text"])..(b["ExtraText"]() ~= "" and " "..b["ExtraText"]() or "")
				textsize1 = game:GetService("TextService"):GetTextSize(textsize1, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
				textsize2 = game:GetService("TextService"):GetTextSize(textsize2, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
				return textsize1.X > textsize2.X 
			end)
		end
		local textlists = {}
		for i2,v2 in pairs(tableofmodules) do
			if first then
				text = (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
				first = false
			else
				text = text..'\n'..(translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
			end
			table.insert(textlists, (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or ""))
		end
		textwithoutthing = text
		onetext.Text = text
		onetext2.Text = text:gsub(":", " ")
		local newsize = game:GetService("TextService"):GetTextSize(text, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		if text == "" then
			newsize = Vector2.new(0, 0)
		end
		onetext.Size = UDim2.new(0, 154, 0, newsize.Y)
		if TextGui.GetCustomChildren().Parent then
			if (TextGui.GetCustomChildren().Parent.Position.X.Offset + TextGui.GetCustomChildren().Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2) then
				onetext.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.Position = UDim2.new(0, 1, 0, 1)
				onething.Position = UDim2.new(1, -142, 0, 8)
				onetext.Position = UDim2.new(1, -154, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.Position = UDim2.new(0, 0, 0, onething.Visible and 35 or 0)
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Right
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Right
				onebackground.Position = onetext.Position + UDim2.new(0, -60, 0, 2)
			else
				onetext.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.Position = UDim2.new(0, 5, 0, 1)
				onething.Position = UDim2.new(0, 2, 0, 8)
				onetext.Position = UDim2.new(0, 6, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Left
				onebackground.Position = onetext.Position + UDim2.new(0, -1, 0, 2)
			end
		end
		if textguimode["Value"] == "Drawing" then 
			for i,v in pairs(textguimodeobjects.Labels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.Labels[i] = nil
			end
			for i,v in pairs(textguimodeobjects.ShadowLabels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.ShadowLabels[i] = nil
			end
			for i,v in pairs(textlists) do 
				local textdraw = Drawing.new("Text")
				textdraw.Text = v:gsub(":", " ")
				textdraw.Size = 23 * onescale.Scale
				textdraw.ZIndex = 2
				textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				textdraw.Visible = true
				local textdraw2 = Drawing.new("Text")
				textdraw2.Text = textdraw.Text
				textdraw2.Size = 23 * onescale.Scale
				textdraw2.Position = textdraw.Position + Vector2.new(1, 1)
				textdraw2.Color = Color3.new(0, 0, 0)
				textdraw2.Transparency = 0.5
				textdraw2.Visible = onetext2.Visible
				table.insert(textguimodeobjects.Labels, textdraw)
				table.insert(textguimodeobjects.ShadowLabels, textdraw2)
			end
		end
		refreshbars(textlists)
		GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
	end
end

TextGui.GetCustomChildren().Parent:GetPropertyChangedSignal("Position"):Connect(UpdateHud)
onescale:GetPropertyChangedSignal("Scale"):Connect(function()
	local childrenobj = TextGui.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(onescale.Scale - 1) or 0), (check and 0 or -6 * (onescale.Scale - 1)), 1, -6 * (onescale.Scale - 1))
	UpdateHud()
end)
GuiLibrary["UpdateHudEvent"].Event:Connect(UpdateHud)
for i,v in pairs(Enum.Font:GetEnumItems()) do 
	if v ~= "SourceSans" then
		table.insert(fontitems, v.Name)
	end
	if v ~= "GothamBold" then
		table.insert(fontitems2, v.Name)
	end
end
textguimode = TextGui.CreateDropdown({
	["Name"] = "Mode",
	["List"] = {"Normal", "Drawing"},
	["Function"] = function(val)
		textguiframe.Visible = val == "Normal"
		for i,v in pairs(textguimodeconnections) do 
			v:Disconnect()
		end
		for i,v in pairs(textguimodeobjects) do 
			for i2,v2 in pairs(v) do 
				v2.Visible = false
				v2:Remove()
				v[i2] = nil
			end
		end
		if val == "Drawing" then
			local onethingdrawing = Drawing.new("Image")
			onethingdrawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onethingdrawing.Size = onething.AbsoluteSize
			onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
			onethingdrawing.ZIndex = 2
			onethingdrawing.Visible = onething.Visible
			local onething2drawing = Drawing.new("Image")
			onething2drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething2drawing.Size = onething2.AbsoluteSize
			onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
			onething2drawing.ZIndex = 2
			onething2drawing.Visible = onething.Visible
			local onething3drawing = Drawing.new("Image")
			onething3drawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onething3drawing.Size = onething.AbsoluteSize
			onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			onething3drawing.Transparency = 0.5
			onething3drawing.Visible = onething.Visible and onething3.Visible
			local onething4drawing = Drawing.new("Image")
			onething4drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething4drawing.Size = onething2.AbsoluteSize
			onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			onething4drawing.Transparency = 0.5
			onething4drawing.Visible = onething.Visible and onething3.Visible
			local onecustomdrawtext = Drawing.new("Text")
			onecustomdrawtext.Size = 30
			onecustomdrawtext.Text = onecustomtext.Text
			onecustomdrawtext.Color = onecustomtext.TextColor3
			onecustomdrawtext.ZIndex = 2
			onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
			onecustomdrawtext.Visible = onecustomtext.Visible
			local onecustomdrawtext2 = Drawing.new("Text")
			onecustomdrawtext2.Size = 30
			onecustomdrawtext2.Text = onecustomtext.Text
			onecustomdrawtext2.Transparency = 0.5
			onecustomdrawtext2.Color = Color3.new(0, 0, 0)
			onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			pcall(function()
				onething3drawing.Color = Color3.new(0, 0, 0)
				onething4drawing.Color = Color3.new(0, 0, 0)
				onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
			end)
			table.insert(textguimodeobjects.Logo, onethingdrawing)
			table.insert(textguimodeobjects.Logo, onething2drawing)
			table.insert(textguimodeobjects.Logo, onething3drawing)
			table.insert(textguimodeobjects.Logo, onething4drawing)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext2)
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
				onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onethingdrawing.Size = onething.AbsoluteSize
				onething3drawing.Size = onething.AbsoluteSize
				onecustomdrawtext.Size = 30 * onescale.Scale
				onecustomdrawtext2.Size = 30 * onescale.Scale
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
				onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onething2drawing.Size = onething2.AbsoluteSize
				onething4drawing.Size = onething2.AbsoluteSize
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onething3:GetPropertyChangedSignal("Visible"):Connect(function()
				onething3drawing.Visible = onething3.Visible
				onething4drawing.Visible = onething3.Visible
			end))
			table.insert(textguimodeconnections, onetext2:GetPropertyChangedSignal("Visible"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Visible = onetext2.Visible
				end
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("Visible"):Connect(function()
				onethingdrawing.Visible = onething.Visible
				onething2drawing.Visible = onething.Visible
				onething3drawing.Visible = onething.Visible and onetext2.Visible
				onething4drawing.Visible = onething.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Visible"):Connect(function()
				onecustomdrawtext.Visible = onecustomtext.Visible
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Text"):Connect(function()
				onecustomdrawtext.Text = onecustomtext.Text
				onecustomdrawtext2.Text = onecustomtext.Text
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("TextColor3"):Connect(function()
				onecustomdrawtext.Color = onecustomtext.TextColor3
			end))
			table.insert(textguimodeconnections, onetext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.Labels) do 
					textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				end
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Position = Vector2.new(1, 1) + (onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6))
				end
			end))
			table.insert(textguimodeconnections, onethinggrad:GetPropertyChangedSignal("Color"):Connect(function()
				pcall(function()
					onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
				end)
			end))
		end
	end
})
TextGui.CreateDropdown({
	["Name"] = "Sort",
	["List"] = {"Alphabetical", "Length"},
	["Function"] = function(val)
		sortingmethod = val
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
TextGui.CreateDropdown({
	["Name"] = "Font",
	["List"] = fontitems,
	["Function"] = function(val)
		onetext.Font = Enum.Font[val]
		onetext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
TextGui.CreateDropdown({
	["Name"] = "CustomTextFont",
	["List"] = fontitems2,
	["Function"] = function(val)
		onecustomtext.Font = Enum.Font[val]
		onecustomtext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
textguiscaleslider = TextGui.CreateSlider({
	["Name"] = "Scale",
	["Min"] = 1,
	["Max"] = 50,
	["Default"] = 10,
	["Function"] = function(val)
		onescale.Scale = val / 10
	end
})
TextGui.CreateToggle({
	["Name"] = "Shadow", 
	["Function"] = function(callback) onetext2.Visible = callback onething3.Visible = callback end,
	["HoverText"] = "Renders shadowed text."
})
TextGui.CreateToggle({
	["Name"] = "Watermark", 
	["Function"] = function(callback) 
		onething.Visible = callback
		UpdateHud()
	end,
	["HoverText"] = "Renders a vape watermark"
})
textguirenderbkg = TextGui.CreateToggle({
	["Name"] = "Render background", 
	["Function"] = function(callback)
		onebackground.Visible = callback
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Hide Modules",
	["Function"] = function(callback) 
		if TextGuiCircleObject["Object"] then
			TextGuiCircleObject["Object"].Visible = callback
		end
	end
})
TextGuiCircleObject = TextGui.CreateCircleWindow({
	["Name"] = "Blacklist",
	["Type"] = "Blacklist",
	["UpdateFunction"] = function()
		UpdateHud()
	end
})
TextGuiCircleObject["Object"].Visible = false
local textguigradient = TextGui.CreateToggle({
	["Name"] = "Gradient Logo",
	["Function"] = function() 
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Alternate Text",
	["Function"] = function() 
		UpdateHud()
	end
})
local CustomText = {["Value"] = "", ["Object"] = nil}
TextGui.CreateToggle({
	["Name"] = "Add custom text", 
	["Function"] = function(callback) 
		onecustomtext.Visible = callback
		if CustomText["Object"] then 
			CustomText["Object"].Visible = callback
		end
		GuiLibrary["UpdateHudEvent"]:Fire()
	end,
	["HoverText"] = "Renders a custom label"
})
CustomText = TextGui.CreateTextBox({
	["Name"] = "Custom text",
	["FocusLost"] = function(enter)
		onecustomtext.Text = CustomText["Value"]
		onecustomtext2.Text = CustomText["Value"]
	end
})
CustomText["Object"].Visible = false

local healthColorToPosition = {
	[0.01] = Color3.fromRGB(255, 28, 0);
	[0.5] = Color3.fromRGB(250, 235, 0);
	[0.99] = Color3.fromRGB(27, 252, 107);
}

local function HealthbarColorTransferFunction(healthPercent)
	healthPercent = math.clamp(healthPercent, 0.01, 0.99)
	local lastcolor = Color3.new(1, 1, 1)
	for samplePoint, colorSampleValue in pairs(healthColorToPosition) do
		local distance = (healthPercent / samplePoint)
		if distance == 1 then
			return colorSampleValue
		elseif distance < 1 then 
			return lastcolor:lerp(colorSampleValue, distance)
		else
			lastcolor = colorSampleValue
		end
	end
	return lastcolor
end
local TextGui = GuiLibrary.CreateCustomWindow({
	["Name"] = "Logo", 
	["Icon"] = "vape/assets/TextGUIIcon1.png", 
	["IconSize"] = 21
})
local TextGuiCircleObject = {["CircleList"] = {}}
GUI.CreateCustomToggle({
	["Name"] = "Logo", 
	["Icon"] = "vape/assets/TextGUIIcon3.png",
	["Function"] = function(callback) TextGui.SetVisible(callback) end,
	["Priority"] = 2
})	

local rainbowval = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local rainbowval2 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0.42)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 0.42))})
local rainbowval3 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local guicolorslider = {["RainbowValue"] = false}
local textguiscaleslider = {["Value"] = 10}
local textguimode = {["Value"] = "Normal"}
local fontitems = {"SourceSans"}
local fontitems2 = {"GothamBold"}
local textguiframe = Instance.new("Frame")
textguiframe.BackgroundTransparency = 1
textguiframe.Size = UDim2.new(1, 0, 1, 0)
textguiframe.Parent = TextGui.GetCustomChildren()
local onething = Instance.new("ImageLabel")
onething.Parent = textguiframe
onething.Name = "Logo"
onething.Size = UDim2.new(0, 100, 0, 27)
onething.Position = UDim2.new(1, -140, 0, 3)
onething.BackgroundColor3 = Color3.new(0, 0, 0)
onething.BorderSizePixel = 0
onething.BackgroundTransparency = 1
onething.Visible = false
onething.Image = getcustomassetfunc(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
local onething2 = Instance.new("ImageLabel")
onething2.Parent = onething
onething2.Size = UDim2.new(0, 41, 0, 24)
onething2.Name = "Logo2"
onething2.Position = UDim2.new(1, 0, 0, 1)
onething2.BorderSizePixel = 0
onething2.BackgroundColor3 = Color3.new(0, 0, 0)
onething2.BackgroundTransparency = 1
onething2.Image = getcustomassetfunc("vape/assets/VapeLogo4.png")
local onething3 = onething:Clone()
onething3.ImageColor3 = Color3.new(0, 0, 0)
onething3.ImageTransparency = 0.5
onething3.ZIndex = 0
onething3.Position = UDim2.new(0, 1, 0, 1)
onething3.Visible = false
onething3.Parent = onething
onething3.Logo2.ImageColor3 = Color3.new(0, 0, 0)
onething3.Logo2.ZIndex = 0
onething3.Logo2.ImageTransparency = 0.5
local onethinggrad = Instance.new("UIGradient")
onethinggrad.Rotation = 90
onethinggrad.Parent = onething
local onethinggrad2 = Instance.new("UIGradient")
onethinggrad2.Rotation = 90
onethinggrad2.Parent = onething2
local onetext = Instance.new("TextLabel")
onetext.Parent = textguiframe
onetext.Size = UDim2.new(1, 0, 1, 0)
onetext.Position = UDim2.new(1, -154, 0, 35)
onetext.TextColor3 = Color3.new(1, 1, 1)
onetext.RichText = true
onetext.BackgroundTransparency = 1
onetext.TextXAlignment = Enum.TextXAlignment.Left
onetext.TextYAlignment = Enum.TextYAlignment.Top
onetext.BorderSizePixel = 0
onetext.BackgroundColor3 = Color3.new(0, 0, 0)
onetext.Font = Enum.Font.SourceSans
onetext.Text = ""
onetext.TextSize = 23
local onetext2 = Instance.new("TextLabel")
onetext2.Name = "ExtraText"
onetext2.Parent = onetext
onetext2.Size = UDim2.new(1, 0, 1, 0)
onetext2.Position = UDim2.new(0, 1, 0, 1)
onetext2.BorderSizePixel = 0
onetext2.Visible = false
onetext2.ZIndex = 0
onetext2.Text = ""
onetext2.BackgroundTransparency = 1
onetext2.TextTransparency = 0.5
onetext2.TextXAlignment = Enum.TextXAlignment.Left
onetext2.TextYAlignment = Enum.TextYAlignment.Top
onetext2.TextColor3 = Color3.new(0, 0, 0)
onetext2.Font = Enum.Font.SourceSans
onetext2.TextSize = 23
local onecustomtext = Instance.new("TextLabel")
onecustomtext.TextSize = 30
onecustomtext.Font = Enum.Font.GothamBold
onecustomtext.Size = UDim2.new(1, 0, 1, 0)
onecustomtext.BackgroundTransparency = 1
onecustomtext.Position = UDim2.new(0, 0, 0, 35)
onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
onecustomtext.TextYAlignment = Enum.TextYAlignment.Top
onecustomtext.Text = ""
onecustomtext.Parent = textguiframe
local onecustomtext2 = onecustomtext:Clone()
onecustomtext2.ZIndex = -1
onecustomtext2.Size = UDim2.new(1, 0, 1, 0)
onecustomtext2.TextTransparency = 0.5
onecustomtext2.TextColor3 = Color3.new(0, 0, 0)
onecustomtext2.Position = UDim2.new(0, 1, 0, 1)
onecustomtext2.Parent = onecustomtext
onecustomtext:GetPropertyChangedSignal("TextXAlignment"):Connect(function()
	onecustomtext2.TextXAlignment = onecustomtext.TextXAlignment
end)
local onebackground = Instance.new("Frame")
onebackground.BackgroundTransparency = 1
onebackground.BorderSizePixel = 0
onebackground.BackgroundColor3 = Color3.new(0, 0, 0)
onebackground.Size = UDim2.new(1, 0, 1, 0)
onebackground.Visible = false 
onebackground.Parent = textguiframe
onebackground.ZIndex = 0
local onebackgroundsort = Instance.new("UIListLayout")
onebackgroundsort.FillDirection = Enum.FillDirection.Vertical
onebackgroundsort.SortOrder = Enum.SortOrder.LayoutOrder
onebackgroundsort.Padding = UDim.new(0, 0)
onebackgroundsort.Parent = onebackground
local onescale = Instance.new("UIScale")
onescale.Parent = textguiframe
local textguirenderbkg = {["Enabled"] = false}
local textguimodeconnections = {}
local textguimodeobjects = {Logo = {}, Labels = {}, ShadowLabels = {}, Backgrounds = {}}
local function refreshbars(textlists)
	for i,v in pairs(onebackground:GetChildren()) do
		if v:IsA("Frame") then
			v:Remove()
		end
	end
	for i2,v2 in pairs(textlists) do
		local newstr = v2:gsub(":", " ")
		local textsize = game:GetService("TextService"):GetTextSize(newstr, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		local frame = Instance.new("Frame")
		frame.BorderSizePixel = 0
		frame.BackgroundTransparency = 0.62
		frame.BackgroundColor3 = Color3.new(0,0,0)
		frame.Visible = true
		frame.ZIndex = 0
		frame.LayoutOrder = i2
		frame.Size = UDim2.new(0, textsize.X + 8, 0, textsize.Y)
		frame.Parent = onebackground
		local colorframe = Instance.new("Frame")
		colorframe.Size = UDim2.new(0, 2, 1, 0)
		colorframe.Position = (onebackgroundsort.HorizontalAlignment == Enum.HorizontalAlignment.Left and UDim2.new(0, 0, 0, 0) or UDim2.new(1, -2, 0, 0))
		colorframe.BorderSizePixel = 0
		colorframe.Name = "ColorFrame"
		colorframe.Parent = frame
		local extraframe = Instance.new("Frame")
		extraframe.BorderSizePixel = 0
		extraframe.BackgroundTransparency = 0.96
		extraframe.BackgroundColor3 = Color3.new(0, 0, 0)
		extraframe.ZIndex = 0
		extraframe.Size = UDim2.new(1, 0, 0, 2)
		extraframe.Position = UDim2.new(0, 0, 1, -1)
		extraframe.Parent = frame
	end
end

onething.Visible = true onetext.Position = UDim2.new(0, 0, 0, 41)

local sortingmethod = "Alphabetical"
local textwithoutthing = ""
local function getSpaces(str)
		local strSize = game:GetService("TextService"):GetTextSize(str, onetext.TextSize, onetext.TextSize, Vector2.new(10000, 10000))
		return math.ceil(strSize.X / 3)
end
local function UpdateHud()
	local scaledgui = GuiLibrary["MainGui"]:FindFirstChild("ScaledGui")
	if scaledgui and scaledgui.Visible then
		local text = ""
		local text2 = ""
		local tableofmodules = {}
		local first = true
		

		local textlists = {}
		for i2,v2 in pairs(tableofmodules) do
			if first then
				text = (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
				first = false
			else
				text = text..'\n'..(translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
			end
			table.insert(textlists, (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or ""))
		end
		textwithoutthing = text
		onetext.Text = text
		onetext2.Text = text:gsub(":", " ")
		local newsize = game:GetService("TextService"):GetTextSize(text, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		if text == "" then
			newsize = Vector2.new(0, 0)
		end
		onetext.Size = UDim2.new(0, 154, 0, newsize.Y)
		if TextGui.GetCustomChildren().Parent then
			if (TextGui.GetCustomChildren().Parent.Position.X.Offset + TextGui.GetCustomChildren().Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2) then
				onetext.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.Position = UDim2.new(0, 1, 0, 1)
				onething.Position = UDim2.new(1, -142, 0, 8)
				onetext.Position = UDim2.new(1, -154, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.Position = UDim2.new(0, 0, 0, onething.Visible and 35 or 0)
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Right
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Right
				onebackground.Position = onetext.Position + UDim2.new(0, -60, 0, 2)
			else
				onetext.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.Position = UDim2.new(0, 5, 0, 1)
				onething.Position = UDim2.new(0, 2, 0, 8)
				onetext.Position = UDim2.new(0, 6, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Left
				onebackground.Position = onetext.Position + UDim2.new(0, -1, 0, 2)
			end
		end

		if textguimode["Value"] == "Drawing" then 
			for i,v in pairs(textguimodeobjects.Labels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.Labels[i] = nil
			end
			for i,v in pairs(textguimodeobjects.ShadowLabels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.ShadowLabels[i] = nil
			end
			for i,v in pairs(textlists) do 
				local textdraw = Drawing.new("Text")
				textdraw.Text = v:gsub(":", " ")
				textdraw.Size = 23 * onescale.Scale
				textdraw.ZIndex = 2
				textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				textdraw.Visible = true
				local textdraw2 = Drawing.new("Text")
				textdraw2.Text = textdraw.Text
				textdraw2.Size = 23 * onescale.Scale
				textdraw2.Position = textdraw.Position + Vector2.new(1, 1)
				textdraw2.Color = Color3.new(0, 0, 0)
				textdraw2.Transparency = 0.5
				textdraw2.Visible = onetext2.Visible
				table.insert(textguimodeobjects.Labels, textdraw)
				table.insert(textguimodeobjects.ShadowLabels, textdraw2)
			end
		end
		refreshbars(textlists)
		GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
	end
end

TextGui.GetCustomChildren().Parent:GetPropertyChangedSignal("Position"):Connect(UpdateHud)
onescale:GetPropertyChangedSignal("Scale"):Connect(function()
	local childrenobj = TextGui.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(onescale.Scale - 1) or 0), (check and 0 or -6 * (onescale.Scale - 1)), 1, -6 * (onescale.Scale - 1))
	UpdateHud()
end)
GuiLibrary["UpdateHudEvent"].Event:Connect(UpdateHud)
for i,v in pairs(Enum.Font:GetEnumItems()) do 
	if v ~= "SourceSans" then
		table.insert(fontitems, v.Name)
	end
	if v ~= "GothamBold" then
		table.insert(fontitems2, v.Name)
	end
end
textguimode = TextGui.CreateDropdown({
	["Name"] = "Mode",
	["List"] = {"Normal", "Drawing"},
	["Function"] = function(val)
		textguiframe.Visible = val == "Normal"
		for i,v in pairs(textguimodeconnections) do 
			v:Disconnect()
		end
		for i,v in pairs(textguimodeobjects) do 
			for i2,v2 in pairs(v) do 
				v2.Visible = false
				v2:Remove()
				v[i2] = nil
			end
		end
		if val == "Drawing" then
			local onethingdrawing = Drawing.new("Image")
			onethingdrawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onethingdrawing.Size = onething.AbsoluteSize
			onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
			onethingdrawing.ZIndex = 2
			onethingdrawing.Visible = onething.Visible
			local onething2drawing = Drawing.new("Image")
			onething2drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething2drawing.Size = onething2.AbsoluteSize
			onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
			onething2drawing.ZIndex = 2
			onething2drawing.Visible = onething.Visible
			local onething3drawing = Drawing.new("Image")
			onething3drawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onething3drawing.Size = onething.AbsoluteSize
			onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			onething3drawing.Transparency = 0.5
			onething3drawing.Visible = onething.Visible and onething3.Visible
			local onething4drawing = Drawing.new("Image")
			onething4drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething4drawing.Size = onething2.AbsoluteSize
			onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			onething4drawing.Transparency = 0.5
			onething4drawing.Visible = onething.Visible and onething3.Visible
			local onecustomdrawtext = Drawing.new("Text")
			onecustomdrawtext.Size = 30
			onecustomdrawtext.Text = onecustomtext.Text
			onecustomdrawtext.Color = onecustomtext.TextColor3
			onecustomdrawtext.ZIndex = 2
			onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
			onecustomdrawtext.Visible = onecustomtext.Visible
			local onecustomdrawtext2 = Drawing.new("Text")
			onecustomdrawtext2.Size = 30
			onecustomdrawtext2.Text = onecustomtext.Text
			onecustomdrawtext2.Transparency = 0.5
			onecustomdrawtext2.Color = Color3.new(0, 0, 0)
			onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			pcall(function()
				onething3drawing.Color = Color3.new(0, 0, 0)
				onething4drawing.Color = Color3.new(0, 0, 0)
				onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
			end)
			table.insert(textguimodeobjects.Logo, onethingdrawing)
			table.insert(textguimodeobjects.Logo, onething2drawing)
			table.insert(textguimodeobjects.Logo, onething3drawing)
			table.insert(textguimodeobjects.Logo, onething4drawing)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext2)
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
				onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onethingdrawing.Size = onething.AbsoluteSize
				onething3drawing.Size = onething.AbsoluteSize
				onecustomdrawtext.Size = 30 * onescale.Scale
				onecustomdrawtext2.Size = 30 * onescale.Scale
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
				onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onething2drawing.Size = onething2.AbsoluteSize
				onething4drawing.Size = onething2.AbsoluteSize
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onething3:GetPropertyChangedSignal("Visible"):Connect(function()
				onething3drawing.Visible = onething3.Visible
				onething4drawing.Visible = onething3.Visible
			end))
			table.insert(textguimodeconnections, onetext2:GetPropertyChangedSignal("Visible"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Visible = onetext2.Visible
				end
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("Visible"):Connect(function()
				onethingdrawing.Visible = onething.Visible
				onething2drawing.Visible = onething.Visible
				onething3drawing.Visible = onething.Visible and onetext2.Visible
				onething4drawing.Visible = onething.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Visible"):Connect(function()
				onecustomdrawtext.Visible = onecustomtext.Visible
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Text"):Connect(function()
				onecustomdrawtext.Text = onecustomtext.Text
				onecustomdrawtext2.Text = onecustomtext.Text
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("TextColor3"):Connect(function()
				onecustomdrawtext.Color = onecustomtext.TextColor3
			end))
			table.insert(textguimodeconnections, onetext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.Labels) do 
					textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				end
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Position = Vector2.new(1, 1) + (onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6))
				end
			end))
			table.insert(textguimodeconnections, onethinggrad:GetPropertyChangedSignal("Color"):Connect(function()
				pcall(function()
					onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
				end)
			end))
		end
	end
})
TextGui.CreateDropdown({
	["Name"] = "Sort",
	["List"] = {"Alphabetical", "Length"},
	["Function"] = function(val)
		sortingmethod = val
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})

TextGui.CreateDropdown({
	["Name"] = "CustomTextFont",
	["List"] = fontitems2,
	["Function"] = function(val)
		onecustomtext.Font = Enum.Font[val]
		onecustomtext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
textguiscaleslider = TextGui.CreateSlider({
	["Name"] = "Scale",
	["Min"] = 1,
	["Max"] = 50,
	["Default"] = 10,
	["Function"] = function(val)
		onescale.Scale = val / 10
	end
})
TextGui.CreateToggle({
	["Name"] = "Shadow", 
	["Function"] = function(callback) onetext2.Visible = callback onething3.Visible = callback end,
	["HoverText"] = "Renders shadowed text."
})
TextGui.CreateToggle({
	["Name"] = "Watermark", 
	["Function"] = function(callback) 
		onething.Visible = callback
		UpdateHud()
	end,
	["HoverText"] = "Renders a vape watermark"
})
textguirenderbkg = TextGui.CreateToggle({
	["Name"] = "Render background", 
	["Function"] = function(callback)
		onebackground.Visible = callback
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Hide Modules",
	["Function"] = function(callback) 
		if TextGuiCircleObject["Object"] then
			TextGuiCircleObject["Object"].Visible = callback
		end
	end
})
TextGuiCircleObject = TextGui.CreateCircleWindow({
	["Name"] = "Blacklist",
	["Type"] = "Blacklist",
	["UpdateFunction"] = function()
		UpdateHud()
	end
})
TextGuiCircleObject["Object"].Visible = false
local textguigradient = TextGui.CreateToggle({
	["Name"] = "Gradient Logo",
	["Function"] = function() 
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Alternate Text",
	["Function"] = function() 
		UpdateHud()
	end
})
local CustomText = {["Value"] = "", ["Object"] = nil}
TextGui.CreateToggle({
	["Name"] = "Add custom text", 
	["Function"] = function(callback) 
		onecustomtext.Visible = callback
		if CustomText["Object"] then 
			CustomText["Object"].Visible = callback
		end
		GuiLibrary["UpdateHudEvent"]:Fire()
	end,
	["HoverText"] = "Renders a custom label"
})
CustomText = TextGui.CreateTextBox({
	["Name"] = "Custom text",
	["FocusLost"] = function(enter)
		onecustomtext.Text = CustomText["Value"]
		onecustomtext2.Text = CustomText["Value"]
	end
})
CustomText["Object"].Visible = false

local healthColorToPosition = {
	[0.01] = Color3.fromRGB(255, 28, 0);
	[0.5] = Color3.fromRGB(250, 235, 0);
	[0.99] = Color3.fromRGB(27, 252, 107);
}

local function HealthbarColorTransferFunction(healthPercent)
	healthPercent = math.clamp(healthPercent, 0.01, 0.99)
	local lastcolor = Color3.new(1, 1, 1)
	for samplePoint, colorSampleValue in pairs(healthColorToPosition) do
		local distance = (healthPercent / samplePoint)
		if distance == 1 then
			return colorSampleValue
		elseif distance < 1 then 
			return lastcolor:lerp(colorSampleValue, distance)
		else
			lastcolor = colorSampleValue
		end
	end
	return lastcolor
end

local TargetInfo = GuiLibrary.CreateCustomWindow({
	["Name"] = "Target Info",
	["Icon"] = "vape/assets/TargetInfoIcon1.png",
	["IconSize"] = 16
})
local TargetInfoDisplayNames = TargetInfo.CreateToggle({
	["Name"] = "Use Display Name",
	["Function"] = function() end,
	["Default"] = true
})
local TargetInfoBackground = {["Enabled"] = false}
local targetinfobkg1 = Instance.new("Frame")
targetinfobkg1.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
targetinfobkg1.BorderSizePixel = 0
targetinfobkg1.BackgroundTransparency = 1
targetinfobkg1.Size = UDim2.new(0, 220, 0, 72)
targetinfobkg1.Position = UDim2.new(0, 0, 0, 5)
targetinfobkg1.Parent = TargetInfo.GetCustomChildren()
local targetinfobkg3 = Instance.new("Frame")
targetinfobkg3.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
targetinfobkg3.Size = UDim2.new(0, 220, 0, 80)
targetinfobkg3.BackgroundTransparency = 0.25
targetinfobkg3.Position = UDim2.new(0, 0, 0, 0)
targetinfobkg3.Name = "MainInfo"
targetinfobkg3.Parent = targetinfobkg1
local targetname = Instance.new("TextLabel")
targetname.TextSize = 17
targetname.Font = Enum.Font.SourceSans
targetname.TextColor3 = Color3.fromRGB(162, 162, 162)
targetname.Position = UDim2.new(0, 72, 0, 7)
targetname.TextStrokeTransparency = 1
targetname.BackgroundTransparency = 1
targetname.Size = UDim2.new(0, 80, 0, 16)
targetname.TextScaled = true
targetname.Text = "Target name"
targetname.ZIndex = 2
targetname.TextXAlignment = Enum.TextXAlignment.Left
targetname.TextYAlignment = Enum.TextYAlignment.Top
targetname.Parent = targetinfobkg3
local targetnameclone = targetname:Clone()
targetnameclone.Size = UDim2.new(1, 0, 1, 0)
targetnameclone.TextTransparency = 0.5
targetnameclone.TextColor3 = Color3.new()
targetnameclone.ZIndex = 1
targetnameclone.Position = UDim2.new(0, 1, 0, 1)
targetname:GetPropertyChangedSignal("Text"):Connect(function()
	targetnameclone.Text = targetname.Text
end)
targetnameclone.Parent = targetname
local targethealthbkg = Instance.new("Frame")
targethealthbkg.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
targethealthbkg.Size = UDim2.new(0, 138, 0, 4)
targethealthbkg.Position = UDim2.new(0, 72, 0, 29)
targethealthbkg.Parent = targetinfobkg3
local healthbarbkgshadow = Instance.new("ImageLabel")
healthbarbkgshadow.AnchorPoint = Vector2.new(0.5, 0.5)
healthbarbkgshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
healthbarbkgshadow.Image = getcustomassetfunc("vape/assets/WindowBlur.png")
healthbarbkgshadow.BackgroundTransparency = 1
healthbarbkgshadow.ImageTransparency = 0.6
healthbarbkgshadow.ZIndex = -1
healthbarbkgshadow.Size = UDim2.new(1, 6, 1, 6)
healthbarbkgshadow.ImageColor3 = Color3.new(0, 0, 0)
healthbarbkgshadow.ScaleType = Enum.ScaleType.Slice
healthbarbkgshadow.SliceCenter = Rect.new(10, 10, 118, 118)
healthbarbkgshadow.Parent = targethealthbkg
local targethealthgreen = Instance.new("Frame")
targethealthgreen.BackgroundColor3 = Color3.fromRGB(40, 137, 109)
targethealthgreen.Size = UDim2.new(1, 0, 1, 0)
targethealthgreen.ZIndex = 3
targethealthgreen.BorderSizePixel = 0
targethealthgreen.Parent = targethealthbkg
local targethealthyellow = Instance.new("Frame")
targethealthyellow.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
targethealthyellow.Size = UDim2.new(0, 0, 1, 0)
targethealthyellow.ZIndex = 4
targethealthyellow.BorderSizePixel = 0
targethealthyellow.AnchorPoint = Vector2.new(1, 0)
targethealthyellow.Position = UDim2.new(1, 0, 0, 0)
targethealthyellow.Parent = targethealthgreen
local targetimage = Instance.new("ImageLabel")
targetimage.Size = UDim2.new(0, 61, 0, 61)
targetimage.BackgroundTransparency = 1
targetimage.Image = 'rbxthumb://type=AvatarHeadShot&id='..game:GetService("Players").LocalPlayer.UserId..'&w=420&h=420'
targetimage.Position = UDim2.new(0, 5, 0, 10)
targetimage.Parent = targetinfobkg3
local round2 = Instance.new("UICorner")
round2.CornerRadius = UDim.new(0, 4)
round2.Parent = targetinfobkg3
local round3 = Instance.new("UICorner")
round3.CornerRadius = UDim.new(0, 2048)
round3.Parent = targethealthbkg
local round4 = Instance.new("UICorner")
round4.CornerRadius = UDim.new(0, 2048)
round4.Parent = targethealthgreen
local round42 = Instance.new("UICorner")
round42.CornerRadius = UDim.new(0, 2048)
round42.Parent = targethealthyellow
local round5 = Instance.new("UICorner")
round5.CornerRadius = UDim.new(0, 4)
round5.Parent = targetimage
TargetInfoBackground = TargetInfo.CreateToggle({
	["Name"] = "Use Background",
	["Function"] = function(callback) 
		targetinfobkg3.BackgroundTransparency = callback and 0.25 or 1
		targetname.TextColor3 = callback and Color3.fromRGB(162, 162, 162) or Color3.new(1, 1, 1)
		targetname.Size = UDim2.new(0, 80, 0, callback and 16 or 18)
		targethealthbkg.Size = UDim2.new(0, 138, 0, callback and 4 or 7)
	end,
	["Default"] = true
})
local oldhealth = 100
local allowedtween = true
local healthtween
TargetInfo.GetCustomChildren().Parent:GetPropertyChangedSignal("Size"):Connect(function()
	if TargetInfo.GetCustomChildren().Parent.Size ~= UDim2.new(0, 220, 0, 0) then
		targetinfobkg3.Position = UDim2.new(0, 0, 0, -5)
	else
		targetinfobkg3.Position = UDim2.new(0, 0, 0, 40)
	end
end)
shared.VapeTargetInfo = {
	["UpdateInfo"] = function(tab, targetsize)
		if TargetInfo.GetCustomChildren().Parent then
			targetinfobkg3.Visible = (targetsize > 0) or (TargetInfo.GetCustomChildren().Parent.Size ~= UDim2.new(0, 220, 0, 0))
			for i,v in pairs(tab) do
				local plr = game:GetService("Players"):FindFirstChild(i)
				targetimage.Image = 'rbxthumb://type=AvatarHeadShot&id='..v["UserId"]..'&w=420&h=420'
				targethealthgreen:TweenSize(UDim2.new(math.clamp(v["Health"] / v["MaxHealth"], 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
				targethealthyellow:TweenSize(UDim2.new(math.clamp((v["Health"] / v["MaxHealth"]) - 1, 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
				if healthtween then healthtween:Cancel() end
				healthtween = game:GetService("TweenService"):Create(targethealthgreen, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = HealthbarColorTransferFunction(v["Health"] / v["MaxHealth"])})
				healthtween:Play()
				targetname.Text = (TargetInfoDisplayNames["Enabled"] and plr and plr.DisplayName or i)
			end
		end
	end,
	["Object"] = TargetInfo
}
GUI.CreateCustomToggle({
	["Name"] = "Target Info", 
	["Icon"] = "vape/assets/TargetInfoIcon2.png", 
	["Function"] = function(callback) TargetInfo.SetVisible(callback) end,
	["Priority"] = 1
})
local GeneralSettings = GUI.CreateDivider2("General Settings")
local ModuleSettings = GUI.CreateDivider2("Module Settings")
local GUISettings = GUI.CreateDivider2("GUI Settings")
local teamsbycolor = {Enabled = false}
teamsbycolor = ModuleSettings.CreateToggle({
	["Name"] = "Teams by color", 
	["Function"] = function() if teamsbycolor.Refresh then teamsbycolor.Refresh:Fire() end end,
	["Default"] = true,
	["HoverText"] = "Ignore players on your team designated by the game"
})
teamsbycolor.Refresh = Instance.new("BindableEvent")
local MiddleClickInput
ModuleSettings.CreateToggle({
	["Name"] = "MiddleClick friends", 
	["Function"] = function(callback) 
		if callback then
			MiddleClickInput = game:GetService("UserInputService").InputBegan:Connect(function(input1)
				if input1.UserInputType == Enum.UserInputType.MouseButton3 then
					local ent = shared.vapeentity
					if ent then 
						local rayparams = RaycastParams.new()
						rayparams.FilterType = Enum.RaycastFilterType.Whitelist
						local chars = {}
						for i,v in pairs(ent.entityList) do 
							table.insert(chars, v.Character)
						end
						rayparams.FilterDescendantsInstances = chars
						local mouseunit = game:GetService("Players").LocalPlayer:GetMouse().UnitRay
						local ray = workspace:Raycast(mouseunit.Origin, mouseunit.Direction * 10000, rayparams)
						if ray then 
							for i,v in pairs(ent.entityList) do 
								if ray.Instance:IsDescendantOf(v.Character) then 
									local found = table.find(FriendsTextList["ObjectList"], v.Player.Name)
									if not found then
										table.insert(FriendsTextList["ObjectList"], v.Player.Name)
										table.insert(FriendsTextList["ObjectListEnabled"], true)
										FriendsTextList["RefreshValues"](FriendsTextList["ObjectList"])
									else
										table.remove(FriendsTextList["ObjectList"], found)
										table.remove(FriendsTextList["ObjectListEnabled"], found)
										FriendsTextList["RefreshValues"](FriendsTextList["ObjectList"])
									end
									break
								end
							end
						end
					end
				end
			end)
		else
			if MiddleClickInput then
				MiddleClickInput:Disconnect()
			end
		end
	end,
	["HoverText"] = "Click middle mouse button to add the player you are hovering over as a friend"
})
ModuleSettings.CreateToggle({
	["Name"] = "Lobby Check",
	["Function"] = function() end,
	["Default"] = true,
	["HoverText"] = "Temporarily disables certain features in server lobbies."
})
guicolorslider = GUI.CreateColorSlider("GUI Theme", function(h, s, v) 
	GuiLibrary["UpdateUI"](h, s, v) 
end)
local blatantmode = GUI.CreateToggle({
	["Name"] = "Blatant mode",
	["Function"] = function() end,
	["HoverText"] = "Required for certain features."
})
local tabsortorder = {
	["CombatButton"] = 1,
	["BlatantButton"] = 2,
	["PrivateButton"] = 3,
	["RenderButton"] = 4,
	["UtilityButton"] = 5,
	["WorldButton"] = 6,
	["FriendsButton"] = 7,
	["ProfilesButton"] = 8
}

local tabsortorder2 = {
	[1] = "Combat",
	[2] = "Blatant",
	[3] = "Private",
	[4] = "Render",
	[5] = "Utility",
	[6] = "World"
}

local function getSaturation(val)
	local sat = 0.9
	if val < 0.03 then 
		sat = 0.75 + (0.15 * math.clamp(val / 0.03, 0, 1))
	end
	if val > 0.59 then 
		sat = 0.9 - (0.4 * math.clamp((val - 0.59) / 0.07, 0, 1))
	end
	if val > 0.68 then 
		sat = 0.5 + (0.4 * math.clamp((val - 0.68) / 0.14, 0, 1))
	end
	if val > 0.89 then 
		sat = 0.9 - (0.15 * math.clamp((val - 0.89) / 0.1, 0, 1))
	end
	return sat
end

GuiLibrary["UpdateUI"] = function(h, s, val, bypass)
	pcall(function()
		local rainbowcheck = GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"]
		local maincolor = rainbowcheck and getSaturation(h) or s
		GuiLibrary["ObjectsThatCanBeSaved"]["GUIWindow"]["Object"].Logo1.Logo2.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
		local rainbowcolor2 = h + (rainbowcheck and (-0.05) or 0)
		rainbowcolor2 = rainbowcolor2 % 1
        local gradsat = textguigradient["Enabled"] and getSaturation(rainbowcolor2) or maincolor
		onetext.TextColor3 = Color3.fromHSV(textguigradient["Enabled"] and rainbowcolor2 or h, maincolor, rainbowcheck and 1 or val)
		onethinggrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)),
			ColorSequenceKeypoint.new(1, onetext.TextColor3)
		})
		onethinggrad2.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(h, textguigradient["Enabled"] and rainbowcheck and maincolor or 0, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(textguigradient["Enabled"] and rainbowcolor2 or h, textguigradient["Enabled"] and rainbowcheck and maincolor or 0, 1))
		})
		onecustomtext.TextColor3 = onetext.TextColor3
		local newtext = ""
		local newfirst = false
		local colorforindex = {}
		for i2,v2 in pairs(textwithoutthing:split("\n")) do
			local rainbowcolor = h + (rainbowcheck and (-0.025 * (i2 + (textguigradient["Enabled"] and 2 or 0))) or 0)
			rainbowcolor = rainbowcolor % 1
			local newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
			local splittext = v2:split(":")
			splittext = #splittext > 1 and {splittext[1], " "..splittext[2]} or {v2, ""}
			newtext = newtext..(newfirst and "\n" or " ")..'<font color="rgb('..math.floor(newcolor.R * 255)..","..math.floor(newcolor.G * 255)..","..math.floor(newcolor.B * 255)..')">'..splittext[1]..'</font><font color="rgb(170, 170, 170)">'..splittext[2]..'</font>'
			newfirst = true
			colorforindex[i2] = newcolor
		end
		if textguimode["Value"] == "Drawing" then 
			for i,v in pairs(textguimodeobjects.Labels) do 
				if colorforindex[i] then 
					v.Color = colorforindex[i]
				end
			end
		end
		if onebackground then
			for i3,v3 in pairs(onebackground:GetChildren()) do
				if v3:IsA("Frame") and colorforindex[v3.LayoutOrder] then
					v3.ColorFrame.BackgroundColor3 = colorforindex[v3.LayoutOrder]
				end
			end
		end
		onetext.Text = newtext
		if (not GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible) and (not bypass) then return end
		local buttons = 0
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			if v["Type"] == "TargetFrame" then
				if v["Object2"].Visible then
					v["Object"].TextButton.Frame.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				end
			end
			if v["Type"] == "TargetButton" then
				if v["Api"]["Enabled"] then
					v["Object"].BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				end
			end
			if v["Type"] == "CircleListFrame" then
				if v["Object2"].Visible then
					v["Object"].TextButton.Frame.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				end
			end
			if (v["Type"] == "Button" or v["Type"] == "ButtonMain") and v["Api"]["Enabled"] then
				buttons = buttons + 1
				local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * tabsortorder[i]) or 0)
				rainbowcolor = rainbowcolor % 1
				local newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
				v["Object"].ButtonText.TextColor3 = newcolor
				if v["Object"]:FindFirstChild("ButtonIcon") then
					v["Object"].ButtonIcon.ImageColor3 = newcolor
				end
			end
			if v["Type"] == "OptionsButton" then
				if v["Api"]["Enabled"] then
					local newcolor = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
					if (not oldrainbow) then
						local rainbowcolor2 = table.find(tabsortorder2, v["Object"].Parent.Parent.Name)
						rainbowcolor2 = rainbowcolor2 and (rainbowcolor2 - 1) > 0 and GuiLibrary["ObjectsThatCanBeSaved"][tabsortorder2[rainbowcolor2 - 1].."Window"]["SortOrder"] or 0
						local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * (rainbowcolor2 + v["SortOrder"])) or 0)
						rainbowcolor = rainbowcolor % 1
						newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
					end
					v["Object"].BackgroundColor3 = newcolor
				end
			end
			if v["Type"] == "ExtrasButton" then
				if v["Api"]["Enabled"] then
					local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * buttons) or 0)
					rainbowcolor = rainbowcolor % 1
					local newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
					v["Object"].ImageColor3 = newcolor
				end
			end
			if (v["Type"] == "Toggle" or v["Type"] == "ToggleMain") and v["Api"]["Enabled"] then
					v["Object"].ToggleFrame1.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
			end
			if v["Type"] == "Slider" or v["Type"] == "SliderMain" then
				v["Object"].Slider.FillSlider.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				v["Object"].Slider.FillSlider.ButtonSlider.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
			end
			if v["Type"] == "TwoSlider" then
				v["Object"].Slider.FillSlider.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				v["Object"].Slider.ButtonSlider.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				v["Object"].Slider.ButtonSlider2.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
			end
		end
		local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * buttons) or 0)
		rainbowcolor = rainbowcolor % 1
		GuiLibrary["ObjectsThatCanBeSaved"]["GUIWindow"]["Object"].Children.Extras.MainButton.ImageColor3 = (GUI["GetVisibleIcons"]() > 0 and Color3.fromHSV(rainbowcolor, getSaturation(rainbowcolor), 1) or Color3.fromRGB(199, 199, 199))
		for i3, v3 in pairs(ProfilesTextList["ScrollingObject"].ScrollingFrame:GetChildren()) do
		--	pcall(function()
				if v3:IsA("TextButton") and v3.ItemText.Text == GuiLibrary["CurrentProfile"] then
					v3.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
					v3.ImageButton.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
					v3.ItemText.TextColor3 = Color3.new(1, 1, 1)
					v3.ItemText.TextStrokeTransparency = 0.75
				end
		--	end)
		end
	end)
end

GUISettings.CreateToggle({
	["Name"] = "Blur Background", 
	["Function"] = function(callback) 
		GuiLibrary["MainBlur"].Size = (callback and 25 or 0) 
		game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible and callback) 
	end,
	["Default"] = true,
	["HoverText"] = "Blur the background of the GUI"
})
local welcomemsg = GUISettings.CreateToggle({
	["Name"] = "GUI bind indicator", 
	["Function"] = function() end, 
	["Default"] = true,
	["HoverText"] = 'Displays a message indicating your GUI keybind upon injecting.\nI.E "Press RIGHTSHIFT to open GUI"'
})
GUISettings.CreateToggle({
	["Name"] = "Old Rainbow", 
	["Function"] = function(callback) oldrainbow = callback end,
	["HoverText"] = "Reverts to old rainbow"
})
GUISettings.CreateToggle({
	["Name"] = "Show Tooltips", 
	["Function"] = function(callback) GuiLibrary["ToggleTooltips"] = callback end,
	["Default"] = true,
	["HoverText"] = "Toggles visibility of these"
})
local rescale = GUISettings.CreateToggle({
	["Name"] = "Rescale", 
	["Function"] = function(callback) 
		task.spawn(function()
			GuiLibrary["MainRescale"].Scale = (callback and math.clamp(cam.ViewportSize.X / 1920, 0.5, 1) or 0.99)
			task.wait(0.01)
			GuiLibrary["MainRescale"].Scale = (callback and math.clamp(cam.ViewportSize.X / 1920, 0.5, 1) or 1)
		end)
	end,
	["Default"] = true
})
cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	if rescale["Enabled"] then
		GuiLibrary["MainRescale"].Scale = math.clamp(cam.ViewportSize.X / 1920, 0.5, 1)
	end
end)
local ToggleNotifications = {["Object"] = nil}
local Notifications = {}
Notifications = GUISettings.CreateToggle({
	["Name"] = "Notifications", 
	["Function"] = function(callback) 
		GuiLibrary["Notifications"] = callback 
	end,
	["Default"] = true,
	["HoverText"] = "Shows notifications"
})
ToggleNotifications = GUISettings.CreateToggle({
	["Name"] = "Toggle Alert", 
	["Function"] = function(callback) GuiLibrary["ToggleNotifications"] = callback end,
	["Default"] = true,
	["HoverText"] = "Notifies you if a module is enabled/disabled."
})
ToggleNotifications["Object"].BackgroundTransparency = 0
ToggleNotifications["Object"].BorderSizePixel = 0
ToggleNotifications["Object"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GUISettings.CreateSlider({
	["Name"] = "Rainbow Speed",
	["Function"] = function(val)
		GuiLibrary["RainbowSpeed"] = math.clamp((val / 10) - 0.4, 0, 1000000000)
	end,
	["Min"] = 1,
	["Max"] = 100,
	["Default"] = 10
})

local GUIbind = GUI.CreateGUIBind()

local teleported = false
local teleportfunc = game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if (not teleported) and (not shared.VapeIndependent) then
		teleported = true
		local teleportstr = 'shared.VapeSwitchServers = true if shared.VapeDeveloper then loadstring(readfile("vape/NewMainScript.lua"))() else loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))() end'
		if shared.VapeDeveloper then
			teleportstr = 'shared.VapeDeveloper = true '..teleportstr
		end
		if shared.VapePrivate then
			teleportstr = 'shared.VapePrivate = true '..teleportstr
		end
		if shared.VapeCustomProfile then 
			teleportstr = "shared.VapeCustomProfile = '"..shared.VapeCustomProfile.."'"..teleportstr
		end
		GuiLibrary["SaveSettings"]()
		queueteleport(teleportstr)
    end
end)

local savecheck = true
GuiLibrary["SelfDestruct"] = function()
	spawn(function()
		coroutine.close(selfdestructsave)
	end)
	injected = false
	if savecheck then 
		GuiLibrary["SaveSettings"]()
	end
	savecheck = false
	game:GetService("UserInputService").OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
	for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
		if (v["Type"] == "Button" or v["Type"] == "OptionsButton") and v["Api"]["Enabled"] then
			v["Api"]["ToggleButton"](false)
		end
	end
	for i,v in pairs(textguimodeconnections) do 
		v:Disconnect()
	end
	for i,v in pairs(textguimodeobjects) do 
		for i2,v2 in pairs(v) do 
			v2.Visible = false
			v2:Remove()
			v[i2] = nil
		end
	end
	GuiLibrary["SelfDestructEvent"]:Fire()
	shared.VapeExecuted = nil
	shared.VapePrivate = nil
	shared.VapeFullyLoaded = nil
	shared.VapeSwitchServers = nil
	shared.GuiLibrary = nil
	shared.VapeIndependent = nil
	shared.VapeManualLoad = nil
	shared.CustomSaveVape = nil
	GuiLibrary["KeyInputHandler"]:Disconnect()
	GuiLibrary["KeyInputHandler2"]:Disconnect()
	if MiddleClickInput then
		MiddleClickInput:Disconnect()
	end
	teleportfunc:Disconnect()
	GuiLibrary["MainGui"]:Remove()
	game:GetService("RunService"):SetRobloxGuiFocused(false)	
end

GeneralSettings.CreateButton2({
	["Name"] = "RESET CURRENT PROFILE", 
	["Function"] = function()
		local vapeprivate = shared.VapePrivate
		local id = (shared.CustomSaveVape or game.PlaceId)
		GuiLibrary["SelfDestruct"]()
		delfile(customdir.."Profiles/"..(GuiLibrary["CurrentProfile"] == "default" and "" or GuiLibrary["CurrentProfile"])..id..".vapeprofile.txt")
		shared.VapeSwitchServers = true
		shared.VapeOpenGui = true
		shared.VapePrivate = vapeprivate
		loadstring(GetURL("NewMainScript.lua"))()
	end
})
GUISettings.CreateButton2({
	["Name"] = "RESET GUI POSITIONS", 
	["Function"] = function()
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			local obj = GuiLibrary["ObjectsThatCanBeSaved"][i]
			if obj then
				if (v["Type"] == "Window" or v["Type"] == "CustomWindow") then
					v["Object"].Position = (i == "GUIWindow" and UDim2.new(0, 6, 0, 6) or UDim2.new(0, 223, 0, 6))
				end
			end
		end
	end
})
GUISettings.CreateButton2({
	["Name"] = "SORT GUI", 
	["Function"] = function()
		local sorttable = {}
		local movedown = false
		local sortordertable = {
			["GUIWindow"] = 1,
			["CombatWindow"] = 2,
			["BlatantWindow"] = 3,
			["PrivateWindow"] = 4,
			["RenderWindow"] = 5,
			["UtilityWindow"] = 6,
			["WorldWindow"] = 7,
			["FriendsWindow"] = 8,
			["ProfilesWindow"] = 9,
			["Text GUICustomWindow"] = 10,
			["TargetInfoCustomWindow"] = 11,
			["RadarCustomWindow"] = 12,
		}
		local storedpos = {}
		local num = 6
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			local obj = GuiLibrary["ObjectsThatCanBeSaved"][i]
			if obj then
				if v["Type"] == "Window" and v["Object"].Visible then
					local sortordernum = (sortordertable[i] or #sorttable)
					sorttable[sortordernum] = v["Object"]
				end
			end
		end
		for i2,v2 in pairs(sorttable) do
			if num > 1697 then
				movedown = true
				num = 6
			end
			v2.Position = UDim2.new(0, num, 0, (movedown and (storedpos[num] and (storedpos[num] + 9) or 400) or 39))
			if not storedpos[num] then
				storedpos[num] = v2.AbsoluteSize.Y
				if v2.Name == "MainWindow" then
					storedpos[num] = 400
				end
			end
			num = num + 223
		end
	end
})
GeneralSettings.CreateButton2({
	["Name"] = "UNINJECT",
	["Function"] = GuiLibrary["SelfDestruct"]
})
GeneralSettings.CreateButten2({
    ["Name"] = "RESTART"
    ["Function"] = GuiLibrary["SelfDestruct"]; loadstring(game:HttpGet("https://raw.githubusercontent.com/synape/QGZFZGAZGZWUZ/main/NewMainScript.lua", true))()
      })  
if shared.VapeIndependent then
	spawn(function()
		repeat task.wait() until shared.VapeManualLoad
		GuiLibrary["LoadSettings"](shared.VapeCustomProfile)
		if #ProfilesTextList["ObjectList"] == 0 then
			table.insert(ProfilesTextList["ObjectList"], "default")
			ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
		end
		GUIbind["Reload"]()
		GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"], true)
		UpdateHud()
		if not shared.VapeSwitchServers then
			if blatantmode["Enabled"] then
				pcall(function()
					local frame = GuiLibrary["CreateNotification"]("Blatant Enabled", "Vape is now in Blatant Mode.", 5.5, "assets/WarningNotification.png")
					frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
				end)
			end
			GuiLibrary["LoadedAnimation"](welcomemsg["Enabled"])
		else
			shared.VapeSwitchServers = nil
		end
		if shared.VapeOpenGui then
			GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
			game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary["MainBlur"].Size ~= 0) 
			shared.VapeOpenGui = nil
		end

		coroutine.resume(selfdestructsave)
	end)
	shared.VapeFullyLoaded = true
	return GuiLibrary
else
	loadstring(GetURL("AnyGame.lua"))()
	if betterisfile("vape/CustomModules/"..game.PlaceId..".lua") then
		loadstring(readfile("vape/CustomModules/"..game.PlaceId..".lua"))()
	else
		local publicrepo = checkpublicrepo(game.PlaceId)
		if publicrepo then
			loadstring(publicrepo)()
		end
	end
	if shared.VapePrivate then
		if pcall(function() readfile("vapeprivate/CustomModules/"..game.PlaceId..".lua") end) then
			loadstring(readfile("vapeprivate/CustomModules/"..game.PlaceId..".lua"))()
		end	
	end
	GuiLibrary["LoadSettings"](shared.VapeCustomProfile)
	local profiles = {}
	for i,v in pairs(GuiLibrary["Profiles"]) do 
		table.insert(profiles, i)
	end
	table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
	ProfilesTextList["RefreshValues"](profiles)
	GUIbind["Reload"]()
	GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"], true)
	UpdateHud()
	if not shared.VapeSwitchServers then
		if blatantmode["Enabled"] then
			pcall(function()
				local frame = GuiLibrary["CreateNotification"]("Blatant Enabled", "Vape is now in Blatant Mode.", 5.5, "assets/WarningNotification.png")
				frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
			end)
		end
		GuiLibrary["LoadedAnimation"](welcomemsg["Enabled"])
	else
		shared.VapeSwitchServers = nil
	end
	if shared.VapeOpenGui then
		GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
		game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary["MainBlur"].Size ~= 0) 
		shared.VapeOpenGui = nil
	end

	coroutine.resume(selfdestructsave)
	shared.VapeFullyLoaded = true
end

else
game.Players.LocalPlayer:Kick("Your not whitelisted");

([[This file was protected with MoonSec V3 by Federal#9999]]):gsub('.+', (function(a) _vZvSQyMSUOfu = a; end)); CtIIqt_fAj_z_zyp=_ENV;YFqQiCCGPEOvurz='e6<Xx_dEWK=Zyz4RE<4=zRzxyZyXZX=WKzK>dxWdEJE=_z_xx_X=<R<<XP<_RKR=RE4<zEyyZRy_=R=WK_KWW4EHE6dK__ddXzX<<E6=6x6_S=RZRX=RKKW4yZyVZ_d6K=WyExEXdZdK6xX4XRX<4K<x6ER49)Rd=Ezxz<ZyZ6=dKKE_EXdx_WxX_KxyxzXE<z<x6yiyn6Rd4KzRz6zKZZZdZ0K4KXWW4X46zKy6Z<=K=XX<<Z6=mR&xRERRzRzRzzy<ZKZx=6KdWZE4_WEKd4_R<ZX4x<<=<<6<pERy4Rz6y_Z4ZxZyZZ=xKKW4W6d=E9ddddxyxWX=XK<R6_,K*6Rz4Kz4zXydyzyL=E=KK=W<WXEOdE_RxRxxXK<y%d6x6Z8_RKRX46zdyZZ4yXZK=yKWK<WaE_dR_z_<xEX=<6Xx6Z6z4KRKR64EzKy4yX<Z<</xKKK_W6EddZ_4XWXy<X6X4x<W6xyXRRRd4Ezyz6<WXx<x;=KyKXWxEKd4d6Xx_x_6XKX_<66d(ZR4zWRK44zRZxyWy6ZEKR=6WEEyE6y_=y=RZ_W6=KK_dX_r_WxWXK_d<x<dyXy6=Z=bK_WWdxd<_XxEXX_6XZXy<d6y6X8zRZRG4_zWyRyyZd=4=<=dW4W<EEdyd6_d<Z=RE_<y<x6xrKR4R6RE46z=yEZ4Z_=dKZKvWXd=_XxX_Z=RxXXW<z<b6=6Z6+n6RKZ_KRKxy4ZEZK=dKqK6EKEdd4d=6=_Xx_<z<y<x<<yzRERW4Z=<z4W4W6Zy=RKdKWW4XRddE;_^_WX=xAv<<z<;rEhKz_4_4K=WW_ZKEiZ<Kz=XWX_tXKX_<<_RwzHKRd466d6xlyRy4_4z=ZZXydZxdW=1KRdxEREzdXd=_dx,xd dX<<_6z9<RK4446zdyZZ4EN=y=yKxWKE4E6xddE_Z_dXyX=X_4XRR6K2_4R4dzyy4yXZW=ZKyEKWzW6EddZd1__y=K,Ex<=646XFWRzR<4Ezyz6yWy_Z^=_K=WzKXEyE4dZ___dX4XZXX<66W6ZL^R_4=zzyKZ6yzK=KXWzdRdyWWWdxWddx=X6XxX6<x6KU4hXR=R64<zEyyZRyxZR=KKEK1ERExdKz6yEZ==d=kW4646X3dRZR14XZXz6z_ZK=4=XKdWKWzW<EXd__xxExRXKXx<Wz4S4CyRzR6z4z<yEZyZ6=dZXW_y_EyE_dx_Kx4x6<WXZ<<<xyEnXR=4Z48z_<z<E6_6Z=wKEWWEzE<zZz_y6=ZXzXx<_6=oRl<tKRZ4=z=yRy<ZE=yKR_=WzW_E_d=_R_<<KxExXXP6R6RAERyR64xZ=zxzXy_Zd=(=zxKdyExE_d<_K_Xx6Xd<Z646dw4RRRZ4W4yz_zZZzZ<=EK=_R_xxEXRXW<d<X6EAy-jRd4WzRzXyWZZ=y=XyzyyZ_==KRK<dZE4W<xddx_dxEx_x>v=6=6<w4R=4R4xzEZ4z6ZWZ==ZKXKxW6EWEXdF__x=Xz6E<K6=6<2WB=c!4K4Zz6ydZZ=4WzK=KEW6EKEZE6_Z_6xz<dxT<y6dJz6lR_4=zRz<yzyKd4=x=dK6x<WXEZdx_E_RxKxxXW<d<xp4}XRW4Z4K46yWy#yxZ==zKKKXW6E_dK_4_XxWXzX<<E_y6XMRRZRq4_zWz4y4yEZzZ2KyKdWxEKdRd6_dxZX4XRXW<6<rrKR4RX4dZyzdz_yEZW=<=REKW6W<dRdd_Rx4xXXW<Z<z<x6L#=-_4z4yz_y=ZRZ<WWK==<WWXW_EE6d._=xdX=X<<y6=(R&xRERy4dzxKzW4Wx=R=<KWKxW}E_d=_z64_xxZXz<K<66KLER4<K4dzZzPyX=KZ<=W=ExKWxEyExd<6<_4Xzxx4d<Z<<6xn4Rx4E4zzXyEEWyx=Z=ZKxx6dXE=dRdXXzxxXE4K6x4dyWRRqZ=Ey<zdy=yYy<=d=d_<_z_<xEXy_R_=xEXyX6<x<W6966N=4RR<4WzIyZZW=z=<K_W=WZERE=dJ_4_Kx6xZ<K646X#d}V16Rd4E=dKaW_ZxZkd<WZWREzXEd6d<__>yXyX=<Z6R,zJZR_4=zRz<=ZZ4y<KdKzKRKWW#dRdd_z__x_X=<R<<<z 4RRc_4R4WzEyyy6ZxZX==K4KKW<EdE__4_XxWXZ6_Xd<Z6yRxRZRzRdz4yzyxZZZd=XKWWzWk_KdWdK_d/d<xXx<y<46xOKR4R6y=zz46Z<yKZZ=_=ZW4Kx_4EWd_dX_&x=XW<z<<6_;zIZfXRXzy4xyyzKZx=KK4K6EcWEEyE7x=_6xxX_64Xx<E6XQzRZRyydzyyyy6ZEZ_Ez=_K=WzEEdy_R_xxKXyRz<=<d6<sERy4R4=4XyyyEZ=KRZ6=/KrWdEWdzd<__xxrxXWX6<)6_a=RzR<RX4_zzz_ZRZ==EKyK6WxddEEd6d4xR_6xEXsX66W8zq<R_yyRxzdyKzLyxZx=yxREKWyEXdE_R__xEXyX6<xX<<EnEv64R4xzKyyyEy6Zx=d=&WyWXERdZdk__xW<=X4XE<y6Ev_wxR<4K4Ez6ydZZ=4W6KWWzW4WKEEE<XxxRx<XKX<<66d(ZR4Rd4d4d4<yKyjZz=WKzK<W__4dzd4_Z Z<4XdXE<x6Zdx#XRW4z4bz=zZz>y6ZKE__R_xWyE&EZ<E__xyxyX_XE6K<66xRZRz4X4xzWzXZKZEZ<d6WZWyERXdXXXW_WXyX4<KR46PhW4Kz_z6=EyXyXyEZ6KEd=E6WRWE_yd4_d__xzxZRE<=6X6?{=yaz<4xz<zEZZy6=zK4=6_<WZE_dX<__W_dXEX<Xx6=URAxREyz4E4dyZyyyx=ZKZWdKKWvW<x4X4_d_WX4XX<W6Zq666YE=yRxzZy4z<Z=Z4_RKdKWK<E=4Ed<_ExyXRXKX=<R<I6WzxZ4ZXzzzEzdZZZyZxKZ_=WxW_EW<R_d_=xWHXx*<X6_6*iyQ6R<4R=GKEWZW_E4dRdS_dxyxdXyXY<%6EYZRRRE4d4xz<yxz_4<yxz4==WKZRE_=KdRWX_yE=EXd:xE<66}Rx0E6=zZ4E44yEZZZ==WW4ZkW_KyE__dWKd4EQ<y_K_d<x-ZX6<KzzR=zWzEZ6z6zxyEKyEBWXdXKXd4W6dKd=Xy_<6zXW<X6ZzR3_Ry4z4<zEy=Z6yXZ<=<=6W=ERExdEx__zxdXKXK6<<Xvz6=RZRz4Ez4yRyxZK=y=<Kx=6WxERdyd6_dxKRZXx<dXXzE6Ey<R_Ruzzz<yEZ=KyZXKZKWWKW=EEdddyx4xXXW<Z3=6X6KnERdR=4ZzyydZzZxKEK4=0KKW6ECdE_4dZxdXZX*<Xz_6<qY;E=K4X4ZyzyAyEZZ=6K_xdWREWd=6=d<xExZXEXX<yy4IKr6R64dzZxx<d6y6ZhKKZRxWXEWdzd#_=_Z_fx6XKR_zRzxRzRXR<=Ez<yyyZZNZ6=KKOW<WdEZ<4_W_KxyjX<=X<<EAK-mR=Rx46zRz=y4EREzEhdE_W_<xxX_<y<d6Z>ywxR64yzZz6y_Zy=4=zKKWRWZWaE6dX_R_<xXXyX<<X6ZHRn<Rz4RzzMW6<Rx4ZzzKKKXWXE4=XdEWZ_6EddyXX<dxKxXAXR_<X6=>yS<R=4=zRzxyEyE=RZ:KzKx=_EyE6dd_K_X_xxKX=X<44zWyzs=RRRx=^zKyZZXZ<===W_XEzE4E6<W__xxx_X<X_4d6Xh=RZRQ4_zWWZWKyW=R=XKWWzW<EEdy_6K_xzxKX_<=6R6<6WrWRyRW4_yRyEyKZXZXKZK*W_EWE<EXdW_KXzx_<z<4<EoysRg_4z4yz_y=ZRZ<W_KyK6K<WzEZEd6E<zxWXZX<<z6=qRAxREzK4=zxyZy<KZ=Z=X==WZW)E_dWxy_6_y6=Xy<x<x<d6dhg4RRxyKzBz<yZZX=<KKK;W4EWdzd<__xW_<X<X=6y<<NxGR>6RG42zEyWZzZ<=_do=WKzEzEEd__=xRx<<6<4X<6Z6E:6RKR=46zdyZZ4=RZZKx=_EEd=WE_#xZx<X6Xzx6<W646qj_R=4zZZZxzByKZW=z=<K_KZW_W_E<d8_ExRXRXx<K6y6<YxmyR<4K46z6ydZZ=4W4KdKEWxEZEEdX_Wxzx(5<XR4R4X4KzRyXZE464_yKZ4ZX=d_zWdxRXyEK<46ZxRXxR=<<4z4xzKy44z4R4=zEyyy6ZxKZ=KKZKXWKWdE<d0dxxWXzX<<_<L6)LdSxRR4KzZ4Xyxyy=4=6=WKyWyWxd4dX_dxZx}XX<J<66KCKR4RX4dzRy4yRZyZX=dKZK5WyE=dRdx_=x4xXXW<z<<6Egyx6RWR64Jz_y=X<<W6ZgEC64RE4E<dE_y_6xdXZ=8d_6y6-2xRK4446z=yzy<ZE=y=XKZWZW}E_z4yQZdZ_=XXx<W6z6<0ERyR6zd6=z6y_Z==R=xKKW4WXEWdzd<_E_<x6Xd<Z<56Z =26Rx4Kz4zXyWZzy<=EKRK6WEEZE>d__=d<xxXz<4<x6Wqz&<RERz46zKyZy<Z_=yKRKxKKE4E_dW_z_<x=XyX6X<6Z6bf_RZ4R4xzKz{RWZW=z=<KEydW6EEdZdi__x=XRXxd6646_qWRzR<4Ezyz64<ZZZ6=_KyWRWdEKKxZ=_Wx4x<Xz<y<<6d66*}RKx_zRzxyKyxZX=KKzKd4<EyE6dddW_gxdX=<R_46KHR(XRK4z4<zEyyRKZd=z=+K_W=ERExdRZ6_XxZXzX<<E6z66UWRZRrcWz=yRyxZK=4=XKWWz4KEEdyd6_WxZx/X_<=xE6x2=R4Rd4Wz4z<yZ6EZ6=dKZyXW_EZdRdxKXx4xxXW<z<<6EhyP6<44Z4<z_y=ZRZx=KK4=RWWE4E<dK_y_Xxdd6WE<_6Z^R6ERK4R4Xz=yzyd6<=y=6KdK4WVEdd=dX=RxKX4XX_Z6z6XVERyxR4dzyzky_Z==R=x=EzRWXERdzEK_Exzx6XE<Z<xE2m=RRRxApz4zxyWy62z=EKyK6ZKEZE6d__=WKxxX=<4<d6Wmz+<REX<46zWyZy7Z_==KR=dKZE4EddWdx_<xEXyxXXz6Z6x;_D64R4xzKy44?ZW=4=<KZWyWXEdK6E=__xZXRdE<K6R6X^yRzRdx<zyz6yd44Zl=dK==6=zEKdRdX_zxzx<XEX4x=6dGzCYRd4=zRzxyK6yZX=ZKzK<WEEyE6EWWx_.xKX=Xd<x6KT4VEdz4z4xzER4y6ZE=Z=0yzW=W_Exd=_4_XxWXzEE<E<X667=RZRj4_z=4Xyxy6=4=EKWWzW<EEWxd6_RxZxXX_<=6R6x7=R4Rz4Wzzz<yEZyZ6=yKZKZW_ERdRdx_Kx4xxXWXK<<6yHy!6Rd4ZRxz_zXZRy5=K=iKXWWZ4E<dR_y_KxdxxX2<_<yMRLzRKRX4XzWyzy<y_=y=KKdKXWuE4d=ER_4xKxdXXXY6z6_qERyR=4d4<zqyyZ=ZE=xKK=XWXEKdzdW_E_Xx6X=xR<h6EU=<<Rx4=z4zXz<ZzZX=EK4K6WdEZEHdR_=xRxxXZ<4<X6W#zXZRE4y46zEyZy(Z_=ZKRKxWKE4EXdW_z_<xKXyX6<d6ZKKU_R=4R4xzKy4yXZW4d=<KEWyW<EddZdJ_d=6xIXx<KX-dztWRzR<Ryzyz6ydy6ZZ=_K=WRWWEKdRdX_KxzxdK<<y<66d+RmqRd4=4X<RyKZ4ZXzWKzKXWEEy4Xdd_Z_lx_X=<R<x6Kx=bXRK4z4<zEyyy6ZdZK=)K_W=ERExd=_4EXZ6XzX<<E6y66EGRZf<xKz=z0yxzK=4=XKWKRKxEEd4d6dZxZxVX_XuE<6x+yR4Rx4Wz4z<yWZyZ6yKKZKsW_EZdRdx_Kx4yZXW<R<<6K7yI<RdRzRyz_yyZR4;=KK4KXK=K=E<d=_yEExdXZXox_X_?RbERKR64X4WyzzxzX=y=_KdRTWQE_d=EREkxKx<XX<y6z6KSE94Rd4d4gzu4ZZ==R=xZKREWXEzdzdE_EEEx6xWd{<26ZS=<_Rx4Kz4RXzyZzZW=E=<K6KWEZEuE6_=_dxxXK<4<X6W6RYRRERx46RdyZyDZ_ZyZxKxK<E4WZdW_z_<_K_EX6Xm6ZE=>_R=4R4Wz=y4yZZWy4=<KWWyW6=4dZdy__xRXRXx<K64KW&Wf=R<R<zyz6ydZZZK=_=dWRWdEKE,dX_Wx4x<X4<y<y6d6E:VR_R=zRzZyKy=ZXZXKzKd=ZEyEKddEd_}xdX=<REy6K6d,X*Y4z4<zEz<6xZdZX=UK_W=W,ExdR_4_XdZXzX<<E6466PdRZRrUWz=yRyxZz=4=XKWWz=_EEdyd6_4xZxmX_<=x<6x-KR4Rd4Wzzz<yEzRZ6=dKZKEW_E=dRdxEyx4xXXW<4<<6Ejy(6X_4Z4Kz_z<ZRZx=KK4KxWWWEE<dE_y_6xdXZXW<_<X9RndRKR!4XzW4Xy<ZE=y==KdWZWPE_EX_R_xxKx/XX<W6z6<6dRyR64dzZz0y_Z=ZXZ=KKW4WXy4d4dX_E_4W6Xd<Z<,XWo=RRRx.KdWzXyWZzZ<=ELdK6KWWZENd__=WKxxXK<4X_<x(zi<REGR46zdyZ4aZz==KRKxWKE4=ydWdRdRxEXyX6dX6Z6nh_R=R64xzKy4yxZW=z=<=K=KW6EddZ=z__x=XRxddK646XuWE2R<4EzyRE6zZZZl=_zdWRW_EKZ5dX_y=Wx<XE<y_z6dOyOHR_<XzRzxyKZRZX=WKz=xZ/EyE6ddZW_wx_X=x6E66KrR%X6d4z4<zERyyKZd=y=2RQW=Z6ExEZdK_XxKXz=R<E6y66<d6_RA4dz=z%yxRR=4Z_KzWzW_EEZ4d6_dxZx#xX<=<C6xOyR4R_4WRz4yyEZzZ6=EKZ4RW_Wy=Rdx_Zx4E4XW<z<<XEd<06RW4Z4<z_4XZRZxy6K4K_WWE4E<dK_yE6xyXZXX<_6ZiR_ZRKh44WzWzPy<Z==yy=KdWZWdE_dy_R_dxKx6XXX=X<6<.=Ry<y4dzZz14_yZ=R=EKKK6WX44dzExWTxyx_XdKx<.6_m=RRdy4K4XzXy=ZzZ<=EKyK4WdE4Eud=_=_6xxXKXz<X6yAzj<RE4y46zdz_yvZ====uKxWKE4W_E<_z_WxEExX6<d6Z<<6KR=Rd4x_dy4yXZWyzZ4KEKXW6EzdZdK___ydWXxX<64dz^WRzR<4Exzz6yzZZZK=_K=WRWxWxd4dK_Wxzx<XK<y<664iZldR_4ZzRzdyKz4yd=W=xK<WWEy=Edddz_Rx_x<<R_X6K(42X6WR<4<zRyyyKZd46=^Z_KyEREydKdd_X==XzXWX_6y6WDd_=R#4dz=zEyxZzuK=XKWWz46EEdzd6_dKZxMXK<=<V6x-KR4RKRxzzzdyE<<Z6=EKZK6W_E4y=dx_Kx4=KXW<4<<XEE_t6Rz4Z46z_<6ZRy<y=K4Z<WW4XE<dW_y_WxdXRWZ<_6=uRd=RK4R4X4=Rdy<Zy=yREKdWZWPEKy__R_xxK=ZXX<K6z6W_KRyR_4dxWz#ydZ==R=xKz4KWXEWdzyR_Exzx6_dKx<>6y>=H7Rxxsz446xyZzz6=EoWK6WEEZEEd__4==xxXK<4WR6W 4V<RZxE46zdyZ<zZ_=ZKRKxzKE4EWdW_z_<xEXyxXdd6Z6E8_E_4R4xzKy4pEZWZx=<KWWyWXEdE6Ed___6XR=d<K6R6XSWRzRdx<zyz6yd<zZH=dK=KXzREKd4dXyZxzxXXEX4x=6d6<7bdR4=zRzxzZR4ZXZuKz*RWEEyE6WdWd_&xzX=XE<x<<D46_hy4z4yzEz=y6Zd=ZypKRW=WKExEX_4KRxWxRXR<E<E66<6RZRn4_4y4Wyxy_=4<:KWWzW<KEW}d6d<xZxyX_Ey6RXx6yR4RR4W4Kz<<dZyz6{RKZKyW_WddREX_Kx4WdXWXE<<<X{y86Rd4Z4xz_z<ZRZx=K=1KXK=W4E<EF_yy4xdXZX*x_<z7R-zRKRE4X64yzzxyd=y=yKdzxWjE_d=_R_=xKxEXXXX6z6xQE6yRX4d4xzPy4Z=Zx=xKKydWXWXdzd=_Exyx6XdKW<k64?=?=Rx4Zz4RXyyZzZZ=E=_K6WyEZKhEz_=_Exxx<<4Wz6W<z-WRER_46z4yZJRZ_==ZEKxKXE4EXdWd6_<EExiX6XG6Z6y?__d4R6xRxy4yzZW6z=<RzWyKXZddZdZ__dWXRXx<KX46y(WqWR<R<zy<yyd46yX=_=_WR<2EKdRdXEyxzxdK<<y<66d=E)&Rd4=R66xyKyKZXydKzK<WEKyE=dddd_L_&X=W=<xXR65GX{X4zE4zEyzy6zW=Z=xRhW=ERExP__4_xxWxRE<<E<E66x:RZR34_4yxKyxy_=46EKWWzW<WKWdd6dXxZ_4X_<=6RXxVzR4il4W4=z<<<ZyyX=zKZK4W_=6dRdx_Kx4_EXWXK<<<XiymRRd4Z4Kz_z_ZRZd=K=&KXW4W_E<E<_y44xdXyX0<d6=6X_RRK444XE_yzyXZEZ4y=KdKdWvK6d=_R_x_KZEXXX<6z_dcEwER64dX=zHzqZ=ZU=xKKW4WXE=dzd4_Exyx6XZ<ZX<<dr=OyRx_xz4zXyWyRy6=E==K6y^EZE^d_dydWxxxW<4KZ6W1z(<RERx464xyZyRZ_==KRKxK4E4WldW_z_<xKXyx6KR6Z6y5_xZ4RR6zK4+<dZWZ==<y6WyW6EdEzEE___WXRd4<K646X*W6_R<Rdzyz<ydZZZj=_=6WRK<EKEpdX_=xz_xx4<yX36ddR51R_4=zRz_yKyZZXZ_Kz=6WEWyE4dddE_jZ=X=Xy<x6KWbwX0_4z4<zEyzy6ydZZ=h=<W==yExE<_4dX_6XzX4<EXz666XRZRBRKz=zyyxyd=4=XKWWzK<EEE=d6_dxZxXX__=Xx6x6ER4_=4W66z<zKzKZ6Z_KZ4xW_E=dRWxE3x4_XXW<4<<W48y6X6R4ZR6z_64ZRZx=KK4zZWWWyE<Ed_yd<xdxZxK<_<WSRayRKRz4X&W4Xy<y_=yRdKdyZW&E_dZ_RdXxKX4XX<Z6zx<<XRy?T4dx<z%R_Z=yRZ{KKK4WXEKdzK4_E_yxdXdX=<j6zB=5RRx6K_ZzXzEZzCE=EzyK6WdzWEGE__=xRxxXy<4_X<W)z6<RE_X46RwyZz<y<==ZkKxWZE4EXdWEzdMxEx4X6<E6Z6R!_;yRE4x4yy46XZW=z=<=KKWW6W=dZK=__x=XRxdxx64<W{Ws6R<4Ezy4X:dZZyd=_6EWRWxEKW4K__WdXx<xz<yEX6d<Z:RR_v?zR4=yK6zZXyW= K<KzEyWEddd=_8_Ex<<RXZ6KxR:XRW4z4<4EyyzdZdy =H=yW=ERW<dKE<_Xx=XzXx<E<4<4-d6/R8_dz=yRyxZKyX=X=KWzKXEEW6d6dd_yxnx_<=<E6x6=R4<X4Zzz4<yE66Z64dKZKwKKE=Wndx_Kx4xdXW_zXy6E6zl6_z4Z<=z_zyy=ZxZZK42RWWEzE<EKd4_6_KXZ=z<_6=LR<xSR44RdzW4 y<<_=yZXR=WZKxE_Z=_R_xxK_:x <WX<6<x6RyR64d4zXxy_zH=R;yKKW4WXW=WKd<d4xyZ4Xd<Z<QX_6_RRYZ4KR_zXXdZzZ<ZdKy=EWdK6ETEy_=xR_RXKxX<X6=lz}xRER44Zzd46yg4X==KRKxWKW4EXE=_zdxxE_<X6XdxZ6H6dR=RE4x4Zy4RXyd=zZXKE46W6ZddZdN_4x=_6Xx<K646dtW<zRK4E44z6<zZZ+K=_=y=EWxWyd44C_Wxzx<_EX=<6<KbZ6XR_XQzR4d4xZ4yW=W5?K<WEEyE6za_ZdXx_xR<R<d6K<4x4RW/#4<4=yyMyZdZzZ)K_KRERR6dK_4_XdWxjX<Xy6y<dJddKRt4_4<yRzEZKyX=XK=Wz=<W<dyEx_d_4xN=y<=<R<=^K61RXRBzz4_yE4yyi=d=zKvz=E==Rdx_Ky#xXxZ<z<<6EvR;6<dmX4b4Wy=<dZxRyK4=XKWEzW_dEdx_6xzXZdgXz6=<<Lxx444<XzWyzz=ZEyV=6KdWZWXE_K=E6_x_zX4K=<WX!6<6E9_R6R=zZzWy_ZR=RzxK4W4KEEWy<d<KExyx6=W<ZX_6_k=RRRE4Kh4R6yWz<Z<q4KyR4WdKZWWd_E.xRx_XKW_<X<=A4O<144yx<zdyZy/Z_y:KR==WKKxEXER_zd<xKXyxd<d<X6/6ZR=6R4KzK4XyXjz=z4<KEWyK<EdW6du__x=x<Xx_KKZ6X64Rz_K4E6=z64dR6Z3ZyK=K<WxzKd4E_dxxz_=XEE=<66dhZ<!RZ4=RWzxyyZ4RZ=W=RK_WEKdE6Zx_Z_?x__=x_<xXx}4hdRWXx4<zEzZy6yz=ZZEK_=_ERWxW__4dKxWx_X<X46yx6WXRZ^d4_<RyROxZK=4==KW=xW<EEdydx_dEZ_XX_x66REZ*KAKRX6WREz<z4ZyZK=dRXKcZ_W4dREZ_K=XxXEW<z<<<Kfy6KRd4Z4kzWy=4RZ4=KZdKX4REz=KdEd4d_xd_xXn=<6=BR:x6K_x4XR6yzzZZEZ_=6=Wz_W3K+d==x_xxKX4XXx<6z<ZuE6ER64WzZ4NyEZ=yE=x=6W4KyEWKzEW_Edxx6WZ<Zd76_&=6=RxT<z4zXyWyJZ<ZK=EK6=rEZW6d__=xR_dxR<4X46WxES<RE4y46L4yZzyZ_=ZKRKxWKE44EdWEW_<xKXyXX<d<z<yi_6d4R?WzKy4yXZWyx=<Z6WyKZEdWEdpd_d<XRxz<KW_6X<<RzMxRxzy4ZydXWZn=_K==RKyEKWWdXE<xzWWXEX4X=6d<E8?dx4=zRzxyK<WZXy<Kz=4WEE4E6WdZZ_f_RX=xK<xxyN4NXBQ4zRyzEy4y6ZW=ZZk=xW=KWExE6_4dzxWdzxW<EX_66_ZRZX#4_z=zKyxzX=4=XKWKlW<=EEEd6EkxZ=EX_XE6RXxAyR4>44W4Xz</dZyyX4dKZ=yW_REdRdx_Kd4=_XWxK<<XXBy_XRdlZRZz_4dZRz(=KRzKX=WWXE<WX_ydzxdZ<X5XE<z+R<6RKdZ4XzWyz4<ZR=yZ4Kd=WWoyEd=ERd_xK_ZXXx_6zE6SE6yFE4dRWz94<Z=Z4=xKK=XWXKxdzE4_EdKx6XdKZ<jX)u=H6Rx4Zz44X4XZzyy=E=xK6=6EZ=kdK_=dKxxW4<4dX6W+z6RRERK46RHyZy6Z_Z=6WKxK_E4=xdWd=_<_KXyX6XX6ZxZ%_R=4RCx4Ey4z.ZWZ==<:zWyKXWEdZd4__yXXRXx<K64<RoWL=R<4KzyzXydyZyz=_=dWRWEEKEZdX_Wd=x<x<<y<z6d7y;jb_dXzRz4yKz_ZXZXKz=xZ4EyEyddyE_ax_X=X_XZ6K6K.XXd444XzEyyy6Z=%d=)K_W=ZzE_d=_4_E=XXzX<<EdX6<JERZ(<<_z=z=yxRy=4=XKWKXzxEEEEd6KWxyx6X_<=6R6WdxR4RX4W6RzXyWZyZ_S6KZKcW_y6E.d__KdhWXXWXW<<<ZvyV6RdR64yz_z_ZRRZ==KRKXWKEzEdy<_y_6xdW<X6<d6=<6xxRKRK4XRzyzy<ZEyyY=KdKdWIW%d==<_x_ZdzXXXX6z__PERyR6RW6KzSz3Z=R<=xKKW4WXWzdzd4_Exyx6X=<ZX*<XP=9ZRxxEz4zXyW4zZ4=E=WK6RWEZE=d__=_Exxxd<4<X6Wt4I<<ERd464XyZzzZ_z<KR=xK4E4ERdWK<_<_xXyxXdd6Z6zc_EE4R4xzK44x<ZWZ==<=xWyy=EdWZdW___EXRx6<KXx6XYWSWR<RdzyzZydZZZN=_=dWRK6EKEzdX_=xz_<_X<y<z6d:yDrt<4=zRzzyKyKZX==KzKXWEEy==dd_Z_-xdX=<R<x6K';O_laGqtzmwgoCGMBv='uWi2qK?&1APaYNxmqKlaxNYWAW?UxNmxx4PY&qK1igmAYaK1?a3iN&PP&Nqa?W2&mxYmPN2qKamKmAYmA??&qKYYm11NAW?&ixmmNN?q12iKiAmmY?A&&KmYWxaNYWA&Kxim NAqaAKKKAimm?Y&PKiYqKxNmWY&1xKm2NYqNY1&qmiqmYY&Ax&&&aKWW1xAY&qx?mWWN&aKaA1mK?i&4K1YP2qm?52KY?NKAA?Nq2cmANaxKmiN*3NW1mP?1qL1iAYaYmKm21WKiqx1aYAiKxxYCNPx&KAfWxmWYW1qA1&1qWNCx1&aKA&qji>1PY&xK&Wx2AYKYNAY?megW&mK&AAP2YqvN PA?a12ixxYmYAq&KqKW&NmPx1x?K2Kk?xWAaaPA3K&i1!?1NPWK;KqxqmW&mAa?adbW_P21WAYiPiYI2N2?YKii?xYF&A2AA?xq-YxmKaY1Y?1xN7Kaj?x&xWAxmXPYPAY2qk2xWmY1Y?22q{1Y2xNaW1KKai&aKN?&&2xKAWKaN&P1x?x2&Y?Nx&Wqm?Pm1NWYm&iqNWqimaaY,AK?qm?-Nxa?mAI2i2?Y?Am?W&Aiqximi1a?Y2NoPNKPq11KxiA,iaxNNa2&PqaiAabYm&2&&V&WqPiax1xi222Y?Pqam&aK2m?aYPi&?2YK&x&aYaPqa&i2ASAxK?P1iiNxamaAq?Y1&q?xAaW1nKx&A)PNaPP1Sq:Km2KmYYNPa2iqPmKamAK?W2&hAYPx?a?q2?q21W=1mP?&<qNW1SiYAAA&KmPWWNaa1122?mYW&P2?K1Yi1x?mmN2PaiPKWNAxqYq1NWYixx&Y2Ax2aKN22aqNa&K&iqxW&P?axA1&i2&0xNx?a12W?m?WKP&?N2yK&WxxxYPqm?&WiNyx;&aKW?YmPYYPK?A21W?2WYiA2?a2Am1W&xNaq1K?2xPTiPN&qqPiimiYq1iAx?xmaWYmsY1q&Kxi1dKN!aP1WKWiNaiYAA2&Z2axxaqYmKaWNqAxlxPa11P?qimm&YNPNqAq?iixa&PAi?Yq?FaAAaWKYWPiPYiAaa?q2W1xma21i?(&a3a,PaK1?qi?2hK3AAA&i2qK2iAm5YWAmi?2xxAa%1KKKiAmYaxNPPP2&K1iYfq12AP?qqW7Ym?aN1N?AxxVKYmPY&&iPm7EaA&KA&xWYNqxW1Y1&2?iNNKP11Z&AiWmqY&YK?NqSWiWWaA1Y?KKNRKN&a2PAKAiaiiYPAY&s?xW?xAamaP?i2KyP!?Px1WKYKimmN2Ya&1qaqqxYaxA&AQ2xGmMAa11a1i2WVKmaPiPWqxq&xmYiAAA22akxx?Nm1&KP26iaN2PK&N&&WmmiYqY2?a2NW27maPaK?K21ixN?P1&m&PiPmam2Aa?xqq2mxxaaa1?&2A2WNAPa1R&NiYjRm?Ax&Wq?qimWY2aa?A212qxWaqPNKqK2XHmAPW&qqaqKxNY(A1AW2ADYxiNN1KK&imiANWPq&?&KWNxmYKYW?a?&^mxiaAa2Kaix=&mmPm1W&1i}m2Y1Yq&iq&2NxKaA1Y1A21F1TiPP&NK?qxmNYYY&&qq&qHx1aP1N1Y222iNmN11DK2iPiqYYAm&&&>W1xaYWaY?q2?LxL1a*12KKKqmYYxPqP.qaq?m?Y1am?&2a<N%aa21?KxK&mmNWPKP2KiiiWYYqA&?a?1W?xaxW1AKY2WiNNKP&1W&AiWm2Y1YK?NqWWiWWYDAi1P2W2bNYN?&xKWiAiiNiP2AaqaWNWqaY1x?A?001NPPxPYKAKiwiNKYa&2q?WAW&amAi?q?2W2x?NY1YKNKKmNN0P1PWKoWNWPYiAq?P??BxxWaPaiKm22iaNAP&PqqYi#mWmeA1?Y2N2Yxqa?1N11imixNPNq&Yqmi&i(N{PWAAqAWaWiaP1Y?&Kxy?N1PYPPK&KDm1YPPiAYqqW&xAx1A=?22P2qNYPx1i1si1maNWYY&qq&WmW1YBAq?K?qHYx{a2aLKNimiAN1P2PiqPWYm?xxAY?A?&_mxWaPa2?WiNiYN1A11q1WKNi?aKYNPA&i)WWAmKaxqN?K2mWANxaK1KWiiPaNANaYqxWqN&mxYKAK&Wm?+xaA&&1&Wmm1W2N2P?2N{YxP}KY2?q2YWiYYm?aP1x?q2VaxNm1wq&?imqYi12A&&&qLYmx&&PK1&25tNiP1&aK?WN21YqA?AP2xmmW?mq&1AA2a2mYmP1?P1iiNxamaA2?mq=W2NxPNAW?22&dAY&x?aY12Kq2iaAxr&Y1sW}WNPaY&A&iY2YYmPNY1Kqi?{iNRA1&xKiW122Y?AKAKi&qxWKxKYWq?KxXAY&N&?mq1?2mWYPYP?Qim(Ni1aY1m1a2ixmbxxqPa&YKPxWmAPq?N2mWixYaa&AAK?KmiW2x&am2xKKWmmYY&aW&1q1iqPAY61P?&2ixKPaY?KiWq2?N&x1aNqxqai&m<&mA&&WqaW^x&a&qqKYxmYmxx1(q?DA2cm&Y&P2i1q0xaPAaAKWiPqK92N1?m2xWY2&YAA1?1qomxWNm2aP1a?Am-d1a2&xK2iWmKYP11Pq&q6Wiim?YxqN?qixEaN?Y51&K&22a1YmAA&?qWmqaPNK?Wi22aW&x(?m1&?W2aCe1xP?KWemWmaPAIPa2&{xNKPq1iANimmNYmAWaiKqK1x1YW12Pi&12mW_xx&K1N21X^N?P&&AqmzNiAmA1?P&&aK2NixAa2AIKaqK+YNYa12NKqWxmaY?&A2mKPx?P1Y}AY?Kmq^Yx1aWq<K12qmN1YPq&xK1WNPaY2?xiY2YN&PNY1K?ixiaYKAq&i1NWPxNYKAAKq&KW&WaPa1qq?&#2q51NxPP21KAmPYWNY?P2aqWNwxqYq1NWY2qY&PKY9qmWxi?YPP2?P1KWix2aN1YqY?2qWYKx?111YWYmKa&Ym&P21q1xwax1N?2iamPNaaW1?KqiNx&C?NYP2&qKiNAmxAYP{202NYax&a&qYKYxmYNx1&&q1qxxxa1Ax&i21K2x8ai1aK1WPqWf1N1aq2AKWmYaPYP?K2aK?W&aK1fqmiNq1NqPP1wKqnmix*qYaAY&PzWWAYqAi?K22OKN?AAaK1KWi22j&NmKx&K2mWYx&NWA1?1qqYAx^PP1&KigKYax?&i2qqNm&7jNqPK?mq&W2aPa&A2KYxaf2NNa&&YK2i2aIY1Ka2aKPxYai&KAY?222.mAqPYK&WKiKY#A?aW2NW&x2Px&NKa&?_AT?P&1i2NKY2imAYPP1imq&miYWAo?n2PdPY&x2a2q*?W2KON1YP2?NqPWKmmY?A?&im&gxN1aK1o22mAWqPd?i1WiKiW)2YmA&&aq2WYxx&a1Pii21yxNKP?1q,ai2YxAqPm2PdxNExmYK1YKN2aYiNaaN1AKW2KmNN?P1iNqxNamq1iAW2Y2&N>x??aAXK?214YNYPa2*q&mymYNWAWiP2PNKxA&P1?iWm&WiAN&W2Yqai&m/&mPA?NqWW&x2&WA1?A2mdiA/P&1KnAi1mxYKA?&qmaWiaxYiqmiPqKN-Pq?m1iKix&m?Pi&KiN2Px?P?1kAx?K2KWWA?Pa1xKqi20D11PC&YqKNqm2YAAM?W2mY?Nx1A1KiSi&WWNmP22AKiNmaPNK?F2qmmNix1ax1KK?2qaaN2&x1iomWma?YAAAi?2NxAaY&q1WiPxNWiNAPA1KpPiiYNNi?q&PK2miYqam&2K2i&YANA&E&mKA22m1YmAmiYq2xmYi&P1&2Wm2W1NmPm1aWoi1N2YxaPqYMqWWa1&NA2?Nq&XYx2a2q)K&T2N?1xAaq1=&iYm2Y2Amiqqa-KxiPN?pKY2xHPNia?&xK&iAa?Y??H&Ks2WmxKY&Aa?a2PamNP?NKfW&iYmPNQ?2&i}AWxPmaaKi?W2Ny?AKPN1&?Wi?mNYNKP&WWNmXP1aK?jiWq?CNNNaA2xK?%WeaYKPi?Nq1iimYYWA1?1mKnYa11aq2KMm&aYxWP1&1KqNAmWAYP??=2NF1NAamqYKNm1mmxAa&&aWWiPa&AiPN216YN&PP&N1q2K2i-xN&??1KKaiim2NWK1&AWaWmPY1&PiiN>1YYxKPq1PqYmmmP11PC&YqKNqxYY1AWiL21WqNN?Y1qKx21mN1aP2qx^YWYaK1NP12AkNNiPW&mAPK? %NiPi?W1iiqi1a1AWK2&iq1{mxlaxqKKNk1N0PK&YqPWPNNmAYAK?&&qai2PiaA12?jiaWKNYPY11QNiqxxYaA?qAbmiPa?&1Am2a21<Axaa81iKx2Aa?YPPP&2kiWYxNYmAq??qiWNPi&?KaK12qmN1YPq1*qAN1mJYYAKiq2YW1xW&,11?qiNaYNq&m2NqNx1YKAi?12SmmxWaq11K?WA2W^NN??K1qW22UaPAmP2&Aq5WWxm&?A&2AqPWmazPx1P?.xWmAPq?P1KWTNma?NWAi?Kmi7Ax&?a1P?4i&m1N?KN&qiLiKa&Px1??1ixWANiA&?2WYiYY2P1Px?xqaW?YAY2?N&222}mNa1x1A2iim5aNq?21iK1Wmm^YxKK?xKZWYxqY1A>?A2aYoNq?x&xWK2Wm&NAPN&NqYNWmiai1mKP_a_1xqPN2YKa2Wm1YAP&ixqimWPmYdPi?x2?WPxiaa1NWP2&YqN&?&&NK2WPxaYAKs?aGiJNaA&mAPiKmAY&AxaAqKW&NPmAYmA??&qKYYxN1mPC&2q1YPxYYWq2?K2P,NYmPK?Y2NWaPiYA?Ki1mxWAPq&12PKAimm?Y&PKiYqqxmaKNXKaimmWW0x?PN&xKYx2mYP?PximKAWNmWY&A2iWq1WAxmaiqkK&2KaANPAPqiKNx1axaa1Y&2vKWaYYYP&1?aWNNxN2?P1WWqipaP1AAP&Yq1WfmqaYAK?&mqY1N&1i1TW?i2aWN?AY&xKiiimW&?1xiAmmWPPK&A2aK2imm1A,?i2?5AWwY21WAi&qqky1xYaq1NKmxYYyNx&P1qUxx?bW1Y?fiiq&GNxmY2A2?ix&Bx1NPK1WqPxiaq11Aa?am1Wmaa1xqYi&qiYNN??Y1PKWiWmN1iPAqKmNN*xKAWK&&imNN^P2??&aKxiqm2NvK1&:qYWKPqaYA1?WmJ)mxKPY&NKaxiIAPKKx&P^WiaxmY2AA?Km2QaaKYQqPii2NY1AYKx&KK2N&m1a1?G&ao?NaNAPP1?KinK6PAYai?2?W8mJiaq&K?PRWW1Paa&KWis2WW2NmP&1aK2iYmx1aKm?xWAW&PNaPq1?N22WKxAaA11!NiKY7A?aW2YW}NixPY?1mi&mAYNP%PxKPKqxxY?xW?Yq6<iWxxx&aAii? qWmPP&mKN2Sm?WWAY?m2iKAibm^YYKW?1WqNPmK13K2W?21YPx&aYK?21i?NKYa&Pimq1k1aRYaK?iPiAYaAPP?q0W2x?aANiAi2PKKx(a?a21q?PiPNixN&1qNqaWYYqNm?P2N2NW{mKYaqYimqPNKP1&qq1iW2YY1AP??2aMaiqxq1YP&2i<1DKN?aY&Yiq2mYPAmAN?xW?2WaYAB1m?iq&WNAx1WAYi&mPY?AaPA2mOxxYR&A2?K21#qN&PP1m1N2&2mYaNA1W&xKPi2aiYPP??mmxi2xAYaAm?m2xY2xK&&?xK?2&N1aOa21?qANYmKaKKN&1{2N&N?&K1q?4iAYWP?PP2AqKNmaY1x??imm1QiYxAx&??ix1NmPKax2P22mia&AKPKqii1m1Amam&WiN}^xiAm&P??2YmqtW1AK?22WqxaxmP&Ki?182xKaV&x2P3N6YWSa1?x1A22mxPK1iKWqPmam2xAa&1mqiIWNiN?&2?W2W=APx1W192?mqmAa?aPK&?VW1NTax?A?WK&:PNNPmKaK<W2mxxP11KPqKxmY?Pq?Y?qiqi1Ea1W122xWixKPP&NKaqa%1NqYW1WK!ya;iY1aH122EWAiiNKN2&1i?W2NAmiaPqKqimNJWaA1YqiiYWPP?&AKi&Y2aNNYW1n2xiNmANaa?&qKYyAN?axPa?q2Ai&NiYPANqWq2WaxA1N&1qa2Pxx.Aa&1W&iiYxmaP1Aqxim(xNAxiA&?1K?-aY?AA1AKqWmhiaA&PAAWPq1Y?PPa2Kyi1xANxN&PK2?WKNmaYPaA&WNbKW}YK1NKqWAW?4&AN1N2qJWx&axAi?iKie1W2aKYA&2iPmYx&Pm1P&x2{xxNx1&KP2mpNmaPi?m??Waxxx&YC&??1i1vAxWA1PpK1WbiEAmPWKYiNf7mDPN?x??iWiPYYAP&P22h?xANqAWAPqmWPexx?YqK?iKWiY1PP1KK1WqWmNq&xqa&a_1NAY2Pm1?iYWiNia1&qK2WA2iaFP&K1&2i?m?aW1i?Y2NWPNNaxaY?W2WxNNNPN12&WWaW&YW1Y?mi0mxxexW1xK&i)iNNNYi?YqaWxiPa11aKN2i!1mWYqAAKq?1mKNNa6?W2}qmRiN1APAaq1iWYiaA&iqWqpxaNaNAa&1?Kim&PYA(PAqaW2W&mKaN?i2AW>a&N&aPKqK^kKYNAqKA?mq&NiYN&aK121W2l&A&1mq121iYNKPxK1qAsmxiPqax&fixWxNiPm&mqN2a2APmaWai1Ki&Nqm21A&?WPWYWNA2??KNiWNmxWAY&Eqk2XxN<WP?&x&P_YYAPN1W?1?Wx1NPPq1PKi5Wi?ax1lqNqYK9W2Px&i?zqqWqYN1a?x1xi:xYPPYmANKKm?W?aWA2Kx&imNYKA1ax?ZWmwxmAAK1&2NmAxWa&1&qmW1W1xNYw&a?a2YRWmN1A1iKKW1NKNW1N?=qNmqmKPY1a?AW&m1Y1AN&K1Aix>?mi&1?i&aWNm?xAY&q22YxNa?aa11&Y=1mAPx1W17iai?x2YYAmAiiPW1W?Ai&&qAK&iPY&AKAx2WW2mAYm1KKPq1xmNWAA?11&WihNYKA11?2xmPN&P?&N?P2KjqmWNmai21imWimxa4?xKxS&x1amN2&a2qr?xxYWaKK:KamixKP21xKYWKm&YPAV?qWmiWNYa_1B1aiNmYx?1PaP2Eimx^YW1i?ai1i&WPx112qW&WmxW&1N1YAV:?xxN1NAPmKAiPYaYN11?rimWA8mamAKA22Nm1N2a?KaKxi&mPm2A0KmqAViN1Y&?YKNi&2Ya&ANKx&NzqWxN?Pa?W&P2NxmPa&2qiiaW?YNaqPN?i2KNxYa1VPP&NpmNNN2&i?x2?{AxYx11NKNiJxmNAYmPNiNiKWaaqaY&q2AxxYWNa&N1?i2x)NYA&P3qPK?WxYaAxKN2T+&NKAaAUK22xiP+iAP&PKKWNiWPiaPAKWaWPN1APYqKxW&sNaNaK?Pq2Wq/WYW1NqaqN:1x0Y21Wq&2Ymm>m1APAK2i?2iNY1K&i2NtAx2YxAmKYiP:Px1a1Km??WN6mYjYa?N&?m&i&mPPqP-?2m2x1Pa?Y?&i7i1xVYxP?KaiAYNa11aA2ixW1YhY?1AKYWWmKYAa??mKAixiNNi1NqAqxqYm?YAAqKmqimAxwNA1N1WWYN2YiN??WiAi?W&YqaNq1qbmA)qPxaP2nK_0KYNAWKA?mq&NNYNPW1xq?TaW&A&&&q1iW4amxa2?&qAqKNWN9YxqxiWm)Y2aY?N?P2aximYaq&A2NIKWaPa1Y?22?WYmqxja2A?i2xKai1m?iK&iNNaaYP?qP?PSKNPAY1W1AqiW?x&NPP1qPW1iWN2aa&A?NqKmPYKA1KqWiWqNp1aPaq1%xU2NA1&PiK&iPYAaqA21PqW0qx&aP&??e2?NPNYai&?KKi1N?mYPq&WiNELYqPNA<1qWv2PNqAa11qWW2m>Y?PA?AqmWNxKAPAa?AUNm1YaANPaKxq2m?NA&x?mqNqxx!PW&+KAqiW&YN1A1=q?WxoANqAm1i2AmPWAx&a3Ai2&22amxA?K?W%miPNNai1K1WiaxiYWYNA=qKjNNqAA?11&KP0NY.Nx12K2WxN2P?&NKa?a%qxxPAai1K?1m?mxae?xiP0&mYamP1&a2q2YYiaAaP?&Ka22C?ax1AKY2qi%axA+K?2&m1YmPNA&?NWamYx?A0PPqYWPmPa21?AN&miqWPAaaaK121mxxYA&??2NiP!KN1Aq1?KqliYamaYx&&im2&;mYqAK2Y2NiAY?Nm?YKqW2NWaNY?KmqAOiY?Y&a22miWxKY&N&KxKNKa/sxmPa&xqWm,xmaP1N?1WKWqp&PZ1PixW1k!N2PAK&iBmNm1xq&i&2WixKNeaP1N&xcP%2NAAi&YK&K2YAYxA2Aa&i2Kx&Aq&?&&KYIYYiPY?2K1mAxWPK&1KNiiiYWsYKaW1qK&2PMix,1i2xWqNKNW1NqxqNWiYWAq&xK?iKomY1aPPh&x2WN1PKAq?iiq2xm3PxAxq&2Ymma?aaPxK22W2iaN1K?P2?cYx2aWAYqPW2;2NlNxKm2ik&xWaqAAANiY21NiPm1qKAiixaxmxWPq?iKiVTY?YxKY2xKqN1N&a1&x2NmNWAxqamqmKNmKx1NxPW1qiiNaxN1WA?qWi&mAANPX?1q?T?N1YAAm?mqKNxm1Ab?P&WqqxAxPA1AnWA2?YiYi1&?1_xxxx&PWAq2PWPWKmK&?1aWYWxL&x1&&1N?lWWaq1P1AKiimrix211AWqqmi.maq&a2aqai:NYNqA&?P2NiAx2a?Km?YWi,ia1aE1a2Am?mYNiPi&122NAm?&mKiqW*&WNm PaA?2YxNm&A21QK2q?JaYaaWAiK1qNmxY?A91Wq22&NYA2PP&?i1SmN&amPiq&i2xNx?aW&PKm{YmNP?1?qY2qximxYN1a?1Wxx2a&1AqN&iW1mKaYAa&AiWiix&aPAa2W22m2NP1N1SKNq W2a1&mqKqaW&mKa21??xi2WYPNYiK??12?NYPm1m1iKN2NV2NaPA??WAxqamP1KA&2MaNmPKPKAP21q:)2Y2PA?PqmmYxA1?112aHxxxNm12qx?1W?mxY&1m?iKi%ANm1YA?2xWmi&a1&xA_iqWWN&APa&q}KK21m2aW?m&qWxNax11WAaK2WY &ANPN1gWAJKN1AxAmKPiqBaNxN21qK?qqWiYmam&Ki1L2YiNqa&&P2PiDm2PWAq2Pr}Ndx11???WYqWx&P?1N?aWWi2a&A?1A&i2N;Nx2Ya1AiiiiW&Y1P1qYK?WqCAP??e&P2NxYYxPW&xq&WWWixSAx1AqqG2YP1N&NqmW?iamWPmKi?m2imPmc1xA?W&xNmmxi&m2A+YHaxYamP&K&21caamaWAWqPmNmNPmah&xK?maxWAW1&KPqZxxx?&&?&Km2iNma2?YqYqYxiYK11A1ix-WWAY2&P&i&iiiY?AY&a?mii{mY11x1x1X2qv?NPaP?YKi2Am1YY?mKxiK2iN1N1&6KAW?WqmiAN1NqaW?x1Am1A1&KN2NT2PN?q&qWANN;i1(P1&2mmWNPKAPK&WaqEmxx?Pq?AiPWSm1PiKYKYiqxxxKYP&PiWrxmxxA1mqN2Ki1m1AA&A2mWmN2a1A1KxKW2AxqNm&YqmK1iama1YPA&qWWWPNPPN&?i&W2%&A1PN?1K2xYN1AmAi&m21iKm1YaAx2&W?xPNW1i?a2?i?mAYmAq?1KNmaxxPWKP?mmNWKa2YH1?WYxmNWAKaPK1?fmNa&a??AqAKi.2NKP1qmqqiixWY1AA2&qa_iaPNY?YiPEqN&aYa2&1KA2Nx&xNa&?2ixWqxiaWPYK121xxxPYYA1?/qqcYxKa&qqKqxamPAQ?22aKjxiNmPmAV?q2&W2x)AWqPWPiaXNNAPW1KqNi?m11KKA?mqKkYNNaaqi?WmqUAPaanqiKWWx8&NPP&qmi1saPaYWK2qK2PlNai1N1AK2iNYa1aAY&xqPWim?axA&?Am?hmPyPYq?KWxAm11xAN2qqNNix?Y?1mWx2mNINY&?1iW7iq3qYNKY&2waxWm?12AYiN2AN2Nm&?qY?WxxmxA1PN2xqAN1xYYYAKiq2YN2P?aKAWKPmiYqNKa&12qaimm&NVPiimqxNAxq&m1aii2KtKAiaWK?KPxYNNNaAmKqi1WqNZYNqA&52&Z&x2?11NK22KbANAP1iNqqN2xaY&ATWm2xxixq&?1NWmWW^?NA&xKAKKWmmA&YAN2mmNW?P1aNqmKPWmNxYqA?&?KiWPaK1qPW22Ki_NN2aa?aKa{Yx&AZPY&YWWiPaqNW?2K2iPiiY&aPA1Kq2qYAaWaKq&?fW?ZYNWAmqxiim?PqYaAi?i2xY2x1PxAB?q2qs211Pmixq?i/mPamqN&i21WPxxax1NWiiAY0Nm??&KW}WYa?YiKAim2PNWmc&a1&iW2YYqAPPK2YqYx?oW1YA&im7iWWxNa?qK?P20Wix?a?1KwPiWa1N&Kx?xZ1WqPxaPKWKY2Y5KAqPYqiKixYm11?AP&Pq2NimA1qAmi&mN{AAmPmqAKqxmmaAiAN&Nq?NKxN12AiiN2AN2xx&?qYK1xxUNA1P22xqAxWaqY2Am?1o2Wsmiax1??P2i:aNN?P1AWqihaPYKKN&TqgYNxYAWAKi&WqxPxaAA?1K?21Na1qPa&iqiWxP2Y11x&_qqWqx2?115jxi?tiYaKP&AWNWmaWY1KPqYqWWqaAAqAfKP2qa&N1&P21KWx)m11P&K?2W?m2YNaW?i2Ym{amNY?x&&K&mmx?PKAWKxixYax&a&qY?KxmpYAxaP1KiYW2N&Px1x&m7qxYm)1iAAq?qWm&Nmaq&22mNmv?YNAN&AmxWmYW&mA1i12mNWNN1P?2K?iqxxaW1W2&}?i2aKY2&NK9q2xYaaaI1NWi2&mNNma212KiN&xm&NAK?mqABxAYYW1&?A2N>NNY?W&ALmWxaKYqKm?ayKWZP1&xAAi^2mYPxK&_&Y4PWxmxY&K??xCKNax&&N1Ni&2iYNN1?&&aKaiqa2YP?i2Kqqi4xA&1AN?2qKWAxAa12NKKxa0PAWP 2aq?xWxN&a1m?m21Y&xx&?1W?WiPaANW?&1?WWWYa&Y2KP2+qaNixW&Y11iiiNYKAaP?2NqNx&<i1NP12hQ2Wixxa&KiKmqW*NNKaA1WKPiYaAYA?2&xZAWqPYam1mWY2axrxq&?1A?iiaxKamA2&Y2AN2mPYWAW?NmiW&NNamA2?22ia&YxKN&KKWWPPAY1?Y?x3)W&PAAaAZ?261x2NmPA12Z?i&YA1&P!2iq&NAY7PW?NKY2mxNYK112mUxiaaNNA1YKP2q KY&PP&0WP2?p?Aaaq2xKaxNNAYP1q?/q2W+NAY2K22a2mNWx2A?&xqx,2xWYi1iixKKWYxYY1qN?xWnYxx&&A1xi)21xmaaAWKx2YWg_i1?KK&i)qxPYiYB12KY2xmix??W1?qYix+iNiPWi?2xNqxq&PAAiq2mYPN??Nq2qmxKmq1mAa2KqTN1PxaAK)?mmPQKPpPaq2qxixm&1?PN2qK2Nix?Y?1mWx2?NtNY&?1WWAxYmaNKPm&qdii&xNYmP2&2qiY&Nx?N1K?WiPaANxPq1?KPiPmA&xA?iq2YW1xW&AAKKa2NWWxWa62KK?m?m2YmA12:,iN?PA&Y1a?&2BNPYYAi1Y2&,xx?P?1W&aK&m&m2aK&PKa%YWNxq&?Ai2xW1m1aiaq1!iWNmmK1&&iqA2Wmxx&AxAi2xqWNiN?PY&2qqiiPAYW?YiP7iW&PAa&???K_NxNaW1NK?WWxWmiNqP5?1qYWqxNamqYi*2?#YN2Pq1iIAi1aaNH&i&&jAW1xKYxPW?xW?xmNi&i11WP-Y4WNq&AKqKRWPmqAiKi?2qKWWNAaN1KKx2gaNN??&1ihNWAa2axK??Kma4PPWaWqa?zmWwYA&PY2PW;WaaiYaKS?qqq5NAYaNqx?2mq,EAPPK2NW2ixaKNqKm?aFKWWPaa&qxiq2AY?Nm& &aW?2WaYY1Km?PqPW2PiaAKoKmmP*?AqP111KWxTn&AiAN21qqNaPxaNAA?imPYYNNam1aK22&mmN1PP2&q?xWxN1&AqiNq1N3x2a2qLKm4qz1APPA&xKA2hYxa2A&K&m&WxxKaKAWW?2a0Wx2a&1&K?Na4i1WAA&K2xYNxYA{Aiiq2aYNamaq1&iY!&+2YNP&iPqaxNPaYqKq?amNRmxWAA1qKqixxqPm?22iqmxWY1P21qK?iKmNYiai2xKPiPamN1?i&mWWm&NiNK&??xqi<ANx&&KN2W2?Y1xqPW?AKWWam2PW1iiKqYW2x2amqq?AimWWxKaK1qsAiwa&Y?KN?xI&WqPNaAK2?xm?YYN1?x&NW1iqaxYA?q&ZmxWimiaaqP?WmAYmNa&W1WWai1YWYx?&&i%Px;xa1iAWiY2&NiNN&1A2Wai?.?YmKx1K#YWYa?YiKY?1gi^NAYa*A:KAx17#A&?P&AK2iNmi1=PK?aqNiWmWYfqKKNxaJ2NmP12&KYii_qN1P1&&mYi2PiaPA?KmmP}&xAaK&N?WiA iNq?W&WTaW1aWaYK&&imP7NNN?P1Aix2iYqNm1KKxi1WaxiAx1KiWq1JmNmaaq%?Kia=NxWaW1_yKWNPaY2Am?1m&W?aPaYqx?Km&xANxaWK?2WiNm&NWKq&KW&NKxx&NAKi&iWxaxYa??xK2glmt1NKY&AXaWYNAPW1m&WWixAxa?11qKqxAbi1YPA2aq1WxYPaaA1?i22xaPW1AKa?GmiMKxWP?KiK2WNmiYmqm&?2N+NxA?x1m2Wxm-1APPmqWqKWxmmNW&x?PixW1P&&?A2iK2AxNx?a.1iKP,jx11iP&?Nqmi2m2Yiq&KmxNpKNmaA&x<Y2Wm&NAPN&NqYNWxP&m1miK2qY2N&a&1Gwm2?YWYx?&1ifNWPaB1?A2i1q&NiNN&1A2WxiAYWA&Pi2AK1x2xx1AAKim2PNiP1aKqPKamq7mAPP?qhqYx2a?YKPW?PmAWxxqY?AP?P2AaxNK?Y&YWiiiavYqPq?NmYW2PxaPKq?pmP%?AN&21xWK2qamYP?K&Wcai?Px1q1mi?2KN3NY&?AWWYi1amAKPW2&q1xWxY1&AiiN2AN{P2ai1xK&mimmxWPN&KKAiWmPYYKA&1R2UmPAa?qmKPmikKNK?i1Wi?iPaYYK&&K?iKmWNmA1&PWAqS+&N&a221KNi2=KNAPA&1mNWqP2aaA&?6xm=xaiaqq?KNxmxWN?PAqxiAiKxmYAqY?NBmYNx?&?1NWmWM9PN9PY&YK2UixY1KKq&WE2WaxxAxA12xWAQma??r&YqYxWmP1qPW222WWAxmP;AP?mWYmxAA&m1KW&mNNWPA1x?WKiWYmc&qAa?i2iFxA2a1&x?T2qVqN2K1&7mxW?m#YP1mWNqi,1xPax1xKNximAAkPm2?qKx8xa1?PWi^2qWqNN?YA2WxiaYWA&P22AK1x2xx1AAqim2aYANNaN1?WKiYYqAPPK2YqNx?mW1YP&2i2mNKPaa1qNKNm&RiANP1q2K=x?aAY1Pq?NmYiWx&YAAN?N2YYWx1?m&mWKiKamNP?K&WmmW2m2aYqa?2mNW1P6&?12W1i1a?YPPP&2IiWAaqY=qx?iqiZaAPYWqYK&x?mPNPP22iKAxqmW&xAi&i2aYPmW&AqmKamWLWAaP?qWqxNaxmYmA1i&2mNAx?&YKiKxmq9qAxPAqqKmxPpK1qA1&1qWNLm&&mKi?W2Nk?PWPxApKYiqr1NyPA&an1W&aiaxK1?KmxWAPWaq1qWW2hNKNA?a&qK2m1NmYmAmqNiKY1xma?1??ix&{YNiaq11K1i&PYY2Ki?Pq?0mAxaN?W?2mKoYAxAo1KK1mNN1NqAx&1maWYax&YAKi&2YYxxNaYKP2AVixAaWP22q}2ipaiAaAkqmWaxxYPai&WnmiamaA)PA22KFxixaNiP2&qqWx&xPAiq12lciD&AA1iKY2Nf2miAm1v&Am?WNxqaqACWK2P7Cxia?1?KKNP0W11P&ix2xN1x2&x1Aiq2SY&ANP12mqmxAmK1mAY2KqWN1PxYAKo?dmPO?AqP111KWx:m&AiAN21qKNax?Y?1mWxqKYYNN&?1WWYi&YiYm?K2aq1NNxN1&AiiNq1N2xx&?qAK12isYNWKm1qqPiYoVN+Amiq2YYPxiax1&W?2aeWx2a&1&K?Nam21WAA&K2xN?mia1AP?x2xENAia2K2KhiYmK1NKm22j?WYmiaA1P?1xm_1NP1Kq2KKi?31YNAm&aK?NYmKYaKq?Kq&W2Naam1&?.2iamA2Pm&KK&iamaYPqm?WWPm?NW?x1??iiaY2P1PY1iqAWPm1&mAWqiq&NAm1Y11YqYWA5aa21m2?K1ixPmNW?2&?2imxY1P??1?A2PNaNmaK&YqNiaaiN&&K&P#Yi?NWY1PiKKW2m7NY1q11KxiKm?NqKa&PWxi2aKAmAm&iqDx&NPaW1iiN2WZ&YxAm&N-qiaY&YYKxqKqxWiYYAa?a2NWAN?NPa8&&q1i?PNY&&0&K4&mAxxYW??qW2Ng&xW&m12KAi%mWYmK??mKWWNxKYAAW?P2YYWxCPYqiqmxYYWAq?&2KqaiWx1aAA&WxqaxWN1&i1iWYxaWWA&?P2NKmNxx21Y1aiAmaYxP2&?KaKm2KmYYNPa2iK2mKmP1YAa?1KWiqmWAA&iKKpq{aANPYKAqYiAYmNDPi&16iW2mKYW1A?N2KGxxn?NqWKPxYB_PaPxKWqKmPYKaAKWiK2NNmx2&21PWY!x_2N?&aK?KiWYm?&AAW?N2?YxxqaP1WKi2ka&Nzai&xq?iPmiYaANii2PNBNm&P1?WN2GOj1NPK22KPiWmWYNKi&&2NWmm2Y2AiW&21aNNKaW&PiqiPYYY??b&?W?W2xma1q&??2Yd2Nqai2AK;xaHGAWAAq1q?NAm21KAq?WqPWNxPAi?aqxxxmNAqPc2PKaxdm?111i&+iiW&xqaiA&qAxxN2N&PN&qqKi2PPY2PK&W2AWNxKaxA0WKixY2A&PN12qPWamA16PW2i2NxAxx1Q&P?1WP%mNYPP1mqWxK9P1mAa2WqaNNYmYqA&2YW&W2NNa&q?KYxxN1N1Pa&AifW2xPaaKqiP2?YYx?&1??2q2WTiaNaiKAKKxWm&1A&aK_ixmPxFA?1&qYxmYqNa?NKqKNiWNaPP&PqYi1N2a1aKqa?Km&Nxx&Pa?K2qFqN?aiKNqiqYWimqY1A1?&mqR2AYaqq?2NW2}Fa&&xKxiNc?PY1WA&2&2qW^NA121&KNiqmKN2KP1*WNi&m1YxAW2P2xWqNaPY1PWW2&NqAPKN&YKiWAxPY1qm?1qPW?NxYi1P?22KaPxi?12YKii1xmYrAxiKqYx1xY&AqN2i2?zYN2Pq1ilAiWYYNcKN2WW?WPmBa&11??xN+Ya>&&KqK1ixmKY?PqiaKixxPYaaKi?imYNqPi&aqYW1xYaNAPAAqWW2NNa51KPW2a2mWKNYPN1aWi22NKYm??&?WcxAaa1A?22qmmxqx1ax1KK?2qaaN2&x2Y-mx&ax1AAW?PCWWWPa1KK&iWmqNANPPP2mK1mPYNA2Km&NqqWqm+&KAW?Wm?WKaW1q1NW?2qmaYaP&iYKWW&mAYNAN?YmWdAPW&PK1KKimlAYxKY&NWmx?Y2Y&?a2W7m}Yx1aWKaK12iFYNWP1&1-Ni?Y1Aa?22q6axWP?Yq1aKa2&aYxWP&1AKNiNmY1AP1qqW&NNPAaqAqKNmqOqAY?NqAWPxxaP1NP?&Y KWKPN&xKAiammYaAx121<KYiKYmNAAm1WKKiKmq&AAaiNW2DaxEPj1GqK2NxaAiPi2YKWx2aP1Y?W2KmxNiP2aPqYWY2aYAAK&i&WWaxaaK11Kaq(2NWAxi1YA8??iNmxNY?2&Ai?iPYPYxPq?a2YWPPWaPAY?12wWqNYaK1&CYiPaPN2?W&&qNWqxKY2qP?W_a4YNY&W1PKx2?aKN??q1iqAWAmK&PAa2N2?YxPi1&11K1xNS?P1&aqWwNiamiYiAxi2q1bxmlYqAq?2xmYiPAP?1iqamKmiYxA&qW2NxAxx1wA?q&qKm2x?A1KAqxxK,P1mAa2W7NNaaK&xKq?hm?N?Pr&Nq2W1ixYcA&?iq&qqNPm21WA&?N2qQKx2?P1iiNxKa1YmPa1Wgii2YK12KmiYq&NVP?&!1qW2iPb11YPqqmqPx?aAYNKm&Ki?iqNiYK&&21iNYqN2?x12WqiAa&Y?Pi?amPWmxKY&Aa?a2PamN&1z&NKAiiYYNOP??N2xWYP2YA??Wm2xNDxYA1&iKifY+xNP&a2KKANaPNaK?g21l*kWPY12qKWPxNWKP&?x2%qmiKxYaNAaii2PxKxA1A1N?2iPmaNA?=&AKai&xmN2Aa&qq?YaxYa?qYiKm1YaAAaK&aKN2W9WNwa:2?_ANYmx1.A?i1iixaxqaiKP2&iYxi1NKmix!KNNai1KK1i?2KWWNP?A11KxiKm?NqKa&qK?iixPYxA??mqWY?NNaWq&Wa2We&YxAm&NZq2rY&N1PN2xqiW1Nmay1xWKiNN1xAaxqmK2iAm*YWAmi?K2xAmPYm?*?q2P%WNiaZ2&qAmP%aNN?i1i=1WNxaYWKq?cqaNYxCa?&NqxiYa2Ya&?&PL&NamWY&1xKm2NYqNm1&A1?NiAdKNaKY12Wmx?aqY/qx?Kq2Y&x?aY12Kq2iaANH&Y&2tNxWY?YPPR?&21W?ANaKKxKmimYqN2&mKiWaxqSiYAAA&KmPWiaN&a1&iWmKWNPm?1A2?1x&YYYAP2&NqiWAxA&x1N2AGYN2AxaY12K2imaqN2PA&zqWWmP?Y&?A&qmPYxa2aq1qWW2&a&YaPa&q,2iKa&YA1A?&iWWxNqaN1AWY2?Y1xqA%?PqPvqh?Ni&2iNq?NqPP&1KiWmi?NWP1?x2meNx2a1N?AN?NqAYxxmAWA?i1W1mIN&1&1Yq?2Wd21NP?2qWAW?miaaqP?i*NWWaWPx11?ii&mxYx?2&iWxmWaA12PW?121WqAAaWKYKNxNYWP?P2&mq1mimia1Pq?,W2fxa&aqAzKAE2_WNNa22qqYm&ax1YPWixeiW5xx&iAxK22FYaAA?&AiWa2PaAYp&2?NqWN&PaAI1N?A2iNYNPa?1YVNWmN_A&?K&P_&NaxAY&qa?Pq;I&N1a?2NKK{lm&AW?KqPqaWaa^amK???R5N1P?&xqA2D:2YAAKa2&PqPi?PaYPPJ?&21W?ANam?lKPmWbWAa&qqWWaxqYAYNP2?P2aWAPbaq?2KNmqyqAx&AqqiWx&YYN*P??N2xWYP2aa??&&2KYPAx&q1WW?xPY(NKP2&A>YiWxmYKPA2P2a^aPvaPKaixmqYRNxPK&KKWN?xxa&AaKmWi/xP2&&KYKAii=YYP&N&ALxxiY&YqAx&12NWqxq&AA22q3&Ypxa&qA2Wi2_m&Y&P2i1qy!AxNaW?q?1mKYAPxPa1KKmiqmaYa?:&PWaxxx?aiKYKPmAW&NxPx1P,mi&m:NqA1qaqmNYa,1&KK2i2WN&Pm&K1qKx21mNNqPq2AK2mqY&am1a2?22Nim^a&1&?2x1V;YAPN&Wiqi1aK1A?gixOa5PaQ11qxKNi?W5Yx1W&NWix?YaY1Pq?NW&W1x1&N1Yi2imYNPK&2qaW?mNNhA&?i1hq&W&m2&1A KAqK/Waqai&1KKWx9PY?AA&qK4WAP1YqAqiA21YmNa&AKiWmm1YiPA&Yq2sxiYm2Y2Amiq2Y,KxAPN?pKxiq(WYPPx&iqKifmYYKKq&/qgNKxq&a1&iKmmYaPK?xKKi1xmaPN1Am?mqaNnx1aWAaKA<YyPN:PN&??*WxmWYYP1&W0>iNxWa11A2Y2&xhNNaA1iWWiAzKYx&1?m2xxAx?AAAZiPmxx2xNa2AK?A2A011NAmqxqai&mFAPAx&q2agYxP&W1P?Y21B^xqPY1KK&NYp2Y&KN?YD&W2PNYiKf??2Y}2Nqai2A?dmYm&PsPq&PqWWimt&&Ax2P2xNxx1PxAO?q2q_211aq2?K%ximqaqAiqYqAmmx1aqq&?Wm2>KYKP2KNKPWymAYKK1iaKWW1PPaA??KA2?NYNNPm1KLmWxa?NNKY?WlaLAPaa&qxiq2AY&APPA1KqxNNmYNiAA?Pq1Ymx1YPA?KxqioPx2aK2PK&x1BoAiai21qBNamWY&1xKm2NYqNNam1aK22&mmN1PPimK?WPas1AKYimmNW2xAa^1WKmx?mmA1Pq&&WWWaa&YiA?2)2AN?xa&YANii2qY1Nm?x1PWqixaPYK?m&2qAWsxWamq?KxCAYmPNaY15KqiPm?AW?1q?qiNLx&YKqA?K2KYiNP1?K1iWxW)1YmAm&a.VWYxY&AAW2a;&YKxYa212Kmxqp-NbKN&KiWm2aP&YP2?P2PW?AaYS1??qiYmaxW?+&YqYNAamNN?m?Pm1Wmx?a?AiW&2mNPNm&W?a2qiNmaP21C&KiaN?P1&&qxi?maYxPW?mq?WNmPOKPia211WAW2m?aY1a?1RaU1xqPNK&KPmmW:xK&?&xWximaK11Ka&NkxWax&YE11KxxKvYNNa2&?WmWYm?NlAKi2qax?xa&N&&q.2A_&Pm1Y1W2&xiaq12KP2iQ&NPPN&aKiiA4?WWPxamAqiKiimxY&K??xq1iix&&KAW?Wxx_?aE&N2P?Wi1m1NqKA&cWYWPPN1mKq2A2?WvxPPm2NKKZcY2Aa&&&qK0WAP1YQAY?KmqhYx?YV1KW2immm1Y?mqxqPN1mmY?A?&im&W2x2&=11&q)?Yx1ma?&NqNiAPxYq&W?mHix2PY1YKxiKmmYaPA&PqqK1x&YYY?&q&1qiNlx&aa??iY*P*&xWaa1H7ximNWAq?x2xWaiNY21?KN2P2&W2NY?a12KN2&mY1PP2qNqaNxam11?=21>WNAP&1?K2iI2qY2P1PK&1i2iWaqAKKx2a{AN&a_&NK?i1m?lPAA&x&aK&i+PmY&P2?YmaW2axaAKiia!18KxWPPKqKiixdq1KANq1RxNNmA&&1x?Ym8!YNY&W1WiNmmm1AWPm&?q?iiP&YK11?Kl9/AN?1A1mqNiPY2AYAaqYqAi2mNYiK9?&2WlxNA1YAiKXiNY?AmAxqmqYi1mWAaA1&q2Nx&xaYW11KA2&axNmPAKqKmxPm21x?&iAq1WxxKa?AqWa22NYx-a?&NqxiYa2Yx&q&1qxWKx?Yqqa?qq?WiNPax1?Km2Wa?Nx?q2NWlx2aWNiA??Pq3SYAPYWAi?1iaaANzPx2iqPi?xm&xA?&i2aYPmqa11Y?iixaYx2aq1PqNNamiNbKq&*qXYNxx1mK2iNmYamx?PN&NKANxmmPWPK2KWWxiP2aaA&?BxmR&aiPx&?KYWxYmYm&&&i2aWPx2AqAK?Kmi0Naq11KqiPxqDaNiPi&xL2Wmxm&Y?i2&WWxKx2?xAKKYiYM11NPA&A}?xxaNAaAPiKqYW2x2amqq?32OaNN11WK2WmxNPmN?AN?NqAYxxPaPq&2G,WNYNa??1NKqiq+w1KPW&Wmxx&aaA2?&?KmCW&NxPx1P>miama11&Wq?WNmWxm&PPW?121WqAAaK1KWimaNWxA&a&AhqiamiYiAxi2qiW1Nma_1xWK2PN?Nqa:1?t&iiYPA,Km2&mAWSxx&i1xKxxa_?Pm&q2&KxiKmKNWK?&iqiYmx?a(1NK?qimxNWaa1iKiixa2Nq&?&PwPx2YXaNA&&W2?YqxK1&1iqaimm2PqPW&Nq?mlxNY&PW??mqWAa&ai&a?&i2mNY&aW?miiWYx?N_1xiY*(W1aPaxqxi&sqrWPYP1&LK?W1YAY?Pi?amPWixxa&q?Kx21WiN&?K1qKPiWmiN*K&&iW1W?miY1qA?xZYNiPW&x2aKi26aqNgP7iNW2mWm1&AP^?&2&W2A1aq1qWW2?NKP&?x2<K&WxxxYPqm?a2aY1xN1Yqxi?x&ExNKPK1W-?WmmaNWKi?NWKNxa?&NKPimxPoWNm?2&mqmNYZWPp??i1qmW?x?Yiq&Kxi1rKYxaP&?qAmYOaYOAN??qPpxxWAiA12P2xYxP&1q1WiYi1msN?A1qAq2i?xYaaA12a21WqNN1&12qNiPm2NmAa?xiW2/xKYi1a?m22#?a&aNKm?2m2YYPAP?KWqNWKmaaN?x?1qaWWxvaN?lKN2A#iPYPA12KNiia3Y&AW?x2&i2Nmai?K&qiA;?Yma2&&qPmaVWP2P&2&W#xNxPAKAWKA2m,WaiPm1aKqx2maNKPm&qgiWAx2Y;1A&K2W0qa&Y?&aK1iWjKYAAYqNK2mKmA1A?i2m2Yx&x2PaAWK2yqnWNNP?2KqNi&TWY?Kq&{qJYNaq1mA1WAqDC&N&a221KqiqaWAA&2&YmNiqxaaaA&WY2&NmNPP21mqaiKxmYmA&qPqqyxxxa?KqKxmP;APqa2qAiim4mYYKPA?N+YNmxxY1Pi?&mK9YN?a2&Y?1iqm&PPPq?xqaWqm1aY1mqnq?x1xY&YKK2iimNPN?Ax1qq?m&mqN7AAi1qFWPmqaAq&?222Y:P21iK?KxNme?YNAN&Amxi2xAY&1mKxqqY2NmPm2Yiiq+NiNPKa1iqAWAmK&PAWKa21OWxNPA&YimiAm2NHAA&NqWWqYKYa?N&W0WNPa&aqKmKai2EAYa&Y&?KAWmxxYa?x?aq&W)aPa?1fKNi?WiYxPWKqqxW1mKaxPi??2AxPm,AiA?i?mmNYNA1q1Dq1ixm8PWPx&PK2WamW&1Am&Xq?oAaiPm1A?2i1a?YNA&&q2NiAxKa1?a?Kim/YNKaA&NKCRW_&PAPN2NW?m2m.AaA&KmqKR&a1aKAWKPxA_WNNP?2KqNiAmi1WAA&K2xYNxKYW1PWA2W!axKPP21K&iNmqYKP2iPqYNYxN1iAZi1qiYxxx&qA:WP2WYCNq??&MSYWxaiYW?&?KqWW&A1a2KaiWm<YN1PPW&ms2Wmxm&YA&qIWiNaAaYi1AKA2KaPN?P?22qxm&Y)&mP??N2NWAAxaP1PW&mmNAN1?21PKWiWmN1iPqqKqX#AmKaW?i&28P<qYxPa&qK1WYxmP_AY??qNNYaKaq?&&?GaI&NWa1&AiY2amIYNA?1j2xWWYiamAA&221Y?x11A1qqN2AmKYmAA1%qWmqxxa1Am?Smxt1Pqa2qx?qm2YYAPP??mK2W&a?1APWq2q&N&a.1N1P2K2WmANmPWKiqmiamq12Aa&KqmWqPiax1xWa2?NmP&?&1xKKiK.W1?PWqAImxNmYY3Aq?P2?YqNm11qPiWx2mPN1KY&1q1NKaPAA?a?AmqWaxiai1xW2immm1Y?mK;iiipPaNiAA?AqKYPmi1N112WixQ1xiP&2KKWiWPxYA&i2&mPiWx1a1AqWA2xfqxiPP&AKmNxmPYPK&2aWAW1P2YPAW?W2NYixi1K1&iAi2g?YYAa&1WaW1mqaN?&?mUmWAa2YV1Y?KiN+21PaW1iK1WaYqYWAa&K2PY1x11a1NimiYh1NW?J&1KqWNPYYqAx&12NYax&a&qqia/1NPN1?21PKWiWmN1iAx?xmaNmaNaYq&?x2K}KxW??&mKa2WaiYP&K2NW&NNaA1mqP?W2mY2NmPm2Yiiq*NiNQKa1iqAWAmK&PA12Nq1LWxAPAKPKq2&mNYYPAqYqAiKxxA1A2qIqa=qxAPYKNK&2Pt,YmPYqmqYi1mWAaA1&iqYWWAmaN?i?Ni?oxYx&m&YK1iWaJY1Pi&YqWYmxaaaq1iYqYNxNY?&1xKKiKgW1?Am&aKWNixPAKKx2qmNNYa,?P1WKmx2mmYmKY&&WxxaP1YmA???qiY&Nx&K1aWmiAYiP&PW1qqPWAm?AAA?&i2axKxK1NK8i1:qmxxWP&&?K2m?m2YmA1qi2mWAm2a1q?KNmqcPAxP1qWi?i2mmY1K&?mqaWqP2aaA&?_xmMPaialq?WmxWmANKAxiNqxmHmq1qKN2P2&xiNxP?1YqxmmmYN?aM&K42iKY?YW1P&?2ix2mq1a1KqmiYmKNAAN&riWWNx&YxKN2?2Kx1m&1Y11Ki2AmPPNaY&WqxW&BWamAiq2qAxaxm&mK12K2iNNNAPW1&qAmPm&N2AYiaq2Wmx1&&1m?Aq2X1A?ai1i!mm2N2N<Ka1iqAWAmK&PAY2N21yWxNPA1AWxiYNKYN??&K2mi?x&1K1mia2PNKxa&PK2iWiNm?NPAx2NWLx2t&ANAP2Wq1NAak&iA12KmaNAN&a21AcPiiYNNi?i12mYW2mW&KAa21qWYYPK1i&xq1iKmBP2P2?&KifmY(aNAA?iXYWiaqa1q1iWmxmaP?Pi?PKXWiY2Y-AP&q2AY&x2a2qjKawqN?AA&v2iKAi(m;YYKW?Pq?WYANYi?gi&mmY1PK&&2KqYiPPxYPAPi&OaiaaNaaq??N2q!qxj?K&Yq?i2xYN1Aq?&WPWWNxaa1q?1iYmmada?K1KYxYYKPiAmqPq?zxmqa??&?Wqq<PNAa?KAK?2imaPKPYqNq1WWmNaAA2KNqq/Ka1ai&Y?2iqYiYY?1&&Wii1a&A;Kx&mJWNqxY1xAiiimaN1NK1^&YqqiPxYANA&&Pq*+mxY1m1Y?12WNaN1ai1YKWNmm?Y^AN??KioxxWAq1aK12KmxxiP?&AiP2)NiN???2mWYWAYqY)11?x2FxWNxaP12WiiPX?YmKx&?KiWaPPYiAx?&m?VxxPa2qiKP2q)xN2?W&NqNNPY2Aq?m?xmAi:x&a&A2W12WtNx2?q1Ki&xxY21m?YqZmYW2mW&KAW?WxxBAas&NKc+N2qmaYaP&iYq2}NxPa2AmKaixxWNaPK1iqaimm2Y?A&&22NWPx2YN1aKx2WxiNYam1KKq2WNqNWPN&?iRiqmPYWAi&8m&ymaPaK&x?Pi?N&NaaW&1qAi&PxYm&W?a2KWiNN1x1Y?12xamN&1i&NW?xmaNNxK&?xqYN>mi1qPW&?W5mix}1m1K2qxAtiA2Ax?1qKW<PmaxAP?2UNZ&xPa*&mKYmmmYN1PWqaq1iimYYWqm??2DQNN?Yi&xKWjqmxY1PK?xKiW?xAaPA??-2N.?mRPx1WKq4K#iNxP&2?qxiPm21iAP&qqxW2PWaN1NWP2KNxaR&YqY4Y22mPYPP?iaq&W&Pqam?122T2Y2xPaW1WKNximAY2PF?AKKWWxqA&1xKa21+WxKPA&YiNiPwqNxP22WKoi?xNaxAYi2q1NKm?&a12iW2sY&YN?N12iiWxx1YK1x&P2?zAaYa?18KNi?SPYxPWKiK1mPmx1x?&qqqWxYx1a A?K1 AoKYmPY&K?WWNm#P2AN?&qqGNmWaK112A2mxWxK&Kqxiai1N2YmA&&N2mmEmPA1A2KYq1GqNxP1AiK,_2mNY&aW?m}NWYx?N3KY2K2qN2xa1NAWiWmPN&Nq&m&aq2iAxaAYA1?i2m{1mqaz122?2,mPN&P(1qq1WaYYNi&q&161xWaxaa???iiPWbNi12&mKNxW!?YYPx1iKiiWP?aN1&?qiNWANKP112Kmi1a&N1&P&xzxx&YqYW?Y?12MW?N11AA22WiYmKxWANqx?lm?g&NY?N?aq&WNAxa??Wi1m?YTx2?2&PK1NYmfAmP1?2q-;aaYaPA??YxNHKaT&?qK(mi*aiYAP&iaq?xxxKai1mKPHa-ia2aW&&i_WmN}N&&1&?2Yx?xqAKA???m2XKa?1A12Wii?*?YmKx1niimqmY&NPq?a2aW&AYYA&N?qiKN1YNAY12qqmKmKaa?q?2W?i?aPa&A2KYL?!2NmP1KiqmiamqAxPqq?qPNPa2AQ1N212qmYxiPqKKKamNm1YWPK?AWPW&m2aYqa?22NW&NY?P1?K?x2mxP&&AqKWiNKmYY2A2?mmqWANmaN1KKq2PaANKPK2iWaxAY&Y?KW&12mnmxa&O1A?K2aaYN&&mqKWqmWPxYKP2i&q2W2Pcaa?i2?mxamx?PN&NKANxmPYPK&&iWAxWP2YPAW?W2NYiNAP213qA2KmWYq&&?x2aW1xWYK1AKYENW2aKaAqAiimmmYP&P2?aKWW2YqYWAa&K2PY1xqaqqxi&r2wi1Naq&aqai&PYNWA&&K2NXYmi&W1NKNxPYmxx1,&x6A2_m&Y&P2i12mZAx?PmAaK&iPNNxxY2KqKPmY EAv?Aq?q2xxxPaiA1KP^aHKx1Px&NKPmNmPN?AmqAqK>mxYaKPWKN26FWNxP&1aqmiiNKYmAA&?2miAx&aP?a&WW2W&P&1#KNKP9KtWYAPm&WiiimmaNqAY&imAi-mWY&1P222soPxqPA2&qxW1mKaxPP??2A6Px&aUAqK1iaNxN1Pi&mq12imsY2&q&PWYi<aM1A???2{x0PNia1&Piai1<qYNKY&qKfWAP1Y+AP&q2AY&x2a2q<KaEqYN1Ya2&PqPi?PaY&A&iq{Ni1aPa1q2?P2WMWNN?i&Aq2i}xANKAW?q2KWiNaam12K?>AOqYNa&&Ki?iYYxNi?i2aW1WKY^aY1q?PiYNNNPaq1xK2xWm1YiAm?1KqW4x2aqAWKP2x.iNK111iqYiAmiNYAP?NWxWam&Y-qm?&qWWaxQ?x1PKPx&Yaxa&N&aL?iNmqYqP>iK2xWPmd&WA22qmNNKAY&PqPOAiRmx1iAx?xmaW?mmAWKaWPqWe1N1aq2AKJWPm&YfPY?12asYxAaiA?KPiNxLNaPq1xqYmN!2PKPA2AWixmxYA&A2KaqWk2aqPxAWK&i?82P?P2&mq1mixxa1AKKxqPV?NA1YAN&if24APaPm2mW1mKmiANAA?Wq&bAaPaqA&KNiY.APYPA1Kqxm1mKYmPA?xmYW2NNaP12?miamxYmPY&KKAWNmZP2Ax?&KW7mYeY??1?YmYNKaiPmKPK?WxCqY?&&&qK)WAP1Y9AY?Kmq3Yx1aWqnK12qmN1YPW1qqPWAm?AAA?&i2axKxWPa11KW2NmAYY&m&Aq2i!xAYNAW?qmmWiNaYK122qqW;Nx?Px1qZa2iT2NAAYqKqiWYm?aaqA?=iPn&NcaY&1qamxm1YiAm?1qYWVx2&xAWKPqq:ia2aE1YKKxqmYN1PW2Zq1iqxN&YAq?xq1oNAaa&1&WqmYNRPA&N&a}?iNmqYqPniKqWWWAx1?Ka222iaNxqPa&aK&NYm1Y1KK& W&xaa?1Yq&?x2KEKxW??&Nq&iqxNNAAK?1WaiPNmaY1K?AiNE^aWPx11?ii&aKNWPWixqAmWYqAVKNiSq&pxNxaP2mKx2qmaYYPP2WKXx2mY1AA12x2YW1xx?m122im1Y&Am?W&1K?NPm?Y?K22?WKUNAmY?1NKN2AaxNN1W&YqK2WxNAxAxq?qz8Pxxai?2?W2NW2AqPYK&KAxaYqAia2iYq2iWPKY&KA&?qaxKY&aK?qKPzAaxNW?1&22NWPxK1qA2?m21xiNmaAA2K1x?/KPAPq?NKAWKY?N1?x&g}iW1xi&NKq2Wim9axW?i&PiKi&aPNaKq?aqAYNmiApAWKq2WYYNxPiK2qmWAm?YW&q&YW1WKmWaP?q?PUYW5PR&AK?K2mxmPYiP1?PWaW1mqaNqY?qqHMAA1a}1P?qiAa&N?PY&2qqiiPAYW?Y?&2!WYN11AAa2WiYYKNaPKqdW&mqmiYxPqiKq?x1x2&NAxW&ix{YATPm1KqYWNma1iAPqKq?_Axm1W1YK&}1EqYxaq&?iAiqYNYPP??mWAW?miaaqP?i2xo&A?Px11?ii&aKNWPWixW?xaLKA&AKi+q&MxNxaP2mKx2qmaYYPP2WK?x2mi1AA?im2&NKxa&aAY2e2qpPNWPi1bn&i1YPAb?x&NqWWKxaa&qK??=AYaPi?q&aKANNmAYAK?&&W1x2PiYAAO?v2YYWNNPN2PWxmYrW1?PN&qqqi9PKYWAWWx^Wx6aqa12N?qiamaN&KY1Wq&iKxNaYPiiW2NSNAP1vAx282qaAxdP&&&K2N1mWAaAN2m2AWYxiaW1x2WixQPN2&N&?iKWmYAN?Pi&aq2WAP^Y&A1?x2WNPN&aW1aKbNxm&PWP2qKqiWxx&&?1x?1qiR&AKaW1W}ximWiPq?aiNKqWaxaY&qY&WsmGPa2a!1P?qiAa&Ni&P1qWxWam&YEqm?&q2/YAaa21N?&iYaPN?P?22WamKmP&mP??N2NWAAxaP1PW&mYNAPNaW2?KNiqmqNeKK?xqPiLPWaA?qiN%qYYPa&Y2AK4ixaiYxAxiaqYimYW1xqP&W21r1xq?A1DqP2YmiPKPPqAq2i?xYaaA12a21WqNN1&1NimmiYPP?PS12qAW1mKA1AK&W2PxqxWaaAKKPx17APa?xq?iiWmmaYqK2?aqKWmxq&i1xKxxaNixm1W1KrP2Wm1Y1PqiAK?xYmqaVA+K1=A7?xjaP&m.NimNyY&Aq&x2PW1xiaK???22mH1A&Pm1aKqx2maN&P/imK mim?1?KmiW2AWKNx?N1KKm2Amx1YP21WkKiPmfNiP?&?qKYPxiax1&2Wix7PN2?i&PK?WmPxY?PZ&P2mYNxAaAq?ixmmNNPmPN21Kmi?m?NiK&&2q2NFxaAqKxiNxmW?NNPN1A0xi&U2NAKP&YWNxKa&1K?i21miwAx&?a1&K&xqYYANaaqNqaN?mNYqAq&fmKWqxPaW1i?_x&_1PPPK?xKPW?mBaPPB?iWK:mNAam1WWmiAYKNq?m1qWqxNaaY&AX&q21N&PPa?AAKmixBaPxPa1&K mPmxNqAa?YqPNWm212P2iAq2YmmX&K&aWaiPYWYP?&129NWmYiY:AY&im2exa?&Yqai1xKmYNPKx&PqPN&miAa?ii2qPWWxWaNqiKxixaaN?&mq1I&ixmKYKPWi?qiWiAm1&?i2K22axxKPY&YK1NNm1PJ??qqK2W&xaYW1NWa2?NmPW&12PKWima2YmAmiYWixxYiYlqa&i2ARAxK?P1?K?x2YPPKPqimK?WNxNYAqx?P2PY&xiYaKNiqx?DNNqPq1SVKWxmPNwKW?AWqNxPm&YKYiPxAOMNx?i&xqxNam?Am?Ai&qxWKxKYWq??W(AYYPq1)&PKNi2miYm&i?mqaWqaxaPKWKamaWYAx12&N?^i?mKNi&K&iqxW&YWaxA1&i2&YKNY&2&NWN2xYyPKPi&xq&N?xxY1Pi?&mKWWxW?x1A2imAaPxWP1&1KqNAmxYqPi?P2AWmAxaP1PW&mxWaPNPa2?KNiqmqNIKK1iW1WNNYY&1q2KimWiN1P&1qi&iq6>YA&2?PWaioNmN31&21qKWWxPai11Mm2?T&NNPfqAq?ijmPamqN&PWzWKNqam&YiNiP ?YmKx&?KiWaPPYiAY&?2aYAxKaKqii?7?*21xaK&YqYi1PNYm&U?aWqWWxaYK1PW12qSqAWPYAKi&xNa,N&Ax?xqPYmx1YqAPWa22NxP&1Fq?i2mia2YPP1iYq1W1PKYE?&2)mWW1NmPm1aW}2YN2NN&&&WKqWPxAY??A??qi/aaKY(KNKm}WmaNxPq&2Ktm2m YYAK2m2YW?mEaKq2?m_?W PPP&12qYNam2YmA1i&2mWaxq&21x2?2qYPP2?K&NKAiiaWNi&q&1=1xWaxaa???iiPWeNi1214KP2qmA1&AYqPqK{xmPa??&&q.m(AN2PN&aKYeWmaYKAm2aWKW2YqYKAKiPqSx?Pa&&AKKYiY711NPA&ARxixYPY21N?&72NYNa&PA1KmimfaAMaWK2qxW&maam&y?Nq&iWx?&q1aKKimYaP?P2K??WmPm&N2AYiaq2WNm&aYA2?2m1W1aiPN&&KWxNY?YK?q1iqAWAmK&PAa2N21hWxKPAKPK&2W#aNRKx&K2mWAaKAO1Nq%qaxqxWaN1?WKiNoANi?W&AK2iNmi1HAY?YmAxGaNaPqK?Y22w2Nm?q&mi&xNYaNPAx&iq1WqPiaN??i1mmYWN1a?2PK?i?a2Yx&&2xmmi?xNaNAAWx2PvPA&aiKaiqx2 PNWPW&N}iWxxx&aA?2mE1Y&xxaK1K?Wx?!aNWPm&&q?iYPaY&A&iqpNx1xK&+A&KxixoP1mP?2Nq&x&Z11P?m?AqYWixWax?WKx2P}2PNPNKKW1mUYYNAPK&xq?WYP2YPAa&W2qNNNPaq1xK2xWm11mAA2AKPNYYWaxAP?2miOPxqax12WWiNmN1P?xqYqaN?mNYqAq&9mKfxxPYwqWKAeqYYP2?Yq1WNNAm6YxKi?x2xYaai1m1YW&2xsKNKaW2??2mAmxaNP1?KW?W m2aA11?K}1eKxWPPKqqamYzWYLaW?1WAW2m?aY1a?1yaS1xqPNK&KqixL1YNKa11Wxi2xiYN1P2a21WqNN?Y1q?:iAa1N+PP1qqAN&m2Y2KO22WiWWAYY21PKP2?aaN&P&2qqmm?am1BP&?x2xWPAmYa?i?YX?U2NNa&&YjP23YNYm&W?xqPW2PiaPAq?x22YWx21q&mi1iKMWYPKA&WqNW?PKY{?1??mYNKA&Pm1aKqx27qP?PP2PW2mvxNA1AqKYqiRqaKai1Y??iaaANq&Yqiinimm2Y&AN?Am&Wiaa&NKqW?iNca1mPa&ak1xxYPAxAYi&qxWKxKYWq??i2iamP?12KKK2NxIKYYAY&1mNWAxA&?AW2PmmYixAaR1lKYxWmPN?PYiNqKmMa&1AK12&riYKNYaP2xKPiPa&ANaaqNqaN?mNYqAq&SmKs&a1aN&Y?NiqNKYmai&1q&iqY&YqPv?AW2iKaaY_&m?Pi&N1NiaK&aqPi&YPY&P2?YW?W2xNY&1YWPiYNNxiPWAiqAmPm&N2AYiaq2WNm&aYqP??2?Y2NxY&KAiWxi{ANHPM&Y WWPm?YYqN?KW3NAPm&1K&i?xKmYNPKx&PqPN&YOAaA1i2qPWWxWaNqiKAmMmPAPaa2NiiWYmmYKAq&WWqWWxNa??-?ok1YaP2&m&AKYiimWYx&W?xqPW2aNaPAq?x22YWN1?m&AWA2PaYPWAx&Pq2NixPY?1mWx2?W0xPPm2NKAiAa?AA&PqYqPNKmYY2A2?mmqW?a&aiKaK12i!YNWKm&aqaN1m2NY?x2Km&WxxKaKAWW?2YNANa&N&PKqixm21WPNqqqxx1xKYW1PWA2W,NN??K&NKAiiaWYY&q&ik1xWP2aaA&? xmWjaia?q?WmmYmAPqP8?1qxWXYWaxAP?2mijPx?Pm2xK?26_PYmKN&AqAN?mWAP?Y22mKWYx2a21mWq2{SJ1N&#AWi2iWPYN2AP?Pq?YaxqY}A?W&2ANPPi&Aqii7m:PmY?Pqi1qqWqPW1K?2?ixNWqNaPa1&>Yi2xNYPA2&m2avxYWNiP&212xxbxq&qqNiPi&NiYxA?&Y2xxmxAYYAi?W2xxWNxaP12iNiAm2NQAA1KqWWqY&YW1a?12WWKNAPY&NKPi2wNYaAxqmKKm&ma1a?qqW2xxAxKPNA2KK;?%<x2PA&1KKm1mKNWAPqqqWWamKaPq1KmiAF?Ymaa&&qPmNm&YWAx?&qa4mxia2AVKAq2bWNq1K1aiN2WYWAP&&&qWmWax2YA1a2Y2AWKNx?N1KKm2Amx1YP2?NqPW2mmaa1xqW21nKxiPa1mK2i?N&NN&m12W2xYYAY?&W?N2KWaNN1x1a?&2HamN&a2&Yjai2mmY1K&?YqmWKxqYW?q?W2Nt?acPN1&?Wi?aqN2PA&JqWWmP?Y1K1&1mxW1PqYKqPKHmommA?Am2YK1ximqA&AK&Wq&Y1x21aKWilmNaPNWPm22qmWmPYY&&R2&m1Wmx?a?AiW&2252A;PaKqWNNY72YPAP&?maW&x&&qKY2&dP 1A2aP1WKWiNaiYN&K2aWAi1xYY A??im,taaq&?qN8mi?tq11Pq&qEWx&Y2A&AKi^q&<xNxaP2mKaiaa1Am&P&A_qiamiYiAxi22m}mAYa&PS2imAaaxiPA&AKKNPm2YmPKi?2xxAa21qKW2WmmaxNKa22&K2i2aDYa&q2xmYi2xPaPA?Wa2?NxPW&AKKqm2im1Y&Pqq&qqi:xAA21mi?2IN7mW&2K1Ki2KmaYPP&qPq&i2xYA?A2?Nq&MYAPaWq1KimiW2AK&P&&K2WYPaY2AN&&2YYPx?a?q2Kx6&Yx1ma?&NqNiAPxN2AA&&2m:xmq&21mKmxYN2m}1i1Mta2imAYAPKiPK&xNmiaWAYKACPRqx&PN&YKAmYmANKAxq12mmymKaqPKKYbNWPx?am1&KNxqzaNYai&KWxWamKYmAqiiqmxKxPPAAqKW{immNaPq22qai&m%&mA&&WqaWIAxaP1PW&maNaN1?21PKWiWmN1iPqqKqdxAx?YnAPKmxNzANA??1W?PmYYi1KPY&2q2WmPqaNAA?mm_ 1a2&YKKWam1Y&11Am&N/WWNxN&PAK2Y;KY?xNaq1q?nxKWWP1aiqYq?iAxmaxAa2x2aW&x.1PAK2i2qN?NOa2&Aq1iKY1YKPW?PWqWWxaYK1PW1qqNaxK&m&YK1iWa:Y1Pq?NmYWqmMaAq1?2XaEAAm&12PKiixm&1?P&qAqNNNa?A2Ad2a2&mmxKP&K1KKim%AYxKY&WWmWPx2Ym1a2YqAxqNxP11iK,2WN?NFAP&qW^xPx1AAAP?PmmWKaa1rqY?P2W%WNN?i&xqxx2 2AmA1?i2YN1aWa0qm?N2qpqxX?K1?i1i2xYN-AqqKqiWYm?aaqA?viPLqP &a&1ia2?YmYYP1&W^-W1miYYAW?121YNxN1&1iqYi?YiAaAP2AK&WxxxYPqm&HWi:NN?aP&ximiYT?xLPK22qPWqxx1P?K?iWKiUaAa?AiKaxPjiNxP&2?qxi1%iY&KK&WqWYxaKAi1mWPqW;1N1aq2AKqmYYiP!Pm&2q&WNxA&&Ai2amNNqA?PN1a8miama11P2qYW2NqmaYiAi?xm2gmNm?Y1&2wmAa1NmP?&?KiN&m2Y2KI?aWqNNAYY21PKP2?aax#P?1qqYWa W1GAY?YmAxiaNaPqK?Y22p2Nm?q&aWiWYaYNNKmqq2xiWx&a?A22?22wmN11i1iiPxNYKPWPx&PK2WamW&1Am&Eq?EAaiPm1A?2i1a?YN?q?x/ximaWA?A2?m21Y&NmaAA2K1x?riNiKmq2iWiSPaNiAA?AqKYPx2amAKW?ixNAPW&1qWWNmiPxYKP2i&q2W2P^1&?q?WxYW2NPPP1?sa21YxN2Ai&N2PxaxKY11xKN2PNNNPa?&miAibNWN?AK1?2Nxxx1YaAW?w2NxoNNaA1iiYiAt2NNPi2QKNm2m1a&PiKmWUQNxAaiqWKA2Kmx1NPK&mKAWxPYY1A1iKp1x&x?&WA1KmimVaARPY&Y!AiqYaAqKK&Yq2W2xm&qPt2&qWNaN1ai1YKWNm>KPiPqq?q2Wmx1&&1m?Aq2-1A?a1KAKqmNmPN?Amixq?iixa&PAK2N2aNWPP?Y1q?OiAa1NA&a&momx1YKYi?N?A2WW&NA1P1&?W2aS01xPAKWW&mK5qY1AY&i2xYYx&AIKiiAxa}ixH?q1sKCNNY2Am&2&WmYi2xPaPA?Wa2&g&Aq&aK1iPi1a2NPPW&WqNNixxaxqa??rmNqA&ax1KKK2Wa?YmPa1WniWPYK1YKxiNFYN&APaW1mW2immm1Y&iAfiii6PaNiAA?AqKYPNY1NAiKWqimAPPPq1&qNWYmAAYAA&K2xx1mPAnAKKq2mmYPNP&1PKbWmmYAmAY&1qWxax1YiAY?Wxm+Waia&&??&WxYmYYP1&Wo7W1miYYAWWm2awaA1a2AYixm?a&NxPK&KKWN?xmYaPWii2PxKPx1qqNiYmaaPNWPm22qmWmPYAK&G?Nm1Wmx?a?AiW&ixYKYm?mA_Wim&mWNqAP?Aq?xAx?Yi1a2K2KNNPd&1Kqqx2Wm&Y?P2q?q2Wmx1Ai1m?Aq2X1A?PNqqqxxx{mAW&?&2qmW1P&amAa?qm2<axKam1qWiixmx1a?xqmiWWmPPNWA1?1qqYAxa1Y1&2-iNU&xWP?2qKfibPNY1aWq2fPYYm2aP1P??xaWWPxafKiqmiA.2Y1K?1iWAi2aNaPA?Kmxxk?xiPa2PKiixm&1?PWqAq&NNa?&1Ay?Y2KYqxK1&1aWamqNWYx&A&K2Ni2xKA?A2?m21Y&Nmaa1qW2iaeKNmPq2iqxWxPaY??mqWH1YPmWa111?qxAjKNK?iqK??m1m?1WP1?m2mWaPUaAAK?axY*xPm&&qxW&mKYK1qAa&AmNWAxA&?KP212&YixAa=1FKYxWm1YiAm?1KqW{x2A?P&&YjNW2aKaAqAiimmmYP&P2?aKWW2YqaxPW?&2?W2a?a21mK17imxY1PK?xKPW?xAAYA??*2N<?xPPx1WKiimm1xiPD&2iqiPYYN4?z2AW?W2axaP1i?1iPNaNKa1&xqNiPYNYPP??mWAW?mRYP1mWN2qmxNaPqA^qYWmNiYYA?&22Yi%xqa&11?KixW1N?PAKP?vCi/?A??mqYqAmqm!a1Ax?RWWZxxPa2qiKP2q,xN2?W&1qiWmx1NqA!?2W?*NNPa&1z?qi1maPYaiKqK1x1YWAxAaq?qi>Pm}ai?2?82YCKAqPY11KWx6m1NqANiYqqi#xA&1Aj?Pqq-AA&a212WOiaN2P?&Wq2+iiAmkYsAYiWq;W?NNPx1YW2i&YKNa&P&1KqiPPaY??x2q,2x6ANaqAiW?2iGi1mPPKWWaNa3iYAAA&KmPW?x?&2K&2&2qamx?PN&NKANxmKamAY?KKW NxjA21NK&2qmNxWPK&1qAi?xmNAA&?PWaiWY2Y&K&2E:N,PaKaW&AKmiWNiYmPA12q1N?miYiKY22K2xKx2?xAKKYiYF11Nai&1K?WxxNN2Ki?x2xYax?Ym?Wi1xPWWN1P11qHAiFxPY&AZ&Y21Qaaxa11iKmi1RYN9P2&qKWWPCqYiAKq?qYxxmi1iKa212KxLNYPq1PqYmNm&NPPr?mqYxmxYY1AW2a2&YxNxP&A2qmmWmNY?PP?x,Nmim1APAxixk&xqxW1Y11K;2?m1PAa?1iKai2mA1bP&&1qxWWaPa&AW?a2;axNK?Y&YqK2WxN1mAa?qq1lYPaA}A?212YYYPK1i&miPi?xxNqA?q&qqi_xA&1A)?Y2KYqNYa?ALKKx2mmYmKYq2i.mim &aPi?A2AWKAPa?1?W2ixW&PA&i2iKAiJm5YYKW?12iVmN1Yq1_K2C?{DYPP&&,KqW1xaaYAA?iqYTPNN1xAq2?2PYPP21R&Ni1iqxYNiAqqKqiWYm?aaqA?bm&,&NfaY&1WPi?xmN2A&2?WaiWY2Y&K&2F6NUPaKaW&AKmiWNiYmPa&qI2WamKYmAqii2x=xAa&mAm2WimaPxWP1&1KqNAmxYqPi?P2AWmAxaP1PW&mmNAN1?21PKWiWmN1iAA?2q^*AmKaW1qKK2imaNmP2&?iAi2xNYPA2&N2alxamaAAY?i2W8xaWPx1PK2mNm?PKPv?AqNWWYiYA?P?qix%&N?ai1x?qxKmNP1Am2YWKx2xma1Pi?;2PW1AYaxKm?qm?YANiAY&AqqmKmiYxA&qW2NM&xqPNAAKKi1NaxF&m1Ki&iaaaAq&W?xWAWKNNY21K2?q2=mx1ae1?FN2qXKNaAxq&qqWxm1aNqaKmUx0ANia?&Pia2iN2YNA&&D2mWam&YNqx??WW01PK&xqYK1iWJaYAP21W,Ki&Y1YNKm2i2aSKxiPNKxKa2&=kPPP?&6qNW?GiaxAWqqqAx1xxA_AqiqmNNPN&1i&xq?iYxxAmAY&1qWNJx1Yq1NWY2qW}NA?113KYiKaqYYP?18qKN2xYY1AxWmqqxiP1&&qmWWi1Q?1PP?&?r2i1Y&AAKY2qmKWYx2a21mWqiNQANm?p&ai2xPYq1a?A2Pm1 mxN&W1NKNxPYNPYaK2?KNiqmqN(KK&WqWYxxKPm1YKKqWmNN8aP1WKWiNaiN2&K&A/AxiamaYA?&R2KY2xq1?1WqPixmiP2P_&YqKxmxAYYAi?W2xxWNxaP12iNiAm2N>AA1KqWWqY&ax1a?12WWKNAPYKN?2-K:AAA&iqmqYm&m2aaPW?2WqdxmWa&1??2/?_2NmP1KiqmiA#2Y1K?&iqiYmx?a=1NK?qimxNWaa1iKiixa2Nq&?&P>Px2Y.aNA&&W2?YqxK1&1iqaimm2PqPW&Nq?m^xNYAAiiW2AWKNx?N1K?WiPaANWPN&?GKWNmAYiKW?AqKGxANaK1m?AixaYN1P12KWYxxYYYAKq&aqiWixx&21mKmxYNiPP1W1L{a2imAYAPKiPq?W?P21PKP2P2&YixAa 1OKYxWmNYNKP&KWxx?ax&AP(?&2&W2A1aW1N?2xqBKP&?xqWnmxmaP&YA2&WmKWWxW?x1A&i-qYxAN?#1&qxWxmP&mAx&q2a,YxP&W1A2qimm1xqPS1iK1WmmrYxKK&YB&WYaxa?qmKxi1+KNc?x&Nq&iqaNA?AK2qX&iaYWYKKK?imNNqA?aK1aKii2MW11PAqaWWxmxNYAAmi<21x2Nx&1AAWiiA=&1aPYqxKixiaaA1AqKx2aD?aAY2&N?2iKN?N2Pm&1iiWYmmYKAq&WWqWWxNa??-?q2P5WNia%2&K1mPmKaxPP??q*<PmfaiK+KPm?)KP^aKqKWxxYm1YWPK?A,1Nax&YPA7Km2YNmNYa11Wiai1viNYPWimqxiqxaaYAPiW2AxqNmP1AqK}2iS1YmP#&xsKiYa&YY?x??mm xN1aK1fWxiNm&Nq?Nq?qKxqa&Na&W&KdKWiPN1qq??K2a8iN2aW21KAmaYWAmAN&AqmN4x1A21xi1qAYiNAa&2aKYmx*iAi?aq1qq0xxaa??A&2iNW2NK1?12Kmi1NiYmPa&q#2WamKYmAqii2xvxAa1WK1&itq9i1Naq&aqai&PYNWA&&K2N8Ymi&W1NKNxPGKxx1yqPWPNYk2YPAP&?maW&x&&Y1YKKqWmNPm12&Nq&iqxNN&AK?13&iKxYaYA1WN2xx>NaPq11qYmNmPNqPx&2:WiiYqY1K12W^xUax&awKPKq2&mNYYPAqYqAiKxxA1AY&i2ArPx1?m11iW2PY&NN?N&KW2iiY1YYPi?A2PW1AmYD?ii1I?WKNAPN12qmNNmxPW?22PmYW2mW&KAW?WxxN2a.aK2P?Wi1m1NqKA&KqKNiaPA?AAWxqKSYNYa12NKAiAY2AP&1&NwiiAm.Y{AYiWq?lYxPai1W?&x?fiNiKm16?2mKam&xPK?Y2YW1ANaW?-KYiq3aYY&N&&KPiCxmYY?m?Yq1WWaaaa?2Kmi&WWYm1n1NKA2imPNZK&&xqmiKx1AW1x?1qi^&AKaGK1KqWY;?Yq&K&iqxW&P?axA1&i2&YKxWaW2xii4}IK1PaW&1q1iqPAYiAx&qmK/Na11iK2iommYN1NPq1iV?iimi&m?&qWq?YamiaA1A?KxPjaPN&Hq1iqWx^WY&A?&2W?W2xma1?iKxmK51AmP&qii&iWUqYPAA&?WAW?miaa?K?i2YW?Na?A1PiYxmY&P2P#&YqKNqxYY1AWi{21WixYaW2mKaiaa1Aa&YqxKiN&mxYKAK&Wm?RmaAaqKNKP2qoxN2?W&NqNNPmaAx&-2?mAi^x&a&A2W12W_Nx2?q&Yi&mWYW1m?a2xmYW2mW&KAW?WxxNiataK2P?Wi1m1NqKA&aWYWxYRaPAN?22i+maiPm1aKqmx61P?a0qPqqi&xNaYAA2Y2AWKNx111KKm2Amx1YPxqmKWm2mrYYAKiq2YW1xW&}11?qiNaYNN&m12W2xYPxY?Pi?amPiixxY&1m?KxYW2xqaP&Ni?i2mNN&AYiPqAWmx?a&AKWY2KYxNN&q1PWPiiY5NA&K&AqmW?x&YKqY?NhmNKa2Yi1?KP2JmY1PPaqxWGx&PAY-Axii2xExAa1yKN?ix&ExNKPK1W+?iimi&m?&q2q?YamiaA1A?KxPE?N?&hq&iKiPPmN?AN?NqAYxm2aAA&KmixWqA2Pm&mMYiNW=Pi?YiaKiWAxAYKqPKxfNfANWa1&AiPiqc&YNAY&AWYWAmKax?1&iWDlYNqaq&YiN2P_?NmP&&N%qiamYNiAK2x2aWKxmaqqi?&QKyWYAPA&WiiWmmaYqK2?aqKWmxq&i1xKxxaYmPNai2&KxiKmKNWK??mqaiWPiaP?Kimn-YNPY&P2PKWima2YmAmiYWqxxm2&1Am??2?WiA&a1KPWNmKNWYaPx&qq2i)Y2YBAY?K(mFaPiamqYKqxmNqYxaW&&q?i2Y?Y2Am?1WiwmxAY211W?2&NAAY&qKjqNiAmi1WAA&K2xYNxKamAAKxxY:1N1?Kq1iAmamm1qPa&iqiWxP2aY???W*Pz&xWaa1#exiPmP1&P1qaWNx2P?YNAq?qqnYKNxaPA+WWiANqAx?x2YW1xaPAY Axii2x{xAa&mKN?ix&XxNKPK1Wg?i1YAYa?N?&qPWUNmaYKmKY21eWPaPaK2KNm&mWNqAP?Aq?xAx?Yi1a2K2i0Yx?Pa2AKamYmxP.AN&AqiNWxAYK1xWN2KWWNP?A1PiY2tY>AAKa&2qmW1P&amAa?qm2Jax&a}2mK&2W8aNrKx&PqPN&miAA?22Pm?WNxqaqA*WK2WoW1xPAKiiqxNax1nP&?x2xWPAma1Aq?PxaTqPx&1q1W?mKYi12AP&1mYW1x1&KKa2W}Y}AAqaa1iKiixa2NiP1?mq_WxPKaxK&??mNW?P2PaqA?Pxm%KPqP1&xqKW?mq&aAY2xyqximWaK1AKmiaaANP&N2mW?N1xmYNKW?N2NYPaV1YAWW?2NXqNqad2KKWiWPxYm&i2YmPiWx1a1AqWA2KOKAia2A?i1m2aWN1Am?mqaNTmKaaAA?W2QW?AKaW1WzximNiANKP1Wq1W1mq&AAP2YmmN&a2PNA<K?iKtiPKPi&xq&mWxNa&AxKmWiiia?Y21m?12>Z?1Naq1KKaWxY&YqAx&12NYaxY1xKWiASKziNxP&2?qxi1oiY&KK&WqWYxxmAi?qiYxNWqNaPa1&UYiK,WN&K1&5Waxia112?i2imb#&xK?A1KKKxiYAx?&1&YXWi1xmamAai/qix2NmP&1&qmj_mPNNP2&iqmmixmYaAq2xK3x?NNPP11K92Pm1Ya&Y&?KAWmxxYa?x?aq&WwaPa&AW?a2Baxx,1W&NqKiKxNAxAa&&qTYmx&Y21YWa22hNx&PY2PK?i?a2Nq&&qAWWNimAYJA5?YmWkNNN?P1a?x!;Y2APKY12qPWPm?&aPB??qqtYNaYWqCKYiYaANP&NqqFKiYm2Y2Amiq21x&xW1a1K?1ixmNNP&N&PK?WmYAN2&W&2WKiixxY&1m?KxYW2xqaP&Ni?i2mNN&AYiPqmxNxmAW1x?P22YiNPaq1xK2xWmNYNKP&aWxx2P?YNAq?qqHYKx-11AiiYiA 2NNPi2vqAm2xxA&Aq&,2AY1xIaY1KWqiYF1NW?L1Wi2i&a&A Ki?Pq?<mAxa2A?KYiaL1PaP11qqNm&maNWA1?Aq&YxmKAW1YKKqWmNPxai11qmi_mx1KPPq1qiIYm11iKYKP)aemxKPY&NKaximaPKAm?AKKWWaiYY?1?qixWPN?1A1KiNixmxA2aQqmWqxQmxYKAK&Wm?Wixi&&112W<KmmYAaK2mW1W&a?NqAa?aq&YYxN1m1PK22&maPYP1&iKxx1Y2Yg&2?mW&WqmnaAq1?z2PWqNAa%1nWKi?NWP2AN?&K2NNa?aKKq&i2AIAxK?P1aiNi1mWNKAAqPq?W#mY1??WKxWWbNaKai1xK&x?maNxPq&2KFm2mcYYAK2m2YW?mCaKq2?i21mmNlPx2KKYm1m2aYP1?qWKWAxma?1&?KxYWWPmPA&2KmxAY2YW&i&?qYW2xqYiqA?i=Y)?NQaY&1WA22YmYaAK1W2Nm_xYAqAK?KmPW&a?&aq&?KiYmYN1KN&AqANxxmA1?Y??2vWYP?&m&xWN2a(iNiPx22Kqm?mWaPAx?iW2(mNAYKqmiPi&NPN?&x&aK&i#PmY&PW&aq+W&x&&Y1N21GPHqYxaPqqWNWYaaNAPZ&BqYNWmiAq1mK12Y4.aWPN&&?2xNY1YK&1&qWYWAmKaxqN?KqWTPAAaW1a?KiPa1NqPq2WqY2KY&A5?2i2qPWWxWaNqi?&iNhaN2Pi118&i2m21fAa1qW?Nma?&iAA?D2+{YAWaj1?qNWxmY12Pqq?qWlPm?ai?2?&2N(qNKa22P?WmNm&YWP&?AWPW1mqYPqa?2TxWiPi&aqAKKWxJiY?PU&xDiiqa?N2P1qiiqWiYWa&??Wa2PYKN<AP&&qixWmpYYAK2m2AWYxiaW1x2Wix{PN2&N&xqxx2m2aYP1?qW?WWNaa11W?aiAmYAaaA1(K9iYaWNi&q?m21WYx^AW1x?1qiQ&AKa?K1KYxYYKPiAm&aqqxxmaY&PV?12xYKxYaNA2K?mmmYN?aE&Kc2iim1amAC?xmKW?a1a2&Y?1iqNKNAPm&?q&iKPYN2?m?A22WANa1Y1P??2YaNNK1L1qWqxNaaY&Ay&q21Wim+&qA?i1qKWPaqA?1q22iAN11NPY2&qi*YxAaqK2?i2x+&aWPx1PK2ximPN?Amixq?iixa&PAi?Yq?7aAAaK1KWiiNNqAm&K2WK1WmxmYaKc?Y2YYAaH12?T2i2zaaxiPA&AKKNPm?Y?K22Pfax1x&&iAA?j2zVYAWPP1?KYNNmmP7?12m>1x&a?&K1Y?PxxrPNP?&qxiZmYma1?PN&qqqiDPKYWAWi?2KmmNYPKAWqNizN2P?PW?PKqWiaWYmA???qiY&x11P1xWxm&NqNWPa1KqPN1mAAaA?Kmq2h&a1aKAWKPEqmxxWP&&?K2m?m2YmA1qiq?WYx2aqAiWA2aYaxY1t&xKP2XaWYY&q2PzAx?P2aPA1WY21+1AK&PKAiaiAaqNaPi&iqxN2xmamqY?&W#NKA1am1?K?2ia&N2P22<qamqa?1mqm&?2NlNxA?xA2KA2&mmYxaq22qmWmPYY&&42?m1Wmx?a?AiW&ixm1NKAx1Pq?WAYYY?AQ?N2?WPNxaW1iKmi1WiN-P2KqKPmY%BA6?Aq?q2xxxPaiA1KPGarKx1Px&NKPmNmPN?AmqAqKnmxYaKPWKN2Ox2NPP&1qqN2WmKY1&A&miWiKaK1x?a?1W2!mN&aN&m282N;AxiPP13j&ixmmNKA1qW2xW1mia&qKKYi?X2YYa1&qq&mPmqaxAa?qq1,YNmaH1NK?qwmxNW1i11iPixaxA&&q&WWYW1x4Y?112A2?WiNa?P1iKY2?ma1APaqYq&W=mYa1?A&aWWhaNKai&aKmi2m?P&P2?NKqx2aYaa?x&xWi5xN1am1*22q2m&NqAN1&qKW1YAYm&W&K3KNxaaa1?2Kmi&bNYm18&NKAiiaWYAP2&NqiN3xYaYqA?q9aNmPA?11mK?i?Ji1&P2&20yWaRqA?KA2dmiWAxQa<1YWWiPU?NYKN1iiLxPaN11??2amKMYxP?x1PKPx&YxPaP122KPiWmWYNKi?ADJW/NAYK1Wi2imm1NYP/2miqiPYYNw?{2AW?W2axaP1i?1iPNaNKa1&xqNiPYNYPP??mWAWKNmaY1K&WiNkga2PP&&KqWNQWYKA1qAqmmWmK1KKx2a21x2NmP&1Nqm<0mPNNP2&iqmmixmYaAq2x2aWKxmaqqiKAmbo/YAaK&WW2Wmx1YYA#imWqWPaYYQK(iAc?;2PxPP&iK1WPYaY1Pq?NmYWqxxY11NWa2&^&Aq&1K?KKxf:&YxAx&PmmW1mqYPqa?NHxN&PP&?KiiKx2mPN1KY&1q1NKm4AA?2iWq1}mNmaaqIK&iWmxY&a2?mqimKxmaAA?Kmq2H&NPPa11KW2amAYY&N&&KPiBxmYY?m?Yq1WWaaa&1WKxi&W2YmPiKKqmWAm?amP2?&2PBax1aWAaKAiYNNx21K1AWAmiYmYY&&&22aiWx2Aq1x&W2&Z?x21?12Kmi1NiYmPA12q1N?xNa&AqKNqAsKN11a1KqmiYmKNAAN&rqWWxx&NW1m?iW2WTxYaKqqKY21}WAGP11qqNNYmqNLAAi12Ni4x?aKAi2K2iOxN&1W&xK12im&1KPq&PqWWim.&&PqiA2mNxNYa11x;miPNiA1?&qq(WW1m?&PA???m2N1a&1A1&Wi2A8_N9PY2WqNWNPPYK?x22m?WNxqaqA9WK2WrW1xPAKiWqxNPNNqAa?aq&YYmWa&AKKNiYWiAWPN&N=PiKYxAqK?&NqqWqmQ&K1YK?22mYx1Pq&&iPiqxxYaAq&12YHmx>aN1?&CixDWaia1KPKxxxY&PqPWqYq1WIm?a1?A?2q?(YNaa1KaK12qmNP&P2?NqPW2mmaa1xqW21nKxiPa1mK2i?N&NN&m12W2xYYAY?&W?N2KWaNN1xAa?&qZ 1Nx?K1YKN22m?AmAY&?K^WKP2aP1q?WiPW?NiPKK1KiWYmAYiP??P2N#xxaaqAxKYimxCx?111YWYmKNiYm&P&?2xiqx?A&Aq&z2AY1xDaPAqKAx&WqPPPK?xKPW?Y&Yx?m?A22WZNAaN1WKq)KSWYaaNqWWPWAYYNW&*?Y2?i1NxAWA?KK2imaxKP2&?i&iNYmN2?22YWAW?YWaN1K?aiNNxNaa&1.zmi&lWNaPnixqPWPP&Yi?A2Nv&Y?xNaq1q?gxKEWNWKx&A?imqa&1xK0&&2x,xxP?m11?q2Paaxo&xq1Wax?YqAAK2?Pq1YYx1a1qKiYgAE?AWa1&mqmiaa.Y&Kx?x2&i2Nm1W1NK?2PmxAN1i11iPixaxA&&q&WWYW1x^Y?112A22W?NYPa11iai1BqYN&&&22NWPx2Ym1aKxWWw1NKai&aKmi2m?P&PNqmK2x2aYAAA?qW2NeKxaPNKxK12a/WN:PNK%qNiAmiAYAA&2qNWiPBa&qxKxi&W2Ym&W&Nq?iPxx1N&i&1WPWxPx1&?q?WBYU1N.a?&1iAi?LiYaKP&iqYi?xa&AAK?KmiN?aqa22x?KiYmYN1KN&?Kii1PAYa?Y2Kd1NqaZ12qWK12?aPN?P?22qxm&YW&mP??N2NWAAxaK&mKYiKWWYNPfK2qNW&mqaNPW?K21CAx?PmAAK&iPNaNKa1&xqNiPYNYPP??mWAWKNmaY1K&WiNpIa2PN&&KqWN#WYKA1?Aq?LmmAa&1P2aqWx2x&&&KjiNiPNKNWAA&mqWmixYYmAK?qqWxqxWaN1?2liNI&xWP?2qqaWKmiaaP&?22?xAx2PN1PK22&maYxAm&YqKimxNYy&W?xqPW2PiaPA?Kmxxr?xiPa2PKiixm&1?Ax&Pq2NixPYqAx?2mWHNNN?P1K?xvrYPAxKY12qPWPm?&aAiKY2AIixxPP&NqxiamqN1AY?miiWNx?N-1x2m2YW?moaKq2KmimYqN2AN&Pq2imxaaxaiqq2mz1miaDqm?N2q)qxt?K1?i1iYaYAK&i?mqAi2x1&?A&2A2qmNxWPKK?K2imm1PiAm&aqqN2xaY&A:Wm2&WWxaal2xKPiPa&Ax&KqYqaN?mNYqAq&TmKWWxW?x1A2*-qYxP??*1&qxWxmP&mAx&q2ayYxP&W1A2qimm1xqPh&PqqiWxY1PAA?2q}NAaiaWKfKm2AW2N1??1iKiNmmPx2&K2mW&NWm1am1m?am{5AxKaa2YKxmmY1Aa?&q&WKNqxaYAqN?A2AY?xWYPKYi&m?a1NmP?&?KiN&m?YYA2?qqiYAxq&aAYiWqWY&xW?N&YW2iiaAYaKm&2BKwmPaYWKW?Nm&mmANP?q2qAm1m?NiP1iAqqxYai1WKxWa2iWbAqa%1!nNmiNWP2PWiYK2WPxPY?qa?&2&YqNm1?qxW>2&mxYxPPimq?W_xNa?PiKx2WxqNxP11Kqx2im?YAAP&&qOiPx1aa?Y&iWqW1P11WKxKao?.iYPa;&ii2ikmPNqAAi&q2W2PZ12?i?WxYW2NPPP1?Saiqo_N?K&&AWPxiaY1i?i2ixmh?xq?11qKqxWmYPK?aiNKqWaxaY&qY?2iNSPN2am&aqx.WmaYKPi?aqmW2x?a&AqKNq&JKN11A1m2W2KYKAx&a&1i2Wmx&YN1mqT2PWNx2ai1m2iimzaNq&x&PqqiWxPN?Ai?KW1WiNYaA1i??iPmNYxPa&qKxWYxmPEP?q1qYNYaKAi1m2P2?mxxqP?K&KW2qmPYAP?qAq?iixaAKAi?Yq?/aAAaC&PK&i6BYY1Aaqxq1Wixma1AY?622,qxWPPAqKiiKN?NY&x1iWixaY1YK&Z?Y2qWPNY1N1P??imaxN?ai&a#PiimYN?AaiAqKWKPiaN??imxxWKNYPY11hNiAmA1?PW1PWYx?PKYYA2?22mYqxAPm1NKKiqIP1APK&K_iWN3?A1?2iWq19mNmaaq8KaO2YAP&a?&Pqxiqm.&xAAqiBqNaANaqAiW?2i9i1m&qK2iKi2PxNKAY?Yq1YNxAaAq??WM1NYPi?K1YK2i2mm1qP?q&qixax1YiAY?Wxm/aNa&KqN?YmxmY1&Px&KqKiWP?YaAW?m2&g?xY?a1&K&xqmmP1?x2UK&WxxxYPqm&aWiWqa?aZA2KAi1lKP1PK1WqPmqh?AYP?q qNWAmiaPARW&2xSmxKP1KWqxi1_iY&KK1iW1iiaYaAAKKxxN,KxWPP2AKWiaHKYPK1&qqqNWa1AK?&?KmlW&NxPx1P)miama11P21YWxxqP&YxAK?KqWY?NmaaAWWiiPNKAx&i2NWPxaPPYWAmi22m:mAY1iP;2i26aaxiPA&AKKNPxxANPi?WK2zAaPaqA&KNiYjAPYPA1Kqxm1X2PHPK?qKKDYaNa&AP?5im^YPmPY11KWmam1NiPY&WmmW2YiY&1?&1ixNmNYa11WW/i1<iNYPWimqaWaP1AF?a2x2YY&xxaK1K?Wx?mNAqP82xK1xWY?Y2AN&&2YYPxK1NK+i1(qBWNNP?2KqNiAmi1WAA&K2xYNx1Ag1xiqmNamN&a2&YEai/F2YAA1&KW1WKmWaP?qKaeYf&N4aY&1KiWYm2Yq&&&W2aWix21WA*KP2WNnPAP1q&Km6WLKAK?xqaq1m2xma&ANKmW3WNxAYi1P?ox&sxNmaK&1iWWxm1NiA&iK2&x1x2PYA1Kqixm1YmP.K2qNW&xxamKN?Y2?UNPY1K1qi22aNNxW&WqPi&iqYmYaA2&A2axYxAYK1xWN2KkmxAPx2YK1i1YiAA&&&?eWi1xmamAai9qKEaxAaW1Z??xKQWNWKxqqiIWmPPNWA1?1qqYAxq1YKi2e2mo2N&PN&Al&iiYa1N?qi?2NWaAmaa1aW122NYP2?q1aKiiimx12Am?mmYx2Y%AiA*WaqifANAaK2PK?i?a2A&&KqAq&NimAY_A>?YmW!Px?aY2NKK_4Y&Am?1q1WqNKxYYPqx?P2PY&PN1A11W22PBWNWPN2iq&mKxmaAP??WWiW9xYYiq2KaT?YNAPa&qWK&W?mWaxA1&?mPkmaNaKKqi&2_mPN&PiK2K_iYmKAmAA&YqiWWxxAW1x?P22NNN?1K1PqAiYmWPiAY&mqKWqmWAqAW?N2?x4NNa&AWK?xqm1P&PY?aqxW2YqYWAN??mKINx&YW1?Wq2}G31N&qqmi2iWPYN2AP?Pq?YaxqYFA?W&imNPP2&AqiiimqPmY?Pqi1qqWqPW1PPK2&2KY*x&Px&xKPNmm?YnAA?1WaW2amaAAY?i2W_xaWPx1PK2mNmNPK?1qTWYW?mAam1x?azx,ax&aXKPK&2WvaN5Kx&AiWxqaYA1AK&W2PYAxWaN1?WKiN{&xWP?2qK,iCPNAb&Wq2qWYYm2aP1P??xa>APxa1KiK&mPmYAxAAq?qxxPx&YWAa?GxxyPNP?&qaiAi1a2NPPW&WqNNimPAKAPKA2xGWaiPm1A?2i1a?N1&A&qWNWPm?amqx??qi!aAPai1xK&x?tWPAP&2NW?N1m=YYAKiqqKx&xa&aKq2WixNANKAN12qKm?mpN2AA?1qKx1xKYW1P2q2qNYPi1t1mK2i&mNYAK&&iWaNNaq&?1N?axmBaNa?112iPmqaqNaPi&iqxN2xmamqY?&_xxiP1?aAiKAiA3K1PPYqNq1mWxxY1Pi?&mKWWxW?x1A&i0qY&Am?s1&qxWxmP&mA1&qqPYax21xK1i1m?N?Pq?2&PK1NYm1Y1KK2AW&W?PWY11mKm2aYExY121Ki&iWbqYPAA&?WAW?miaa?K&&wNW&aWPa1xKqi2G<P2P9&YqKxmxYY?PX?Km2Wma?a1KPK&22mY1aP2&mq1N&xmYAP2?1m?Wixi?m1P2WvKYm1xaK&YqYi1PNYAAAi?vPiPaYaPqK?Y2232Nm?q1AqmiNmKYqPPiAqKWKPiaN?qimxxWKNYPY11-N22NvNKAq1K2YxNx&YPA,Km2YNmNYa11WiaiqN2N1A&1A2mm8mNYAPi?PqUY&xxamAKK1 WmxN1ai&&)KWAY1YN1Y&x2qxKxiax1&W?ixt1xiP&2KKWiWPxYA&iqq=YYNmqaa1a?&xYWWN&aK&NqY2iaWYNANiPW2ixY*axqA&>2&e&x2?1&mW?iiY}NP?2q1qiiKxaaPA&2P2&W2NY1?1?ixmWYAPKai&xK&WmmK&YP2&qqP.Na?a21N?&iYaPNW?1&qWiiYaKAPA&&22YYax2am11W&imraNq?2&xi?iqaPA2KK?NqAWiPWYi?q?1m1NWPxPaK?KiWPblYi&21vqYiKxNY2qP&WqiW1Na1q1WKa2KmP11P2qaWWxmmxYiA??Y21Y?xW1PqYi2xKmYNPKx&PqPN&miAA?2i2qPWWxWaNqiKxixaaN?&NKWW&NP_WY1A1&qmAWaaYa&?+KN2&WWN??q1 KRNNm1xW&22?sxYmm?aN1N?AxxX&x2aA2PKimNY&A&?KqKW2NixAY&qa?&2&YqP11?1KWp2&mxYxPPimKamimqA?A;&22A<1xK111K?WiPNqx?&Y1?izWPmNY2Ai?mWi3mxaaqKxKa2KHmNq?i1xiKi&YAY?Pi?amPWixxa&q?Kx21WiN&?K1WKWNxmAP%&q2xmNiqxaaaA&WY21H1AK&AAAiaiAaqNaPi&iqxN2m1axAY?q22WAA1aq1qWWiYN2AxKN1qqaWam&&YPi2mqqo2mqPaKYK?2AmmYxPaqxqai&mrAPA2qiq&!?m1PxKm?Y21WWNAPm2?KNixzqY&&l?Nq&iWx?&q112&2YmaxNP2KqKWiNm?1KAN&&KWW?PqY!A%WN21xWa2&a2Y?2iPmPN?Ka1yq?iqxYaaPWi}2YBYAA1iANimiNa1NmP?&?KiN&xx1KAWimqANia&aWAqKPiAp?PAP?1iqamKmKAN?r21WqiWxNY?1x?qxaWix2aA&YiKiimYN?AaiAqEN&x21WAaiqgAJ?xiPa2PKiixm&1?Ax&Pq2NixNAKA2iAoiYqNYa11WWn2WN2N&?&qHWNWPYKYW1A?m2WxiNmaa1qW2ia{&NhKm&&K2WYPaY2Am?1m&MYxmaK1q?WXq4WNNP?KQKqiPmWYiP4i&2mxPxKPxAPK?2smPN&PiKKqmWAm?YWKm?x21WKPx1&1?iK2WWqNPPA1?iAi?{iYa&K&iqYi?xa&AA1?x2KI?xq?a1?WN2xY2x2?A126mWxaKYqKa?NUWraP&aaqN?2m2gmAAPW2mq1xKxaAPA1&qqPYax?1xKqi29vaNNqai2?KiiiPmAq&2qKq2YxmKaY1Y?1xN,ANA??1Wi1m!aiNAPl&_qYNWx1ai1mK1qqtLN21?1XqPi&mJNqA1?a2YWAxiYY1PKN}xWqa?aPqPi2zkmNP1Pq?YKiWqYKYiAY&?2aYAxKaKqiiKyqp21xaK&YqYi1PNY?Pi&1mAWaaY1qKxiq<qNqAWP11?TPi?m?12Axq&+NYmm?aN1N?Axx.KYmPY&K?WWNmIP2AN?&qqBNmWaK11KA2?mmxAP&&Pia2WN2N&?&qOWNWPYKYW1A?m2WxiNYam1KKq2WNqNWPN&?i}WYx?Y21Y&12qF&aPaq&xKaiqw1YYAm&dqNW?d#axAWqiq1xPxx&xK&2q2WNYN1P-1?q1mAm2N?AY?aq1xax1Yq1N2&2qhxx1PN2aKiWYmAYiPx?P2Nm9xPaqAWKP2xQiNKP?12qY2?mqY&&1&xiJiqaq1N?P?&Wi<xN?aY&ximiY51NW?5&1KqWNPYYqAx&12NYax&a&qqKms1NWA_a&&xqxiPPmYaAai1q2iYax11q&?x2K:KxW??1aKWimm&Y?PYiaq&W&PqamP12PFKY2xPaW1WKNximNPK?aqAK1WYmbY?Aiiv2axqP?&N2mK?2qa1NqPq2WW?mKY&YKKV&&2xrxxP?m1aKax1%2PP&xqq_&ixmKYKPWi?q1xAxq1N1P?q2xt2AWPN&NW&xm}xP9AxiAK:W&x&Y2q1?N22WWNAP11x3NiAmA1?PWqPWzNimAYJAB?YmWWNaqa?K1Ki2KmaYPP&qPq&i2xYA?P12xq1xixmaaAqKY2iaAxXaW1&qPm2mZYPPq?Am&iqaPYqKxKa2&On1mP&12qYNam2YNP&?YmPW?x?&2KP2&DA<&AiaA1JKhiYaWYNANiPqKixYM1?qA&c2&E&x2?11WKN22aqYY&&qUWqNmaY1NqY?2qWYKxWaW2xiqqiNqNiKN1qqaWam&&YA=2mqqd2mKPaKYK?2AmmYxPaqxqai&mwAPPKqiq&t?m&PxKmKA2YZiNWPxKWqxiPm2ANAP&qqxW2PWaK?q?Ai1WPNC1W&xKPi2aiYPPq&xq2NWxNaNqP2i/NxvNx?AA9K&i&f211Am2?qix*mP12?1?K2mWANx?Y1&immiYPP?P2&mq1N&xmYaAqi22aW&x^?m1P2i2=Y?Am?W&AKKWxPNYiPK?a2PW&aPa&A2KYE?mNPxPA&iKxWPmqaxAK??WAW2NNaq1Ki22imYN2&iqaqPxArWP2P&2&WRxNxPAKAWKA2m(Waiam1a?qiY{i1Aak1WK&WPY2Y(AP&q2AY&NA1P1Kqx2Pm?N{AP&WqimKxmaAA}?WmmdxN1Pmqxi&i?YKNN&m12W2xYYAY?&W?N2KWaNN1x1a?&2RamN&aW1aKGNxmPYP?q2aWAW1P2YPAW?W2NYix&PN1aK2ii.11&P2&2j4x?YiYWqY&22P5Px??a1?ixmqNixWPK&AqmWaPAYq?Nim9?Y1NmaNqWKNiNaPNK&xqKM?iNmqYqPfiKqWWWAx1K?i2q2iaNxqPa&aK&NYm1Y1KK2AW&xaxA&qAa?i2i+xA2PY11KxNmm&Pi?AqWfPxPa?&&1x?Ym#*YNY?AqmiaiPaKNYP2&2qmNqxAA&AWKaq1+2aqai1x?qxKmNP1?m2YKAx2mAa1AN?,2PW1AYaWKmK&m?YANiAY&AqqmKmiYxA&qW2aWxxqa2Ac222nFYNK&m&1i&iYxaYxA2qq2xiWx&a?A22?22rmN11i&mKA22m11?APqAqxGNmsaK???22m/1A&Pm1A?2i1a?NiPiimW?mWYKY2qx&K2Y(Yx1?N1??i21aANW&YqKWaxqYqA?KW?1q?YPx?a?q2iYq&NAN&?i1AKDirmY1WA1?i2a(PaNaK?WKa2x7qN2aOK2K=iYmKAmAmq&wPxiaxa1Aa?W2CSNa,PN1AKimYmAN2PN&i0MWaY21?Kx2P2&W2NY?a12Kmi1a&YmPA12q1N?miYiqm2iW2xKx2?xAKKYiYZ11NPaKMKPmqxmAYAxqnqKx1m^1Y1A?22NsiA0PY&YXAxNYaYPKK&Yq2W2xm&qAY2&2YmaN?P2KqKWiaGKYPK1&PWaW?amaYA1?Wm;J1xqPN2YKq2HmA11P2qaqANma1&PAi?x2&Y?x&1A1NWNm?N2Nf&a&&2miKx&A1Ai&K2a!Px&1P1&?2iYN?N?&xqqii2WmKYAAm?amAWqaN&mK?W1im-NAWPN&NJPiKYYA?K?&NqqWqm-&KAW?WxxpAa+1qqPdN2qmaYaP&iYqxxmxPA2A ?PqqMAA&a212W/iaWqP??AqWciiAm8YhAYiW2PW?xY?N1K2;mPYPA1&1q?XKWYmP&xAP?Pm&NaaAa1q2?P2W}WNN?i1xiKi&YAY2P??Y2aW1aaa1AqKNy&WAPmaAK2qN28m?YKPiqKqiWxx&AW1x?1qi!&AKYWK1KPmYmANKAxiNqKiWxP&AAW?aqK.PA1aq1qWWiYN2P&&W2*K&WxxxYPqm?a2aY1PYYYKxKYx&5xNKPK1Wz?iamWYmA&??qYYax&a&qqKmM?NWA0a&&xqxiPPmNK&i&&2?i&Nx1m1A?Y2i-WNx1W&xKPi2YNY?&K&P2AiaxWAiAm?aqq-Yxi?AAG?W2&mPP2P!&PKqWAP&aa?P?mixipN?1&1q?)iAa1N6PP1qqAN&m2Y2KZ?aWqx?Px?mA?KNiNIA1xa2&AK&WmxxNqK2?m2mYYaKNb?i?VxaWiNAPA1KfPiWa1Yq?i&YgKxPxqY&1NKY2ANYNAaK&xi1i1NRA2?aq&Kqi*mAYWA&WxqKW?xYPmK1KKimVAYxKY&20PW?aqYxK&2Y2AWKNx?N1K?WiPaANWPN&?0Ki*Y1Y?KY2Km&smxaaqq2?qf?UPAP&2KzqNm1mqaYPi?qWKiixxY&1m?KxYW2xqaP&Ni?i2mNN&AYiPqKxNa2AWPn?q21%xNP?112iYxxYK1&Ax&Yb{WYxY&AAq2a_KYKxYa212KmxqZTNVKN&1Wmm2aA&YP2?P2PW?AaaNKxKAOimmNAa2&1-?iimi&mAP12WKN1a-&WA1KmimvaA#PA1KKaNYmqAm?A2A%&x&aK&q1a?AxNfANA??qPi1i&aiNAPU&:qYNWmNAqA?212iWKNaPP1&iPi&g2YY&?11Wxi1YiaYAm?K2qWWaqaW1NK?I(mNN&aW&?Zq2:Y&YA?a?1qqDNAYaqA#KAx1B*NPaq&Af&i2m21-AaqiW?x5AmY?1NKN2AaxNPPP2&Wa2aYNYaK?&NqqWqmO&KAP?c2x!?NKaa2PK?i?a2Yx&Kqbmmi?xNaNAAWxqqxWx?PKA?qNmxm1NaPW&OqNmtxNYAAi2Y2KxqxAP1APK,_W>xNPa2&aKWN1mmNjP??AWi0mxAY211W?iPNANxAN1mqKm?m2YmA1i&2mWAm2a1q??i2iamNP12KKWNNx4KYYAY&1mNiix1Y?1xKNq2YiNxPx2aiq2mNWYmKP1Wq1W1mq&AA^i&22NWxa&qKAK22?mYYaP1qaq1iqxNA&A&2mtiNPa?Y21m?12TT?1Naq1KKaWxY&YqAx&12NYaxi&A1Ki22NY?PaP11qqNNYmqN6AAi1q,WYxK&q1m2&2KYaPq??&xKPi2aiN2&K&A#AxiamaY?&?2iaWWN21q1WKNi?aKYNPA&i^WWAmKaxqN?KqWHPAAaW1NK?xKmNNAPi2WqAi2mNYiK{?Y2YYAxq1NK?iAx15mN?P?1i_&iMmYNiK2&KW?x+a&&xKNi1xaEixy?q1OKlNNYqAP&i&WmYi2xPaPA?Wa2PW:N&P11?sN2PamNK&q&iqxiqPKYZ?1ixmNNPA&Px1YWSiYmY1A?xqNWmWNP1YmA???qiY&x2a2q0KaOiN?AYKm1?qNWNmA&xAKKm2YwKmWPN1 KWixm&NaAm&iiKWmxAY?1m&A2&QPaaYW?2?&m&NSPNPPKKKWWAmmYW&i?mqAi2x1&?Ai?ixmzPm21KqNVx2KmYYYP1iNqq5xxaaqP4KYimU%NNP?1PqxiWNqYmA11iq{mWm&AAANiN)?x2xw1a1&qm2Km&P1PK&mKAWxPYY21N?P22WmNaPx?W&iq&N1Nx1T1qWqxNYPY&&i?x2?WYNx1m1Y?12WYZN1aq&N#YiqmxN1ANiaq&W&Pq1a???KmnW&NxPx1P9miama11P21YWxxPP&YxAK?KqWY?m21A1qqN2AmKP?PNqxq1Wixma1AY?J22xqxZPPAYidmAm1Paa#qmqaWK_&aN&/&K2qWWNPYq1iKK+?/YPxaiqiWam1mKPzAY?qqP_YaNaPAq?x22YWN1?m&mq12qmgAiAx?&qa_mPxA2AE?Y2KYqNYa?AwKKx2mmYmKYqiWmmimr&aPi?A2AWKAPaW&aK1iW:NYAAY?NqPW2m&aa1xqW2YsKxmPNKx?q6?GPAP&2KfqNm1mqaYPi?qWKWixYY?1aWA2nmPN&P#1Yq1WaYxYKAi?m21WYx_a2?q?P0YWcP.&AK?K2mxmPYiP1?PWaW1mqaNqY?qq*CAA1a61YKKxqmYN1PW24qKi1xxaNAP2N2PW?Nm1A1iqmiYmKNAAN&Zi2WNx&Yq1N&A2K71aAa2A?KYia<1PaP11qqNm&mqYxP1?NmaLmNYaA1i??iPmNa7PP&qKWWPn?YiAKq?q2Wmx1&&1m?a2qY2Naa&1ylmi&f2YYKa&2qmW1P&amAA&221Y?xiai2mi2mYN?N2Kx1KqYWYm1&NAA?Am?xWa11Y1PWK2YV2N2Pm2qK}iFPNAW?KqiW?WqAmY?1NKN2AaxNPPP2&KimaYNAq?PiAKdW&x&Y2q1?q2qYWPK&aK1iPi1a2NPPW&WqNNixxaxK2?iiYvANiax&PqN%(N2YNA&&q2Ni&xKa1K&&K2YsYx1?N1x2%2qYqAN&P&&KWiamV&xAmqW2YrKxAPNKxKa2&wGPPP&1WKaizPxYPAPi&8ax2axaaq??N2q^qxX?K&YKPNx)2YAPa&mqmWxP2aaA&?fGP/&xWaa1>9xiKxmYYAK1W2NW!xWax1&?aimfiaKPm&AK?Wm8AY&APqaKWm2m&1&?p2N2PxKxWPA1mKW/imxY1PK?xKPW?xAaPA&?<qq41Na1x11Kiimm1xiP%&2iqiPYYN)?82AW?W2axaP1i?1iPNaN&PW&xq&22xmYi&K1?KaxYmiAqA1i1(WNxNa1?1iqP2>miP2Am?Aq?Rmmaa&1P2Nqxi2aqaPKY?_mDYAP?P2qxqPWim1aP?a?&2WUxN&Y2&mKii2hDYAPN&Wqqm&miaaPK?2WqWPaYYXK8iA;?>2PxPP&iK1WPYaY&Kx?x2&i2Nm1W1NK?2PmxAN1i11iPixaxA&&q&WWYW1x<Y?112A2KmmNYPKAWqNi6N2YNA&&q2NiWxKa11A??imWAN&PPKaK12qmN1YPq1+qAN1m_YPPq?Am&W2x2&(Kqi1T?NAN&?i1AKZi{mY1WAN?NmPWaxmY&q?KNi&MqYNaA&Kq12imAYAPKiPqaxNmW1WKP2&2qHxx1PN2aKYmxmAYiP??PWaW1mqaN?&?q2xW1NN?a1P?%i&m1N?KN1qi%WaxqN*1Y2NqWW&NxPm1NWq2KN&NWAa&1qWiKxAaY?N?A22WmPA1i1W2q21N1NqAx1Pq?mAmNaNAP?2qN3aNx1m1Y?12WYgN1aq&NGYiqmxN1ANiaq&W&Pqam?12P0WN2A?aN1qKq2naKNWPWixqA2iYq1aKxi^q&#xNxaP2mK?2qa1NNP21KKAiAm1&NAqKx2avqm3PY&mKP2?mm1xP?1/KPWmPNYYPi?A2PW1AmYWKW?Rm&W1PYPP1?KYNNmWPB??2KW>Ymx?Yqq1?q2qYWPK1KK&qxx5z&YxAx&PmmWaxa&11Y2YmxN?A&ax1KKK2Wa?YmPa1W4iimYK1xKmiN;NNmAPaW1mW2immm1Y&rK=q?N1mmY?A?&im&wxN1aK&x?Pi?mAPYP?&=qNW?mPaxAW?i2mb1mia3122q2PNYxU&,qAi?i2YxYPAi&12PxaxKY11xKN2PNNNPa?&miA2eNWYYAK&A2NxxxxA?ADKPqWriNxaPA>WWiANqNA?1qWEmWaxqYx1Y??qqY1x21a1AiimKmxY1PK&kiWWxmPY2?N?A22WtNAYK1WKqM&:KPaaWK2K&x&YFANAPqKqWoAxmaW?iKY2m^KNqaWKqKWiNm?PFAN&&KWW?Pqaa1K?iiaW&N2P?KAK2WNmPY2P&?a2xlmxYaKAmKN2bxWx&1A1NWNm?N2N8&a&&2miKx&A1AK&W2PYAxWaaAKKPx1GqNq?W&Ki2xNPNNqAa?aq&YYmA1m1PK22mmaNKAmAWq&mPmqaxa#??fqW2NNYmK2iYiaYPxi1q11W1mWYxYa&?&i2PifxiA2At?Pqq{AA&a212WQiqNqP??NimK?WNxNYAqx&22AW&NmPxAqW2immm1Y&2Kgq?N1mmY?A?&im&*xPKaK&x?Pi?Y1NqAN1WqKxqYAYm&W&K!KNxaaa1?2Kmi&nNYm1.&PKNi2miYm&i?mqaWqaxYK???WiPCxNi1212iaiKxmN?A&&2qmiKP?ax?A?xmNN?Pqa5&A?2iWmaNAKN&1iCWxa&1PA2KN2PjKa?a21mK17imxY1PK?xKPW?xAAYAPq6qNWAmiaPAhW&2xemxKP1KWqxi1+iY&KK&&W1W2NYYU1q2K2KNNN&PW11qAiKZWN&K1&JWaigPm11K??iiaWKN2PN1a miPNiN.?A2YqKOmxYa&?1?KqWePaqas&PK&iQ<YY1AaqxqYmixmYaAqi22aW&xE?m1&?2iYaaN2Pm&14&WmmaYqK2?aqKWmxq&i1xKxxaN?PNPY2&KxiKmKNWK??mqaiWPiaN?KiamPNiAqPa1AhNiAmAA2?P1PWYWPPKYYA2?22mYqxAPm1NKKiqOP1APK&K^iWNt?A1KmiWq1)mNmaaqhK&iWmxY&a2?mqimKxmaAA?Kmq2y&NPPa11KW2amAYY&N12iKiAaAAi?m?YW&W2NaYW122qixWWN&P?12i?i2mmY1&i&2q2N1x&aW1xK&q2mmNiY?K1K2WY{?Yq?21Wq1W1mq&AAP2Yq5N!PA1?12KN2&mY1PPaqNq1WWmKaA?P?&q2*Ya?Y21m?12l4?1Naq1KKaWxY&YqAx&12NYax&a&qYKaiK>iYaa&&2q?2PYYY&A<&P21N&mKaY1Y?1xN.xaCaqqqWNmPm&NWPa&LmxWmYWaY1K?AiNNxNaa&1:iPi&j2YYKa&2qmW1P&amAA&221Y?NNP&1qqN2AmKY1AA&K2mWYxKYA1N?c22x?x7PP1&Kf2Pm1Ya&Y&AKKWxPNYKPW?PmAWWxNa?qKKN2&WWN??q1/K3NNm1Am&22YmYi2xPaPA?Wa2&t&AqPmK?Wmx.>&YxAx&PmmWaxa1KKx2PexHYA&ax1KKK2Wa?YmPa1WfiimYK1xKxiNUNN1APaW1mW2immm1Y?mqxqNN1mmY?A?&im&WLxYYiq2KaZ?)WYPa?&iWqirxAYNAW?aqAYNxqPx1aK?JA>NNaaWK2KgiYmKAmAA&YqiWWxxAW1x?P22NNxWa&&xqmiNaqYm??1&WaW&xWax1&&2im0iaKPY&AK?Wm,2Y&APqaKWm2m&1&?*2N2PxKxWPA1mKWQimxY1PK?xKPW?xAAYA??#2NM?xPPx1WKiimm1xiP6&2iqiPYYN,?42AW?W2axaP1i?1iPNaN&?x&xq&22xmAWAN??qPDxPNAiA12P2xYxP&1q1WiYi1mpN?A1qAqAmWxYaKPWKN2&MWxWPAKYK?i>:yY1??&K2mWmaK1x1NiYqqx?xP&PK22MiNN1NqAY1iqqmKmWaaA1?WqNyANYPN1PK22&maYx1W&aqKiixaNKA2??W&WNamY2K2iYpA:?aWPN&KKaWNYxYx&?&W2Pi?xiA2PK2a2KmmNmP&K1K?2ir11APWqYqPxXaA1&A2KYqshqNxaYq%?imqWWx?1L?iKQmmmKPqKA&xn2!xN1aK1RWmixwPN2&N&&KPi/xmYY?m?Yq1WWaaa1Ai?Y2WamN1aq1PEai2YxYAAi&x2PNYx1aWAKKA22WWAKPY&?K2WxNWNKP2&AWaW1mqaN?&?qq^kAA1a,1P?qiAa&N2P22fqamqaa&YP2?P2PW?Aaai&YKAiiOxYPANKBq&WqmWaPAx?i2Kx?x2aNA&KYxPn?N??21qK128PmY?A,?N2?iiNxaWAa?i2ilxA2aqK?KPxPY2P>AN&&KWW?PqYK?&?iiazmN21q1WKNi?N.YNPA&i}WWAmKaxqN?K2mWANx?Y11K1xKnOP&&aq?zqiamiYiAxi22m<mAY1WPX2i2,aaxiPA&AKKNPm2YmPKi?q1xAaF1PKWixmaaxNKa22&K2i2a/Ya&q2NmYi2xPaPA?Wa2PWVN&P11?MNiKN_YaAq192YW?x>aN112a2KmmNYP&qKqmxamPAKPW2PW2xWIi1qK&?2q?gYNaa1KaK12qmNP&PK1WK&N1m2Aa?W2cL1YPxWamq2KmimYAP<Y=KiK(Na,iYAAA&KmPW2xmYKq??1MANiPq&WqNiqNxmKN2K&&2q2N0a2Nq???qxmW?NNPN1A#xiPmP1mAx?1qKyxmPa?1A&NLm=PN2aN&aWP21mmYmPa2}KWm2m&1&?o2N2PWqxxa2qW?inqmmY1PY&EiWWxmPY2?N?&qPW.NmaYKmKY21_WPaP&&WqxW&V2amAiqK2m3Ax?PmA2K&iPmaN1PW1aqAWYYNN2&K&A>AxiamaY?&?2iaWWN21q&x?Wi&m?N2&?&2qmW1YiamAA&221Y?xiaiq&K?ivmNY?ai?xqW2KY&Yi1a&K22NimJa&1&?2x1OAPaPm2mW1mKmiYYP??amAWPaYa&1_?qi1NAN?ai&aiKiimxY&K??xqPW2Pia&AP?}im:YPmPY11KWmam1NiPY&WmmW1mqYPqa??DxNqP2&a2NKq2ia?NiPi2YW222YKY2qx&K2YgYx1?N1??i21aANa&YqKW&xqYZA&KW?1q?YPx?a?q2i?q&NAN&?i1AKni/mY1WAN?N>iWWNaa11W?NiAmYm_1i&Nq?2Sxx1NPa&iqiWxP2Yq???PmPN2a^PN1&?Wi?aqNK&&&i2aWmx2AqAW?N2?x;NPaN12KiimNiYmPa&qWxWPxqYW1P&?2iHKa1ai&YKAiir?YPAN?xqaWqmxaY1mq>q?x1xY&YKK2iimNPN?Ax1qq?m&mWNqAP?Aq?xAx?Yi1a2K2i^Yx?Pa2AKKiKaPYAA2&I2AiKxWaqP12P2Kmxx1P?qK?2iPmPN?Ka&YWxiiai1a?1?K2mWANx?Y1NimiPm2N&AaqYqAiKxxA1AK&W2PYAxWaN1?WKiNTANi?W&AK2iNmi1+AY?YmAWqaN1qqK?Y2292Nm?q1AqmiNmKYqPPiAqKWKPi1Y???2xxWKNYPY11eNiY_iYAAP&1mmWPYFaY1??2iYW1NqP&KP?AWxmaYqP1?Y2mmhm?A1AYiYjKxiNm1P1?qx2qm?P&P2?NqPW2mmaa1xqWK%fKxiPa1mK2i?N&NN&m12W2xYYAY?&W?N2KWaNN1x1PKq2WmPx?Pi&Ki1iixYYAAi&?2PjNaxYq???PmPN2aUPNK1KqWYbiYq&K&KWNW1xWYN1A?2iN NNK111iqYiYmqAiPW?aqaxWaPaAK1& WiW?P?&mKYKAEq;<Y1Px&;iWWNx&Yq1N&A2K81NAaK&mKYiK+AYNPf&2i?i)xPY&A+&P21#aaYYi?q?1m1NWPxPaK?KiWP5SYi&2?mqNNWm?aYAx&iqiWWA?Px1PK2mNm&NPPM?mqYxmxYY1AW2a2&RWNxP&A2qmiiNKx?aaqYKimqm111?W2x2ax?xiPPAQKiB2mmYAP??mKaW&xPaaA1?WqK+ANY1m1PK22NmaPYaiKqK1x1YWAxAaq?qidPmEai?2KmiA<?Ymaa&&qPWam1YWPK?A2YxmxPa2ANKa(YWiaqa1q1iWmxmaP?Pi?PKnWiY2am1A??imWaN&PP&aK1iWMKYAAYqmqPW2mNaa?Y&iWqW1P11WKxKat?QiYPas&ii2WmxAY?1m&a2&3PaNYxP22q2PNYx*&9qAi?i2YxYPAi&12Pxax&aW1xK&q2mmNiP21JqAiNmWYq&&&i2aiKx2AqAP2YqTNTPA1?12ixiPmiN1APqaq&WWxxa&P2Km2ixKNYPA1?qm22m&YP&a11KqiNmKYaKi&AqPiZx21Y1A?22N+iAFP&&WqxW&G2amAiqKK?iaaYYi?q?1m1NWPxPaK?KiWPl.Yi&2?m2AW?NmYa1&KPiaX1NWaK&AqYmmmPY2PN?aWYiiYqY1K12W%xraa?ai&P?,iiN2YmAA&?2miax&aP1a?12WWKNAPYKmKPi2vNYa&Y1iiqi1a1AW?x?aW?WiNPYj1i22immAN?Am1aq&WPxaY1AW&K2AVYamaP12?NiaNYxi1q11W1mWYxYa&?&i2Pi:xiA21mKA2?mmxaP&&PiN2xW2PqPPqYKDx_aAA?A22x2Pcix1PPKaK&iWmxY&a2?mqiW2mXaAAN?W2qx&xiPaAKK2LqtPPYa,q6WAm?m2AxAP?iq1pPaaa&1WKxi&W2YmPiKKqYWAm?amP2?&2Pxax1Yq1NWY2qW4NA?11fKYiKaqYYP1&W/FW1miYYAWWm2a(aA1&NK2iNiYa&NxPK&KKWN?miYiqm2q!xxqx2?xAKKYiYT11NPA&A_?iWYPAY?K2&m1Wmx?a?AiW&22l2ARPaKiWYxmPmN?AN?NqAYxxKPm1YKKqWmNNZ12&Nq&iqxNNWAK?12AW?NmYA1&KP;a,1xiaY1W{miama11P2qYWxx?Y*&PPW?121WqAAai1x?qxKT&P1?mqiW=xNam&NAq&im?Wixi?m1P22maYx1xaK&YqYi1PNYYPi?A2PW1AmaPKW?am&MAANP&q2KixAm11mPa2K2xNaxm1WA&i&q&YNxx&2&AWA2MYxYYP1&xmmWPYi11K&2qmW(1x??P1?K?x2mxPK?mimK?WNxNYAqx?P2PY&xi1AKNi2x?-NNqPq13RKWYx?Y21Y&12qJ&aPaW&xKaiqT1YYAmK+K?m1mY1Y?Kqi2mxPx?PxAqK?p&OqNxa1&NIai&m&1q?A11WPW1P2YPAW?W2NYiNN1KqaiA21mYN0P?&ifOWaYq1?KNWm2?WqA1aq1qWWiYN2ANKN1qqaWam&&YA1?1mKWGaA1aKiWq2aJiNiPx22qmWmPYY&aHqij1YamiaA1A?KxPU2NmaK2?qxmAYiAa?Wqv*NYxxKY2q&?222Y5Na1qqP!Y22mPYPP?iaqAxxmjAi1Y?m2KrqxW1q1WKNi?N=Na&11iWYW?mAam1x?a4x;ax&aCKPK&2W,aNOKx1qiWiaYKYiAx?&m?txx1Yi1&WK2&N1N2&Y&AKKWxPNYKAm&A2xYYx1a1qKiN_AI?AWa1&mqmiaagYYAYiAgmiNamaNq1?m2?b?xi?&AqiPimxxNAA?q&qqWxm1aNqa?W0xW2NiaK&Piai1}qYNKY&qqxi1xN&aA&?&mqNPm11P11W22PkWNWPN2iqai&mN&xA?qWwPNxPA11K1W?iN5a1mPa&aO1i2,YAx?Pi&qxWKxKYWq?KNmqWAAxP1qWi?ipp2YAA1&KW1WKmWaP?q?qrYYmP&12&N?9i?mKNi&K&iqxW&YWaxA1&i2&YKxR11qai2mmmYN1PW2Rq1iqxN&YAq&z2AY1x21a1AWmm1aPNiPx&&Z?i&YAYNKN2?W2W;aaa&&m?Ki&N1NKPm1AqxNYm2aNAP?2qmTaNxAW11KK2imaNmP2&?i&iNYmN2?22YWAW?YWaN1K?aiNNxNaa&1-Xmi&62YYKa&2qNi&xY&PA???m2NaaK1A1&Wi2AD{NCPY2WqNWNPPYK?NqIUaYAm8a&1&?2x1haPaP??mKaW&mWaaP2?2W?W NPYi1iidimmAxW?mq1q&x?mxPsPq2q=NxPx&Ai1xK?2YmxPmPY1??liKa2Yx&?2YWPiAxNYWA&?2mWgYaK&&qxWei&JK1APK&Knix&Y?A1A?iWq1lmNmaaqkKYiYaANq&Nqi=KiYm2Y2AmiqqGW/PP1iKm222WaYx2PP&PK?Na4.Y?Pq?Y2aiWPVaY1YWA2qNaPq?K1YK2i2mm1qPPq&KWxaxKY11xKN2PNNNPa?&miAiYNWN2&K1iqxi&xmYKqY&2qqWPNN1?12KN2&mY1Pa.qNK&mWxxYPA2ii2PWqxxa2qW?2GqmmP1PK1WqPNAmWYaPK?Pm1Wqxq&WKA22p&ZKA#a&&xqxiPPmYaAai1q2xaax1Pq&?x2KoKxW??1WiAxYYqPjAN&&KWW?PqaaKi&&mYV?Am1q1WKNi?aKYNP&1Wq?NqmVYlqN2i=mx2xW?YA2KPiPe?1aal&?KqWYxaNWK/?Y2YYAxqYNKmi1x1BmN?P?1i,&2qYPYm1x&A2?x&xWYq1PKA2?NAN?ai&aiKikYNNiAW&q2AxPm&Y2AY?q2PYWx1aA1mKimam1NiPY&WmmiYYiY&1?&WixNmNYa11WW,i1#qYNKY&qK#WAP1Y2?a?AmmN1APai1xK&x?mxNPP22iqPiqmxY2KW?N2NYPPxYx?zKxxAW#N&P&12t1iNm2NWAA?1qxYNxAaAq?iNqPNYNP?K1YK2i2mm1qAa?Kqifam&a21?2A22mNNPP21&qaWxxmYYAK&m2NW_YWY&?A?NmNN?a2apKaK&Wm%KY&&1&iKKWaxPY&?P?&q2lYa?a?Kxiq4iWWNKPA&mqaNAmqANKm2?m17mxN&W1NKNxPdKPx1HqA.A2;m&Y&P2i1qqWqPW1A?22&2KYGx&Px&xKPNmmaYaK1&2WaxxaP&&Ax?K2KWWA?aWKAWYmqN>YNP&1Wq?NqxaaKP&KNW#BKaqaW1NK?xKmNN&aW&?9qiwm6&N?t2m2xYAmFa&1&?2x15NN2aW&Aq1ixPNYAAAi?zNiPaYaPqK?Y22b2Nm?qAWi&iYxaN1A2qq2xiWx&a?A22?22tmN11i&AiPiqxxNmA?q&qKiWm&&1AU2aFiYmm*&?1Yqa2dm2YNPaimqWmix&1AKY?Kim=YN&111K?WiPNqxWPN1?qxiqPaNiP2&A2YxKxiaYA?KaxAW?PYaW&rKNW1YAY?Pi?amPWixxa&q?Kx21WiN&?K1WKWNxYiP4&q&imNiqxaaaA&WY21s1AKa4AAiaxxYK1&Px&KqKiWP?YaAW?m2&n?xY?a1&K&xqmmP1?x2>K&WxxxYPqm&aWiW&N?a(&ximiAMYNiPW&xiWWxmPY2?N&qWKWRaAY?Ai?a224AAXa&11KxiWYPY&PW&aqFYxmPAWA?KKimmNPxPa1&K>Nmm&NWPa&hmxi?YWYa?KKmpNkmaWa?KA?WmNmPN?Amixq?iixa&PAK2N2aNWPP?Y1q?piAa1NA&a&m%mx1YKYi?N?A2WW&NA1PA&?22Y5qNP?W11KAimmiAaA1&iqYWWAmaP?ii1D?WKNAPN12qmNNm1PW?22PmYW2mW&KAW?Wxx-Aai1qqN(N2qmaYaP&iYq1W1PK1N?&2a2AYqxaai1iKxx2mmYmKY&&Wmmiax&aPi?A2AWKAPaKKNi_m1NqNWPa1KqPN1xmaAPa?WWqtAa1aKAWKPxAsWNaaK&P91iqmq1W?qq2qiYNmqaa1a?&xYWWN&aK&NqY2iaWYNANiPWWixY:axqA&T2&5&x2?1AKia2gxmNYA&q1qiiKxaaPA&2P2&W2NY1?&Nixi1mix2APqaqAiKma&YAq2mV?N2mq&PAyqm2qm&NWPm22qKm?xa1N?(?A22WONa1Y1A?KixN1xKaW1PKii1PmN?P&&NqnxAx?Y#APKmxNWPaBaK&q?WWYYNYPP??mmxW?miaaqP?i2YW?Na?A1KKKxiY?Pq&1&?LWi1xmamAaiJ2Y;YAAaqANimmiYA1aai&AqAiKPPYmAK&22a{PmE?m1aKax1_2PY&i2qKaiimiYxK2&mW?WaNPaq1i22iNW4N?PK1iiKiimxY&&W&1WAWqaNYPA??m2&HNAqaa1Y?iiKYxYaPK&mqqNimxAKAPKA220WaiPm1aKqx2maNKPm&qriiPYKYm?A?2WWW2aKaPKN?K6WmxNPP22iqPi?xm&xAAqW2mNKPx&y11?qiNaYNN&m12W2xYYAY?&W?N2KWaNN1x1a?&2.amN&a2&Yhai2mmY1K&?mqaWqP2a1Aa?W2=)Na^PN1AKimYmNYN?i&i2ai&x2AK?A?2iN;PN2aN&aqxxNvaNiPi&xl2iqY?YPKP22Wr^Nx&YW1?Wq2KN&NiAa&mq2mqmWYNA?qf2PWNx2ai1m2iim,aNq&x&aKKimmq1iAx?xz2W2NYY11q2?CPrqYxPa&qKxWYxm1xPY&2q2WmPqYK?&?amaNqaWPx11?ii&aKN?&1&22YibxqAKAi?x2&xWNxaP12WiiPT?YmKx&?K)iPxm&NAA?Am?WWmP1YKqixx1EmN?P?1i}&iYmiNdA1?&qNYYx1a1qK?D_ANWPW?q1aKiiimx12A&?qqWkPxxai1K212imYNAPi1xqPWNYxY1Pa&Wq7WNY!aNAA?iQYW8x?PN&xKYx2m&AKPaqPq1iqmP&aA?2x)qN2aC?N1q?ix?siNiKm&Pi2mKax&xPK?Y2YW1ANaA1AW?mxN1PYPP2KKYi2m2YmKq&,q#YNx1AWKAWAqg9&N&a221KWiN321qP?q&-xx?Pm1YKmWY22WWAKaW1Wbxm?N5YmKP1Wq1W1mq&AAJKP2&3MxYP1&aix2mWqPKAm1iq1W&mqA&Aq&L2Ax2NmPA1?qm2am&YPAa&1qWiKxAaY?m?P22WNNa1YAi2q21Y1PW&x&ai?iixPN)Aiq22Nilx?aKAi2K2i4xN&1W&xK12im&1KAY??q2HYm1aq1&K12KmxxiP?&AiYi&m)NPA1qAqmmWmK1KKx2a21x2NmP&1NqmHVmNNAPi2WqAi2mNYiK8?Y2YYAxq1NKmiimAaaxiPA&AKKNPm2YmPKi?K2xAaW1KKW2p+WaxNKa22&K2i2apA?&i&WmYi2xPaPA?Wa2imYNAPi1xqPWNxxYaAq&12Y}mYiaY1??2iYW?NqP&K1KxcFDqAq?NqPq&mixxa?AYKx^m3AxYai1WKxFWmxNPP2qNq?mKmgaAAN?WWiWAaPaq&xK&i?EiNxaq2KqNm1xm1Y?K222mJ1mian1P?1xYzxPmaqq?WAiixYYAAqqKqiWxx&AW1NK&2qmNxAPK&1ia25YmNK&&&a6axqYWax?A?KiNW2NK1?1J?2iAm1NK&1&KKWWPYqYWAa&K2PY1NmPA1?qm2am&YPAa&1qWiKxAaY?m?A22WwNAY21WKqGK7aPNaWqWWPm&mqAmAa?2qA%aaYaAAKKxxN#KxWPP2AKWia*KYPK1&qqqNWxYAK?&ixmCW&NxPx1P7miamaAK?x1YWxWYP&YxAK?KqWY?NmaaAWWi2qNKAx?m2NWAxYPPYWAmi22m>mAY10KxKNx14mN?P?1it&WxaKYK1x&P2?N1xqPNAWKKmqNANm1W1KWKxxYaY1&2?m2&WNNmAX1P?N22GiNm1i&mKaiqYxYPAq&W2Pi?xiaK?1?iiYeANia?&PqNWxmaYqPx?Y2mmHm?A1AYiYwKxiNm1P1?qx2qm?P&PW1qqPWAm?AAA?&i2axKxiaYA?KaxAl_A&P&&QKYW1aPY?1m&22&N?aaYW?2?&m&N/PNPPKKKWWAmmYW&i?mqaWqP2aaAK?m2qYiNAP21TqA2KmWYqAK&i2aWmx2a??A?qiNW&NK1?1Yix2iYiAa&1&KihWYxqYP1Y2N2PW?Nm?x1??iiaaPNiPx&&V?ixmPN2Aa&Wm1Wmm3Y?1A2iim:Ax2P12?KKiamiY2PWi12YNPm+1m1N?A2mYjNa12qAW1mKaiYAP&iaq&W&Pqam?12P;2Y2xPaW1WKNximxYxKaq2WNmWxm&PPW?121WqAAaK1KWiiNN?AxKx1KqYWYm1&NA?&iq1YAxa1YK2iamqNWPq?W&1K?NPm?Y?K22aWKWqAmY?1NKN2AaxNKAm&YqK2WxNYn&21qKAxPxqY&1NKY2ANYNAaK&xi1iqxxYaAq1#2Y mxIaN1??PixhWaqPm&1?iiQNWN&&A&N8Nx?Y2Y3?a?&imWKN&111i?KiamPN&&P&&K2WYY?Y2AN&&2YYPxWPa11KW2NmAYYAN&Pq2i&xaax&W?Y2KWmNN1xAq2?2PYPP21U&Ni1iqxYNiAqqKqiWxx&&?1x?1qi-&AKaW1WvxiANiPq?&2xkhi&xxaxAPWm21WqxP?aA1ixm?YPA?&Kq?B2WPm1&YA1?1mKNaa&a?qW?1immmNa?F&&qWWxx&N21m?i22W_NAaN1WKq}&.WYaP1&WKaWAxYANP2qKqANAai1m1Y2&22maxWP2Kqqx2Wm&Y?P2q?q2Wmx1Ai1a2P2KmxxiP?K&KxmmmAY2AY?aq&i2mA&PAi2N2qNWPP&11qqN2&mKYmPN2WK2mqmA1aKx?&2W+xNA1P1&?2iYN?NiAY&AqiixxPaN&g&KWqWPaYY;KgiA9?v2PxPP&iK1WPYaYKP1?x2NWPaNaPA?KmVA%?xBaP&mfNiqxxYaAq1E2Y^mx.aN1??Pix9WaqPx&1KKWxb1Y?AAqPK8mim?1?Km2Y2AxqxLP11xKw5WmxNPP22iqPi?xm&xA?&MqPcmANaA1AW?2WNPPY&22KKYi2m2YmKq&eq4NPa2NW?2?WxYW2NPPP1?JaiqVnN?K&&AWPx2aq1iKx2Wxmz?xq?11qKqxWYKP2PiiNKqWaxaY&qY?2mPyPN2am&aWNiAmiN?AP2AWxiqY?YPKP22WO)Na1aq&Y?iiqNKYmai&1q&iqY&YqP_?AW2:mNAa?&m?ai&mPPNP&&WqxW&maamAi?2qt3Am2aW1q2K2aNNxW&WqPi&iqYmYaA2&A2axYx?YA1mKx2aNxNaa&10iPi&:WNaP ixqKNYxYaKPWKNmmwaNqa1&YWa)C_?P1PY2YWKmixmAPA?KxqqL?a&aqA+KAx1=SNPaq&A+&Wxx1YK1x&P2?#ANPa&1h?qi1maPxPA&iKYWPYaNW&2&&*&xtaNaP?K?WiArmNW1i&mKaiqa2YaP&&TmmW&m2aYqa?22mC1A&Pm1aKqx2maNKPm&qyiWxxx&a?D21Wixqxi?NAqKaiaS&1YP1&1kKxPamAP?x?Ym&WxxKaKAWW?imUaxW?i12iKxYYq1N?N2YmPWWxm&21mKmxYNWP11W1X!a2imAYAPKiPqAWmx?a&AKWY2NNmNPP21mqamY3UN?AN?xqYN2mPA?AhKPq{Zia2aW1N?2xqmYP&Pa2aWqxixxa&AaKm2AW&AaaNqm?YqWNaaNPaKPKTmmaqN2Kx?A22WGNa&P1A?KixN1NiaK&aqPi&YPY&P2?YW?WPm<a&11??xN8?aQPa&q?9WYYNNWP&?x2mWNPqY2?&&1qNNxNYa11xnmi&NiAA?&2WKqNqxaYAqN?YqisANPa12mK&Ei*aY?P2?xWmWNmAYmK*&WW2NAP1&i1&WKiYQP1xPN12qPWamA1kA1q22x<&xNPm?>?q2PLWNia72&KxmPmKax?&??W&WamWa11A?&xxsmaWPY&KWmWNYxYmAmiYK2xmYiaYqaKm2ms1A&a1KaiNiAa?NNPq&qKCNKmqa?AYKxWWWaNKaa&NixiamqANAYqmKWm2mkYYAK2m2YW1xW1a11?qiNN&NWaq&PqAi?YAY?Pi?aWKWixYY?1aWA21sxNKP?1q aiYYxYAAi&x2PxaxmYK1YKN2aYixA1K&mqAimmWPiPR&YKiN2xaA?APiPE2NWNNP?1Pqxi1+?1PPY2xKa2HYPPYAPqA2mxxP2YiqNK1iimmYP?A&1KqWNY&YqPO?Am1W7xPYq1AW&22Z2Ac&Kqm?&mAm&1iPA&jq}WYPWYpA?KNixeYA2PaK?KWWPy?YiAY??q2;xYWaa1K?iiNYaNPPq1WWPm2miAWPt&PKqWAP&ax11?KixWPN?PAKYK?iTmNY?PP?xqWxixxa1AKKxq16?NA1P1&?2iYaaN2Pm&1/&WmmaYqK2?aqKWmxq&i1xKxxaNwPi1i&mlP2Wm1Y1PqiAqKWKPiaN?qiYs&YWx1Pm&mKax+mYYYKA&qWax2aN&1Am??2?WiA&Px&1KKWxoPY?AA?Pq&W0mqa11a2x21HiNmP1AiK!i2NqNP&Y1pW,xAY?Y2?x?P2iW1NP1a1&KWixm&x2Am&iq2irxAYNAW?qW&WiNaYK122q2PNYx.&kqAi?i2YxYPAi&12Pxax&aW1xK&q2mmNi1KA??amYviPqP121WWxxxaA?AiKPqeFia2Pm&AK?WmIaY&AP?aq1WWmKaA1Y2m2PM2xNPaKY?iMqF1A1&Wqxqam?miaPP#?iW2jmP?a?&m?ai&YANKAx1iq?xKYPN=&i&?O?NmaYaA?q?Si1HxN41W&Nq&iqxNNAAK?1WaWiNmaY1K?AiN(+aWa&KAKNxNY?P2PHqaq&>mmKa&?1?qix{aNqYh&Yqm}imYY?P2?YKwWqx&a1AKKxq18?NA1P1&?W2aB!1xPN12qPWamA1kAq2iqWx&xKYWA&W12PNaPW&^qa PiWmm12Am?mmYx(axYqq1?m2?{?xi?&12K2xVpiPq?aiYK2WPxPY?qa?&2&Yqx?11KPiix2sPNWPW&NXiWam&YNqx&aWWNAPa&AKAiPx?mNNaKm&aqaN1mPAP?KiqqaWixiaxq2KPiq-WYPa?&iqKm1miaYAA?iq?0PNNPx1PKq2WmPxqPi&Kq1mAmmPWPK2KZxxax1A21mK&2NmmaOPP1NK2iimmPiAm&aqqxxx&A?AWKP2xOia2a2KaKKWmm1Y&P2&mKKN?xxAAA/iNO?Nqx{PAA2KWia{A1NP1KQqxx&aPY21N?P2Kx?x2am112iixm1NKAx1Pq?WAYYYP&_?PqNW2xiam?iKm2arqPxPa1KKmiqaiY?&K&V2AWNxWAiAi2P2qmxN&P?1iKx2qaKYN&1?m:YxKa2am11&i2%;Px1?Y1&imiNY?AAPi?YqAWqYKYiAx?&WWBNN&aq&N?AiKm1PaPAqmqYi1mW15A1&iqYWWAma?1hKNi?WiYxPWKqqxW1mKaxPi??2ANqx&aBAPK1vAjmaWaKqKWxmam1P2Am?&qN4mY>aNAA?imW(Ax2aN1iWTiYmYA??N1NWmiqP1YmA???qiY&xYaiA,K1i&DN1YP1&1wKi&vAAa?WiqqaWixiaxq2KPiqtWYPa?&iqKm1miaYAA?iq?fPNN&x1PKq2WmPxqPi&Ki?iYYxNi?i2aW1WKYhaY1q?PiYNNN&aP1<qmiYYmYYP1&WWaW&xWax1&&2imoiaKYq&AK?Wm(2Y&APqaKWm2m&1&?w2N2PxKxWPA1mKW4iQmNaaq&YKiNA9/NWP&?PW2W xPYq1AW&ixm1NKAx1Pq?WAYYY?Ak?N2?WPNxaWKiKxi1MKYxa1&?qAmP-FPiP?2?DmxYxAAqA/K12xk)aWPx1PK2ximPN?Amixq?iixa&PAi?x2&Y?Nxa1AiK&xKpWNWKx&AiimqaaAiKS&&2x,xxP?mAqKP21VjYmaK2qKSi:PNAi?2qqqWYYm2aP1P??xa!iYYPA&iKxWPxNP^KA?N2&WqNNYW1KK15A_2x?PY&aK1mam1NqANq&qaiWx1aAA&Wx2mxWNYPKAWqNi&mWN&AA2&qWNNxY1&AYiY<KN2NmP11YK%xmYixWPN1?qxiqPaNiP2&A2YxKxiaYA?KaxAJjYPP&&HKYW1xaAxK&?a2KWiNaam12K?{&+qx(PA21K;iYmK1qAY&?K}WKP2am1mWY2&Nxai&PqNXx2KmYYYP1iNqAWAP?1aKN2YCmrNA1am1?K?2ia&N?PY&2qqiiPANKKa?W>WbAP&a?qN?2m2WqAAP?qxKii1xmY0AxiKq?x1Px1YAaKm22cANK?21qi&xAY61iAA&&maW&x&&qKP212aYlx&Px&xKPNmmaYaK1&AWYxWPqYaAi?i2xY2NmPm2Yi}qoNiN?Ka1iqAWAmK&PAY2N2azWN1PAKPK&2WsaNrKx&AiWWYYKYiAx?&m?Dxx1Yi1&WKqWN1xi&Y&2iqi?Y1YW&z&1WqWWxNa?qKKN2&WWN??q1XKBNNmxAm&22NmYi2xPaPA?Wa2&S&AqaKK1i=xQs&YxAx&PmmW1YiaY1??NixNmNNaA1mWvi1N2AP?&&xfxWNx2aY1a?Kq2Y&x-1P1?iWmqmNY&Pq?mijWNmAYi?Y?Aq2WNxi&!AN222Wm&x1AmKRqNiAmi1WAA&2qNWiPdaY1YWA_iNYPma221Kmi?m?NiK&&1WPNNaKAW1x?1qi*&AKPY&??1WxNWYN&K&iqxW&P?axAP?2mi Px?Pm2xKmhW.KAK?x2Dq1iqxN&YAq?xq1,NAaai&YKAii)xYPAN?xqaWqm1aY1mqi2Y+?x2PYA?Kqi&N1NKaW&P{AiWmaNKAPi1qqWqPWaY?2iYDWYZx&Px&xKPNmm?YVAN??KiLxxWAq1xK12KmxxiP?&AWYi?moYNA?1C2xWWYiamAA&221Y?xiai2miqm&W?P1P?2WK1WmxmYaKS?AqKWaAYaxKmiARWY&Pq&12qqaiAPNYAAAi?baxWmN1m1NW12mB?N?ai2&qxW1mKaxPP??2ApPx&ajAqK1iaNxNAPi1YqPma6WP2P&2&WyxNxPAKAWKA2mtWaiPx&1KKWxUPY?AA?Pq&Wdmqa11a2x21giNmP1AiK}i2NqNP&Y17WexAY?Y2?x?P2iW1NP1a1&KWixm&x2Am&iq2idxAYNAW?qW&WiNaYK122q2PNYx<&%qAi?i2YxYPAi&12Pxax&aW1xK&q2mmNi1KA??amYHiPqP121WWxxxaA?AiKPq3pia2Pm&AK?Wm6aY&AP?aq1WWmKaA1Y2m2Pn2xNPaKY?iFqX1A1&Wqxqam?miaPPH?iW2{mNAa?&m?ai&mPYaP1&WKKWAxYAmAA?2q(0Am2aW1q2K2aNNxW&WqPi&iqYmYaA2&A2axYx1ai1mK1qqp/N2Pq1WqPixmiYK&1&22Yi?xqAK1m&i21=&xq1&1q?yiAN2NqPq2AqAWimxaP?YqB2PkqxWPPAqKiiKYqxiPA&AKKNPmaANPW2W=Px&xqaxA1KNxazYPxPA&iK?WPYaY1Pq?NW&WWmqaP1A??/A9?xiPaKKKiiYR?YaKA&(2PW&x=YY11KaiY9ANia?&PqNIgmaYqPx?YWNi2YKYAKA2iMm.Ya&a2&a?Wi2NqNBAP&&q%iYx1aa1Y?A2iW?NPPN?gKPiq_WYPaq&iqKm?mYAxPi2i#ax1xKA;1YKq2PmYPNPA&2KyWARKYWAq?KqiHaxma21?2A2qmNx&PKK?KYmx5iAi?aq1qKm=xYaqAPKY5NBAN2ab&A?KiWmqP&a11NWxiqY?YPKP22WftNa1aq&Y?iiqNKNWAa&1qWiNxAaY1N?P22W&NaPx?WKYiK,mYN&x1qi?iPaPA2&_?NW1WqNYYi1q2K2WmaN1PW1NqAWYxNYPA2&&2aLxYWaa1K?iiaWKN2P?K&KNmm92A2?YqAq?mWxNaKAaKNpx-PNqaW&P??iimKY?P2?YKsWqx&APAKKxq1:?a&aqArKAx1V8NYPK2qqYi1mW1kA1&q2NYYxqYn1AW12:<YNK?q&YK1iWafY1Pi&YqWYmxaaaq1?2,YNiPq&a2P?Wi1m1NqKA&KqKNia?1PKx2PSxlYA&ax1KKK2Wa?NiPiimW2x1aPAAA?iWq14mNmaaq+KYiYaAAN&WqAi2iJPaNiAA?AqKYPx?a?q2Kx}KYNPW&&2KKYi2m2YmKq&-q0YNaW1KK&2KkA!&AiaA1/KHiYaWN?AY&PqiWWm&&?Ai?ixmN2P&&YAAiaiAaqNaPi&iqxN2xmamqY?2iN^PN2am&aqx21mmYmPa2RKWm2m&1&?62N2PWqxxa2qW?iOqmmY1PY&ViWWxmPY2?N?&qPWrNmaYKmKY21(WPaPm1KqYWNma1iAPqKq(DAmKaW1aKK2imNAaPP&qKWxPY2Yi?W1+qYiKxNY2qP&WqiW1Na1q1WKa2KmP11Pq&q_WW1xiam11&q2Es2xNaq1q?HxKk?P1PY2YWKmixmYAP2?1m?W&aAaq&N?WiKN?N2Pm&1iiWmmaYqK2?aqKWmxq&i1xKxxaYmP2&1K2i&iKa{N&Ax?xqPYmx1YqAPWa2YNxPK&Yq?iimqa2YPP1iYq1W1PKY.PA2a4iN?PN?PAWK1i1Dq1APe?Pq&WJmYa11aKY2A9ix?PP&N26iamqNxAYqNq&iPmramAY2m2YW1xW1aAYKWixm&NaAm&iiKWmxAY?1m&a2&jPaaaKA1KxiNRPPNPP1?qmmAm?NRPP?mmNiANxaa1q?1iYmmaiPY&?K2WY-1YqA&q1qKiWxP&AAW?N2?YKNNa&AWK?xqB8N;KN&1iWm2aP1x?1iiqAWexFaYqWKNiNaPAx&2q2iqiWPYN2AP?Pq?YaxPYR1&K12?aNNK1R&aqq2pxYANPmqKq4NAxmaAKqia%1%?xia12AKPmYm&AWaiiaqii=PqY2AA?e2WJmA?PxKAKPWNv2AKP}?aWYW1xiY11P2N21xWNxaP12iNiPnqNxP22WqNWNPPYKPxqZQ&NaaK?mA?KNiN;A1xa2&AK&WmxxNqK2?m2mYYx&AXK?iamaaxxKPY&YK1NNmYNiAA?Pq1Ymx&Ai1NK?qimxN1Pi&mqPmNm&YWAx?A,&WWPNaYK&?2mYNKP2Yqq?WAiK61YxAN&PWNWPm?am?A?P2PYmNxP11Kqx2Pm?YA&YqmqPW2mNaaKP&12momxa&eAW222&Y&PC&N&PKqixm21WPiqq2m01xYaX?WKx2Pb2PNaP1?Kmi&mN1qPa&YKiWKaxaaAK?m2qYixWa&&xqmiNaqYY&&&i2ai&x2aN1&?qimxiNYP?12qxxYm?AiPW2Yq1xWaP11PAiamx>NxAaiqWKA2Kmx1NPK&mKAWxPYY1A1iKqkxAaa1iK?iYxPWWN1P11qpAixmqNiAP?AqmYxxPaPq&?i!ANWPK&x2A?.i&m&N2K1&&qNWqxKY2qP?KmY9qaWPm1a?WxiIqPK?a2PW?NqxaYAqN?A2AY?x111KYiqxK/YN2P2&m_qi}m#&NAmqWW2NPAYY21PKP2?aaN&P&2qK?m1YP1N?qi?qNWqxqY9qKKx2PW4AWaxKqWYmWaYA1?NiAq*WxPiax1xWa2NNmPK?&1xKKiKoW1?AN?&qqfNmAaK112a2KmmNYPK1AqNi/NWN&&A&N Nx?Y2Y0?a?&imWKN&111i?KiamPN&&P&&K2WYY?Y??x?A2iWxNP1a1q22iNm&NqAN1WqKW1YAYK1m?m+KNxNNAp1&2q2/mPNPPiKKqYWAm?amPA?&2PxamWA2A&i&C4NNNP1K1WqAimmWPiAY&mqKWqmWAqAW?N2?xUNNa&AWK?xqmaYKPi?aK&W2x?AAA2KN2Pp2x&Pa&xim2KN&Na?aqqiWWxYAYK1N&22Kx?x2am11W&im^Ax2P12?qNW&mqaNPA?K21xaxKPm1YKK2AmNN3PW&xq&2WxmYi&2&AWaWmPm11?K?i(N0ANWa&&AiPi&.2YYKa&2qNi&xY&PA???m2NPa&aa2m??iNmNNAKx&AiWWYxKNW1N?&2WWWNA1Y1?KE2_m1A?P-2Yqax?mK1a?q2i2xe&xaPmqxiW2ANaNm?mq1iKiiYNYAAW&&2AxPx&YWAa?LxxHPNP?&1Aiamqa2NPPW&WqNNixNAKA9KAqKoWNaPK1KqNxamPYqPq2PW2WiaWYQAP&q2AY&NxP11Kqx2Pm?YAAP&&q#iqx1aa?x?12i8mN1Yi1!K2+qLPPYa}qSWAm?m2AxAP?iq19Paaa1AqKNxY{qx>PA21KviYmK1qAY&1qWNCxKY11xKN2PNNNPa?&miAiKxmYYAK1W2NW0Y2aN1&?qiNWWNKP1qaKKWmmYYKPm?Nq{mWmxYPP2?aqWY1xmYtA?KArimmNAa2&1S?WNx&Yq1N&A2Ky1aaaK&mKYiKjAYNP+q2qNW&mqaNP&?K21xAx?Yi1aWP2ibxN&??&xKPi2aiYPPq&xq2NWxNaNqPixT2N1aiaW2Y?2iPmPN?Ka&&q&NqxmA1?P2W;?NxAAYM1&K&22a1NqPq2WWKxPYiAAA1i2qPWWxWaNqiKxixaaAm&qqNiqm&mK1.P&?x2xWPAma?1IKNi?WiYxPWKqqxW1mKaxPi??2ANAx&afAPK1pA^?xMaP&m%NixNBYaAq&12YxNxPY?1mWx2?W)xPPm2NKqWxmaYqaS?Y2mmixYa?A2KYq*9qN&P11Kqx21m?YA&P15iii?a?1m?Y?AWqW#N1ax1J2WiPm&NqAN1WqKW1YaYK1m?Y2KiWNNaS?W?&XAXNAN&?K2Krmam&amPK?&W1WqNxaa1q&{iYmmaiPA&?K2WYCfYqA&q1qxmQmq1qKN2P2&xiNxP?1YqxmmmaYKPi?aK&W2x?AAA2KN2P.2x&Pa&xqmiYmKNmAN&BiWi&YAYNKN2?W2W;aaa&&m?Ki&N1NWAx&aqqi1xYam&i?Y2?W2NYY11qK&>1vxa*aqqqWNmPm&PiAx??qYUxamaa1K?iiaW&N2P?KAW&i&m4NqA11YWxxqaRAKAa2NqWNWPP1&1qimiam2NAAaqYqKWixma1AY?922x?x3PP1&K=2Ym1Ya&Y&AKKWxPNYKAm&A2xYYx1a1qK?4DAYmPq&12&KxiKmKNWK?&aqWWmx&a?AYWa2&n&Aq&1qNi22xNbYxKA1pq&W&m2&1PqKA2?mmx2P&&PiNi&mWYxA&122mWiY2aNPt??2KWiaKai1xK&!W*KNaPi&2KWN1m2AAAAqW2YEKmWPN1&KW2WmAA&P?&4K6x?amaxKN&KW&WaPa1q?WKx8A!KYNa2&Ki?iixYYAAi&x2PBNYVa&1q?WiPwxNiPKK?KYmx/iAi?aq1qKmdxYaqAPKY9N5AN2aV&A?KiWmqP&Ax?aq1WWmKaA1Y2Nq2xKxA&AKiimiYN&N2Aa1Wq2mqm6aPA&?vqYH1Na1x11Kiimm1NYP+&2qqiWxPNqAi?KW?WYaxYiKiia(1bKa=PY&qKPWYYNYAA2&z2AiKxWaq?&KxiaF1NWaK&AqYmNQ2PKPA2AWixmxYA&A2KaqW02aqa3&PK&i8IYY1Aaqxq1Wixma1AY?322lqxWPPAqKiiKN?NY&x1iWixaY1YK&k?Y2qWPNY1N1AK22.mAxKPW&qi&WxxaY1AW&K2A^YaNYPA??m2&.NAqaa1Y?iiKYxYaPK&mqqNimWY&1xKm2NYqNm1K1KiNi1mWNNAA&22NWNxK12AiKY2YNiPaPPqA?WT2 &A&&>qNqPmKmWaAAm?WWiZxN1aK&x?Pi?mAPYP2&#qNW?mPaxAWqiq1xPxx&xK&2q2WNYN1Pp1?q1mAmKamAY?KKW!NxpA21PK&2qmNxWPK&1iAimNWNK?K2xWaW1Y2am1&?NimxcNYP?12qY21mqY&&P&q2xWaxqY11YKm2heNN?Y0&xKW;ir1PPPx2xW&mqmWAYA1?;q?p1aAaK&mKYiKWWYNP*K2qPW&mqaNPW?K21xAxmAWAKiKmxNaN112&mq&iNxmPVAY??q2EYm1aq1&2P2qmxNaPq11qYWmm(YNA?1>2xWWYiY1?P?xmxN&aqaWKYK1iJ*?Y1&A&K2mWYxKNW1N?CW25PN&aq&N?WiKm1PAP?1iqaNPmiYxA&i?2xW1mia&qK?W2WaxPi&&qPi1mPm112PP&WqWWNPiax1xWammNqPK12K&KKx7Z&YxAx&PmmiqxPY1AyKmqKYqxXa#2NiWm?Y1x&&A&&HiiAmvYnAYiWq9W?NNPx1YW2ixNqNiPx1qpKi&Y11xKN2&m&6xxY&U1YKYxA.aPa&q2KKYi2m2YmKq&*qFYNxmAM?2iAxYW2NPPP1?SaiixYYAAi&x2P NYdaP1q?WiPgxNiPKK?KYmx0iAi?aq1qKm4xYaqAPKY.NLPxqax12WWiYNqYmA11qq=WPxqYq1Y2m2Ab2x2PaqAK1iiDiA1&W&L.mi&YAYNKN2?W2W3aaa&&m?Ki&N1NKaW&P.AiWmaNKAPi1qqWqPWY2PK2&mPNiA2aP1WKWiNaiN&AN&aq2Wim1&&A2?2mrN?mq1?1agm2?mNYNPAixqKGmxYaKPWKN2_ZWNNP&1qqN2WmKY1Aaqxq1Wixma1Pi?J22xqxP1YADiTmAN?N2&x&Pqii1xPAaAK&12x^NxP1N1P??imNANKAm&YqK2WxNY/AW?N2&WqNNYW1KK1iaNxN1Pi&mq12imZY2&q1WqNi?xxYqqa&iq2WANY1K1iKY2?ma1AP}?Pq&W,mYa11aKY21>iNmP11YK%i2m?PAP2?NqPW2mNaa1x2m2YW1xW&<11?qiNaYNqa=&A}1WN8dY?AK&iWKWixxa&?W?i2iY&N&PH1Yq1mPYxY1Ai?m21iixGa2Ki&c2&5&x2?11Aiai?xmN2A&q1qKWmmAaxqY?N4mW2P2&YKAK?2imaPKai&xK&WmmK&YP2&qqPBNa?a21N?&iYaPNAPm&?q&iKPYY&?N?aq&WNAxYB?Wi&m?N=AJP&1K:AiKmK1iPqqq*NYxmKaY1Y?1xNTANA??11iAmYYi1KPY&2q2WmPqaa1K?iiaW&N2P?KAK2WNmPY2P&?a2xxmmKA&Aaia8qxWNx1A1KqN22mKP?P2&NK&WYPPYK?N?12WWNNAa2&NKNiKN1NiAY&YqqximWaaAa2WgP<AP1Yo?i??m?YmPYPAKqKbW1mxY4&W?xqPW2PiaPAq?x22YWNNPN2PKY2xN:A2?aiYK2WPxPY?qa&r2?WqNYPaAWW3iYmY1A?m1NWmiqP1YmA???qiY&NxP11Kqx2Pm?YAAP&?qHWNx?YP1x?W2qx&xWPa11KW2amAYY&N12iKiAaAAi?m?YW&W2NaYW122qixWWN&P?12i?i2mmY1&i?x21WKNxYP1?KAiPD?NLPN&?KPWxmWYq&&&W2aW1xWYa1AKYnNWPx?am1&KNxqtaNYai&KWxWamKYmAqii2A 2xSPAAKKWiqmKNWAa&1qWiKxAaY1mqi2Y6?x2PYA?Kqi&N1NKaW&PUAiWmNY?KK?NqAWiPWaAAKKxxN(KNmaA&xVYi1m11K?A2xW-xNxY&&Ax?K2KWWA?Pm1a?Wxi^2PK?m2xnNxAaA&PAW?mm2SmNm?YK<iKmPN?N2Kx1KqYWYm1&NAY&i2AOPx1?m1&2iiNm?xiAx&1qiWmxPANA&?W2x(AP&&a1&?P2.mmNY&m&YK1iWYaYmPK?Y2NWaPiaaKq?2mP*iP/a?q?KmmammNKAY?NqaNim2AKKa2Aq1.Yx/a?1iW<2WNqA??Nimq?iqP1YqAqiWr?x2x1?NAqKaia(&1YP1&1MKxNYAYYKW&12m mxa&F1YKYxAYYPa&m12H1imm?Y?Pii&q/WYmi&21a2?#,N2Ax&aqYfaii :1qP*&BmNWx}WA2KNWYq2MPNPa?2aKNmxmPYiAa?PWaWKm1ax1N?P7N%Px?PmKA?25WmNYKPK?NWxW1maYWAy?NWoZNxAaiKYKA22bNNi?{1Ki2Wmx&Y&1mqs2NWAxi&W1A?22NgiA#PY&YjAxNYaAmP2i1qmW?x?Yiq&?42YWiA2PaK?ifm&axAx?aiaqiijPqYZA=WNSKiWa2a&2Y?2iPmPN?Ka&YWxxWaAAK1m&i21k&xq1&1q?niAN2Ym??12Wdi?a2A1Ai&K2aZPx&1P1&?2iYN?N2PN1&qYNPmW11PK2iq1NKaPa&A2KYxaO2NmP12&qmiA.2Y1K?&iqiYma2AW?K?AxxWKNYPY110NiAmA1??a1PWYi/PKYYA2?22mYqNm1&AWiai1#iNYPWimq2mimqA?A2?m21Y&NmaAA2K1x?mmPAPqqNqPi?xm&xA?&i2aYPxa1NAWiWmPaYNqaE&AQ1WNX6Y?AK&iWKWixxa&?WKx21WiN&?K1qKPiWmiN-K&?mWPWKNxYP1??<iPh&Ni1K&mqAi?mW1m?2&iqxW&P?axAP?2mi(Px?Pm2xK?2ima1PPi&YK?WaPAYKAKii0?NAPm1PKxKYx&{xNKPK1WD?iimi&m?22?W^xAx?&WA1KmimGaAQPY&Y)AiqYaA2??2xmaiixAaAAKWP2?B?A2PxA&iAmfY2A&K1&mq?W?mi&&AC?YqiY2NY1?KLiKxxYYA1Ka&iK}NqmVY5qN?1KWx2PP&NKqWi2AntNhPY2Wq1Wixma1Pq?E22x?m&YYKNK&2PIvYmPYqmqYi1mWAaAY?YUWWhNPa&1w?Yi1maPx1W&aqKiixaNKA2??tKi2xPaPA?Wa2YNxxi&iqai1iKmmNAAxiYqNxmxPa2A&KaRY^AxKPxK1Ki2KmaYPP&qPq&i2xYA?A2?Nq&,YAPaW&aK1iWUNYAAYqm?_2KY?Y2Am?1m&pmxAY211W?2i5i1m&2q?Wxm&m?1WP1?m2mWaPzamAKKYiN/aAiaAKKKLWAkKYW&i&?qYW2xqYiqA?i^Yk?N}aY&1KP2_m&Y1P?iNKim;xPaqPLiP.qoia2aq1qWA2?NKAP??1qqaWam&&YA1?1mNfxaAai&Y?1miYaYP?A1&qxWxmP&mPOqi2N#?xPPxKmKY2?WkNK?2&Pqq2baPAKAiqKqWxAx?Yi1aWP2i0Yx?Pa1iKix&m1PWAY??KiNYaKaqK2&W21U1xq?A1PiYi&m)NqA1qAq?iQmPamqN?qixWPPq&m&YimiaN2NTPY&K#qWYm?NsAKi2qiW1Nma%1xWKi&Y&NN?N1xiii%mYNiK2?xW?NYPa11qKKY2PaxNPPP2&WYmAm112PP&WqWWNPiax1xWa2?NNPA?&1xKKiKEW1?Pi&ifYx2YWAKA2WxqK-YNYa12N?ii1U?YxAN12ziWxxx&a?i&mWW:mAPYW11K12qaAN7AP&&qSiYx1aa1Y?A2iW?NPPN?yKPiq8WYPaq&iqKm?mYAxPi2ieax1xKA=1YKq2PmYPNP&1PKMWmmYAmAY&1qWxax&aW1xK&q2mmNi1K&YqAi?xmN2A&?PWaiWY2Y&K&2<QN+PaKaW&AKmiWNiNmPa1qqYiiPANOPW&&2Px2x*aPAqKAx&mxY1PK?xKPW?xAaPA&?Jqq61Na1x11Kiimm1xiP-&2iqiPYYNB?H2AW?W2axaP1i?1iPNaN1aq&NIYiqmxN1ANiaq&W&Pq1P??2P21Y2xPaW1WKNxiF&YNPa&2qii1P&Y2A2iU2aiqa?1i2m??iNmNNAKx&kiWWYxKNW1N2xqKx?xEPP1&KV2qm1Ya&Y&1qiWAa1AWA#q2q1x&x2PN1qKK}1oNYYPA&iKYWPxNAxPqq?qPNPa2AI1N212qmYxiPqKKqm2im1Y&Pqq&qqi:xAA21mi?2?mmxaP&qAKKWx=iY??KqPK&i2mYYqAPiWq1WAxmaiKaK12iDYNWKm&?*NWNx?Ni1x2J2YyKxAPNqY2Wix:PN2?i&PK?WmPxY?P9&P2mYNxAaAq??W_PNYP2?K1YK2i2mm1qPs&=mNW19WA2K?iNxmW?NNPN1AFxi&z2NAKP?xWNx?aN1K?q2WmiHAx&?a1&K&xqmmP??m2nK&WxxxYPqm??mNMNN?Yi&xi,iYmKNAAN2YiWi&YAYNKN2?W2W5aaa&&m?Ki&N1NiaK&aqPi&YPY&P2?YW?WNaxaA1i??iPNaxN12&Nq&ixxmYaP&&NmxW?YWY?KKixmY)1NWaa&AK22WaKxi&111_mxixaaKAiKN<x%ax&a%KPK?ivmNY?ai?xqWmq#qA1Axq}qqNqPN1P1&2iixm?NYAxqmqAiYmiYWAxqW2xWPx21N1P?q2x+2AWa2KqqmW1mYYB&W12WAW2NNYq1K?W2NW2AqPYK&KYxaYqAiAx?&KW,mxAY&qa&1fxWxPK&11Wqai1m2PqPW&Nq?mlxYa?A2KYq1,qN&1PAPix2qN?NP?Pq2izWNY1Yq1Y&i2qxKxiax1&W?ix!1xiP&2Kq&m1m2aYP1?q2xw1Nma_?2KNi&mxYm?N&Yq?WNaYAKAq22qaxNmW1WKP2&2qNmNaP21AqamYmANKAxiNqKiWxP&AAW?N2?YKNNaA1iWWiA{KYxKN&KqmiAxx&YA1?1mKNAPY1&Km2WimaPxWP1&1KqNAmKYKKi?NW?NYPm1Aqq?a2i;iNx?2&PK1NYBWY&PA&NqNWYPWa11iKmi1WqNFP2&xKPi2aiYPPq&xq2NWm,Y?1NKx2YY2xm&K&aWai2YWNe?&&NcNixa2Y+?1?YqibANPa12m?0wiY1P?aK&AqNi2xm&NAxqW_2NPAYa2AWWK2W3W1x&qKiKKNP:WY1A1&qmAWKxK&iA22?maaxxKPY&YK1NNmAYA?22aKPxYm,&KAY?222_mAqPN1AKmxQm&P2?PqK)axAa1&11m?NmW5NNN?Pqmix2Wa?NNPq&qK6NKm-A1A22Y2?WANmPx1aixiaO&NX&P1Wiiisx?aN1x2m2AWYxiaW1x2WixkPN2&N&PKqixm21WAYqq2mx1xKYW1PWA2WRaxKPP21?qma%KAmA?q&qAxaxqA2Aa2&2qW3NA?11DKP2qmA1&P2&2rkx1YqY&qY&22PCPx??a1&K&xqEKP1&PqWF2iPmWYWANii2aW&xN?x1?2WmANWAA&AqP)?WNma&mAa?am1WAaP1Kqq?a2i:iNx?2Ani?iqxPNaAiq22Nikx?aKAi2K2i+xN&1W&miAi2xNNqAKq?qqi(m?&&1m2PnWYxxK&K1qqPi2miYYPPixq&mWxN11Ka?qix3aN?1&1q? iAN2YNa#&?qKiiYKYiAx?&WW%xx1Yi1&WKixN1NiAY12qqmKm2YmPKi?2xxAa5&NAqiq22mANiPW&aKANNm?PVAY2&;PW2NNaP1K2?22cmN11i&mKaiqa2YaPK&mqqNixxaxqa?YQmxWPP?PAWK1i1Gq1APi&xKqNKxNA1?H2iB5Nxa2?N1q?ix? iNiKm1b?2mKYc&xPK?Y2YW1ANax?ci2maN&NWaq&PqAi?YAY?Pi?aWKWWNaYN122?2iNPNqa&&NqYiAYYYAPK?xW1WKxmYA1xWY22mNxmPKK1KqmYmANKAxiNqKiWxP&AAW?N2?YKx?111YWYmKa&YmPa&qs2Wam&YLqm?&qWWaxn?x1PKPx&siPA&WqKW&NArlY&A&&2m1W&xNaq1K?2xP/KAYaiKWqNW&mqaNPA?K21xaxKPm1YKK2AmNNO1W1&iAiNaNA?&2&hWaW&NmYK1&2121xTNaPqAyqYi?m;NRA1qaqKtmxma&KKKmma6PPKaqqPi2mWmNY?PP?xhNxBm1APAxix=&xqxW1Y11KL2?m1PAPK?mqYWK+WaNAFq2yWWWNPax1i&?)1YxAP&m1Ki&iaaaAq&W?xWAWKNNY21K2?2imYNAPi1xqPWNN(1xAx?&qaMmy2AKKai&ZYWiaqa1q1iWmxmaP?Pi?PK_WiY2am1A??imWaN&PPKNKqiWmxY&Pa?mqim2mAAaAmim:1xKxi1N1AKW2&mAPPP?&vqNW?DiaxAWqq2aQ1xKPxAiK?iANPxX1i1?W?xmYYYA&q&421Wxx>AWAW2A2qmNxAPKK?KNmxm1YiAm?1qYWlx2AqAnKP2PN7PAP1Ka?}mmmaYKPK?Ni/iKxqYW1P&q2iwKa?a21N?&iYaPN?P?22qxm&aNAh?PiKqYW2x2amqqKN2A(mAoaiK2WaxNaaAP?Pi12mWNPWaN1NWP2KNYPq&1qa=Y22mPYPP?iaqibYxAaiAxKPiNmxNaPq11qYWmNiYYA?&22Yi?xqa&?1?iqK:aNPa&KPK&22mYP?PP1bq&W1m?&NAPimqmNKNx&aAKiW2iY&N??N1qW2i&aAY2Km&KIKiWPaYYKWK&m&nAPYPYKqWPm1n&YaAm&KqWYmxPA2KKiYxxyKx2?&12K2x{YKPq&?&qmmi?xNaNAAWx2PXPA&aiKAiWx2(PNWPW&NriiqYKY^?A??qZWPNm?N1AKAx?YAP1P&2iKAiCm:YYKW&?2YWPxiaWA&W?2iZi1m&qA2iKi2PxNKAY?Yq1YNmAA7AP2qixWWN&P?12i?i2mmY1&i?YWPWYaxYaA&&J21>xAKaY1N?2i?YmYYP?1{qKN2mmA?P/2P2&W2NY?a12Kmi1a&YmPA12q1N?miYiqm?PWWNNAaYi1AKA2KaPN?P?22W&2&YAY&Ki&AqvWnxY&W1P??2YaNNK1hqAiix1Y1AKKK?YqPYxxPaPq&ix-a}1A2aP1WKWiNaiN1&K&P2AW2xWAi1Y?m2KSqxW1q1WKNi?N,xi&1&N2YiNxqAK1m&i21+&xq1&1q?XiAN2NdPP1qqAN&QqAPAmKxqmZ?a&aqA;KAx1dlNPaq&Al&i2m21l?KqiqWYYm2aP1P??xaFqx;a?2&qmmPYiAa?iqnWqYmx?Yqq1?q2qYWPA121iHN2qmaYaP&iYq&xmai1P??? q2jAN1aKK1KK2WmPPqP/2&KYxWma1q?A?2q?LYNaa1KaK12qmNP&Pq&xK1WNPaY??x2W(AxKxiax1&W?ixRPN2?i&PK?WmPxYA&W?m#KNxPta1AqKNxY5NPma2q2WYmAm?PWAN?Kqa+NaxaP1q?WiPW?NiPKK1qmWYmAYiP??P2NxxmqA?APiP}2xsNN111qqY2imqPKPW?aq1WWmNaA1Y2m2A42x3PA1NKWiqmKNiAa1Kq2W?Y&YN?m&2F2NYaAa??WKNiKwaYN&x&xi?xYYPNAAN&Wq&W2PWaY?Ki&mxYCN&aK2AKKiKaiYN&q2xmxiKxYaYA1WN2AHAA?aWK1iYmiaKNYP2&2qmNqm?A&Ai2a21WixYaW2mKaiaa1Aa&PqxqYN&mxYKAK&Wm?WaxWam1&K?2YaaN&P&2qWAm1mK1=P&?x2xWPAmYa?i?Yk?e x2PA&1KKm1mKNWAPqq2xxYxxAIAN?Aqi+Pxw?&1xKm2Km1PWAx&1KiW&PKaP?1?PCYzAxKPx2NKK2WmP1APW&aKKWPP1YqAqiW%1x2xi?NAqKaiab&1YP1&1*Ki,YAAa?2iqqaWixiaxq2KY21.x1mP&KiWaxaaPAP?Ai&2xWYPOaY1YWA2qNaP1?K1YK2i2mm1qAa2iK&NYm?&m?qKxqWl&N?a2K?K2imm1PiPiqPvNxKYWaaAx?q22Wra2aO1YKKmmmYN?az&K72WPaWN?Ka&Kmxx2xtaY1KWqiY5?xDPK22qmWmaAADaFqiqHYamiaA1A?KxPgmNKa2&aqP2.PmYaAai1q2xYaq&qAa?i2ifxA2YVK?KaWP9aYi&2?NKSW?xKYi?K?i2x4&aWaYKAKxWNm&YK&?12qmi1mtY?qN&qqKWaNx1&1qKx21mN1aa1qxK2Wit2aP?a?1qqQNAYaqA0KAx1/3NYPK2qqmm&mK1a?qi?2xWPx2&iA22K2AYAPi&m&Yi&i2xaNWA2qqqqxYaiAnAm?22&rNNA?&1iiaxNYq1?AN&ammWaxa&1A22P8xN?A&ax1KKK2Wa?NiPiimW2m2mr&aPi?A2AWKAPaNKN?&(Wo?PAPaqNq1mKmNAAA?&)qP.mANaA1AW?2WNPPY?mq&-1imm?Y?Pii&q=WYmi&2Aq2?mmNiAx&NqNVaiiEX1qPf&TmNxiYWaxqA&C2&y&x2?11Piai?YmYAPY&iqWWxYWaxAP?2GNWPaKaP&AKxiWNiYYPm&KqqiWYqYWAN??WE<Nx&YW1?Wq2?N&Ni&a&1KqWNPYYqPo?Am1W-xPYq1AW&22_2A4PaKqi?mWPmN?AN?NqAYxxPaPq&?i9aNqA2aP1WKWiNaiYaP&&NmxW?YW11KmiAgANaA?PN1ahmiama11P2qYW?NqmaYiAi?xm2>xa?&AKWiNi&/PNzAm&YWmWYm1YW?a?&2Wi2NA1Y1W2_iPcNN2Pi&miiWmmaYq?x?aqKWmxq&i1AK2qKmaPxP2Kiqmiamq12Aa&KqmWqPiax1xWammWmaWPm2P?Wi1m1NqKA&iqxiqPKaN?12WbiNIa,&Y2NKq2ia?NiPiimqP22YK1mqx&K2Y.Yx1?NAP262KmqNYAYqNq&iPm>amAY2m2YW1xW1a1i22iNm&xqAmK=qxiPb(1WAAqqZaN1mK&mAKKqimmYN?aq21qPmamTAi?K?x21WKxwAW1x?P22NNN&aP1CqmiYYmYYP1&WWaW1miYYAWWm2WxiNYP?A2qxmmmNNAPm2kq1m2aP1&PqixqqO2NxPa1K?2x&mAPPAmqWWqWNx&Yq1mqf2NWAxi1Y1A?KixaNNKaW&PSAiWmNY?KK&JW1W?PY1Kq&Km2a;qA2aqK?KPxPY2P}ANq1qqDYmiaq?K?1*N_1NWaN&AK2WNFTYK&1&i2YWmxq1iAWKa2xNWPPPAq1?64iL?A??mqYqAmqm.a1Ax?{WWWixi?mAy?q2YaaNiAY&AqiixxPaNP&?x2xWPAmYL?i??m?YmPYPA12KNiia NW&2?x2&WaNmAd1N?A2iNYN?aA&mqxiaYxYaP&&4WPW&mWYaAeWx2NW2NPPa1AWciNYixi?11qLxW&aqYKKP?ADgWqP?aNqYK?mi+1A1ai2xKmxqxP1PAY2m2mx&PN1aAPKx2i51Nq?i&Ni?x1am1WA1&?mPW?x?&2K12&eAS&AiaA1bKFiYaWYNANiPqKxYaq&?AN?q2qWQAKa&K1K2mYmAN2PN&i}(WYxY&AKY2a2PYKxYa212Kmxq:AYmPN&KqqiPPAYKAKiis&i?a1a?qW?1immmNa?k1Yi2iNY&YWPq?P2AW?aAa?AiKacKWiPNPmKWKxiP,2YaPWi1qmi(m?aA?iKm2AW2N1??AiiA22YNYPP??mmxW?miaaqP?i2YW?Na?A1KKKximNPq&JixKKWYxYY1qN?A2AY?PPYPKYKPxKVYN2P2&mnqWNmAYmKI?1W2NYaK&aKai1x1mmNN?W&NqNNPYWAxAai?qNWqxqY0qKKP}1dNYYaA&qiKWmRiY1A&&qW&Wqm>aA?2&KRaW,YmYe&&i1iizKYaAP&&WPW&m2aY???22NW&NY?PA&iN2imWxiAAqPq&i2xY&aA2?Nq&oYAPa?1?W2m1NKNqKm1?qNWNmA&xA&&2qAYPxi1NKKixmKN2P&?i&AK&Nam&Y&Kq2YW?WKPcY&1xKx2PamNP1iqKWNmAm2N?AY?aq1xax1Yq1N2&22YPxm&q&NW&mYm?NAAm?xqaxxxaY&A,2P2&WWxaa82xKA,WYqAY&1&KKWWPPAYWAN??mK_NxAaiqWKYwqJiA1&W22qai&m^&mPlqiq?N?Pm1Y1A2q2ym1NxP{KWqNW&mqaNPA?K21xaxiPm1YKK2AmNNB1W1&iAiNaNA?&2&tWaW&NmYK1&212qmxNaPqA^qYWmNiYYA?&22Yi;xqa&11?KixW1N?PAKP?F.ir?A??mqYqAmqm4a1Ax?JWWWWaA&mKN?Y2JOqNPP?2qqmm1aPAWK2?Pq1YYx1a1qK?:3&NWAWa1&mqmiaaDYYAYiAqqxaam1Kq1?m2?Q?xi?&1AiPiKYxYaPK&mqqNixxaxqaixRNxWNm?PAWK1i1Xq1APx&qKiWPxAYmqx?P2PY&PY1a11W22PkWNWPN2iKxmKmmAAA2&?2Ytax11a11?qiNN&xq&m1Wi22EmYNKAN&2mPiWmiY11a2q2WRaxKPP21?6mamNAmAY&1qWNMx1Yq1NWY2qExx1PN2aK&i&aqAa&?&K3li&xxaxAPWm2afaA1a2KYixm?a&NxPK&KKWN?xmYaPWii2PxKPx&xqNiNmYaPNWPm22qmWmPYY&?x2am1Wmx?a?AiW&ixYKxP?m&1Wim&mWNqAP?Aq?xAx?Yi1a2K2KNNPB&1Kqqx2Wm&Y?P2q?q2Wmx1Ai1m?Aq2-1A?PNqq?Axxm&AW&?&2qmW1P&amAA&221Y?xiaiqYi2q2NKN2Kx1KqYWYm1&NPi?1q?hxNNY2qiKxixaaN?&mq&)&ixmKYKPWi?K2xAxxPNAxKKE?pZx2PA&1KKm1mKNWAPqq2xxYmWacANK1_AW?xiaa12KAxDU&N1Px&WWPW&mWYaAcWxqaxWx?PKA?qNmxmaN&POimq&i2xY&aA2?m21Y&xi1P11Wxm&aANWPN&?=Ki?Y1YYKY2KWi8maPa?&x?qi?N&N&&mqKi22im?YPP_?YmPWKax1BK&WA2};xAiPx&x6ai?YNPW?AiPKWW1x1YqqA?K2KYiP?1?12vx2KmYYYP1iNqNmfmPAqAY2Y2xxMNa11A>iYiAO2NNPi26qYWYPAYq?N2m/iNPAaYi1AKA2KaPN2Pm1KR?i&YAAi?K2WWSxOAxaKA2W&22f2A:&KKqKWNYz2YPAP&?maWNaxaA?iKY2mVKNqaWKqKWiNm?PIPaq1qNpYmqaq?KKmqij1N&aqK&Kq2^mAP2P6&PKqWAP&YA?P?K%xEax&ak2mK&22mY1aP2&NK&WYPPY?A?i22xx&aA1qqi?A2!}rNY?W&NqNNPmKAx?&i?qNWqxqY#qKKx2PWBAWPAKqWamiaYAY?xiAqZWxPiax1xWa2?NmPA?&1xKKiKcW1?PWqAjYxqY0aPAN?22iFmaiPm1aKqmxmPYqa??YWmWqY2aNP4??2KWiaKai1xK&tWmxN1ai&&<KWYx?N11xqW2?xKxiax1&W?ixv1xiP&2KKWiWPxAiaiqqqiYNmqaa1a?&xYtKxWa&21KcmaYqAK?2q2dmNvx&YKqA?K2KYiNNY?K1iixWT1YmAm&at%iNY2Y11&?YimxpNPaN12KiimNiYmPa&qWxWKY?Yg1P&K2ix2xWaNA2WqiYN&Ax?a1?Wii1x&Yi1m?Aq&YaNN1x12iKm1LWYaP1&2iqiWmNY?&0?PqNW2xiam?iKm2a*qPxPa1KKmiqaiYq&K?m2AiqxWAiAs?YqiY2Na1?qNWP2KYWN&A?&W2xW1m?&P1Y2N2iNqP&a#&PK&iiN2NFPY&KWmWYm1YWK,?1qq)NAYaqAkKAx1V2PaPA2mW1NPmiYxA&i?q&xAxN&NK?222eNaN&Am1Kq&m1maPDAa?qK_%Yx?aZA2K1narKYmai&&WKiqxxNW?q2N2YNam2AKAAiA8iNmNY1&12qa2Wm2PqPK&Kcii2m&Ymqx?KimIYNKYW&NK+2P<WNWPN2iK2mKmA1A?i2m2YW?mtaKq2?q^?9WYPPx&ii2i5mYYK?m?Yq1WWP>a1AqKNxYQqx_PA21KdiYmK1qAY&?KjWKP2am1mWYOONiPx1?12Dx2KmYYYP1iNqAWAP?1PKY2?WV{NA1am1?K?2ia&N2P22_Wqx?aYA1A&iiqAWgxUaYqWKP2?MY1NPxK6WAmia1A??iiK2YWPAxaP1PW&maYNP?1W&x/A2)m&Y&P2i12mJAx?PmAaK&iPNNN&PW&xq&iaxmYiA2&)2Ai2xWaq?KKmqi)1N&aqK&Kq2zmAP2P&&NqqWKm2&PAa2N21SWxNPA12qN22mKP1Pi?YKiWqaiaYK1?&!iW&P&1;qxKPi2f&Ya?P2NqAiYmiYWAxqW2xWPx21N1P?q2x72AWan1?qNWxmY12Pqq?qW+Pm?ai1YK?2YmxaWPa&KKaWNaaYK?W&GDai*aw1AK&?2iYWpNq&2q?KK2WmP1APW&aKKWPP1YqAqiW2YxKa&&xK-i1x?BNNqPq1H9KWxmPN<KW&iWqNaPN&YKYiAxAnCNx?i&xqxNam?Nm&W217PxKPkY&1xKx2PamN?P9&Nq?2ixxYW&q1KKPxaxKY11xKN2PNNNPa?&miAiN+2YPAa&AF}iWY2ax1&&2imWWx&Px&mKNxqXaA?PiqNqKNxxNa&ANKmmNM&P2aiqN?imiYaAAPK?xKiW?aK11Ka&mWKWEPAamKWi1xP:ANmP?&&KKNYmqAm?Kq2qWWNm2&qAK2&2aYYxN??&NKaNmm&PiAN2?wmxYx1aiA1KPVNW&NWPx&AiPi&<2YY&?&sK2WAx1YK?1?KqW!PaqaW1a?KiPa1YmAA&?2miax&aP?N&xK2xqxWaN1?WKiNdANi?W&AK2iNmi1!AY?YmANNa^1i?W?0xaWiNAPA1KyPi?m?12?&2P8NxNamaNq1?m2?/?xi?&&xq1iKxxNPA??AWYW?x4aN1??Pix7WAYPm&1?ii3NWYxP11iq&NKmWYWqx?AWiN1PP1Kq_?&ixmxNPKm1qqPi1m6amPKiqqXW3ANa1Kmi&mPYm1ma?&NqNiAPxYNP2?P2aWAPJaaKi&2B&{KxWa&21qYmaYWAw?PiPqWWmP2am1mWYr!NxN??11mK?i?9i1&P2&2O;WqY2A?KmWmq?QNNNaA2xKARWmYYKaW?NWx2TY?Y^1P?P2ix2xWaNA2WqiYN&NK?aqqWiWxx&Ya1m?Aq&YaxN&mAY&WdaxNNa1P1DimxqTA1xAA?2qopaPPaAAKKx#1eKNmaA&xvYi2xNYPA2&m2a-xNmaY1K?AiNb<a2Px&&?WWmNlN?&1&YGYxKYiam?P??ixWqN?1&1q?diAa1NoPP1qqAN&m2Y2K32qKqx?NN?mA?KNiN!A1xPAKWqYWK{WaNA&?WqW)AaYa?10?Vi1Y?NKAm&mWKxxxN1YPqq?qPNPa2A#1N212qmYxiPqKKKiiYf?YaKA&j2PW&xHYY11KaiY/ANia?&PqNZSmPYqPW?PKqWixKA?AY2xqiNiPa111K2=iYmqNPAYqNqPi?xm&xA?&i2aYPxiax1&W?ia^xNqP21di2iDmYYK?m&2qAW^xWamq??Wm1WiAxaPqq?qmAm&N2PAiPqYxNa21iKmWY22WWAKaW1Wvx2TNiAAKP1Wq1W1mq&AAK?KmiWqa?&m2x?KiYmYN1KN&AqAN?m1AP?Y2KmKWYx2a21mWqiNTANm?C&ai2xNY21a?&21m1_mxN&W1NKNxPOYPx&12?KNiqmqNyKK?Y2?W2NYY11qK&IPBqYxPa&qK1WYxmYMAN??Kg,xxWAi1Y?m2K#qxW1q1WKNi?NZYYA?&22Yi1xqa&?P?qixnaNqa1&Yqmi>mNY?aU?xqWmim1APAxixg&xqxW1Y11KH2?m1PAP21?qYWam1AaA1&q2Nx&xqaxA1KNxaCiYYPA&iKxWPxNPTAP?qqW6Pxxai1KK?22mYx?Pq&&i1ixNENq?q2NWPW&Yiax1??YixNmNYa11WWgi1oiNYPWimqaWaP11N?P&BmqWaxiai1xW221mxNYPq&2KAN1mqYqKW2&KKx&xY&RA&KxixgP1mP?&HqNW?GiaxAWqq2aw1xKPxAiK?iANPx71i1?W?xmYYYA&q&z21WxxLAW1a?x2qy2x}121%KYiKYmYaAK&i2ai&x2a??A?2iNnPN2a&&aqxWmmYYKPm?Nq{mWm&AAANiNb?x2xX1a1&qm2Km&P1aK1WKPiim1&mP?&&qNWJaAa?A ?PimaNNqAx&aqq2lxYam&i?A2?W2NYY31qK&f1CxataqqqWNmPm&PiAx??qYpxamaYA1?WmMz1xqPN2YKqixT1YNKa&&q&Nqa1A1AYi(q&,xNxaP2mKPgimNY?ai?xK&x2mmAPAiia2PfqxqPYqPKqm4mmAPPA2mW1x?miaaAm?2tiNKP1YY?i?Nm?R?Ax&K2&?2mPYtAxAY&1qxYmx&AiA6i&q1YWN1a?2P??mN#YAW?Pq&q2.NxPaK?1&WiYWNNq1K1iKxi&NWN&&A&N9Nx?Y2YF?a?&imWKN&111KKm2Amx1YP1&1pKi&YA1a?qiqqaWixiaxq2KY21Xx1mPxKiWYxYaPAP?qi&2xWYPnaY1YWAmNWNPmaq21Kmi?m?NiK&&iWPWKNxYP1??EiPHPNi1K&mqAiAmW1m?2&aWNiWaW1P?&?qtm7aN2aA&aiYi?nAYmAx&aWxWam&Yr?P?PWi3NN?Yi&xK1ii<iYP&N&&qWiWxA1&AWiN2YN&x?&YKKi2qqY?AAaWK2K&x&Y7ANAPqKqWoAxmaW?iKY2mhKNqaWKqKWiNm?P#AN&&KWW?Pqam?&?iiaW&N2PN&&K&WmNiYYA?&?2xNYa4Y1?P?xmxN&aqaWKYK1ih6?Y1&A&?KiWaPPYiAx?&m?}xxPa2qiKP2?mm1xa?1iKai2mA1lP&&1qxWWaPa&AW?a2BaxNNa2&PqaiAafYa?i&xn1iiPxYx?2?W2NW2Aqa?K&WNxYYA1?AN&ammWaxa&1AP2Yl2Yqxaai1iKxx2mmYmKY&xi#xAP1YmA???qiY&x2a2q_?iDqN?AmKm1?qNWNmA&xA&&2qAYPxK1NK&iNmKNWPi?i&AK&Nam&Y&Kq&?W1xiP:Y&1xKx2PamN?P^&Nq?2ixxYW&q?x21WKNxYi1?KAiPs&N^aP&1qamYm?NAAm?xqaxxxaY&AD2P2?#VNNP?AiqxiWNqYxA1&K2xiix?aA1P?&2=WPN1PaKY?iMqj1A1&Wqxqam?miaPP+?iW2MNmJa?1K?ihK5iNxP&KWqxi1XiY&KK?Y2?W2NYY11qK&<PvqYxPa&qK1WYxmYlAN??K-#xxWAiA12P2xYxP&1q1WiYi1mGN?A1qAq?iixa&PAi?Yq?eaAAaK1KWim&NqNPKx1KqYWYm1&NPi?1q?)xNNY2qiKxixaaPWamKWK?NP-WY1A1&qmAW7NPa&1#?Yi1maPxPK&iqmW1mYY#A2qqqPxYm>1kKA2?22NxNPPi11qPmamKN1Ax?NqPxNxPY?1m2A2KmmNYPKAWqNitN2YNA&&q2NiWxKa11A??imWAN&PPKa?WH2^&A&&DqNqPmKmWaAAm?WWiWmxaYq1Y?ixAW9xWa&&Pi2iMmPNqAAi&2x_1xKPxAPK?iANYN2Pd&Nq?iPxxYW&i&1WPWxPx1&?q?WzYy1NHa?&1iAi?UiYaKP&iqxW&P?axA1&i2&YKxWaW2xiili(?1PaW&1q1iqPAYq?Y?&2JWYN1Y2qN?&nqmYAKPq?xqxW?aqaxKP?AzqW2PA1iK,KYiKXAYN?Y2mWi2?YYNK?B&U}1NmPWYN?qiPB1;?xia12AKWmYmPAWaiiaqiiMPqNE?&&?maNqaWPN&&KqWmNiNNA?1&2xxmxYY1AW2aqWx2x&&&KDiNiPNKNWAA&mqWmixmYAP2?1m?Wixi?mAW22mKYx1xaK&YqYi1PNY?Pi&1mAW1aY1?K?iqJqYxAWP11?{Pi?m?12?&1&WAWxPiYAAL? 2YYWNY1q&mq12qm/YPAq&q2YxmxAa2A2KamAYNxK1&1aWamqNWYx&A&K2Ni2xKA?A#&22AT1xK111K?WiPNqNq&Y&&q7iYx1Yi1Y?Y2qx&xWPa1aK2mWmaA&P?qWKpx?am1NPx2:.2WaaNYWKWiPr&vqPmPa&2KAWaYYY?PA?m2xWaaxaaA&?)XP4&xWaa14dxiANWYYAK1W2NW&xWYW1A2Y2?RsxcP1q?WP2iNqN1?1qWWxWaY?Yi1P&g2ix2xRaY1KWqiY%1NW?.&1KqWNPYYqPh?Am1WkxYaKqqKY21/WAdP11iKYiWPmYaAai1{YNxaPA+1mWPqW#1N1aq2AK1ixmKY?PqiaKixxxAaiAxKP_a9mxKPY&NKaxif&PKAm?AKKNmaAa&?1?YqiEANPa12mK1_imYY?ai?xomiAYKYW1a&&22x?xi1P1aKam(FNPY&W2NKaiimiYxK2?m2mNqxK1x?iKYi?WiAY&K&qW22Wm1Y1PqiAqPxYx&a/AqK1!AsKYmaaqKiRWNNQYY&q&WqNW?PKaNA&&W2?=NNN&i12ixj{mPYqa-2PW2WiaWYmA???qiY&x11P1Kqx2im?P&P2?NKAx2axaa?x?PWi-mxaaqq2Ka2KCmNq?i1WK&WxxmYNKq&?WKW2xmYKq??WMAYmAx&a21qmiNaWYNANiPqKxYa?&?AN?q2qWjAKaW1W8xmWNkYmKP1Wq1W1mq&AAK?KmiN?aK111?WW21mmYmPa2jq&WWxxa&P2Km2ixKNmPA1?qm22m&YPAa&1qWiaxAaY?N&2WKWAPA1iKmKYT&/2YaaW&2iqiWmaNKAPi12m6Ax?PmAaK&iPNNN&PW&xq&iaxmYiA2&O2Ai2xWaq?K?aBNWWPW&PK&KqmmmaY2PA?aWYWAmKaxqN?K2mWANx?Y1ximiPm2NmAa&K2mi?x&APAqKxqKM?PqPxqPKAmq/PAA&iqzqYWKmAaNKYimq&xAxN&NK?222lNaN&Am1Kq&m1mKNWAPiAqWWamKaPq1?q2qYWP1121i4N2qmaYaP&iYq1W1PKYTPA2ah?Yqxaai1iKxx2mPYqPW?PK?WixKa?A2KYqOpqN&1P1Kqx21m?P&Pq&xK1WNPaYi1Y?A2iWxNPPN&xKaiqp1YYAmKiqNW?*Jax?m&KW&WaPa1q?WKx{AFKYNa2&Ki?i2mmY1K&?mqAi2x1&?Ai?ixmN?a2aC2a?iiAmANKKP&W2aW1xWYN1AKY,m AN2ac&AKNiWmqYKPi?aKKW2x?A&AN2mq2N2PY1A1?2WiNmKNaANqxqaiKmmYqKi?A22WeNAYK1WKq3&W1xN&x1qi?iPaPA2&v?NW1WqNYYi1q2K2i.xN&??&xKPi2aiYPP??mmxW?miaaqP?i2xI&A?Px1PK2ximPN?Amixq?iixa&PAi?x2&Y?Nxa1AiK&xKkWNWKx&Ai5mqYiA2KV&&2xZxxP?m1aKax1}2PP&xqaWxNP5WY1A1&qmAWKxK&iKYiY:A6?AWa1&mqmiaawYYAYiAqqxaaA1&q1?m2?g?xi?&12K2x#maPq&?qiWKNimAY7A.?YmWW?NYaP1iKW2&a?NiPiimWAx?Y?Y2qx&K2Y;Yx1?N1Y?iiAmPN1Km1WilWxmPNvKW?YWqNPPA1qq2KP21aYN1P12KKcmAYaA2Kq&aqiWixx&21mKmxYNiPx1i1 ba2imAYAPKiPq?W?P2ax?&iYxmW?NNPN1AXx22mAN&Am?xKqN2xmamqY?&KCxiPY?aAiKAiA(K1PPYqNq1WWmNaAA2KNqqrKa1ai&Y?2iqYiYY?1&&Wii1a&AvKx?P22W&Na&PqN?KH&SaAa&qKWqxmAmKaNP2?KW?Wfm2aA11?KT1EKxWPPKqKKiKaPYAA2&.2AiKxWaq?&2P2Kmxx1P?qK?2iPmPN?Ka&YWxiiai1a?1?K2mWANx?Y1NimiPm2N&AaqYqAiKxxA1PK&WqPWix1?mA??&2NIfPAP?1%KPWmPNYAAAix2Nf&xqPNAAKKi1NaPxPA&iKYWPaAN&Ax?xqPYmm8AiA?i?mmNYNAa21NKixtnWP2Ax?&qa*mYnaNAA?iTYkAxKPx2NKKimeAYxKY&2^PWPx2Ym1aiN2Akix?PPqAix2qN?NP?Pq2i;WNY1Yq1Y&i2qxKxiax1&W?ixI1xiP&2KKWiWPxAiaiqqqiYNmqaa1a?&xY!2YNPP&2KmWaxxPWAa?Kqi;axma21?2&2NNmx2&2qYiAi?NWYNAK&a2NxxxaYKAm?qmi(AP;a(&A?KiWY2YmA1&Yq3NmYqYP?Y& d-NAa?a2KxKPiiU1YP&a&1KqWNPYYqP#?Am1WfxYaKqqKA2Y7iNWPxKWqxiPm2ANAA?2qg%AmKaW1q2&2WmaN1PW1KqAWYaYYPA2&N2axYmAYKAx??2YY2xPaaAWKqmNmPNqPx&2JWiVm?aN1x?Ym2WKaqai1x?qxKo=P1?x2NW1N&xxYYKZ?Y2YYAxq1NKmi&x1zmN?P?1iC&i2m21#??qiW?WqAmY?1NKN2AaxNPPP2&KimaY512PP&WqWWNPiY&1N?a22:ix1?&12K2xLmaxq&?qSmmi?xNaNAAWxq<xWNYPKAWqNi&mWN1AAqYq?Wnm&a1K??OmY5aP?aYqaiqmimxY&Pa?m<xxWmAAaAmimb1xKxi1N1AKW2&mAPPPq1&qNWYmAAYAA&K2xx1xAaAqxKNi&5qYNaA&Kq1maYxYAAi&Y2PNAm&ax1x?PxmW#aia?q?WmmYmAN2PN&isBiWY2ax1&?aimxRNNaA1iiY2ArKNxP?&YT2iPmaNWAq2N2PWqxxa2qWKNiNYiNWAa&1qWiNxAaY?mqi2Nf?mTPxqN?a2iTiNx?21qi?iPaPA2&X?Nq&iWx?&qAK2&2imaNmP2KqKWiNm?PhAN&AqiNWxAY2AN?im9/&AxPx&&?2WmYWYNA?&P2xNNYiY1?P?xmxN&aqaWKYK1iw!?Y1&A&?KiWaPPYiAY&?2aYAxKaKqii?q?N1N??W11qmWmma1^A&?W2xI&m2Pm1i2KimmAN?Am12q&WPYaNW&2&&H&xRaNaP?K?WiAbmNW1i&mKA22m11?AN2qqqeNmAaKK&?2iYW6Nq&2K1Kx7+0qAq?NqPq&mixxa?AYKxgmRYx1aWq7K12qmN1YPq1<qAN1mzYYAKiq2YW?mQaKq2KmimaYN&Y;KiWmxNPxNKAY?Yq1YNxYYi1AKP21amx?1i&Nq?2ixxAmP2&Aq>WWxm&?1m2A22mNxAPK1&KNiqmKN2KP&mWNW&xWYNK&2Wimx3xWaWq??2biY&A2aW&1q1iqPAYKAKiP2ax?NmPAAKWmm1m&A?aq&aqai&PYYN?m?P22W&Na1Y1A?22NEiA*P&&WKNx&Yiam&i?xW?W2xma1q&Km2AW2N1Pm&mWqiKYxYAA2&mlAxixW14Ax?K2KWWA?a&KAKqWNcWYK&?&2qNi&xY&PAWKaq&NWPYPAKYK1s#mNNAPi2WqAi2mNYiKo?mqKhYNNaaqi?mmq)xAPP2q}K?x?+?1YAi2i2PN1x&1N1N2KmaNAx1PY1UK?iiapYa&q2?BNYmx?Yqq1?q2qYWP?121i3N2qmaYaP&iYq1W1PK1N?A??mWW1NmPm1aWJiYmY1APqqNWqNKmYY2A2?mmqONxAamq0K1>2YNP-?aq&WAN1xmYNKW?N2NYPxK1YK&W?2NjqNqa.2Kq&m1mNaYPx?qWKEmmia11&?q{&3qxlPAK2qYmamKamaH?&W1W?miY1qA?W9YN2PlYWq&KNWYm?YqAx&YgoWqY2aPKPiN2?%%NNP1KAK?2imaPKAm1iq1W&mqA&Aq&f2Ax2x{aPAqKAx&mAPPPm?x?jW?Y&YqPL?Am1W7xPYq1AW&2262Aj&1K2i?iqPmN?AN?NqAYxxKPm1?K&{P_WPxPa1KKmiqaiYN&K21W,xYxAYK1xWN2KWWNP?A1WKa2KmP11Pq&qeWxKYKYiqN&q2aHax&?YAAim2AN2Nx&a&NWmWAY&Ym?a?1qiWYxW?m1aKax1YNPa&x&Y:&ixmKYKPWi?KixAxxPNA1KK}?j2NNa&&YsPiYYNY1&W?xqPW2PiaPA?Kmxx#?xiPa2PKKmNmaAW?PiYqqiOxA&1AA2a2mYmP11K1iiNiAmWN&AAqPq?W#xNa?PiKx2W9iNmP11YKGi2N?NtAP&&q>iPx1aa?Y&iWqW1P11WKxKa=?tiYPaz&ii2WmxAY?1m&a2&8PNaa11W?KiAmYPmPP&2KNWaYYNi&q&1c1xWaxaa???iiPW7Ni12&mqAi?xmNaA&?PWNix52AqAP2YqLNMPA1?12ixiPmiN1APqaq&WWxxa&P2Km2i 2x^PA1NKWiqN&NiAa1Kq2mqmPAYP<2)/Ax?x21x1PKi21mPPaP&&WqxW&02amAiqK2mQAx?PmA2K&iPmaN1PW1aqAWYYNN2&K&A,AxiamaY?&?2iaWWN21q1VqPi&m:NYA1?a2YWAxiY?1PKNWR PNqaW&P?qiimKP?P2&mq1N&xmYaAqi22aWKxmaqqiKxixaaPK&&KiqmNPgWY1A1&qmAWKxK&i1N2Kz1NKPK?q1aKiiimx12Pi&12mW5xx&KA&2?2qWcx??&1iiPmgamAYKA&)qxNixxaxqa2s)NfYA&ax1KKK2Wa?NiPiimqPm2aY&aPi?A2AWKAPa?1?W2ixN?PA&q2iKAiCmpYYKW?1mmwmN1Yq1:iiixm&NaAm2xi2iAYaYmKm21WKWiaNaA1W?&iANPN&aW1aKTNxmKamAY?KKWcNx+A21PK&2qmNxWPK&1iAi?:iYaKP&iqYi?xa&AAK?KmiN&m?111?WW21mmYmPa2#qAiKma&YAx2m)?xWP&1KK1Wqia/A1NPA&AR?iWUPAY?KiKqYW2x2amqqKaiKGiYaa&&2q?mAjPNm&,&?W1WYPY1K?iKmUPG?Yxaq&?i&iW{qYPAA&?WAW?miaa?K?Wia71NWaN&AqYWNmPY2P&?a2xmWxYaKAmKN,xWqa?aPqPi2TDmNP1Pq?YKiWqYKamPi?12&Wqa&aqA+KA>2H_NPaq&Af&Wxx1YK1x&P2?%AaYYNPi222ANaNm?mq1iKiiYNYAAW&&2AxPx&Y21YWa227mN1?&&mKA22m11?Pi&immx2Y2Ygqa&i2A^AxK?P1WW1i1mWNNAA2aq&W!mqa1K&2Yqixqx1&1KWixiaN?NiAP1bqim2mvYPPq?Am&W2x2&NKK2i2WaYx2PP&PK?NamqNLP?i&2axPa21qKiim)WamN?aq21KqiqaWYYaKq&_xNsm&ax1x?PxmB?NMPN&??iWxmWYiAm?1qYW x2A?A/KP2&tBxPP1&aiY2iNqN1?1qWWxWaY?Yi1P&G2ix2NNY=1?KK2iNKNiPx&&iWi1YAYq1N&A2K(mNAY)1W2qixm1NmPn2xq1xqm21xPq22_YNPx?PmA2K&m?YAxW121&W&mkYNYP&K&W2AWmxWAi1Y?m2KRqxW1q1WKNi?N!YNP&1Wq?NqxaaKAiKaq&c2N?P&1qqN2WmKY1&a&K2mWYxKYm1N?yWWW&aAaNqNi?X2n5PaP&?mKKW&Y1YKPW?PmAWWxNa?qKKN2A<iAWPA1KqxNNmKYmPA?xmYWamWa11A?&xxJAPTa?KKKKmNm1YWPN?AWPiWYiaY1??2iYWpNqP&K1KqWxmxAq?N?YWmiqY2am1A?A2WxqxAP11Kqx21m?YA&P1_iii?a?1m?Y?AWqWLN1ax152WiNm&NqAN1AqKW1YaYi1m?Y2KWANNa+?W?&7AoNAN&?K2K%mam&amPK?&W1WqNxaa1q&tiYmmaiPY&?K2WYCkYqA&?1qKpxm1a?1A2PqQxix?&?qmiYiANqN:A1&xq_mWmWAAAqKNqAEKNmPA1AKW6qmxY1P1&c^xW1aqY2Kx?N42NYPPa?&m?2i&Y?AAaWK2K&x&YLANAPqKqWvAxmaW?iKxi1jKYxaP&?qAmYm?Y5AN??qPgxxWai1mK1qi04N21q1PiY2yY#AA&?&2WxWPxiY11P2a2&QWNxP&A2qmiim2N/AA&NqWWqY&YW1a?12WWaNAPYKN?2QKrAAA&iqmqYm&m2aaPW?2WqWlNPa&1(?Yi1maYYPA&iK?WPxNP.Aa?qqxVYaNaPA?KmxxX?x_aP&m^NiAmA1?&Sq2WYxmxN&1Am??2?WiA&a?1YK2iq5i1APq2aKYmlxxYPPoiWq2xqPP&AK?W2iP011YP1&1kKi&Y&Aa?2iqqaWixiaxq2KmimaYAm1fKiK&NabiYAAA&KmPWWNaa11W?NiAmYPmP?&2KIWAmNYWAqqKqaxNmW1WKP2&2qNmNaP21AqamYmAN2PN&ipsWYxY&AKY&N_mWqA1am1?K?2ia&NoPY1iO2WxY?1x?Wix.Px-AaaiADWq2U/^1N&iKWKKNA50Y&A&&2m1*mNAa?&m?ai&mPYaP1&WKKWAxYAmAP?2qN/aaYYi?q?1m1NWPxPaK?KiWP}-Yi&2?NK6W?xKYi?K?i2xy&aWPN&&KqWNyAYKA1qaqi/mxYaKAAKN2/xWx&1A1NWNm?N2NT&a&&2miKx&A1Ai&K2aHPx&1P1&?2iYN?N2PN1&qYNPmWaaA1?WqN ANYPN1PK22&maYx1W&YqKimxNAxPqq?qPNPa2AT1N212qmYxiPqKKKiixm&1?Ax&Pq2NixPYqAx?2mWTNNN?P1Yixe6Ya1Aa4&&q&i2P1YqAqiWq2xKPx?NAqKaia5&1YPK1WK&N1xYAa?22a!2xWa2&V1&?KxA!KNK?iqPiqiPPxNKAY?Yq1YNxqPx1aKqq_mYYm1i&Yq?i2xYN7Aq?&21WKNxY11?KA6Ppqx&PN&YKAmYmANKAxq1q1mBxaaqPfKY2?,cxyP1KaKKWmmmY&?K?m*aWPaKYqKP228WMNN?aP&xWNmDo1PPPx2xW&mqmWAYA1?Uq?s1aAa2A?KYiat1PaP11qqNm&mqYxP1?NmaW?axaA1i?xiPtqYxPx&?iAi2xNYNAK222NNAx112Aii1wWYmNaPq11qYxaaxN?&1&YpYxKYiam?P??ixWqN?1&1q?!iAa1NRPP1qqAN&m2Y2K}2&W2x?xa?mA?KNiNtA1xPK2YqYWKpWaNKm?a2qW1NY&a?4??I1_YAY&KKiqmmPm?axPq??W&WqxxY11NWa2?NxNAPi1xqPmaLNP2AN?&qqENmWaK112A2KmmNm&KqxqN!3WnPqPd?PqPWiYKNK1A??imWAN&PPKa?Wt2M&A&&)qNqPmKmWaAAm?WWiCmxaaqq2Ka2&Q#1mP&12qYNam2YmA1i&2mWAm2a1q??K2akiN2aW21KQmam?amPa?&qAWmx?a&AKWYq2Yxx21K&NW?iKxmYYA&2KqqDxxa1qKNKYmaYxmi111YWYiAYqAaKN&YKiWAxPY1qm&SWiN1a?aqAR??x&mmPPPK2m?dNAm{YxKi&2WKWAPA1iKmKaiKhiYN1M1PqqiPxYANAP&?2mxAx?Yi1aWP2i%xN&??&xKPi2aiYPPq&xq2NWxNaNqP?K}xNaP&?AA#K&i&S211Pq&qTWxYaPA1?P?1m2WPxWaW1NWiixmx1a&?q2iWmqmi&NPq?a2aW&AYa111WKiYm?N2AY11qqW& WY1A1&qmAWPaYYjKpiA>? 2NNa&&YXPiaYNY1AW&K2AxPx&Y21Y2?22=Nx&PY2PKAimm?Y&PKiY2xxmxPaN1??2iYWjNqP&K1KY2imAYPP1imKYm*mqYPAW?iq%Y&xi1PAa&e7WW2PAPxqfKxhYmNPN&KKxq&WYPKYaP3iiqqmaYxPa12qYi)J?AxAP&Yq1WHmqaYAK?&mq%NAxPPqWK&iNmqYKP2iPqixNxaaW1xKAlPWqNPaYA;?fimaqYYAK2x2N}xxaaqKxKYimxgNNaA1iWNi2m?N1Pi1&qYiqxNYWP&2m2aWNxAaWAKKN2?+1AKPq2mqaxKmP11Ax&q2a#YxP&W1A2q2im1NKPt&aqqxNxYaNAP?2lN3aNxAWAK2K2i/xN&1WA?WKmPm1NqPPiaKixxaK121mK1qiF_NPa12YKNmmR2A2?YqAqNi2xPaaAAi,21x2NmP&1Nqms<UWNWKx&?2mWxx&AP?N2?#aYAmCa&1&?2x1)2YAaKqWW1W&YPNaA&2i2x8&xaPmPi222;FPxqPA2&KiW1_qAT?&??WAiPma1W1NK?2PmxmW1i&mKaiqYxNAAqimKiNNa?aK?1??cY3AxKPxK1KqWxmaYqaZ?Y2mmimi121NiNqxN2Na&?KaK12qmN1YPq&xK1WNPaY&A&iq2mx?aK1Kq2?P2WkWNN?i1WK&WxxmYNKq&KW&WiNaY&12?K2a#iN2aW21KmxPm?PWAA2iqWlamWa2KWKam&z?PWa?q?WmxNmAYiP??PeANYPmN2?A?qmNW2PK&Y2xKN22mPYaPA2vq1m2aAA&AK&Wq&Y1xA1a1miUqWaPNWPm22qam?mW1P?2q_2Yn?xYPx?W?aiK.iYN&x&aK&itYPY&PW&aq9YxxPaPq&?iTaN1P&??1NKqiqDk1KPP&7qxW?xKYaqP??2?Y2Nx1KKqiKxioANsPV&YzWW1xiam11&q2,92a?as&PK&iC>qY1Aa2Yq1Wixma1Pi?:22xqNxYW1&K?22N?N2Pm&1iii?mYY2Aq&imAWaaPa1Aq?Pxae?Px&qq2i NNmqNiK?&iqiYmaKA2A^Waqi4ANAaK2PK?i?a2A?&&qAq&NimAY_Ab?YmW}1NiPm&1?qiFm2P?P;?Pq&Wwmqa11aKY2AGixYPP&Nix2qN?NP?Pq2ikWNY1Yq1Y&i2qxKxiaYA?KaxAMKNK?mq&iqi2PxNKAY?Yq1YNx?YiA1WAiNNYP2&Aqqiim6aWY1P?iPq?W?P2ax?&iNxmW?NNPN1AIxiKxmYYAK1W2NWXY2aN1&?qiNWWNKP1&AK?WmHAY&APqaKWm2m&1&?J2N2PxKxWPA1mKW^imYNmPK&qKWmqmWYNA?qHq&x1x2PYA1Kqixm1NmPzK2qNW&mxamKN2WqAxaxm&mK12K2iNNNAPW1&qAmPmqN&AN?YqAxYxAYK1x212KLmxAPx2YKxmmmPY2Pm?aqK%mm?a&?P?qixWKN?&qq1?OXie?A??mqYqAmqm!a1Ax?_WWVxxPa2qiKP2?mm1xP?1eKPWmPNYAAAi?qWxPa2&iAA?F2SEYAWPN&NyPxmkxPIAxiAK;W&x&Y2q1?N22WWNAP11xcNiAmA1?PW1PWYx&PKYYA2?22mYqNaPK1iqa2&m2Y?&A&22NWPx2Y&1aKximwYNKam&NK)kWmaNxPq&2K#m2mSYYAK2m2a9KxiPaA&K2i?NANJAN&Pq2i&xaax?m&KW&WaPa1q?WKx:ACKYNa2&Ki?22mmN1PS&?mNiqmKYa1x2&2q*xx1PN2aKiWYmAYiPx?P2NmzxPaqAWKP2xDiNKP?12qY2?mqY&&1&KKWWPPAYWAa&K2PY1xqaqqWKY)KN&AP&W22KPiWmWYNKi&&2NWax2aiA1W&22>2Ab&?KiKWNYC2YPAP&?maWiNYaA1i?xiPmNaXPP&qKWWPmxYiAK21qijYxAaiAYKPiNNxxq1?1PWPm2NkYN&1&q2YiixqAK1m&i21Q&xq1&1q?_iAN2YmAA&?2miax&aP?N?&2WMxN&aa&mKimiy>YAa2&Wiii1YPYxKx2&WqWWaYa11*??i1NAx?ai1aK2iAaGN&P1&xqWxPx&YWAa?:xx=KYmPY&K?WWNmLP2AN?&qq_NmWaK11ia2KmmNYPK1mqNi0NWN&&A&NVNx?Y2Yo?a?&imWKN&111K?WiPaANWPN&?QKWNmAYiKW?AqK.xANYKAW?P2if11ma?1&KNiRYAY?P<&P2mYNxqPx1aKqqCmYYm1i&Yq?i2xYN:Aq?&B1WqNxaa1q?xiYmmaOPN1AKixWmANKAxiNqKiWxP&AAW?aqK9PA1aq1qWWmaN-P?PK2sK&WxxxYPqm?a2aY1ai1qKNKYx&GxNKPK1W/?WmmaNWKi?aWKNxaW&NKaiNxPMWNm?2&mqmNYm&P5?N21maiixAaAAKWP2?H?AaPa&q?XWYYxYAA2&l2Ai2xWaqK2&W21+1xq?A1PiYi&m.NqA1qAq?iRmPamqN?xW9WqPq&NKPK&22mYP?P612qAW1mKA1AK&W2Pxqx PP1&K+2Ym1Ya&x2YqYWKmAaNaWq2FANKaPaqA&KNiYFAPYPA1Kqxm1mKYmPA?xmYW1x1&N1NK?qimxatPa&KKiWawKY2A?2KK2WPxPY?qa?Y(x*ANia?&Piai1_iNYPWimKnmim?1?Km2Y2AWKNx111K?WiPaANWPa1KqPN1mqYqKW?YKKx&aq1&q2?P2WnWNN?i1&qNiam2YiP1i&q2W2P;aaPq2?72N&AiaA1pK_iYaWY1Ai?m21iqxZa21q?hiP%&Noaq&1qaWxNWYaAK&i2aiKx2a??&?WqqDPNAa?KAK?2imaPKPA&mq?W&mK&YAq2m2Pc2xmPa1KqmiYm&PPPq?xqaW?aq11P&&2qYWqxP&WA1?A2mDiPaP11iKYiWPmYxPq?a2YWPPWaA?qKmi1WqNfPP&qKWWYYmYAA2&(2aNAPNaYA1?Wmf%1xqPN2YKq2;mA11Po&YqKNqxYY?P(?Km2>mNm?YK1i1j2:_1aai&AqAiKPPY?A?i2kmNPaPa&qi?A2Ry7NY?W&NqNNPmKAY?a2mmAinx&a&A2W12qOqAW&Yqm?1mPm112PP&WqWWNPiax1xi22imYNAPi1xqPWNWWP2Ax?&KWvmPxYYA2?22mYqxK1&1aWamqNWYxP11iq&NKm?A1A2KYqz;qaKai1xK&CWmxN1ai&&tKWxmPNbKW?AWq_mN1Yq1:iiixm&NaAm&AK&NamiaYAA?qW&WaxAam?WKx2Pz2PNPP1?qmNxm?N<PP?mmNWAxA&??W2iZaNmNN?11mK?i?Ii1&Py&YKiN2m1A?KN2WmxNNPP?a1i?jxqH^NEKNq1WY2qY?Yqqm&?2NRNxA?x1&?22AaPNm&Nq2WixPPYY2PWiKqWWWPa1iPi2q2YaNxqPa&aK&NY(WY&PK?N2YiiPWaN1NWP2mNxP2??1NKqiqgQ1KPW&WmxWmm2YaqP?Wiar1NWaN&AqY2?mNYNPAixqmmWmK1KKx2a21WixYaW2m?D6imNY?PP?xWmWYm1YW?a?Kq1(xNNaPKNKP2?mmPAPK?mqYWKeWaNARq22Pr&xqPNAWKKi1NANm1W1KWKxxYaY1&2?m2&WNNmA*AN?Aqi/PxJ?&1xKm2Km1PWAx&1KiW&PKaY1??2iYW1NqP&KPKWWxmaYqP1?Y2mmHm?A1AYiY}KxiNm1P1?qx2qm?P&Pq1jqAN1m_YYAKiq2AWYxiaW1x2WixkPN2&N&Aq2ivxANKAW?qW&NKxKPxAiK?qPNYPi?xK2qN2.m?YKPiqKqiWxx&AW1x?1qiw&AKPY&?K2WYQ1YqA&qPS1W1xWYK1A&N(mNKPW1?12Kmi1a&YmPa&qC2WamKYmAqii2xhxAaa?KmiNmAaPxWP1&1KqNAmKYKKi?NWqxqai&WA1KmimtaARPm1KqYWNma1iPq2qKqNPx71^PWi?qfYYNa1W&Nq&iqxNNAAK?1WaiYJWAiA12P2xYxP&1q1WiYi1m3N?A1qAqK+mxYaKPWKN2dwWNxP&1aqmiiNKN8AA12qWmim1APAxixl&xqxW1Y11K/2?m1PAPAKWW&mK>qY1AY&i2xYYx&A*KiiAxa4ix.?q1HKwNNY2PWAxiAKDW&x&Y2q1?q2qYWPK1K1iQN2qmaYaP&iYqxxmxPA2A7?PqqZAA&a212WNmqNiNWKY12qPWPm?&aP<??qqEYNaYWqfKYiYaANq&Nq2cKiYm2Y2Amiq2?x&xA1a1K?1ixmNNP&N&PK?WmYANP&W&aWKiixxY&1m?KxYW2xqaP&Ni?i2mNN&AYiP2YxNxmAW1x?P22YiNPa?&mIxi?dvNPAmiNqAWAP?YW?P2YM&YKxYa212KmxqXLNdKN&1?Wm2aN&YP2?P2PW?AaaqA>??x&mmPP&qq?WixxYi&mA?&qm1Wqxq&WKA222iaNxqPa&aK&NYm&Am?i2PW?Wcm2aA11?K61!KxWPPKqK}x&zKAWai2qWAW2m?aY1a?1%a(1xqPNK&Kqixk1YNKa&?WxxWaAAKAi?x2&Y?Nxa1AiK&xK+WNW?aqiitmqmi&NPq?a2aW&AYaKAW?&x1ZIPa&2qqW2mWY21TA&&KmAWKxK&i1N2?mxaxxKPY&YK1NN72P8PK?qKKIYaNa&AP?6imBYPmPY11KWma6NP2P1?&2x}mY8aPAN?22i_maiPm1aKqmxmaNKPm&qriimYKYP1A?f2WxiNmaa1qW2ia &NtKm&&K2WYPaY??x?YHiNaANaKAWKPxAEPPYa.qTWAm?m2AxAP?iq1IPaaa&1WKxi&W2YmPiKKqmWAm?amP2?&2P!ax1aWAaKAiYNNx21K1AWAmiYmYY&&&22aiWx2AqAq2YTix0xma21&KNiAa&Ni&a2NWqN?xNYaqm?a2aY1PN1YKxKYx&LxNKPK1W;?iimi&mAPq2WKNYAxYK1YKY21aNNAPA2?KW2PYYAiKK&Yq2W2xm&qAAKm2NlKNqaP2AKKiKaiA&a?q1q?NWm1am1m?amBWYa2aNK&KW2qmPYAP?qAq?iixaAK1Y2N2mxWxxaPA2Ka2Wa1Nma)1?qAmixmYAP2?1m?iiaAY2KNKP2?mm1xP?1_KPWmPNYm&X?aWqWWxNa?qKKN2&WWN??q1*K}NNYKPWAxiAK/W&x&Y2q1?q2qYxPK121i_N2qmaYaP&iYKWW&mKaN1Y&imW_NNN?P1Kixm?a?NNPq&qK>NKmaA1ANKYqNnqaKPmAiK1i&lqP&Pq1#qAm2ZKAaP:Km2?T&a1YKAW?P2iR11ma?1&KNi=YAY?PH&P2mYNm2A>AKKqqKmYPNPP1?qmNxm?NEPP?mmNWAxA&?AW2P}YNKAKaY12K2imaqNAAm&NqKWqmP&AAK?KmiNPaqa22x?KiYmYN1KN&1iyx2aaA&AW&q2PpAx?1A1??iiaNKNW?11?Wi22aKAPP&&2qYWqxP&WA1?A2mciPaP11iKYiWPmYP&i2KfNxAx?Yi1aWP2ifxN&??&xKPi2aiYN&K&2_AxiPqaYA1?Wm#WWa2a&q&i3mNmPPKPW?AqmWWYiax11?KixWPN?PAKYK2iRmNY?PP?xqWmim1APAxixD&xqxW1Y11K92?m1PAPAKWW&mKjqY1AY&i2xYYx&AnKiiAxa}ixk?q1kKkNNm1Am&22amYi2xPaPA?Wa2&,&AqPmK1WNxnI&YxAx&PmmWaxa&1A22YyxNWPA?PAWK1i1jq1APi&xKqNKxNA1?i2irpNNaW?N1q?ix?5iNiKm&P?2mKaY&xPK?Y2YW1ANPm?-?iJqmxxWP&&?K2m?m2YmA1qiK2xPmq1x11?a2Wj0NN1o&NKAiiYYYAP2&NqiN;mYA2AN2&2qW6NA?11=KP2qmA1&PAqPqKxxxaY&A=Wm2&WWxaaX2xKPiPa&Ax&A&1X2iPmWYWANii2xgxAaa?Am2WmaaPxWP1&1KqNAmiYxPqiK2Nx1aF1PKDimmPaNNqai2?KiiiPmA1a2qKq2YxmKaY1Y?1xN7qAaaAqK??x1YNY&PP&<2mWYamaYA1?W)aIaa2&?qxiPiq=&YNAY&AWYWAmKax?1?K2mWANx?Y12WP21YqxK?&qYqAiKxx&NAK?mqA9xAYa111WK2VWAPa&W2qKaiimiYxK2&12xWYxqa2AAW12qlqAWPYK2WxNN8qYaAa&&mYiAamYq12KPiaNYN?aA&mqxiaYxYaP&&pWPiKYiY&1?&&ixNmxYa1AWKAima?NNPx1qq&mpxNY&PW??mqiWa&aY&aKii2NqNWPN&?DKWNmAYiKW?AqKDxANa1?JKxmqYN1mP&12qYNam2YNP&?YmPW?x?&2KmiA,1NYNP?K1YK2i2mm1qPA?mqNWKxqYPqA?K2KYiNN1?KqiixWM1YmAm&a<5WmmKaY1N?amiW&PqaxqP?Pmrj?PKP2&mKKN?mWAAKmixUaY1NmaNqWKNiNaPNK&xqKt?iNmqYqPViKqWWWAxaA?i2qmmaNxqPa&aK&NYm1Y1KK2NW&W?PWY11mKm2aY0xK12&xq&22xmYAA2&N2axxx1aiAYKPm1kiAxPNq1?WxNY?AqaK2&ZPWAm2YNAii5qKx2NxP&A2qm21Yqxq&a&2RYWaxKYm1Nia2PSqxx&PK2KimWYqx1&x1NWiiYaPAWK2&KW?NYaPa1Aq?Pxaj2Pxa?q2?qNNmqNiK?&1WAWxPN1??2KmiAZ?NW1q1Nq1imm:PWAx&Pq2xNm2AKAAiAMiNmNY1&12qa2Wm2PqPW&Nq?NKxNY&PW??mqWbxd?NKiimixaAxGP&&&K2N1mNY2PW?A21WxANaA1AW?2WNPPi?i1AKbi(mY1WA1im2mz1mqa8KiKxi&naYm?xK2KAmamm1m?1qKqixNxAaWA&KAXPEqx&PN&YKAmYmANKAxq1qq5xxaaqP=KYimxiNAP?12qY2XmqY&&1&xiniqaq1N?P?&WiHxN?aY&xim2Y}1xWPA&mw?iNmxNqA&q!2NW&mWa?qqKamiDiYaa&&2WKiWxPYxAi2WW?WYaxYiKiiaw1dKa9PY&qKPWYYNYPP??mmxW?miaaqP?i2YW?Na?A1KKKxiYKP?&1&?>Wi1xmamAaig2&)WNxP&A2qmiiNKx?aaqYKimqm111?W2x2ax?xiPPAkKip26pNPaq&AC&i2m21*Aa1qW?NAai&iAA?S2j#YAWa?&YKPiimWN&K?&iqiYma2N2?K?2xxWKNYPY11pNiqxxYaAq1p2YnmYiaA1??2iYWdNqP&K1Kxe^5qAq?NqPq&mixxa?AYKx*m*AxYai1WKx%WmxNPP2qNqAW2mSaAPK?W2qx&m1YNKx?qp?ZPAP&2KpqNm1mqaYPi?qWKiixxY&1m?KxYW2xqaP&Ni?i2mNN&AYiPqWLax1aWANKAiYNmN?P21DqAiNmWYq&K&aWNiWaW1P?&?qUmGaN2aA&aiYiA4KYxKN&KKWWPPAYWAN??mK-NxAaiqWK?2AmmYxPaqxqai&mvAPA??h2NQ?miPx1W2qxNgWYaP1&WKKWAxYANPP&?qmW&xN&qAa?YqiSKPxPa1KKmiqaiNWP&?x2mWNPqYAK?&?mYW?Pia1K&KK2WH&11P2qaWWxwaN&PAW?mm24mNm?Y1&2om&a1NmP?&?KiN&m2Y2K ?aWqx?aW?mA?KNiNDA1xPP&PT&xmYAY1K2&PqWWWxN&iA&2K2FmAxKPW&aqKimxNP^AP?qqxoYPPaqKzKmmPW2Am&1q??&xAaYYaPK&mqqNim&AKAUKAqK_WmF&?A}iNiKaxYNA&1W2mNNxYa?P7iYUKhqP2&?AP2t2AYqNx?Yq2MKi&Y11x?Y?Pq?WYANaK?S?1mKW?1mP?1qX1iPYaN0Km21WKWWNaa1122?qKmPxWPiK2KFiYmKAmPKq&qaNaaqAW1x2A2KmNx2PKK?K2imm11&Am&AK2W1P?YiAiWmXqxWxt?aAiKAiAfK1PPm&KK2WaxPNGqm?a2aY1x21YKqWq2aQiNiPx22qPxWmWaPP??iHqW.NAaN1Wi=wK!aPNaWqWWPm&mqAmAa?2qAZaaYa?AAKmixSaPxPa1&K3mPm?YVAN??Ki*xxWAq1aK12KmxxiP?&AiP2tNiN???2mWYWAYqYe11?x2CxWxxaPA2Ka2Wa1Nma#1?qAmixmYAP2?1m?0NPqaq&N?AiKY&N2AY1yqqx2Y1Yx&9&qCqNNaPa&?iKxi? YYx&m&YK1iWayY1Pq?NmYWqxxY11NWa2&/&Aq&&K1iPi1a2NPPW&WqNNixAa2A>KAqK0WNq1&A1?NmxkqP?PP2PW2mSxNA1AqKYqi0qaKai1Y??iaaANKPK2iqN2?Y11a?qiqqaWixiaxq2?1ix<YNqP21Aw1iqmq1W?K1KW&WKPUY&1xKx2PamN?PD&Nq?2ixxYW&q?a21WKNxYi1?KA_PWgaia?q?WmmYmAPqP>?1qxWrYWaaAx?q22Woa2ah1YKKmmmaYKPi?aK&W2x?AAPP&mWJW?a1aYqYiKcimmPPP??xKqW?Y&NqP9&AqWW&AxYKA??YimN1NKPm1AqxNYm2aNAP?2qm:aNxAW11KK2imaNmP2&?i&iNYmN2?22YWAW?YWaN1K?aiNNxNaa&1h5mi&=2YYKa&2qmW1P&amAa?qm2Qax&a02mK&22mY1aP2&NK&WYPPY?A?i2GmNPa1a&qi?A2,+ NY?W1nK?WNxxYYK2?KW?WWxqPN1PK22&maYx&m12KAiLmWYmK?12W&WamWa11A?&xxJAaWYiA&i12PNdNK?&1K22iqNqAY1K?xq2YYmiY&qA?aiimKNiPP&2q&iNYKYWP2?m2&Wax2aY1xWa2qYKNW?1&xKqWaxYYPKW?AWqWiN1aK1v2W2aVWx2a&1&K?Nam2aY?K?q2KWiNa1K12K?X&<qxFPAqqqPWNmmYAPx&2qaWqx1Yx???iqqWJN1aY1qKNimaYYa??&i!YiWPmYKAa?i22WWA1aMKaKAWmmYY&Pi?aWqW2xqYW1P2q2iIKa1aYKYKA2KmxP1aN2YiWWmmaNWKi&AWKNYPPa?&m?Ai&GWNm?21qi?iPaPA2&7&qqPWWxiY4q&Km{Pk?Yxaq&?i&i1m11KAN??qKOxYWAqKN2im_W&NxPx1P%miPmVNY?12m2xmW%iaxKA?KixWiN?YAKPK&2WJaN3Kx&A2miaa&1x1Nq<KWiiP1aq&N?WiKW1PAP?1iqamK!9aaK?&ASqNNNY1m1N222k4YNK&m&aqKiixaN&A2??WAWAPPaqKq&KmP5iAN1i&mKA22m11?P&qAqqyNmWaK???22mw1A&Pm1aKqx2maN&P7imq&iWmaY6qx?P2PY&xi1AKWi2m?aAxfP&&&K2N1mqYqKW2N:xx1aPa1q2?P2WHWNN?i&xqxNaY&A?aiqqqiYNmqaa1a?&xYWWN&aK&NqY2iaWYNANiPqKixYO1mKmWYq2DPNPa?2aKP2zm&Y1P?iNqKm,xaaqP-KYQNWWx&Px&mKNxqgKP&PW?aq1W2YqYiAx&qmK)Na1a2qYiKm2Wq1NPq1iL?i1aPN&PYq?i1W?YKaa?PWm21YANqAx&aq?xKmqN^AAq22Nibx?aKAi2K2iwxN&1W1KKaiim2NWK1&PsPWiamaNAA?mmT4aa2&Aq1iKximAN&Ka&&q&NqxmA??ji+q&%xNxaP2mKaiaa1Aa&YqxqYN&mxYKAK&Wm?W1aAaq&N?AiKN?Ym&x&1qiWmx1YYA ?2WqWfNPYWKTiAi1NaNi&m&aqKiYxNP,A&?qqWLPmqai1K2?2YNxxi&iqai1iKNzYYAq&P2YxNxPYqAx?2mWsNNN&&KI?xVLmx1Aac&&q&i2P1YWAN&2mqU1a&1WKAWmmYYP1YP21W3KiWmW&x?iq+2mYPmWa111?qxA>_YPP&&0KYW1xaaYAA?iq?wPNNAQ1PKq2WmPxqPi&Ki?iYYxNi?i2aW1WKY_aY1q?PiYNNN&aP1<qmiYYmYYP1&WWaiiY2ax1&&2imwAN2aP&aixi1miNAAP21q&WWm11&?%KmmxW?a1aYqYiKwimmPPP??xKqW?Y&YWPq?P2AW?aAa?AiKapKniNYa?&apAiwxPY&A^&Y21ZaNYaA1i??iPmNarPP&qKWWP{qYiAKq?qYxxmi1iKa212KxcNYPq1PqYmNmPN?Amixq?iixa&PAi?Yq?daAAaK1KWimAN?P1P?2WK1WmxmYaKf?Y2YYAxq1NKmi?x1MmN?P?1i7&iYmiNGA1?&qNYYx1a1qK?6qANaPq?q1aKiiimx12AP?qqW0Pm?ai1K21qAWxPmaKK&KaxaYqPWAxqAqKXNm2aK???cq2%AN1aKK1KK2WmPPqP(?Pq&WTmYa11aKY2A4ix?PP&N2_iamqNxAYqNK2mKmA1A?i2m2Yx&x2PaAWK2VqWWNNa?&xKqNapiN2PA?YWKWixYY?1aWA2XmPN&PT1Yq1WaYxNmaqqKqaxNmW1WKP2&2qNmNaP21AqamYmANKAxiNqKWmmAaxqY?121YKPNYAKaKAxq>aNiPi&x*2WPxqYW1P&?2i4Ka1ai&YKAii-?YPAN?xqaWqmxaY1mq{2NW&mWa?qqKaiKHiYaa&&2q?W&mqaNPW?K21xax?PmAAK&z1%xawaqqqWNmPm&PiAx??qYwxamaYA1?Wmp/1xqPN2YKq25mA11Pc&YqKNqmYY1PW?A2mY?xNaxAqK&IwmNN&aW&?^qi2mAYRAW?mm?W1P1akKNKa2&XN1xPAKWW&x?Y21UA&&KmAWKxK&i1N2qmxaxxKPY&YK1NNmAYAK?2AWPxYxP&KAY?2226mAqa?K&KiWan&Y2&q?NWYW?x7aN1??PixDWaiPx&1KmxxY&Y?&A&bWNWAx2YP1a2x2K;iNmP1AiKBi2NqNP&Y1yW_xAY?Y2?x?P2iW1NP1a11?i2YFW1mPa&aWKxx<YAxAYi&qxWKxKYWq?Km2aWWAiP?KKWmm&aNAP?1iPqWWmP2am1mWY9rNxNN?11mK?i?ji1&Ax?1qK4xmPa?1AKP2&dIxqP1&aixi1miYmA11iqEW2YqYP?Y&r+)NAa?a2KxKPii,1YP&a&KK1WxxNYP?N?Pq?{maAYE?WKYiKWWYNP&&WK1WAYYY?AS&&21N?xKPmA?iKmxmNAYaqK?KPxPY2P_ANq1qqEYmiaq?KKmqi;1N&aqK&Kq2>mAP2P;&PKqWAP&ax11?KixWPN?PA&PK&ip;qY1Aaqxq1Wixma1Pi? 22xqxP1YA i-mAN?N2&x&Pqii1xPAaA1&q2NYYxqYT1AW12:jPxqPA2&K2i2aOA&&qq?qqYmm?aN1N?AxxGPNP?&1iiamNYq1?PN&qqqiBPKYPAF?x2?EKxa?P1?K?x2mxx&&AqiFiiAmfYVAYiW21#iNmP1AqK8i2N?x&aYqNK2mKmA1A?i2m2Yx&x2PaAWK2RqmxxWP&&?K2m?m2YmA1qi2x=1xKPxAPK?iAmPN&Pk1qq1WaYxYAAi&Y2PxamWA2A&i&37NNNP1K1WqAimmWPiPm&aKqWYmi&AP{&Wq&BPa2aw1P?qiAa&YxA1&K2xiPx?aA?Y&NKix2xA1a1mWmm1NKNi&N&AqWi&xAAPA&&22YYax2aNA&KYxPJ?N??2qa?&mAm&1iPA&Vq WYPWa11iKmi1WqNMP2K?KGWPm&Y_Pq?12ahYxAaiAYKPiNNxNaaK1mKqximAY2P!?AKKWWxqaKAiKa2mc2N?1A1qqN2&mKP?PYqxKixiaaA1AKq,2Y9qxPPYKNKP2?mm1xP?1iqaNPmiYxA&i?2xWPx2&i1P??imaxN?ar1PqmNNmAYAK?qiWQiNamaNq1?m2?D?xi?&1YKi2cm1Y&PNiYq1W1PKYl?A2&<AYqxaai1iKxx2ZiN1Am&7qxNKml1&AxiN2?N2m2&A11WmixYKNq?a&PWWiJa&N2KN?&s2WiPAPmqm?AmKe&AaPAqWK&x&m11NPx22q&x1x?YiA1WA2qNYPi&Wqx.aii)s1qPH&8mNx2amA2AWWYq2+PNPa?2aK&i&aqYm&?qPWqN2mPYWAW?NmioxNx?aqmiN#Wmm1PaW&1q1iqPAYxAq&i2PwAxm?x1PKPx&YxPaP122KPiWmWYNKi?qWKWzNAYK1WKaiKmYYN1^&PqqWaxY1PAA?22PNAaiaWK.?1dPhxAx&&KqKWmYm1Y_P??1WAW2m?aY1a?1 a;1xqPNK&K&mmYKP2ai&?qPidxY&PAK2x!pN&AAac1xWiixmx1aP?qmW?N&mxYKAK&Wm?Wixi?m1P2WGKYm1xaK&YqYi1PNYAAAi?qWxPaY1qqK?Y22%2Nm?q&NKAima_Y1&22aW2Naa11Nq1Km2NYWNNPN2Pi}mYma1?PN&qqqiUPKNi?1?NiYWqNq1K&m?ii1m&Nq&&&qK3WAY2Nq?a&8imIAN&111i?KiamPN&&P&&K2WYY?Y2AN&&2YYPm?1NAiKWiamAPPP&12qYNam2YNP&?YmPW?x?&2KA2K=AR&AiaA1ZKoiYaWYPP?&YmNWKYJ1PKYi15?NKAKPY1P{xiPmP1&?mqAq1N2mPYWAW?NmikNaK&1KtiYi?yAYmAx&aWxWam&Y;?P??mNiiP&Y&qPimiAtYNiPW&xiWWxmPY2?N?PqqWxx2&W1Y2qm&YmPaP11qqNNYmqN5AAi1q WPmqaAq&?222Y_P21qK?KqNm_?YNAN&AmxiVYWaY?K?i2YW?Na?A1KKKximNP?&12x4Wi1xmamAai,2AWKxa?Y1qimm&Y1A&&2q?9qWamA&NAA?Am?NPa1a&qi?A2Z9<NY?W&?iqi?Y1YiPK?a2PW&aPa&A2KY=?wxPxa1KiqYimmKYqPWqqqWWNx?A)1N?&qWb?AqPAK&KAmam1NqANiYqqi5xA&1AC?Y2KYqNm1&1KWamqa?YxPP&2Mii2YKYAKA2iCm^Ya&a2&a?Wi2NqxWPN1?qxiqPaNiP2&A2YxKxiaYA?KaxAmaPYP&&9KYW1miaYA2?qW&WWNaai12iW2QmPNW&dqAq1x&mmPWPK2K>xxax1A21mK&2NmmawPN1AKixWmAN2PN&i+)WYxY&AAq2NpmN1A1am1?K?2ia&NYPi1.q1W&mN&YA1?1mKNNmA1a1AWq2a/iNiPx22qPWqmWaPP??i2K=?x2PYAwKqi&NPNqAx&aqqixxYam&+?PqNW2xiam?iKm2a4qPxPxK?WYmPfAYNPW&&q2NWxYAKK&ixmF<&xK?A1KKKximNP?&1qW0Wi1xmamAaip2YEYAAaqKaimmAa1NmP?&?KiN&m2Y2K722Kqx?xq?mA?KNiN;A1xa2&AK&WmxxNqK2?m2mYYai1x1NW12m}?N?ai2&K&mPmqaxP!??W&WKmWY&q1?L)aNiAmaWq?KYWamPY2AN&ammWmYiYKKAiY2KmmNYP&K1KK2WmPPqAx1Wq&W?m2A?A2?m21ximq1P1mqx2Am?P&aq16KAiWm&&xPK&?qY+ma1aK1m?AixaYxA&m1qq2ixxaAYAA&K2xYNxKamAAKxxYM1N1?K1_iAmaY21qPa&iqiWxP2aYA1?xxmS&ai&YKWWPmPY11&Ax&YOGWYxY&AAq&NhmNPA1am1?K?2ia&Ni&P2NWKmWxaYxAq?2q5x2xCaY1KimiamKx&ANKMK2mqxxNWA&??q2x?x2am112iim<Ax2P12?qNW&DAam&i&KW?W2xma1q&Km2a>qA2Pa1KKmiqaiYxAxiaq?xNaK&&Ax?K2KWWA?aYKA?2mNj+PKP&qAq1mWmAAKAi?Yq?yaAAaK1KWim&W?P1P?2WK1WmxmYaK*&iW2fxa&aq1x?1iNaaN1&x12qiiKxPAaA1&q2NYYxqY=1AW1277YNK?q&mi&iKaaAqK??xqPW2PiY2?K?AmANiPmPYK&K2WaOWY2&q1WqNi?xxYqqa&iq2WANY1K1iKY2?ma1AP_?Pq&WemYa11aKY2ACix?PP&N2UiPmqNWAP1qqiWKY?Y2Am?1m&pmxaaqq2Ka2KCmNq?i&xqxNaaxANAYi&qxWKxKYWq??i2iamNP12qKWxNxeKYYAY&1mNiix1Y?1xKNq2YiNxPx2aK?mNY?1&Px&KqKiWP?aN1&?qiNWANKP1KaKiWmmYYKPA?NqGmWm&AAANiNZ?x2xn1a1&qm2Km&P1Pi1KqaWPm&APA&&22Yx?x?1xKq2iqWsKNAPm&aBAiqYN1m??i12mWNPWaN1NWP2KNxP???1NKqiq6H1KPW&WmxWAY91NqP&W21t1xq?A1KKKximNx?&1q2sWi1xmamAaiD2?x2xxP&1xqN2ImKY1&A&?K;iPxm&NPPqVqK{qxmPYKNKP2?mm1xP?10KPWmPNYAAAi?qWiPaY1qqK?Y22E2Nm?q&NKAimafY1&22NWyNaa11Nq1Km2NYWNNPN2Piqmxma1?PN&qqqizPKaY1?&1ixxWNP1K&m?ii1m&Nq&&&qK)WAY2Y2?aix3?xiNYam1KKq2WNqNWPN&?iEWNm&NWA?iq2a!Km&PN?^KA qkWNNP?2KqNiAmi1WAA&2qNWiP*aY1YWAmNNaNP?K1YK2i2mm1qP_&:mNW1YWA2K?ixxmW?NNPN1A3x22mAN&Am?xKqN2xmamqY?&WzN&A1am1?K?2ia&Nm&P&qWxW1maYWAX?NW<8NxAaiKYKm7qJ?P1aK1WKPiim1&mP?&&qNWjaAa?Ak?PimaNxK1o&PiqiWmNY?KK?Nq&iWx?&qAp?7mPN2mW121WMY22mPYPP?iaK:W?mqaY1a&WmlSYNY?A1q?NmmY?11Pm&?q?iiP&YA?P?K8x*1xaaW1.KNwpmNNAPiqYK&mqmxA1PK&WqPWix1?mA??&2Nt4PAP?1dKPWmPNYm&c?aWqWWxNa?qKKN2AJiAWPA1KqxNNm1PyAx2q_NYmx&Y21YWa2YNxxi&iqai1iKNZYYAq&P2YxNmPY?Am?&2NYqxaaYAiKKmxmaNKPm&qMiWNYK1a?A&12YW_x?aiq_KaQqY?ANKm&?KqN1mqYqKW?YWKNNANYq1aKa2&aYN1P12KKpm&Yq1WP1?m2mWaPdaY1YWA2qWNPm&P21Kmi?m?NiK&?NWPiKNxYK1q?&iYmmajPN1&?Wi?aqxW&&&Y2ai?x2AqAW?N2?YKNNa&AWK?xq}6NGKN&1?Wm2aa&YP2?P2PW?AaaqA=??x&mmPP&qq&WixmYq&mA?&qm1Wqxq&WKa2K2iaNxqPa&aK&NYm2aNPm?KW1WWaYa?AAKmixOaPxPa1&KymPmPPi?K2NWAW2m?aY1a?15a 1xqPNK&Kqixe1YNKa&i2YixxqA&A^2a21WqNN?Y1q?ziAa1NUPP1qqAN&m2Y2KI2qWiWWAYY21PKP2?aaN&P&2qqmm1YP1N?Ki?qNWqxqYwqK?P2#nxN?PK1a>Pi?m?12Axq&FxYmm?aN1N?AxxW?aWPaKKqm2im1Y&Pqq&qqi%xAA2A?2a2NNmxYa1AWKAima?NNPx1qq&m}xNY&PW??mqWYa&aWKaK12qmN1YPq&xK1WNPaY&A&2WdPi1aPa1q2?P2WdWNN?i1&qNiam2YiP1i&q2W2PDaaPq2?mNamx?PN&NKANxD#PWAYqK2miix1a&Aq2&2qW_NA121xia2KYmNYP11WqAWmP?YNAx&q2&xCNNa&AWK?xqF?P&Piqaq1iqxN&YAq&v2AY1xLaY1KWqimN&NK?aqqB?WxmPY2Ki&2WKWAPA1iKmKYI&V2YaaW&2iqiWmNY?KK?Nq&iWx?&q1m2&mNNaxPPx1iK1iqaiYN&?21;mNWx1Y?qP??2?Y2P11&KAK&xi+AN4Pf&YeWWNxN&PKN2xWC3xAAY91&K&22a1NP&a&?WmWYm?N4AKi22mymAY1W?XKNx1omN?P?1i^&iPYPNq?x?aqKWmxq&i1&2K2&NAN?ai&apPiimxY&K??xq1iix&&KAW?WxxOAai1qqm(N2qmaYaP&iYq1W1PKYR?A2a(KYqxaai1iKxx2mYN1Pximq&miaPAiKP2&-&Y&NxaYqTKYiYaAPiaNqmqNN1mmY?A?&im&TxPKYPqm?mmiN&NWaq&PqAi?YAY?Pi?aWKWKaN1.K12qixWWN&P?12i?i2mmY1&i?mqAi2x1&?1NiqqAYxxx&WK?K2imm11&Am&AK2W1P?YiAiWm2Px2aK&Y2x?KiYmYN1KN1iq1i?xxaNP2ii2xGxAa1iAm2WimaPxWP1&1KqNAIKAYPW?;2P>1aAa2A?KYiaB1PaP11qqNm&GAAmPq?2qaOaaYYAAK?x2?XYA2aP1a?WiqYNYPPq&xq2NWmNAqAAK12iX5aWPx1PK2ximPN?Amixq?iixa&PAK2N2aNWPP?Y1q?}iAa1NA&a&m=mx1YKYi?N?A2WW&NA1P1&?2iYaaN2Pm&1L&WmmaYqK2?1qaWWxnaN?}KN2A8iPYP1&iqmW1/qY.A2q?q+%Px&ahAqK1iamYNAPi1YqPWNYxNq&?&PePx2Y,aN?1?qiYWiNq1K1Wqai1mWNNAA?YWmWAx2Yb1A?N2WyqNKai&a?Ki2m?P&PNqmK2x2aYAAA?qW2NZKxaPNKxKPiqeWYPa?&iqKm1miaYAA?iq?(PNNPx1aKq2xmYYm1.1?i1iYaYAK&i?mWPW?NxYq1?2&22mNNPP21mqaWxNWY1AK&i2aWmx2a??&?N^mW2P2&YKAK?_WmNYKPa?NWxWPxqYW1P&?2i3Ka1ai&YKAiip?YPAN?xqaWqmxaY1mq4q?x1xY&YKK2iimNPN?Ax1qq?m&m2aNAP?2qmyaNxAW1aKK2imaNmP2&?q&iqxNN&AK?1WAWmYWYKKKixGas1a2Pm&&KNWmNlYYA?&22Yi1xqa&?P?qix:aNqa1&YqmiImNY?aX?xqWmimmYaPq?YqiYAmEYWA&KPG2DzNPaq&A>&Wxx1YK1x&P2?!AaYa?19KNi?<PYxPW&iqmW1ciY3A2qqqPxYm>1^KA2?22NxNPPi11qPmam&YWAx?&K2_mxiAK1mKA2?mmx2P&&Pqai1mWNaAA?YWNi2YKYAKA2iBmEYa&a2&a?Wi2NqNHAP&&qSiYx1aa?x?12i+mN1aY15K2iqQWYPaq&iqKm?mYAxPi2i!ax1xKA_1YKq2PmYPNPA&2K#WAlKYWAqq&2x-ax1aWAKKAiYNNx21K1AWAmiYmYY&&&22aiWx2AqAZKP2&UpxYP1&aixi1miYmA1&YqdW2xqYW1P&q2i/Ka?aYKx?imiYaP1PKKGqYWqmPaY?N?A22W:NAYK1WKqj&eWYaP1&WKKWAxYaNAP?2qN*aNx1mAK2&2aYaPq1W&xiAiKxNN2AKq?qiDYxAaiAxKPiNxbNPPq1WqPixmiYKA?&22Yi?xqa&?1?KqW5PAAaW1NK?xKmNN&aW&?hqi>m4&N?W22*&x&aAa&qi?A2D!>NY?W&NqNNPY?A??m?xmAidx&a&A2W12WJNx2?q1?i&xmY&1m?m2YmYW2mW&KAW?WxxbAa/&1qPWxx3^&YxAx&PmmW1mqYPqa&O>xNqP2&a2NKq2ia?NiPi2YWKmWYKYNqx&K2Y6Yx1?NAiK12?mxYNa22iqxWxPaN>?N2Km&WxxKaKAWW?iNYqNqAN1AqKx&m2aYP+?qB2x1xxAcAqiqmNNPN&1i&xq?iYxxAmAA&YqiWWxxAW1x?P22NNNAP21OqA2KmWYq&&?x2aW1xWYK1AKYdNWPx?am1&KNxqkaNYai&KWxWamKYmAqii2A#2xXPAAKKWiqN&YxAa&1qWiKxAaY?N?Pq?DmAxa?AiKaxPmmxiP1&&Kqm&mqNUAAq22m,Ax?PmAaK&iPNNN&PW&xq&iaxmYiA2?m2AW?NmYA1&KPiNNxN1aa1WKUiNNGYNPA&iWYWAm2YNAii_2AWKxa?YAWimmKYqAYKx&KK2N&m2Y2KN2?Wix?xx?mA?KNiN*A1xa2&AK&WmxxNqK2?m2mYYmW1xK?W12mt?N?ai2&qxxKmKaxPP??H1WqNNYW1KiqIArmaWaKqKWxmam1P2Am?&qNvmY}aPAN?22i9maiPm1aKqmxmPYqPW?PK?WixKA11mKY2Ayix?PP&Nix2as&xHP1&x7KiYmNN2A?2m2YW?m8aKq2KPiqTWYPa?&iqKm1xmaYAA?iq?gPNN1x1a?&24amN&a2&Y5ai2mmY1K&?mqAi2x1&?Ai?ixm5Pa2&AqaioxWk1YmAm&a9<WYxY&AAq2N32NKPA?aAiKAiAGK1PP2&mKKN?m&AA?22?,WxMaq?x1K?2x&e2N2?k&aiixPaYA2Ki&Aq0WkxY&W11Kiimm1xqP:&2i?2KxPY&A-&q21:aaYa?AAKmixGaPxPa1&K>mPmxNqAa?YqPNWxPAq1mK1qq}oaWaK1aKii20W11P&qaKY2WYiY/AY&im2_aa?&NqaWK21a1YmPN2WK4i?xNaxAYi22ax?xmPP1&KiX2IWNNa22qKKm&aN1YK??amAW4xx&iAW?&ixmmNN?q1Ki&iixaNWA2qqq1WxxKa?AqWaqiNxxiPiqaqPmammNKAY?NqaNixPAKAAKA:2lWaia212We2&N2P?PTimq2i2xY&aA22mWWzNAPYW11K12qaAN1AP&&qimKmmaAA??WWiW1N11W1H222KN&NqaE&Ai2i#mYYK?m?Yq1WWaaaKA1KxiNgPPNPP1?qmmAm?NsPP?mmNWqNxaa1q&^iYmmaiYW&?K2WY<eYqA&q1qKiWxP&AAW?aqK;PA1a&1NKqiKJ21PaWqNq1WWmNaA?P?xqqUaNYaPqW?ilqmxY1PK?xKiW?xAAPA??XqYN?PmPx?W?K9K.WYaa&&2i?iPxPY&Ac&P21_aaYaAAKKxxNwKxWPP2AKWiNm?1KAN&AqiNWxAYK1xWN2KWWNP?A1WKNi?aKN?&12mGYiiYiamAa?qHxEax&a*KP?qiP4YxgaO&moqiaxm&NAK&W2Pxqx1ax1KK?2qaaNP&xqqKmiIm2AaAm&K2YRNxa&i1a2Kq?WaPYa 1?qNWxmY12Axq?Sqx^PaAGAq?P2W_ix#?&1xiPx&aPPW?W&iKqiUx1YYAq?N2mYYxK&21AKmi?m&NKKY&2Wmi2P1Y&AN?q2KW2APamKNi22xYAAYKm&xKqWaxYYPKW?AWqNPmK1_K2W?iNNAxP?P&aKNiAmWNKAN&?q1NKmq&Y1mKmxYWWa6&KAFWNmqaWN1Am?mqaNCmKaaAN&WqWW-AKaY2aK2imm11&PYqPKiNxa&&AAW2YmP PP2&aA?iPmaYYA&aW2A^1x?pW1xAOiiq&dNxmY2A2?ixmmmAi&U1aW?xYYAAY?i&NEAYaNmam11Wm2JWiNxP?1PKiiamN1PAA2WqqWqPWYiA??xxNHxYxPP&??Mi&m&N2K1&gWaW?Pm1&PiiN8WY2xqPq1DqYmmaNA1a2qWWqNNYiamAa?qm2W1NxY>Aq?q22a1Nma>1?qAN&xmYaAqiYmNmiNNPiAY2xxmmYNYPK2qqaWKaNN1?K?2MWNYm&aq1&i22mY&APa21AWiiiaKA2Px2AbmxYam1KPZiNxx(ixiPaqiK22KwWYAPN&KqxikPNaYKq?&2&YqxKaAAWWI2WmWYNAA12qPWPm?&aA22x2ANiPPYKKriqx?n&Y&P2?miix)aaN??q2?<HxKxiax1&W?2a+Wx2a&1&K?NaCiN2PA?YmPWixxa&qmi9q2mfNWPN?&WiWmmmY1K&?x21xema1A1?iqq2YNPKYIqNWxm1aNA^PA&mG1W1Pa1APqim!KxiaK&aA?iWxqm1N1PW21qAiam&amP2?aqqW?P2aiqPKNiNaPNaPm1&V?i&x&Y21m&AqGW;xY&W1A2qimY1P4aaq?WPNYmNaNAA?KW1N?aWYY1a2(m?NaN1aq&N:Y2Wm&NAPN&NqYNWm1YAAm?im>d1xqPNqKW?2?mAN21d&1X1WKmKaxqN?qixN?mW&N&YWP2AY2Aaa?q2qAx&a21?Am&Km?WNAYaqA;KAmWY&A?P&1AKKWN(WYAPi&q;W(NP1aa1aW12NNYPWaYqAWmNNTqYaAa&&mYiWx&YAAN?N2YYWNK?&&mKaiqa2N1&?&xTPx2PKaN?1i?2?YmP&Yi1)iJmqY2YP?K2qWiiNaYAWqx&22AWaxmam1xWaiaaxAYa&qiW1mKY11xPA2?m&SaxaaqqaKY2xLPNia?&xK&iAa?YKKN&Dq=YNxxYiAPWA2PmPN?Pi1YK2i2mm1qAYq&qiNaa2YxKAiNxmW_NbPY&1iaxAYqNmAm&i.AxxmiaqKxKYMmYNxqP?K{qxxxamNxPi21qAiam&amP2?aqqW?P2&&1&WYmEmmNaPq2mqKxWnr11Ka2iqYWXP?aN&mi1i&YAYm?a1PWixKa11a?*2AW?WqNYaY1q2&q1WNPxaiK?K1WPYqYi&2&2WaWAPmY2?K?i2xv&A?aa1W?22&p&N?Ka1iK2iAxY&PAi?x2&YmP3Pm&?qKWix_AiAm&mq1N&xxa1?C&a%Ac?Pq&mAPiNmYY?Ym?P2NK?iYaKYKK12?KWNYai1m?ii1q2YxAWPK1KqxxKm?N1Pq?YKgW1mWY2KDKmm&-PNP?&11KY2qa2NqAq&72Yi?xNaNAAWx2?xWNY&KqN?1m2Y&1APP?Pq?WiYK12Kx&AtaNmP2111?qxixm?PAPK&&,NxWY?Y??x?Y%iW?a1aKAWKPxA%xNqa?1PKPiAPxNKP?&Y2mYNxKYW1Piim2}Ax&1A1m22xKmiNiAaiPqWBaa2YxKPKAm&-2Pc&1A2qmi?aNA:PA&mw1W1Pa1APqim5KxiaK&aA?iixqm1N1PW21qAiam&amP2?aqqW?P2aiqPKNiNaPNaPm1&w?i&x&Y21m&Aq*W}xY&W1A2qimY1PSaaq?WPNYmNaNAA?KW1N?aWYYKPKmm?Nax&12Aq?8xNY81YAqq7W?NWxK&xK?&WqNNxNYPq1qqYmmmAYN?22&WYWYYqYiK1i1maWqx1YI2m?Wm2Nxa<a&?1qmtYNPP?KA?qqq0NAY1wqi?q2PaaAx?PqmKaWKaxaN&QiN2KxWa&&AK2i?2mmAPiPWKiK?W1YiY/&22AKqWKx1A/1N?A2iYWx?PY1x?i2iCW1?PN&xKqW&PKaNAA?imPYaNaYW112YW1aNYPPP&2_iWAx21aP?222WYmNa&1K4?amAYmNi?12aKqiPPaamKW?AqKtxP?&YqaKY2xsPNia?&xK&iAa?Y&KN&<q+YNmiAWK?&WmxNqAiaA1^KJiYaWN?AY&xKiiimW&?1mWY2qWRNA?11Nia22amA1KP&iWNNaxa1qKY&&yPNYNY&11qWPxAY&xiPi2.KKWamNNWPW&3mN/NPG&xAAiqmPN&PP&=1aW1NAxNYNA?iN2xiVxYaqA1?+2AsaA1P&2mKiiiPmN8Pq&YmaWYNYa11q?x2KyKxW??&xiAiqaNAKa:2a4mNWmiai1xKPVNYaP?YWKWWmxaNjYNPA&ioWi?xYYxPi&iqWY?xNaxAqK&xKmNNAPi2P8ai2YxPYAi&2mN>PxPa2qiKAi2Yax?&i&W>mxPtKA2?P?1_qWiP1&aAq?Pm2c2A?&q1mWPm;YNP9??1W3YYmx2Y21Yi22qW?xiPP1xK?im3W1xAN2Kq1W1PKY?AP&imWWiNiPx&P?qiamaN&KY&qWmWPa21aP?2WdKY&x1P11qK)=2YWAYa&qaWaxWY?Ni?xia22NNaq&&Kx?iw?W&NKa&12qaimm&NbPiimw2WAP1&Y1a?&2zWYPNaAKKKmxYam1aA22arNx<Nm1PKYi2tP6&x2PY2a?^i?b1NYPY&avvi&m1YxAWWm2&W2NY&qqK?1bAx8N2Am2&qqiqxN&YA2KNMKiDPNPaqAKPmiYPxK&2qqqPxiaKYxPqiN2NNBPxYAKqiP)&NPPbaaq&<AWNmNY?KN?xKeWYxqY1A_?A2aY1N&?m1iKiNm_=NqPYiaqYvYx1aqAx?K2KWWA?PxKAKqxNYKxZ?a2m-Wiixiax1P2NmaN?mWPm1WWa:<mNNAPi2WK?WYmxNiPi&Wm?WNxxYq1&WKiN+ANi?P2aiY2Wx&PqPKiN2PWPx2&i1AK2maW?PqPW2mKJx1YONaA12N*KN1mWY&q1?Wxx.?xiPaq2?PiqxxA?aW2m2YNPaKNpKY2K!ANaP5Pm1aKqxYWWx?&&&aKWW1xAY&qx??WWWWPiPYq1KAxmYiP&PK?NW&WKY1NAPx2m2NCKPxPN?{KamW+iYP&2&iWWWPNmY8PqqxKqWxYPAK&aqAW1W2amAmKKKAi&mNAmAYq&q&N1xi&x1miKm1WqNPaYAe?bimaqYY?i2aHxxWPmAqAW?N2?YKxPaGAi??2?)K1PPA&KTaNxxmNWAN?KqAWWxPaYqAWN22jANfPW&mJ?i&YANPPm&Wq&cxNmaNqqKYk&YNx1&2q&iqi1mxYKA?&qmaWiaYaN1NWP2YYxaA1aAiq2iPx&aK1WiaKiWAxAYKqP?W<NWiPq1m?W?1WA{MaN1aK&dAiFxY12Ai?Yq?daAAa:KYWAxYmNNAPi2WqNWNPPYYKx&G28oxY1YK&a?q2eY2Ni?N12WK;qmWPA1i?&i1mmY1&aAA?*2{LYAWPAKqqmx1YTAxAa&KqmWqPiaP?K?#mANiPmPY11KWx;JWYWAx?AWYximN11KN2A2mmmxKPK1iqNxxY?xW?Yq42mmia1N2Kx2q<mWANmYWAK?K2qaANP&P&&K2WYaq1?KP2V_KN1Pa&A11?qiNYKA&?P&aKNiAmWNKAN&?q1NKxx&m1aiK2 YaNx&W1YW&iqaPNRP??N2xWYP2aY?q?K2KYiPA1qK1KYxWf1YmAm&ahFWYxY&A?i2NqtYKxYa212KmxqDBNnKNqiWmm2m&&YP2?P2PW?AaaqAn??x&fDPP&2q2WimWam&mA?&qm1Wqxq&WAi2KmxaNxqPa&aK&NYmaNWA1?Aq&YxxmAWA22K2W;mA2a1&x?h2q>qN2K1&WK2Wmx&YaA2?Y2xYaAmaK1aKii2rW11P+qaq?NYxa1?Aai1qWNix&&Kqa?BxNz?A&PY2PVNmim11K?WiYWWWaxWY2A&?&2?aaN2&Y&AKKWxY1YKPW?PWq#xmWa&1??2 ?Q2NmP1KiK?iYm2YqPiiAqPxYxxA_Aq?P2WMixf?&1xWAiYamYY&?1 v&xqPxA21m?NmWW?NYaxAi?i2Wa?YmaW&NqKiAmWYPAYiAmNW2xAad1WKmx?mNA1P&2xqPxqmNAaA?iY2aN?xa&1AWii2&YKAaa 2NK?x&mY1PKm2Pd2x1xx&aKPiis&WWN&aA1NKNiYaAN??W&xh?NaPaaaK2?1m1YNANa5qKKqxPamYa&K&iqxW&YWaxAP?2MN}&xPah&mKYmmmYN1PWqaq1iimYYWqm?xqq5aNYaPqW?iQqb?P1PY1iqAWPm1&mAP2WqPN&xq1xA1WmmYY?PaP&1KLAixmqN?PP&PqAYxx&YAAKKNqWHAxiaqqWWKia+WY1AA&&mxW?aSYaK??WmYGma2PxqqK2xxf2AHPA2PqmNNa2Y1KK?xmmWqPi&&KiWao;-?A2&i2PWmiAxmNWPK&KqqNWx1&A1PWxm2Y2Ni?a1?W)xKaKNqKN?YbiN&xq1N1P??imNAN?ai&aiKiimxY&K??xq1iix&&KAW?WxxDma01qK.0N2qmaYaP&iYq2iWPKYPA4&iq?W?xK?PAWqai&m2YxPP&2WNWPmqYxA2iW2NZNAPaaAx2SmPaAxgP&&&K2N1mNY2PW?A21WxANaA1AW?yWWPPYap2KKYi2m2YmKq?aqAYNmia1AP?x2xcNAia1&NKmiam?N1A1&x2xWixmaaKW&&qYYxmQP2qiqNi7m;Pd&2?AWAxPxi1PKY2&ixN?P112qKqx<WmNNmPa&2K&Wmm1YPK&?&DWWYP&aPqNK1m241A?PA&A{?i&PYN2AP?Pq?Yam_a?A1?Y2YjaA,P1&WK&WAmqYxP1?NqqWqPWa1q&?x2KeKxW??1aKW22v&N&P?iaq2NWxAY2AN?imj=1NWaN&AiYixaKYNPA&ieWWAmKaxPPiA21WqNN?Y1W?qiPmAN?&A&?KiWaYKYWAmi2q1bxm%YqAq?2x1mmA?Pmq=KKi2mA1YA&imWqWWxNa?qK?N2AWiNPan2&KximIKY1&W?xq1iix&&K1Y?PxxW2NAaa1mKmixa2NAAx1pqYW&mAaAAmKm22W.NY&iA1?NxmWWYq?2?xqWWWYWAq1P2P+ah2Pa&NK1qmm&YAPq???miiWxwMYYAq&1q_WAxa&111ii2NY1N2?x1WWqiAa&YPAPi&q1YNmqaa1a?&xYWWN&aA1NKNiYaWYAAi&12PWKxmYA1x?K2KYixW?11mK?i?Bi1&PY&iKqi1m1Y&qY?qmiTPxqax12WWiAmiNxAPqNq&N?xxYPA2ii2PW?NmYaqPKA2Kmx1NPK1WqPNAmWYNA?iK2NWAxi&W1A?22NwiApPY&YdAiPYNA2KK&Yq2W2xm&qAy?zmPNWPmaq2A?Li&m&N2K1&WqNi2PqaN?&2F iYmPN1W2YK22WaKNWPWixWq2iYqY1qN&q2aXax&?Y12?WxKZPN,ai1?K?iKPP1x??2P:Nx8Px1wK1iWmxNCP2&qqPW2xYYiA?K2?aq&W{aPaqA&KNiYFAPYPA1Kqxm1mqNiK?&aqWi2m&Y&A?Wa22YAPK&%q?Kix1Y&AiPN21qaNxxA1qAli&mNUAAm&mqA?qxmliAKPH21q&i2xYA?Av&22A_1xK111K?WiPNqNWPa1KqPN1xmYNKW&?2YWxmiYiAWW?ixYqP{?aqWqNx2Yi1NP122q?NAxq&m1aiim1oqAP&PqqKmxPmNArAa22qiWxx&AW1x?P22YiNPaq1xK2xWmNYNKP&aWxmja21PqY&22P5Px??aA)K?2qmYYaaW2>qYWYPAYP?N2imKWYx2a21mWqialA1Nai&1KPixmxYNKi?aqNWAxWYK1N??21YKNq?m&aWKiPa1YaAai1qAYxmKaY1Y?1xNpYxiPA&PK1Nmm&Pi?j?meNx2xi&m1miP%WYYAm?xqxqNxPaNN??12m_PxWPmamKP2WmYNWPP&KKP?qiPyYx<af&mFqWYa&YiKK2qWWnxx1Yi1&WK2qwPNWPi1oR&WmYPAiAWix2xNAaL&a?w?P2=Wix?a?1KWiiWaK1aAa2qqWN1Y9Ai1NiqimbmN1?&qaGNim<K1??Aq&qqiSxAA2Ap?Y2KNmNYa11WiaiKk1YxAN&PWNWPm?am?A?Kq2Y&xYaiAq?121S&1YPq2PW?xWa&Y2KA21-2WxPAaYqmKPmKOWA1?x&PWdmeaPNK?v&2s?WWPAa1AqKN.&Wqx_aA1WK&Nx!KN?PY?mW1WKxmYA1xWY22WWAKaP1^?i2?/?NKKP&2KKiWxAYNAK?xq*YNx?&&12WNi1Y N2P22{q&N?mNYqAq&5mKWqxPaW1i?nx&mmPP?11WWKxaxP1&A&2i-ANqP&&?K?KKmiYKNq&<q&WixAa&Y&?i2A#qNAai&N?i?Y2iWqx1a11&_YiqamYPKN2YWAW?mQYP1mWN2YWiNAPP11ymi&NiAPAA2?q?xWa112?1&i21WPxxax1NWP22aNA2P22YqAxbY1APAKiY2&W&xv?mK2WK2&7N1x&WqmqYi1mWAaA1&q2Nx&xqYc1A222rBYNK?q&YK1iWakY1Pq?NmYWqm;aAKWi&mYYmPi&X';BZsdVWKFtnlWLZdjLOF_ztnFJbKJbdWq={"j&XXbkjg9b3&Xjgb9Ng9&,^eVNjVx,_ke9kNCV3,_&jX3X&k9ggV9g_V^,V","e9Xj,bVkeCxVb3bkgNbjVV&jC3X&,,VNC^NC3xCejXC9NN^bg&egXb_93&NjC^N_3X_^x,bbC_&jX&e,^NbbXjjeX93_Nj,x9","_^&e,3j,NNxgC^x_&x,^^kCX_9x^VCekVVCgV&b^&X9^93xgCkx^_V3k_g&e&^Xe_jj,^&","gx9kCgkVex93,x9jCb^&k,k_,3C3jg&Ck39V^jj,3x3Ckebg,kkj9gVC,^,bex_gVxbXCV&&,^9eVV,gjxXgV3Vk3&ee_^&_jNjb3","CX&xNx3gX,^j,xk&X_3eVxXg&CX,,&,x33ggV,X,_Ce^CC9kxXV&^ejg,k_&V9kgVkxXg,3kb3&^NVVN3jjxg^VkXxV_kVV__VCX3e393,9X_CCb,b,3,Cee^,jg&k^X_CjN9^3,V9","jkg_XeX^g,eg3,xV9,b9CX^Nj^N&g3^kX3xxeNV3b99^e99bV__bNjV9,_,N9eX9&bj9^_j9","__3k_V&V3VxV3_Cj^xkj^Ckgb9x^_N_j,3e9C_,e3^VC^","x&^e^gNNg3bjx&&,XxCjg,C9,k,&kgXX9Vbxeggxg^_bCNVN&_bbe&XXC^bxxbjg^g3NXgCee,Xe3_xe3N9&Ck_NNVNN9xC,bxXCj9^k&NgX3xe_k3eV,xN&,","XjVVNVbC^_V^3je9__ee_b,N&x3CeC^,X_Nkxx_,3,VCCe^,39XjgV","N_9Ve&V^_3CjkXjV^jN3^geNXk_jCbN3^^j9Vb_^CNNX_VjCNXjg9k^V3N9j,,g,g9Vg3kx33X9x^X9keX,V,,bj,ekVNxC3g^C9j^bb39Xb&&,3V9N^CXj9b",",V,,gXCb^CCXeXxXX,xj^b9g&eeN_^b&bx,xN&CV^X^x^^X3C_bbV,bX9jbkkg&C",",je9CkxNkNN,,e3x^CVe^99X9bgbeXgCN3NXX_C9bV,x&&gCVek,X&,jbkV&xxeg_^N^k,C^V,xXg_&x,k3X&3kb3N&939k_Ceg^,g^e3333bXCNbXb,3Nx&jC9k_&,x&j","bxXj^gNNCj9N9_X_xV39&9__XjkeC&_NbXCX^Vg,xgj39Cgkxg,V&V^^&e3bbN,g3xebxb3Vxgj9NgxCxkNj&Vb^jNbgxXNCbNeeVCbXxj3^Nk^3V_ggebXX^j,X_N,^k9&Cx__x3V9&Nbj&Ce&N^Ce^^j^g9bCNbNNj^x^3xg^3b99gxk9eXxbgjbxC9V,39kC9e3xxCxkVNk&_C&_kkbxjXXX^_b3^9,Nbe99kxV^X93^xVx&xjCjbjXVg3_b,be^9C9j,3xNeNbgxCeXg^xVx^&C39bj9bNbb^xCjxg&jb93_xk9^Xx3bjV3x9Vjxk9Ckek&N3X_gN9Vkb&3X&3N_&gkkCe^C3V9b^b^j,XNN9g&CbNgkj_CN^_9b_k&&bg^X^NX3xV&_b_C3,bX3&^xN&kC9_j9N3XexVC^^xjxe93,,,be,&g&bg_Nkb_xX9gxgxCX,bgNbbNbCV&xb&X&_&,VXC^ebbjx,^VNXxN9&N,3Xxxb3ke,_jk9&bNgV3CCCxb9Vx,VjNk^33ej&&g&&&3CbCxCj3C,xee_Xx3XC93N3x,Ve^&X_XxgxCNjbN,,9^eeX39kN9e_bb&,_&_x,j3^&_gg^bXxk^X,_xC,jkbx^xe3j^beV^jkj_N,,k9exx_C&,Xb_b__ex,_kj^beXxg^bNb,kjXXxNgCVxkk,Njk3e_e&g,j&3kjCx&k3C3NeeNkx3,X93,Xx,,,^&^gXxVxCkXbN,VV^&C,39eVNbgxCe9b^xN3^&,x9bCxbxg&^g9xCj9&9_^^xVb&&9NXXjNeCk9j&9gX^gbVxC,_bCk_3g&V^&VXXxbXC,3x3^9kVCe3xNj&,N^,bNx_^x_C&Vkjb_,b3^^&VC,bCj&g9ek&V_Xx&93XXjbgCk,9N,CVx&ke3Nejb_^XbN^g^x^9&V^bb_9gk9kjxCXkb9bXbV3bxVeC&eb,j&xeCb_9&9,k^g^9xC_,bCb_,bk3&ebg&ejxCg&,Nkj,^bV,x_jjbxeXV9jC&3e&Xj99C3j^N,&NV^&Vxgb^,&&_x^9g&&egjx,NC9Nk3XbjVC&Nx,N3,k3&xjkg^,,e^j,N_NkVk9N9x__C,Xb9bC_&x3jCXx_gjbg^xb3_k93xekV,3XN_NV9CVNX^j,,3j3bjxV3&N,CN^^C_Cjbb9VC^xgNe&9jbj9VNbxjNbC99eg9Vxex_NeN3Vx^e^3XbjV&,b9Vekgk9^jkCC&jV9,NXVxXV&^gkjxVeCCj9b3_exk_^33b_9ebXbN^kj^X3X_V&CNC^Nk,j^Xkex&e,9Cj^x_kx&_xe&eCg3__XbgXkx9xj3XbVVe333be,^CCXXjC_Cj&xb3Xj^e_b33CgNeb,3g_X^kV_j3gb9VgX3X,^x3bN3X39Ve,C3bVC^CeV^_V&C,j,3^3eVCjVx&&Nk_gC3bxkk&kV^j^9b^N3N,k_C93C3XNXVe&k3bxg^x_^XjgX_gC9bgxk^g,gxC,3kbVgV_XCeb9j^jkx_NCek93bxCNCb9x,9Cg9V9C_j_^jjX3gCjx_k3bV^N^xxC&k9xg_V_j,&_Xb&,kebN^^3^kCX3bb3X9eVe_k3bj_^Ckbg^33b9VCbCgCeeVVCeCg9g_jx,3b&j9N^e3bCekCbgX^X__VCe9&Ne&b3e_V^&bNjb^9xbNVk9xjek333XNNNxj&VN^,j,eejb,bxb_9k9bbekVb3X9eNV&XVNbjj,_j^jb3_N&Xk9jXxC9NVxg_bN,bx3CV&_xjXjjjb_gk9g_XxC_,3XX_Ngex3j^9^x^j&VbebXx3k9jjx3X33,XbbXbxV&jg^xx^&Vkeb_CNkCgbX9N9V9VCbX^NV&__^xNb&VX&b_exkxX&X9e^V9kVNb,kCe,g^xk_^&jgxV,^3,_9^xgeCexgkbC,3b&9k&9e^jj^b__Xkje^x3eex3eCNgg,,_ge^xjb&V3gbX&Ck93,xCxk33geNgeCxg39ebxxjkeNbbj,bjk,VCCjx&e,9,^eVCbxXxXxj3^kCx^j3_NCC39xCekbb_CexC^kke9,&kgNCxNC&9_xee&gV^kebVCgxk3V&eC,^ejkCe_&bbV9^VNkxgC,b9jCxC9C^&&CjbCbxb^jk9Njek_&3Xe_N9_NVNeb^kk9j3xNCxXV3_,,9V,NCX__&VN9,_bXkjke^b,^V_XNN_9Ng",""};return(function(f,...)local c;local h;local s;local d;local u;local t;local e=24915;local n=0;local l={};while n<248 do n=n+1;while n<0x1fd and e%0x491e<0x248f do n=n+1 e=(e*136)%40881 local r=n+e if(e%0x482a)>0x2415 then e=(e+0x27b)%0x864f while n<0x331 and e%0x350c<0x1a86 do n=n+1 e=(e*126)%38504 local d=n+e if(e%0x48f2)>=0x2479 then e=(e+0x9c)%0xad21 local e=31796 if not l[e]then l[e]=0x1 t=string;end elseif e%2~=0 then e=(e*0x16f)%0x60b3 local e=99875 if not l[e]then l[e]=0x1 end else e=(e+0xac)%0x8272 n=n+1 local e=82521 if not l[e]then l[e]=0x1 u={};end end end elseif e%2~=0 then e=(e-0x360)%0x4daf while n<0x3ad and e%0xf6e<0x7b7 do n=n+1 e=(e*159)%27242 local r=n+e if(e%0x1402)>=0xa01 then e=(e*0x21c)%0x536 local e=88492 if not l[e]then l[e]=0x1 h="\4\8\116\111\110\117\109\98\101\114\77\71\97\108\97\76\99\120\0\6\115\116\114\105\110\103\4\99\104\97\114\115\106\117\81\110\113\79\104\0\6\115\116\114\105\110\103\3\115\117\98\83\110\105\101\99\77\73\103\0\6\115\116\114\105\110\103\4\98\121\116\101\105\108\116\98\114\98\121\74\0\5\116\97\98\108\101\6\99\111\110\99\97\116\110\74\70\122\99\119\83\77\0\5\116\97\98\108\101\6\105\110\115\101\114\116\120\86\88\88\75\66\67\71\5";end elseif e%2~=0 then e=(e+0xab)%0x463f local e=6457 if not l[e]then l[e]=0x1 end else e=(e+0x11)%0x3e6c n=n+1 local e=79785 if not l[e]then l[e]=0x1 c=function(l)local e=0x01 local function n(n)e=e+n return l:sub(e-n,e-0x01)end while true do local l=n(0x01)if(l=="\5")then break end local e=t.byte(n(0x01))local e=n(e)if l=="\2"then e=u.MGalaLcx(e)elseif l=="\3"then e=e~="\0"elseif l=="\6"then d[e]=function(n,e)return f(8,nil,f,e,n)end elseif l=="\4"then e=d[e]elseif l=="\0"then e=d[e][n(t.byte(n(0x01)))];end local n=n(0x08)u[n]=e end end end end end else e=(e-0x245)%0x2445 n=n+1 while n<0x2fa and e%0x2fa2<0x17d1 do n=n+1 e=(e-555)%43059 local c=n+e if(e%0x2f0e)<0x1787 then e=(e+0x1b5)%0xc09f local e=34345 if not l[e]then l[e]=0x1 d=getfenv and getfenv();end elseif e%2~=0 then e=(e*0x1da)%0x9ebf local e=1282 if not l[e]then l[e]=0x1 d=(not d)and _ENV or d;end else e=(e-0x30)%0x637f n=n+1 local e=16000 if not l[e]then l[e]=0x1 s=tonumber;end end end end end e=(e+727)%8101 end c(h);local e={};for n=0x0,0xff do local l=u.sjuQnqOh(n);e[n]=l;e[l]=n;end local function r(n)return e[n];end local t=(function(h,t)local f,l=0x01,0x10 local n={{},{},{}}local d=-0x01 local e=0x01 local c=h while true do n[0x03][u.SniecMIg(t,e,(function()e=f+e return e-0x01 end)())]=(function()d=d+0x01 return d end)()if d==(0x0f)then d=""l=0x000 break end end local d=#t while e<d+0x01 do n[0x02][l]=u.SniecMIg(t,e,(function()e=f+e return e-0x01 end)())l=l+0x01 if l%0x02==0x00 then l=0x00 u.xVXXKBCG(n[0x01],(r((((n[0x03][n[0x02][0x00]]or 0x00)*0x10)+(n[0x03][n[0x02][0x01]]or 0x00)+c)%0x100)));c=h+c;end end return u.nJFzcwSM(n[0x01])end);c(t(247,"9!A_rLeEP()Wf7xSoW!er7L(eAeE)V(_Ww7_fexex!7LP((!f(M!!(A7!m_(r_LFAExfSrA7LeESe7(!PQ(r)()xrSL((:)!)Ex)7PSxVfxW!eAP!7frfx{P!_!fr!e_EeLfEEPePSEE_(rLEWP)Pf(((7W77(7ASSjfxr=_d7f&fWR!=x!E!7e7ree7E)ESEC(EES_xrPPLPx(eWWxef_7)xSS)SA!EW_WxSrSft7!LASe_r_LALLPfPrPf_!_WErP_P_W_)Sf7frfAS(xA7S)eWlxWxSSW!f_WAL_ArxeSefL_!WAeeAe(EeEx(LWR7eWe7E7A7LSd(()r7)xexSSrAr!xAPr(e(EtrPP!!EA!LxeAe((AW))!f))ff!fWS_Pf(ef77(x!!PAL_P!_rOA7Lr_Ec!t7rAr)L)LSeWWP)S)_)YW!WxfW7!PP(_f(7)x1x(ArAP!(ASAeLEr_e_Ve!yrSLELWEA)(W7)Sfrfl7PWfEWPeWffrfx7(+!S({PAWAAA__e_)S(JL_7rELALWerP?(x)f)PW!)rWxfAP>P)f!fW7WA_Ar_e!fr_!)AeLxSLSS_WreLnef(!PL)E)S(xW))+e)ErW!W_frSfSe!(SEA_!)_L__7Sx(AEA)_LrWLSLSE7ErEWW_WeLrLx(P(x)P7USEyrxSSrR;uPAff(7_H)!e!WrfrEE_e_eAeLeWEE_xr(PEPE(!)!7x7r7r-_YASE!!SfWffrSSA!A)A7L(rfeLLrEW!SAEe!P!PeW))r)A7!W_xEPAP)feJ_,ESESP:x_frrAWxLx7A)eDLrP(P7exP4ExWrrPL&Px)7Wxf(Wx7!7A7fSA)WWLx7S(Y__ELr_f_errLWE_eAAYA(eAe((e(W(e7wWL7C7S7LPf(LfS7E3SSP_eAx!__tLPLfSP%!_)rALfEEPJ),(eWAf)(7ere7)E)x7(xP!!xxH7A7AfA77+7W!A!(Ae_AeEPEP(ePeS)e(!(ErxL(PS(E)A)fxLx)&_SfmWA8APbfff7L!!!E_)L!L!L_LLexe7Ej_Pr!E(PE)Lfx7xfEfS7_xSxA)r)7xPxx!(rLAfAW_!e7LSE)!G!(LPL))P(A)fWr)_fe7EfrEfPrf_#eSE!_!(_23W_PAe7SxPALA7EPL_e_P)())_ESWtrWLr(A(P)xf_fSfxS7S;!(S7WEf%S7TwrWA(LWePefLAPEerA_Afe(EA(PfLfS)EWLxrS!7_PS(P7_7PAeAP!7_)!f_PL)_!SWHr_Sre(rE)(x(!(L(e(xWWeEEN)SWLx)#eGSx7OLSfAL_r7e"));c(t(15,"O5}waL(RVDF*)QB&&5BVa(wV}R4&7LB&RQ)BQn*DFQFRD5LR(DaL}Q5&55*FF)lVB)Q*QR)VF)*aRRRRRF(*wRwaQ()*}R5Fx}&VB&Qw*BF&F)VR(L(wRc&aB*aDw*}F5}6V&}V5QF*&)wFwDD()((R}aFL)}*w5&&FFD&&DQBB})RLLFQD(VVV)RLw*LBa_}}}F&Q&BQwV}R*Qw*(*(FkVDVD(R(*aDw*w(} 5aBDBw&5B,)*DQDRwV})()()L*LQaDwQB&5w&LQB)(QR)D))D)wD}FVB(D(}LBaBi&}V5D{5&QQLBV(LLLRBV}FiL&V}LDw)L(a()}*R5axe&LBRQ(*B*aDBR}DMRR(FwBw}}(}F*7F(j(BaQ(Q5**aQFQDRVF()L&LVaawa}V}*swB})RBB(FLQ*QFRDFR)(&(V(5}BwF6D}L&P1D&RRF())V**FwDDDS(BLLLaaL5}}B}w&QD*VBB*QR))*BFQDLV*RLa5wQ}a}w})}R&(BFVQRQQD))*aFFF5V}RB(BL)aRa)5TNaFFDQ&*QBQ()XF&*5VRDLL&aRawwYa(w&*(F*mLBFBBQw(5*wFFDBV&VwaD((LwaF5*5Q5wQ*V&"));qEwqBIbpZLFe_yG=function(e)e((-u.aK_yczlW+(function()local l,n=u._nySstxF,u.QqVqWbnj;(function(e)e(e(e))end)(function(e)if l>u.pUrwMoxd then return e end l=l+u.QqVqWbnj n=(n+u.RkuRdjjI)%u.GZJnrAWX if(n%u.yIgkgOmL)<u.RtHVbdSo then return e(e(e))else return e end return e end)return n;end)()))end;Gy_eFLZpbIBqwEq={u.JwmoRUXk,u.aWeeAlpY};local e=(-u.HsJPJxgf+(function()local d,e=u._nySstxF,u.QqVqWbnj;(function(l,n,e)e(e(e,e,e),n(n and e,n,n and n),l(e,l,e and n))end)(function(n,c,l)if d>u.WJ_MBpPD then return n end d=d+u.QqVqWbnj e=(e*u.KaBFYqeC)%u.FXuLdVPb if(e%u.WHIaxvEu)>u.PoMmFRSr then return l else return n(c(l,l,l),c(c,n,c and l),n(l,c,n))end return l(l(c,l,n and n),c(n,c,n),l(c,n,n))end,function(c,n,l)if d>u.aeoAeIgA then return n end d=d+u.QqVqWbnj e=(e-u.aeoAeIgA)%u.zhSGOSWT if(e%u.hcKXFnQh)<=u.AozcobqL then e=(e-u.RAGaOGQL)%u.J_dWWARM return l else return l(n(c,l and l,c),c(n,l,c),n(l,n,n))end return l(n(c,n,n),n(l,c,n)and l(c,l and n,c),n(l,l,n and l))end,function(l,c,n)if d>u.xpyVtBEt then return l end d=d+u.QqVqWbnj e=(e*u.LhSlkQdA)%u.gXrGjXj_ if(e%u.ALCXFDsm)>u.QosUQTSn then e=(e+u.XJmTJDAD)%u.lYPvlXiK return n(n(n,n,n),l(n,n,l and l)and c(n,n and l,n and l),c(c and c,l,c))else return l end return l end)return e;end)())local r=u.sOjHsMur or u.fehzaOCy;local te=(getfenv)or(function()return _ENV end);local c=u.LLFiScIg;local d=u.IEpQFlEp;local h=u.hcJBOtsQ;local y=u.QqVqWbnj;local function le(m,...)local a=t(e,"oucm%L6(n4*l)z:7l)z%m:*nuc():6LCl*c%n:uW*c)zm)*Vg*(%z))cc:n77:6:L*)%c:4ngc6)z6n6:*uLnm:nLcl)c%z*:6uf%*m4*z.)(6:j%nc*4(7m6sz4%%*)Nz()z7z4%4*)u6nH:nzum)*%_L(%z(zum:*%&:(n:2)4mLn)n*7%L:)nmc4) 6lzu*%%*:unnc:)L6)A%*z%77(lzcm)*6U:cc(()):*cnc:l%674:u:l7LLS%6n:4*:c(7u:76O)cc)467:zl%ml)unnu7%66Lu)mc%n:7n6_lzl%L):)m6uz4JL7uz4m7XL*)%c)7u(l)*%)l)uznmzm6%zLm (n4N7*6%):mn*c_)(:c_%l)uu:nn7cL*n%%::cWL*6*E:(Lclcz4*n76l7m44c7)66):*4uLnc*nL(*%:)Lz76m(l:%*(7RL6nznzl%z*:unnc:*z%m4*(uc(*zl%**z*6uw(*:%%:ln*cz%m66uz4m%4:}n:mculzcuL))zL>)nu)(nz)6L)4%znL*4u(():6Lac:nL716%)())m6*kY*(%z:%n:LL)n(7LL*)%c:46LLuu))J4*lcc(::nLcl*)n4luFum)cmLm%:4L)Luc)zcz:n47(L))6mB4n(*:(%ml9*)u6n9:*L%l:cnl%m)6(:*m**%=:(6m4)Lc74n:(6m)lmun7u*nc:mLclLcl6*7LL*)%c7*cz7():6%:m)*6u8(*:%%:lncc))766+)*m%4:<n(c:)n6lucIn%::Ln)h)467l4lmL6m:*nuc():6L#l*Ln):74zI))m6*E9n*zu6n}:lL%l:c4zI%m44>L(czlLn(4ulnm7)Ll)*m*4L5)(c)7%%lLcLn4:m%l)1c*LL7:6l)(m%*zunnE:uL,lm:Ln47z6mz%cz*%um(nz4%:lnumn6:m6E)*mc4m76(mz)m(L)z6nn**u%(::nLc)mc64E:**l77(lln%u**uLn):LL***c(nz{c6):mu)*mu*((lzL*)%c)nz7H6zz6mu(L46/y6*z%m:*nuc4nc6L=l*c%n:7n6c))L::ZJl(4z:%nlcu*%4(cLl:mc74z+c6)z6m:n:%(u*ncLm)uc64&7*6cmu*H4L*:(6:8%*l%u:nn7c%){LmuL)>66:zn%E)mc*4(7:6(!4LcB)67zm%:l4cG(z*c6pl(cln7^cu:):%%*lummQ7mLm)mc*%cSmLl)ccz4LIl%c(7:666z>m**%0:(n:cLnl6c1n*7%L:)nmc4)06(Tz*%%:zc64E7*4L),c*4%7:6nzcm)*6up(*:%%:)%27(6766F)*m%4:tn)z:mL%ldu*n%::Ln)cc)46iJ(nzlm:*nuc():6L()nc%n:7n6c))m6*0{*(%:)%7,7d4(.7UL*)%c:4nLz6)m%%qlucc(::nLcl)c64<m4)x:lmn*cp)(6u7n4u,Lznn7cL))6m84*uc(Lzn%ct*(m6zz%L%l:cn4cL(66c:m**%6)(n:4L4)%L7n*7)4zb((uzl%L*7u4nm:zL()u7LL677mn*uYL)6zcm)p%ui(*%uml*cccn)76llcnm%4:66(cz)*%l2u*n%%)66)4c)46+R6*z%m:*nuc():6LZ)umcn:L66c))m6*&6n(%z:%nlc(4(mz*L*)%n44ntc)*z6%/**(c(::nlil)mL4e7*6%zz(%*c/)(6:D%*)mL*nn7cL)PcmO4*M%))zn%c*)u6z::*L%uluL()7)66clm**%Z:z6:c%)l6(:n*7%6z)nmc4)p6*7u4%%*:unnc:)4L77c*4%7:6nk:m)V%uC(*:%*)lnccn)76lzl(u:4:hn(cm(%6lIu*:c::Lnzu6n*LTr6*:uL*lQuc)l:7L;l*c%467nluzLL%*zC*(%u*L(::u):%7/L*)%n)7L:7L6z6%3**u%z4:nlbl)c64huL6)):mn*cS)(6:!n6)mu:46776*)66)*4=%6:zn%c*)u6n4QLL%l:cn7w7))mlzc%*%O:(n:c%)uuc^:n7%l)#%(u4)p6(n:m%%*:L6nc7%L6)_c*4z7:*6zcm)*:u4(*:%nz)(cc:*766ec(cunnqn(cz)%6l/u*nl7l66Zun*46m)6*z%m:lPLcn47%n7)umu4Lm((Rz4mz*4=*(%z:L(lc(*)L7:6()lulncIc6)z6%a**u%(::nLcl)cz4z}(*<):mn*c%)(z::n4llcVn7mu6*)z(^4*,%6::(%7l4uz6zz%L%l:cn4c7)66zNm**%S:(n:c%)l6L)n*7%L:)nmczn%6(z:uLm*:unnc:)L6)7u((:7:6nzcm)*6uX(*:%%:lnccn)7663)*(%z*Xn(cz)%6l(c(nl::Ln)cc)*Lr(L(l:m:*nuc():6Lxl*c%n:7n6c))m6*^=*(%u:n%lcu)n67}L*)%c:4nkc(lzzcz4%u%(::nLcl)c64=7*6%):mn*cC)(6:w%*l%u:n77464z%m:*nuu(Lz7c746u6nS:*L%l:cn4c7)66zem**%R:(n:c%)z:6uznmnlu)n6(:)a6*mcLnz7cIL6)z4%<46qQ6*z%m:*nuc*6c6Lu:*c%n:7n6Ac7*7u7n64:Lnl:uz4*7664z6mlLnPl(746LLlnuLn-7%L(()m*47l*64:6mz*Lcun*:LG*)nc64u/Lu)z4mm*)vz(::)uM%mlzu6nI:*Lcsl*6:L%7:u%:*mu%L4:)%lz<u7*%;z6:L7znmc4)}66:mV)KL747:u_%_z:cu:z)LczLgmL:cluun3:%%:lncEv66m)l%f**47<z(cz)%6*:()L4Rlcu)mmu46V!6*zc*lu*(z7n:(LLl*c%n:766lllLm%:Mln}z:%nlcu*4zni77L%*LYn7ccz%(4%c6uLnu:nLcl)44ALL)6Lzmmn*ci)(%:7uL%u4(nn7cL))6m_4*:%zzun%c*)u6n_:*L%l:(mzc7z6lzxm**% )m6m*cz%6crn*7%L:)nmc4)m6lyzl%:*:unnc:*(9(n%m6):m)LLl%xn u5(*:%%:lnccv)m)*F)*m%4:fn(cz))67zL*nL7(Ln)cc)4%6cn7:(lll-%:+*clLuzlc%n:7n6Tun4*uz(nz%m74z8c4*7:66llu*4cd6(6)cc74Bum4n7)63*cuT4c:L%:zKm)44uz!zn9:V%*l%u)zm(4*(l:l7(zm6nzul%c*)u6n8:*L%l:%:zc7z6*zym**%(+7uL6lul(m9n*7%L:)6nmu767z7c*4*uc4c::m7*cml*l:m(464znm)*6uI(n7*u)zm%uuu7(6L)*m%4:K6lnm*lu6uuln4::Ln)cc*uz42**z4m7*:uc():6)mc:467(66)4))m6*B_*(%z:%n7)L)n(wcL*)%c:46LlzL%)*l7ln77)6))4mz4(24%(lLcLn%ccv)(6:J%*l%u:nnu64))(m%4*B%6:%)llu)(lnH:*L%l:cn4c7)4cutml*4M:(n:c%*6*6%mL6*L:)nmc4)E6(fL*n%::u44%:)L6)<cn7))4L7)m:z(ub:ll7):z(:Luneucu/cL6*47;z(cz)%6*::*(4%L:d)cc)46+#6*z%m:*nuc(z:*L!l*c%7u6G)mm:m6*?a*(%z:%nlcm8)67jL*)%c:4nsc:)cun5*lul(::nLccc4L0cL7)Lmu*d*cj)(6:P%*l%4:)*mcLzzcmJ4*s%6)646LcLuuu4nl46mul(%6m)66c}ml*%H:n*%4%)l6c_4z7%L:)nmn*)?6(9z*%n*:u4nc:zL6)%%z4%7:6nz6m)*(uH(:D(%:lnccl)766u)*m%)(en(cz)%6l{u*n%::*()ccz46Mq6*z%m:*nuL():6LIl*c%n77nncc*m6*ra*(%z:6zlcc:c47<Ll)%(*4nbc6):nLc**u6(:7lLcl)c646/66%zumn*%&)((:V%ll%u:))7cL))6mu4*A%6:znz6*)unnf:)L%l7cn*%u666zcm*:*e:(n:cL:llc;nz7%*&)nmc4)c6(:z*%(*:ulncu)L6zc%.4%qc6n:6m)*6uj4*7Z%:l)cc4H76l})*%6l4In((z)nnl#u*n%_:l6)cmu46AL6*cum:l*m7():)LI7)c%n:7nnc:(m6*6D*(*z:nLlcu)n*786u)%c:4nkc6):nL4**u)(:m%Lcl)c6*cp66%z(mnz%h)(6:sL))7u:4c7cnu)6mA4*Vn(zzn%**)m(n2:lL%l:%%4cpn66zLm**%S:(n9c%))mc;4L7%L:)nmclce6()z*%6*:u*nc:)L()Zmu4%U46nz:m)*6uz(*:l%:)%cc4(766%mcm%*6Tnnzz)%(l=u*cl::6>)cm%462?6*z*%**nu*()::LGllc%4%7n6cu<m6*& *(6z:%nlcu))*7sL*)%mc4n,c6)z6n%**u%(:7DLcl)c640m:6%):mn*Lj)(6:p%*7nu:nn7c6m)6m_4*J%lczn%c*)u(n=:*L%l:%L4cxL66znm**%d:(n:L%))DcDn*7%L:)nmc*(T6(4z*%6*:u*nc:)6:)sc*4%X(6nzcm)*6cn(*:%%:l*ccn)766Y:mm%4:<n(cz)%6lDu:4)::Ln)c(l4(xu6*:6(m*nuc()c%L1l*c%*:hn6c))m6*P>*44z:L*)6u)n67E6l)%c:4nu%nuz6%2**Lc(::nLcz)m)457*6%):mnlz/)nn7m%*l%u:n*7cL))6mFlu_%6:zn%m*)u6n17)L4l:cn4cu666zrm*l6%m(n:c%)7Rckn*7%L:)*mc4z<6(vz*%%*:unn%:)Ln)1c*4%7:6nzcLn*6um(*:%%:lncc4:uc6C):m%*:+n(cz)Lnllu*n4::*%)cc)46uc(lz%%%*n%%():6L ))c)n:776c7um6*}H*(n:n%nl(u))77eLl)%%+)zxc(Lz6%6**u%(:-n:7l)c74=Wm6%7lmn*cuL(6:*%*l)u:nn7cL)z7mS*mQ%(dzn%%*)u646:*L6l:mA4cxL66zUL,*%u((n:%%)l:c5n*YcL:)*mc*LV6(nz*%nu6unn(:)4()Dcl4%upz:zc%u*6mL(*:%%:)*n6n)7)6r77m%4:#nn%:c%6l(u**4::Ln)cm.*(qs67z%4n*num()r6)ml*czn:yQ6c7um6)Pnl(%:n%nl6u)nz7,L*z6c:*%Zc(%z6%^**u%n::nL7l)c:4r7*6%):LD*cu6(6:z%*l6u:nnUnL))4mU*mw%(nzn6c*zu6n4:*Lnl:c74c7)6:zN%L*%u6(n:c%)l6m)n*FJL:zpmc4)V6(pmz%%l(unn::)Ln)i%*467:(czc%%*6mL(*:%L(lncLn)776Tz%m%*c(E(c:u%67zu*nL::L:):c)4l&,(hz%m7*nu6():64%l*c%n:746c))m6*}%:(%z:%nlcu)n67{L*vnc:4n5c67z6%D**u%)c:nLcl)cn4_7*6%:,z(*cuc(6:l%*l%u:n:77L)))mS1Ii%67zn%c*)u**m:*L%l:n:4c7z66:c67*%u%(n:z%)l6cBn*nmL:):mc4zY6(cz*%*l%unnn:)lz){cl4%776nz6L7*6uX(*%l%:l4cc4:cl6?zPm%)(In(cz)%6))u*nl::Lz)cc)46uczmz%%6*n%_():6L ))c)n:Pu6c7um6*<?*n6:n%nl)u)4%7qL*)%%5*) c((z6(l**u%(:7*L)l)mc4U7z6%):mn*cc6(6:(%*)Bu:n*7cL)z6m?*cV%(mzn%c*)cn:4:*Lzl:(#4c7)66:c%6*%un(n7z%)l6cx4)puL:zmmc4ze6(Az*L6lmunn::)*5)dc*4%uM(%zc%4*6L7(*:%%:lnm*n)7:6Hz(m%*?Pn(c:l%6l4u*n4::Ln)cm:77_9(%z%6c*nuc()7nLml*c7n:j66c))m6lcuL(%:*%n):u)n67Q6)):c:*L_cnmz6%?**c6nc:n6+l)L44G7*6%):ml*cuL(6::%*l6u:nnY(L)z>m>475%6:znL%ccu6nl:*47l:cn4c;:z)z_%6*%c*(n:c%))n46n*<uL:)4mc4)r6nc:m%%l)unll:)L6)jm)4(7:((zc(%*6u0(*:%6llnc)n)DL6Q))m%4:uL(c:(%6lcu*n%::Ln)Lc)*cg_67z%m:*nc%4m:6Lzl*6Ln:7n6cz:m4*vun(%c)%nlcu)4n7(L*zmc:*uFc6)z6Lc*)u%n::nL)l)c64-I)(7):%4*cu%(6:a%*l%m(nn7:L)z(mg4)D%6::U%cl4u6nL:*L%l:m*467)(%z+6l*%>:(n7%Lnl6c7n*7LL:)nmc*:()( :*%%):unnc:)6nm6c**L7:4czcm)*6cc*%:%6Iln(mn)766X)*%=4:uL(c::%6lcu*n%P6Ln)zc)*m_p6lz%Lhu:ucnn:6(6l*c%n:7nz4))%m*Ve7(%z:%n)%c6n67:L*s%c:4n?c(:z(%;l4u%4::nLcl)mn*(7*(%):n6*cg)(67cLjl%c7nnW7L))6mB*)#(6::*%c)*u6n3:*L%zccn477)(nzNm)*%,:46:cL4l6c6n*buL:z*644)u%(jc6%%*:un4%7mL6)7c*lm7:6nzcm)l)u n*:%L%lnc4n)7)(n)*%%4:**(czz%6luu*nnuuLn)cc)mn?C6lz%%c)luc():6P:l*cLn:b*zn))%6*Tc7(%z:%nlcm:n6KuL*)7c:4n;c(:7u%;l)u%*m:nLcl)c*4*7*(%):7L*cez(6:06nl%mcnn7zL)z4m84*nn6::)%clcu64%:*L*zucn*67)cczOml*%9:(n:667l6c9n*lZL:)4mc4)c%(P::%%l%unn4:)L6u*c**n7:()zc%%*6u+n%:%6mlnczn)v46N)*m44:uz(c:c%6)Lu*n%74Lnz6c)4nwH6)z%m:lDuc4D:66%l*czn:7n64))%**Du:(%z:%nznu7n6h%L*n>c:44Fc(*z6%%)zu%(::nV:l)c(4R7*n9):%)*cu4(6:,%*l%nnnnZ(L)zcmh4*X%6::c%c)9u6nc:*LLl:m*4)7)(*z_%(*%k:(n:cL)l6m%n*7LL:)4mc4)_7(/z*%%*7unnc:)L6)%c**n7:()zcm)*6uczu:%6mlnc(n)766t)*l64:uz(czz%6luu*nnL6Lnzcc)m)ta6lz%L:z(ucn*:6L:l*%4n:7n(:))%6*A;7(%z:%n)%nLn6iuL*7?c:4nsc(:z*%Dl)u%n(:nLcl)mn*c7*(():Ln*cf)(67cL:l%mcnnJuL))6m#*)uL6::z%c7zu6nS:*L%)mcn*c7)(lzXm)*%w:4Y:cL%l6mrn*7%L:)n*44)u6(5z7%%*:un4%>nL6zuc*l(7:6nzc%:)cuqn):%6(lnccn)Kn(z)*%(4:c%(cz)%6)ccmn%.cLnu%c)46dG()z(m:lzuc)m:6L2l*c%*(7n(c))%l*2T)(%z:6%lccLn6hTL*)%c:4nc06):6%^ldu%n6:nLnz.c64(7*m():m4*cu)(6:%6zl%u:nn)LL))(mJ4*cc6::n%clcu6n(:*L%z)cn447)(6zH%c*%.:46:cL)l6c6n*7zL:):%64)k:(;ln%%*7un4c:)L*:mc*4%7:%6zcmz*6uA46:%L:lnc(n)766Ez)%74:u4(c7c%6lPu*4676Lnz%c)zlS 6*z%LE)%ucn7:6Lul*c%n:}*66))%**y%4(%z:%n)%c:n6vLL*z6c:4n;c6):6%wl*u%4m:nL%l)c6*m7*6)):m:*cu)(67c)pl%c:nnu(L))6m.4*c66::4%cl(u6n+:*66)ucn*%7)nlzsm**%ucnu:cL)l6_:n*7LL:z*6(4)u*(dpL%%*:unnn7nL6zLc*4l7:64zc%m*6u}l::%%:lnc*n)766!)*(n4:Fn(c:(%6l<u*n%mcLn)cc)*4?O6*z%m::)uc():6L(l*c%n:7n*6))m6*}un(%z:%nlc6Fn67OL*zuc:4njc6)u*%,**u%n*:nLcl)c6zL7*(n):m**c8z(6:qL*l%munn7cL))6mt4:6)6::n%cn:u6nu:*(*u6cn*k7)L7ztml*%L*(n:667l6cYn*:zL:)4mc4)cc(P:*%%llunnc:)6nSmc**L7:4>zcm)*6u,nu:%L:lnc%n)7(6{z)%L4:un(c:4%6lVu*n%7)Lnzcc)4(-V6lz%m:)uuc():6Lul*c%n:7n(m))%6*Uu*(%z:%nl%(mn6wuL*)(c:4nkc6)Ln%5llu%(7:nLml)%6::7*(%):%m*cc((6: )ml%cLnn7nL)z6m *)p*6::n%czuu6nj:*L%):cn*m7)(uzxm**%c8nl:cL:l6%Ln*7%L:))m44)u6(U:(%L*7unncE*L6z%c*477:(lzcm)%*uVn::%L%lnm6n)7)6l)*%n4:u%(mzz%6lzu*nnuuLn)cc)*cXu6lz%m:)%uc40:6Lzl*c%n:7n))))%l*Mu6(%z:%nlccln6E%L*)6c:44>c(::(%Zl:u%nl:nLcl)c6477*(n):m4*ckz(6:fLLl%u:nn7mL))6m-4*,46::)%c) u6n^:*L6uLcn*(7)66zxm**%+:7*:c6ul6cun*7LL:))4*4)u6(ez4%%*7unnn7nL6zQc*4n7:64zcm:*6uhl::%%:lncnn)766;)*(n4:9n(c:6%6lNu*n%u*Lnzmc)44hd6*z%LQ*:ucn::6Lcl*c%n:7n6:))%4*CK7(%z:%n)%u:n6O%L*)nc:4nhc(:zz%!l7u%l*:nLcl)mn4)7*(*):n6*c_)(67cLul%mLnncuL))6m^*)(*6:78%c)uu6n!:*L%clcn*L7)(:z!m)*%!:n7:c6-l6cLn*7%L:z*%u4)ul(Di:%%*:un4%::L6z6c*lL7:6nzc%:*(uH4u:%%7lnccn);n64)*%)4:m:(cz)%6)cc)n%2(LnXLc)46ED6*:lm:l)uc4L:6Lcl*c%:l7n(m))%**rjl(%7fl:lcc:n6uLL*)%c:4nc%6):4%Cllu%(::n6%)mc6*%7*n4):mn*cupn(:8L)l%LLn47mL)zn*64*u*6:7z%c*)u6n_8)L%zLcn4z7)66zq%)lmb:4B:c(ul6cRn*7n6u)n%n4)m)(uzl%%*:m%ncb6L6zZc*4%7:6n5zm))uu}nL:%6(lncc*(76())*%L4:uz(cz)6RlWm%n%Y*Ln)%c)4)T46*::m:zzum(z:6L9l*cnlu7n6c))6l*u{l(%z:6%lcm6n67zL*)%c:4nm66)7u%kl6u%(::nLclzc6**7*66):m4*cu:nn:16%l%clnn7cL))6%(4*u:6:z4%c*zu6nG7(L%l:cn4m7)66z>m:J)i:n::c(Ll(cun*7n)6)n%%4)cl(uzl%%)N%znc7:L6)Lc*4%7:6:u7m)lnu0lL:L%7lnccn)7*nm)*m%4:%m(mzz%6l%mzn%::Ln7:cz4(35()_4m:l*uc4%:6LBl*c%**7n(L))%n*kR*(%z:nnlcmjn6=cL*)%c:4n2%6):l%V*7u%(::n6%)uc6*67*n6):mn*cu:nl: 6ul%%Lnn7cL)znm%4*u)6:7%%c*)u64cB(L%z(cn4:7)66z;%)*7W:4c:c4Ll6c5n*7%(L)n%(4)cx(Pz)%%*:L4nc,eL6)cc*467:6nznm)l*uC(l:%LHlnm%4676(L)*6l4:Xn(c::%4lim;n%mcLn)cc)46um6*:nm:l:uc():6LP)zc%*u7n6c))mn*g0))lz:L)lcuzn67gL*)%4)4nuL6):*%9**u%(:7zLc)7c64f7*6%):mnluH)(6:C%*l%u:nn7cnm)6mQ4*9L6:zn%clLu6ns:*LLl:cn4c7)66zAm**%F:(nzcnll6cLn*7%L::nn:4)C((Ez*%%*7unnc7ZL6)uc*4L7:64zcm)l(uX(l:%%:lnccn)76(m)*mL4:D4(czz%6lvc6n%::Ln)mc)46^T6*z%m:*nuL():6LWllc%n:7n6c)z%(*>=*(%z)4ncun*7L6))Lm*Lnu46z:4.klcu44R:z:46cl)c64G7n)(u:lm7z(7)mcz4l3:6z:u(czl%cl%4l2z6:zn%czc*znY:*L%)ucn4m7)6(zEm:)(}:(n:c%7l6cun*7nnu)nmc4)})(izl%%).%znc:zL6)mc*4%7:6nu*m)*(uR():%%:lnc6*7766;)*m)4:_4(c::l)l!uln%7eLn)cc)46%n6*zLm:**uc():6Lx:uc%n:7n6m))m6*a}*(%z:%nlcu)n678Ll)6c:4nTc6)6c%!**u%(::nLcl)c6l(7*6%):m4*c=)(6:H%*l%u:n47cL))6mO4*1%6:zn%c*),6l7:*L4l:cn4cu))czdml*%R:(n:m%)l6c4n*7LL:)4mc4zJ6(q7c%%*7unnc:)L6)vc**)7:64zcmz*6uu(*:%LLlnccn)7(6y)*m%4:an(cz)%:l-u*n%:7L:)cc)467::nm7**u:nu():6L-l*c%n:7n6c;)m(*LS*(%z:%6mv47Z#L7L*)%c:4n?c6)z6mN:4uLn%:nLcl)c%I*6()7%%*:*mu((6:Y%*lcn(7u(kzL%m*:u6((:6%4%ml4u6nV:*Lcml4(u_(mzL%:*Lcc(4:%Lnlll(c(n*7%L:)6*7u*nc:mLclLlD6:nc:)L6zc%m4%Zq6nz(m)*6u8(*2?%:llccn)766P)*m%*%Un(6z)%(lFu*n%::6l)cc7460m6*znm:*num():*LGl*c%n:7n6cz4m6*%0*(nz:%nlcu)nz7OL7)%c:4nwc6)z6L(**u6(::zLcl:c646%(6%zUmn*:x)((:8%*l%cc*l7cL))6m)4*SL6:znL%*)u4nj:lL%l:cn4c%%66zmm**6X:(n:cL::lc}nz7%6u)nmc4){6n)z*%n*:u4nc:)L6)t)74%Mu6nz%m)*nu;*j(l%:llcc4:766u)*m)4:y)4Lz)%6lBc)n%:7Ln)6%7465b6*9mm:*4uc()6mLflzc%n:7n6c))m6l:v*((z:%llcuzn676(%)%mu4nu*6)z(%q*lu%ncBlLcl)c6*n7*6L):mnl%+)(4:T%*l%u:nn7c*%)6mm4*266:zn%c*)4mns:zL%l:cn4c7)66::m**(R:(l:c%zl6c&4)7%6c)nmc4)E6(fz*)u*:uznc:)L6),c*4*3*6nznm)*(ux(l:%%7lncczr766^)*mn4:dn(cz)z%lQu7n%:7Ln)nc)*nmL6*z4m:*7uc():6LW:mc%4%7n6c))m6*_;*4zz:%7lcu)n67uL*)*m*4n1*6)z6%,*lu%(7:nLcBUc64Q7*6n):mn*cu)():qLul%c%nn7*L))6mL4*+46:z7%c*:u64cFuL%)%cn4(7)66z/m*lzW:(7:c%)l6ckn*7%6z)nm44)#z(fz*%%*:u4nc7%L6)Lc*4%7:6nz)m)*)uXnc:%%7lnccQ47666)*m%4:Rn(cz)z%lCc{n%:7Ln)Lc)46%n6*znm:**uc():6L2u)c%4u7n6c))m6*du)*4z:%llcu7n67&L*)%%*4n_66)z(%I**u%(:nzLcl7c64c7*66):L:m4S)(4:i(7l%u7nn7mL))*Lm4*V%6:Zz%c*zu6n%9zL%l:cn:(7)6(zWm*cuW:(l:c%)l6cBn*u%z6)nm64),((hz:%%*:u*nc:7L6)mc*4n7:nn:(m)**ud(l:%Lxlncc*L766m)*m(4:e)(cz)Lml u:n%::Ln)cc)46ua6*z4m:*nuc():6(5)Lc%4%7n6m))m**<K*4cz:%zlccun676L*:%n)4n_n6)z(%;*)u%n%7%Lc)mc64c7*6L):m4*c0)l*:5%*l%ccnn7cL))6l:4*346:z:%clmu64cu7L%)mcn447)66z!m*)zB:(::c%)l6c!n*7%n()nm44)b6(Azl%%l%c%nc7%L6)mc*4L7:64zcm):*uI(*:%Lclnccn)b666)*ml4:H:(c:%%6lyu7n%7mLn)4c)4ntO()z6m:*:ucnu:6L9l*c%4)7n64))m6*gB*(%z:6Ulccmn67(L*)%c:4nNL6)z:%y*7u%(::nLc)cc6467*6)):m4*cT)7m:NLhl%u:nn7cL):6l64*Cl6:z4%cl u6na::L%)%cn4n7)6zzjL**7R:(7:c%zl6ccn*7%6%)nmn4)vz(/zz%%*:u7nc7qL6)cc*4%7:6nzzm)*4u^(*:%%:lncclm766,)*mL4:-n(c:I%6lHu*n%::Ln)cc)44r#6*z%m:l*uc():6Lul*c%n:7n::))m6*.x*(%z:%nlc%mn671L*)Lc:4n!c6)z6%p**u%(::nLclzc*4S7*6%):%**cBz(6:u%*l%u:nn(:L))(mw4*t%6:zn%czmu6nX:*LLl:cn4c7)nzz#m**%37(n:c%)l6cQn*7%L:)nmc4)U((%z*%%*:un4%:)L()/cl4%7:6nzc)n*6uu(*:%%:lnccn)uz6C)*m%47Hn(cz)%6z(u*n%::L4)cc)46d&6*z%m:*nuc():6LWlzc%n:7n6cz:m6*^b*(Lz:%nlcu)uc7KL*)%c:4n.c6)z66(**u%(::4Lcl)c64f7*6%):m4*cC)(6:h%*l%u:nn7cL)l6674*^46:zn%c))(cnp:lL%l:cn4m7)66:sm**L1:(4:c%zl6cH*%7%L7)nmc4)w6(^z*LL*:u4nc:zL6)uc*4%u66nzcm)*(uK(*:%%:lnccn)7:6Q)*m%47r)(cz)%6*:4(CmL*Ln)cc)46OX6*z%m::nuc():6L,l*c%n::ncu)zm6*-r*(%z:%nlcu)n67DL*l%6z4nPc6)z6%s**u%::cnLcl)c64Y7*6%):mn*cZ)(6:,%*l%u:nncc4))l(m4*d%6:znl7*)ulna:*L%l:cn4cu*66zLm**4y:(n:cLcz_c?n77%6m)nmm4)e((Fz:6(*:unnc7uL6)uc*4ncu6nzcm)*:u&(l:%%:mLcc4u7668)*m%4:On4Hz)%llvu7n%::Ln)c(%46>L6*z6m:*nuc()6mL#l7c%n77n6c))m6-7A*(Lz:%zlcuzn6bc6>)%mm4nD46)z6%.l)cu(:::Lc)uc64Y7*(6z)mn*4P)(4:}%*l%u:477c6%)6mu4*&%6:zn%)*)u:nt7cL%)ccn*%Rc66z4m**l#:(n:cL:c)ck4%7%6c)nmc4)<6l6z*%7*:uznc::L6:6)u4%T46n:(m)*(u;nu:%Lczlccn)76(L)*mL4:k)4Lz)%6lAm6n%:7Ln)c*446&)6*z6m:*nuc4)74L>)(c%n77n6m))m6l6;*nmz:%:lcu)n67_Lz)%m:4n&n6)z6%b**c7(:7LLc))c64c7*6%z)mn*:Z)nc:<L(l%m:4(7c6L)6m)4*G)6:7:z4*)cun8y4L%l7cn4(7)6*7mm**%.:4(:c%zl6c%*z7%L:)nLn4)s((3z*)u*:c%nc::L6),c*l%f66nz7m)*(u,(l:%%:zLcc4l7666)*m%4:en((z)L6lQc_n%::Ln)cm446Bz6*:%m:**uc()7cLK)6c%4*7n67))m6l4^*(zz:Lulccnn6u67u)%m44ncl6)z(%T*)u%ncQlLcl)c6l47*6L):m))LF)(6:xnml%u7nnucnl)6m(4*kl6:zz%c*)lnnb76L%)ucn4c7)66z:m*l-X:(7:cLnl6%K4*7%6*)nm:4)xl(_z*%n*:cLnc:7L6)qc*l% (6n:}m)*4u^(l:%%:l:cc4)766))*m%4:Gn((z)L(lHc6n%::Ln)c%m46.:6*:Lm:**uc()%)L0)(c%4l7n(}))m6*(T*nuz:Lulcc4n67N6))%m)4n_)6)z6%-**u:(:7(Lcl7c64b7*n%:6mnlc.)nm:<L,l%u:nl7c6l)6m74*u%6:znL6*)cdnD7nL%)zcn4n4*66z6m*:b>:(4:cL%l6c%*z7%L:)n6:4)d((rz:6(*:unncclL6)uc*4%(l6nz:m)*6uH(*:%%:%6cc4n766I)*m:4:jnl*z)L2lRu)n%::Ln:cLl46FL6*z4m:*zuc4)uLLB)Rc%4%7n6())m*)mC*(%z:L4lcuzn67Anu)%c:4nGm6)z6%<**u%(::nL6l)c64;7*6%):mn*cE)(6:i%*l%u:nn7cL))6mFn*%m67:L%c*)u6(:%m)zu)4:/:67zLcLl6c(nc)*:mLcl6c{n*7cznmL4zuc()(V74%%*:unncc6L6)Xc*4%7:6nzcm)l:ux(l:%%7lnccn)766%)*m64:M*(cz)%6lKccn%:7Ln)mc)4nM;6*:7m:*nuc(::6Lcl*c*4c7n6c))m:*fTl(%z:%nl6m7n67#L*))c:44vc(>74%,**u%4u:nLml)c6l47*6%):mn*c&)(67c(7l%u7nn76L))6m&*=ux6:z*%c*)u6nu:*L(l:cn)%7)66zsmz*%x:(n:c(:l6cKn*7LL:)nmc4)mn(Jz*%%lRunnc:)L6%Lc*4L7:6*zcm)*6uy)u:%%:lnccn)7(61:*4c4:3n(cz)%6lcu*n*mlLn)cc)l%jd6lz%m:*nu647:6LRl*%cn:746cz:*)*;K*(%z7%nlcu)n6n*L*)%c:4)^c6)z6%N)(u%(::nL(l)c64^7*6L):m4*cuc(6:I%*l%mcnn7cL))nmj4lX%n&:6%c*)u6nm:*L%l:cn*47)66z/ml*%.7(n:c6Ll6cPn*7LL:)nmc4)*z(5z*%%*:unnc:)Lnu(c*4L7:64zcm)*6ue7):%%7lncmn)7(6r)*Ll4:+n(czz%6l8u*n6::Ln)cc)46?C6*z%%L*nuc():6*?l*c%n:7n6c))m6*ecu(%z7%nlmu)n67eL*z6c:4*8c6:z6%}**u%nL:nLml)c(4h7)6%):Lu*cd)(6:u%*l%u:nn7%L))6mv4*g%6:zn%clUu6na:*LLl:cn4c7)66zVm**Ld:(n:c%)l6cRn*7%L:)ncczlH6(Lz*%%*:mnz::)L()dc*4%776nzc%:*6uu(*:L%:l4ccn)#L6w)lm%4:Zn(cz)%6))u*nL::L4)ccz46eI(uz%m:*num():6LGl*c%n:7n64))m6*t2l(%z:%nlcuzn(7PL*)%c)44vn6)z6%/uznn7ULu)Ecmc64f7*6%):mn*c7)lL:Q%*l%u:nn7cL)m6(.4ld46:zn%ccG((:cL6l4l:cn4c7)66zJm**%%:(4u6%)l6cdn*(uL:)4mc4)_6(Yz*%%)*unn%:)L6){c*4%7:Uzzcmz*6uc(*:6%:z:l4n)7(6Izwm%47;n(nz)%*zmu*n%::L:)ccz46y%nzz%m:*nu7():(LOl**un:746c)zm6*eC*(%7*%nl%u)n678L*)%m%*%Pc67z6%=**uL(::*Lcl)6*4h7*6%):mn*cV)(6uc%*l%u:n*7cL))6mTu%S%67zn%L*)u(ny::((l:cn4cc:66zum**%nl(n:m%)l6cyn*7%L::%mc4:,6(9z*%%*:unc(:)L()Gc)4%JT6n7n4%*6uu(*u6%:l4ccn7766%:zm%4:=n*%z)%(l.u*):::L4)cc)46;96*:c64*nu6()7)LQllc%n77n66:7m6*QM*n*z:%4lcc{*47hL*)%6Y4nYm6)z6lz**uL(::lLcl)c64ky(6%zCmn*cv)(6:DL)z;u:nl7c6J)6mb4*u6nmzn%6*)u*nV:*L%l:mc4c7z66z%m**6_:4:7:%)l(c.l)7%L7)nm%4)G*4mz*%%*:%*nc:zL6zc*24%776nzmm)*6uBn)L*%:l*cc4m766P)*m%)BWn(Lz)%6lvu*n%a?L*)cm}46b%6*z%m:*)c7():nL1:lc%n77n6c:nm6*6X*(Lz:%nlcu)*:7y6u)%mc4n c6)z6L6**u)(::)Lcl)c649776%z(mn*Lq)(6:?%*lzu:4c7cL))6m.4*i%(uzn%z*)ulng:*L%l:m)4cWn66zLm**%+:(n:n%)l7cU467%6h)nmcl*.6(nz*%)*:cunc:))*)/mm4%Dm6nzcm)*6uz(*:)%:) cc4L76nHz4m%*6pn(*z)%ll_u*4l::L7)cmm46Bn6*z%%)*num():)L})uc%4c6W6c):m6)c.*(Lz:%n7*u)n(7WL))%c:4n-cl%z6%B**u6(::nLcl)%z4a7*6%)7mn*cJ)((:>%*l%u:nn7cL))nm64*N%6:zn6m*)unnF:*L%l:cn4c_L66zmm**Lr:(n:c%)llc1n:7%L7)nmc4)y6ncz*%(*:u*nc::L6)Dm:4%}T6nzcm)*4uS(*7n%:lnccnz766M)*m%4:Jn(c");local n=u._nySstxF;u._vHWiiDP(function()u.sCkkbmTv()n=n+u.QqVqWbnj end)local function e(e,l)if l then return n end;n=e+n;end local l,n,o=f(u._nySstxF,f,e,a,u.iltbrbyJ);local function t()local l,n=u.iltbrbyJ(a,e(u.QqVqWbnj,u.LLFiScIg),e(u.bMytLUJw,u.LTVBLDER)+u.IEpQFlEp);e(u.IEpQFlEp);return(n*u.auTEJXgM)+l;end;local ne=true;local z=u._nySstxF local function _()local e=n();local n=n();local c=u.QqVqWbnj;local d=(l(n,u.QqVqWbnj,u.TPBsOagT)*(u.IEpQFlEp^u.aAveAUto))+e;local e=l(n,u.BTTkXkzD,u.SYyMczph);local n=((-u.QqVqWbnj)^l(n,u.aAveAUto));if(e==u._nySstxF)then if(d==z)then return n*u._nySstxF;else e=u.QqVqWbnj;c=u._nySstxF;end;elseif(e==u.czsIGuWT)then return(d==u._nySstxF)and(n*(u.QqVqWbnj/u._nySstxF))or(n*(u._nySstxF/u._nySstxF));end;return u.EwhYpRbF(n,e-u.c_o_eqpK)*(c+(d/(u.IEpQFlEp^u.LZQJCSIC)));end;local b=n;local function k(n)local l;if(not n)then n=b();if(n==u._nySstxF)then return'';end;end;l=u.SniecMIg(a,e(u.QqVqWbnj,u.LLFiScIg),e(u.bMytLUJw,u.LTVBLDER)+n-u.QqVqWbnj);e(n)local e=""for n=(u.QqVqWbnj+z),#l do e=e..u.SniecMIg(l,n,n)end return e;end;local b=#u.JwmoRUXk(s('\49.\48'))~=u.QqVqWbnj local e=n;local function de(...)return{...},u.YvOFQMrz('#',...)end local function ce()local z={};local e={};local s={};local a={s,z,nil,e};local e=n()local f={}for d=u.QqVqWbnj,e do local l=o();local e;if(l==u.LLFiScIg)then e=(o()~=#{});elseif(l==u._nySstxF)then local n=_();if b and u.JSnUvTiF(u.JwmoRUXk(n),'.(\48+)$')then n=u.GsouUfkB(n);end e=n;elseif(l==u.QqVqWbnj)then e=k();end;f[d]=e;end;a[u.LLFiScIg]=o();for a=u.QqVqWbnj,n()do local e=o();if(l(e,u.QqVqWbnj,u.QqVqWbnj)==u._nySstxF)then local r=l(e,u.IEpQFlEp,u.LLFiScIg);local o=l(e,u.hcJBOtsQ,u.LTVBLDER);local e={t(),t(),nil,nil};if(r==u._nySstxF)then e[c]=t();e[h]=t();elseif(r==#{u.QqVqWbnj})then e[c]=n();elseif(r==m[u.IEpQFlEp])then e[c]=n()-(u.IEpQFlEp^u.KkrRQL_I)elseif(r==m[u.LLFiScIg])then e[c]=n()-(u.IEpQFlEp^u.KkrRQL_I)e[h]=t();end;if(l(o,u.QqVqWbnj,u.QqVqWbnj)==u.QqVqWbnj)then e[d]=f[e[d]]end if(l(o,u.IEpQFlEp,u.IEpQFlEp)==u.QqVqWbnj)then e[c]=f[e[c]]end if(l(o,u.LLFiScIg,u.LLFiScIg)==u.QqVqWbnj)then e[h]=f[e[h]]end s[a]=e;end end;for e=u.QqVqWbnj,n()do z[e-(#{u.QqVqWbnj})]=ce();end;return a;end;local function le(l,e,n)local d=e;local d=n;return s(u.JSnUvTiF(u.JSnUvTiF(({u._vHWiiDP(l)})[u.IEpQFlEp],e),n))end local function k(p,a,o)local function ce(...)local t,_,j,le,m,n,s,b,g,ee,z,l;local e=u._nySstxF;while-u.QqVqWbnj<e do if u.LLFiScIg<=e then if e<u.bMytLUJw then if e>u._nySstxF then repeat if u.LLFiScIg<e then ee=u.YvOFQMrz('#',...)-u.QqVqWbnj;z={};break;end;b={};g={...};until true;else b={};g={...};end else if e>=u.QqVqWbnj then for n=u.SvTJGzcu,u.vWhgMgoS do if e~=u.LTVBLDER then l=f(u.qYliwImR);break;end;e=-u.IEpQFlEp;break;end;else e=-u.IEpQFlEp;end end else if e>=u.QqVqWbnj then if e>u._nySstxF then repeat if u.QqVqWbnj<e then n=-u.SvTJGzcu;s=-u.QqVqWbnj;break;end;j=f(u.LTVBLDER,u.SYyMczph,u.LLFiScIg,u.wIPnuuHp,p);m=de le=u._nySstxF;until true;else j=f(u.LTVBLDER,u.SYyMczph,u.LLFiScIg,u.wIPnuuHp,p);m=de le=u._nySstxF;end else t=f(u.LTVBLDER,u.AMPFlVvQ,u.QqVqWbnj,u.rGptoLxL,p);_=f(u.LTVBLDER,u.SwxGLrvO,u.IEpQFlEp,u.AMPFlVvQ,p);end end e=e+u.QqVqWbnj;end;for e=u._nySstxF,ee do if(e>=j)then b[e-j]=g[e+u.QqVqWbnj];else l[e]=g[e+u.QqVqWbnj];end;end;local j=ee-j+u.QqVqWbnj local e;local f;function OoTlrieKryjH()ne=false;end;local function g(...)while true do end end while ne do if n<-u.unZnGZsA then n=n+u.wToYTLK_ end e=t[n];f=e[y];if u.attIXFfl<=f then if f<=127 then if f<=105 then if 95<=f then if 99<f then if 103>f then if 100>=f then local f,u,h;for r=0,2 do if 0<r then if 2>r then l(e[d],e[c]);n=n+1;e=t[n];else f=e[d];u=l[f]h=l[f+2];if(h>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end else l(e[d],e[c]);n=n+1;e=t[n];end end else if 99<=f then for u=10,64 do if 101<f then local f,f,f,m,z,f,f,o,s,_,u,k,r,b;for f=0,6 do if 3>f then if f>0 then if f>=-3 then repeat if 1<f then f=0;while f>-1 do if f<4 then if f<2 then if f==1 then o=d;else u=e;end else if-1<=f then repeat if f>2 then m=l;break;end;s=c;until true;else m=l;end end else if f>=6 then if f>=2 then repeat if 7>f then l[r]=z;break;end;f=-2;until true;else l[r]=z;end else if 2<=f then for e=29,66 do if f~=4 then r=u[o];break;end;z=m[u[s]];break;end;else r=u[o];end end end f=f+1 end n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]]+l[e[h]];n=n+1;e=t[n];until true;else f=0;while f>-1 do if f<4 then if f<2 then if f==1 then o=d;else u=e;end else if-1<=f then repeat if f>2 then m=l;break;end;s=c;until true;else m=l;end end else if f>=6 then if f>=2 then repeat if 7>f then l[r]=z;break;end;f=-2;until true;else l[r]=z;end else if 2<=f then for e=29,66 do if f~=4 then r=u[o];break;end;z=m[u[s]];break;end;else r=u[o];end end end f=f+1 end n=n+1;e=t[n];end else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else if f>4 then if 5==f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else f=0;while f>-1 do if f>2 then if f<=4 then if f>-1 then for e=36,60 do if 3<f then b=l[k];for e=1+k,u[_]do b=b..l[e];end;break;end;r=u[o];break;end;else r=u[o];end else if 4<=f then repeat if f<6 then l[r]=b;break;end;f=-2;until true;else l[r]=b;end end else if 1>f then o=d;s=c;_=h;else if f>0 then repeat if 2~=f then u=e;break;end;k=u[s];until true;else k=u[s];end end end f=f+1 end end else if 2<f then for u=12,94 do if 3<f then l[e[d]]=l[e[c]]%e[h];n=n+1;e=t[n];break;end;l[e[d]]=a[e[c]];n=n+1;e=t[n];break;end;else l[e[d]]=a[e[c]];n=n+1;e=t[n];end end end end break;end;l[e[d]]={};break;end;else local f,f,f,m,z,f,f,o,s,_,u,k,r,b;for f=0,6 do if 3>f then if f>0 then if f>=-3 then repeat if 1<f then f=0;while f>-1 do if f<4 then if f<2 then if f==1 then o=d;else u=e;end else if-1<=f then repeat if f>2 then m=l;break;end;s=c;until true;else m=l;end end else if f>=6 then if f>=2 then repeat if 7>f then l[r]=z;break;end;f=-2;until true;else l[r]=z;end else if 2<=f then for e=29,66 do if f~=4 then r=u[o];break;end;z=m[u[s]];break;end;else r=u[o];end end end f=f+1 end n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]]+l[e[h]];n=n+1;e=t[n];until true;else f=0;while f>-1 do if f<4 then if f<2 then if f==1 then o=d;else u=e;end else if-1<=f then repeat if f>2 then m=l;break;end;s=c;until true;else m=l;end end else if f>=6 then if f>=2 then repeat if 7>f then l[r]=z;break;end;f=-2;until true;else l[r]=z;end else if 2<=f then for e=29,66 do if f~=4 then r=u[o];break;end;z=m[u[s]];break;end;else r=u[o];end end end f=f+1 end n=n+1;e=t[n];end else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else if f>4 then if 5==f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else f=0;while f>-1 do if f>2 then if f<=4 then if f>-1 then for e=36,60 do if 3<f then b=l[k];for e=1+k,u[_]do b=b..l[e];end;break;end;r=u[o];break;end;else r=u[o];end else if 4<=f then repeat if f<6 then l[r]=b;break;end;f=-2;until true;else l[r]=b;end end else if 1>f then o=d;s=c;_=h;else if f>0 then repeat if 2~=f then u=e;break;end;k=u[s];until true;else k=u[s];end end end f=f+1 end end else if 2<f then for u=12,94 do if 3<f then l[e[d]]=l[e[c]]%e[h];n=n+1;e=t[n];break;end;l[e[d]]=a[e[c]];n=n+1;e=t[n];break;end;else l[e[d]]=a[e[c]];n=n+1;e=t[n];end end end end end end else if f<=103 then for f=0,1 do if-1<=f then for u=26,54 do if 1>f then l[e[d]]=o[e[c]];n=n+1;e=t[n];break;end;if not l[e[d]]then n=n+1;else n=e[c];end;break;end;else l[e[d]]=o[e[c]];n=n+1;e=t[n];end end else if 104==f then local d=e[d];local f=l[d+2];local t=l[d]+f;l[d]=t;if(f>0)then if(t<=l[d+1])then n=e[c];l[d+3]=t;end elseif(t>=l[d+1])then n=e[c];l[d+3]=t;end else local u;for f=0,6 do if f>=3 then if 5>f then if f~=-1 then for u=42,54 do if f<4 then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end else if 5<f then l[e[d]]=l[e[c]];else u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];end end else if f>=1 then if-2<=f then for u=33,53 do if f<2 then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end else l(e[d],e[c]);n=n+1;e=t[n];end end end end end end else if 96>=f then if 96==f then l[e[d]]=l[e[c]]+l[e[h]];else local e=e[d];do return r(l,e,s)end;end else if 98>f then l[e[d]]=l[e[c]][l[e[h]]];else if f>95 then for u=40,63 do if 99~=f then local t=e[d];local c={};for e=1,#z do local e=z[e];for n=0,#e do local n=e[n];local d=n[1];local e=n[2];if d==l and e>=t then c[e]=d[e];n[1]=c;end;end;end;break;end;local f;for u=0,2 do if u<1 then f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];else if u>=-1 then repeat if u<2 then l[e[d]]=l[e[c]]-e[h];n=n+1;e=t[n];break;end;l[e[d]][l[e[c]]]=l[e[h]];until true;else l[e[d]][l[e[c]]]=l[e[h]];end end end break;end;else local f;for u=0,2 do if u<1 then f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];else if u>=-1 then repeat if u<2 then l[e[d]]=l[e[c]]-e[h];n=n+1;e=t[n];break;end;l[e[d]][l[e[c]]]=l[e[h]];until true;else l[e[d]][l[e[c]]]=l[e[h]];end end end end end end end else if f>89 then if f>=92 then if 92<f then if f~=89 then repeat if 93~=f then l[e[d]]=l[e[c]][e[h]];break;end;local n=e[d];local d=l[n];for e=n+1,e[c]do u.xVXXKBCG(d,l[e])end;until true;else l[e[d]]=l[e[c]][e[h]];end else l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;end else if f~=89 then repeat if f>90 then local u;for f=0,6 do if f<=2 then if f>0 then if f~=-1 then for u=40,90 do if 2>f then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end else l(e[d],e[c]);n=n+1;e=t[n];end else if f<5 then if f~=-1 then for u=27,53 do if 4>f then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end else if 3<=f then for h=46,96 do if 5~=f then l[e[d]]=l[e[c]];break;end;u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];break;end;else l[e[d]]=l[e[c]];end end end end break;end;local u;for f=0,6 do if 3>f then if 1<=f then if f>=-2 then for u=23,90 do if 2>f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else if 5<=f then if f>4 then repeat if f>5 then if(l[e[d]]==e[h])then n=n+1;else n=e[c];end;break;end;l[e[d]]=#l[e[c]];n=n+1;e=t[n];until true;else l[e[d]]=#l[e[c]];n=n+1;e=t[n];end else if 4==f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else u=e[d]l[u]=l[u](l[u+1])n=n+1;e=t[n];end end end end until true;else local u;for f=0,6 do if 3>f then if 1<=f then if f>=-2 then for u=23,90 do if 2>f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else if 5<=f then if f>4 then repeat if f>5 then if(l[e[d]]==e[h])then n=n+1;else n=e[c];end;break;end;l[e[d]]=#l[e[c]];n=n+1;e=t[n];until true;else l[e[d]]=#l[e[c]];n=n+1;e=t[n];end else if 4==f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else u=e[d]l[u]=l[u](l[u+1])n=n+1;e=t[n];end end end end end end else if f>=87 then if 87>=f then l[e[d]]=k(_[e[c]],nil,o);else if 88<f then local t=l[e[h]];if not t then n=n+1;else l[e[d]]=t;n=e[c];end;else if(l[e[d]]==e[h])then n=n+1;else n=e[c];end;end end else if 81<f then repeat if 86~=f then l[e[d]]=l[e[c]][e[h]];break;end;local n=e[d]l[n]=l[n](r(l,n+1,e[c]))until true;else l[e[d]]=l[e[c]][e[h]];end end end end else if f>116 then if f>=122 then if 124<f then if f<126 then l[e[d]]=a[e[c]];else if 123~=f then repeat if f~=127 then local n=e[d];do return l[n](r(l,n+1,e[c]))end;break;end;if(l[e[d]]==l[e[h]])then n=n+1;else n=e[c];end;until true;else local n=e[d];do return l[n](r(l,n+1,e[c]))end;end end else if f<=122 then local n=e[d]l[n](r(l,n+1,e[c]))else if 121<f then for n=20,76 do if 123<f then local r,s,a,t,o,u,f;local n=0;while n>-1 do if n>2 then if 5>n then if n>2 then for e=31,90 do if 3<n then f=l[o];for e=1+o,t[a]do f=f..l[e];end;break;end;u=t[r];break;end;else u=t[r];end else if n>=3 then repeat if n~=5 then n=-2;break;end;l[u]=f;until true;else l[u]=f;end end else if n<1 then r=d;s=c;a=h;else if n~=0 then for l=48,72 do if 1~=n then o=t[s];break;end;t=e;break;end;else t=e;end end end n=n+1 end break;end;l[e[d]]=(e[c]~=0);break;end;else l[e[d]]=(e[c]~=0);end end end else if 119<=f then if f<=119 then local f;l[e[d]]=l[e[c]];n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))else if f~=119 then for u=44,98 do if 121>f then l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=(e[c]~=0);n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][e[h]];break;end;local f,u,o;for r=0,4 do if r>=2 then if r<=2 then l[e[d]]=#l[e[c]];n=n+1;e=t[n];else if r<4 then l(e[d],e[c]);n=n+1;e=t[n];else f=e[d];u=l[f]o=l[f+2];if(o>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end end else if 0~=r then l(e[d],e[c]);n=n+1;e=t[n];else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end end end break;end;else local f,u,o;for r=0,4 do if r>=2 then if r<=2 then l[e[d]]=#l[e[c]];n=n+1;e=t[n];else if r<4 then l(e[d],e[c]);n=n+1;e=t[n];else f=e[d];u=l[f]o=l[f+2];if(o>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end end else if 0~=r then l(e[d],e[c]);n=n+1;e=t[n];else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end end end end end else if f>115 then for n=39,68 do if 117<f then local t,u,h,r,f;local n=0;while n>-1 do if 3>n then if n<1 then t=e;else if 0~=n then repeat if n<2 then u=d;break;end;h=c;until true;else h=c;end end else if 4>=n then if 2~=n then repeat if n<4 then r=t[h];break;end;f=t[u];until true;else f=t[u];end else if 4<n then for e=44,71 do if 6>n then l(f,r);break;end;n=-2;break;end;else n=-2;end end end n=n+1 end break;end;l[e[d]]=l[e[c]]-l[e[h]];break;end;else l[e[d]]=l[e[c]]-l[e[h]];end end end else if f>110 then if f>113 then if 115>f then l[e[d]]=l[e[c]]-l[e[h]];else if f~=114 then repeat if 116>f then l[e[d]]=l[e[c]]-e[h];break;end;local z,s,b,u,r,m,o,f;for f=0,4 do if 2<=f then if f>2 then if 0<f then for a=40,97 do if 4>f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;f=0;while f>-1 do if 3<=f then if f<=4 then if f~=-1 then for e=36,56 do if f~=3 then o=l[r];for e=1+r,u[b]do o=o..l[e];end;break;end;m=u[z];break;end;else m=u[z];end else if 2<=f then for e=19,88 do if 5~=f then f=-2;break;end;l[m]=o;break;end;else f=-2;end end else if 1<=f then if 0~=f then for n=40,55 do if f~=2 then u=e;break;end;r=u[s];break;end;else r=u[s];end else z=d;s=c;b=h;end end f=f+1 end break;end;else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else l[e[d]]=l[e[c]]%e[h];n=n+1;e=t[n];end else if 0~=f then l[e[d]]=l[e[c]]+l[e[h]];n=n+1;e=t[n];else l[e[d]]=a[e[c]];n=n+1;e=t[n];end end end until true;else l[e[d]]=l[e[c]]-e[h];end end else if f>111 then if f>108 then for n=30,68 do if 112~=f then a[e[c]]=l[e[d]];break;end;l[e[d]]=l[e[c]]%e[h];break;end;else l[e[d]]=l[e[c]]%e[h];end else for f=0,6 do if 3>f then if f>=1 then if 0~=f then for u=20,98 do if f>1 then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else if f>=5 then if 5==f then l[e[d]]=l[e[c]]-l[e[h]];n=n+1;e=t[n];else l(e[d],e[c]);end else if 1<f then for u=24,94 do if 4~=f then l(e[d],e[c]);n=n+1;e=t[n];break;end;l[e[d]]=#l[e[c]];n=n+1;e=t[n];break;end;else l[e[d]]=#l[e[c]];n=n+1;e=t[n];end end end end end end else if f<108 then if f>104 then for u=34,89 do if 106~=f then if(l[e[d]]==e[h])then n=n+1;else n=e[c];end;break;end;local h,u,r,m,z,a,f,s;f=0;while f>-1 do if 4>f then if 1<f then if f~=-2 then repeat if f~=3 then r=c;break;end;m=l;until true;else r=c;end else if-3<=f then for n=21,60 do if 0~=f then u=d;break;end;h=e;break;end;else u=d;end end else if f<6 then if f~=1 then repeat if f~=5 then z=m[h[r]];break;end;a=h[u];until true;else a=h[u];end else if 3~=f then for e=10,81 do if f>6 then f=-2;break;end;l[a]=z;break;end;else f=-2;end end end f=f+1 end n=n+1;e=t[n];s=e[d]l[s](l[s+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;n=n+1;e=t[n];for e=e[d],e[c]do l[e]=nil;end;break;end;else local u,h,r,z,m,a,f,s;f=0;while f>-1 do if 4>f then if 1<f then if f~=-2 then repeat if f~=3 then r=c;break;end;z=l;until true;else r=c;end else if-3<=f then for n=21,60 do if 0~=f then h=d;break;end;u=e;break;end;else h=d;end end else if f<6 then if f~=1 then repeat if f~=5 then m=z[u[r]];break;end;a=u[h];until true;else a=u[h];end else if 3~=f then for e=10,81 do if f>6 then f=-2;break;end;l[a]=m;break;end;else f=-2;end end end f=f+1 end n=n+1;e=t[n];s=e[d]l[s](l[s+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;n=n+1;e=t[n];for e=e[d],e[c]do l[e]=nil;end;end else if f>=109 then if 110~=f then local z,j,m,k,b,_,j,f,u,h,s,a,o;z=e[d]l[z]=l[z](r(l,z+1,e[c]))n=n+1;e=t[n];f=0;while f>-1 do if 3>=f then if 1<f then if f>2 then b=l;else k=c;end else if f>-1 then repeat if f>0 then m=d;break;end;u=e;until true;else m=d;end end else if 5>=f then if 4<f then o=u[m];else _=b[u[k]];end else if f~=6 then f=-2;else l[o]=_;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if f<=2 then if 0<f then if-3<=f then repeat if f<2 then h=d;break;end;s=c;until true;else h=d;end else u=e;end else if f<5 then if 4~=f then a=u[s];else o=u[h];end else if f~=6 then l(o,a);else f=-2;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if f<3 then if 0<f then if-3<f then for e=35,66 do if 1<f then s=c;break;end;h=d;break;end;else h=d;end else u=e;end else if f<5 then if 1<f then repeat if f~=4 then a=u[s];break;end;o=u[h];until true;else o=u[h];end else if 3<f then for e=44,81 do if f~=5 then f=-2;break;end;l(o,a);break;end;else f=-2;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if 2>=f then if 1>f then u=e;else if f>0 then for e=11,58 do if 1<f then s=c;break;end;h=d;break;end;else h=d;end end else if f>4 then if 3~=f then for e=34,52 do if f<6 then l(o,a);break;end;f=-2;break;end;else l(o,a);end else if f<4 then a=u[s];else o=u[h];end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if 3<=f then if f>4 then if f==5 then l(o,a);else f=-2;end else if f>=-1 then repeat if 3~=f then o=u[h];break;end;a=u[s];until true;else a=u[s];end end else if f>0 then if 1==f then h=d;else s=c;end else u=e;end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if 2>=f then if 0<f then if 2==f then s=c;else h=d;end else u=e;end else if f>=5 then if 5==f then l(o,a);else f=-2;end else if 3==f then a=u[s];else o=u[h];end end end f=f+1 end else local f,o,a,h,m,u;f=e[d];do return l[f](r(l,f+1,e[c]))end;n=n+1;e=t[n];f=e[d];do return r(l,f,s)end;n=n+1;e=t[n];f=e[d];o={};for e=1,#z do a=z[e];for e=0,#a do h=a[e];m=h[1];u=h[2];if m==l and u>=f then o[u]=m[u];h[1]=o;end;end;end;end else local f,u,h;for r=0,2 do if 0>=r then l[e[d]]=#l[e[c]];n=n+1;e=t[n];else if r>-2 then for o=38,83 do if 1~=r then f=e[d];u=l[f]h=l[f+2];if(h>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else f=e[d];u=l[f]h=l[f+2];if(h>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end end end end end end end end else if 149>f then if 138>f then if 132<f then if 134<f then if 136>f then local d=e[d];local f=l[d+2];local t=l[d]+f;l[d]=t;if(f>0)then if(t<=l[d+1])then n=e[c];l[d+3]=t;end elseif(t>=l[d+1])then n=e[c];l[d+3]=t;end else if 136<f then l[e[d]][e[c]]=l[e[h]];else l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;end end else if 134==f then local s,o,a,u,r,f;l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]][l[e[c]]]=l[e[h]];n=n+1;e=t[n];do return l[e[d]]end n=n+1;e=t[n];s=e[d];o={};for e=1,#z do a=z[e];for e=0,#a do u=a[e];r=u[1];f=u[2];if r==l and f>=s then o[f]=r[f];u[1]=o;end;end;end;else local e=e[d]local d,n=m(l[e](l[e+1]))s=n+e-1 local n=0;for e=e,s do n=n+1;l[e]=d[n];end;end end else if f<130 then if 125<=f then repeat if f~=129 then local u;for f=0,6 do if 2<f then if f>=5 then if f~=5 then l[e[d]]=l[e[c]];else u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];end else if-1<=f then for u=12,95 do if 4>f then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end end else if f>0 then if f~=2 then l(e[d],e[c]);n=n+1;e=t[n];else l(e[d],e[c]);n=n+1;e=t[n];end else l(e[d],e[c]);n=n+1;e=t[n];end end end break;end;local o,k,u,s,a,z,m,b,f;o=e[d];k=l[e[c]];l[o+1]=k;l[o]=k[e[h]];n=n+1;e=t[n];f=0;while f>-1 do if f>=4 then if 5<f then if f>2 then repeat if 7>f then l[b]=m;break;end;f=-2;until true;else f=-2;end else if 3<=f then repeat if f>4 then b=u[s];break;end;m=z[u[a]];until true;else b=u[s];end end else if 1<f then if-2~=f then repeat if f>2 then z=l;break;end;a=c;until true;else a=c;end else if f~=1 then u=e;else s=d;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if f<4 then if f>=2 then if f~=3 then a=c;else z=l;end else if f>=-1 then repeat if f<1 then u=e;break;end;s=d;until true;else s=d;end end else if f>=6 then if f<7 then l[b]=m;else f=-2;end else if f>=1 then for e=36,62 do if f~=5 then m=z[u[a]];break;end;b=u[s];break;end;else m=z[u[a]];end end end f=f+1 end n=n+1;e=t[n];o=e[d]l[o]=l[o](r(l,o+1,e[c]))n=n+1;e=t[n];l[e[d]][l[e[c]]]=l[e[h]];n=n+1;e=t[n];o=e[d];k=l[e[c]];l[o+1]=k;l[o]=k[e[h]];n=n+1;e=t[n];f=0;while f>-1 do if 3>=f then if 1<f then if f~=-1 then for e=13,65 do if 3>f then a=c;break;end;z=l;break;end;else z=l;end else if f>-2 then repeat if f~=1 then u=e;break;end;s=d;until true;else s=d;end end else if 6<=f then if 2~=f then for e=21,55 do if f~=7 then l[b]=m;break;end;f=-2;break;end;else f=-2;end else if 1<=f then for e=15,69 do if 5~=f then m=z[u[a]];break;end;b=u[s];break;end;else m=z[u[a]];end end end f=f+1 end until true;else local u;for f=0,6 do if 2<f then if f>=5 then if f~=5 then l[e[d]]=l[e[c]];else u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];end else if-1<=f then for u=12,95 do if 4>f then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end end else if f>0 then if f~=2 then l(e[d],e[c]);n=n+1;e=t[n];else l(e[d],e[c]);n=n+1;e=t[n];end else l(e[d],e[c]);n=n+1;e=t[n];end end end end else if f>=131 then if f>128 then for u=15,61 do if 132~=f then l[e[d]]=l[e[c]]*e[h];break;end;for f=0,1 do if f~=-2 then repeat if f~=0 then if l[e[d]]then n=n+1;else n=e[c];end;break;end;l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];until true;else if l[e[d]]then n=n+1;else n=e[c];end;end end break;end;else l[e[d]]=l[e[c]]*e[h];end else l[e[d]]();end end end else if 142>=f then if 139>=f then if f>=134 then repeat if 138~=f then local e=e[d]l[e](l[e+1])break;end;o[e[c]]=l[e[d]];until true;else local e=e[d]l[e](l[e+1])end else if f>140 then if 142==f then l[e[d]][l[e[c]]]=l[e[h]];else l[e[d]]=l[e[c]]%e[h];end else a[e[c]]=l[e[d]];end end else if f>145 then if 146>=f then local d=e[d];local t=l[d]local f=l[d+2];if(f>0)then if(t>l[d+1])then n=e[c];else l[d+3]=t;end elseif(t<l[d+1])then n=e[c];else l[d+3]=t;end else if 147~=f then local u;for f=0,6 do if f>2 then if f>=5 then if 2<=f then repeat if 6>f then l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];break;end;l[e[d]]=o[e[c]];until true;else l[e[d]]=o[e[c]];end else if 3~=f then l[e[d]]=o[e[c]];n=n+1;e=t[n];else l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];end end else if 1>f then u=e[d]l[u](l[u+1])n=n+1;e=t[n];else if 1==f then l[e[d]]=o[e[c]];n=n+1;e=t[n];else l[e[d]]=o[e[c]];n=n+1;e=t[n];end end end end else l[e[d]]=l[e[c]]+e[h];end end else if 143<f then if 141<f then repeat if f>144 then local n=e[d]l[n](r(l,n+1,e[c]))break;end;local e=e[d]l[e]=l[e]()until true;else local e=e[d]l[e]=l[e]()end else local f;for u=0,1 do if-1~=u then for h=45,65 do if u~=0 then if not l[e[d]]then n=n+1;else n=e[c];end;break;end;f=e[d]l[f]=l[f]()n=n+1;e=t[n];break;end;else f=e[d]l[f]=l[f]()n=n+1;e=t[n];end end end end end end else if f>=160 then if f>=165 then if 168>f then if 166<=f then if 164<=f then for u=12,79 do if f~=167 then local f,u,r;for h=0,2 do if 0>=h then l[e[d]]=#l[e[c]];n=n+1;e=t[n];else if 1==h then l(e[d],e[c]);n=n+1;e=t[n];else f=e[d];u=l[f]r=l[f+2];if(r>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end end end break;end;for e=e[d],e[c]do l[e]=nil;end;break;end;else local f,u,h;for r=0,2 do if 0>=r then l[e[d]]=#l[e[c]];n=n+1;e=t[n];else if 1==r then l(e[d],e[c]);n=n+1;e=t[n];else f=e[d];u=l[f]h=l[f+2];if(h>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end end end end else local e=e[d]l[e]=l[e](l[e+1])end else if f<169 then if not l[e[d]]then n=n+1;else n=e[c];end;else if 166~=f then for u=43,90 do if f<170 then l[e[d]]=l[e[c]]-e[h];break;end;l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;break;end;else l[e[d]]=l[e[c]]-e[h];end end end else if 162>f then if 161==f then if(e[d]<l[e[h]])then n=e[c];else n=n+1;end;else l[e[d]][e[c]]=l[e[h]];end else if 163>f then local k,b,u,m,o,s,r,z,f;l[e[d]]=#l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]]%l[e[h]];n=n+1;e=t[n];l[e[d]]=l[e[c]]+e[h];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];k=e[d];b=l[e[c]];l[k+1]=b;l[k]=b[e[h]];n=n+1;e=t[n];f=0;while f>-1 do if f<4 then if f>=2 then if 0<f then repeat if f~=2 then s=l;break;end;o=c;until true;else o=c;end else if f~=-4 then for n=16,81 do if 0~=f then m=d;break;end;u=e;break;end;else u=e;end end else if f<6 then if 1<f then for e=27,55 do if f>4 then z=u[m];break;end;r=s[u[o]];break;end;else r=s[u[o]];end else if f>5 then repeat if 6~=f then f=-2;break;end;l[z]=r;until true;else l[z]=r;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if 3<f then if 5>=f then if 5~=f then r=s[u[o]];else z=u[m];end else if f~=2 then repeat if f<7 then l[z]=r;break;end;f=-2;until true;else f=-2;end end else if 1<f then if 2<f then s=l;else o=c;end else if 0<f then m=d;else u=e;end end end f=f+1 end else if f>159 then for u=35,98 do if 163~=f then for f=0,1 do if 0==f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else if(l[e[d]]==l[e[h]])then n=n+1;else n=e[c];end;end end break;end;for f=0,1 do if f==1 then l[e[d]]=o[e[c]];else l(e[d],e[c]);n=n+1;e=t[n];end end break;end;else for f=0,1 do if f==1 then l[e[d]]=o[e[c]];else l(e[d],e[c]);n=n+1;e=t[n];end end end end end end else if f>=154 then if f>156 then if 158>f then local f;for u=0,5 do if u>=3 then if 4>u then l[e[d]][l[e[c]]]=l[e[h]];n=n+1;e=t[n];else if 0<u then repeat if 4~=u then l[e[d]][l[e[c]]]=l[e[h]];break;end;l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];until true;else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end end else if u<=0 then l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];else if-3<=u then for h=16,62 do if 2>u then l[e[d]]=l[e[c]];n=n+1;e=t[n];break;end;f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];break;end;else f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];end end end end else if f>=157 then repeat if 159>f then local a,f,s,r,o,u,b,m,z;local t=0;while t>-1 do if 3<=t then if 4<t then if t>=1 then repeat if 5<t then t=-2;break;end;n=z;until true;else t=-2;end else if t~=3 then z=b==m and f[u]or 1+s;else b=a[r];m=a[o];end end else if t<=0 then a=l;else if t>-1 then repeat if t>1 then r=f[d];o=f[h];u=c;break;end;f=e;s=n;until true;else r=f[d];o=f[h];u=c;end end end t=t+1 end break;end;for f=0,1 do if-4~=f then repeat if 1>f then l[e[d]]=o[e[c]];n=n+1;e=t[n];break;end;if l[e[d]]then n=n+1;else n=e[c];end;until true;else l[e[d]]=o[e[c]];n=n+1;e=t[n];end end until true;else local r,f,m,u,o,a,s,z,b;local t=0;while t>-1 do if 3<=t then if 4<t then if t>=1 then repeat if 5<t then t=-2;break;end;n=b;until true;else t=-2;end else if t~=3 then b=s==z and f[a]or 1+m;else s=r[u];z=r[o];end end else if t<=0 then r=l;else if t>-1 then repeat if t>1 then u=f[d];o=f[h];a=c;break;end;f=e;m=n;until true;else u=f[d];o=f[h];a=c;end end end t=t+1 end end end else if 154<f then if 155~=f then local e=e[d];s=e+j-1;for n=e,s do local e=b[n-e];l[n]=e;end;else local f,u,z,s,o,m,r,a,b;local t=0;while t>-1 do if t<3 then if t<=0 then f=l;else if t>=-1 then repeat if t~=2 then u=e;z=n;break;end;s=u[d];o=u[h];m=c;until true;else u=e;z=n;end end else if t>=5 then if 6==t then t=-2;else n=b;end else if 0~=t then for e=46,68 do if t<4 then r=f[s];a=f[o];break;end;b=r==a and u[m]or 1+z;break;end;else r=f[s];a=f[o];end end end t=t+1 end end else local f;a[e[c]]=l[e[d]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];f=e[d]l[f](l[f+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;end end else if f>=151 then if f<152 then if(l[e[d]]~=e[h])then n=n+1;else n=e[c];end;else if f>=148 then repeat if f~=152 then local s=_[e[c]];local r;local f={};r=u.hLUrpjKT({},{__index=function(n,e)local e=f[e];return e[1][e[2]];end,__newindex=function(l,e,n)local e=f[e]e[1][e[2]]=n;end;});for d=1,e[h]do n=n+1;local e=t[n];if e[y]==68 then f[d-1]={l,e[c]};else f[d-1]={a,e[c]};end;z[#z+1]=f;end;l[e[d]]=k(s,r,o);break;end;if(l[e[d]]~=e[h])then n=n+1;else n=e[c];end;until true;else if(l[e[d]]~=e[h])then n=n+1;else n=e[c];end;end end else if 149<f then local n=e[d];local d=l[n];for e=n+1,e[c]do u.xVXXKBCG(d,l[e])end;else l[e[d]]();end end end end end end else if f<=41 then if 20>=f then if f>9 then if 14>=f then if 11>=f then if f>=6 then repeat if 11>f then local d=e[d];local t=l[d]local f=l[d+2];if(f>0)then if(t>l[d+1])then n=e[c];else l[d+3]=t;end elseif(t<l[d+1])then n=e[c];else l[d+3]=t;end break;end;local f,u,r;for h=0,2 do if 1>h then l[e[d]]=#l[e[c]];n=n+1;e=t[n];else if 2==h then f=e[d];u=l[f]r=l[f+2];if(r>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end else l(e[d],e[c]);n=n+1;e=t[n];end end end until true;else local d=e[d];local t=l[d]local f=l[d+2];if(f>0)then if(t>l[d+1])then n=e[c];else l[d+3]=t;end elseif(t<l[d+1])then n=e[c];else l[d+3]=t;end end else if f<13 then local s=_[e[c]];local r;local f={};r=u.hLUrpjKT({},{__index=function(n,e)local e=f[e];return e[1][e[2]];end,__newindex=function(l,e,n)local e=f[e]e[1][e[2]]=n;end;});for d=1,e[h]do n=n+1;local e=t[n];if e[y]==68 then f[d-1]={l,e[c]};else f[d-1]={a,e[c]};end;z[#z+1]=f;end;l[e[d]]=k(s,r,o);else if 10~=f then for u=43,70 do if f>13 then l[e[d]]=o[e[c]];break;end;local u;for f=0,4 do if f>1 then if f<3 then l(e[d],e[c]);n=n+1;e=t[n];else if f==4 then if(l[e[d]]==e[h])then n=n+1;else n=e[c];end;else u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];end end else if f>=-2 then for u=46,87 do if 1~=f then l[e[d]]=l[e[c]];n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l[e[d]]=l[e[c]];n=n+1;e=t[n];end end end break;end;else l[e[d]]=o[e[c]];end end end else if f>17 then if f<19 then l[e[d]]=(e[c]~=0);else if f>17 then repeat if 20>f then local f,u;f=e[d];u=l[e[c]];l[f+1]=u;l[f]=u[e[h]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=l[e[c]]*e[h];break;end;local t=l[e[h]];if not t then n=n+1;else l[e[d]]=t;n=e[c];end;until true;else local f,u;f=e[d];u=l[e[c]];l[f+1]=u;l[f]=u[e[h]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=l[e[c]]*e[h];end end else if 15>=f then n=e[c];else if f>=12 then repeat if 17~=f then for f=0,6 do if 2<f then if f<5 then if 2<f then for u=15,86 do if 3~=f then o[e[c]]=l[e[d]];n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];break;end;else o[e[c]]=l[e[d]];n=n+1;e=t[n];end else if 1~=f then for u=38,79 do if 5<f then o[e[c]]=l[e[d]];break;end;l[e[d]]=(e[c]~=0);n=n+1;e=t[n];break;end;else l[e[d]]=(e[c]~=0);n=n+1;e=t[n];end end else if f<1 then l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];else if-2~=f then repeat if 1<f then l[e[d]]=o[e[c]];n=n+1;e=t[n];break;end;o[e[c]]=l[e[d]];n=n+1;e=t[n];until true;else o[e[c]]=l[e[d]];n=n+1;e=t[n];end end end end break;end;l[e[d]]=l[e[c]]+l[e[h]];until true;else for f=0,6 do if 2<f then if f<5 then if 2<f then for u=15,86 do if 3~=f then o[e[c]]=l[e[d]];n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];break;end;else o[e[c]]=l[e[d]];n=n+1;e=t[n];end else if 1~=f then for u=38,79 do if 5<f then o[e[c]]=l[e[d]];break;end;l[e[d]]=(e[c]~=0);n=n+1;e=t[n];break;end;else l[e[d]]=(e[c]~=0);n=n+1;e=t[n];end end else if f<1 then l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];else if-2~=f then repeat if 1<f then l[e[d]]=o[e[c]];n=n+1;e=t[n];break;end;o[e[c]]=l[e[d]];n=n+1;e=t[n];until true;else o[e[c]]=l[e[d]];n=n+1;e=t[n];end end end end end end end end else if f>4 then if f>6 then if f>7 then if 7<f then for u=19,79 do if f~=8 then local f;l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];l[e[d]]={};n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);break;end;local f,o;for u=0,5 do if u>2 then if 3<u then if u>3 then repeat if 5>u then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]]+l[e[h]];until true;else l[e[d]]=l[e[c]]+l[e[h]];end else f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];end else if u<1 then f=e[d];o=l[e[c]];l[f+1]=o;l[f]=o[e[h]];n=n+1;e=t[n];else if u==1 then l[e[d]]=l[e[c]];n=n+1;e=t[n];else l[e[d]]=l[e[c]];n=n+1;e=t[n];end end end end break;end;else local f,o;for u=0,5 do if u>2 then if 3<u then if u>3 then repeat if 5>u then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]]+l[e[h]];until true;else l[e[d]]=l[e[c]]+l[e[h]];end else f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];end else if u<1 then f=e[d];o=l[e[c]];l[f+1]=o;l[f]=o[e[h]];n=n+1;e=t[n];else if u==1 then l[e[d]]=l[e[c]];n=n+1;e=t[n];else l[e[d]]=l[e[c]];n=n+1;e=t[n];end end end end end else local f;l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);end else if 6>f then local u,z,m,s,b,_,k,f;l[e[d]][e[c]]=l[e[h]];n=n+1;e=t[n];u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];f=0;while f>-1 do if 3>=f then if f<2 then if 0==f then z=e;else m=d;end else if f>=-1 then for e=32,91 do if f~=2 then b=l;break;end;s=c;break;end;else s=c;end end else if f>=6 then if 2~=f then for e=41,67 do if f~=7 then l[k]=_;break;end;f=-2;break;end;else f=-2;end else if f==4 then _=b[z[s]];else k=z[m];end end end f=f+1 end n=n+1;e=t[n];u=e[d]l[u](r(l,u+1,e[c]))else local f;l[e[d]][e[c]]=l[e[h]];n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f](r(l,f+1,e[c]))end end else if f<=1 then if 0==f then do return l[e[d]]end else local e=e[d];do return r(l,e,s)end;end else if f<3 then local u,a,r,h,o,f;l[e[d]]={};n=n+1;e=t[n];l[e[d]]={};n=n+1;e=t[n];l[e[d]]={};n=n+1;e=t[n];f=0;while f>-1 do if 2>=f then if 0>=f then u=e;else if f~=2 then a=d;else r=c;end end else if 4>=f then if f~=0 then repeat if f~=4 then h=u[r];break;end;o=u[a];until true;else h=u[r];end else if f>=3 then repeat if 6>f then l(o,h);break;end;f=-2;until true;else f=-2;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if 2<f then if f>4 then if 4~=f then for e=38,95 do if 6>f then l(o,h);break;end;f=-2;break;end;else l(o,h);end else if 3<f then o=u[a];else h=u[r];end end else if f<=0 then u=e;else if 2==f then r=c;else a=d;end end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if f>2 then if f>4 then if f>=3 then repeat if 5<f then f=-2;break;end;l(o,h);until true;else l(o,h);end else if-1~=f then repeat if 3<f then o=u[a];break;end;h=u[r];until true;else h=u[r];end end else if 0<f then if f~=-2 then repeat if 1<f then r=c;break;end;a=d;until true;else r=c;end else u=e;end end f=f+1 end n=n+1;e=t[n];f=0;while f>-1 do if f<=2 then if f>=1 then if-3<f then repeat if 2>f then a=d;break;end;r=c;until true;else a=d;end else u=e;end else if f<=4 then if 0<f then repeat if 4>f then h=u[r];break;end;o=u[a];until true;else h=u[r];end else if 4~=f then for e=28,91 do if f<6 then l(o,h);break;end;f=-2;break;end;else f=-2;end end end f=f+1 end else if f>3 then l[e[d]]=l[e[c]]*e[h];else local n=e[d]local d,e=m(l[n](r(l,n+1,e[c])))s=e+n-1 local e=0;for n=n,s do e=e+1;l[n]=d[e];end;end end end end end else if 30>=f then if 25<f then if f>=28 then if f>28 then if f~=25 then for u=49,98 do if 29<f then l[e[d]]=l[e[c]][l[e[h]]];break;end;local f,o,a,h,r,u;l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];do return l[e[d]]end n=n+1;e=t[n];f=e[d];o={};for e=1,#z do a=z[e];for e=0,#a do h=a[e];r=h[1];u=h[2];if r==l and u>=f then o[u]=r[u];h[1]=o;end;end;end;n=n+1;e=t[n];n=e[c];break;end;else l[e[d]]=l[e[c]][l[e[h]]];end else local f,t,r,u,o,h;local n=0;while n>-1 do if 4<=n then if n>=6 then if n>=5 then for e=19,95 do if n>6 then n=-2;break;end;l[h]=o;break;end;else n=-2;end else if n==5 then h=f[t];else o=u[f[r]];end end else if 1>=n then if n>-1 then repeat if n~=1 then f=e;break;end;t=d;until true;else t=d;end else if n==2 then r=c;else u=l;end end end n=n+1 end end else if 26~=f then local u,s,a,o,z,f,m;for f=0,6 do if 2<f then if f<=4 then if f~=2 then repeat if f~=3 then f=0;while f>-1 do if f<3 then if f>=1 then if f~=0 then for e=42,85 do if 2>f then s=d;break;end;a=c;break;end;else s=d;end else u=e;end else if 4<f then if 4~=f then for e=24,52 do if f~=6 then l(z,o);break;end;f=-2;break;end;else f=-2;end else if f>=-1 then repeat if f~=4 then o=u[a];break;end;z=u[s];until true;else o=u[a];end end end f=f+1 end n=n+1;e=t[n];break;end;f=0;while f>-1 do if 2>=f then if 0<f then if-2<f then repeat if 1~=f then a=c;break;end;s=d;until true;else s=d;end else u=e;end else if f<5 then if f>-1 then for e=26,75 do if f~=3 then z=u[s];break;end;o=u[a];break;end;else o=u[a];end else if 6==f then f=-2;else l(z,o);end end end f=f+1 end n=n+1;e=t[n];until true;else f=0;while f>-1 do if f<3 then if f>=1 then if f~=0 then for e=42,85 do if 2>f then s=d;break;end;a=c;break;end;else s=d;end else u=e;end else if 4<f then if 4~=f then for e=24,52 do if f~=6 then l(z,o);break;end;f=-2;break;end;else f=-2;end else if f>=-1 then repeat if f~=4 then o=u[a];break;end;z=u[s];until true;else o=u[a];end end end f=f+1 end n=n+1;e=t[n];end else if 2~=f then for u=45,58 do if f<6 then m=e[d]l[m]=l[m](r(l,m+1,e[c]))n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]][l[e[h]]];break;end;else l[e[d]]=l[e[c]][l[e[h]]];end end else if f<1 then f=0;while f>-1 do if 3<=f then if f>4 then if f>5 then f=-2;else l(z,o);end else if f==4 then z=u[s];else o=u[a];end end else if 1>f then u=e;else if f~=1 then a=c;else s=d;end end end f=f+1 end n=n+1;e=t[n];else if-3~=f then repeat if f~=1 then f=0;while f>-1 do if f<=2 then if 0>=f then u=e;else if f==1 then s=d;else a=c;end end else if 5<=f then if 4~=f then repeat if f<6 then l(z,o);break;end;f=-2;until true;else f=-2;end else if f~=2 then repeat if f~=3 then z=u[s];break;end;o=u[a];until true;else o=u[a];end end end f=f+1 end n=n+1;e=t[n];break;end;f=0;while f>-1 do if f<3 then if f<=0 then u=e;else if 1~=f then a=c;else s=d;end end else if f<=4 then if-1<=f then repeat if f>3 then z=u[s];break;end;o=u[a];until true;else o=u[a];end else if f>3 then for e=16,80 do if f~=6 then l(z,o);break;end;f=-2;break;end;else f=-2;end end end f=f+1 end n=n+1;e=t[n];until true;else f=0;while f>-1 do if f<=2 then if 0>=f then u=e;else if f==1 then s=d;else a=c;end end else if 5<=f then if 4~=f then repeat if f<6 then l(z,o);break;end;f=-2;until true;else f=-2;end else if f~=2 then repeat if f~=3 then z=u[s];break;end;o=u[a];until true;else o=u[a];end end end f=f+1 end n=n+1;e=t[n];end end end end else if not l[e[d]]then n=n+1;else n=e[c];end;end end else if 23>f then if f>19 then repeat if f~=22 then local n=e[d]local d,e=m(l[n](r(l,n+1,e[c])))s=e+n-1 local e=0;for n=n,s do e=e+1;l[n]=d[e];end;break;end;local e=e[d]l[e](l[e+1])until true;else local n=e[d]local d,e=m(l[n](r(l,n+1,e[c])))s=e+n-1 local e=0;for n=n,s do e=e+1;l[n]=d[e];end;end else if f<24 then local n=e[d]l[n]=l[n](r(l,n+1,e[c]))else if f>24 then l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];l[e[d]]={};else local u;for f=0,6 do if f<3 then if f<1 then l(e[d],e[c]);n=n+1;e=t[n];else if 0~=f then for h=48,67 do if 2>f then l(e[d],e[c]);n=n+1;e=t[n];break;end;u=e[d]l[u]=l[u](r(l,u+1,e[c]))n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end end else if 5>f then if 1<=f then repeat if 3<f then l(e[d],e[c]);n=n+1;e=t[n];break;end;l[e[d]]=l[e[c]];n=n+1;e=t[n];until true;else l(e[d],e[c]);n=n+1;e=t[n];end else if 6==f then l(e[d],e[c]);else l(e[d],e[c]);n=n+1;e=t[n];end end end end end end end end else if 35<f then if 39>f then if f>36 then if 36<=f then for t=22,76 do if 38~=f then local t=e[d];local c={};for e=1,#z do local e=z[e];for n=0,#e do local n=e[n];local d=n[1];local e=n[2];if d==l and e>=t then c[e]=d[e];n[1]=c;end;end;end;break;end;if(l[e[d]]==l[e[h]])then n=n+1;else n=e[c];end;break;end;else if(l[e[d]]==l[e[h]])then n=n+1;else n=e[c];end;end else local f,u,r,t,h;local n=0;while n>-1 do if n<=2 then if n>0 then if n>-3 then repeat if n>1 then r=c;break;end;u=d;until true;else u=d;end else f=e;end else if n<5 then if n>=0 then repeat if n>3 then h=f[u];break;end;t=f[r];until true;else t=f[r];end else if n>=3 then for e=46,68 do if n>5 then n=-2;break;end;l(h,t);break;end;else l(h,t);end end end n=n+1 end end else if 39<f then if 38~=f then repeat if f<41 then local f;l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))break;end;l[e[d]]={};until true;else local f;l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))end else do return end;end end else if 32<f then if 33<f then if 32<=f then repeat if f~=35 then local f,u,h;for r=0,2 do if r>0 then if-1~=r then repeat if r>1 then f=e[d];u=l[f]h=l[f+2];if(h>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end break;end;l(e[d],e[c]);n=n+1;e=t[n];until true;else f=e[d];u=l[f]h=l[f+2];if(h>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end else l[e[d]]=#l[e[c]];n=n+1;e=t[n];end end break;end;n=e[c];until true;else n=e[c];end else local f;l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];l[e[d]][l[e[c]]]=l[e[h]];n=n+1;e=t[n];do return end;end else if f==32 then local f;for u=0,3 do if u<=1 then if-1<=u then repeat if u~=1 then l[e[d]]=l[e[c]];n=n+1;e=t[n];break;end;f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];until true;else f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];end else if u>=0 then for f=38,69 do if 3>u then l[e[d]][l[e[c]]]=l[e[h]];n=n+1;e=t[n];break;end;l[e[d]][l[e[c]]]=l[e[h]];break;end;else l[e[d]][l[e[c]]]=l[e[h]];end end end else local e=e[d]local d,n=m(l[e](l[e+1]))s=n+e-1 local n=0;for e=e,s do n=n+1;l[e]=d[n];end;end end end end end else if 63>f then if f<=51 then if f>46 then if 49>f then if f~=45 then repeat if f<48 then l[e[d]]=l[e[c]]+e[h];break;end;local s,o,r,f,u,a,t;local n=0;while n>-1 do if n<3 then if n<=0 then s=d;o=c;r=h;else if-3~=n then repeat if n<2 then f=e;break;end;u=f[o];until true;else f=e;end end else if 5>n then if 2<=n then for e=16,52 do if n>3 then t=l[u];for e=1+u,f[r]do t=t..l[e];end;break;end;a=f[s];break;end;else t=l[u];for e=1+u,f[r]do t=t..l[e];end;end else if n~=5 then n=-2;else l[a]=t;end end end n=n+1 end until true;else local o,a,r,f,u,s,t;local n=0;while n>-1 do if n<3 then if n<=0 then o=d;a=c;r=h;else if-3~=n then repeat if n<2 then f=e;break;end;u=f[a];until true;else f=e;end end else if 5>n then if 2<=n then for e=16,52 do if n>3 then t=l[u];for e=1+u,f[r]do t=t..l[e];end;break;end;s=f[o];break;end;else t=l[u];for e=1+u,f[r]do t=t..l[e];end;end else if n~=5 then n=-2;else l[s]=t;end end end n=n+1 end end else if f>=50 then if f==51 then local n=e[d];do return l[n](r(l,n+1,e[c]))end;else l[e[d]]=a[e[c]];end else local d=e[d];local n=l[e[c]];l[d+1]=n;l[d]=n[e[h]];end end else if 44<=f then if 45>f then for f=0,6 do if f<3 then if 0<f then if f>0 then repeat if f>1 then l[e[d]]=l[e[c]];n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];until true;else l(e[d],e[c]);n=n+1;e=t[n];end else l[e[d]]={};n=n+1;e=t[n];end else if 4>=f then if 2<=f then for u=46,57 do if f~=4 then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end else if 2~=f then for u=18,52 do if f~=5 then l(e[d],e[c]);break;end;l(e[d],e[c]);n=n+1;e=t[n];break;end;else l(e[d],e[c]);n=n+1;e=t[n];end end end end else if 43<f then repeat if f>45 then local e=e[d];s=e+j-1;for n=e,s do local e=b[n-e];l[n]=e;end;break;end;local f,u,r;l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]={};n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];f=e[d];u=l[f]r=l[f+2];if(r>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end until true;else local f,u,r;l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]={};n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];f=e[d];u=l[f]r=l[f+2];if(r>0)then if(u>l[f+1])then n=e[c];else l[f+3]=u;end elseif(u<l[f+1])then n=e[c];else l[f+3]=u;end end end else if f>=39 then repeat if 42~=f then if(e[d]<l[e[h]])then n=e[c];else n=n+1;end;break;end;local f,o;for h=0,2 do if h>0 then if-2~=h then for a=39,91 do if 2~=h then f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];break;end;f=e[d];o=l[f];for e=f+1,e[c]do u.xVXXKBCG(o,l[e])end;break;end;else f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];end else l(e[d],e[c]);n=n+1;e=t[n];end end until true;else local f,o;for h=0,2 do if h>0 then if-2~=h then for a=39,91 do if 2~=h then f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];break;end;f=e[d];o=l[f];for e=f+1,e[c]do u.xVXXKBCG(o,l[e])end;break;end;else f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];end else l(e[d],e[c]);n=n+1;e=t[n];end end end end end else if 56<f then if f<60 then if 58>f then local e=e[d]l[e]=l[e](r(l,e+1,s))else if f>=54 then repeat if f~=59 then local u;for f=0,5 do if f<3 then if f>=1 then if f>1 then l[e[d]]=a[e[c]];n=n+1;e=t[n];else l[e[d]]=a[e[c]];n=n+1;e=t[n];end else l[e[d]]=a[e[c]];n=n+1;e=t[n];end else if f<4 then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else if f~=5 then u=e[d]l[u]=l[u](l[u+1])n=n+1;e=t[n];else if l[e[d]]then n=n+1;else n=e[c];end;end end end end break;end;local f;for u=0,3 do if u<2 then if u~=1 then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];end else if u==3 then if l[e[d]]then n=n+1;else n=e[c];end;else f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];end end end until true;else local u;for f=0,5 do if f<3 then if f>=1 then if f>1 then l[e[d]]=a[e[c]];n=n+1;e=t[n];else l[e[d]]=a[e[c]];n=n+1;e=t[n];end else l[e[d]]=a[e[c]];n=n+1;e=t[n];end else if f<4 then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];else if f~=5 then u=e[d]l[u]=l[u](l[u+1])n=n+1;e=t[n];else if l[e[d]]then n=n+1;else n=e[c];end;end end end end end end else if 61<=f then if f~=60 then repeat if f>61 then local e=e[d]l[e]=l[e](l[e+1])break;end;for e=e[d],e[c]do l[e]=nil;end;until true;else local e=e[d]l[e]=l[e](l[e+1])end else local e=e[d]l[e]=l[e](r(l,e+1,s))end end else if 54<=f then if 55<=f then if 54<f then repeat if 55<f then local d=e[d];local n=l[e[c]];l[d+1]=n;l[d]=n[e[h]];break;end;for f=0,3 do if 1>=f then if 0<f then l(e[d],e[c]);n=n+1;e=t[n];else l(e[d],e[c]);n=n+1;e=t[n];end else if f>-1 then repeat if 3~=f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;if not l[e[d]]then n=n+1;else n=e[c];end;until true;else if not l[e[d]]then n=n+1;else n=e[c];end;end end end until true;else for f=0,3 do if 1>=f then if 0<f then l(e[d],e[c]);n=n+1;e=t[n];else l(e[d],e[c]);n=n+1;e=t[n];end else if f>-1 then repeat if 3~=f then l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];break;end;if not l[e[d]]then n=n+1;else n=e[c];end;until true;else if not l[e[d]]then n=n+1;else n=e[c];end;end end end end else local e=e[d]l[e]=l[e]()end else if f>=50 then repeat if f~=52 then l[e[d]]=o[e[c]];break;end;local f;l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f](l[f+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;until true;else local f;l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f](l[f+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;end end end end else if f>73 then if f>78 then if 82>f then if f<80 then local c,f,r;for h=0,1 do if h>-3 then repeat if 1~=h then c=e[d];s=c+j-1;for e=c,s do f=b[e-c];l[e]=f;end;n=n+1;e=t[n];break;end;c=e[d];r=l[c];for e=c+1,s do u.xVXXKBCG(r,l[e])end;until true;else c=e[d];s=c+j-1;for e=c,s do f=b[e-c];l[e]=f;end;n=n+1;e=t[n];end end else if f~=80 then o[e[c]]=l[e[d]];else local f;l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=a[e[c]];n=n+1;e=t[n];l[e[d]]=l[e[c]][l[e[h]]];n=n+1;e=t[n];f=e[d];do return l[f](r(l,f+1,e[c]))end;n=n+1;e=t[n];f=e[d];do return r(l,f,s)end;n=n+1;e=t[n];do return end;end end else if 83>f then local f;l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,e[c]))n=n+1;e=t[n];l[e[d]]=l[e[c]];n=n+1;e=t[n];l(e[d],e[c]);else if f>82 then repeat if f<84 then do return end;break;end;l[e[d]]=k(_[e[c]],nil,o);until true;else l[e[d]]=k(_[e[c]],nil,o);end end end else if f<76 then if 72~=f then repeat if f~=75 then l[e[d]]=#l[e[c]];break;end;l[e[d]]=#l[e[c]];until true;else l[e[d]]=#l[e[c]];end else if 77<=f then if 78~=f then if l[e[d]]then n=n+1;else n=e[c];end;else local f;l[e[d]]=l[e[c]];n=n+1;e=t[n];f=e[d]l[f](l[f+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;n=n+1;e=t[n];for e=e[d],e[c]do l[e]=nil;end;end else local u,z,s,r,o,a,f;l[e[d]]=l[e[c]][e[h]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];f=0;while f>-1 do if 3<f then if f<=5 then if f>=1 then for e=22,86 do if f~=5 then o=r[u[s]];break;end;a=u[z];break;end;else o=r[u[s]];end else if 5<f then repeat if 7~=f then l[a]=o;break;end;f=-2;until true;else l[a]=o;end end else if 1<f then if 0<=f then repeat if f~=3 then s=c;break;end;r=l;until true;else r=l;end else if f~=-2 then repeat if 1>f then u=e;break;end;z=d;until true;else u=e;end end end f=f+1 end n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;end end end else if f<=67 then if 65<=f then if f>=66 then if f~=64 then for u=47,58 do if 67>f then l[e[d]][l[e[c]]]=l[e[h]];break;end;local f;l(e[d],e[c]);n=n+1;e=t[n];f=e[d]l[f](l[f+1])n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];l[e[d]]();n=n+1;e=t[n];do return end;n=n+1;e=t[n];for e=e[d],e[c]do l[e]=nil;end;break;end;else l[e[d]][l[e[c]]]=l[e[h]];end else local f,a,h,u;f=e[d]l[f]=l[f](l[f+1])n=n+1;e=t[n];f=e[d]l[f]=l[f]()n=n+1;e=t[n];l(e[d],e[c]);n=n+1;e=t[n];l[e[d]]=o[e[c]];n=n+1;e=t[n];f=e[d]a,h=m(l[f](r(l,f+1,e[c])))s=h+f-1 u=0;for e=f,s do u=u+1;l[e]=a[u];end;n=n+1;e=t[n];f=e[d]l[f]=l[f](r(l,f+1,s))end else if f>59 then for u=15,56 do if f>63 then for f=0,6 do if f<=2 then if 1<=f then if f==1 then l[e[d]]=l[e[c]];n=n+1;e=t[n];else l(e[d],e[c]);n=n+1;e=t[n];end else l[e[d]]=l[e[c]];n=n+1;e=t[n];end else if f<5 then if-1<f then repeat if f~=3 then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];until true;else l(e[d],e[c]);n=n+1;e=t[n];end else if 4<=f then repeat if f>5 then l(e[d],e[c]);break;end;l(e[d],e[c]);n=n+1;e=t[n];until true;else l(e[d],e[c]);n=n+1;e=t[n];end end end end break;end;l[e[d]]=l[e[c]]%l[e[h]];break;end;else for f=0,6 do if f<=2 then if 1<=f then if f==1 then l[e[d]]=l[e[c]];n=n+1;e=t[n];else l(e[d],e[c]);n=n+1;e=t[n];end else l[e[d]]=l[e[c]];n=n+1;e=t[n];end else if f<5 then if-1<f then repeat if f~=3 then l(e[d],e[c]);n=n+1;e=t[n];break;end;l(e[d],e[c]);n=n+1;e=t[n];until true;else l(e[d],e[c]);n=n+1;e=t[n];end else if 4<=f then repeat if f>5 then l(e[d],e[c]);break;end;l(e[d],e[c]);n=n+1;e=t[n];until true;else l(e[d],e[c]);n=n+1;e=t[n];end end end end end end else if 71>f then if 68<f then if 66<f then for u=26,64 do if f~=70 then local c,o,h,f,r,u;for a=0,1 do if 1>a then c=e[d]l[c](l[c+1])n=n+1;e=t[n];else c=e[d];o={};for e=1,#z do h=z[e];for e=0,#h do f=h[e];r=f[1];u=f[2];if r==l and u>=c then o[u]=r[u];f[1]=o;end;end;end;end end break;end;l[e[d]]=l[e[c]]%l[e[h]];break;end;else l[e[d]]=l[e[c]]%l[e[h]];end else local t,u,h,o,r,f;local n=0;while n>-1 do if n<=3 then if 1>=n then if n>=-2 then for l=35,85 do if 1~=n then t=e;break;end;u=d;break;end;else t=e;end else if 2~=n then o=l;else h=c;end end else if n>=6 then if 4~=n then repeat if n<7 then l[f]=r;break;end;n=-2;until true;else n=-2;end else if n>3 then repeat if 4<n then f=t[u];break;end;r=o[t[h]];until true;else f=t[u];end end end n=n+1 end end else if 71>=f then local e=e[d];local n=l[e];for e=e+1,s do u.xVXXKBCG(n,l[e])end;else if f>=70 then for t=31,60 do if f>72 then if l[e[d]]then n=n+1;else n=e[c];end;break;end;do return l[e[d]]end break;end;else if l[e[d]]then n=n+1;else n=e[c];end;end end end end end end end end n=1+n;end;end;return ce end;local d=0xff;local h={};local t=(1);local c='';(function(n)local l=n local f=0x00 local e=0x00 l={(function(r)if f>0x1f then return r end f=f+1 e=(e+0xcc2-r)%0x45 return(e%0x03==0x1 and(function(l)if not n[l]then e=e+0x01 n[l]=(0x96);c='\37';d={function()d()end};c=c..'\100\43';end return true end)'J_KJF'and l[0x1](0x3a2+r))or(e%0x03==0x0 and(function(l)if not n[l]then e=e+0x01 n[l]=(0x7c);c={c..'\58 a',c};h[t]=ce();t=t+((not u.yrGhSJKL)and 1 or 0);c[1]='\58'..c[1];d[2]=0xff;end return true end)'s_rTz'and l[0x2](r+0x249))or(e%0x03==0x2 and(function(l)if not n[l]then e=e+0x01 n[l]=(0xf6);end return true end)'eupJr'and l[0x3](r+0x2cc))or r end),(function(u)if f>0x1f then return u end f=f+1 e=(e+0xd67-u)%0x3c return(e%0x03==0x0 and(function(l)if not n[l]then e=e+0x01 n[l]=(0x10);h[t]=te();t=t+d;end return true end)'uqFmU'and l[0x3](0x2b3+u))or(e%0x03==0x2 and(function(l)if not n[l]then e=e+0x01 n[l]=(0xd);d[2]=(d[2]*(le(function()h()end,r(c))-le(d[1],r(c))))+1;h[t]={};d=d[2];t=t+d;end return true end)'kmitr'and l[0x2](u+0x19f))or(e%0x03==0x1 and(function(l)if not n[l]then e=e+0x01 n[l]=(0x88);end return true end)'fOdUW'and l[0x1](u+0x150))or u end),(function(d)if f>0x28 then return d end f=f+1 e=(e+0xaa8-d)%0x1a return(e%0x03==0x1 and(function(l)if not n[l]then e=e+0x01 n[l]=(0xd);end return true end)'_htcw'and l[0x1](0x27c+d))or(e%0x03==0x2 and(function(l)if not n[l]then e=e+0x01 n[l]=(0x4a);end return true end)'bBhgA'and l[0x3](d+0x69))or(e%0x03==0x0 and(function(l)if not n[l]then e=e+0x01 n[l]=(0x7d);end return true end)'EMjXY'and l[0x2](d+0x28c))or d end)}l[0x1](0x23ad)end){};local e=k(r(h));h[2]={};h[1]=e(h[1])qEwqBIbpZLFe_yG=nil;e=k(r(h))return e(...);end return le((function()local n={}local e=0x01;local l;if u.yrGhSJKL then l=u.yrGhSJKL(le)else l=''end if u.JSnUvTiF(l,u.gaamWDQm)then e=e+0;else e=e+1;end n[e]=0x02;n[n[e]+0x01]=0x03;return n;end)(),...)end)((function(e,n,l,d,c,t)local t;if 3>=e then if 1>=e then if-2<=e then repeat if e<1 then do return n(1),n(4,c,d,l,n),n(5,c,d,l)end;break;end;do return function(n,e,l)if l then local e=(n/2^(e-1))%2^((l-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(n%(e+e)>=e)and 1 or 0;end;end;end;until true;else do return function(n,e,l)if l then local e=(n/2^(e-1))%2^((l-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(n%(e+e)>=e)and 1 or 0;end;end;end;end else if 3==e then do return n(1),n(4,c,d,l,n),n(5,c,d,l)end;else do return 16777216,65536,256 end;end end else if 5<e then if e>6 then if 6<=e then for n=32,95 do if 8>e then do return setmetatable({},{['__\99\97\108\108']=function(e,l,d,c,n)if n then return e[n]elseif c then return e else e[l]=d end end})end break;end;do return l(e,nil,l);end break;end;else do return setmetatable({},{['__\99\97\108\108']=function(e,c,l,d,n)if n then return e[n]elseif d then return e else e[c]=l end end})end end else do return c[l]end;end else if 2<e then repeat if 5>e then local e=d;local f,u,c=c(2);do return function()local d,l,t,n=n(l,e(e,e),e(e,e)+3);e(4);return(n*f)+(t*u)+(l*c)+d;end;end;break;end;local e=d;do return function()local n=n(l,e(e,e),e(e,e));e(1);return n;end;end;until true;else local e=d;do return function()local n=n(l,e(e,e),e(e,e));e(1);return n;end;end;end end end end),...)

end
