/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Escape From Tarkov Shared"
local AddonName = "Misha EFT Content"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_mishaeft.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	VJ.AddCategoryInfo("Escape From Tarkov", {Icon = "vj_base/icons/eft_add_icon2_64_sprite.png"})

	-- Weapons
	VJ.AddNPCWeapon("VJ_EFT_AK74", "weapon_vj_meft_ak74m")
	VJ.AddNPCWeapon("VJ_EFT_AKs74u", "weapon_vj_meft_aks74u")
	VJ.AddNPCWeapon("VJ_EFT_ASVAL", "weapon_vj_meft_asval")
	VJ.AddNPCWeapon("VJ_EFT_M4A1", "weapon_vj_meft_m4a1")
	VJ.AddNPCWeapon("VJ_EFT_MP5", "weapon_vj_meft_mp5")
	VJ.AddNPCWeapon("VJ_EFT_UMP45", "weapon_vj_meft_ump45")
	VJ.AddNPCWeapon("VJ_EFT_KEDR", "weapon_vj_meft_kedr")
	VJ.AddNPCWeapon("VJ_EFT_TOZ", "weapon_vj_meft_toz")
	VJ.AddNPCWeapon("VJ_EFT_PM", "weapon_vj_meft_pm")
	VJ.AddNPCWeapon("VJ_EFT_MP155", "weapon_vj_meft_mp153")
	VJ.AddNPCWeapon("VJ_EFT_MR43", "weapon_vj_meft_mr43")
	VJ.AddNPCWeapon("VJ_EFT_MOSIN", "weapon_vj_meft_mosin")
	VJ.AddNPCWeapon("VJ_EFT_SCAR", "weapon_vj_meft_scar")
	VJ.AddNPCWeapon("VJ_EFT_SKS", "weapon_vj_meft_sks")
	
	-- ConVars --
	VJ.AddConVar("vj_pmc_h",90)
	VJ.AddConVar("vj_pmc_d",45)
	
	VJ.AddConVar("vj_scav_h",80)
	VJ.AddConVar("vj_scav_d",45)
	
	VJ.AddConVar("vj_boss_bully_h",120)
	VJ.AddConVar("vj_boss_bully_d",45)
	
	VJ.AddConVar("vj_boss_sanitar_h",240)
	VJ.AddConVar("vj_boss_sanitar_d",45)
	
	VJ.AddConVar("vj_boss_bully_goon_h",160)
	VJ.AddConVar("vj_boss_bully_goon_d",45)
	
	VJ.AddConVar("vj_boss_sanitar_goon_h",200)
	VJ.AddConVar("vj_boss_sanitar_goon_d",45)
	
	VJ.AddConVar("vj_novya_santa_h",450)
	VJ.AddConVar("vj_novya_santa_d",45)
	
		local AddConvars = {}
	AddConvars["vj_me_bear"] = 0
	AddConvars["vj_me_usec"] = 0
	AddConvars["vj_me_scav"] = 0
	AddConvars["vj_me_rogues"] = 0
	
	for k, v in pairs(AddConvars) do
		if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_ARCHIVE} ) end
	end
	
	if CLIENT then
	local function VJ_MEPMC_MENU_MAIN(Panel)
		if !game.SinglePlayer() then
		if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
			Panel:AddControl( "Label", {Text = "UNTAR GO NAHER!"})
			Panel:ControlHelp("Notice: Only admins can change this settings")
			return
			end
		end
		Panel:AddControl( "Label", {Text = "Notice: Only admins can change this settings."})
		local vj_MEPMC_reset = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "1"}
		vj_MEPMC_reset.Options["#vjbase.menugeneral.default"] = { 
		vj_me_bear = "0",
		vj_me_usec = "0",
		vj_me_scav = "0",
		vj_me_rogues = "0",
		}
		Panel:AddControl("Checkbox", {Label = "Be Friend With BEAR", Command = "vj_me_bear"})
		Panel:ControlHelp("Makes all NPCs on the BEAR fraction friendly.")
		
		Panel:AddControl("Checkbox", {Label = "Be Friend With Rogues", Command = "vj_me_rogues"})
		Panel:ControlHelp("Makes all NPCs on the Rogues fraction friendly.")

		Panel:AddControl("Checkbox", {Label = "Be Friend With USEC", Command = "vj_me_usec"})
		Panel:ControlHelp("Makes all NPCs on the BEAR fraction friendly.")

		Panel:AddControl("Checkbox", {Label = "Be Friend With SCAV", Command = "vj_me_scav"})
		Panel:ControlHelp("Makes all NPCs on the SCAV fraction friendly.")
		
		
	end
	function VJ_ADDTOMENU_MEPMC()
		spawnmenu.AddToolMenuOption( "DrVrej", "SNPC Configures", "Escape From Tarkov", "Misha Escape From Tarkov", "", "", VJ_MEPMC_MENU_MAIN, {} )
	end
		hook.Add( "PopulateToolMenu", "VJ_ADDTOMENU_MEPMC", VJ_ADDTOMENU_MEPMC )
	end	
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end