function buyEntity(ply, cmd, args)
   if (args[1] != nil) then
       local ent = ents.Create(args[1])
	   local tr = ply:GetEyeTrace()
	   --local balance = ply:GetNWInt("Money")
	   
	   --if(ent:IsValid())then
	    if (IsValid(ent)) then
	    local ClassName = ent:GetClass()
	   
    if(!tr.Hit) then return end
   
   local entCount = ply:GetNWInt(ClassName .. "count")
   
   --if (entCount < ent.Limit && balance >= ent.Cost) then
   if(!ent.Limit or entCount < ent.Limit) then
      if (ply:CanAfford(ent.Cost)) then
      local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80
   
         ent.Owner = ply
   
         ent:SetPos(SpawnPos)
         ent:Spawn()
         ent:Activate()
   
         --ply:SetNWInt("Money", balance - ent.Cost)
		 ply:RemoveFromBalance(ent.Cost)
         ply:SetNWInt(ClassName .. "count", entCount + 1)
   
         return ent
		 else

		    end

            end
		   
            return
	   end
   end
end

--Команды
LFCC = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
function SetupMenuTeamLoh (ply)
	ply:SetupTeam(0)
	ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	ply:SetNWInt("TeamRN", 1)
	ply:SetPData("TeamRN",ply:GetNWInt("TeamRN"))
	
	local teamForLoh = {"SSNK","USA","GBC","WN"}
	
	for k,v in ipairs(teamForLoh) do
		ply:SetNWInt("Team".. v, 0)
		ply:SetPData("Team".. v,ply:GetNWInt("Team".. v))
		ply:SetNWInt("LeaderTeam".. v, 0)
		ply:SetPData("LeaderTeam".. v,ply:GetNWInt("LeaderTeam".. v))
	end
end 

function SetupMenuTeamSSNK (ply)
	ply:SetupTeam(1)
	ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	if ply:GetNWInt("LeaderTeamSSNK") == 1 then
		ply:SetModel("models/player/bf3russians/russian_camo_6.mdl")
		ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
		ply:SetBodygroup(1,3)
		ply:SetBodygroup(2,1)
		ply:SetBodygroup(3,4)
		ply:SetBodygroup(4,4)
	end
	ply:SetNWInt("TeamSSNK", 1)
	ply:SetPData("TeamSSNK",ply:GetNWInt("TeamSSNK"))
	ply:SetNWInt("TeamRN", 0)
	ply:SetPData("TeamRN",ply:GetNWInt("TeamRN"))
	
	local teamForSSNK = {"USA","GBC","WN"}
	
	for k,v in ipairs(teamForSSNK) do
		ply:SetNWInt("Team".. v, 0)
		ply:SetPData("Team".. v,ply:GetNWInt("Team".. v))
		ply:SetNWInt("LeaderTeam".. v, 0)
		ply:SetPData("LeaderTeam".. v,ply:GetNWInt("LeaderTeam".. v))
	end
end 

function SetupMenuTeamUSA (ply)
	ply:SetupTeam(2)
	ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	ply:SetBodygroup(8,4)
	if ply:GetNWInt("LeaderTeamUSA") == 1 then
		ply:SetModel("models/Ninja/BF3/player/us_bill.mdl")
		ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	end
	ply:SetNWInt("TeamUSA", 1)
	ply:SetPData("TeamUSA",ply:GetNWInt("TeamUSA"))
	ply:SetNWInt("TeamRN", 0)
	ply:SetPData("TeamRN",ply:GetNWInt("TeamRN"))
	
	local teamForUSA = {"SSNK","GBC","WN"}
	
	for k,v in ipairs(teamForUSA) do
		ply:SetNWInt("Team".. v, 0)
		ply:SetPData("Team".. v,ply:GetNWInt("Team".. v))
		ply:SetNWInt("LeaderTeam".. v, 0)
		ply:SetPData("LeaderTeam".. v,ply:GetNWInt("LeaderTeam".. v))
	end
end 

function SetupMenuTeamGBC (ply)
	ply:SetupTeam(3)
	ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	if ply:GetNWInt("LeaderTeamGBC") == 1 then
		ply:SetModel("models/player/PMC_4/PMC__01.mdl")
		ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	end
	ply:SetNWInt("TeamGBC", 1)
	ply:SetPData("TeamGBC",ply:GetNWInt("TeamGBC"))
	ply:SetNWInt("TeamRN", 0)
	ply:SetPData("TeamRN",ply:GetNWInt("TeamRN"))
	
	local teamForGBC = {"SSNK","USA","WN"}
	
	for k,v in ipairs(teamForGBC) do
		ply:SetNWInt("Team".. v, 0)
		ply:SetPData("Team".. v,ply:GetNWInt("Team".. v))
		ply:SetNWInt("LeaderTeam".. v, 0)
		ply:SetPData("LeaderTeam".. v,ply:GetNWInt("LeaderTeam".. v))
	end
end

function SetupMenuTeamWN (ply)
	ply:SetupTeam(4)
	ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	if ply:GetNWInt("LeaderTeamWN") == 1 then
		ply:SetModel("models/csgosas3pm.mdl")
		ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
	end
	ply:SetNWInt("TeamWN", 1)
	ply:SetPData("TeamWN",ply:GetNWInt("TeamWN"))
	ply:SetNWInt("TeamRN", 0)
	ply:SetPData("TeamRN",ply:GetNWInt("TeamRN"))
	
	local teamForWN = {"SSNK","USA","GBC"}
	
	for k,v in ipairs(teamForWN) do
		ply:SetNWInt("Team".. v, 0)
		ply:SetPData("Team".. v,ply:GetNWInt("Team".. v))
		ply:SetNWInt("LeaderTeam".. v, 0)
		ply:SetPData("LeaderTeam".. v,ply:GetNWInt("LeaderTeam".. v))
	end
end 
--Команды

--Одежда 
-----------SSNK------------------------------------------------------------------SSNK-----------
concommand.Add("set_SSNKcloth1", function (ply) local unlockSSNKcloth1=ply:GetNWInt("UnlockSSNKcloth1") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth1 == 0 and levelSSNK >= 1 then ply:SetNWInt("UnlockSSNKcloth1", 1) ply:SetModel("models/steinman/bf4/ru_02.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth1", ply:GetNWInt("UnlockSSNKcloth1")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth1 == 1 then ply:SetModel("models/steinman/bf4/ru_02.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth2", function (ply) local unlockSSNKcloth2=ply:GetNWInt("UnlockSSNKcloth2") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth2 == 0 and levelSSNK >= 3 then ply:SetNWInt("UnlockSSNKcloth2", 1) ply:SetModel("models/russianfed/rooskie4.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth2", ply:GetNWInt("UnlockSSNKcloth2")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end  ply:SetBodygroup(1,0) ply:SetBodygroup(3,1) ply:SetBodygroup(6,1) ply:SetBodygroup(7,2) ply:SetBodygroup(8,0) ply:SetBodygroup(11,1)
elseif unlockSSNKcloth2 == 1 then ply:SetModel("models/russianfed/rooskie4.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(1,0) ply:SetBodygroup(3,1) ply:SetBodygroup(6,1) ply:SetBodygroup(7,2) ply:SetBodygroup(8,0) ply:SetBodygroup(11,1) end end)

concommand.Add("set_SSNKcloth3", function (ply) local unlockSSNKcloth3=ply:GetNWInt("UnlockSSNKcloth3") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth3 == 0 and levelSSNK >= 5 then ply:SetNWInt("UnlockSSNKcloth3", 1) ply:SetModel("models/russianfed/rooskie3b.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth3", ply:GetNWInt("UnlockSSNKcloth3")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(1,0) ply:SetBodygroup(6,0) ply:SetBodygroup(7,2)
elseif unlockSSNKcloth3 == 1 then ply:SetModel("models/russianfed/rooskie3b.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(1,0) ply:SetBodygroup(6,0) ply:SetBodygroup(7,2) end end)

concommand.Add("set_SSNKcloth4", function (ply) local unlockSSNKcloth4=ply:GetNWInt("UnlockSSNKcloth4") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth4 == 0 and levelSSNK >= 7 and balance >= 1000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-1000) ply:SetNWInt("UnlockSSNKcloth4", 1) ply:SetModel("models/player/spetsnaz/spetsnaz_05.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth4", ply:GetNWInt("UnlockSSNKcloth4")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth4 == 1 then ply:SetModel("models/player/spetsnaz/spetsnaz_05.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth5", function (ply) local unlockSSNKcloth5=ply:GetNWInt("UnlockSSNKcloth5") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth5 == 0 and levelSSNK >= 9 and balance >= 2000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-2000) ply:SetNWInt("UnlockSSNKcloth5", 1) ply:SetModel("models/steinman/bf4/ru_03.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth5", ply:GetNWInt("UnlockSSNKcloth5")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth5 == 1 then ply:SetModel("models/steinman/bf4/ru_03.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth6", function (ply) local unlockSSNKcloth6=ply:GetNWInt("UnlockSSNKcloth6") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth6 == 0 and levelSSNK >= 11 and balance >= 4000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-4000) ply:SetNWInt("UnlockSSNKcloth6", 1) ply:SetModel("models/steinman/bf4/ru_01.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth6", ply:GetNWInt("UnlockSSNKcloth6")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth6 == 1 then ply:SetModel("models/steinman/bf4/ru_01.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth7", function (ply) local unlockSSNKcloth7=ply:GetNWInt("UnlockSSNKcloth7") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth7 == 0 and levelSSNK >= 13 and balance >= 7000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-7000) ply:SetNWInt("UnlockSSNKcloth7", 1) ply:SetModel("models/player/spetsnaz/spetsnaz_07.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth7", ply:GetNWInt("UnlockSSNKcloth7")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(3,5)
elseif unlockSSNKcloth7 == 1 then ply:SetModel("models/player/spetsnaz/spetsnaz_07.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(3,5) end end)

concommand.Add("set_SSNKcloth8", function (ply) local unlockSSNKcloth8=ply:GetNWInt("UnlockSSNKcloth8") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth8 == 0 and levelSSNK >= 15 and balance >= 11000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-11000) ply:SetNWInt("UnlockSSNKcloth8", 1) ply:SetModel("models/steinman/bf4/ru_04.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth8", ply:GetNWInt("UnlockSSNKcloth8")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth8 == 1 then ply:SetModel("models/steinman/bf4/ru_04.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth9", function (ply) local unlockSSNKcloth9=ply:GetNWInt("UnlockSSNKcloth9") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth9 == 0 and levelSSNK >= 17 and balance >= 16000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-16000) ply:SetNWInt("UnlockSSNKcloth9", 1) ply:SetModel("models/player/r6s_kapkan.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth9", ply:GetNWInt("UnlockSSNKcloth9")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth9 == 1 then ply:SetModel("models/player/r6s_kapkan.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth10", function (ply) local unlockSSNKcloth10=ply:GetNWInt("UnlockSSNKcloth10") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth10 == 0 and levelSSNK >= 18 and balance >= 21000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-21000) ply:SetNWInt("UnlockSSNKcloth10", 1) ply:SetModel("models/auditor/r6s/spetsnaz/tachanka/chr_spetsnaz_turret3.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth10", ply:GetNWInt("UnlockSSNKcloth10")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth10 == 1 then ply:SetModel("models/auditor/r6s/spetsnaz/tachanka/chr_spetsnaz_turret3.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth11", function (ply) local unlockSSNKcloth11=ply:GetNWInt("UnlockSSNKcloth11") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth11 == 0 and levelSSNK >= 19 and balance >= 27000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-27000) ply:SetNWInt("UnlockSSNKcloth11", 1) ply:SetModel("models/player/mgstps_sovietsoldier.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth11", ply:GetNWInt("UnlockSSNKcloth11")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth11 == 1 then ply:SetModel("models/player/mgstps_sovietsoldier.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_SSNKcloth12", function (ply) local unlockSSNKcloth12=ply:GetNWInt("UnlockSSNKcloth12") local balance=ply:GetNWInt("Money") local levelSSNK=ply:GetNWInt("SSNKLVL")
if unlockSSNKcloth12 == 0 and levelSSNK >= 20 and balance >= 34000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-34000) ply:SetNWInt("UnlockSSNKcloth12", 1) ply:SetModel("models/jq/codmw2019/russian_j-12_player.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockSSNKcloth12", ply:GetNWInt("UnlockSSNKcloth12")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockSSNKcloth12 == 1 then ply:SetModel("models/jq/codmw2019/russian_j-12_player.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)
-----------SSNK------------------------------------------------------------------SSNK-----------

-----------USA------------------------------------------------------------------USA-------------
concommand.Add("set_USAcloth1", function (ply) local unlockUSAcloth1=ply:GetNWInt("UnlockUSAcloth1") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth1 == 0 and levelUSA >= 1 then ply:SetNWInt("UnlockUSAcloth1", 1) ply:SetModel("models/ninja/mgs4_pieuvre_armament_merc.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth1", ply:GetNWInt("UnlockUSAcloth1")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(8,4)
elseif unlockUSAcloth1 == 1 then ply:SetModel("models/ninja/mgs4_pieuvre_armament_merc.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(8,4) end end)

concommand.Add("set_USAcloth2", function (ply) local unlockUSAcloth2=ply:GetNWInt("UnlockUSAcloth2") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth2 == 0 and levelUSA >= 3 then ply:SetNWInt("UnlockUSAcloth2", 1) ply:SetModel("models/steinman/bf4/us_02.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth2", ply:GetNWInt("UnlockUSAcloth2")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth2 == 1 then ply:SetModel("models/steinman/bf4/us_02.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth3", function (ply) local unlockUSAcloth3=ply:GetNWInt("UnlockUSAcloth3") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth3 == 0 and levelUSA >= 5 then ply:SetNWInt("UnlockUSAcloth3", 1) ply:SetModel("models/steinman/bf4/us_03.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth3", ply:GetNWInt("UnlockUSAcloth3")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth3 == 1 then ply:SetModel("models/steinman/bf4/us_03.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth4", function (ply) local unlockUSAcloth4=ply:GetNWInt("UnlockUSAcloth4") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth4 == 0 and levelUSA >= 7 and balance >= 1000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-1000) ply:SetNWInt("UnlockUSAcloth4", 1) ply:SetModel("models/csgofbi1pm.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth4", ply:GetNWInt("UnlockUSAcloth4")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth4 == 1 then ply:SetModel("models/csgofbi1pm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth5", function (ply) local unlockUSAcloth5=ply:GetNWInt("UnlockUSAcloth5") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth5 == 0 and levelUSA >= 9 and balance >= 2000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-2000) ply:SetNWInt("UnlockUSAcloth5", 1) ply:SetModel("models/ninja/bf3/player/us_test_shemagh.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth5", ply:GetNWInt("UnlockUSAcloth5")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth5 == 1 then ply:SetModel("models/ninja/bf3/player/us_test_shemagh.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth6", function (ply) local unlockUSAcloth6=ply:GetNWInt("UnlockUSAcloth6") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth6 == 0 and levelUSA >= 11 and balance >= 4000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-4000) ply:SetNWInt("UnlockUSAcloth6", 1) ply:SetModel("models/ninja/bf3/player/us_nick.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth6", ply:GetNWInt("UnlockUSAcloth6")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth6 == 1 then ply:SetModel("models/ninja/bf3/player/us_nick.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth7", function (ply) local unlockUSAcloth7=ply:GetNWInt("UnlockUSAcloth7") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth7 == 0 and levelUSA >= 13 and balance >= 7000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-7000) ply:SetNWInt("UnlockUSAcloth7", 1) ply:SetModel("models/steinman/bf4/us_04.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth7", ply:GetNWInt("UnlockUSAcloth7")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth7 == 1 then ply:SetModel("models/steinman/bf4/us_04.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth8", function (ply) local unlockUSAcloth8=ply:GetNWInt("UnlockUSAcloth8") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth8 == 0 and levelUSA >= 15 and balance >= 11000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-11000) ply:SetNWInt("UnlockUSAcloth8", 1) ply:SetModel("models/artel/usssoldier/uss_soldier.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth8", ply:GetNWInt("UnlockUSAcloth8")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth8 == 1 then ply:SetModel("models/artel/usssoldier/uss_soldier.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth9", function (ply) local unlockUSAcloth9=ply:GetNWInt("UnlockUSAcloth9") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth9 == 0 and levelUSA >= 17 and balance >= 16000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-16000) ply:SetNWInt("UnlockUSAcloth9", 1) ply:SetModel("models/konnie/asapgaming/modernwarfare/grinchghillie.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth9", ply:GetNWInt("UnlockUSAcloth9")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth9 == 1 then ply:SetModel("models/konnie/asapgaming/modernwarfare/grinchghillie.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth10", function (ply) local unlockUSAcloth10=ply:GetNWInt("UnlockUSAcloth10") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth10 == 0 and levelUSA >= 18 and balance >= 21000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-21000) ply:SetNWInt("UnlockUSAcloth10", 1) ply:SetModel("models/styrofoam/bf4/us_assaultpm.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth10", ply:GetNWInt("UnlockUSAcloth10")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth10 == 1 then ply:SetModel("models/styrofoam/bf4/us_assaultpm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth11", function (ply) local unlockUSAcloth11=ply:GetNWInt("UnlockUSAcloth11") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth11 == 0 and levelUSA >= 19 and balance >= 27000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-27000) ply:SetNWInt("UnlockUSAcloth11", 1) ply:SetModel("models/npc/fbi_assault_npc.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth11", ply:GetNWInt("UnlockUSAcloth11")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth11 == 1 then ply:SetModel("models/npc/fbi_assault_npc.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_USAcloth12", function (ply) local unlockUSAcloth12=ply:GetNWInt("UnlockUSAcloth12") local balance=ply:GetNWInt("Money") local levelUSA=ply:GetNWInt("USALVL")
if unlockUSAcloth12 == 0 and levelUSA >= 20 and balance >= 34000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-34000) ply:SetNWInt("UnlockUSAcloth12", 1) ply:SetModel("models/auditor/r6s/navy/blackbeard/chr_navy_richochet.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockUSAcloth12", ply:GetNWInt("UnlockUSAcloth12")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockUSAcloth12 == 1 then ply:SetModel("models/auditor/r6s/navy/blackbeard/chr_navy_richochet.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)
-----------USA------------------------------------------------------------------USA-----------

-----------GBC------------------------------------------------------------------GBC-----------
concommand.Add("set_GBCcloth1", function (ply) local unlockGBCcloth1=ply:GetNWInt("UnlockGBCcloth1") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth1 == 0 and levelGBC >= 1 then ply:SetNWInt("UnlockGBCcloth1", 1) ply:SetModel("models/player/polizei/ct_urban.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth1", ply:GetNWInt("UnlockGBCcloth1")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth1 == 1 then ply:SetModel("models/player/polizei/ct_urban.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth2", function (ply) local unlockGBCcloth2=ply:GetNWInt("UnlockGBCcloth2") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth2 == 0 and levelGBC >= 3 then ply:SetNWInt("UnlockGBCcloth2", 1) ply:SetModel("models/player/enhancedgsg9.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth2", ply:GetNWInt("UnlockGBCcloth2")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth2 == 1 then ply:SetModel("models/player/enhancedgsg9.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth3", function (ply) local unlockGBCcloth3=ply:GetNWInt("UnlockGBCcloth3") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth3 == 0 and levelGBC >= 5 then ply:SetNWInt("UnlockGBCcloth3", 1) ply:SetModel("models/player/pmc_5/pmc__04.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth2", ply:GetNWInt("UnlockGBCcloth3")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth3 == 1 then ply:SetModel("models/player/pmc_5/pmc__04.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth4", function (ply) local unlockGBCcloth4=ply:GetNWInt("UnlockGBCcloth4") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth4 == 0 and levelGBC >= 7 and balance >= 1000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-1000) ply:SetNWInt("UnlockGBCcloth4", 1) ply:SetModel("models/player/pmc_4/pmc__14.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth2", ply:GetNWInt("UnlockGBCcloth4")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth4 == 1 then ply:SetModel("models/player/pmc_4/pmc__14.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth5", function (ply) local unlockGBCcloth5=ply:GetNWInt("UnlockGBCcloth5") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth5 == 0 and levelGBC >= 9 and balance >= 2000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-2000) ply:SetNWInt("UnlockGBCcloth5", 1) ply:SetModel("models/player/polizei/ct_sas.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth5", ply:GetNWInt("UnlockGBCcloth5")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth5 == 1 then ply:SetModel("models/player/polizei/ct_sas.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth6", function (ply) local unlockGBCcloth6=ply:GetNWInt("UnlockGBCcloth6") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth6 == 0 and levelGBC >= 11 and balance >= 4000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-4000) ply:SetNWInt("UnlockGBCcloth6", 1) ply:SetModel("models/madivan18/gsg9/gsg9_karlt_v2_crye_player.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth6", ply:GetNWInt("UnlockGBCcloth6")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth6 == 1 then ply:SetModel("models/madivan18/gsg9/gsg9_karlt_v2_crye_player.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth7", function (ply) local unlockGBCcloth7=ply:GetNWInt("UnlockGBCcloth7") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth7 == 0 and levelGBC >= 13 and balance >= 7000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-7000) ply:SetNWInt("UnlockGBCcloth7", 1) ply:SetModel("models/player/pmc_5/pmc__06.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth7", ply:GetNWInt("UnlockGBCcloth7")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth7 == 1 then ply:SetModel("models/player/pmc_5/pmc__06.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth8", function (ply) local unlockGBCcloth8=ply:GetNWInt("UnlockGBCcloth8") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth8 == 0 and levelGBC >= 15 and balance >= 11000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-11000) ply:SetNWInt("UnlockGBCcloth8", 1) ply:SetModel("models/player/pmc_5/pmc__01.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth8", ply:GetNWInt("UnlockGBCcloth8")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth8 == 1 then ply:SetModel("models/player/pmc_5/pmc__01.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth9", function (ply) local unlockGBCcloth9=ply:GetNWInt("UnlockGBCcloth9") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth9 == 0 and levelGBC >= 17 and balance >= 16000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-16000) ply:SetNWInt("UnlockGBCcloth9", 1) ply:SetModel("models/auditor/r6s/rook/chr_gign_lifeline_ash_engset.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth9", ply:GetNWInt("UnlockGBCcloth9")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(6,1)
elseif unlockGBCcloth9 == 1 then ply:SetModel("models/auditor/r6s/rook/chr_gign_lifeline_ash_engset.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(6,1) end end)

concommand.Add("set_GBCcloth10", function (ply) local unlockGBCcloth10=ply:GetNWInt("UnlockGBCcloth10") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth10 == 0 and levelGBC >= 18 and balance >= 21000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-21000) ply:SetNWInt("UnlockGBCcloth10", 1) ply:SetModel("models/ninja/mgs4_raven_sword_merc.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth10", ply:GetNWInt("UnlockGBCcloth10")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth10 == 1 then ply:SetModel("models/ninja/mgs4_raven_sword_merc.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth11", function (ply) local unlockGBCcloth11=ply:GetNWInt("UnlockGBCcloth11") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth11 == 0 and levelGBC >= 19 and balance >= 27000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-27000) ply:SetNWInt("UnlockGBCcloth11", 1) ply:SetModel("models/gsgpm.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth11", ply:GetNWInt("UnlockGBCcloth11")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth11 == 1 then ply:SetModel("models/gsgpm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_GBCcloth12", function (ply) local unlockGBCcloth12=ply:GetNWInt("UnlockGBCcloth12") local balance=ply:GetNWInt("Money") local levelGBC=ply:GetNWInt("GBCLVL")
if unlockGBCcloth12 == 0 and levelGBC >= 20 and balance >= 34000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-34000) ply:SetNWInt("UnlockGBCcloth12", 1) ply:SetModel("models/player/r6s_jager.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockGBCcloth12", ply:GetNWInt("UnlockGBCcloth12")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockGBCcloth12 == 1 then ply:SetModel("models/player/r6s_jager.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)
-----------GBC------------------------------------------------------------------GBC-----------

-----------WN------------------------------------------------------------------WN-------------
concommand.Add("set_WNcloth1", function (ply) local unlockWNcloth1=ply:GetNWInt("UnlockWNcloth1") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth1 == 0 and levelWN >= 1 then ply:SetNWInt("UnlockWNcloth1", 1) ply:SetModel("models/mw2/skin_09/mw2_soldier_05.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth1", ply:GetNWInt("UnlockWNcloth1")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth1 == 1 then ply:SetModel("models/mw2/skin_09/mw2_soldier_05.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth2", function (ply) local unlockWNcloth2=ply:GetNWInt("UnlockWNcloth2") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth2 == 0 and levelWN >= 3 then ply:SetNWInt("UnlockWNcloth2", 1) ply:SetModel("models/pm/moviesf/operator2c.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth2", ply:GetNWInt("UnlockWNcloth2")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth2 == 1 then ply:SetModel("models/pm/moviesf/operator2c.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth3", function (ply) local unlockWNcloth3=ply:GetNWInt("UnlockWNcloth3") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth3 == 0 and levelWN >= 5 then ply:SetNWInt("UnlockWNcloth3", 1) ply:SetModel("models/mw2/skin_09/mw2_soldier_01.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth3", ply:GetNWInt("UnlockWNcloth3")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth3 == 1 then ply:SetModel("models/mw2/skin_09/mw2_soldier_01.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth4", function (ply) local unlockWNcloth4=ply:GetNWInt("UnlockWNcloth4") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth4 == 0 and levelWN >= 7 and balance >= 1000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-1000) ply:SetNWInt("UnlockWNcloth4", 1) ply:SetModel("models/csleader/paapmc/player/pgac_def_soldier2_pm.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth4", ply:GetNWInt("UnlockWNcloth4")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth4 == 1 then ply:SetModel("models/csleader/paapmc/player/pgac_def_soldier2_pm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth5", function (ply) local unlockWNcloth5=ply:GetNWInt("UnlockWNcloth5") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth5 == 0 and levelWN >= 9 and balance >= 2000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-2000) ply:SetNWInt("UnlockWNcloth5", 1) ply:SetModel("models/yukon/hecu/hecu_01_player.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth5", ply:GetNWInt("UnlockWNcloth5")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(17,1) ply:SetBodygroup(19,2) ply:SetBodygroup(20,7)
elseif unlockWNcloth5 == 1 then ply:SetModel("models/yukon/hecu/hecu_01_player.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(17,1) ply:SetBodygroup(19,2) ply:SetBodygroup(20,7) end end)

concommand.Add("set_WNcloth6", function (ply) local unlockWNcloth6=ply:GetNWInt("UnlockWNcloth6") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth6 == 0 and levelWN >= 11 and balance >= 4000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-4000) ply:SetNWInt("UnlockWNcloth6", 1) ply:SetModel("models/mw2/skin_09/mw2_soldier_03.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth6", ply:GetNWInt("UnlockWNcloth6")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth6 == 1 then ply:SetModel("models/mw2/skin_09/mw2_soldier_03.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth7", function (ply) local unlockWNcloth7=ply:GetNWInt("UnlockWNcloth7") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth7 == 0 and levelWN >= 13 and balance >= 7000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-7000) ply:SetNWInt("UnlockWNcloth7", 1) ply:SetModel("models/player/test/t_arctic.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth7", ply:GetNWInt("UnlockWNcloth7")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth7 == 1 then ply:SetModel("models/player/test/t_arctic.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth8", function (ply) local unlockWNcloth8=ply:GetNWInt("UnlockWNcloth8") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth8 == 0 and levelWN >= 15 and balance >= 11000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-11000) ply:SetNWInt("UnlockWNcloth8", 1) ply:SetModel("models/csleader/paapmc/player/pgac_soldier_aali_pm.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth8", ply:GetNWInt("UnlockWNcloth8")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth8 == 1 then ply:SetModel("models/csleader/paapmc/player/pgac_soldier_aali_pm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth9", function (ply) local unlockWNcloth9=ply:GetNWInt("UnlockWNcloth9") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth9 == 0 and levelWN >= 17 and balance >= 16000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-16000) ply:SetNWInt("UnlockWNcloth9", 1) ply:SetModel("models/mw2/skin_09/mw2_soldier_06.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth9", ply:GetNWInt("UnlockWNcloth9")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(2,1) ply:SetBodygroup(4,3)
elseif unlockWNcloth9 == 1 then ply:SetModel("models/mw2/skin_09/mw2_soldier_06.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(2,1) ply:SetBodygroup(4,3) end end)

concommand.Add("set_WNcloth10", function (ply) local unlockWNcloth10=ply:GetNWInt("UnlockWNcloth10") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth10 == 0 and levelWN >= 18 and balance >= 21000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-21000) ply:SetNWInt("UnlockWNcloth10", 1) ply:SetModel("models/ninja/mgs4_praying_mantis_merc.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth10", ply:GetNWInt("UnlockWNcloth10")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetSkin(1)
elseif unlockWNcloth10 == 1 then ply:SetModel("models/ninja/mgs4_praying_mantis_merc.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetSkin(1) end end)

concommand.Add("set_WNcloth11", function (ply) local unlockWNcloth11=ply:GetNWInt("UnlockWNcloth11") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth11 == 0 and levelWN >= 19 and balance >= 27000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-27000) ply:SetNWInt("UnlockWNcloth11", 1) ply:SetModel("models/csleader/paapmc/player/pgac_heavy_support_pm.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth11", ply:GetNWInt("UnlockWNcloth11")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
elseif unlockWNcloth11 == 1 then ply:SetModel("models/csleader/paapmc/player/pgac_heavy_support_pm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_WNcloth12", function (ply) local unlockWNcloth12=ply:GetNWInt("UnlockWNcloth12") local balance=ply:GetNWInt("Money") levelWN=ply:GetNWInt("WNLVL")
if unlockWNcloth12 == 0 and levelWN >= 20 and balance >= 34000 then ply:SetNWInt("Money", ply:GetNWInt("Money")-34000) ply:SetNWInt("UnlockWNcloth12", 1) ply:SetModel("models/motoess/sas/sas-2.mdl")
ply:SetPData("Money",ply:GetNWInt("Money")) ply:SetPData("UnlockWNcloth12", ply:GetNWInt("UnlockWNcloth12")) ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(15,1)
elseif unlockWNcloth12 == 1 then ply:SetModel("models/motoess/sas/sas-2.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetBodygroup(15,1) end end)
-----------WN------------------------------------------------------------------WN-----------

-----------RN------------------------------------------------------------------RN-----------
concommand.Add("set_RNcloth1", function (ply) local unlockRNcloth1=ply:GetNWInt("UnlockRNcloth1") level=ply:GetNWInt("LVL")
if unlockRNcloth1 == 0 and level >= 1 then ply:SetNWInt("UnlockRNcloth1", 1) ply:SetModel("models/pm/moviebaddies/baddie3.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
ply:SetPData("UnlockRNcloth1", ply:GetNWInt("UnlockRNcloth1"))
elseif unlockRNcloth1 == 1 then ply:SetModel("models/pm/moviebaddies/baddie3.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_RNcloth2", function (ply) local unlockRNcloth2=ply:GetNWInt("UnlockRNcloth2") level=ply:GetNWInt("LVL")
if unlockRNcloth2 == 0 and level >= 3 then ply:SetNWInt("UnlockRNcloth2", 1) ply:SetModel("models/player/vympel/t_phoenix.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
ply:SetPData("UnlockRNcloth2", ply:GetNWInt("UnlockRNcloth2"))
elseif unlockRNcloth2 == 1 then ply:SetModel("models/player/vympel/t_phoenix.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_RNcloth3", function (ply) local unlockRNcloth3=ply:GetNWInt("UnlockRNcloth3") level=ply:GetNWInt("LVL")
if unlockRNcloth3 == 0 and level >= 5 then ply:SetNWInt("UnlockRNcloth3", 1) ply:SetModel("models/player/vympel/t_leet.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
ply:SetPData("UnlockRNcloth3", ply:GetNWInt("UnlockRNcloth3"))
elseif unlockRNcloth3 == 1 then ply:SetModel("models/player/vympel/t_leet.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_RNcloth4", function (ply) local unlockRNcloth4=ply:GetNWInt("UnlockRNcloth4") level=ply:GetNWInt("LVL")
if unlockRNcloth4 == 0 and level >= 7 then ply:SetNWInt("UnlockRNcloth4", 1) ply:SetModel("models/chemicalagentpm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetSkin(3) ply:SetBodygroup(3,3) ply:SetBodygroup(4,3) ply:SetBodygroup(2,1)
ply:SetPData("UnlockRNcloth4", ply:GetNWInt("UnlockRNcloth4"))
elseif unlockRNcloth4 == 1 then ply:SetModel("models/chemicalagentpm.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end ply:SetSkin(3) ply:SetBodygroup(3,3) ply:SetBodygroup(4,3) ply:SetBodygroup(2,1) end end)

concommand.Add("set_RNcloth5", function (ply) local unlockRNcloth5=ply:GetNWInt("UnlockRNcloth5") level=ply:GetNWInt("LVL")
if unlockRNcloth5 == 0 and level >= 9 then ply:SetNWInt("UnlockRNcloth5", 1) ply:SetModel("models/grim/isa/isa_sniper.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
ply:SetPData("UnlockRNcloth5", ply:GetNWInt("UnlockRNcloth5"))
elseif unlockRNcloth5 == 1 then ply:SetModel("models/grim/isa/isa_sniper.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)

concommand.Add("set_RNcloth6", function (ply) local unlockRNcloth6=ply:GetNWInt("UnlockRNcloth6") level=ply:GetNWInt("LVL")
if unlockRNcloth6 == 0 and level >= 11 then ply:SetNWInt("UnlockRNcloth6", 1) ply:SetModel("models/ninja/cubanmerc_male_foma.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end
ply:SetPData("UnlockRNcloth6", ply:GetNWInt("UnlockRNcloth6"))
elseif unlockRNcloth6 == 1 then ply:SetModel("models/ninja/cubanmerc_male_foma.mdl") ply:SetSkin(0) for k,v in ipairs(LFCC) do ply:SetBodygroup(v,0) end end end)
-----------RN------------------------------------------------------------------RN-----------
--Одежда


concommand.Add("buy_entity", buyEntity)


--Команды
concommand.Add("set_team_loh", SetupMenuTeamLoh)
concommand.Add("set_team_ssnk", SetupMenuTeamSSNK)
concommand.Add("set_team_usa", SetupMenuTeamUSA)
concommand.Add("set_team_gbc", SetupMenuTeamGBC)
concommand.Add("set_team_wn", SetupMenuTeamWN)
--Команды
