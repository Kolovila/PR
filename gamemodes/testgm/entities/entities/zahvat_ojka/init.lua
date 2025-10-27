AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("OpenIDKPanel")
util.AddNetworkString("OpenAdminPanel")
util.AddNetworkString("GetPointsCfgs")
util.AddNetworkString("GivePointsCfgs")
util.AddNetworkString("SetServerPointsCfgs")
util.AddNetworkString("GetNewCfgs")
util.AddNetworkString("CreateNewCfgs")
util.AddNetworkString("SetClientNewPoint")
util.AddNetworkString("SetPoint")
util.AddNetworkString("UpgradePoint")
util.AddNetworkString("GivePointEnt")
util.AddNetworkString("GivePointUpgrade")
util.AddNetworkString("SpawnGuardianNPC")
util.AddNetworkString("GuardianDown")

PR_Capture_Points_List = PR_Capture_Points_List or {}

function ENT:Initialize()
    self:SetModel(self.Model)
    --self:PhysicsInit(SOLID_VPHYSICS)
    --self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
   
    self:SetUseType(SIMPLE_USE)
   
    local phys = self:GetPhysicsObject()
   
    if (IsValid(phys)) then
		phys:Wake()
    end
	
	self:SetHealth(self.BaseHealth)
	
	self.timer = CurTime()
	
	--timer.Create("PrintTimer"..self:EntIndex(), self.PrintRate, 0, function()
	   --self:SetStorage(self:GetStorage() + self.PrintAmount)
	--end)
end

function ENT:SpawnFunction(ply, tr, ClassName)
    if(!tr.Hit) then return end
   
    tr.start = ply:EyePos()
    tr.endpos = ply:EyePos() + 95 * ply:GetAimVector()
    tr.filter = ply
   
    local trace = util.TraceLine(tr)
   
    
    local entityforpr = ents.Create(ClassName)
    entityforpr:SetPos(trace.HitPos)
    entityforpr:Spawn()
    entityforpr:Activate()

	SpawnModules(entityforpr)
	
	return entityforpr
end

function ENT:Use(activator, caller)
	if self.CaptureTeam == "" or self.CaptureTeam == nil then
		net.Start("OpenAdminPanel")
		net.WriteEntity(self)
		net.Send(activator)
	elseif self.CaptureTeam != activator:GetNWString("PR_fraction") and (self.CaptureTeam != "" or self.CaptureTeam != nil) then
		CapturePoint(activator:GetNWString("PR_Fraction"), activator, self)
	else
		net.Start("OpenIDKPanel")
		net.WriteEntity(self)
		net.Send(activator)
	end
end

--[[
function ENT:OnTakeDamage(damage)
   self:SetHealth(self:Health() - damage:GetDamage())
   
    if (self:Health() <= 0) then
	 --timer.Remove("PrintTimer"..self:EntIndex())
     self:Remove()
	end
end
]]

function ENT:OnRemove()
	self.CurPoint = ""
	self.CaptureTeam = ""
	self.UpgradeMonitor = 0
	self.UpgradeComputer = 1
end

function SpawnModules(mainEnt)
	local Monitor = ents.Create("prop_physics")
	Monitor:SetPos(mainEnt:GetPos()+Vector(-10,0,31.5))
	Monitor:SetAngles(mainEnt:GetAngles())
	Monitor:SetModel("models/props_lab/monitor01a.mdl") --сделать взависимости от переменных .._for_num
	Monitor:Spawn()
	Monitor:Activate()
	Monitor:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	Monitor:SetMoveType(MOVETYPE_NONE)
	Monitor:SetParent(mainEnt,-1)

	local Computer = ents.Create("prop_physics")
	Computer:SetPos(mainEnt:GetPos()+mainEnt:GetUp()*30+mainEnt:GetRight()*-30)
	Computer:SetAngles(mainEnt:GetAngles())
	Computer:SetModel("models/props_lab/harddrive02.mdl")
	Computer:Spawn()
	Computer:Activate()
	Computer:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	Computer:SetMoveType(MOVETYPE_NONE)
	Computer:SetParent(mainEnt,-1)

	local KeyBoard = ents.Create("prop_physics")
	KeyBoard:SetPos(mainEnt:GetPos()+Vector(20,0,20))
	KeyBoard:SetAngles(mainEnt:GetAngles())
	KeyBoard:SetModel("models/props/cs_office/computer_keyboard.mdl")
	KeyBoard:Spawn()
	KeyBoard:Activate()
	KeyBoard:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	KeyBoard:SetMoveType(MOVETYPE_NONE)
	KeyBoard:SetParent(mainEnt,-1)

	local Flag = ents.Create("prop_physics")
	Flag:SetPos(mainEnt:GetPos()+Vector(0,-80,-20))
	Flag:SetAngles(mainEnt:GetAngles())
	Flag:SetModel("models/gmodflags/flagpole05.mdl")
	Flag:SetSkin(24)
	Flag:Spawn()
	Flag:Activate()
	Flag:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	Flag:SetMoveType(MOVETYPE_NONE)
	Flag:SetParent(mainEnt,-1)


end

function CapturePoint(team, player, point)
	if not timer.Exists( "CapturePoint" ) then
		timer.Create( "CapturePoint", 1, 2,
		function()
			if(player:GetPos():Distance(point:GetPos())<600 and player:Health() > 0) then
				player:ChatPrint(timer.RepsLeft("CapturePoint"))
				if timer.RepsLeft("CapturePoint") < 1 then
					player:ChatPrint("Точка захвачена!")
					timer.Remove("CapturePoint")
					point.CaptureTeam = team
					UpdatePointInfo(point)
				end
			else
				timer.Remove("CapturePoint")
			end
		end)
	end
end

function UpdatePointInfo(ent)
	if not file.Exists("pr_gamemode", "DATA") then
		file.CreateDir("pr_gamemode")
	end

	if not file.Exists( "pr_gamemode/capture_points_list.txt", "DATA" ) then
		file.Write("pr_gamemode/capture_points_list.txt")
	end

	local SaveData = file.Read("pr_gamemode/capture_points_list.txt", "DATA")
	PR_Capture_Points_List.Config = util.JSONToTable(SaveData) or {}
	PR_Capture_Points_List.Config[ent.CurPoint] = {
		["Team"] = 0,
		["Monitor"] = 0,
		["System"] = 1
	}

	PR_Capture_Points_List.Config[ent.CurPoint]["Team"] = ent.CaptureTeam
	PR_Capture_Points_List.Config[ent.CurPoint]["Monitor"] = ent.UpgradeMonitor
	PR_Capture_Points_List.Config[ent.CurPoint]["System"] = ent.UpgradeComputer

	file.Write("pr_gamemode/capture_points_list.txt", util.TableToJSON(PR_Capture_Points_List.Config, true))
	
	net.Start("SetClientNewPoint")
		net.WriteEntity(ent)
		net.WriteString(ent.CaptureTeam)
   	net.Broadcast()
end

net.Receive( "UpgradePoint", function(len, ply)
	local ent = net.ReadEntity()
	local price = net.ReadInt(32)
	local action = net.ReadInt(3)

	if action == 1 then
		ent.UpgradeMonitor = ent.UpgradeMonitor + 1
	elseif action == 2 then
		ent.UpgradeComputer = ent.UpgradeComputer + 1
	end

	UpdatePointInfo(ent)
	
	net.Start("GivePointUpgrade")
		net.WriteEntity(ent)
		net.WriteInt(ent.UpgradeMonitor, 8)
		net.WriteInt(ent.UpgradeComputer, 8)
   	net.Broadcast()

	ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - price)
end)

net.Receive( "SpawnGuardianNPC", function(len, ply)
	local ent = net.ReadEntity()
	local npc_setting = net.ReadTable()
	
	local type_npc = npc_setting["npc"]
	local weap_npc = npc_setting["weapon"]
	local healthy = npc_setting["healthy"]
	local signal = npc_setting["signal"]
	local price = npc_setting["price"]

	local NPCList = list.Get("NPC")
	local NPCData = NPCList[type_npc]

	local guard = ents.Create( type_npc )
	guard:SetKeyValue("additionalequipment", weap_npc)

	local SpawnFlags = bit.bor(SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK)

	if (NPCData.SpawnFlags) then
		SpawnFlags = bit.bor(SpawnFlags, NPCData.SpawnFlags)
	end

	if (NPCData.TotalSpawnFlags) then
		SpawnFlags = NPCData.TotalSpawnFlags
	end

	guard:SetKeyValue("spawnflags", SpawnFlags)

	if (NPCData.KeyValues) then
		for k, v in pairs(NPCData.KeyValues) do
			guard:SetKeyValue(k, v)
		end
	end

	guard.WhiteFractionList = ent.CaptureTeam
	guard:SetPos(ent:GetPos() + Vector(0,0,500))
	guard:Spawn()
	guard:Activate()

	--guard:SetHealth(guard:GetMaxHealth() * 1)
	guard:SetHealth(guard:Health() * healthy)
	print(guard:Health())

	--guard.Behavior = VJ_BEHAVIOR_PASSIVE

	--guard:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)

	guard.SignalUpgrade = signal
	guard.SignalPoint = ent.CurPoint

	guard.Point = ent

	ent.GuardianCount = ent.GuardianCount + 1

	--NPC:SetLastPosition( Vector Position )

	--[[ if not timer.Exists(tostring(guard).."CheckIsAlive") then
		timer.Create(tostring(guard).."CheckIsAlive", 5, 0, function()
			if guard:IsValid() then
				guard_mem = guard
			else
				ent.GuardianCount = ent.GuardianCount - 1
				print(guard_mem)
				for k,v in pairs(player.GetAll()) do
					if v:GetNWString("PR_Fraction") == guard_mem.WhiteFractionList then
						v:ChatPrint("Я помер\nМоя изначальная точка: " .. guard_mem.SignalPoint)
					end
				end
				timer.Remove(tostring(guard_mem).."CheckIsAlive")
			end
		end)
	end ]]
	ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - price)
end)

net.Receive( "GetPointsCfgs", function()
	if not file.Exists("pr_gamemode", "DATA") then
		file.CreateDir("pr_gamemode")
	end

	if not file.Exists( "pr_gamemode/capture_points_list.txt", "DATA" ) then
		file.Write("pr_gamemode/capture_points_list.txt")
	end

	local SaveData = file.Read("pr_gamemode/capture_points_list.txt", "DATA")
	local config = util.JSONToTable(SaveData) or {}

	net.Start("GivePointsCfgs")
		net.WriteTable(config)
   	net.Broadcast()
end)

net.Receive( "SetServerPointsCfgs", function()
	local namecfg = net.ReadString()
	local ent = net.ReadEntity()
	local SaveData = file.Read("pr_gamemode/capture_points_list.txt", "DATA")
	local config = util.JSONToTable(SaveData) or {}
	
	PR_Capture_Points_List.Team = config[namecfg]["Team"]
	PR_Capture_Points_List.MonikUp = config[namecfg]["Monitor"]
	PR_Capture_Points_List.SistemnikUp = config[namecfg]["System"]

	ent.CurPoint = namecfg
end)

net.Receive("CreateNewCfgs", function()
	local cfgname = net.ReadString()
	local ent = net.ReadEntity()

	if not file.Exists("pr_gamemode", "DATA") then
		file.CreateDir("pr_gamemode")
	end

	if not file.Exists( "pr_gamemode/capture_points_list.txt", "DATA" ) then
		file.Write("pr_gamemode/capture_points_list.txt")
	end

	local SaveData = file.Read("pr_gamemode/capture_points_list.txt", "DATA")
	PR_Capture_Points_List.Config = util.JSONToTable(SaveData) or {}
	PR_Capture_Points_List.Config[cfgname] = {
		["Team"] = 0,
		["Monitor"] = 0,
		["System"] = 1
	}

	PR_Capture_Points_List.Config[cfgname]["Team"] = "Ничья"
	PR_Capture_Points_List.Config[cfgname]["Monitor"] = 0
	PR_Capture_Points_List.Config[cfgname]["System"] = 1

	ent.CurPoint = cfgname
	file.Write("pr_gamemode/capture_points_list.txt", util.TableToJSON(PR_Capture_Points_List.Config, true))
end)

net.Receive( "GetNewCfgs", function()
	local PointsTable = net.ReadTable()
	PR_Capture_Points_List.Team, PR_Capture_Points_List.MonikUp, PR_Capture_Points_List.SistemnikUp = PointsTable[1], PointsTable[2], PointsTable[3]
	net.Start("SetClientNewPoint")
		net.WriteTable(PointsTable)
   	net.Broadcast()
end )

net.Receive( "SetPoint", function()
	local ent = net.ReadEntity()
	local namecfg = ent.CurPoint
	local SaveData = file.Read("pr_gamemode/capture_points_list.txt", "DATA")
	local config = util.JSONToTable(SaveData) or {}
	
	ent.CaptureTeam = config[namecfg]["Team"]
	ent.UpgradeMonitor = config[namecfg]["Monitor"]
	ent.UpgradeComputer = config[namecfg]["System"]
	
	net.Start("GivePointEnt")
		net.WriteEntity(ent)
		net.WriteString(config[namecfg]["Team"])
		net.WriteInt(config[namecfg]["Monitor"], 8)
		net.WriteInt(config[namecfg]["System"], 8)
   	net.Broadcast()
end)