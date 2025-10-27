if CLIENT then
    function MainMenuFunc()
        local ply = LocalPlayer()

        if not MainMenu then
            MainMenu = vgui.Create("DPanel")
            MainMenu:SetSize(1200,800)
            MainMenu:Center()

            MainMenu.Paint = function()
                surface.SetDrawColor(0,0,0,240)
                surface.DrawTexturedRect(0, 0, MainMenu:GetWide(), MainMenu:GetTall())


                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,25,MainMenu:GetWide(),1)
                draw.DrawText("Опыт оружия " .. ply:GetNWString("PR_fraction") ..  ": " .. ply:GetNWInt("PR_weapon_exp_" .. ply:GetNWString("PR_fraction")), "DermaDefaultBold", MainMenu:GetWide() / 2, 5, Color(255,255,255,255),1)
            end
            gui.EnableScreenClicker(true)
        else
            if(MainMenu:IsVisible()) then
                MainMenu:SetVisible(false)
                gui.EnableScreenClicker(false)
            else
                MainMenu:SetVisible(true)
                gui.EnableScreenClicker(true)
            end
        end

        -----------------------------------------------------------------------------------------------------------
        if MainMenu then
            if not PR_ButtonsMenu then
                PR_ButtonsMenu = {}
            end

            if not PR_Panels then
                PR_Panels = {}
            end

            --[[ if not PR_ButtonsMenu.Map then
                PR_ButtonsMenu.Map = vgui.Create("DButton")
                PR_ButtonsMenu.Map:SetParent(MainMenu)
                PR_ButtonsMenu.Map:SetText("")
                PR_ButtonsMenu.Map:SetSize(100,50)
                PR_ButtonsMenu.Map:SetPos(0,25)
    
                PR_ButtonsMenu.Map.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.Map:GetWide(),PR_ButtonsMenu.Map:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.Map:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.Map:GetTall())
                    
                    draw.DrawText("Карта","DermaDefaultBold", PR_ButtonsMenu.Map:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.Map.DoClick = function()
                    PR_Clear_All_Parasha()
                    test_gm_OpenMap()
                end
            end ]]

            if not PR_ButtonsMenu.Group then
                PR_ButtonsMenu.Group = vgui.Create("DButton")
                PR_ButtonsMenu.Group:SetParent(MainMenu)
                PR_ButtonsMenu.Group:SetText("")
                PR_ButtonsMenu.Group:SetSize(100,50)
                PR_ButtonsMenu.Group:SetPos(0,25)
    
                PR_ButtonsMenu.Group.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.Group:GetWide(),PR_ButtonsMenu.Group:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.Group:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.Group:GetTall())
                    
                    draw.DrawText("Группировка","DermaDefaultBold", PR_ButtonsMenu.Group:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.Group.DoClick = function()
                    PR_Clear_All_Parasha()

                    PR_Panels.rusButton = vgui.Create("DImageButton")
                    PR_Panels.rusButton:SetParent(MainMenu)
                    PR_Panels.rusButton:SetPos(100,25)
                    PR_Panels.rusButton:SetSize(150,90)
                    PR_Panels.rusButton:SetImage("test_gm_mat/flags/ssnk.png")

                    PR_Panels.rusButton.DoClick = function()
                        ply:SetNWString("PR_fraction", "SSNK")
                        net.Start("SetFrac")
                        net.WriteString("SSNK")
                        net.SendToServer()
                    end

                    PR_Panels.usaButton = vgui.Create("DImageButton")
                    PR_Panels.usaButton:SetParent(MainMenu)
                    PR_Panels.usaButton:SetPos(100,115)
                    PR_Panels.usaButton:SetSize(150,90)
                    PR_Panels.usaButton:SetImage("test_gm_mat/flags/usa.png")

                    PR_Panels.usaButton.DoClick = function()
                        ply:SetNWString("PR_fraction", "USA")
                        net.Start("SetFrac")
                        net.WriteString("USA")
                        net.SendToServer()
                    end

                    PR_Panels.gerButton = vgui.Create("DImageButton")
                    PR_Panels.gerButton:SetParent(MainMenu)
                    PR_Panels.gerButton:SetPos(100,205)
                    PR_Panels.gerButton:SetSize(150,90)
                    PR_Panels.gerButton:SetImage("test_gm_mat/flags/gbc.png")
                    
                    PR_Panels.gerButton.DoClick = function()
                        ply:SetNWString("PR_fraction", "GBC")
                        net.Start("SetFrac")
                        net.WriteString("GBC")
                        net.SendToServer()
                    end

                    PR_Panels.wnButton = vgui.Create("DImageButton")
                    PR_Panels.wnButton:SetParent(MainMenu)
                    PR_Panels.wnButton:SetPos(100,295)
                    PR_Panels.wnButton:SetSize(150,90)
                    PR_Panels.wnButton:SetImage("test_gm_mat/flags/wn.png")

                    PR_Panels.wnButton.DoClick = function()
                        ply:SetNWString("PR_fraction", "WN")
                        net.Start("SetFrac")
                        net.WriteString("WN")
                        net.SendToServer()
                    end

                    if ply:IsAdmin() or ply:GetNWBool("PR_admin") == true then
                        PR_Panels.adminButton = vgui.Create("DImageButton")
                        PR_Panels.adminButton:SetParent(MainMenu)
                        PR_Panels.adminButton:SetPos(100,385)
                        PR_Panels.adminButton:SetSize(150,90)
                        PR_Panels.adminButton:SetImage("test_gm_mat/flags/admin.png")

                        PR_Panels.adminButton.DoClick = function()
                            ply:SetNWString("PR_fraction", "admin")
                            net.Start("SetFrac")
                            net.WriteString("admin")
                            net.SendToServer()
                        end
                    end

                    --[[ PR_Panels.scavButton = vgui.Create("DImageButton")
                    PR_Panels.scavButton:SetParent(MainMenu)
                    PR_Panels.scavButton:SetPos(100,385)
                    PR_Panels.scavButton:SetSize(150,90)
                    PR_Panels.scavButton:SetImage("test_gm_mat/flags/scav.png")

                    PR_Panels.scavButton.DoClick = function()
                        print('Soon ёпта')
                    end ]]
                end
            end

            if not PR_ButtonsMenu.WeaponShop then
                PR_ButtonsMenu.WeaponShop = vgui.Create("DButton")
                PR_ButtonsMenu.WeaponShop:SetParent(MainMenu)
                PR_ButtonsMenu.WeaponShop:SetText("")
                PR_ButtonsMenu.WeaponShop:SetSize(100,50)
                PR_ButtonsMenu.WeaponShop:SetPos(0,75)
                
                PR_ButtonsMenu.WeaponShop.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.WeaponShop:GetWide(),PR_ButtonsMenu.WeaponShop:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.WeaponShop:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.WeaponShop:GetTall())
                    
                    draw.DrawText("Оружие","DermaDefaultBold", PR_ButtonsMenu.WeaponShop:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.WeaponShop.DoClick = function()
                    PR_Clear_All_Parasha()

                    PR_Create_WS_Labels()

                    --PR_GiveNWData_WS(ply:GetNWString("PR_fraction"))
                end
            end

            if not PR_ButtonsMenu.EquipShop then
                PR_ButtonsMenu.EquipShop = vgui.Create("DButton")
                PR_ButtonsMenu.EquipShop:SetParent(MainMenu)
                PR_ButtonsMenu.EquipShop:SetText("")
                PR_ButtonsMenu.EquipShop:SetSize(100,50)
                PR_ButtonsMenu.EquipShop:SetPos(0,125)
                
                PR_ButtonsMenu.EquipShop.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.EquipShop:GetWide(),PR_ButtonsMenu.EquipShop:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.EquipShop:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.EquipShop:GetTall())
                    
                    draw.DrawText("Снаряжение","DermaDefaultBold", PR_ButtonsMenu.EquipShop:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.EquipShop.DoClick = function()
                    PR_Clear_All_Parasha()

                    PR_Create_Equip_Labels()
                end
            end

            if not PR_ButtonsMenu.VehicleShop then
                PR_ButtonsMenu.VehicleShop = vgui.Create("DButton")
                PR_ButtonsMenu.VehicleShop:SetParent(MainMenu)
                PR_ButtonsMenu.VehicleShop:SetText("")
                PR_ButtonsMenu.VehicleShop:SetSize(100,50)
                PR_ButtonsMenu.VehicleShop:SetPos(0,175)
                
                PR_ButtonsMenu.VehicleShop.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.VehicleShop:GetWide(),PR_ButtonsMenu.VehicleShop:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.VehicleShop:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.VehicleShop:GetTall())
                    
                    draw.DrawText("Техника","DermaDefaultBold", PR_ButtonsMenu.VehicleShop:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.VehicleShop.DoClick = function()
                    PR_Clear_All_Parasha()

                    PR_Create_Veh_Labels()
                end
            end

            if not PR_ButtonsMenu.ClothShop then
                PR_ButtonsMenu.ClothShop = vgui.Create("DButton")
                PR_ButtonsMenu.ClothShop:SetParent(MainMenu)
                PR_ButtonsMenu.ClothShop:SetText("")
                PR_ButtonsMenu.ClothShop:SetSize(100,50)
                PR_ButtonsMenu.ClothShop:SetPos(0,225)
                
                PR_ButtonsMenu.ClothShop.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.ClothShop:GetWide(),PR_ButtonsMenu.ClothShop:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.ClothShop:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.ClothShop:GetTall())
                    
                    draw.DrawText("Одежда","DermaDefaultBold", PR_ButtonsMenu.ClothShop:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.ClothShop.DoClick = function()
                    PR_Clear_All_Parasha()

                    PR_Show_Cloth()
                end
            end

            if not PR_ButtonsMenu.ProfileMenu then
                PR_ButtonsMenu.ProfileMenu = vgui.Create("DButton")
                PR_ButtonsMenu.ProfileMenu:SetParent(MainMenu)
                PR_ButtonsMenu.ProfileMenu:SetText("")
                PR_ButtonsMenu.ProfileMenu:SetSize(100,50)
                PR_ButtonsMenu.ProfileMenu:SetPos(0,275)
                
                PR_ButtonsMenu.ProfileMenu.Paint = function()
                    --Цвет
                    surface.SetDrawColor(0,0,0,0)
                    surface.DrawRect(0,0, PR_ButtonsMenu.ProfileMenu:GetWide(),PR_ButtonsMenu.ProfileMenu:GetTall())
                    
                    --Края
                    surface.SetDrawColor(200,220,220,255)
                    surface.DrawRect(0,49,PR_ButtonsMenu.ProfileMenu:GetWide(),1)
                    surface.DrawRect(99,0,1,PR_ButtonsMenu.ProfileMenu:GetTall())
                    
                    draw.DrawText("Профиль","DermaDefaultBold", PR_ButtonsMenu.ProfileMenu:GetWide() / 2, 17, Color(255,255,255,255),1)
                end
    
                PR_ButtonsMenu.ProfileMenu.DoClick = function()
                    PR_Clear_All_Parasha()

                    PR_Show_Stats()
                end
            end
        end
    end
    
    function PR_Clear_All_Parasha()
        if IsValid(map) then
            map:Remove()
        end

        --PR_Editor_WeaponShop = false

        if PR_Panels != nil then
            for k,v in pairs (PR_Panels) do
                PR_Panels[k]:Remove()
            end
        end
    end

    --[[ function PR_Open_Fraction()

    end ]]

    --[[
    hook.Add("Think","NiceWorkBitchBoom", function()
        if PR_Editor_WeaponShop == true then
            if (LocalPlayer():KeyReleased(2)) then
                local CurX, CurY = MainMenu:CursorPos()
                PR_WS_Edit(CurX, CurY)
            end
        end
    end)
    ]]
    
    net.Receive("MainMenuOpen", MainMenuFunc)

    --[[
    for k,v in pairs(PR_WS_List["SSNK"]) do
        if v["Name"] == "Калак" then
            print(v["Price"])
        end
    end
    ]]
end