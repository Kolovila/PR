local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
     name = "Loh",
	 color = Vector(0,0,0),
	 model = "models/pm/moviebaddies/baddie3.mdl",
	 weapons = {""}
}
teams[1] = {
     name = "SSNK",
	 color = Vector(255,0,0),
	 model = "models/steinman/bf4/ru_02.mdl",
	 weapons = {}
}
teams[2] = {
     name = "USA",
	 color = Vector(0,0,255),
	 model = "models/ninja/mgs4_pieuvre_armament_merc.mdl",
	 weapons = {}
}

teams[3] = {
     name = "GBC",
	 color = Vector(255,130,0),
	 model = "models/player/polizei/ct_urban.mdl",
	 weapons = {}
}

teams[4] = {
     name = "WN",
	 color = Vector(0,255,0),
	 model = "models/mw2/skin_09/mw2_soldier_05.mdl",
	 weapons = {}
}


function ply:SetupTeam (n)

   if (not teams[n]) then return end
   
   self:SetTeam(n)
   self:SetPlayerColor(teams[n].color)
   self:SetHealth (100)
   self:SetMaxHealth(100)
   self:SetWalkSpeed(100)
   self:SetRunSpeed(200) 
   self:SetModel(teams[n].model)
   print(n)
end