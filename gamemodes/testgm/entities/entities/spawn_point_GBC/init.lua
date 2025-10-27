AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

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
	
	return entityforpr
end

function ENT:Use(activator, caller)
	if activator:GetNWBool("PR_leader_GBC") == true then
		spawnX = self:GetPos().x
		spawnY = self:GetPos().y
		spawnZ = self:GetPos().z

		for k, v in pairs(player.GetAll()) do
			if v:GetNWString("PR_fraction") == "GBC" then
				hook.Add( "PlayerSpawn", "some_unique_name",
				function(ply)
					for k, v in pairs(player.GetAll()) do
						if v:GetNWString("PR_fraction") == "GBC" then
							ply:SetPos(Vector(spawnX + math.random(-100, 100), spawnY + math.random(-100, 100), spawnZ + 50))
						end
					end
				end)
				self:PhysicsInit(SOLID_VPHYSICS)
				self:SetMoveType(MOVETYPE_VPHYSICS)
				self:SetSolid(SOLID_BSP)
			end
		end
	activator:ChatPrint("Точка респавна активирована")
	self:SetColor(Color(255,0,0))
	end
end


function ENT:Think()

end

	

function ENT:OnTakeDamage(damage)
   self:SetHealth(self:Health() - damage:GetDamage())
   
    if (self:Health() <= 0) then
		self:Remove()
	end
end


function ENT:OnRemove()
	for k, v in pairs(player.GetAll()) do
		if v:GetNWString("PR_fraction") == "GBC" then
			v:ChatPrint("Вашу точку респавна сломали!")
			hook.Add( "PlayerSpawn", "some_unique_name",
			function(ply)
				for k, v in pairs(player.GetAll()) do
					if v:GetNWString("PR_fraction") == "GBC" then
					end
				end
			end)
		end
	end
end