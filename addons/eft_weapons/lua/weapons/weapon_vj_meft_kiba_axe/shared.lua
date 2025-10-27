if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Kiba Arms Axe"
SWEP.Author = "DrVrej"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"
SWEP.MadeForNPCsOnly = true -- Is this weapon meant to be for NPCs only?
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = 1 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire = 0.35 -- How much time until the bullet/projectile is fired?
SWEP.MeleeWeaponSound_Hit = {"mishaeft_guns/knife_bayonet_stab.wav"} -- Sound it plays when it hits something
SWEP.NPC_BeforeFireSound = {"mishaeft_guns/knife_bayonet_swing1.wav","mishaeft_guns/knife_bayonet_swing2.wav"}
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel = "models/misha_eft/yurie_melee_pack/kiba_arms_axe.mdl"
SWEP.HoldType = "knife"
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 24 -- Damage
SWEP.IsMeleeWeapon = true -- Should this weapon be a melee weapon? 

