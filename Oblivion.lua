--[[
    Made by:
    SomeoneIdfk

    Credits:
	- https://github.com/shlexware
		Made the ui library, could be better but I absolutely love it.
		Made the esp, wasn't perfect but I made it work.
]]

repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("GUI")

-- Environment 
local filesys, syn, environment, oblivion = {
    listfiles = listfiles or listdir or syn_io_listdir or nil,
    isfolder = isfolder or nil,
    isfile = isfile or nil,
    makefolder = makefolder or nil,
    writefile = writefile or nil,
	readfile = readfile or nil
}, {
    getrawmetatable = getrawmetatable or nil,
    getsenv = getsenv or nil,
	getrenv = getrenv or nil,
    hookfunc = hookfunc or hookfunction or replaceclosure or nil,
    sethiddenproperty = sethiddenproperty or nil,
	getconnections = getconnections or nil,
	mousemoverel = mousemoverel or nil,
	getnamecallmethod = getnamecallmethod or nil,
	getcallingscript = getcallingscript or nil,
	newcclosure = newcclosure or nil,
	checkcaller = checkcaller or nil,
	setreadonly = setreadonly or nil,
	make_writeable = make_writeable or nil
}, {
    Workspace = game:GetService("Workspace"),
    UserInputService = game:GetService("UserInputService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService = game:GetService("HttpService"),
    RunService = game:GetService("RunService"),
    Players = game:GetService('Players'),
    TeleportService = game:GetService("TeleportService"),
    LocalPlayer = game:GetService('Players').LocalPlayer,
	Mouse = game:GetService("Players").LocalPlayer:GetMouse(),
	CurrentCamera = game:GetService("Workspace").CurrentCamera,
	ContentProvider = game:GetService('ContentProvider')
}, {
    env_err = false,
    ran = false,
    lists = {tagged = {}, textures = {}, visible_player_cache = {}, enemies = {}, teammates = {}, everyone = {}, hit_sounds = {Bameware = "rbxassetid://3124331820", Bell = "rbxassetid://6534947240", Bubble = "rbxassetid://6534947588", Pick = "rbxassetid://1347140027", Pop = "rbxassetid://198598793", Rust = "rbxassetid://1255040462", Skeet = "rbxassetid://5633695679", Neverlose = "rbxassetid://6534948092", Minecraft = "rbxassetid://4018616850"}, weapon_data = loadstring("return "..game:HttpGet('https://raw.githubusercontent.com/SomeoneIdfk/Roblox/main/Weapon_Data.cfg'))(), ignore_flags = {"aimbot_whitelist", "aimbot_add_player", "esp_whitelist", "esp_add_player", "settings_profile"}},
    values = {map = nil, splatterblood = nil, createbullethole = nil, aimbot = {player = nil, lastplayer = nil, part = nil, reset = 0, delay = 0, rayfilter = false, triggerbot = {state = false, delay = 0, shoot = 0}}, bodyvelocity = Instance.new("BodyVelocity"), defaultgravity = game:GetService("Workspace").Gravity, sound = nil},
	client = nil,
	fov = Drawing.new("Circle"),
	triggerbot_fov = Drawing.new("Circle"),
	oldnamecall = nil,
	step = nil,
	ping = nil,
	config_name = nil
}

for i, v in ipairs(filesys) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
for i, v in ipairs(syn) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
for i, v in ipairs(environment) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
if oblivion.env_err then return end

if not (filesys.isfolder("Oblivion") and filesys.isfolder("Oblivion/CB") and filesys.isfolder("Oblivion/CB/Profiles")) then filesys.makefolder("Oblivion") filesys.makefolder("Oblivion/CB") filesys.makefolder("Oblivion/CB/Profiles") end
if not filesys.isfile("Oblivion/CB/tagged.cfg") then filesys.writefile("Oblivion/CB/tagged.cfg", environment.HttpService:JSONEncode({})) end
if not filesys.isfile("Oblivion/CB/auto_load.cfg") then filesys.writefile("Oblivion/CB/auto_load.cfg", "") end

oblivion.lists.tagged = environment.HttpService:JSONDecode(filesys.readfile("Oblivion/CB/tagged.cfg"))

-- Preparation
repeat wait() until environment.Workspace:FindFirstChild("Map") and environment.Workspace.Map:FindFirstChild("Origin")
oblivion.client, oblivion.fov.Thickness, oblivion.triggerbot_fov.Thickness = syn.getsenv(environment.LocalPlayer.PlayerGui:WaitForChild("Client")), 2, 2

local ui_source = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local ui = ui_source:MakeWindow({Name = "Oblivion", HidePremium = true, SaveConfig = false, ConfigFolder = "", IntroEnabled = true, IntroText = "Oblivion", IntroIcon = "rbxassetid://4335489513"})

local esp = loadstring(game:HttpGet('https://raw.githubusercontent.com/SomeoneIdfk/Roblox/main/Esp.lua'))()

esp.teamSettings = {
    enemy = {
        enabled = false,
        box = true,
        boxColor = { Color3.new(1,0,0), 1 },
        boxOutline = false,
        boxOutlineColor = { Color3.new(), 1 },
        boxFill = false,
        boxFillColor = { Color3.new(1,0,0), 0.5 },
        healthBar = false,
        healthyColor = Color3.new(0,1,0),
        dyingColor = Color3.new(1,0,0),
        healthBarOutline = false,
        healthBarOutlineColor = { Color3.new(), 1 },
        healthText = false,
        healthTextColor = { Color3.new(1,1,1), 1 },
        healthTextOutline = false,
        healthTextOutlineColor = Color3.new(),
        name = false,
        nameColor = { Color3.new(1,1,1), 1 },
        nameOutline = false,
        nameOutlineColor = Color3.new(),
        weapon = false,
        weaponColor = { Color3.new(1,1,1), 1 },
        weaponOutline = false,
        weaponOutlineColor = Color3.new(),
        distance = false,
        distanceColor = { Color3.new(1,1,1), 1 },
        distanceOutline = false,
        distanceOutlineColor = Color3.new(),
        tracer = false,
        tracerOrigin = "Bottom",
        tracerColor = { Color3.new(1,0,0), 1 },
        tracerOutline = false,
        tracerOutlineColor = { Color3.new(), 1 },
        offScreenArrow = false,
        offScreenArrowColor = { Color3.new(1,1,1), 1 },
        offScreenArrowSize = 15,
        offScreenArrowRadius = 150,
        offScreenArrowOutline = false,
        offScreenArrowOutlineColor = { Color3.new(), 1 },
        chams = false,
        chamsVisibleOnly = false,
        chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 },
        chamsOutlineColor = { Color3.new(1,0,0), 0 }}, friendly = { enabled = false, box = true, boxColor = { Color3.new(0,1,0), 1 }, boxOutline = false, boxOutlineColor = { Color3.new(), 1 }, boxFill = false, boxFillColor = { Color3.new(0,1,0), 0.5 }, healthBar = false, healthyColor = Color3.new(0,1,0), dyingColor = Color3.new(1,0,0), healthBarOutline = false, healthBarOutlineColor = { Color3.new(), 1 }, healthText = false, healthTextColor = { Color3.new(1,1,1), 1 }, healthTextOutline = false, healthTextOutlineColor = Color3.new(), name = false, nameColor = { Color3.new(1,1,1), 1 }, nameOutline = false, nameOutlineColor = Color3.new(), weapon = false, weaponColor = { Color3.new(1,1,1), 1 }, weaponOutline = false, weaponOutlineColor = Color3.new(), distance = false, distanceColor = { Color3.new(1,1,1), 1 }, distanceOutline = false, distanceOutlineColor = Color3.new(), tracer = false, tracerOrigin = "Bottom", tracerColor = { Color3.new(0,1,0), 1 }, tracerOutline = false, tracerOutlineColor = { Color3.new(), 1 }, offScreenArrow = false, offScreenArrowColor = { Color3.new(1,1,1), 1 }, offScreenArrowSize = 15, offScreenArrowRadius = 150, offScreenArrowOutline = false, offScreenArrowOutlineColor = { Color3.new(), 1 }, chams = false, chamsVisibleOnly = false, chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 }, chamsOutlineColor = { Color3.new(0,1,0), 0 }}}

local Hitboxes = {"Head", "UpperTorso", "LeftUpperArm", "RightUpperArm", "LeftFoot", "RightFoot", "LeftHand", "RightHand"}

oblivion.values.sound = Instance.new("Sound")
for _, v in pairs(oblivion.lists.hit_sounds) do
    oblivion.values.sound.SoundId = v
    environment.ContentProvider:PreloadAsync({oblivion.values.sound}, function() end)
end
oblivion.values.sound:Destroy()

-- Functions
function esp.isFriendly(player)
	return player and player:FindFirstChild("Status") and player.Status.Team.Value == environment.LocalPlayer.Status.Team.Value or false;
end

local function TableContains(list, value)
	if type(list) ~= "table" then return false; end
	for i, v in ipairs(list) do
		if v == value then return i; end
	end
	return false;
end

local function TableRebuild(list, i, value)
	if type(list) ~= "table" then return list; end
	local temp = {}
	for _, v in ipairs(list) do
		if i == 1 or v ~= value then temp[#temp + 1] = v end
	end
	if i == 1 then
		temp[#temp + 1] = value
	end
	return temp;
end

local function RefreshFlags()
	local saves = {"-"}
	for i, v in pairs(filesys.listfiles("Oblivion/CB/Profiles")) do
		local name;
		for v2 in string.gmatch(v, "[^\\/]+") do
			name = v2
		end
		saves[#saves + 1] = string.gsub(name, ".cfg", "")
	end
	ui_source.Flags["settings_profile"]:Refresh(saves, true)
end

local function SaveFlags(name)
	local save = {}
	for i, v in pairs(ui_source.Flags) do
		if not TableContains(oblivion.lists.ignore_flags, i) then
			save[i] = v.Value
		end
	end
	filesys.writefile("Oblivion/CB/Profiles/"..name..".cfg", environment.HttpService:JSONEncode(save))
	RefreshFlags()
end

local function LoadFlags(name)
	if not (name or filesys.isfile("Oblivion/CB/Profiles/"..name..".cfg")) then RefreshFlags() return; end
	local save = environment.HttpService:JSONDecode(filesys.readfile("Oblivion/CB/Profiles/"..name..".cfg"))
	for i, v in pairs(save) do
		coroutine.wrap(function()
			local succes, result = pcall(function()
				if ui_source.Flags[i] then
					ui_source.Flags[i]:Set(v)
				end
			end)
			if not succes then
				print("Error loading; "..tostring(result))
			end
		end)()
	end
	print("Loaded config; "..tostring(name))
end

local function GetTeam(player)
	return player and player:FindFirstChild("Status") and player.Status:FindFirstChild("Team") and player.Status.Team.Value ~= "Spectator" and player.Status.Team.Value or nil;
end

local function IsAlive(player)
	return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and GetTeam(player) and true or false;
end

local function ReturnCharacter(player)
	return IsAlive(player) and player.Character or nil;
end

local function WithinFOV(camera, hrp)
	local playerToCharacter, playerLook = (hrp.Position - camera.Position).Unit, camera.LookVector
	local withinFOV = playerToCharacter:Dot(playerLook)
	return withinFOV > 0;
end

local function DistanceFromPlayer(player)
	local character = ReturnCharacter(player)
	return character and (environment.CurrentCamera.CFrame.p - character.HumanoidRootPart.Position).magnitude or 0;
end

local function CanSeePlayer(player, hitboxes)
	local character, localplayer = ReturnCharacter(player), environment.LocalPlayer.Character
	if not character then return false; end
	local origin = environment.CurrentCamera.CFrame
	if not WithinFOV(origin, character.HumanoidRootPart) then return false; end
	for _, v in ipairs(hitboxes) do
		local part = character:FindFirstChild(v) and character[v] or nil
		if part then
			local ray = Ray.new(origin.Position, (part.Position - origin.Position).unit * (part.Position - origin.Position).magnitude)
			local hit, pos = environment.Workspace:FindPartOnRayWithIgnoreList(ray, {localplayer, environment.CurrentCamera, environment.Workspace.Map.Clips, environment.Workspace.Map.SpawnPoints, environment.Workspace.Debris}, false, true)
			if hit and hit:FindFirstAncestor(player.Name) then
				return hit;
			end
		end
	end
	return false;
end

local function KnifeOrGun()
	local tool, result = IsAlive(environment.LocalPlayer) and environment.LocalPlayer.Character.EquippedTool.Value or nil, nil
	if not tool then return "unknown"; end
	if oblivion.client.gun:FindFirstChild("Melee") then return "knife"; end
	for _, v in pairs(oblivion.lists.weapon_data.guns) do
		if tool == v.name then
			result = "gun"
			break
		end
	end
	return result or "unknown";
end

local function GetGunName()
	local tool, result = IsAlive(environment.LocalPlayer) and environment.LocalPlayer.Character.EquippedTool.Value or nil, nil
	for i, v in pairs(oblivion.lists.weapon_data.guns) do
		if tool == v.name then
			result = i
			break
		end
	end
	return result
end

local function EditDropdowns(name, reason)
	local temp1, temp2, temp3, lteam = {"-"}, {"-"}, {"-"}, GetTeam(environment.LocalPlayer)
	for _, v in pairs(environment.Players:GetPlayers()) do
		if environment.LocalPlayer ~= v then
			local pteam = GetTeam(v)
			if pteam then
				if lteam == pteam then
					temp2[#temp2 + 1] = v.Name
				else
					temp1[#temp1 + 1] = v.Name
				end
			end
			temp3[#temp3 + 1] = v.Name
		end
	end
	oblivion.lists.enemies, oblivion.lists.teammates, oblivion.lists.everyone = temp1, temp2, temp3
	ui_source.Flags["esp_add_player"]:Refresh(temp3, true)
	ui_source.Flags["aimbot_add_player"]:Refresh(temp3, true)

	if name then
		if reason == 1 then
			local index = TableContains(ui_source.Flags["esp_whitelist"].Options, name)
			if index then
				ui_source.Flags["esp_whitelist"]:Refresh(TableRebuild(ui_source.Flags["esp_whitelist"].Options, 2, name), true)
			end

			index = TableContains(ui_source.Flags["aimbot_whitelist"].Options, name)
			if index then
				ui_source.Flags["aimbot_whitelist"]:Refresh(TableRebuild(ui_source.Flags["aimbot_whitelist"].Options, 2, name), true)
			end
		elseif reason == 2 then
			--[[local temp4 = TableRebuild(ui_source.Flags["aimbot_whitelist"].Options)
			for _, v in ipairs(temp4) do
				if v ~= "-" and not TableContains(temp1, v) then
					temp4 = TableRebuild(temp4, 2, v)
				end
			end
			ui_source.Flags["aimbot_whitelist"]:Refresh(temp4, true)]]
		end
	end
end

local function InitiatePlayer(player)
	coroutine.wrap(function()
		repeat
			wait()
		until not environment.Players:FindFirstChild(player.Name) or player:FindFirstChild("Status") and player.Status:FindFirstChild("Team")
		if environment.Players:FindFirstChild(player.Name) then
			player.Status.Team:GetPropertyChangedSignal("Value"):Connect(function()
				EditDropdowns(player.Name, 2)
			end)
		end
	end)()
	if environment.LocalPlayer == player then return end
	oblivion.lists.visible_player_cache[player] = {state = false, reset = 0}
	player.CharacterAdded:Connect(function(character)
		local renderstepper = environment.RunService.RenderStepped:Connect(function()
			pcall(function()
				if ui_source.Flags["rage_anti_anti_aim_pitch"].Value == true then
					character.UpperTorso.Waist.C0 = CFrame.Angles(0, 0, 0)
					character.LowerTorso.Root.C0 = CFrame.Angles(0,0,0)
					character.Head.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(0, 0, 0)
				end
				if ui_source.Flags["rage_anti_anti_aim_roll"].Value == true then
					character.Humanoid.MaxSlopeAngle = 0
				end
				if ui_source.Flags["rage_anti_anti_aim_animation"].Value == true then
					for _, v in pairs(character.Humanoid:GetPlayingAnimationTracks()) do
						v:Stop()
					end
				end
			end)
			pcall(function()
				local Position = character.HumanoidRootPart.Position
				environment.RunService.RenderStepped:Wait()
				if character ~= nil and character:FindFirstChild("HumanoidRootPart") then
					if character.HumanoidRootPart:FindFirstChild("OldPosition") then
						character.HumanoidRootPart.OldPosition.Value = Position
					else
						local Value = Instance.new("Vector3Value")
						Value.Name = "OldPosition"
						Value.Value = character.HumanoidRootPart.Position
						Value.Parent = character.HumanoidRootPart
					end
				end
			end)
		end)
		repeat
			wait()
		until character and character:FindFirstChild("Humanoid")
		character.Humanoid.Died:Connect(function()
			renderstepper:Disconnect()
		end)
	end)
	coroutine.wrap(function()
		local character = ReturnCharacter(player)
		if character then
			local renderstepper = environment.RunService.RenderStepped:Connect(function()
				pcall(function()
					if ui_source.Flags["rage_anti_anti_aim_pitch"].Value == true then
						character.UpperTorso.Waist.C0 = CFrame.Angles(0, 0, 0)
						character.LowerTorso.Root.C0 = CFrame.Angles(0,0,0)
						character.Head.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(0, 0, 0)
					end
					if ui_source.Flags["rage_anti_anti_aim_roll"].Value == true then
						character.Humanoid.MaxSlopeAngle = 0
					end
					if ui_source.Flags["rage_anti_anti_aim_animation"].Value == true then
						for _, v in pairs(character.Humanoid:GetPlayingAnimationTracks()) do
							v:Stop()
						end
					end
				end)
				pcall(function()
					local Position = character.HumanoidRootPart.Position
					environment.RunService.RenderStepped:Wait()
					if character ~= nil and character:FindFirstChild("HumanoidRootPart") then
						if character.HumanoidRootPart:FindFirstChild("OldPosition") then
							character.HumanoidRootPart.OldPosition.Value = Position
						else
							local Value = Instance.new("Vector3Value")
							Value.Name = "OldPosition"
							Value.Value = character.HumanoidRootPart.Position
							Value.Parent = character.HumanoidRootPart
						end
					end
				end)
			end)
			repeat
				wait()
			until character and character:FindFirstChild("Humanoid")
			character.Humanoid.Died:Connect(function()
				renderstepper:Disconnect()
			end)
		end
	end)()
end

local function RemoveTextures()
	local decalsyeeted = false
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	syn.sethiddenproperty(t, "Decoration", false)
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = 0
	l.FogEnd = 9e9
	l.Brightness = 0
	for i, v in pairs(w:GetDescendants()) do
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("MeshPart") and decalsyeeted then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		elseif v:IsA("SpecialMesh") and decalsyeeted  then
			v.TextureId=0
		elseif v:IsA("ShirtGraphic") and decalsyeeted then
			v.Graphic=0
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
			v[v.ClassName.."Template"] = 0
		end
	end
	for i = 1, #l:GetChildren() do
		local e = l:GetChildren()[i]
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
end

-- UI
local tabs = {
    aimbot = ui:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
	rage = ui:MakeTab({Name = "Rage", Icon = "rbxassetid://3944668821", PremiumOnly = false}),
	esp = ui:MakeTab({Name = "ESP", Icon = "rbxassetid://4483362458", PremiumOnly = false}),
	qol = ui:MakeTab({Name = "QOL", Icon = "rbxassetid://4384401360", PremiumOnly = false}),
    settings = ui:MakeTab({Name = "Settings", Icon = "rbxassetid://3605022185", PremiumOnly = false})
}
local sections = {
    aimbot = {
        main = tabs.aimbot:AddSection({Name = "Main"}),
		fov = tabs.aimbot:AddSection({Name = "FOV"}),
		triggerbot = tabs.aimbot:AddSection({Name = "Triggerbot"})
    },
	rage = {
		bhop = tabs.rage:AddSection({Name = "B-Hop"}),
		antiantiaim = tabs.rage:AddSection({"Anti Anti-Aim"})
	},
	esp = {
		main = tabs.esp:AddSection({Name = "Main"}),
		chams = tabs.esp:AddSection({Name = "Chams"}),
		boxes = tabs.esp:AddSection({Name = "Boxes"}),
		details = tabs.esp:AddSection({Name = "Details"}),
		tracers = tabs.esp:AddSection({Name = "Tracers"})
	},
	qol = {
		performance = tabs.qol:AddSection({Name = "Performance"}),
		hit_sounds = tabs.qol:AddSection({Name = "Hit Sounds"}),
		misc = tabs.qol:AddSection({Name = "Misc"})
	},
    settings = {
		profile = tabs.settings:AddSection({Name = "Profile"}),
        misc = tabs.settings:AddSection({Name = "Misc"})
    }
}

sections.aimbot.main:AddToggle({Name = "Enable", Default = false, Flag = "aimbot_enemy_enable"})
sections.aimbot.main:AddToggle({Name = "Team", Default = false, Flag = "aimbot_team_enable"})
sections.aimbot.main:AddToggle({Name = "Visible Only", Default = false, Flag = "aimbot_visible_only"})
sections.aimbot.main:AddDropdown({Name = "Aim Type", Default = "Smooth", Options = {"Smooth", "Lock", "Silent"}, Flag = "aimbot_type"})
sections.aimbot.main:AddToggle({Name = "Whitelist Only", Default = false, Flag = "aimbot_whitelist_only"})
sections.aimbot.main:AddDropdown({Name = "Whitelist Remove", Default = "-", Options = {"-"}, Flag = "aimbot_whitelist", Callback = function(state) if state ~= "-" then ui_source.Flags["aimbot_whitelist"]:Set("-") ui_source.Flags["aimbot_whitelist"]:Refresh(TableRebuild(ui_source.Flags["aimbot_whitelist"].Options, 2, state), true) end end})
sections.aimbot.main:AddDropdown({Name = "Whitelist Add", Default = "-", Options = {"-"}, Flag = "aimbot_add_player", Callback = function(state) if state ~= "-" then ui_source.Flags["aimbot_add_player"]:Set("-") if not TableContains(ui_source.Flags["aimbot_whitelist"].Options, state) then ui_source.Flags["aimbot_whitelist"]:Refresh(TableRebuild(ui_source.Flags["aimbot_whitelist"].Options, 1, state), true) end end end})
sections.aimbot.main:AddDropdown({Name = "Preference", Default = "Head", Options = {"Head", "Humanoid"}, Flag = "aimbot_preference"})
sections.aimbot.main:AddDropdown({Name = "Prediction", Default = "-", Options = {"-", "CFrame", "Velocity"}, Flag = "aimbot_prediction"})
sections.aimbot.main:AddToggle({Name = "Force Hit", Default = false, Flag = "aimbot_force_hit"})
sections.aimbot.main:AddSlider({Name = "Smoothness", Min = 1, Max = 50, Default = 25, Color3.fromRGB(0, 0, 0), Increment = 1, Flag = "aimbot_smoothness"})
sections.aimbot.main:AddSlider({Name = "Delay", Min = 0, Max = 500, Default = 200, Color3.fromRGB(0, 0, 0), Increment = 50, Flag = "aimbot_delay"})
sections.aimbot.main:AddSlider({Name = "Memory", Min = 0, Max = 500, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 50, Flag = "aimbot_memory"})
sections.aimbot.fov:AddToggle({Name = "FOV", Default = false, Flag = "aimbot_fov_enable"})
sections.aimbot.fov:AddColorpicker({Name = "Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "aimbot_fov_colour", Callback = function(state) oblivion.fov.Color = state end})
sections.aimbot.fov:AddSlider({Name = "Radius", Min = 10, Max = 360, Default = 60, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "aimbot_fov_radius", Callback = function(state) oblivion.fov.Radius = state end})
sections.aimbot.fov:AddSlider({Name = "Transparency", Min = 0, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "aimbot_fov_transparency", Callback = function(state) oblivion.fov.Transparency = (state / 100) end})
sections.aimbot.triggerbot:AddToggle({Name = "Triggerbot", Default = false, Flag = "aimbot_triggerbot"})
sections.aimbot.triggerbot:AddDropdown({Name = "Shoot Delay", Default = "-", Options = {"-", "1/1", "3/4", "1/2", "1/4"}, Flag = "aimbot_triggerbot_shoot_delay"})
sections.aimbot.triggerbot:AddSlider({Name = "Custom Tap", Min = 1, Max = 20, Default = 1, Color3.fromRGB(0, 0, 0), Increment = 1, Flag = "aimbot_triggerbot_custom_tap"})
sections.aimbot.triggerbot:AddSlider({Name = "Delay", Min = 0, Max = 300, Default = 100, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "aimbot_triggerbot_delay"})
sections.aimbot.triggerbot:AddToggle({Name = "FOV", Default = false, Flag = "aimbot_triggerbot_fov"})
sections.aimbot.triggerbot:AddColorpicker({Name = "Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "aimbot_triggerbot_fov_colour", Callback = function(state) oblivion.triggerbot_fov.Color = state end})
sections.aimbot.triggerbot:AddSlider({Name = "Radius", Min = 10, Max = 360, Default = 60, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "aimbot_triggerbot_fov_radius", Callback = function(state) oblivion.triggerbot_fov.Radius = state end})
sections.aimbot.triggerbot:AddSlider({Name = "Transparency", Min = 0, Max = 1, Default = 0.5, Color3.fromRGB(0, 0, 0), Increment = 0.1, Flag = "aimbot_triggerbot_fov_transparency", Callback = function(state) oblivion.triggerbot_fov.Transparency = state end})

sections.rage.bhop:AddDropdown({Name = "B-Hop", Default = "None", Options = {"None", "CFrame", "CFrame Walk", "Gyro", "Gyro Walk"}, Flag = "rage_bhop_type"})
sections.rage.bhop:AddSlider({Name = "Speed", Min = 1, Max = 100, Default = 20, Color3.fromRGB(255, 255, 255), Increment = 1, Flag = "rage_bhop_speed"})
sections.rage.antiantiaim:AddToggle({Name = "Pitch Manipulation", Default = false, Flag = "rage_anti_anti_aim_pitch"})
sections.rage.antiantiaim:AddToggle({Name = "Roll Manipulation", Default = false, Flag = "rage_anti_anti_aim_roll"})
sections.rage.antiantiaim:AddToggle({Name = "Animation Manipulation", Default = false, Flag = "rage_anti_anti_aim_animation"})

sections.esp.main:AddToggle({Name = "Enable", Default = false, Flag = "esp_enemy_enable", Callback = function(state) esp.teamSettings.enemy.enabled = state esp.teamSettings.friendly.enabled = state and ui_source.Flags["esp_team_enable"] and ui_source.Flags["esp_team_enable"].Value or false end})
sections.esp.main:AddToggle({Name = "Team", Default = false, Flag = "esp_team_enable", Callback = function(state) if ui_source.Flags["esp_enemy_enable"].Value then esp.teamSettings.friendly.enabled = state end end})
sections.esp.main:AddToggle({Name = "Visible Only", Default = false, Flag = "esp_visible_only"})
sections.esp.main:AddToggle({Name = "Whitelist Only", Default = false, Flag = "esp_whitelist_only"})
sections.esp.main:AddDropdown({Name = "Whitelist Remove", Default = "-", Options = {"-"}, Flag = "esp_whitelist", Callback = function(state) if state ~= "-" then ui_source.Flags["esp_whitelist"]:Set("-") ui_source.Flags["esp_whitelist"]:Refresh(TableRebuild(ui_source.Flags["esp_whitelist"].Options, 2, state), true) end end})
sections.esp.main:AddDropdown({Name = "Whitelist Add", Default = "-", Options = {"-"}, Flag = "esp_add_player", Callback = function(state) if state ~= "-" then ui_source.Flags["esp_add_player"]:Set("-") if not TableContains(ui_source.Flags["esp_whitelist"].Options, state) then ui_source.Flags["esp_whitelist"]:Refresh(TableRebuild(ui_source.Flags["esp_whitelist"].Options, 1, state), true) end end end})
sections.esp.chams:AddToggle({Name = "Chams", Default = false, Flag = "esp_chams", Callback = function(state) esp.teamSettings.enemy.chams = state esp.teamSettings.friendly.chams = state end})
sections.esp.chams:AddColorpicker({Name = "Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "esp_chams_colour", Callback = function(state) if ui_source.Flags["esp_chams_team_colour"] and not ui_source.Flags["esp_chams_team_colour"].Value then esp.teamSettings.enemy.chamsOutlineColor[1] = state esp.teamSettings.friendly.chamsOutlineColor[1] = state end end})
sections.esp.chams:AddToggle({Name = "Team Colour", Default = false, Flag = "esp_chams_team_colour", Callback = function(state) if state then esp.teamSettings.enemy.chamsOutlineColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.friendly.chamsOutlineColor[1] = Color3.fromRGB(0, 255, 0) else esp.teamSettings.enemy.chamsOutlineColor[1] = ui_source.Flags["esp_chams_colour"] and ui_source.Flags["esp_chams_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.chamsOutlineColor[1] = ui_source.Flags["esp_chams_colour"] and ui_source.Flags["esp_chams_colour"].Value or Color3.fromRGB(255, 255, 255) end end})
sections.esp.chams:AddSlider({Name = "Transparency", Min = 0, Max = 90, Default = 40, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "esp_chams_transparency", Callback = function(state) esp.teamSettings.enemy.chamsOutlineColor[2] = (state / 100) esp.teamSettings.friendly.chamsOutlineColor[2] = (state / 100) end})
sections.esp.chams:AddColorpicker({Name = "Filled Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "esp_filled_chams_colour", Callback = function(state) if ui_source.Flags["esp_filled_chams_team_colour"] and not ui_source.Flags["esp_filled_chams_team_colour"].Value then esp.teamSettings.enemy.chamsFillColor[1] = state esp.teamSettings.friendly.chamsFillColor[1] = state end end})
sections.esp.chams:AddToggle({Name = "Filled Team Colour", Default = false, Flag = "esp_filled_chams_team_colour", Callback = function(state) if state then esp.teamSettings.enemy.chamsFillColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.friendly.chamsFillColor[1] = Color3.fromRGB(0, 255, 0) else esp.teamSettings.enemy.chamsFillColor[1] = ui_source.Flags["esp_filled_chams_colour"] and ui_source.Flags["esp_filled_chams_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.chamsFillColor[1] = ui_source.Flags["esp_filled_chams_colour"] and ui_source.Flags["esp_filled_chams_colour"].Value or Color3.fromRGB(255, 255, 255) end end})
sections.esp.chams:AddSlider({Name = "Transparency", Min = 0, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "esp_filled_chams_transparency", Callback = function(state) esp.teamSettings.enemy.chamsFillColor[2] = (state / 100) esp.teamSettings.friendly.chamsFillColor[2] = (state / 100) end})
sections.esp.boxes:AddToggle({Name = "Box", Default = false, Flag = "esp_boxes", Callback = function(state) esp.teamSettings.enemy.box = state esp.teamSettings.friendly.box = state end})
sections.esp.boxes:AddColorpicker({Name = "Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "esp_boxes_colour", Callback = function(state) if ui_source.Flags["esp_boxes_team_colour"] and not ui_source.Flags["esp_boxes_team_colour"].Value then esp.teamSettings.enemy.boxColor[1] = state esp.teamSettings.friendly.boxColor[1] = state end end})
sections.esp.boxes:AddToggle({Name = "Team Colour", Default = false, Flag = "esp_boxes_team_colour", Callback = function(state) if state then esp.teamSettings.enemy.boxColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.friendly.boxColor[1] = Color3.fromRGB(0, 255, 0) else esp.teamSettings.enemy.boxColor[1] = ui_source.Flags["esp_boxes_colour"] and ui_source.Flags["esp_boxes_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.boxColor[1] = ui_source.Flags["esp_boxes_colour"] and ui_source.Flags["esp_boxes_colour"].Value or Color3.fromRGB(255, 255, 255) end end})
sections.esp.boxes:AddSlider({Name = "Transparency", Min = 10, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "esp_boxes_transparency", Callback = function(state) esp.teamSettings.enemy.boxColor[2] = (state / 100) esp.teamSettings.friendly.boxColor[2] = (state / 100) end})
sections.esp.boxes:AddToggle({Name = "Filled Box", Default = false, Flag = "esp_filled_boxes", Callback = function(state) esp.teamSettings.enemy.boxFill = state esp.teamSettings.friendly.boxFill = state end})
sections.esp.boxes:AddColorpicker({Name = "Filled Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "esp_filled_boxes_colour", Callback = function(state) if ui_source.Flags["esp_filled_boxes_team_colour"] and not ui_source.Flags["esp_filled_boxes_team_colour"].Value then esp.teamSettings.enemy.boxFillColor[1] = state esp.teamSettings.friendly.boxFillColor[1] = state end end})
sections.esp.boxes:AddToggle({Name = "Filled Team Colour", Default = false, Flag = "esp_filled_boxes_team_colour", Callback = function(state) if state then esp.teamSettings.enemy.boxFillColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.friendly.boxFillColor[1] = Color3.fromRGB(0, 255, 0) else esp.teamSettings.enemy.boxFillColor[1] = ui_source.Flags["esp_filled_boxes_colour"] and ui_source.Flags["esp_filled_boxes_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.boxFillColor[1] = ui_source.Flags["esp_filled_boxes_colour"] and ui_source.Flags["esp_filled_boxes_colour"].Value or Color3.fromRGB(255, 255, 255) end end})
sections.esp.boxes:AddSlider({Name = "Filled Transparency", Min = 10, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "esp_filled_boxes_transparency", Callback = function(state) esp.teamSettings.enemy.boxFillColor[2] = (state / 100) esp.teamSettings.friendly.boxFillColor[2] = (state / 100) end})
sections.esp.details:AddToggle({Name = "Details", Default = false, Flag = "esp_details", Callback = function(state) esp.teamSettings.enemy.name = state esp.teamSettings.enemy.distance = state esp.teamSettings.enemy.healthBar = state esp.teamSettings.enemy.healthText = state esp.teamSettings.enemy.weapon = state esp.teamSettings.friendly.name = state esp.teamSettings.friendly.distance = state esp.teamSettings.friendly.healthBar = state esp.teamSettings.friendly.healthText = state esp.teamSettings.friendly.weapon = state end})
sections.esp.details:AddColorpicker({Name = "Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "esp_details_colour", Callback = function(state) if ui_source.Flags["esp_details_team_colour"] and not ui_source.Flags["esp_details_team_colour"].Value then esp.teamSettings.enemy.nameColor[1] = state esp.teamSettings.enemy.distanceColor[1] = state esp.teamSettings.enemy.healthTextColor[1] = state esp.teamSettings.enemy.weaponColor[1] = state esp.teamSettings.friendly.nameColor[1] = state esp.teamSettings.friendly.distanceColor[1] = state esp.teamSettings.friendly.healthTextColor[1] = state esp.teamSettings.friendly.weaponColor[1] = state end end})
sections.esp.details:AddToggle({Name = "Team Colour", Default = false, Flag = "esp_details_team_colour", Callback = function(state) if state then esp.teamSettings.enemy.nameColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.enemy.distanceColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.enemy.healthTextColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.enemy.weaponColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.friendly.nameColor[1] = Color3.fromRGB(0, 255, 0) esp.teamSettings.friendly.distanceColor[1] = Color3.fromRGB(0, 255, 0) esp.teamSettings.friendly.healthTextColor[1] = Color3.fromRGB(0, 255, 0) esp.teamSettings.friendly.weaponColor[1] = Color3.fromRGB(0, 255, 0) else esp.teamSettings.enemy.nameColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.enemy.distanceColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.enemy.healthTextColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.enemy.weaponColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.nameColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.distanceColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.healthTextColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.weaponColor[1] = ui_source.Flags["esp_details_colour"] and ui_source.Flags["esp_details_colour"].Value or Color3.fromRGB(255, 255, 255) end end})
sections.esp.details:AddSlider({Name = "Transparency", Min = 10, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "esp_details_transparency", Callback = function(state) esp.teamSettings.enemy.nameColor[2] = (state / 100) esp.teamSettings.enemy.distanceColor[2] = (state / 100) esp.teamSettings.enemy.healthTextColor[2] = (state / 100) esp.teamSettings.enemy.weaponColor[2] = (state / 100) esp.teamSettings.friendly.nameColor[2] = (state / 100) esp.teamSettings.friendly.distanceColor[2] = (state / 100) esp.teamSettings.friendly.healthTextColor[2] = (state / 100) esp.teamSettings.friendly.weaponColor[2] = (state / 100) end})
sections.esp.tracers:AddToggle({Name = "Tracers", Default = false, Flag = "esp_tracers", Callback = function(state) esp.teamSettings.enemy.tracer = state esp.teamSettings.friendly.tracer = state end})
sections.esp.tracers:AddColorpicker({Name = "Colour", Default = Color3.fromRGB(0, 0, 0), Flag = "esp_tracers_colour", Callback = function(state) if ui_source.Flags["esp_tracers_team_colour"] and not ui_source.Flags["esp_tracers_team_colour"].Value then esp.teamSettings.enemy.tracerColor[1] = state esp.teamSettings.friendly.tracerColor[1] = state end end})
sections.esp.tracers:AddToggle({Name = "Team Colour", Default = false, Flag = "esp_tracers_team_colour", Callback = function(state) if state then esp.teamSettings.enemy.tracerColor[1] = Color3.fromRGB(255, 0, 0) esp.teamSettings.friendly.tracerColor[1] = Color3.fromRGB(0, 255, 0) else esp.teamSettings.enemy.tracerColor[1] = ui_source.Flags["esp_tracers_colour"] and ui_source.Flags["esp_tracers_colour"].Value or Color3.fromRGB(255, 255, 255) esp.teamSettings.friendly.tracerColor[1] = ui_source.Flags["esp_tracers_colour"] and ui_source.Flags["esp_tracers_colour"].Value or Color3.fromRGB(255, 255, 255) end end})
sections.esp.tracers:AddSlider({Name = "Transparency", Min = 10, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "esp_tracers_transparency", Callback = function(state) esp.teamSettings.enemy.tracerColor[2] = (state / 100) esp.teamSettings.friendly.tracerColor[2] = (state / 100) end})
sections.esp.tracers:AddDropdown({Name = "Origin", Default = "Bottom", Options = {"Bottom", "Top", "Middle"}, Flag = "esp_tracers_origin", Callback = function(state) esp.teamSettings.enemy.tracerOrigin = state esp.teamSettings.friendly.tracerOrigin = state end})

sections.qol.performance:AddToggle({Name = "Remove Textures", Default = false, Flag = "qol_texture_remove", Callback = function(state) if state then RemoveTextures() end end})
sections.qol.performance:AddToggle({Name = "Remove Mags", Default = false, Flag = "qol_mag_remove", Callback = function(state) if not state then return end for _, v in pairs(environment.Workspace.Ray_Ignore:GetChildren()) do v:WaitForChild("Mesh") if v.Name == "MagDrop" then v:Destroy() end end end})
sections.qol.performance:AddToggle({Name = "Remove Bullets", Default = false, Flag = "qol_bullet_remove", Callback = function(state) if not state then return end for _, v in pairs(environment.Workspace.Debris:GetChildren()) do if v.Name == "Bullet" then v:Destroy() end end end})
sections.qol.performance:AddToggle({Name = "Remove Blood", Default = false, Flag = "qol_blood_remove"})
sections.qol.hit_sounds:AddDropdown({Name = "Hit Sound", Default = "-", Options = {"-", "Bameware", "Bell", "Bubble", "Pick", "Pop", "Rust", "Skeet", "Neverlose", "Minecraft"}, Flag = "qol_hit_sound"})
sections.qol.hit_sounds:AddSlider({Name = "Volume", Min = 10, Max = 100, Default = 20, Color3.fromRGB(0, 0, 0), Increment = 10, Flag = "qol_hit_sound_volume"})
sections.qol.misc:AddDropdown({Name = "Infinite Ammo", Default = "-", Options = {"-", "Mag", "Reserve"}, Flag = "qol_infinite_ammo"})
sections.qol.misc:AddToggle({Name = "Anti-AFK", Default = true, Flag = "qol_anti_afk"})
sections.qol.misc:AddDropdown({Name = "Auto Join", Default = "None", Options = {"None", "Terrorists", "Counter-Terrorists"}, Flag = "qol_auto_join"})

sections.settings.profile:AddTextbox({Name = "Name", Default = "", TextDisappear = false, Callback = function(state) oblivion.config_name = state end})
sections.settings.profile:AddButton({Name = "Save", Callback = function() SaveFlags(oblivion.config_name) end})
sections.settings.profile:AddDropdown({Name = "Profiles", Default = "-", Options = {"-"}, Flag = "settings_profile"})
sections.settings.profile:AddButton({Name = "Load", Callback = function() if ui_source.Flags["settings_profile"].Value ~= "-" then LoadFlags(ui_source.Flags["settings_profile"].Value) end end})
sections.settings.profile:AddButton({Name = "Auto Load", Callback = function() filesys.writefile("Oblivion/CB/auto_load.cfg", ui_source.Flags["settings_profile"].Value == "-" and "" or ui_source.Flags["settings_profile"].Value) end})
sections.settings.profile:AddButton({Name = "Refresh", Callback = function() RefreshFlags() end})
sections.settings.misc:AddButton({Name = "Server Hop", Callback = function() local places, teleported = {}, false repeat places = {} for _, v in ipairs(environment.HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100")).data) do if type(v) == "table" and (v.maxPlayers - 2) <= v.playing and v.id ~= game.JobId then places[#places + 1] = v.id end end if #places > 0 then teleported = true environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, places[math.random(1, #places)]) end if not teleported then wait(3) end until teleported end})
sections.settings.misc:AddButton({Name = "Server Rejoin", Callback = function() environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, environment.LocalPlayer) end})
sections.settings.misc:AddButton({Name = "Refresh Dropdowns", Callback = function() EditDropdowns() end})

-- Init
ui_source:Init()
esp:Load()

environment.Players.PlayerAdded:Connect(function(player)
	coroutine.wrap(function()
		InitiatePlayer(player)
	end)()
end)

environment.Players.PlayerRemoving:Connect(function(player)
	coroutine.wrap(function()
		EditDropdowns(player.Name, 1)
	end)()
end)

for _, player in pairs(environment.Players:GetPlayers()) do
	coroutine.wrap(function()
		InitiatePlayer(player)
	end)()
end

environment.LocalPlayer.CharacterAdded:Connect(function(character)
	local renderstepper = environment.RunService.RenderStepped:Connect(function()
		pcall(function()
			if not (character:FindFirstChild("UpperTorso") and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart")) then return end
			oblivion.values.bodyvelocity:Destroy()
			oblivion.values.bodyvelocity = Instance.new("BodyVelocity")
			oblivion.values.bodyvelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
			if ui_source.Flags["rage_bhop_type"].Value ~= "None" and environment.UserInputService:IsKeyDown("Space") then
				local add = 0
				if environment.UserInputService:IsKeyDown("A") then add = 90 end if environment.UserInputService:IsKeyDown("S") then add = 180 end if environment.UserInputService:IsKeyDown("D") then add = 270 end if environment.UserInputService:IsKeyDown("A") and environment.UserInputService:IsKeyDown("W") then add = 45 end if environment.UserInputService:IsKeyDown("D") and environment.UserInputService:IsKeyDown("W") then add = 315 end if environment.UserInputService:IsKeyDown("D") and environment.UserInputService:IsKeyDown("S") then add = 225 end if environment.UserInputService:IsKeyDown("A") and environment.UserInputService:IsKeyDown("S") then add = 145 end
				local x, y, z = environment.CurrentCamera.CFrame:ToOrientation()
				local rot = (CFrame.new(environment.CurrentCamera.CFrame.Position) * CFrame.Angles(0, y, 0)) * CFrame.Angles(0, math.rad(add), 0)
				oblivion.values.bodyvelocity.Parent = character.UpperTorso
				character.Humanoid.Jump = true
				if ui_source.Flags["rage_bhop_type"].Value == "Gyro Walk" then character.Humanoid.JumpPower = 1 end
				environment.Workspace.Gravity = (ui_source.Flags["rage_bhop_type"].Value == "CFrame" or ui_source.Flags["rage_bhop_type"].Value == "Gyro") and oblivion.values.defaultgravity or (ui_source.Flags["rage_bhop_type"].Value == "CFrame Walk" or ui_source.Flags["rage_bhop_type"].Value == "Gyro Walk") and 99999
				oblivion.values.bodyvelocity.Velocity = Vector3.new(rot.LookVector.X, 0, rot.LookVector.Z) * (ui_source.Flags["rage_bhop_speed"].Value * 2)
				if add == 0 and not environment.UserInputService:IsKeyDown("W") then
					oblivion.values.bodyvelocity:Destroy()
				elseif ui_source.Flags["rage_bhop_type"].Value == "CFrame" or ui_source.Flags["rage_bhop_type"].Value == "CFrame Walk" then
					oblivion.values.bodyvelocity:Destroy()
					character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + Vector3.new(rot.LookVector.X, 0, rot.LookVector.Z) * ui_source.Flags["rage_bhop_speed"].Value/50
				end
			elseif ui_source.Flags["rage_bhop_type"].Value == "None" then
				if environment.Workspace.Gravity ~= oblivion.values.defaultgravity then environment.Workspace.Gravity = oblivion.values.defaultgravity end
			end
		end)
	end)
	repeat
		wait()
	until character and character:FindFirstChild("Humanoid")
	character.Humanoid.Died:Connect(function()
		renderstepper:Disconnect()
	end)
end)
coroutine.wrap(function()
	local character = ReturnCharacter(environment.LocalPlayer)
	if character then
		local renderstepper = environment.RunService.RenderStepped:Connect(function()
			pcall(function()
				if not (character:FindFirstChild("UpperTorso") and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart")) then return end
				oblivion.values.bodyvelocity:Destroy()
				oblivion.values.bodyvelocity = Instance.new("BodyVelocity")
				oblivion.values.bodyvelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
				if ui_source.Flags["rage_bhop_type"].Value ~= "None" and environment.UserInputService:IsKeyDown("Space") then
					local add = 0
					if environment.UserInputService:IsKeyDown("A") then add = 90 end if environment.UserInputService:IsKeyDown("S") then add = 180 end if environment.UserInputService:IsKeyDown("D") then add = 270 end if environment.UserInputService:IsKeyDown("A") and environment.UserInputService:IsKeyDown("W") then add = 45 end if environment.UserInputService:IsKeyDown("D") and environment.UserInputService:IsKeyDown("W") then add = 315 end if environment.UserInputService:IsKeyDown("D") and environment.UserInputService:IsKeyDown("S") then add = 225 end if environment.UserInputService:IsKeyDown("A") and environment.UserInputService:IsKeyDown("S") then add = 145 end
					local x, y, z = environment.CurrentCamera.CFrame:ToOrientation()
					local rot = (CFrame.new(environment.CurrentCamera.CFrame.Position) * CFrame.Angles(0, y, 0)) * CFrame.Angles(0, math.rad(add), 0)
					oblivion.values.bodyvelocity.Parent = character.UpperTorso
					character.Humanoid.Jump = true
					if ui_source.Flags["rage_bhop_type"].Value == "Gyro Walk" then character.Humanoid.JumpPower = 1 end
					environment.Workspace.Gravity = (ui_source.Flags["rage_bhop_type"].Value == "CFrame" or ui_source.Flags["rage_bhop_type"].Value == "Gyro") and oblivion.values.defaultgravity or (ui_source.Flags["rage_bhop_type"].Value == "CFrame Walk" or ui_source.Flags["rage_bhop_type"].Value == "Gyro Walk") and 99999
					oblivion.values.bodyvelocity.Velocity = Vector3.new(rot.LookVector.X, 0, rot.LookVector.Z) * (ui_source.Flags["rage_bhop_speed"].Value * 2)
					if add == 0 and not environment.UserInputService:IsKeyDown("W") then
						oblivion.values.bodyvelocity:Destroy()
					elseif ui_source.Flags["rage_bhop_type"].Value == "CFrame" or ui_source.Flags["rage_bhop_type"].Value == "CFrame Walk" then
						oblivion.values.bodyvelocity:Destroy()
						character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + Vector3.new(rot.LookVector.X, 0, rot.LookVector.Z) * ui_source.Flags["rage_bhop_speed"].Value/50
					end
				elseif ui_source.Flags["rage_bhop_type"].Value == "None" then
					if environment.Workspace.Gravity ~= oblivion.values.defaultgravity then environment.Workspace.Gravity = oblivion.values.defaultgravity end
				end
			end)
		end)
		repeat
			wait()
		until character and character:FindFirstChild("Humanoid")
		character.Humanoid.Died:Connect(function()
			renderstepper:Disconnect()
		end)
	end
end)()

environment.Workspace.ChildAdded:Connect(function(child)
	if child.Name == "Map" then
		if ui_source.Flags["qol_auto_join"].Value ~= "None" then
			coroutine.wrap(function()
				local var, rounds = ui_source.Flags["qol_auto_join"].Value == "Terrorists" and "T" or ui_source.Flags["qol_auto_join"].Value == "Counter-Terrorists" and "CT", environment.Workspace.Status.Rounds.Value
				repeat environment.ReplicatedStorage.Events.JoinTeam:FireServer(var) wait(1) until GetTeam(environment.LocalPlayer) == var and rounds == environment.Workspace.Status.Rounds.Value or rounds ~= environment.Workspace.Status.Rounds.Value
			end)()
		end
		repeat
			wait()
		until child:FindFirstChild("Origin")
		wait(5)
		if ui_source.Flags["qol_texture_remove"].Value then
            RemoveTextures()
        end
	end
end)

environment.Workspace.Ray_Ignore.ChildAdded:Connect(function(child)
	if ui_source.Flags["qol_mag_remove"].Value then
		if child.Name == "MagDrop" then
			child:WaitForChild("Mesh")
			child:Destroy()
		end
	end
end)

environment.Workspace.Debris.ChildAdded:Connect(function(child)
	if child.Name == "Bullet" and ui_source.Flags["qol_bullet_remove"].Value or child.Name == "SurfaceGui" then
		environment.RunService.RenderStepped:Wait()
		child:Destroy()
	end
end)

environment.Mouse.Move:Connect(function()
	if oblivion.fov.Visible or oblivion.triggerbot_fov.Visible then
		local position = environment.UserInputService:GetMouseLocation()
		oblivion.fov.Position, oblivion.triggerbot_fov.Position = position, position
	end
end)

environment.RunService.RenderStepped:Connect(function(step)
	--pcall(function()
		oblivion.step, oblivion.ping = step, game.Stats.PerformanceStats.Ping:GetValue()
		local localplayeral = IsAlive(environment.LocalPlayer)
		local visible_players = {}

		for _, player in pairs(environment.Players:GetPlayers()) do
			if player ~= environment.LocalPlayer then
				if localplayeral and (ui_source.Flags["esp_enemy_enable"].Value and ui_source.Flags["esp_visible_only"].Value or ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_visible_only"].Value) then
					if oblivion.lists.visible_player_cache[player].reset ~= 0 then
						oblivion.lists.visible_player_cache[player].reset -= 1
						visible_players[player] = oblivion.lists.visible_player_cache[player].state
					end
					if oblivion.lists.visible_player_cache[player].reset == 0 then
						local part = IsAlive(player) and CanSeePlayer(player, Hitboxes) or false
						if part then
							oblivion.lists.visible_player_cache[player].state, oblivion.lists.visible_player_cache[player].reset, visible_players[player] = part, 5, part
						else
							oblivion.lists.visible_player_cache[player].state, oblivion.lists.visible_player_cache[player].reset, visible_players[player] = false, 3, false
						end
					end
				end

				local val3 = (ui_source.Flags["esp_whitelist_only"].Value and TableContains(ui_source.Flags["esp_whitelist"].Options, player.Name) or not ui_source.Flags["esp_whitelist_only"].Value and (#ui_source.Flags["esp_whitelist"].Options == 1 or TableContains(ui_source.Flags["esp_whitelist"].Options, player.Name)))
				if localplayeral and ui_source.Flags["esp_enemy_enable"].Value then
					if IsAlive(player) and (ui_source.Flags["esp_whitelist_only"].Value and TableContains(ui_source.Flags["esp_whitelist"].Options, player.Name) or not ui_source.Flags["esp_whitelist_only"].Value and (#ui_source.Flags["esp_whitelist"].Options == 1 or TableContains(ui_source.Flags["esp_whitelist"].Options, player.Name))) and (not ui_source.Flags["esp_visible_only"].Value or ui_source.Flags["esp_visible_only"].Value and visible_players[player]) and (ui_source.Flags["esp_team_enable"].Value or GetTeam(environment.LocalPlayer) ~= GetTeam(player)) then
						esp.whitelist[player] = false
					else
						esp.whitelist[player] = true
					end
				else
					if IsAlive(player) and DistanceFromPlayer(player) > 5 and (ui_source.Flags["esp_whitelist_only"].Value and TableContains(ui_source.Flags["esp_whitelist"].Options, player.Name) or not ui_source.Flags["esp_whitelist_only"].Value and (#ui_source.Flags["esp_whitelist"].Options == 1 or TableContains(ui_source.Flags["esp_whitelist"].Options, player.Name))) then
						esp.whitelist[player] = false
					else
						esp.whitelist[player] = true
					end
				end
			end
		end

        if localplayeral and environment.Workspace:FindFirstChild("Status") and environment.Workspace.Status:FindFirstChild("Preparation") and not environment.Workspace.Status.Preparation.Value and environment.Workspace.Status:FindFirstChild("RoundOver") and not environment.Workspace.Status.RoundOver.Value and ui_source.Flags["aimbot_enemy_enable"].Value then
			local closestDistance, closestPart, closestPlayer = math.huge, nil, nil
			for _, player in pairs(environment.Players:GetPlayers()) do
				local character = ReturnCharacter(player)
				local part = character and (ui_source.Flags["aimbot_force_hit"].Value and (ui_source.Flags["aimbot_preference"].Value == "Head" and character:FindFirstChild("Head") or ui_source.Flags["aimbot_preference"].Value == "Humanoid" and character:FindFirstChild("HumanoidRootPart")) or (ui_source.Flags["aimbot_preference"].Value == "Head" and (character:FindFirstChild("FakeHead") and character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")) or ui_source.Flags["aimbot_preference"].Value == "Humanoid" and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("FakeHead") and character:FindFirstChild("Head")))) or nil
				if character and part and (ui_source.Flags["aimbot_whitelist_only"].Value and TableContains(ui_source.Flags["aimbot_whitelist"].Options, player.Name) or not ui_source.Flags["aimbot_whitelist_only"].Value and (#ui_source.Flags["aimbot_whitelist"].Options == 1 or TableContains(ui_source.Flags["aimbot_whitelist"].Options, player.Name))) and (ui_source.Flags["aimbot_team_enable"].Value or GetTeam(environment.LocalPlayer) ~= GetTeam(player)) and WithinFOV(environment.CurrentCamera.CFrame, part) then
					local vector = environment.CurrentCamera:WorldToScreenPoint(part.Position)
					local distance = (Vector2.new(environment.Mouse.X, environment.Mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
					if distance < closestDistance and (not ui_source.Flags["aimbot_fov_enable"].Value or (ui_source.Flags["aimbot_fov_radius"].Value == 0 or distance < ui_source.Flags["aimbot_fov_radius"].Value)) and (not ui_source.Flags["aimbot_visible_only"].Value or visible_players[player]) then
						closestDistance, closestPart, closestPlayer = distance, part, player
					end
				end
			end
			if closestPart then
				oblivion.values.aimbot.reset, oblivion.values.aimbot.delay, oblivion.values.aimbot.player, oblivion.values.aimbot.part = ui_source.Flags["aimbot_memory"].Value == 0 and 1 or ui_source.Flags["aimbot_memory"].Value, oblivion.values.aimbot.player == oblivion.values.aimbot.lastplayer and oblivion.values.aimbot.delay or ui_source.Flags["aimbot_delay"].Value, closestPlayer, closestPart
				oblivion.values.aimbot.lastplayer = oblivion.values.aimbot.player
			end
			if not closestPart and (oblivion.values.aimbot.player or oblivion.values.aimbot.part) then
				if oblivion.values.aimbot.reset ~= 0 and IsAlive(oblivion.values.aimbot.player) then
					closestPart = oblivion.values.aimbot.part
					oblivion.values.aimbot.reset -= 1
				else
					oblivion.values.aimbot.player, oblivion.values.aimbot.part, oblivion.values.aimbot.delay = nil, nil, 0
				end
			end
			if (oblivion.values.aimbot.player or oblivion.values.aimbot.part) and oblivion.values.aimbot.delay ~= 0 then
				oblivion.values.aimbot.delay -= 1
			end
			if closestPart and oblivion.values.aimbot.delay == 0 then
				if ui_source.Flags["aimbot_type"].Value == "Smooth" then
					local position = environment.CurrentCamera:WorldToScreenPoint(closestPart.Position)
					local magnitude = Vector2.new(position.X - environment.Mouse.X, position.Y - environment.Mouse.Y)
					syn.mousemoverel(magnitude.x / ui_source.Flags["aimbot_smoothness"].Value, magnitude.y / ui_source.Flags["aimbot_smoothness"].Value)
				elseif ui_source.Flags["aimbot_type"].Value == "Lock" then
					environment.CurrentCamera.CFrame = CFrame.new(environment.CurrentCamera.CFrame.Position, closestPart.Position)
				end
			end
			if closestPart and ui_source.Flags["aimbot_triggerbot"].Value then
				local vector = environment.CurrentCamera:WorldToScreenPoint(closestPart.Position)
				local distance = (Vector2.new(environment.Mouse.X, environment.Mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
				if (not ui_source.Flags["aimbot_triggerbot_fov"].Value or (ui_source.Flags["aimbot_triggerbot_fov_radius"].Value == 0 or distance < ui_source.Flags["aimbot_triggerbot_fov_radius"].Value)) then
					if oblivion.values.aimbot.triggerbot.state then
						local found, gun_name = KnifeOrGun() == "gun", GetGunName()
						if oblivion.values.aimbot.triggerbot.delay == 0 and found and oblivion.values.aimbot.triggerbot.shoot == 0 then
							local shoot_delay = ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value ~= "-" and (ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value == "3/4" and 75 or ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value == "1/2" and 50 or ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value == "1/4" and 25) or 100
							oblivion.values.aimbot.rayfilter, oblivion.values.aimbot.triggerbot.shoot = true, ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value ~= "-" and gun_name and (oblivion.lists.weapon_data.guns[gun_name].data.triggerbot_delay / 100 * shoot_delay) or 0
							for i = 0, ui_source.Flags["aimbot_triggerbot_custom_tap"].Value do
								oblivion.client.firebullet()
							end
							oblivion.values.aimbot.rayfilter = false
						elseif oblivion.values.aimbot.triggerbot.delay ~= 0 then
							oblivion.values.aimbot.triggerbot.delay -= 1
						end
					else
						oblivion.values.aimbot.triggerbot.state, oblivion.values.aimbot.triggerbot.delay = true, ui_source.Flags["aimbot_triggerbot_delay"].Value
					end
				else
					oblivion.values.aimbot.triggerbot.state = false
				end
			end
		elseif oblivion.values.aimbot.reset ~= 0 then
			oblivion.values.aimbot.reset, oblivion.values.aimbot.delay, oblivion.values.aimbot.player, oblivion.values.aimbot.part = 0, 0, nil, nil
        end

		if oblivion.values.aimbot.triggerbot.shoot ~= 0 then
			oblivion.values.aimbot.triggerbot.shoot -= 1
		end

		if ui_source.Flags["qol_infinite_ammo"].Value ~= "-" and localplayeral then
			local gun_name = GetGunName()
			if gun_name and ui_source.Flags["qol_infinite_ammo"].Value == "Mag" and oblivion.lists.weapon_data.guns[gun_name].data.type == "primary" then
				oblivion.client.ammocount = oblivion.lists.weapon_data.guns[gun_name].data.clip
			elseif gun_name and ui_source.Flags["qol_infinite_ammo"].Value == "Mag" and oblivion.lists.weapon_data.guns[gun_name].data.type == "secondary" then
				oblivion.client.ammocount2 = oblivion.lists.weapon_data.guns[gun_name].data.clip
			elseif gun_name and ui_source.Flags["qol_infinite_ammo"].Value == "Reserve" and oblivion.lists.weapon_data.guns[gun_name].data.type == "primary" then
				oblivion.client.primarystored = oblivion.lists.weapon_data.guns[gun_name].data.ammo
			elseif gun_name and ui_source.Flags["qol_infinite_ammo"].Value == "Reserve" and oblivion.lists.weapon_data.guns[gun_name].data.type == "secondary" then
				oblivion.client.secondarystored = oblivion.lists.weapon_data.guns[gun_name].data.ammo
			end
		end

		if ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_fov_enable"].Value and oblivion.fov.Visible ~= localplayeral then
			oblivion.fov.Visible = localplayeral
		elseif not ui_source.Flags["aimbot_enemy_enable"].Value or not ui_source.Flags["aimbot_fov_enable"].Value then
			oblivion.fov.Visible = false
		end

		if ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_triggerbot_fov"].Value and oblivion.triggerbot_fov.Visible ~= localplayeral then
			oblivion.triggerbot_fov.Visible = localplayeral
		elseif not ui_source.Flags["aimbot_enemy_enable"].Value or not ui_source.Flags["aimbot_triggerbot_fov"].Value then
			oblivion.triggerbot_fov.Visible = false
		end

		if ui_source.Flags["qol_bullet_remove"].Value then
			if not oblivion.values.createbullethole then
				oblivion.values.createbullethole = oblivion.client.createbullethole
			end
			oblivion.client.createbullethole = function()
				return
			end
		elseif oblivion.values.createbullethole then
			oblivion.client.createbullethole = oblivion.values.createbullethole
		end

		if ui_source.Flags["qol_blood_remove"].Value then
			if not oblivion.values.splatterblood then
				oblivion.values.splatterblood = oblivion.client.splatterBlood
			end
			oblivion.client.splatterBlood = function()
				return
			end
		elseif oblivion.values.splatterblood then
			oblivion.client.splatterBlood = oblivion.values.splatterblood
		end

		if ui_source.Flags["qol_anti_afk"].Value then
			for _, v in pairs(syn.getconnections(environment.LocalPlayer.Idled)) do
				v:Disable()
			end
		end
	--end)
end)

syn.hookfunc(syn.getrenv().xpcall, function() end)
local mt = syn.getrawmetatable(game)
if syn.setreadonly then syn.setreadonly(mt, false) else syn.make_writeable(mt, true) end

oblivion.oldnamecall = syn.hookfunc(mt.__namecall, syn.newcclosure(function(self, ...)
    local method, callingscript, args = syn.getnamecallmethod(), syn.getcallingscript(), {...}

	if method == "Kick" then
		return
	elseif method == "FireServer" then
		if string.len(self.Name) == 38 then
			return wait(99e99)
		elseif self.Name == "test" then
			return wait(99e99)
		elseif self.Name == "HitPart" then
			if ui_source.Flags["aimbot_force_hit"].Value and oblivion.values.aimbot.part and oblivion.values.aimbot.delay == 0 then
				args[1] = oblivion.values.aimbot.part
				args[2] = oblivion.values.aimbot.part.Position
			end

			coroutine.wrap(function()
				if not syn.checkcaller() and ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_prediction"].Value ~= "-" and oblivion.values.aimbot.player and args[1] == oblivion.values.aimbot.part then
					if ui_source.Flags["aimbot_prediction"].Value == "CFrame" then
						local velocity = (oblivion.values.aimbot.part.Parent.HumanoidRootPart.Position - oblivion.values.aimbot.part.Parent.HumanoidRootPart.OldPosition.Value) / oblivion.step
						local direction = Vector3.new(velocity.X / velocity.magnitude, 0, velocity.Z / velocity.magnitude)
						if velocity.magnitude >= 8 then
							args[2] = args[2] + direction * (velocity.magnitude * (oblivion.ping / 1000) * (oblivion.ping > 200 and 1.5 or 2))
							args[4] = 0
							args[12] = args[12] - 500
						end
					elseif ui_source.Flags["aimbot_prediction"].Value == "Velocity" then
						local velocity = oblivion.values.aimbot.part.Parent.HumanoidRootPart.Velocity
						local direction = Vector3.new(velocity.X / velocity.magnitude, 0, velocity.Z / velocity.magnitude)
						if velocity.magnitude >= 8 then
							args[2] = args[2] + direction * (velocity.magnitude * (oblivion.ping / 1000) * (oblivion.ping > 200 and 1.5 or 2))
							args[4] = 0
							args[12] = args[12] - 500
						end
					end
				end
			end)()

			coroutine.wrap(function()
				local player = args[1].Parent and environment.Players:FindFirstChild(args[1].Parent.Name)
				if player and ui_source.Flags["qol_hit_sound"].Value ~= "-" and GetTeam(player) and GetTeam(environment.LocalPlayer) ~= GetTeam(player) then
					oblivion.values.sound = Instance.new("Sound", environment.Workspace)
					oblivion.values.sound.Volume, oblivion.values.sound.PlayOnRemove, oblivion.values.sound.SoundId = (ui_source.Flags["qol_hit_sound_volume"].Value / 100), true, oblivion.lists.hit_sounds[ui_source.Flags["qol_hit_sound"].Value]
					oblivion.values.sound:Destroy()
				end
			end)()
		end
	elseif method == "InvokeServer" then
		if self.Name == "Moolah" then
			return wait(99e99)
		end
	elseif method == "FindPartOnRayWithIgnoreList" and args[2][1] == environment.Workspace.Debris and ((not syn.checkcaller() or oblivion.values.aimbot.rayfilter) and ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_type"].Value == "Silent") and oblivion.values.aimbot.player and oblivion.values.aimbot.part and oblivion.values.aimbot.delay == 0 then
		args[1] = Ray.new(environment.CurrentCamera.CFrame.Position, (oblivion.values.aimbot.part.Position - environment.CurrentCamera.CFrame.Position).unit * (environment.ReplicatedStorage.Weapons[environment.LocalPlayer.Character.EquippedTool.Value].Range.Value * 0.1))
	end

	return oblivion.oldnamecall(self, unpack(args))
end))

local save = filesys.readfile("Oblivion/CB/auto_load.cfg")
if save ~= "" then LoadFlags(save) end

oblivion.ran = true
EditDropdowns()
RefreshFlags()
