--[[
    Made by:
    SomeoneIdfk

    Credits:

]]

repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("GUI")

-- Environment 
local filesys, syn, environment, oblivion = {
    listfiles = listfiles or listdir or syn_io_listdir or nil,
    isfolder = isfolder or nil,
    isfile = isfile or nil,
    makefolder = makefolder or nil,
    writefile = writefile or nil
}, {
    getrawmetatable = getrawmetatable or nil,
    getsenv = getsenv or nil,
    hookfunc = hookfunc or hookfunction or replaceclosure or nil,
    sethiddenproperty = sethiddenproperty or nil,
	getconnections = getconnections or nil
}, {
    Workspace = game:GetService("Workspace"),
    UserInputService = game:GetService("UserInputService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService = game:GetService("HttpService"),
    RunService = game:GetService("RunService"),
    Players = game:GetService('Players'),
    TeleportService = game:GetService("TeleportService"),
    LocalPlayer = game:GetService('Players').LocalPlayer
}, {
    env_err = false,
    ran = false,
    lists = {tagged = {}, textures = {}, visible_player_cache = {}},
    values = {map = nil, splatterblood = nil},
	client = nil
}

for i, v in ipairs(filesys) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
for i, v in ipairs(syn) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
for i, v in ipairs(environment) do if v == nil and not oblivion.env_err then oblivion.env_err = true break end end
if oblivion.env_err then return end

if not filesys.isfolder("Oblivion") or not filesys.isfolder("Oblivion/CB") then filesys.makefolder("Oblivion") filesys.makefolder("Oblivion/CB") end
if not filesys.isfile("Oblivion/CB/tagged.cfg") then filesys.writefile("Oblivion/CB/data.cfg", "{}") end

oblivion.lists.tagged = loadstring("return "..readfile("Oblivion/CB/tagged.cfg"))()

-- Preparation
repeat wait() until environment.Workspace:FindFirstChild("Map") and environment.Workspace.Map:FindFirstChild("Origin")
oblivion.client = syn.getsenv(environment.LocalPlayer.PlayerGui:WaitForChild("Client"))

local ui_source = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local ui = ui_source:MakeWindow({Name = "Oblivion", HidePremium = true, SaveConfig = false, ConfigFolder = "", IntroEnabled = true, IntroText = "Oblivion", IntroIcon = "rbxassetid://4335489513"})

local esp = loadstring(game:HttpGet('https://raw.githubusercontent.com/SomeoneIdfk/Roblox/main/Esp.lua'))()
--local esp = loadstring(readfile("Oblivion/CB/esp.lua"))()
esp.whitelist = {}
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
        chamsOutlineColor = { Color3.new(1,0,0), 0 }
    },
    friendly = {
        enabled = false,
        box = true,
        boxColor = { Color3.new(0,1,0), 1 },
        boxOutline = false,
        boxOutlineColor = { Color3.new(), 1 },
        boxFill = false,
        boxFillColor = { Color3.new(0,1,0), 0.5 },
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
        tracerColor = { Color3.new(0,1,0), 1 },
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
        chamsOutlineColor = { Color3.new(0,1,0), 0 }
    }
}

local Hitboxes = {"Head", "UpperTorso", "LeftUpperArm", "RightUpperArm", "LeftFoot", "RightFoot", "LeftHand", "RightHand"}

-- Functions
function esp.isFriendly(player)
	return player and player:FindFirstChild("Status") and player.Status.Team.Value == environment.LocalPlayer.Status.Team.Value or false;
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

local function CanSeePlayer(player, hitboxes)
	local character, localplayer = ReturnCharacter(player), environment.LocalPlayer.Character
	if not character then return false; end
	local origin = environment.Workspace.CurrentCamera.CFrame
	local playerToCharacter, playerLook = (character.HumanoidRootPart.Position - origin.Position).Unit, origin.LookVector
	local withinFOV = playerToCharacter:Dot(playerLook)
	if withinFOV < 0 then return false; end
	for _, v in ipairs(hitboxes) do
		local part = character:FindFirstChild(v) and character[v] or nil
		if part then
			local ray = Ray.new(origin.Position, (part.Position - origin.Position).unit * (part.Position - origin.Position).magnitude)
			local hit, pos = environment.Workspace:FindPartOnRayWithIgnoreList(ray, {localplayer, environment.Workspace.CurrentCamera, environment.Workspace.Map.Clips, environment.Workspace.Map.SpawnPoints, environment.Workspace.Debris}, false, true)
			if hit and hit:FindFirstAncestor(player.Name) then
				return hit;
			end
		end
	end
	return false;
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
    --aimbot = ui:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345998", PremiumOnly = false}),
	esp = ui:MakeTab({Name = "ESP", Icon = "rbxassetid://4483362458", PremiumOnly = false}),
	qol = ui:MakeTab({Name = "QOL", Icon = "rbxassetid://4384401360", PremiumOnly = false}),
    settings = ui:MakeTab({Name = "Settings", Icon = "rbxassetid://3605022185", PremiumOnly = false})
}
local sections = {
    --aimbot = {
        --main = tabs.aimbot:AddSection({Name = "Main"})
    --},
	esp = {
		main = tabs.esp:AddSection({Name = "Main"}),
		chams = tabs.esp:AddSection({Name = "Chams"}),
		boxes = tabs.esp:AddSection({Name = "Boxes"}),
		details = tabs.esp:AddSection({Name = "Details"}),
		tracers = tabs.esp:AddSection({Name = "Tracers"})
	},
	qol = {
		performance = tabs.qol:AddSection({Name = "Performance"}),
		misc = tabs.qol:AddSection({Name = "Misc"})
	},
    settings = {
        misc = tabs.settings:AddSection({Name = "Misc"})
    }
}

--sections.aimbot.main:AddToggle({Name = "Enable", Default = false, Flag = "aimbot_enable"})
--sections.aimbot.main:AddToggle({Name = "Visible Only", Default = false, Flag = "aimbot_visible"})

sections.esp.main:AddToggle({Name = "Enable", Default = false, Flag = "esp_enemy_enable", Callback = function(state) esp.teamSettings.enemy.enabled = state end})
sections.esp.main:AddToggle({Name = "Team", Default = false, Flag = "esp_team_enable", Callback = function(state) esp.teamSettings.friendly.enabled = state end})
sections.esp.main:AddToggle({Name = "Visible Only", Default = false, Flag = "esp_visible_only"})
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
sections.qol.performance:AddToggle({Name = "Remove Blood", Default = false, Flag = "qol_blood_remove"})
sections.qol.misc:AddToggle({Name = "Anti-AFK", Default = true, Flag = "qol_anti_afk"})
sections.qol.misc:AddDropdown({Name = "Auto Join", Default = "None", Options = {"None", "Terrorists", "Counter-Terrorists"}, Flag = "qol_auto_join"})

sections.settings.misc:AddButton({Name = "Server Hop", Callback = function() local places, teleported = {}, false repeat places = {} for _, v in ipairs(environment.HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100")).data) do if type(v) == "table" and (v.maxPlayers - 2) <= v.playing and v.id ~= game.JobId then places[#places + 1] = v.id end end if #places > 0 then teleported = true environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, places[math.random(1, #places)]) end if not teleported then wait(3) end until teleported end})
sections.settings.misc:AddButton({Name = "Server Rejoin", Callback = function() environment.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, environment.LocalPlayer) end})

-- Init
ui_source:Init()
esp:Load()

environment.Players.PlayerAdded:Connect(function(player)
	oblivion.lists.visible_player_cache[player] = {state = false, reset = 0}
	player.CharacterAdded:Connect(function(character)
		wait(1)
		if character ~= nil and character:FindFirstChild("HumanoidRootPart") then
			local Value = Instance.new("Vector3Value")
			Value.Name = "OldPosition"
			Value.Value = character.HumanoidRootPart.Position
			Value.Parent = character.HumanoidRootPart
		end
	end)
end)

for _, player in pairs(environment.Players:GetPlayers()) do
	if player ~= environment.LocalPlayer then
		oblivion.lists.visible_player_cache[player] = {state = false, reset = 0}
		player.CharacterAdded:Connect(function(character)
			wait(1)
			if character ~= nil and character:FindFirstChild("HumanoidRootPart") then
				local Value = Instance.new("Vector3Value")
				Value.Name = "OldPosition"
				Value.Value = character.HumanoidRootPart.Position
				Value.Parent = character.HumanoidRootPart
			end
		end)
	end
end

environment.RunService.RenderStepped:Connect(function(step)
	--pcall(function()
		local localplayeral = IsAlive(environment.LocalPlayer)
		local visible_players = {}

		for _, player in pairs(environment.Players:GetPlayers()) do
			if player ~= environment.LocalPlayer then
				if localplayeral and (ui_source.Flags["esp_enemy_enable"].Value and ui_source.Flags["esp_visible_only"].Value) then
					if oblivion.lists.visible_player_cache[player].reset ~= 0 then
						oblivion.lists.visible_player_cache[player].reset -= 1
						visible_players[player] = oblivion.lists.visible_player_cache[player].state
					end
					if oblivion.lists.visible_player_cache[player].reset == 0 then
						if IsAlive(player) and CanSeePlayer(player, Hitboxes) then
							oblivion.lists.visible_player_cache[player].state, oblivion.lists.visible_player_cache[player].reset, visible_players[player] = true, 5, true
						else
							oblivion.lists.visible_player_cache[player].state, oblivion.lists.visible_player_cache[player].reset, visible_players[player] = false, 3, false
						end
					end
				end

				if localplayeral and ui_source.Flags["esp_enemy_enable"].Value then
					if IsAlive(player) and (not ui_source.Flags["esp_visible_only"].Value or ui_source.Flags["esp_visible_only"].Value and visible_players[player]) and (ui_source.Flags["esp_team_enable"].Value or GetTeam(environment.LocalPlayer) ~= GetTeam(player)) then
						esp.whitelist[player] = false
					else
						esp.whitelist[player] = true
					end
				end
			end
		end

        --[[if ui_source.Flags["aimbot_enable"].Value then

        end]]

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

environment.Workspace.ChildAdded:Connect(function(child)
	if child.Name == "Map" then
		if ui_source.Flags["qol_auto_join"].Value ~= "None" then
			coroutine.wrap(function()
				local var, rounds = ui_source.Flags["qol_auto_join"].Value == "Terrorists" and "T" or ui_source.Flags["qol_auto_join"].Value == "Counter-Terrorists" and "CT", environment.Workspace.Status.Rounds.Value
				repeat environment.ReplicatedStorage.Events.JoinTeam:FireServer(var) wait(1) until GetTeam(environment.LocalPlayer) == var and rounds == environment.Workspace.Status.Rounds.Value or rounds ~= environment.Workspace.Status.Rounds.Value
			end)
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
