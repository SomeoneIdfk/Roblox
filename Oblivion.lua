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
	hookmetamethod = hookmetamethod or nil,
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
	ContentProvider = game:GetService('ContentProvider'),
	Chat = game:GetService("Chat")
}, {
    env_err = false,
    ran = false,
    lists = {tagged = {}, textures = {}, visible_player_cache = {}, enemies = {}, teammates = {}, everyone = {}, hit_sounds = {Bameware = "rbxassetid://3124331820", Bell = "rbxassetid://6534947240", Bubble = "rbxassetid://6534947588", Pick = "rbxassetid://1347140027", Pop = "rbxassetid://198598793", Rust = "rbxassetid://1255040462", Skeet = "rbxassetid://5633695679", Neverlose = "rbxassetid://6534948092", Minecraft = "rbxassetid://4018616850"}, weapon_data = loadstring("return "..game:HttpGet('https://raw.githubusercontent.com/SomeoneIdfk/Roblox/main/Weapon_Data.cfg'))(), weapon_types = loadstring("return "..game:HttpGet('https://raw.githubusercontent.com/SomeoneIdfk/Roblox/main/Weapon_Types.cfg'))(), ignore_flags = {"aimbot_whitelist", "aimbot_add_player", "esp_whitelist", "esp_add_player", "settings_profile"}, penetration_multipliers = {Head = 4, FakeHead = 4, HeadHB = 4, UpperTorso = 1, LowerTorso = 1.25, LeftUpperArm = 1, LeftLowerArm = 1, LeftHand = 1, RightUpperArm = 1, RightLowerArm = 1, RightHand = 1, LeftUpperLeg = 0.75, LeftLowerLeg = 0.75, LeftFoot = 0.75, RightUpperLeg = 0.75, RightLowerLeg = 0.75, RightFoot = 0.75}},
    values = {map = nil, splatterblood = nil, createbullethole = nil, aimbot = {player = nil, lastplayer = nil, part = nil, reset = 0, delay = 0, rayfilter = false, triggerbot = {state = false, delay = 0, shoot = 0}}, bodyvelocity = Instance.new("BodyVelocity"), defaultgravity = game:GetService("Workspace").Gravity, sound = nil},
	client = nil,
	fov = Drawing.new("Circle"),
	triggerbot_fov = Drawing.new("Circle"),
	oldnamecall = nil,
	oldindex = nil,
	displaychat = nil,
	createnewmessage = nil,
	step = nil,
	ping = nil,
	config_name = nil,
	more_gun_mods = false
}

for i, v in ipairs(filesys) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
for i, v in ipairs(syn) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
for i, v in ipairs(environment) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
if oblivion.env_err then return end

if not (filesys.isfolder("Oblivion") and filesys.isfolder("Oblivion/CB") and filesys.isfolder("Oblivion/CB/Profiles")) then filesys.makefolder("Oblivion") filesys.makefolder("Oblivion/CB") filesys.makefolder("Oblivion/CB/Profiles") end
if not filesys.isfile("Oblivion/CB/tagged.cfg") then filesys.writefile("Oblivion/CB/tagged.cfg", environment.HttpService:JSONEncode({})) end
if not filesys.isfile("Oblivion/CB/auto_load.cfg") then filesys.writefile("Oblivion/CB/auto_load.cfg", "") end
if not filesys.isfile("Oblivion/CB/messages.txt") then filesys.writefile("Oblivion/CB/messages.txt", "Message Logs") end

oblivion.lists.tagged = environment.HttpService:JSONDecode(filesys.readfile("Oblivion/CB/tagged.cfg"))

-- Preparation
repeat wait() until environment.Workspace:FindFirstChild("Map") and environment.Workspace.Map:FindFirstChild("Origin")
oblivion.client, oblivion.displaychat, oblivion.fov.Thickness, oblivion.triggerbot_fov.Thickness = syn.getsenv(environment.LocalPlayer.PlayerGui:WaitForChild("Client")), syn.getsenv(environment.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat), 2, 2
oblivion.createnewmessage = oblivion.displaychat.createNewMessage

local ui_source = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local ui = ui_source:MakeWindow({Name = "Oblivion", HidePremium = true, SaveConfig = false, ConfigFolder = "", IntroEnabled = true, IntroText = "Oblivion", IntroIcon = "rbxassetid://4335489513"})

ui_source:MakeNotification({Name = "Oblivion", Content = "Loading script.", Image = "rbxassetid://4400702947", Time = 3})

local esp = loadstring(game:HttpGet('https://raw.githubusercontent.com/SomeoneIdfk/Roblox/main/Esp.lua'))()

esp.teamSettings = {enemy = {enabled = false, box = true, boxColor = { Color3.new(1,0,0), 1 }, boxOutline = false, boxOutlineColor = { Color3.new(), 1 }, boxFill = false, boxFillColor = { Color3.new(1,0,0), 0.5 }, healthBar = false, healthyColor = Color3.new(0,1,0), dyingColor = Color3.new(1,0,0), healthBarOutline = false, healthBarOutlineColor = { Color3.new(), 1 }, healthText = false, healthTextColor = { Color3.new(1,1,1), 1 }, healthTextOutline = false, healthTextOutlineColor = Color3.new(), name = false, nameColor = { Color3.new(1,1,1), 1 }, nameOutline = false, nameOutlineColor = Color3.new(), weapon = false, weaponColor = { Color3.new(1,1,1), 1 }, weaponOutline = false, weaponOutlineColor = Color3.new(), distance = false, distanceColor = { Color3.new(1,1,1), 1 }, distanceOutline = false, distanceOutlineColor = Color3.new(), tracer = false, tracerOrigin = "Bottom", tracerColor = { Color3.new(1,0,0), 1 }, tracerOutline = false, tracerOutlineColor = { Color3.new(), 1 }, offScreenArrow = false, offScreenArrowColor = { Color3.new(1,1,1), 1 }, offScreenArrowSize = 15, offScreenArrowRadius = 150, offScreenArrowOutline = false, offScreenArrowOutlineColor = { Color3.new(), 1 }, chams = false, chamsVisibleOnly = false, chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 }, chamsOutlineColor = { Color3.new(1,0,0), 0 }}, friendly = { enabled = false, box = true, boxColor = { Color3.new(0,1,0), 1 }, boxOutline = false, boxOutlineColor = { Color3.new(), 1 }, boxFill = false, boxFillColor = { Color3.new(0,1,0), 0.5 }, healthBar = false, healthyColor = Color3.new(0,1,0), dyingColor = Color3.new(1,0,0), healthBarOutline = false, healthBarOutlineColor = { Color3.new(), 1 }, healthText = false, healthTextColor = { Color3.new(1,1,1), 1 }, healthTextOutline = false, healthTextOutlineColor = Color3.new(), name = false, nameColor = { Color3.new(1,1,1), 1 }, nameOutline = false, nameOutlineColor = Color3.new(), weapon = false, weaponColor = { Color3.new(1,1,1), 1 }, weaponOutline = false, weaponOutlineColor = Color3.new(), distance = false, distanceColor = { Color3.new(1,1,1), 1 }, distanceOutline = false, distanceOutlineColor = Color3.new(), tracer = false, tracerOrigin = "Bottom", tracerColor = { Color3.new(0,1,0), 1 }, tracerOutline = false, tracerOutlineColor = { Color3.new(), 1 }, offScreenArrow = false, offScreenArrowColor = { Color3.new(1,1,1), 1 }, offScreenArrowSize = 15, offScreenArrowRadius = 150, offScreenArrowOutline = false, offScreenArrowOutlineColor = { Color3.new(), 1 }, chams = false, chamsVisibleOnly = false, chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 }, chamsOutlineColor = { Color3.new(0,1,0), 0 }}}

local Hitboxes = {"Head", "UpperTorso", "LeftUpperArm", "RightUpperArm", "LeftFoot", "RightFoot", "LeftHand", "RightHand"}
local RadioText = {
	"Go!",
	"Fall back!",
	"Stick together team.",
	"You take the point.",
	"Hold this position.",
	"Follow me.",
	"Affirmative.",
	"Negative.",
	"Cheer!",
	"Nice!",
	"Thanks.",
	"Enemy spotted!",
	"Need backup!",
	"You take the point.",
	"Sector clear.",
	"I'm in position."
}

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
		if i == 1 or i == 2 and v ~= value or i == 3 and i ~= value then temp[#temp + 1] = v end
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
			if v.Value ~= v.Default then
				save[i] = v.Value
			end
		end
	end
	filesys.writefile("Oblivion/CB/Profiles/"..name..".cfg", environment.HttpService:JSONEncode(save))
	RefreshFlags()
end

local function LoadFlags(name)
	if not (name or filesys.isfile("Oblivion/CB/Profiles/"..name..".cfg")) then RefreshFlags() return; end
	local save, error1, error2 = environment.HttpService:JSONDecode(filesys.readfile("Oblivion/CB/Profiles/"..name..".cfg")), false, false
	for i, v in pairs(save) do
		coroutine.wrap(function()
			local succes, result = pcall(function()
				if ui_source.Flags[i] then
					ui_source.Flags[i]:Set(v)
				else
					error2 = true
				end
			end)
			if not succes then
				error1 = true
				print("Error loading; "..tostring(result))
			end
		end)()
	end
	print("Loaded config; "..tostring(name))
	ui_source:MakeNotification({Name = "Oblivion", Content = not error1 and "Succesfully loaded profile "..name.."." or not error2 and "Not all values in the profile of "..name.." could be applied." or "Some values might be corrupted in the profile of "..name..".", Image = not error1 and "rbxassetid://4384403532" or "rbxassetid://4384402990", Time = 10})
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
	local succes, blacklist = pcall(function()
		return {environment.CurrentCamera, environment.Workspace.Ray_Ignore, environment.Workspace.Debris, environment.Workspace.Map.Clips, environment.Workspace.Map.SpawnPoints, localplayer, character.HumanoidRootPart};
	end)
	if not succes then return false; end
	if not WithinFOV(origin, character.HumanoidRootPart) then return false; end
	for _, v in ipairs(hitboxes) do
		local part = character:FindFirstChild(v) and character[v] or nil
		if part then
			local ray = Ray.new(origin.Position, (part.Position - origin.Position).unit * (part.Position - origin.Position).magnitude)
			local hit, pos = environment.Workspace:FindPartOnRayWithIgnoreList(ray, blacklist, false, true)
			if hit and hit:FindFirstAncestor(player.Name) then
				return hit;
			end
		end
	end
	return false;
end

local function PenetrationTest(player, part)
	local character, localplayer = ReturnCharacter(player), environment.LocalPlayer.Character
	if not character then return false; end
	local origin = environment.CurrentCamera.CFrame
	local succes, blacklist = pcall(function()
		return {environment.CurrentCamera, environment.Workspace.Ray_Ignore, environment.Workspace.Debris, environment.Workspace.Map.Clips, environment.Workspace.Map.SpawnPoints, localplayer, character.HumanoidRootPart};
	end)
	if not succes then return false; end
	if not WithinFOV(origin, character.HumanoidRootPart) then return false; end
	local hits, hit, ray = {}, {start = nil, stop = nil, position = nil}, Ray.new(origin.Position, (part.Position - origin.Position).unit * (part.Position - origin.Position).magnitude)
	local succes, penetration = pcall(function()
		return oblivion.client.gun.Penetration.Value * 0.01;
	end)
	if not succes then return false; end
	repeat
		hit.start, hit.position = environment.Workspace:FindPartOnRayWithIgnoreList(ray, blacklist, false, true)
		if hit.start and hit.start.Parent then
			if hit.start and oblivion.lists.penetration_multipliers[hit.start.Name] then
				hit.stop = hit.start
			else
				blacklist[#blacklist + 1] = hit.start
				hits[#hits + 1] = {hit = hit.start, position = hit.position}
			end
		end
	until not hit.start or hit.stop or #hits >= 4
	--print(tostring(#hits))
	if hit.stop and oblivion.lists.penetration_multipliers[hit.stop.Name] and #hits <= 4 then
		--print("true "..tostring(#hits))
		local limit, damage_multiplier = 0, 1
		--print(tostring(damage_multiplier))
		for _, v in ipairs(hits) do
			local hit_part = {part = v.hit, position = v.position}
			local modifier = 1
			if hit_part.part.Material == Enum.Material.DiamondPlate then
				modifier = 3
			elseif hit_part.part.Material == Enum.Material.CorrodedMetal or hit_part.part.Material == Enum.Material.Metal or hit_part.part.Material == Enum.Material.Brick or hit_part.part.Material == Enum.Material.Concrete then
				modifier = 2
			elseif hit_part.part.Name == "Grate" or hit_part.part.Material == Enum.Material.Wood or hit_part.part.Material == Enum.Material.WoodPlanks then
				modifier = 0.1
			elseif hit_part.part.Name == "nowallbang" then
				modifier = 100
			elseif hit_part.part.Transparency == 1 or not hit_part.part.CanCollide or hit_part.part.Name == "Glass" or hit_part.part.Name == "Cardboard" then
				modifier = 0
			end
			if part:FindFirstChild("PartModifier") then
				modifier = part.PartModifier.Value
			end
			local direction = (part.Position - hit_part.position).unit * math.clamp(oblivion.client.gun.Range.Value, 1, 100)
			ray = Ray.new(hit_part.position + direction * 1, direction * -2)
			local _, pos = environment.Workspace:FindPartOnRayWithWhitelist(ray, {hit_part.part}, true)
			local thickness = (pos - hit_part.position).magnitude
			thickness = thickness * modifier
			limit = math.min(penetration, limit + thickness)
			damage_multiplier = 1 - limit / penetration
			--print(tostring(damage_multiplier))
		end
		local damage = oblivion.client.gun.DMG.Value * oblivion.lists.penetration_multipliers[hit.stop.Name] * damage_multiplier
		if player:FindFirstChild("Kevlar") then
			if string.find(hit.stop.Name, "Head") then
				if player:FindFirstChild("Helmet") then
					damage = (damage / 100) * oblivion.client.gun.ArmorPenetration.Value
				end
			else
				damage = (damage / 100) * oblivion.client.gun.ArmorPenetration.Value
			end
		end
		damage = damage * (oblivion.client.gun.RangeModifier.Value / 100 ^ ((origin.Position - hit.stop.Position).Magnitude / 500)) / 100
		--print(tostring(damage).." >= "..tostring(ui_source.Flags["aimbot_penetration_minimum_damage"].Value).." = "..tostring(damage >= ui_source.Flags["aimbot_penetration_minimum_damage"].Value))
		return damage >= ui_source.Flags["aimbot_penetration_minimum_damage"].Value;
	end
	return false;
end

local function KnifeOrGun()
	local tool, result = IsAlive(environment.LocalPlayer) and environment.LocalPlayer.Character.EquippedTool.Value or nil, nil
	if not tool then return "unknown"; end
	local succes, output = pcall(function()
		if oblivion.client.gun:FindFirstChild("Melee") then return "knife"; end
	end)
	if succes then return output; end
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
	ui_source.Flags["rage_killall_add_player"]:Refresh(temp3, true)

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

			index = TableContains(ui_source.Flags["rage_killall_whitelist"].Options, name)
			if index then
				ui_source.Flags["rage_killall_whitelist"]:Refresh(TableRebuild(ui_source.Flags["rage_killall_whitelist"].Options, 2, name), true)
			end
		elseif reason == 2 then
			--[[local temp4 = TableRebuild(ui_source.Flags["whitelist"].Options)
			for _, v in ipairs(temp4) do
				if v ~= "-" and not TableContains(temp1, v) then
					temp4 = TableRebuild(temp4, 2, v)
				end
			end
			ui_source.Flags["whitelist"]:Refresh(temp4, true)]]
		end
	end
end

local function PlayerFunctions(character)
	if not character then return; end
	pcall(function()
		if ui_source.Flags["rage_anti_anti_aim_pitch"].Value == true then
			character.UpperTorso.Waist.C0 = CFrame.Angles(0, 0, 0)
			character.LowerTorso.Root.C0 = CFrame.Angles(0, 0, 0)
			character.Head.Neck.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(0, 0, 0)
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
				Value.Value = Position
				Value.Parent = character.HumanoidRootPart
			end
		end
	end)
end

local function LocalplayerFunctions(character)
	if not character then return; end
	pcall(function()
		if ui_source.Flags["visuals_third_person"].Value then
			environment.LocalPlayer.CameraMaxZoomDistance = ui_source.Flags["visuals_third_person_distance"].Value
			environment.LocalPlayer.CameraMinZoomDistance = ui_source.Flags["visuals_third_person_distance"].Value
		else
			environment.LocalPlayer.CameraMaxZoomDistance = 0
			environment.LocalPlayer.CameraMinZoomDistance = 0
		end
		oblivion.values.bodyvelocity:Destroy()
		oblivion.values.bodyvelocity = Instance.new("BodyVelocity")
		oblivion.values.bodyvelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
		if ui_source.Flags["rage_bhop_type"].Value ~= "None" and environment.UserInputService:IsKeyDown("Space") then
			local add = 0
			if environment.UserInputService:IsKeyDown("A") then add = 90 end if environment.UserInputService:IsKeyDown("S") then add = 180 end if environment.UserInputService:IsKeyDown("D") then add = 270 end if environment.UserInputService:IsKeyDown("A") and environment.UserInputService:IsKeyDown("W") then add = 45 end if environment.UserInputService:IsKeyDown("D") and environment.UserInputService:IsKeyDown("W") then add = 315 end if environment.UserInputService:IsKeyDown("D") and environment.UserInputService:IsKeyDown("S") then add = 225 end if environment.UserInputService:IsKeyDown("A") and environment.UserInputService:IsKeyDown("S") then add = 145 end
			local x, y, z = environment.CurrentCamera.CFrame:ToOrientation()
			local rot = (CFrame.new(environment.CurrentCamera.CFrame.p) * CFrame.Angles(0, y, 0)) * CFrame.Angles(0, math.rad(add), 0)
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
			PlayerFunctions(character)
		end)
		repeat
			wait()
		until not environment.Players:FindFirstChild(player.Name) or not IsAlive(player) or character and character:FindFirstChild("Humanoid")
		repeat
			wait()
		until not environment.Players:FindFirstChild(player.Name) or not IsAlive(player)
		renderstepper:Disconnect()
	end)
	coroutine.wrap(function()
		local character = ReturnCharacter(player)
		if character then
			local renderstepper = environment.RunService.RenderStepped:Connect(function()
				PlayerFunctions(character)
			end)
			repeat
				wait()
			until not environment.Players:FindFirstChild(player.Name) or not IsAlive(player) or character and character:FindFirstChild("Humanoid")
			repeat
				wait()
			until not environment.Players:FindFirstChild(player.Name) or not IsAlive(player)
			renderstepper:Disconnect()
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

local function WarmupCheck()
	return environment.ReplicatedStorage.gametype.Value == "casual" and (environment.Workspace.Status.TWins.Value == 0 and environment.Workspace.Status.CTWins.Value == 0 and environment.Workspace.Status.Rounds.Value ~= 1) or false;
end

local function ParseTextLabel(text, colour)
	local textlabel = Instance.new("TextLabel", environment.LocalPlayer.PlayerGui.GUI.Main.Chats)
	textlabel.Name = "Line1"
	textlabel.BackgroundTransparency = 1
	textlabel.BorderSizePixel = 0
	textlabel.Size = UDim2.new(0, 590, 0, 30)
	textlabel.Position = UDim2.new(0.01, 0, 0, 147)
	textlabel.TextColor3 = colour
	textlabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	textlabel.TextStrokeTransparency = textlabel.TextTransparency
	textlabel.TextWrapped = false
	textlabel.Font = "ArialBold"
	textlabel.FontSize = "Size14"
	textlabel.TextXAlignment = "Left"
	textlabel.Text = text
	textlabel.Size = UDim2.new(0, textlabel.TextBounds.X + 1, 0, 30)
	return textlabel;
end

local function RandomPlayer(alive)
	local player, timeout = nil, os.time() + 1
	repeat
		local list = environment.Players:GetPlayers()
		local random = list[math.random(1, #list)]
		if random ~= environment.LocalPlayer and (alive and IsAlive(random) and random.Character:FindFirstChild("Head") or not alive) then player = random; end
	until player or os.time() >= timeout
	return player.Name or environment.LocalPlayer.Name;
end

local function Preparation(timer_check)
	if environment.Workspace:FindFirstChild("Status") and environment.Workspace.Status:FindFirstChild("Preparation") and environment.Workspace.Status:FindFirstChild("Timer") then
		if timer_check then
			local number = oblivion.ping <= 100 and 1 or oblivion.ping <= 200 and 2 or oblivion.ping <= 300 and 3 or 5
			return environment.Workspace.Status.Preparation.Value and environment.Workspace.Status.Timer.Value > number or false;
		elseif not timer_check then
			return environment.Workspace.Status.Preparation.Value;
		end
	end
	return true;
end

-- UI
local tabs = {
    aimbot = ui:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
	rage = ui:MakeTab({Name = "Rage", Icon = "rbxassetid://3944668821", PremiumOnly = false}),
	visuals = ui:MakeTab({Name = "Visuals", Icon = "rbxassetid://10802202912", PremiumOnly = false}),
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
		antiantiaim = tabs.rage:AddSection({Name = "Anti Anti-Aim"}),
		killall = tabs.rage:AddSection({Name = "Kill All"}),
		misc = tabs.rage:AddSection({Name = "Misc"})
	},
	visuals = {
		thirdperson = tabs.visuals:AddSection({Name = "Third Person"}),
		tracers = tabs.visuals:AddSection({Name = "Tracers"}),
		impacts = tabs.visuals:AddSection({Name = "Impacts"})
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
		gun_mods = tabs.qol:AddSection({Name = "Gun Mods"}),
		damage = tabs.qol:AddSection({Name = "Damage"}),
		chat = tabs.qol:AddSection({Name = "Chat"}),
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
sections.aimbot.main:AddDropdown({Name = "Prediction", Default = "-", Options = {"-", "CFrame 1", "CFrame 2", "Velocity"}, Flag = "aimbot_prediction"})
sections.aimbot.main:AddToggle({Name = "Penetration Test", Default = false, Flag = "aimbot_penetration_test"})
sections.aimbot.main:AddSlider({Name = "Minimum Damage", Min = 0, Max = 100, Default = 20, Color3.fromRGB(0, 0, 0), Increment = 1, Flag = "aimbot_penetration_minimum_damage"})
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
sections.rage.killall:AddToggle({Name = "Enable", Default = false, Flag = "rage_killall_enemy_enable"})
sections.rage.killall:AddToggle({Name = "Team", Default = false, Flag = "rage_killall_team_enable"})
sections.rage.killall:AddToggle({Name = "Visible Only", Default = false, Flag = "rage_killall_visible_only"})
sections.rage.killall:AddToggle({Name = "Whitelist Only", Default = false, Flag = "rage_killall_whitelist_only"})
sections.rage.killall:AddDropdown({Name = "Whitelist Remove", Default = "-", Options = {"-"}, Flag = "rage_killall_whitelist", Callback = function(state)
	if state ~= "-" then
		ui_source.Flags["rage_killall_whitelist"]:Set("-")
		ui_source.Flags["rage_killall_whitelist"]:Refresh(TableRebuild(ui_source.Flags["rage_killall_whitelist"].Options, 2, state), true)
	end end})
sections.rage.killall:AddDropdown({Name = "Whitelist Add", Default = "-", Options = {"-"}, Flag = "rage_killall_add_player", Callback = function(state)
	if state ~= "-" then
		ui_source.Flags["rage_killall_add_player"]:Set("-")
		if not TableContains(ui_source.Flags["rage_killall_whitelist"].Options, state) then
			ui_source.Flags["rage_killall_whitelist"]:Refresh(TableRebuild(ui_source.Flags["rage_killall_whitelist"].Options, 1, state), true)
		end end end})
sections.rage.killall:AddDropdown({Name = "Weapon", Default = "-", Options = {"-", "Banana", "Gun", "Knife", "Both"}, Flag = "rage_killall_weapon"})
sections.rage.killall:AddDropdown({Name = "Prediction", Default = "-", Options = {"-", "CFrame 1", "CFrame 2", "Velocity"}, Flag = "rage_killall_prediction"})
sections.rage.misc:AddDropdown({Name = "Spectate", Default = "-", Options = {"-", "Anti Spectate", "Sideways Left", "Upside Down", "Sideways Right"}, Flag = "rage_spectate"})

sections.visuals.thirdperson:AddToggle({Name = "Third person", Default = false, Flag = "visuals_third_person"})
sections.visuals.thirdperson:AddSlider({Name = "Distance", Min = 1, Max = 20, Default = 8, Color3.fromRGB(0, 0, 0), Increment = 1, Flag = "visuals_third_person_distance"})
sections.visuals.tracers:AddToggle({Name = "Tracers", Default = false, Flag = "visuals_bullet_tracers"})
sections.visuals.tracers:AddColorpicker({Name = "Color", Default = Color3.fromRGB(0, 0, 0), Flag = "visuals_bullet_tracers_color"})
sections.visuals.tracers:AddDropdown({Name = "Material", Default = "ForceField", Options = {"SmoothPlastic", "Neon", "ForceField", "Wood", "Glass"}, Flag = "visuals_bullet_tracers_material"})
sections.visuals.tracers:AddSlider({Name = "Transparency", Min = 0, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, ValueName = "%", Flag = "visuals_bullet_tracers_transparency"})
sections.visuals.impacts:AddToggle({Name = "Impacts", Default = false, Flag = "visuals_bullet_impacts"})
sections.visuals.impacts:AddColorpicker({Name = "Color", Default = Color3.fromRGB(0, 0, 0), Flag = "visuals_bullet_impacts_color"})
sections.visuals.impacts:AddDropdown({Name = "Material", Default = "ForceField", Options = {"SmoothPlastic", "Neon", "ForceField", "Wood", "Glass"}, Flag = "visuals_bullet_impacts_material"})
sections.visuals.impacts:AddSlider({Name = "Transparency", Min = 0, Max = 100, Default = 50, Color3.fromRGB(0, 0, 0), Increment = 10, ValueName = "%", Flag = "visuals_bullet_impacts_transparency"})

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
sections.qol.gun_mods:AddDropdown({Name = "Infinite Ammo", Default = "-", Options = {"-", "Mag", "Reserve"}, Flag = "qol_infinite_ammo"})
sections.qol.gun_mods:AddToggle({Name = "No Recoil", Default = false, Flag = "qol_no_recoil"})
sections.qol.gun_mods:AddToggle({Name = "No Spread", Default = false, Flag = "qol_no_spread"})
sections.qol.gun_mods:AddToggle({Name = "Penetration", Default = false, Flag = "qol_penetration"})
sections.qol.gun_mods:AddToggle({Name = "Firerate", Default = false, Flag = "qol_firerate"})
sections.qol.damage:AddToggle({Name = "No Firedamage", Default = false, Flag = "qol_no_firedamage"})
sections.qol.damage:AddToggle({Name = "No Falldamage", Default = false, Flag = "qol_no_falldamage"})
sections.qol.chat:AddToggle({Name = "No Filter", Default = false, Flag = "qol_no_filter"})
sections.qol.chat:AddToggle({Name = "Chat Alive", Default = false, Flag = "qol_chat_alive"})
sections.qol.chat:AddToggle({Name = "Dead Chat", Default = false, Flag = "qol_dead_chat"})
sections.qol.chat:AddToggle({Name = "Rules", Default = false, Flag = "qol_chat_rules"})
sections.qol.misc:AddToggle({Name = "Anti-AFK", Default = true, Flag = "qol_anti_afk"})
sections.qol.misc:AddToggle({Name = "Anti-Votekick", Default = true, Flag = "qol_anti_votekick"})
sections.qol.misc:AddDropdown({Name = "Auto Join", Default = "None", Options = {"None", "Terrorists", "Counter-Terrorists"}, Flag = "qol_auto_join"})

sections.settings.profile:AddTextbox({Name = "Name", Default = "", TextDisappear = false, Callback = function(state) oblivion.config_name = state end})
sections.settings.profile:AddButton({Name = "Save", Callback = function() SaveFlags(oblivion.config_name) end})
sections.settings.profile:AddDropdown({Name = "Profiles", Default = "-", Options = {"-"}, Flag = "settings_profile"})
sections.settings.profile:AddButton({Name = "Load", Callback = function() if ui_source.Flags["settings_profile"].Value ~= "-" then LoadFlags(ui_source.Flags["settings_profile"].Value) end end})
sections.settings.profile:AddButton({Name = "Auto Load", Callback = function() filesys.writefile("Oblivion/CB/auto_load.cfg", ui_source.Flags["settings_profile"].Value == "-" and "" or ui_source.Flags["settings_profile"].Value) end})
sections.settings.profile:AddButton({Name = "Refresh", Callback = function() RefreshFlags() end})
sections.settings.misc:AddButton({Name = "Server Hop", Callback = function() local places, teleported = {}, false repeat places = {} for _, v in ipairs(environment.HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100")).data) do if type(v) == "table" and (v.maxPlayers - 1) > v.playing and v.id ~= game.JobId then places[#places + 1] = v.id end end if #places > 0 then teleported = true environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, places[math.random(1, #places)]) end if not teleported then wait(3) end until teleported end})
sections.settings.misc:AddButton({Name = "Server Rejoin", Callback = function() environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, environment.LocalPlayer) end})
sections.settings.misc:AddButton({Name = "Refresh Dropdowns", Callback = function() EditDropdowns() end})
sections.settings.misc:AddToggle({Name = "Message Logger", Default = true, Flag = "settings_message_logger"})
sections.settings.misc:AddToggle({Name = "Unlock More Gun Mods", Default = false, Flag = "settings_more_gun_mods", Callback = function(state)
	if state then
		if oblivion.ran then
			ui_source:MakeNotification({Name = "Oblivion", Content = "This option will tank performance.", Image = "rbxassetid://4384402990", Time = 3})
		end
		if not ui_source.Flags["qol_automatic"] then
			sections.qol.gun_mods:AddToggle({Name = "Automatic", Default = false, Flag = "qol_automatic", Callback = function(state2)
				if state2 and not ui_source.Flags["settings_more_gun_mods"].Value then
					ui_source.Flags["qol_automatic"]:Set(false)
				end
			end})
		end
		if not ui_source.Flags["qol_infinite_range"] then
			sections.qol.gun_mods:AddToggle({Name = "Infinite Range", Default = false, Flag = "qol_infinite_range", Callback = function(state2)
				if state2 and not ui_source.Flags["settings_more_gun_mods"].Value then
					ui_source.Flags["qol_infinite_range"]:Set(false)
				end
			end})
		end
		if not ui_source.Flags["qol_instant_reload"] then
			sections.qol.gun_mods:AddToggle({Name = "Instant Reload", Default = false, Flag = "qol_instant_reload", Callback = function(state2)
				if state2 and not ui_source.Flags["settings_more_gun_mods"].Value then
					ui_source.Flags["qol_instant_reload"]:Set(false)
				end
			end})
		end
		if not ui_source.Flags["qol_instant_equip"] then
			sections.qol.gun_mods:AddToggle({Name = "Instant Equip", Default = false, Flag = "qol_instant_equip", Callback = function(state2)
				if state2 and not ui_source.Flags["settings_more_gun_mods"].Value then
					ui_source.Flags["qol_instant_equip"]:Set(false)
				end
			end})
		end
		if oblivion.more_gun_mods then return end
		oblivion.more_gun_mods = true
		oblivion.oldindex = syn.hookmetamethod(game, "__index", function(self, index)
			if index == "Value" then
				if (self.Name == "Spread" or self.Parent.Name == "Spread") and ui_source.Flags["qol_no_spread"].Value then
					return 0
				elseif (self.Name == "AccuracyDivisor" or self.Name == "AccuracyOffset") and ui_source.Flags["qol_no_spread"].Value then
					return 0.001
				elseif self.Name == "Penetration" and ui_source.Flags["qol_penetration"].Value then
					return 200
				elseif self.Name == "FireRate" and ui_source.Flags["qol_firerate"].Value then
					return 0.001
				elseif self.Name == "Auto" and ui_source.Flags["qol_automatic"].Value then
					return true
				elseif self.Name == "Range" and ui_source.Flags["qol_infinite_range"].Value then
					return 9999
				elseif self.Name == "RangeModifier" and ui_source.Flags["qol_infinite_range"].Value then
					return 100
				elseif self.Name == "ReloadTime" and ui_source.Flags["qol_instant_reload"].Value then
					return 0.001
				elseif self.Name == "EquipTime" and ui_source.Flags["qol_instant_equip"].Value then
					return 0.001
				end
			end

			return oblivion.oldindex(self, index)
		end)
	else
		if oblivion.ran then
			ui_source:MakeNotification({Name = "Oblivion", Content = "This will require a rejoin to take effect.", Image = "rbxassetid://4384402990", Time = 3})
		end
		if ui_source.Flags["qol_automatic"] and ui_source.Flags["qol_automatic"].Value then
			ui_source.Flags["qol_automatic"]:Set(false)
		end
		if ui_source.Flags["qol_infinite_range"] and ui_source.Flags["qol_infinite_range"].Value then
			ui_source.Flags["qol_infinite_range"]:Set(false)
		end
		if ui_source.Flags["qol_instant_reload"] and ui_source.Flags["qol_instant_reload"].Value then
			ui_source.Flags["qol_instant_reload"]:Set(false)
		end
		if ui_source.Flags["qol_instant_equip"] and ui_source.Flags["qol_instant_equip"].Value then
			ui_source.Flags["qol_instant_equip"]:Set(false)
		end
	end
end})

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
		if player ~= environment.LocalPlayer then
			InitiatePlayer(player)
		end
	end)()
end

environment.LocalPlayer.CharacterAdded:Connect(function(character)
	oblivion.values.aimbot.delay, oblivion.values.aimbot.part, oblivion.values.aimbot.player, oblivion.values.aimbot.reset = 0, nil, nil, 0
	oblivion.values.aimbot.triggerbot.delay, oblivion.values.aimbot.triggerbot.shoot, oblivion.values.aimbot.triggerbot.state = 0, 0, false
	local renderstepper = environment.RunService.RenderStepped:Connect(function()
		LocalplayerFunctions(character)
	end)
	repeat
		wait()
	until character and character:FindFirstChild("Humanoid")
	repeat
		wait()
	until not IsAlive(environment.LocalPlayer)
	renderstepper:Disconnect()
end)
coroutine.wrap(function()
	local character = ReturnCharacter(environment.LocalPlayer)
	if character then
		local renderstepper = environment.RunService.RenderStepped:Connect(function()
			LocalplayerFunctions(character)
		end)
		repeat
			wait()
		until character and character:FindFirstChild("Humanoid")
		repeat
			wait()
		until not IsAlive(environment.LocalPlayer)
		renderstepper:Disconnect()
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
		if WarmupCheck() and (environment.LocalPlayer.PlayerGui.GUI.MapVote.Visible or environment.LocalPlayer.PlayerGui.GUI.Scoreboard.Visible) then
			environment.LocalPlayer.PlayerGui.GUI.MapVote.Visible = false
			environment.LocalPlayer.PlayerGui.GUI.Scoreboard.Visible = false
		end
	end
end)

if (environment.LocalPlayer.PlayerGui.GUI.MapVote.Visible or environment.LocalPlayer.PlayerGui.GUI.Scoreboard.Visible) then
	environment.LocalPlayer.PlayerGui.GUI.MapVote.Visible = false
	environment.LocalPlayer.PlayerGui.GUI.Scoreboard.Visible = false
end

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

environment.ReplicatedStorage.Events.SendMsg.OnClientEvent:Connect(function(message)
	if ui_source.Flags["qol_anti_votekick"].Value then
		local args = string.split(message, " ")
		if environment.Players:FindFirstChild(args[1]) and args[12] == environment.LocalPlayer.Name and (args[7] == "2" or args[7] == "1" or args[7] == "-1" or args[7] == "-2") then
			environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, environment.LocalPlayer)
		end
	end
end)

environment.RunService.RenderStepped:Connect(function(step)
	--pcall(function()
		oblivion.step, oblivion.ping = step, game.Stats.PerformanceStats.Ping:GetValue()
		local localplayeral = IsAlive(environment.LocalPlayer)
		local visible_players = {}

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

		if ui_source.Flags["qol_no_recoil"].Value and localplayeral then
			oblivion.client.resetaccuracy()
			oblivion.client.RecoilX = 0
			oblivion.client.RecoilY = 0
		end

		if ui_source.Flags["qol_firerate"].Value and localplayeral then
			oblivion.client.DISABLED = false
		end

		for _, player in pairs(environment.Players:GetPlayers()) do
			if player ~= environment.LocalPlayer then
				if localplayeral and (ui_source.Flags["esp_enemy_enable"].Value and ui_source.Flags["esp_visible_only"].Value or ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_visible_only"].Value or ui_source.Flags["rage_killall_enemy_enable"].Value and ui_source.Flags["rage_killall_visible_only"].Value) then
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

        if localplayeral and not Preparation(true) and environment.Workspace.Status:FindFirstChild("RoundOver") and not environment.Workspace.Status.RoundOver.Value and ui_source.Flags["aimbot_enemy_enable"].Value then
			local closestDistance, closestPart, closestPlayer = math.huge, nil, nil
			for _, player in pairs(environment.Players:GetPlayers()) do
				local character = ReturnCharacter(player)
				local part = character and (ui_source.Flags["aimbot_force_hit"].Value and (ui_source.Flags["aimbot_preference"].Value == "Head" and character:FindFirstChild("Head") or ui_source.Flags["aimbot_preference"].Value == "Torso" and character:FindFirstChild("UpperTorso")) or (ui_source.Flags["aimbot_preference"].Value == "Head" and (character:FindFirstChild("FakeHead") and character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")) or ui_source.Flags["aimbot_preference"].Value == "Torso" and (character:FindFirstChild("UpperTorso") or character:FindFirstChild("FakeHead") and character:FindFirstChild("Head")))) or nil
				if character and part and not character:FindFirstChildOfClass("ForceField") and (ui_source.Flags["aimbot_whitelist_only"].Value and TableContains(ui_source.Flags["aimbot_whitelist"].Options, player.Name) or not ui_source.Flags["aimbot_whitelist_only"].Value and (#ui_source.Flags["aimbot_whitelist"].Options == 1 or TableContains(ui_source.Flags["aimbot_whitelist"].Options, player.Name))) and (ui_source.Flags["aimbot_team_enable"].Value or GetTeam(environment.LocalPlayer) ~= GetTeam(player)) and WithinFOV(environment.CurrentCamera.CFrame, part) then
					local vector = environment.CurrentCamera:WorldToScreenPoint(part.Position)
					local distance = (Vector2.new(environment.Mouse.X, environment.Mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
					if distance < closestDistance and (not ui_source.Flags["aimbot_fov_enable"].Value or (ui_source.Flags["aimbot_fov_radius"].Value == 0 or distance < ui_source.Flags["aimbot_fov_radius"].Value)) and ((not ui_source.Flags["aimbot_visible_only"].Value or visible_players[player]) or ui_source.Flags["aimbot_penetration_test"].Value and PenetrationTest(player, part)) then
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
					environment.CurrentCamera.CFrame = CFrame.new(environment.CurrentCamera.CFrame.p, closestPart.Position)
				end
			end
			if closestPart and ui_source.Flags["aimbot_triggerbot"].Value then
				local vector = environment.CurrentCamera:WorldToScreenPoint(closestPart.Position)
				local distance = (Vector2.new(environment.Mouse.X, environment.Mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
				if (not ui_source.Flags["aimbot_triggerbot_fov"].Value or (ui_source.Flags["aimbot_triggerbot_fov_radius"].Value == 0 or distance < ui_source.Flags["aimbot_triggerbot_fov_radius"].Value)) then
					if oblivion.values.aimbot.triggerbot.state then
						local found = GetGunName()
						if oblivion.values.aimbot.triggerbot.delay == 0 and found and oblivion.values.aimbot.triggerbot.shoot == 0 then
							local shoot_delay = ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value ~= "-" and (ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value == "3/4" and 75 or ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value == "1/2" and 50 or ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value == "1/4" and 25) or 100
							oblivion.values.aimbot.rayfilter, oblivion.values.aimbot.triggerbot.shoot = true, ui_source.Flags["aimbot_triggerbot_shoot_delay"].Value ~= "-" and found and (oblivion.lists.weapon_data.guns[found].data.triggerbot_delay / 100 * shoot_delay) or 0
							for i = 1, ui_source.Flags["aimbot_triggerbot_custom_tap"].Value do
								oblivion.client.firebullet()

								if ui_source.Flags["qol_infinite_ammo"].Value ~= "-" then
									if found and ui_source.Flags["qol_infinite_ammo"].Value == "Mag" and oblivion.lists.weapon_data.guns[found].data.type == "primary" then
										oblivion.client.ammocount = oblivion.lists.weapon_data.guns[found].data.clip
									elseif found and ui_source.Flags["qol_infinite_ammo"].Value == "Mag" and oblivion.lists.weapon_data.guns[found].data.type == "secondary" then
										oblivion.client.ammocount2 = oblivion.lists.weapon_data.guns[found].data.clip
									elseif found and ui_source.Flags["qol_infinite_ammo"].Value == "Reserve" and oblivion.lists.weapon_data.guns[found].data.type == "primary" then
										oblivion.client.primarystored = oblivion.lists.weapon_data.guns[found].data.ammo
									elseif found and ui_source.Flags["qol_infinite_ammo"].Value == "Reserve" and oblivion.lists.weapon_data.guns[found].data.type == "secondary" then
										oblivion.client.secondarystored = oblivion.lists.weapon_data.guns[found].data.ammo
									end
								end

								if ui_source.Flags["qol_no_recoil"].Value then
									oblivion.client.resetaccuracy()
									oblivion.client.RecoilX = 0
									oblivion.client.RecoilY = 0
								end
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
			oblivion.values.aimbot.triggerbot.state, oblivion.values.aimbot.triggerbot.delay = false, 0
        end

		oblivion.values.aimbot.triggerbot.shoot = oblivion.values.aimbot.triggerbot.shoot < 0 and 0 or oblivion.values.aimbot.triggerbot.shoot < 1 and (oblivion.values.aimbot.triggerbot.shoot - 1) ~= 0 and 0 or oblivion.values.aimbot.triggerbot.shoot > 0 and oblivion.values.aimbot.triggerbot.shoot - 1 or oblivion.values.aimbot.triggerbot.shoot

		if localplayeral and not Preparation(true) and environment.Workspace.Status:FindFirstChild("RoundOver") and not environment.Workspace.Status.RoundOver.Value and ui_source.Flags["rage_killall_enemy_enable"].Value then
			for _, player in pairs(environment.Players:GetPlayers()) do
				local character = ReturnCharacter(player)
				if character and (ui_source.Flags["rage_killall_team_enable"].Value or GetTeam(environment.LocalPlayer) ~= GetTeam(player)) and (ui_source.Flags["rage_killall_whitelist_only"].Value and TableContains(ui_source.Flags["rage_killall_whitelist"].Options, player.Name) or not ui_source.Flags["rage_killall_whitelist_only"].Value and (#ui_source.Flags["rage_killall_whitelist"].Options == 1 or TableContains(ui_source.Flags["rage_killall_whitelist"].Options, player.Name))) and (not ui_source.Flags["esp_visible_only"].Value or ui_source.Flags["esp_visible_only"].Value and visible_players[player]) then
					local gun_name = ui_source.Flags["rage_killall_weapon"].Value == "-" and oblivion.client.gun.Name or ui_source.Flags["rage_killall_weapon"].Value == "Banana" and "Banana" or oblivion.lists.weapon_types[ui_source.Flags["rage_killall_weapon"].Value][math.random(1, #oblivion.lists.weapon_types[ui_source.Flags["rage_killall_weapon"].Value])]
					local gun_model = ui_source.Flags["rage_killall_weapon"].Value == "Banana" and environment.LocalPlayer.Character.Gun or environment.ReplicatedStorage.Weapons[gun_name].Model
					local args = {
						[1] = character.Head,
						[2] = character.Head.CFrame.p,
						[3] = gun_name,
						[4] = 4096,
						[5] = gun_model,
						[8] = 1,
						[9] = false,
						[10] = false,
						[11] = Vector3.new(),
						[12] = 16868,
						[13] = Vector3.new()
					}

					if ui_source.Flags["rage_killall_prediction"].Value ~= "-" then
						if ui_source.Flags["rage_killall_prediction"].Value == "CFrame 1" then
							local hrp, oldhrp = character.HumanoidRootPart.Position, character.HumanoidRootPart.OldPosition.Value
							local velocity = (Vector3.new(hrp.X, 0, hrp.Z) - Vector3.new(oldhrp.X, 0, oldhrp.Z)) / oblivion.step
							local direction = Vector3.new(velocity.X / velocity.magnitude, 0, velocity.Z / velocity.magnitude)
							if velocity.magnitude >= 8 then
								args[2] = args[2] + direction * (oblivion.ping / (math.pow(oblivion.ping, 1.5)) * (direction / (direction / 2)))
								args[4] = 0
								args[12] = args[12] - 500
							end
						elseif ui_source.Flags["rage_killall_prediction"].Value == "CFrame 2" then
							local velocity = (character.HumanoidRootPart.Position - character.HumanoidRootPart.OldPosition.Value) / oblivion.step
							local direction = Vector3.new(velocity.X / velocity.magnitude, 0, velocity.Z / velocity.magnitude)
							if velocity.magnitude >= 8 then
								args[2] = args[2] + direction * (velocity.magnitude * (oblivion.ping / 1000) * (oblivion.ping > 200 and 1.5 or 2))
								args[4] = 0
								args[12] = args[12] - 500
							end
						elseif ui_source.Flags["rage_killall_prediction"].Value == "Velocity" then
							local velocity = character.HumanoidRootPart.Velocity
							local direction = Vector3.new(velocity.X / velocity.magnitude, 0, velocity.Z / velocity.magnitude)
							if velocity.magnitude >= 8 then
								args[2] = args[2] + direction * (velocity.magnitude * (oblivion.ping / 1000) * (oblivion.ping > 200 and 1.5 or 2))
								args[4] = 0
								args[12] = args[12] - 500
							end
						end
					end

					environment.ReplicatedStorage.Events.HitPart:FireServer(unpack(args))
				end
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

	if method == "FireServer" and self.Name == "ReplicateCamera" and ui_source.Flags["rage_spectate"].Value ~= "-" then
		args[1] = ui_source.Flags["rage_spectate"].Value == "Sideways Left" and args[1] * CFrame.Angles(0, 0, math.rad(90)) or ui_source.Flags["rage_spectate"].Value == "Upside Down" and args[1] * CFrame.Angles(0, 0, math.rad(180)) or ui_source.Flags["rage_spectate"].Value == "Sideways Right" and args[1] * CFrame.Angles(0, 0, math.rad(270)) or CFrame.new()
	end

	if method == "Kick" then
		return
	elseif method == "FireServer" then
		if string.len(self.Name) == 38 then
			return
		elseif self.Name == "FallDamage" and ui_source.Flags["qol_no_firedamage"].Value then
			return
		elseif self.Name == "BURNME" and ui_source.Flags["qol_no_falldamage"].Value then
			return
		elseif self.Name == "ControlTurn" and not syn.checkcaller() then
			return
		elseif self.Name == "test" then
			return
		elseif self.Name == "PlayerChatted" and ui_source.Flags["qol_chat_alive"].Value then
			args[2] = false
			args[3] = "Innocent"
			args[4] = false
			args[5] = false
		elseif self.Name == "HitPart" then
			if ui_source.Flags["aimbot_force_hit"].Value and oblivion.values.aimbot.part and oblivion.values.aimbot.delay == 0 then
				args[1] = oblivion.values.aimbot.part
				args[2] = oblivion.values.aimbot.part.Position
			end

			coroutine.wrap(function()
				if not syn.checkcaller() and ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_prediction"].Value ~= "-" and oblivion.values.aimbot.player and args[1] == oblivion.values.aimbot.part then
					if ui_source.Flags["aimbot_prediction"].Value == "CFrame 1" then
						local hrp, oldhrp = oblivion.values.aimbot.part.Parent.HumanoidRootPart.Position, oblivion.values.aimbot.part.Parent.HumanoidRootPart.OldPosition.Value
						local velocity = (Vector3.new(hrp.X, 0, hrp.Z) - Vector3.new(oldhrp.X, 0, oldhrp.Z)) / oblivion.step
						local direction = Vector3.new(velocity.X / velocity.magnitude, 0, velocity.Z / velocity.magnitude)
						if velocity.magnitude >= 8 then
							args[2] = args[2] + direction * (oblivion.ping / (math.pow(oblivion.ping, 1.5)) * (direction / (direction / 2)))
							args[4] = 0
							args[12] = args[12] - 500
						end
					elseif ui_source.Flags["aimbot_prediction"].Value == "CFrame 2" then
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
				if ui_source.Flags["visuals_bullet_tracers"].Value then
					local tracer = Instance.new("Part")
					tracer.Anchored, tracer.CanCollide = true, false
					tracer.Material, tracer.Color, tracer.Transparency = ui_source.Flags["visuals_bullet_tracers_material"].Value, ui_source.Flags["visuals_bullet_tracers_color"].Value, (ui_source.Flags["visuals_bullet_tracers_transparency"].Value / 100)
					tracer.Size, tracer.CFrame = Vector3.new(0.1, 0.1, (environment.CurrentCamera.CFrame.p - args[2]).magnitude), CFrame.new(environment.CurrentCamera.CFrame.p, args[2]) * CFrame.new(0, 0, -tracer.Size.Z / 2)
					tracer.Name, tracer.Parent = "Tracer", environment.CurrentCamera
					wait(3)
					tracer:Destroy()
				end
			end)()

			coroutine.wrap(function()
				if ui_source.Flags["visuals_bullet_impacts"].Value then
					local impact = Instance.new("Part")
					impact.Anchored, impact.CanCollide = true, false
					impact.Material, impact.Color, impact.Transparency = ui_source.Flags["visuals_bullet_impacts_material"].Value, ui_source.Flags["visuals_bullet_impacts_color"].Value, (ui_source.Flags["visuals_bullet_impacts_transparency"].Value / 100)
					impact.Size, impact.CFrame = Vector3.new(0.25, 0.25, 0.25), CFrame.new(args[2])
					impact.Name, impact.Parent = "Impact", environment.CurrentCamera
					wait(3)
					impact:Destroy()
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
		elseif self.Name == "Hugh" then
			return
		elseif self.Name == "Filter" then
			--print(tostring(args[2])..": "..tostring(args[1]))
			if ui_source.Flags["settings_message_logger"].Value and not syn.checkcaller() and callingscript == environment.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat then
				local logged = filesys.readfile("Oblivion/CB/messages.txt")
				filesys.writefile("Oblivion/CB/messages.txt", logged.."\n"..tostring(args[2].Name)..": "..tostring(args[1]))
			end

			coroutine.wrap(function()
				if (
					callingscript == environment.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat and
					not syn.checkcaller() and
					(
						args[2] == environment.LocalPlayer and not GetTeam(environment.LocalPlayer) and ui_source.Flags["qol_chat_alive"].Value or
						args[2] ~= environment.LocalPlayer and (
							not GetTeam(environment.LocalPlayer) and
							GetTeam(args[2])
						)
					)
				) then
					oblivion.displaychat.moveOldMessages()
					local teamcolour = GetTeam(args[2]) == "T" and BrickColor.new("Bright yellow") or GetTeam(args[2]) == "CT" and BrickColor.new("Bright blue") or BrickColor.new("White")
					local label = not (args[2] == environment.LocalPlayer and not GetTeam(environment.LocalPlayer) and ui_source.Flags["qol_chat_alive"].Value) and (not GetTeam(args[2]) or not IsAlive(args[2]) or TableContains(RadioText, args[1])) and ParseTextLabel(not GetTeam(args[2]) and "(SPECTATOR)" or not IsAlive(args[2]) and "*DEAD*" or TableContains(RadioText, args[1]) and "*RADIO*", not GetTeam(args[2]) and environment.LocalPlayer.PlayerGui.GUI.Main.Chats.SpectatorColor.Value or not IsAlive(args[2]) and environment.LocalPlayer.PlayerGui.GUI.Main.Chats.DeadColor.Value or TableContains(RadioText, args[1]) and Color3.new(0.3137254901960784, 0.47058823529411764, 0.47058823529411764)) or nil
					oblivion.displaychat.createNewMessage(args[2].Name, args[1], teamcolour.Color, Color3.new(255, 255, 255), args[2] == environment.LocalPlayer and not GetTeam(environment.LocalPlayer) and ui_source.Flags["qol_chat_alive"].Value and 0.01 or not GetTeam(args[2]) and 0.2 or not IsAlive(args[2]) and 0.11 or TableContains(RadioText, args[1]) and 0.12 or 0.01, label)
				end
			end)()

			coroutine.wrap(function()
				if ui_source.Flags["qol_dead_chat"].Value and callingscript == environment.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat and args[2] ~= environment.LocalPlayer and not syn.checkcaller() and not WarmupCheck() and not environment.Workspace.Status.RoundOver.Value and not Preparation(false) and IsAlive(environment.LocalPlayer) and GetTeam(args[2]) and not IsAlive(args[2]) then
					oblivion.displaychat.moveOldMessages()
					local teamcolour = GetTeam(args[2]) == "T" and BrickColor.new("Bright yellow") or GetTeam(args[2]) == "CT" and BrickColor.new("Bright blue") or BrickColor.new("White")
					local label = ParseTextLabel("*DEAD*", environment.LocalPlayer.PlayerGui.GUI.Main.Chats.DeadColor.Value)
					oblivion.displaychat.createNewMessage(args[2].Name, args[1], teamcolour.Color, Color3.new(255, 255, 255), 0.11, label)
				end
			end)()
			if ui_source.Flags["qol_no_filter"].Value then
				return args[1]
			end
		end
	elseif method == "FindPartOnRayWithIgnoreList" and args[2][1] == environment.Workspace.Debris and (not syn.checkcaller() or oblivion.values.aimbot.rayfilter) then
		if ui_source.Flags["qol_penetration"].Value then
			args[2][#args[2] + 1] = environment.Workspace.Map
		end
		if ui_source.Flags["qol_no_spread"].Value then
			args[1] = Ray.new(environment.CurrentCamera.CFrame.p, environment.CurrentCamera.CFrame.LookVector * (environment.ReplicatedStorage.Weapons[environment.LocalPlayer.Character.EquippedTool.Value].Range.Value * 0.1))
		end
		if ui_source.Flags["aimbot_enemy_enable"].Value and ui_source.Flags["aimbot_type"].Value == "Silent" and oblivion.values.aimbot.player and oblivion.values.aimbot.part and oblivion.values.aimbot.delay == 0 then
			args[1] = Ray.new(environment.CurrentCamera.CFrame.p, (oblivion.values.aimbot.part.Position - environment.CurrentCamera.CFrame.p).unit * (environment.ReplicatedStorage.Weapons[environment.LocalPlayer.Character.EquippedTool.Value].Range.Value * 0.1))
		end
	end

	return oblivion.oldnamecall(self, unpack(args))
end))

oblivion.displaychat.createNewMessage = function(plr, msg, teamcolor, msgcolor, offset, line)
	if ui_source.Flags["qol_chat_rules"].Value then
		local player = environment.Players:FindFirstChild(plr)
		if not IsAlive(player) and not WarmupCheck() and not environment.Workspace.Status.RoundOver.Value and not Preparation(false) and offset == 0.01 then
			if IsAlive(environment.LocalPlayer) and ui_source.Flags["qol_dead_chat"].Value then return end
			return oblivion.createnewmessage("(Dead) "..plr, msg, Color3.new(196, 40, 28), msgcolor, offset, line)
		end
	end
	return oblivion.createnewmessage(plr, msg, teamcolor, msgcolor, offset, line)
end

ui_source:MakeNotification({Name = "Oblivion", Content = "Loaded script.", Image = "rbxassetid://4400702457", Time = 3})

local save = filesys.readfile("Oblivion/CB/auto_load.cfg")
if save ~= "" then LoadFlags(save) end
EditDropdowns()
RefreshFlags()

oblivion.ran = true

ui_source:MakeNotification({Name = "Oblivion", Content = "Welcome "..environment.LocalPlayer.Name..".", Image = "rbxassetid://4431165334", Time = 10})

--[[
	Todo;
	- Add kill all (Started, working but needs more options like "teleport dodging").
	- Change how teams are checked for other gamemodes (Deathmatch).
	- Anti aim.
	- Skin changer.
	- Viewmodels.
	- Misc, like anti spectate.
	- Fun options, like constantly teleporting behind a player as if you're attached to them.

	Issues;
	- Random bug with esp where there is another set existing.
	- When using extra gun mods's hook, performance tanks.
]]
