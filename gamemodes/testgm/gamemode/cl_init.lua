include( "shared.lua" )
include("testhud.lua")
--include("custom_menu.lua")
include("custom_scoreboard.lua")
include("sh_f4menu.lua")
include("cl_weaponshop.lua")
include("cl_equipment.lua")
include("cl_cloth.lua")
include("cl_vehicle.lua")
include("cl_profile.lua")
include("player/sh_player_save.lua")


hook.Add("ContextMenuOpen", "pizda_spawnmenu", function()
   if not (LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true) then
      return false
   end
end)



hook.Add("OnSpawnMenuOpen", "pizda_spawnmenu", function()
   if not (LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true) then
      return false
   end
end)