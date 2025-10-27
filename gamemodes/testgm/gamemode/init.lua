AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("concommands.lua")
AddCSLuaFile("testhud.lua")
--AddCSLuaFile("custom_menu.lua")
AddCSLuaFile("custom_scoreboard.lua")
AddCSLuaFile("player/sh_player_save.lua")
AddCSLuaFile("teamsetup.lua")
AddCSLuaFile("sh_f4menu.lua")
AddCSLuaFile("cl_weaponshop.lua")
AddCSLuaFile("cl_equipment.lua")
AddCSLuaFile("cl_cloth.lua")
AddCSLuaFile("cl_profile.lua")
AddCSLuaFile("cl_vehicle.lua")

include( "shared.lua" )
include("sh_f4menu.lua")
include("concommands.lua")
include("player/sh_player_save.lua")
include("teamsetup.lua")


hook.Add("PlayerSpawn", "Aboltys", function(ply)
	if ply.Preset["Primary"] != nil then
		if ply.Preset["Primary"]["Item"] != nil then
			ply:Give(ply.Preset["Primary"]["Item"])
		end
	end

	if ply.Preset["Secondary"] != nil then
		if ply.Preset["Secondary"]["Item"] != nil then
			ply:Give(ply.Preset["Secondary"]["Item"])
		end
	end
end)

hook.Add("PlayerDeath", "Aboltys", function(victim, inflictor, attacker)
	--[[ 
	StartMoney+AdditionalMoney*LevelFraction+AdditionalMoney(ExpLevel/ExpLevelNext)
	StartMoney=500
	AdditionalMoney=100
	LevelFraction - ур фракции противника
	ExpLevel - опыт на его уровне
	ExpLevelNext - нужное кол-во опыта для повышения
	]]

	victim:SetNWInt("PR_deaths", victim:GetNWInt("PR_deaths") + 1)

	if victim == attacker then return false end

	local atkMoney = attacker:GetNWInt("PR_money")
	local atkLevel = attacker:GetNWInt("PR_level")
	local atkFracLevel = attacker:GetNWInt("PR_level_" .. attacker:GetNWString("PR_fraction"))
	local atkExp = attacker:GetNWInt("PR_exp")
	local atkFracExp = attacker:GetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction"))

	local atkKills = attacker:GetNWInt("PR_kills")
	
	local vicFracLevel = victim:GetNWInt("PR_level_" .. victim:GetNWString("PR_fraction"))
	local vicFracExp = victim:GetNWInt("PR_exp_" .. victim:GetNWString("PR_fraction")) + 50

	if victim:GetNWString("PR_fraction") == attacker:GetNWString("PR_fraction") then
		attacker:SetNWInt("PR_money", atkMoney - 100)
		return false
	end

	if victim:GetNWString("PR_fraction") == "" then
		attacker:SetNWInt("PR_money", atkMoney + 100)
	else
		attacker:SetNWInt("PR_money", atkMoney + 100 + 20 * vicFracLevel)
		--attacker:SetNWInt("PR_money", atkMoney + 1000)
	end
	attacker:SetNWInt("PR_exp", atkExp + 10 + 1 * vicFracLevel)
	attacker:SetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction"), atkFracExp + 10 + 1 * vicFracLevel)

	attacker:SetNWInt("PR_weapon_exp_" .. attacker:GetNWString("PR_fraction"), attacker:GetNWInt("PR_weapon_exp_" .. attacker:GetNWString("PR_fraction")) + 10 + 1 * vicFracLevel)

	local atkLevel = attacker:GetNWInt("PR_level")
	local atkFracLevel = attacker:GetNWInt("PR_level_" .. attacker:GetNWString("PR_fraction"))
	local atkExp = attacker:GetNWInt("PR_exp")
	local atkFracExp = attacker:GetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction"))

	if atkExp >= atkLevel * 100 then
		attacker:SetNWInt("PR_exp", 0)
		attacker:SetNWInt("PR_level", atkLevel + 1)
	end

	if atkFracExp >= atkFracLevel * 100 then
		attacker:SetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction"), 0)
		attacker:SetNWInt("PR_level_" .. attacker:GetNWString("PR_fraction"), atkFracLevel + 1)
	end

	attacker:SetNWInt("PR_kills", atkKills + 1)

	--[[ victim:SetNWInt("DEATHS",victim:GetNWInt("DEATHS") + 1)
    victim:SetPData("DEATHS",victim:GetNWInt("DEATHS")) ]]
end)

hook.Add("OnNPCKilled", "Aboltys", function(victim, inflictor, attacker)
	attacker:SetNWInt("PR_money", attacker:GetNWInt("PR_money") + 100)
	attacker:SetNWInt("PR_exp", attacker:GetNWInt("PR_exp") + 1)
	attacker:SetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction"), attacker:GetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction")) + 1)
	
	attacker:SetNWInt("PR_weapon_exp_" .. attacker:GetNWString("PR_fraction"), attacker:GetNWInt("PR_weapon_exp_" .. attacker:GetNWString("PR_fraction")) + 1)

	if attacker:GetNWInt("PR_exp") >= attacker:GetNWInt("PR_level") * 100 then
		attacker:SetNWInt("PR_exp", 0)
		attacker:SetNWInt("PR_level", attacker:GetNWInt("PR_level") + 1)
	end

	if attacker:GetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction")) >= attacker:GetNWInt("PR_level_" .. attacker:GetNWString("PR_fraction")) * 100 then
		attacker:SetNWInt("PR_exp_" .. attacker:GetNWString("PR_fraction"), 0)
		attacker:SetNWInt("PR_level_" .. attacker:GetNWString("PR_fraction"), attacker:GetNWInt("PR_level_" .. attacker:GetNWString("PR_fraction")) + 1)
	end

	attacker:SetNWInt("PR_kills_npc", attacker:GetNWInt("PR_kills_npc") + 1)

	--[[ victim:SetNWInt("DEATHS",victim:GetNWInt("DEATHS") + 1)
    victim:SetPData("DEATHS",victim:GetNWInt("DEATHS")) ]]
end)

hook.Add("ScalePlayerDamage", "Ebaboba", function( ply, hitgroup, dmginfo )
	dmginfo:ScaleDamage(1)
end)

hook.Add("EntityTakeDamage", "Elaboba", function( target, dmginfo )
	if dmginfo:GetDamageType() == 64 then
		if target:IsPlayer() or target:IsNPC() then return false end
		dmginfo:ScaleDamage(20)
	end
end)

function GM:ShowSpare2(ply)
   ply:ConCommand("open_main_menu")
end

function GM:ShutDown()
	for k,v in pairs(player.GetAll()) do
		PR_Save_Player(v)
	end
end

--[[ for k,v in pairs(player.GetAll()) do
	print(v:Nick().." "..v:GetNWString("PR_fraction"))
end ]]

function GM:PlayerSay(ply, text)
	local playerMsg = string.Explode (" ", text)
	
	--[[ --GIVEMONEY (ADMIN)
	if playerMsg[1] == "!giveMoney" or playerMsg[1] == "/giveMoney" then	-- если первое сообщение - !giveMoney или /giveMoney, то выполняется
		if ply:GetNWInt("AdminPR") == 1 or ply:IsAdmin() then --если тот, кто пишет - админ, то работает
			for k, v in ipairs(player.GetAll()) do -- ищет среди всех игроков (если что зайдите в gmod wiki)
				if playerMsg[2] == v:SteamID64() then --если второе сообщение - стим айди, то выполняется
					local amount = playerMsg[3] --вводить тип данных integer (например 213210)
					v:SetNWInt("Money", v:GetNWInt("Money") + amount) --даёт бабло
					v:SetPData("Money",v:GetBalance()) -- сохраняет в PData
					ply:ChatPrint("Дал " .. amount .. "$ " .. "бомжу: " .. v:Nick()) --выводит это в чат (только вам)
				end
			end
		end
	return "" -- чтобы в чат не писало ваши секретные команды
	end ]]
	
	if playerMsg[1] == "!деньги" then
		local amount = playerMsg[2]

		if ply:GetNWInt("PR_money") >= tonumber(amount) then
			scripted_ents.Get("pr_money"):SpawnFunction(ply, ply:GetEyeTrace(), "pr_money"):SetValue(amount)

			ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - amount)
		end

		return "" -- чтобы в чат не писало ваши секретные команды
	end

	--[[ if playerMsg[1] == "!!" then
		for k,v in pairs(ents.GetAll()) do
			v:Freeze(false)
		end
	end ]]
end

if not timer.Exists("PR_ChangeSpeed") then
	timer.Create("PR_ChangeSpeed", 1, 0, function()
		for k,v in pairs(player.GetAll()) do
			if v:GetRunSpeed() > 250 then
				v:SetRunSpeed(250)
			end
			if v:GetWalkSpeed() > 150 then
				v:SetWalkSpeed(150)
			end
		end
	end)
end
	