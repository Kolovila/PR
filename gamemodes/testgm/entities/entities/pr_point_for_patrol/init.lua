AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetColor( Color( 0, 255, 0, 255 ) ) 
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_BSP)
	
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	
	if (IsValid(phys)) then
		phys:Wake()
	end
end

function ENT:SpawnFunction(ply, tr, ClassName)
	if(!tr.Hit) then return end
	
	tr.start = ply:EyePos()
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector()
	tr.filter = ply
	
	local trace = util.TraceLine(tr)
	
	local ent = ents.Create(ClassName)
	--ent:SetModel(self.SpawnModel)
	ent:SetPos(trace.HitPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT.SetPatrolSettings(name, numNow, self, posNow)
	self.PatrolName = name
	self.PosNow = posNow
	self.SetModelType(numNow, self)
end	

function ENT.SetModelType(numNow, self)
	print(NumNow)
	if numNow == 0 then
		self:SetModel(self.SpawnModel)
	else
		self:SetModel(self.PointModel)
	end
end	

function ENT:Use(activator, caller)
	print(self.PatrolName)
	print(self.PosNow)
	table.RemoveByValue(PR_Patrols_List[self.PatrolName][1]["Points"], self.PosNow)
	print("VVVVVVVVVVVVVVVVVVVVVVVVV")
	PrintTable(PR_Patrols_List[self.PatrolName][1]["Points"])
	print("^^^^^^^^^^^^^^^^^^^^^^^^^")
   	self:Remove()
end