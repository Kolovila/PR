GM.Name = "PR"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

team.SetUp(0, "Loh", Color(255,0,0))
team.SetUp(1, "SSNK", Color(0,0,255))
team.SetUp(2, "USA", Color(0,255,0))
team.SetUp(3, "GBC", Color(255,0,255))
team.SetUp(4, "WN", Color(0,255,255))

DeriveGamemode("sandbox")

if SERVER then
    util.AddNetworkString("MainMenuOpen")

    util.AddNetworkString("SaveWeaponData")
    util.AddNetworkString("SaveVehicleData")
    util.AddNetworkString("SaveEquipData")
    util.AddNetworkString("SaveClothData")
    util.AddNetworkString("SavePatrolsData")

    util.AddNetworkString("WeaponTable")
    util.AddNetworkString("EquipTable")
    util.AddNetworkString("VehicleTable")
    util.AddNetworkString("ClothTable")
    util.AddNetworkString("PatrolsTable")

    util.AddNetworkString("CapturePoint")

    util.AddNetworkString("GiveWeapon")
    util.AddNetworkString("GiveVehicle")
    util.AddNetworkString("GiveEnity")
    util.AddNetworkString("BuyPlayerModel")
    util.AddNetworkString("SetFrac")

    util.AddNetworkString("SetAdminPR")
    util.AddNetworkString("SetLeaderFracPR")
    util.AddNetworkString("SetMoneyPR")
    util.AddNetworkString("SetExpPR")
    util.AddNetworkString("GiveMoneyForMissionPR")
    util.AddNetworkString("SetExpFracPR")
    util.AddNetworkString("SetCoinPR")
    util.AddNetworkString("KickOffNahyiPR")
    util.AddNetworkString("IsPlayerInBuyBox")
    util.AddNetworkString("SendIsPlayerInBuyBox")

    util.AddNetworkString("Preset")

    concommand.Add("open_main_menu", function(ply)
        net.Start("MainMenuOpen")
        net.Send(ply)

        local WeapData = file.Read("pr_gamemode/weapon_shop_list.txt", "DATA")
        if not WeapData then
            MsgC(Color(255,0,0), "Где сейв")
        else
            net.Start("WeaponTable")
                net.WriteTable(util.JSONToTable(WeapData))
            net.Send(ply)
        end

        local EquipData = file.Read("pr_gamemode/equip_shop_list.txt", "DATA")
        if not EquipData then
            MsgC(Color(255,0,0), "Где сейв")
        else
            net.Start("EquipTable")
                net.WriteTable(util.JSONToTable(EquipData))
            net.Send(ply)
        end

        local VehicleData = file.Read("pr_gamemode/vehicle_shop_list.txt", "DATA")
        if not VehicleData then
            MsgC(Color(255,0,0), "Где сейв")
        else
            net.Start("VehicleTable")
                net.WriteTable(util.JSONToTable(VehicleData))
            net.Send(ply)
        end

        local ClothData = file.Read("pr_gamemode/cloth_shop_list.txt", "DATA")
        if not ClothData then
            MsgC(Color(255,0,0), "Где сейв")
        else
            net.Start("ClothTable")
                net.WriteTable(util.JSONToTable(ClothData))
            net.Send(ply)
        end

        local PatrolsData = file.Read("pr_gamemode/patrols_list.txt", "DATA")
        if not PatrolsData then
            MsgC(Color(255,0,0), "Где сейв")
        else
            net.Start("PatrolsTable")
                net.WriteTable(util.JSONToTable(PatrolsData))
            net.Send(ply)
        end
    end)

    net.Receive("SetFrac", function(len, ply)
        local frac = net.ReadString()
        ply:SetNWString("PR_fraction", frac)
    end)

    net.Receive("SetAdminPR", function(len, ply)
        local man = net.ReadEntity()

        if man:GetNWBool("PR_admin") != true then
            man:SetNWBool("PR_admin", true)
        else
            man:SetNWBool("PR_admin", false)
        end
    end)

    net.Receive("SetLeaderFracPR", function(len, ply)
        local man = net.ReadEntity()

        for k,v in pairs(player.GetAll()) do
            v:SetNWBool("PR_leader_" .. man:GetNWString("PR_fraction"), false)
        end

        man:SetNWBool("PR_leader_" .. man:GetNWString("PR_fraction"), true)
    end)

    net.Receive("SetMoneyPR", function(len, ply)
        local man = net.ReadEntity()
        local money = net.ReadInt(32)

        man:SetNWInt("PR_money", man:GetNWInt("PR_money") + money)
    end)

    net.Receive("SetExpPR", function(len, ply)
        local man = net.ReadEntity()
        local exp = net.ReadInt(32)

        man:SetNWInt("PR_exp", man:GetNWInt("PR_exp") + exp)
    end)

    net.Receive("GiveMoneyForMissionPR", function(len, ply)
        local man = net.ReadEntity()
        local money = net.ReadInt(32)
        
        local lvl = man:GetNWInt("PR_level")
        local pribavka = 0

        if lvl <=19 then
            pribavka = (lvl-1) * 10
        elseif lvl >= 20 then
            pribavka = 200
        end

        man:SetNWInt("PR_money", man:GetNWInt("PR_money") + money / 100 * pribavka + money)
    end)

    net.Receive("SetExpFracPR", function(len, ply)
        local man = net.ReadEntity()
        local exp = net.ReadInt(32)

        local frac = man:GetNWString("PR_fraction")

        man:SetNWInt("PR_exp_" .. frac, man:GetNWInt("PR_exp_" .. frac) + exp)
    end)

    net.Receive("SetCoinPR", function(len, ply)
        local man = net.ReadEntity()
        local coin = net.ReadInt(32)

        man:SetNWInt("PR_coin", man:GetNWInt("PR_coin") + coin)
    end)

    net.Receive("KickOffNahyiPR", function(len, ply)
        local man = net.ReadEntity()

        man:Kick()
    end)

    net.Receive("SaveWeaponData", function()
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        local Table = net.ReadTable()

        file.Write("pr_gamemode/weapon_shop_list.txt", util.TableToJSON(Table, true))

        
        net.Start("WeaponTable")
        local data = file.Read("pr_gamemode/weapon_shop_list.txt", "DATA")
        if not data then MsgC(Color(255,0,0), "Где сейв") return end

        net.WriteTable(util.JSONToTable(data))
        net.Broadcast()
    end)

    net.Receive("SaveEquipData", function()
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        local Table = net.ReadTable()

        file.Write("pr_gamemode/equip_shop_list.txt", util.TableToJSON(Table, true))
        
        net.Start("EquipTable")
        local data = file.Read("pr_gamemode/equip_shop_list.txt", "DATA")
        if not data then MsgC(Color(255,0,0), "Где сейв") return end

        net.WriteTable(util.JSONToTable(data))
        net.Broadcast()
    end)

    net.Receive("SaveVehicleData", function()
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        local Table = net.ReadTable()

        file.Write("pr_gamemode/vehicle_shop_list.txt", util.TableToJSON(Table, true))
        
        net.Start("VehicleTable")
        local data = file.Read("pr_gamemode/vehicle_shop_list.txt", "DATA")
        if not data then MsgC(Color(255,0,0), "Где сейв") return end

        net.WriteTable(util.JSONToTable(data))
        net.Broadcast()
    end)

    net.Receive("SaveClothData", function()
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        local Table = net.ReadTable()

        file.Write("pr_gamemode/cloth_shop_list.txt", util.TableToJSON(Table, true))

        
        net.Start("ClothTable")
        local data = file.Read("pr_gamemode/cloth_shop_list.txt", "DATA")
        if not data then MsgC(Color(255,0,0), "Где сейв") return end

        net.WriteTable(util.JSONToTable(data))
        net.Broadcast()
    end)

    net.Receive("SavePatrolsData", function()
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        local Table = net.ReadTable()

        file.Write("pr_gamemode/patrols_list.txt", util.TableToJSON(Table, true))
        
        net.Start("PatrolsTable")
        local data = file.Read("pr_gamemode/patrols_list.txt", "DATA")
        if not data then MsgC(Color(255,0,0), "Где сейв") return end

        PR_Patrols_List = util.JSONToTable(data)

        net.WriteTable(util.JSONToTable(data))
        net.Broadcast()
    end)

    net.Receive("GiveWeapon", function(len, ply)
        local Weap = net.ReadString()
        local Price = net.ReadInt(32)
        local Exp = net.ReadInt(32)
        ply:Give(Weap)

        ply.PurchasedWeapons = ply.PurchasedWeapons or {}
        if not table.HasValue(ply.PurchasedWeapons, Weap) then
            table.insert(ply.PurchasedWeapons, Weap)
        end

        ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - Price)
        ply:SetNWInt("PR_weapon_exp_".. ply:GetNWString("PR_fraction"), ply:GetNWInt("PR_weapon_exp_".. ply:GetNWString("PR_fraction")) - Exp)
    end)

    net.Receive("Preset", function(len, ply)
        local Item = net.ReadString()
        local Type = net.ReadString()
        local Name = net.ReadString()

        ply.Preset[Type] = {
            ["Item"] = Item,
            ["Name"] = Name
        }
    end)

    net.Receive("GiveVehicle", function(len, ply)
        local price = net.ReadInt(32)
        local classname = net.ReadString()
        local mod = net.ReadString()
        local vecDeploy = net.ReadVector()
        local tr = ply:GetEyeTrace()
        
        if mod == "simfphys" then
            simfphys.SpawnVehicleSimple( classname, vecDeploy, Angle(0,90,0) )
        else
            local ent = ents.Create(classname)
            ent:SetModel(classname)
            ent:SetPos( vecDeploy )
            ent:SetAngles( Angle(0,90,0) )
            ent:Spawn()
        end

        ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - price)

        --[[ print(classname)

        local car1 = ents.Create("prop_vehicle_jeep")
        --car1:SetModel("models/LoneWolfie/chev_tahoe.mdl")
        --car1.VehicleTable = list.Get( "Vehicles" )[ "Chevy Tahoe Police"]
        --car1:SetKeyValue("vehiclescript","scripts/vehicles/lwcars/chev_tahoe.txt") 
        --car1:GetKeyValues()
        print(car1)
        --[[ car1:SetPos(ply:GetPos() + Vector(500,0,0))
        car1:Spawn()
        car1:Activate() ]]
        --ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - Price) ]]

        --local name = "Seat_Jeep"

        --[[ local vehicle = list.Get("simfphys_vehicles")[classname]
        if not vehicle then print("Vehicle name not recognized") return end

        local ent = ents.Create(vehicle.Class)
        if ent and ent:IsValid() then
            ent:SetModel(vehicle.Model) ]]
            --ent:SetPos(tr.HitPos + tr.HitNormal * 50)

            --[[ --PrintTable(ent:GetKeyValues())
            
            for k, v in pairs(ent:GetKeyValues()) do
                if type(v) == "string" then
                    ent:SetKeyValue(k, v)
                end
            end

            ent.Mass = 1000
            
            ent:Spawn()
        end ]]
    end)

    net.Receive("GiveEnity", function(len, ply)
        local Entity = net.ReadString()
        local Type = net.ReadString()
        local Price = net.ReadInt(32)
        if Type == "wepaon" then
            ply:Give(Entity)
        else
            local entity_spawn = ents.Create(Entity)
            
            local tr = {}
            tr.start = ply:EyePos()
            tr.endpos = ply:EyePos() + 95 * ply:GetAimVector()
            tr.filter = ply
            local trace = util.TraceLine(tr)

			entity_spawn:SetPos(trace.HitPos)
			entity_spawn:Spawn()
        end

        ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - Price)
    end)

    net.Receive("BuyPlayerModel", function(len, ply)
        local Skin = net.ReadString()
        local Bodygroups = net.ReadTable()
        local Price = net.ReadInt(32)
        ply:SetModel(Skin)
        for k,v in pairs(Bodygroups) do
            ply:SetBodygroup(k,v)
        end

        ply.PurchasedModels = ply.PurchasedModels or {}
        if not table.HasValue(ply.PurchasedModels, Skin) then
            table.insert(ply.PurchasedModels, Skin)
        end

        ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") - Price)
    end)

    net.Receive("IsPlayerInBuyBox", function(len, ply)
        print("ad")
        local ply = net.ReadEntity()
        local typeBuy = net.ReadString()

        local isInBox = false

        if typeBuy == "weapon" then
            local tEntities = ents.FindInBox( Vector(2599, -5735, -534), Vector(2827, -5960, -396) )
            
            for i = 1, #tEntities do
                if ( tEntities[ i ] == ply ) then
                    if isInBox == false then isInBox = true end
                end
            end
        end

        net.Start("SendIsPlayerInBuyBox")
            net.WriteBool(isInBox)
        net.Send(ply)
    end)

    --[[
    function GM:Think()
        for i, v in ipairs( player.GetAll() ) do
            if (v:Nick() == "Kolovila") then
                --print(v:GetPos())
                v:Kill()
            end
        end
    end
    ]]
end

if CLIENT then
    function PR_CreateErrorNotice(errorText)
        if not timer.Exists("OshibkaNovichka") then

            local txtWidth, txtHeight = surface.GetTextSize( errorText )

            local NoEntryError = vgui.Create("DLabel")
            NoEntryError:SetSize(txtWidth*2.1,txtHeight+40)
            NoEntryError:SetPos(ScrW()/2 - NoEntryError:GetWide()/2,ScrH()/2 - NoEntryError:GetTall()/2)
            NoEntryError:SetText("")

            NoEntryError.Paint = function()
                draw.RoundedBox(0, 0, 0, NoEntryError:GetWide(), NoEntryError:GetTall(), Color(0,0,0,timer.TimeLeft("OshibkaNovichka")*200))

                draw.DrawText(errorText, "panel_INFO_font", NoEntryError:GetWide()/2, txtHeight/2, Color(255,255,255,timer.TimeLeft("OshibkaNovichka")*200), 1)

                draw.RoundedBox(0, 0, 0, NoEntryError:GetWide(), 1, Color(255,255,255,timer.TimeLeft("OshibkaNovichka")*200)) -- верхушка

                draw.RoundedBox(0, 0, 0, 1, NoEntryError:GetTall(), Color(255,255,255,timer.TimeLeft("OshibkaNovichka")*200)) -- левушка

                draw.RoundedBox(0, NoEntryError:GetWide() - 1, 0, 1, NoEntryError:GetTall(), Color(255,255,255,timer.TimeLeft("OshibkaNovichka")*200)) -- правушка

                draw.RoundedBox(0, 0, NoEntryError:GetTall() - 1, NoEntryError:GetWide(), 1, Color(255,255,255,timer.TimeLeft("OshibkaNovichka")*200)) -- низушка
            end

            timer.Create( "OshibkaNovichka", 2, 1, function() NoEntryError:Remove() end)
        end
    end

    function PR_CreateWriteMenu(MainFunc, title)
        title = title or ""

        local BackGround = vgui.Create ("DFrame")
		BackGround:SetSize(200,70)
		BackGround:SetPos((ScrW()/2)-BackGround:GetWide(),(ScrH()/2)-BackGround:GetTall())
		BackGround:SetTitle(title)
		BackGround:SetVisible(true)
		BackGround:SetDraggable(true)
		BackGround:ShowCloseButton(true)
		BackGround:MakePopup()
		BackGround.Paint = function ()
		    draw.RoundedBox(4,0,0,BackGround:GetWide(), BackGround:GetTall(), Color(200,0,0,200))
			draw.RoundedBox(4,0,0,BackGround:GetWide()-4, 21, Color(50,50,50,200))
		end
		
		local TextEntry = vgui.Create ("DTextEntry", BackGround)
		TextEntry:SetPos(20,30)
		TextEntry:SetTall(20)
		TextEntry:SetWide(160)
		TextEntry:SetEnterAllowed(true)
		TextEntry.OnEnter = function()
            MainFunc(TextEntry:GetValue())
			BackGround:Remove()
		end
    end
    
    function PR_CreateNewButton(butt, text, w, h, x, y, icon, parent, colorBackGround, colorText, align, textPosX, textPosY, font)
        local butt = vgui.Create("DButton", parent)

        local textWidth, textHeight = surface.GetTextSize( text )

        local colorBackGround = colorBackGround or Color(180,180,180,255)

        local colorText = colorText or Color(0,0,0,255)

        local align = align or TEXT_ALIGN_RIGHT

        local font = font or "DermaDefaultBold"

        butt:SetText("")
        butt:SetSize(w,h)
        butt:SetPos(x,y)

        local textPosX = textPosX or butt:GetWide() - 5

        local textPosY = textPosY or butt:GetTall()/2 - textHeight / 1.5

        butt.Paint = function()
            draw.RoundedBox(0, 0, 0, butt:GetWide(), butt:GetTall(), colorBackGround)

            --draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
            draw.RoundedBox(0, 0, 0, butt:GetWide(), 1, Color(255,255,255,255)) -- верхушка

            draw.RoundedBox(0, 0, 0, 1, butt:GetTall(), Color(255,255,255,255)) -- левушка

            draw.RoundedBox(0, butt:GetWide() - 1, 0, 1, butt:GetTall(), Color(255,255,255,255)) -- правушка

            draw.RoundedBox(0, 0, butt:GetTall() - 1, butt:GetWide(), 1, Color(255,255,255,255)) -- низушка

            draw.SimpleText(text, font, textPosX, textPosY, colorText, align)
        end

        if icon != "" then
            local img = vgui.Create("DImage", butt)
            img:SetSize(32, 32)
            img:SetPos(2, butt:GetTall()/2 - img:GetTall() / 2)
            
            -- Set material relative to "garrysmod/materials/"
            img:SetImage("test_gm_mat/icons/" .. icon)
        end

        return butt
    end

    function PR_GetIconForShop(class)
        if file.Exists('materials/entities/' .. class .. '.png', 'GAME') then
            return 'entities/' .. class .. '.png'
        end
    
        if file.Exists('materials/vgui/entities/' .. class .. '.vtf', 'GAME') then
            return 'vgui/entities/' .. class
        end
    end
    
    local creator_icon = "icon16/wand.png"
    local copy_icon = "icon16/page_copy.png"

    spawnmenu.AddContentType( "entity", function( container, obj )

       if ( !obj.material ) then return end
       if ( !obj.nicename ) then return end
       if ( !obj.spawnname ) then return end

       local icon = vgui.Create( "ContentIcon", container )
       icon:SetContentType( "entity" )
       icon:SetSpawnName( obj.spawnname )
       icon:SetName( obj.nicename )
       icon:SetMaterial( obj.material )
       icon:SetAdminOnly( obj.admin )
       icon:SetColor( Color( 205, 92, 92, 255 ) )
       icon.DoClick = function()
          RunConsoleCommand( "gm_spawnsent", obj.spawnname )
          surface.PlaySound( "ui/buttonclickrelease.wav" )
       end
       icon.OpenMenu = function( icon )

          local tiers = {"grenade_lethal", "grenade_unlethal", "explosion", "melee_weapon", "stims", "first_aid", "stations_device", "binoculars", "rocket_launchers", "signal_device", "armor_and_else"}
          local menu = DermaMenu()
                menu:AddOption( "Copy to Clipboard", function() SetClipboardText( obj.spawnname ) end ):SetImage( copy_icon )
                menu:AddOption( "Spawn Using Toolgun", function() RunConsoleCommand( "gmod_tool", "creator" ) RunConsoleCommand( "creator_type", "0" ) RunConsoleCommand( "creator_name", obj.spawnname ) end ):SetImage( creator_icon )
    
                local submenu = menu:AddSubMenu( "Add to drop", function() end )
                for k,tier in pairs(tiers) do
                   submenu:AddOption( tier, function() PR_Equip_Create(tier, obj.nicename, obj.spawnname) end ):SetImage("test_gm_mat/q_menu_equip/" .. string.lower(tier) .. ".png")
                   submenu:AddSpacer()
                end
          menu:Open()

       end

       if ( IsValid( container ) ) then
          container:Add( icon )
       end

       return icon

    end )
    
    spawnmenu.AddContentType( "weapon", function( container, obj )

       if ( !obj.material ) then return end
       if ( !obj.nicename ) then return end
       if ( !obj.spawnname ) then return end

       local icon = vgui.Create( "ContentIcon", container )
       icon:SetContentType( "weapon" )
       icon:SetSpawnName( obj.spawnname )
       icon:SetName( obj.nicename )
       icon:SetMaterial( obj.material )
       icon:SetAdminOnly( obj.admin )
       icon:SetColor( Color( 135, 206, 250, 255 ) )
       icon.DoClick = function()

          RunConsoleCommand( "gm_giveswep", obj.spawnname )
          surface.PlaySound( "ui/buttonclickrelease.wav" )

       end

       icon.DoMiddleClick = function()

          RunConsoleCommand( "gm_spawnswep", obj.spawnname )
          surface.PlaySound( "ui/buttonclickrelease.wav" )

       end

       icon.OpenMenu = function( icon )

          local menu = DermaMenu()
                menu:AddOption( "Copy to Clipboard", function() SetClipboardText( obj.spawnname ) end ):SetImage( copy_icon )
                menu:AddOption( "Spawn Using Toolgun", function() RunConsoleCommand( "gmod_tool", "creator" ) RunConsoleCommand( "creator_type", "3" ) RunConsoleCommand( "creator_name", obj.spawnname ) end ):SetImage( creator_icon )

                local DROP_Type_List = {"pistol","shotgun","smg","ar","sniper","machinegun"}
                local Fractions = {"SSNK","USA","GBC","WN"}
                local submenu = menu:AddSubMenu( "Add to drop", function() end )
                for numweap, weap in pairs(DROP_Type_List) do
                   weap_menu = submenu:AddSubMenu( weap, function() end )
                   --weap_menu:SetImage("test_gm_mat/q_menu_weap/" .. string.lower(weap) .. ".png") ДА ПОШЁЛ ОН НАХУЙ
                   submenu:AddSpacer()

                   for numfr, frac in pairs(Fractions) do
                      weap_menu:AddOption( frac, function() PR_WS_Create(weap, frac, obj.nicename, obj.spawnname) end ):SetImage("test_gm_mat/q_menu_flags/" .. string.lower(frac) .. ".png")
                      weap_menu:AddSpacer()
                   end
                end
          menu:Open()

       end

       if ( IsValid( container ) ) then
          container:Add( icon )
       end

       return icon

    end )
end

PR_WS_List = PR_WS_List or {}
PR_Vehicle_List = PR_Vehicle_List or {}
PR_Equip_List = PR_Equip_List or {}
PR_Cloth_List = PR_Cloth_List or {}
PR_Capture_Points_List = PR_Capture_Points_List or {}
PR_Patrols_List = PR_Patrols_List or {}

function PR_Load_Data()
    local WeaponData = file.Read("pr_gamemode/weapon_shop_list.txt", "DATA")
    local VehicleData = file.Read("pr_gamemode/vehicle_shop_list.txt", "DATA")
    local EquipData = file.Read("pr_gamemode/equip_shop_list.txt", "DATA")
    local ClothData = file.Read("pr_gamemode/cloth_shop_list.txt", "DATA")
    local PointsData = file.Read("pr_gamemode/capture_points_list.txt", "DATA")
    local PatrolsData = file.Read("pr_gamemode/patrols_list.txt", "DATA")

    if EquipData != nil then MsgC(Color(0,255,0), "------------------Cюда сейв экипа------------------") PR_Equip_List = util.JSONToTable(EquipData) end
    if VehicleData != nil then MsgC(Color(0,255,0), "------------------Cюда сейв техники------------------") PR_Vehicle_List = util.JSONToTable(VehicleData) end
    if WeaponData != nil then MsgC(Color(0,255,0), "------------------Cюда сейв оружия------------------") PR_WS_List = util.JSONToTable(WeaponData) end
    if ClothData != nil then MsgC(Color(0,255,0), "------------------Cюда сейв одежда------------------") PR_Cloth_List = util.JSONToTable(ClothData) end
    if PointsData != nil then MsgC(Color(0,255,0), "------------------Cюда сейв точек------------------") PR_Capture_Points_List = util.JSONToTable(PointsData) end
    if PatrolsData != nil then MsgC(Color(0,255,0), "------------------Cюда сейв патрулей------------------") PR_Patrols_List = util.JSONToTable(PatrolsData) end

    --PR_WS_List = util.JSONToTable(WeaponData)
    --PR_Equip_List = util.JSONToTable(EquipData)
    --MsgC(Color(0,255,0), "------------------Сюда сейв------------------")

    if CLIENT then
        chat.AddText(Color(255, 0, 0), "Подсказка:\nКоманда для открытия меню: open_main_menu (bind KEY open_main_menu) либо кнопка F4\nКоманда для проверки магазина: PR_Check_Ammo (bind KEY PR_Check_Ammo)" )
    end
end

net.Receive("CapturePoint", function()
    PR_Capture_List = net.ReadTable()
end)

hook.Add("InitPostEntity", "LoadSavePR", PR_Load_Data)