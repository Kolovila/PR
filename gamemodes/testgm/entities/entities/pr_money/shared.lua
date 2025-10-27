function ENT:SetupDataTables()
   self:NetworkVar("Int", 0, "Value")
end

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Category = "TestPR"

ENT.PrintName = "Money"
ENT.Author = "Loh"
ENT.Contact = ""
ENT.Purpose = "Physical version of money"
ENT.Instructions = "Pick up, make money"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/props/cs_assault/money.mdl"