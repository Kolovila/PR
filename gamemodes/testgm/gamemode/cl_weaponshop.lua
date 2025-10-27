if CLIENT then
    local ply = LocalPlayer()
    
    function PR_WS_Create(TypeWeapon, Fraction, GunName, ClassNameWeapon)
            local BackGround = vgui.Create ("DFrame")
            BackGround:SetSize(300,500)
            BackGround:SetPos((ScrW()/2)-BackGround:GetWide(),(ScrH()/2)-BackGround:GetTall())
            BackGround:SetTitle("")
            BackGround:SetVisible(true)
            BackGround:SetDraggable(true)
            BackGround:ShowCloseButton(true)
            BackGround:MakePopup()
            BackGround.Paint = function ()
                draw.RoundedBox(4,0,0,BackGround:GetWide(), BackGround:GetTall(), Color(100,100,100,200))
                draw.RoundedBox(4,0,0,BackGround:GetWide()-4, 21, Color(50,50,50,200))
                draw.DrawText("Название","DermaDefaultBold", BackGround:GetWide() / 2, 80, Color(255,255,255,255),1)
                draw.DrawText("Цена","DermaDefaultBold", BackGround:GetWide() / 2, 130, Color(255,255,255,255),1)
                draw.DrawText("Ранг (от 1 до 11)","DermaDefaultBold", BackGround:GetWide() / 2, 180, Color(255,255,255,255),1)
                draw.DrawText("Попыт","DermaDefaultBold", BackGround:GetWide() / 2, 230, Color(255,255,255,255),1)
            end

            local PR_Fraction = "Фракция"
            
            local ScrollButton = vgui.Create("DButton", BackGround)
            ScrollButton:SetPos(20,50)
            ScrollButton:SetSize(260,20)
            ScrollButton:SetText("")

            ScrollButton.Paint = function()
                surface.SetDrawColor(50,50,50,255)
                surface.DrawRect(0,0, ScrollButton:GetWide(), ScrollButton:GetTall())
                        
                draw.DrawText(PR_Fraction,"DermaDefaultBold", ScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            ScrollButton.DoClick = function()
                local DScrollPanel = vgui.Create( "DScrollPanel", BackGround )
                DScrollPanel:SetPos(20,50)
                DScrollPanel:SetSize(260,100)

                local PR_Frac_List = {"SSNK","USA","GBC","WN"}

                for k,v in pairs(PR_Frac_List) do
                    local DButton = DScrollPanel:Add( "DButton" )
                    DButton:SetText(v)
                    DButton:Dock(TOP)
                    DButton:DockMargin( 0, 0, 0, 0 )

                    DButton.Paint = function()
                        surface.SetDrawColor(30,30,30,255)
                        surface.DrawRect(0,0, DScrollPanel:GetWide(), DScrollPanel:GetTall())

                        draw.DrawText(v,"DermaDefaultBold", DScrollPanel:GetWide() / 2, 2, Color(255,255,255,255),1)
                    end

                    DButton.DoClick = function()
                        PR_Fraction = v
                        DScrollPanel:Remove()
                    end
                end
            end

            if Fraction then
                PR_Fraction = Fraction
            end

            -------------------------------------------------------------------

            local PR_Name = vgui.Create ("DTextEntry", BackGround)
            PR_Name:SetPos(20,100)
            PR_Name:SetTall(20)
            PR_Name:SetWide(260)
            PR_Name:SetEnterAllowed(true)
            
            if GunName then
                PR_Name:SetValue(GunName)
            end

            -------------------------------------------------------------------
            
            local PR_Price = vgui.Create ("DTextEntry", BackGround)
            PR_Price:SetPos(20,150)
            PR_Price:SetTall(20)
            PR_Price:SetWide(260)
            PR_Price:SetEnterAllowed(true)

            -------------------------------------------------------------------
            
            local PR_Tier = vgui.Create ("DTextEntry", BackGround)
            PR_Tier:SetPos(20,200)
            PR_Tier:SetTall(20)
            PR_Tier:SetWide(260)
            PR_Tier:SetEnterAllowed(true)

            -------------------------------------------------------------------

            local PR_Exp = vgui.Create ("DTextEntry", BackGround)
            PR_Exp:SetPos(20,250)
            PR_Exp:SetTall(20)
            PR_Exp:SetWide(260)
            PR_Exp:SetEnterAllowed(true)

            -------------------------------------------------------------------

            local PR_Weap_Type = "Какого типа оружие"
            
            local ScrollButton = vgui.Create("DButton", BackGround)
            ScrollButton:SetPos(20,300)
            ScrollButton:SetSize(260,20)
            ScrollButton:SetText("")

            ScrollButton.Paint = function()
                surface.SetDrawColor(50,50,50,255)
                surface.DrawRect(0,0, ScrollButton:GetWide(), ScrollButton:GetTall())
                        
                draw.DrawText(PR_Weap_Type,"DermaDefaultBold", ScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            ScrollButton.DoClick = function()
                local DScrollPanel = vgui.Create( "DScrollPanel", BackGround )
                DScrollPanel:SetPos(20,200)
                DScrollPanel:SetSize(260,100)

                local PR_Frac_List = {"pistol","shotgun","smg","ar","sniper","machinegun"}

                for k,v in pairs(PR_Frac_List) do
                    local DButton = DScrollPanel:Add( "DButton" )
                    DButton:SetText("")
                    DButton:Dock(TOP)
                    DButton:DockMargin( 0, 0, 0, 0 )

                    DButton.Paint = function()
                        surface.SetDrawColor(30,30,30,255)
                        surface.DrawRect(0,0, DScrollPanel:GetWide(), DScrollPanel:GetTall())

                        draw.DrawText(v,"DermaDefaultBold", DScrollPanel:GetWide() / 2, 2, Color(255,255,255,255),1)
                    end

                    DButton.DoClick = function()
                        PR_Weap_Type = v
                        DScrollPanel:Remove()
                    end
                end
            end

            if TypeWeapon then
                PR_Weap_Type = TypeWeapon
            end

            local PR_Unlock = "После какого оружия открывается"
            
            local ScrollUnlockButton = vgui.Create("DButton", BackGround)
            ScrollUnlockButton:SetPos(20,340)
            ScrollUnlockButton:SetSize(260,20)
            ScrollUnlockButton:SetText("")

            ScrollUnlockButton.Paint = function()
                surface.SetDrawColor(50,50,50,255)
                surface.DrawRect(0,0, ScrollUnlockButton:GetWide(), ScrollUnlockButton:GetTall())
                        
                draw.DrawText(PR_Unlock,"DermaDefaultBold", ScrollUnlockButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            ScrollUnlockButton.DoClick = function()
                if PR_WS_List[PR_Fraction] != nil and PR_WS_List[PR_Fraction] != {} then
                    local ScrollUnlock = vgui.Create( "DScrollPanel", BackGround )
                    ScrollUnlock:SetPos(20,20)
                    ScrollUnlock:SetSize(260,350)
                
                    local CloseButton = ScrollUnlock:Add( "DButton" )
                    CloseButton:SetText("")
                    CloseButton:Dock(TOP)
                    CloseButton:DockMargin( 0, 0, 0, -2 )
    
                    CloseButton.Paint = function()
                        surface.SetDrawColor(30,30,30,255)
                        surface.DrawRect(0,0, ScrollUnlock:GetWide(), ScrollUnlock:GetTall())
    
                        draw.DrawText("Убрать","DermaDefaultBold", ScrollUnlock:GetWide() / 2, 2, Color(255,255,255,255),1)
                    end
    
                    CloseButton.DoClick = function()
                        PR_Unlock = ""
                        ScrollUnlock:Remove()
                    end

                    for k,v in pairs(PR_WS_List[ply:GetNWString("PR_fraction")]) do
                        local DButton = ScrollUnlock:Add( "DButton" )
                        DButton:SetText("")
                        DButton:Dock(TOP)
                        DButton:DockMargin( 0, 0, 0, 0 )

                        DButton.Paint = function()
                            surface.SetDrawColor(30,30,30,255)
                            surface.DrawRect(0,0, ScrollUnlock:GetWide(), ScrollUnlock:GetTall())

                            draw.DrawText(v["Name"],"DermaDefaultBold", ScrollUnlock:GetWide() / 2, 2, Color(255,255,255,255),1)
                        end

                        DButton.DoClick = function()
                            PR_Unlock = v["ClassName"]
                            ScrollUnlock:Remove()
                        end
                    end
                else
                    return false
                end
            end

            -------------------------------------------------------------------

            local PR_Weapon = "Теперь удачи найти это оружие"
            
            local WeaponScrollButton = vgui.Create("DButton", BackGround)
            WeaponScrollButton:SetPos(20,380)
            WeaponScrollButton:SetSize(260,20)
            WeaponScrollButton:SetText("")

            WeaponScrollButton.Paint = function()
                surface.SetDrawColor(50,50,50,255)
                surface.DrawRect(0,0, WeaponScrollButton:GetWide(), WeaponScrollButton:GetTall())
                        
                draw.DrawText(PR_Weapon,"DermaDefaultBold", WeaponScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            WeaponScrollButton.DoClick = function()
                local Add_Weapon_Frame = vgui.Create("DFrame")
                Add_Weapon_Frame:SetTitle("Негры")
                Add_Weapon_Frame:SetSize(555, 400)
                Add_Weapon_Frame:Center()
                Add_Weapon_Frame:MakePopup()

                local Add_Weapon_Sort = vgui.Create("DTextEntry", Add_Weapon_Frame)
                Add_Weapon_Sort:SetPos(5,5)
                Add_Weapon_Sort:SetTall(20)
                Add_Weapon_Sort:SetWide(260)
                Add_Weapon_Sort:SetEnterAllowed(true)

                local Add_Weapon_Scroll = vgui.Create("DScrollPanel", Add_Weapon_Frame)
                Add_Weapon_Scroll:Dock(FILL)

                local List = vgui.Create("DIconLayout", Add_Weapon_Scroll)
                List:Dock(FILL)
                List:SetSpaceY(5)
                List:SetSpaceX(5)

                --local PR_Weapon_List = {}

                for k,v in pairs(weapons.GetList()) do
                    local Icon_Weapon = PR_GetIconForShop(v["ClassName"])
                    local Name_Weapon = v["PrintName"]
                    if Name_Weapon and Name_Weapon != "Scripted Weapon" and Name_Weapon != "Base Weapon" then
                        local ListItems = List:Add("DPanel")
                        ListItems:SetSize(128, 128)
                        if Icon_Weapon != "" and Icon_Weapon != nil then 
                            ListItems.Paint = function()
                                surface.SetDrawColor(255, 255, 255, 255)
                                surface.SetMaterial(Material(Icon_Weapon))
                                surface.DrawTexturedRect(0, 0, ListItems:GetWide(), ListItems:GetTall())
        
                                draw.DrawText(Name_Weapon, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
        
                                
                                surface.SetDrawColor(200,220,220,255)
                                surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                                surface.DrawRect(0,0,ListItems:GetWide(),1)
                                surface.DrawRect(0,0,1,ListItems:GetTall())
                                surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                            end
                        else
                            ListItems.Paint = function()
                                surface.SetDrawColor(255, 255, 255, 255)
                                draw.DrawText(Name_Weapon, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
        
                                surface.SetDrawColor(200,220,220,255)
                                surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                                surface.DrawRect(0,0,ListItems:GetWide(),1)
                                surface.DrawRect(0,0,1,ListItems:GetTall())
                                surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                            end
                        end
                        local DermaButton = vgui.Create("DButton", ListItems)
                        DermaButton:SetText("")
                        DermaButton:SetPos(0,0)
                        DermaButton:SetSize(ListItems:GetWide(), ListItems:GetTall())
                        DermaButton.Paint = function()
                            surface.SetDrawColor(0, 0, 0, 0)
                        end
        
                        DermaButton.DoClick = function()
                            PR_Weapon = v["ClassName"]
                            PR_Name:SetValue(v["PrintName"])
                            Add_Weapon_Frame:Remove()
                        end
                    end
                end

                Add_Weapon_Sort.OnValueChange = function(self)
                    --print(ListItems)
                    List:Remove()
                    List = vgui.Create("DIconLayout", Add_Weapon_Scroll)
                    List:Dock(FILL)
                    List:SetSpaceY(5)
                    List:SetSpaceX(5)
                    --for i, v in pairs(ListItems) do ListItems[i] = nil end

                    for k,v in pairs (weapons.GetList()) do
                        local Icon_Weapon = PR_GetIconForShop(v["ClassName"])
                        local Name_Weapon = v["PrintName"]
                        if Name_Weapon then
                            if string.find(string.lower(tostring(Name_Weapon)), string.lower(tostring(self:GetValue()))) then
                                ListItems = List:Add("DPanel")
                                ListItems:SetSize(128, 128)
                                if Icon_Weapon != "" and Icon_Weapon != nil then 
                                    ListItems.Paint = function()
                                        surface.SetDrawColor(255, 255, 255, 255)
                                        surface.SetMaterial(Material(Icon_Weapon))
                                        surface.DrawTexturedRect(0, 0, ListItems:GetWide(), ListItems:GetTall())
            
                                        draw.DrawText(Name_Weapon, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
            
                                        
                                        surface.SetDrawColor(200,220,220,255)
                                        surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                                        surface.DrawRect(0,0,ListItems:GetWide(),1)
                                        surface.DrawRect(0,0,1,ListItems:GetTall())
                                        surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                                    end
                                else
                                    ListItems.Paint = function()
                                        surface.SetDrawColor(255, 255, 255, 255)
                                        draw.DrawText(Name_Weapon, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
            
                                        surface.SetDrawColor(200,220,220,255)
                                        surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                                        surface.DrawRect(0,0,ListItems:GetWide(),1)
                                        surface.DrawRect(0,0,1,ListItems:GetTall())
                                        surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                                    end
                                end
                                local DermaButton = vgui.Create("DButton", ListItems)
                                DermaButton:SetText("")
                                DermaButton:SetPos(0,0)
                                DermaButton:SetSize(ListItems:GetWide(), ListItems:GetTall())
                                DermaButton.Paint = function()
                                    surface.SetDrawColor(0, 0, 0, 0)
                                end
            
                                DermaButton.DoClick = function()
                                    PR_Weapon = v["ClassName"]
                                    PR_Name:SetValue(v["PrintName"])
                                    Add_Weapon_Frame:Remove()
                                end
                            end
                        end
                    end
                end
            end

            if ClassNameWeapon then
                PR_Weapon = ClassNameWeapon
            end

            -------------------------------------------------------------------

            local SaveButton = vgui.Create("DButton", BackGround)
            SaveButton:SetPos(20,420)
            SaveButton:SetSize(260,20)
            SaveButton:SetText("")

            SaveButton.Paint = function()
                surface.SetDrawColor(50,50,50,255)
                surface.DrawRect(0,0, SaveButton:GetWide(), SaveButton:GetTall())
                        
                draw.DrawText("Сохранить","DermaDefaultBold", SaveButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            SaveButton.DoClick = function()
                --if PR_Fraction != nil and PR_Fraction != "" and PR_Fraction != "Фракция" and PR_Weapon != nil and PR_Weapon != "" and PR_Weapon != "Теперь удачи найти это оружие" and PR_Name != nil and PR_Name != "" and PR_Price != nil and PR_Tier != nil then
                    

                    if PR_Fraction == nil or PR_Fraction == "" or PR_Fraction == "Фракция" then
                        PR_CreateErrorNotice("Ты не ввёл фракцию")
                        return false
                    end

                    if PR_Name == nil or PR_Name:GetValue() == "" then
                        PR_CreateErrorNotice("Ты не ввёл название")
                        return false
                    end

                    if PR_Price == nil or PR_Price:GetValue() == "" then
                        PR_CreateErrorNotice("Ты не ввёл цену")
                        return false
                    end

                    if PR_Tier == nil or PR_Tier:GetValue() == "" then
                        PR_CreateErrorNotice("Ты не ввёл ранг")
                        return false
                    end

                    if PR_Exp == nil or PR_Exp:GetValue() == "" then
                        PR_CreateErrorNotice("Ты не ввёл попыт")
                        return false
                    end

                    if PR_Weap_Type == nil or PR_Weap_Type == "" or PR_Weap_Type == "Какого типа оружие" then
                        PR_CreateErrorNotice("Ты не ввёл тип оружия")
                        return false
                    end

                    if PR_Weapon == nil or PR_Weapon == "" or PR_Weapon == "Теперь удачи найти это оружие" then
                        PR_CreateErrorNotice("Ты не выбрал какое это оружие")
                        return false
                    end
                
                    if PR_Unlock == "После какого оружия открывается" or PR_Unlock == nil then
                        PR_Unlock = ""
                    end

                    if PR_WS_List != nil then
                        PR_WS_List[PR_Fraction] = PR_WS_List[PR_Fraction] or {}

                        for k,v in pairs(PR_WS_List[PR_Fraction]) do
                            if v["ClassName"] == PR_Weapon then
                                PR_CreateErrorNotice("Такое оружие уже есть во фракции " .. PR_Fraction .. "\nПроверка идёт по его Class Name (самое последнее выбранное)")
                                return false
                            end
                        end

                        table.insert( PR_WS_List[PR_Fraction], {
                            ["Tier"]=tonumber(PR_Tier:GetValue()),
                            ["Type"]=PR_Weap_Type,
                            ["Name"]=PR_Name:GetValue(), 
                            ["ClassName"]=PR_Weapon, 
                            ["Price"]=tonumber(PR_Price:GetValue()), 
                            ["Exp"]=tonumber(PR_Exp:GetValue()),
                            ["NeedToUnlock"]={PR_Unlock}
                        })
                    end

                    PR_Save_Weapons()
                --else
                    --return false
                --end
            end
    end

    function PR_Create_WS_Labels()
        ply = LocalPlayer()
        
		if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
            PR_Panels.CreateNewWeapon = vgui.Create("DButton", MainMenu)
            PR_Panels.CreateNewWeapon:SetPos(1020, 0)
            PR_Panels.CreateNewWeapon:SetSize(180, 25)
            PR_Panels.CreateNewWeapon:SetText("")
            
            PR_Panels.CreateNewWeapon.Paint = function()
                    surface.SetDrawColor(10,10,10,255)
                    surface.DrawRect(0,0, PR_Panels.CreateNewWeapon:GetWide(), PR_Panels.CreateNewWeapon:GetTall())
                    
                    --surface.SetDrawColor(200,220,220,255)
                    --surface.DrawRect(0,64,PR_Panels.CreateNewWeapon:GetWide(),1)
                    --surface.DrawRect(749,0,1,DLabel:GetTall())
                    
                    draw.DrawText("Добавить новую пушку","DermaDefaultBold", PR_Panels.CreateNewWeapon:GetWide() / 2, 5, Color(255,255,255,255),1)
            end
            PR_Panels.CreateNewWeapon.DoClick = function()
                PR_WS_Create()
            end
        end

        
        PR_Panels.Tier1 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier1:SetPos(100, 25)
        PR_Panels.Tier1:SetSize(190, 65)
        PR_Panels.Tier1:SetText("")
        PR_Panels.Tier1.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier1.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier1:GetWide(), PR_Panels.Tier1:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier1:GetWide(),1)
                surface.DrawRect(0,0,PR_Panels.Tier1:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier1:GetTall())
                --surface.DrawRect(749,0,1,PR_Panels.Tier1:GetTall())
        end
        PR_Panels.Tier1.DoClick = function()
            --PR_Show_Weapons(1)
            if PR_Panels.WS_ScrollPanel != nil then
                PR_Panels.WS_ScrollPanel:Remove()
            end
            PR_Select_WS("pistol")
        end
        

        PR_Panels.Tier2 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier2:SetPos(290, 25)
        PR_Panels.Tier2:SetSize(190, 65)
        PR_Panels.Tier2:SetText("")
        PR_Panels.Tier2.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier2.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier2:GetWide(), PR_Panels.Tier2:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier2:GetWide(),1)
                surface.DrawRect(0,0,PR_Panels.Tier2:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier2:GetTall())
        end
        PR_Panels.Tier2.DoClick = function()
            --PR_Show_Weapons(2)
            if PR_Panels.WS_ScrollPanel != nil then
                PR_Panels.WS_ScrollPanel:Remove()
            end
            PR_Select_WS("shotgun")
        end


        PR_Panels.Tier3 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier3:SetPos(470, 25)
        PR_Panels.Tier3:SetSize(190, 65)
        PR_Panels.Tier3:SetText("")
        PR_Panels.Tier3.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier3.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier3:GetWide(), PR_Panels.Tier3:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier3:GetWide(),1)
                surface.DrawRect(0,0,PR_Panels.Tier3:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier3:GetTall())
        end
        PR_Panels.Tier3.DoClick = function()
            if PR_Panels.WS_ScrollPanel != nil then
                PR_Panels.WS_ScrollPanel:Remove()
            end
            PR_Select_WS("smg")
        end

        
        PR_Panels.Tier4 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier4:SetPos(650, 25)
        PR_Panels.Tier4:SetSize(190, 65)
        PR_Panels.Tier4:SetText("")
        
        PR_Panels.Tier4.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier4.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier4:GetWide(), PR_Panels.Tier4:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier4:GetWide(),1)
                surface.DrawRect(0,0,PR_Panels.Tier4:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier4:GetTall())
        end
        PR_Panels.Tier4.DoClick = function()
            if PR_Panels.WS_ScrollPanel != nil then
                PR_Panels.WS_ScrollPanel:Remove()
            end
            PR_Select_WS("ar")
        end
        
        PR_Panels.Tier5 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier5:SetPos(830, 25)
        PR_Panels.Tier5:SetSize(190, 65)
        PR_Panels.Tier5:SetText("")
        
        PR_Panels.Tier5.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier5.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier5:GetWide(), PR_Panels.Tier5:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier5:GetWide(),1)
                surface.DrawRect(0,0,PR_Panels.Tier5:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier5:GetTall())
        end
        PR_Panels.Tier5.DoClick = function()
            if PR_Panels.WS_ScrollPanel != nil then
                PR_Panels.WS_ScrollPanel:Remove()
            end
            PR_Select_WS("sniper")
        end
        
        PR_Panels.Tier6 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier6:SetPos(1010, 25)
        PR_Panels.Tier6:SetSize(190, 65)
        PR_Panels.Tier6:SetText("")
        
        PR_Panels.Tier6.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier6.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier6:GetWide(), PR_Panels.Tier6:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier6:GetWide(),1)
                surface.DrawRect(0,0,PR_Panels.Tier6:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier6:GetTall())
        end
        PR_Panels.Tier6.DoClick = function()
            if PR_Panels.WS_ScrollPanel != nil then
                PR_Panels.WS_ScrollPanel:Remove()
            end
            PR_Select_WS("machinegun")
        end


        --[[ 
        PR_Panels.Tier7 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier7:SetPos(100, 415)
        PR_Panels.Tier7:SetSize(750, 65)
        PR_Panels.Tier7:SetText("")
        
        PR_Panels.Tier7.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier7.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier7:GetWide(), PR_Panels.Tier7:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier7:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier7:GetTall())
                surface.DrawRect(749,0,1,PR_Panels.Tier7:GetTall())
        end
        PR_Panels.Tier7.DoClick = function()
            PR_Show_Weapons(7)
        end
        
        PR_Panels.Tier8 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier8:SetPos(100, 480)
        PR_Panels.Tier8:SetSize(750, 65)
        PR_Panels.Tier8:SetText("")
        
        PR_Panels.Tier8.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier8.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier8:GetWide(), PR_Panels.Tier8:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier8:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier8:GetTall())
                surface.DrawRect(749,0,1,PR_Panels.Tier8:GetTall())
        end
        PR_Panels.Tier8.DoClick = function()
            PR_Show_Weapons(8)
        end
        
        PR_Panels.Tier9 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier9:SetPos(100, 545)
        PR_Panels.Tier9:SetSize(750, 65)
        PR_Panels.Tier9:SetText("")
        
        PR_Panels.Tier9.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier9.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier9:GetWide(), PR_Panels.Tier9:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier9:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier9:GetTall())
                surface.DrawRect(749,0,1,PR_Panels.Tier9:GetTall())
        end
        PR_Panels.Tier9.DoClick = function()
            PR_Show_Weapons(9)
        end
        
        PR_Panels.Tier10 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier10:SetPos(100, 610)
        PR_Panels.Tier10:SetSize(750, 65)
        PR_Panels.Tier10:SetText("")
        
        PR_Panels.Tier10.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier10.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier10:GetWide(), PR_Panels.Tier10:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier10:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier10:GetTall())
                surface.DrawRect(749,0,1,PR_Panels.Tier10:GetTall())
        end
        PR_Panels.Tier10.DoClick = function()
            PR_Show_Weapons(10)
        end
        
        PR_Panels.Tier11 = vgui.Create("DButton", MainMenu)
        PR_Panels.Tier11:SetPos(100, 675)
        PR_Panels.Tier11:SetSize(750, 65)
        PR_Panels.Tier11:SetText("")
        
        PR_Panels.Tier11.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("test_gm_mat/tiers/tier11.png"))
                surface.DrawTexturedRect(0, 0, PR_Panels.Tier11:GetWide(), PR_Panels.Tier11:GetTall())
                
                surface.SetDrawColor(200,220,220,255)
                surface.DrawRect(0,64,PR_Panels.Tier11:GetWide(),1)
                surface.DrawRect(0,0,1,PR_Panels.Tier11:GetTall())
                surface.DrawRect(749,0,1,PR_Panels.Tier11:GetTall())
        end
        PR_Panels.Tier11.DoClick = function()
            PR_Show_Weapons(11)
        end
        ]]
    end

    function PR_Save_Weapons()
        net.Start("SaveWeaponData")
        net.WriteTable(PR_WS_List)
        net.SendToServer()
    end

    function PR_Select_WS(type)
        PR_Panels.WS_ScrollPanel = vgui.Create("DScrollPanel", MainMenu)
        --PR_Panels.WS_ScrollPanel:Dock( FILL )
        PR_Panels.WS_ScrollPanel:SetPos(100,90)
        PR_Panels.WS_ScrollPanel:SetSize(200,710)

        local ply = LocalPlayer()
        PR_PurchasedWeapons = PR_PurchasedWeapons or {}
        PR_Preset = PR_Preset or {}

        PrintTable(PR_WS_List)

        if PR_WS_List != nil then
            if PR_WS_List[ply:GetNWString("PR_fraction")] != nil then
                for k,v in SortedPairsByMemberValue(PR_WS_List[ply:GetNWString("PR_fraction")], "Tier") do
                    if v["Type"] == type then
                        local PR_WS_Gun = PR_Panels.WS_ScrollPanel:Add("DButton")
                        PR_WS_Gun:SetText("")
                        --PR_WS_Gun:SetPos(i,h)
                        PR_WS_Gun:SetSize(PR_Panels.WS_ScrollPanel:GetWide(),60)
                        PR_WS_Gun:Dock( TOP )
                        PR_WS_Gun:DockMargin( 0, 0, 0, 0 )

                        local WeapIsUnlock = false

                        if PR_PurchasedWeapons != {} and PR_PurchasedWeapons != nil then
                            for ki,ev in pairs(v["NeedToUnlock"]) do
                                if ev != nil and ev != "" then
                                    if table.HasValue(PR_PurchasedWeapons, ev) or v["NeedToUnlock"] == "" then
                                        WeapIsUnlock = true
                                    else
                                        if WeapIsUnlock != true then
                                            WeapIsUnlock = false
                                        end
                                    end
                                else
                                    WeapIsUnlock = true
                                end
                            end
                        else
                            WeapIsUnlock = true
                        end

                        PR_WS_Gun.Paint = function()
                            surface.SetDrawColor(255, 255, 255, 240)

                            if WeapIsUnlock then
                                surface.SetMaterial(Material("test_gm_mat/buttons/".. string.lower(ply:GetNWString("PR_fraction")) .."_button.png"))
                            else
                                surface.SetMaterial(Material("test_gm_mat/buttons/".. string.lower(ply:GetNWString("PR_fraction")) .."_button_lock.png"))
                            end
                            --surface.SetMaterial(Material(Icon_Weapon))

                            surface.DrawTexturedRect(0, 0, PR_WS_Gun:GetWide(), PR_WS_Gun:GetTall())

                            draw.DrawText(v["Name"], "DermaDefaultBold", PR_WS_Gun:GetWide()/2, PR_WS_Gun:GetTall()/2.7, Color(255,255,255,255), 1)
                
                            surface.SetDrawColor(200,220,220,255)
                            --surface.DrawRect(0,64,PR_WS_Gun:GetWide(),1)
                            surface.DrawRect(0,59,PR_WS_Gun:GetWide(),1)
                            surface.DrawRect(0,0,1,PR_WS_Gun:GetTall())
                            surface.DrawRect(PR_WS_Gun:GetWide()-1,0,1,PR_WS_Gun:GetTall())

                            --[[ draw.DrawText("Цена: ".. v["Price"], "DermaDefaultBold", 5, 20, Color(255,255,255,255), 0)
                            if v["NeedToUnlock"] != "" and v["NeedToUnlock"] != nil then
                                draw.DrawText("Откроется после: ".. v["NeedToUnlock"], "DermaDefaultBold", 5, 35, Color(255,255,255,255), 0)
                            end ]]
                        end
                        
                        PR_WS_Gun.DoClick = function()
                            if PR_Panels.BuyWindow != nil then
                                PR_Panels.BuyWindow:Remove()
                            end
                            PR_Panels.BuyWindow = vgui.Create("DPanel", MainMenu)
                            PR_Panels.BuyWindow:SetSize(900,710)
                            --BuyWindow:SetPos((ScrW()/2)-BuyWindow:GetWide()/2,(ScrH()/2)-BuyWindow:GetTall()/2)
                            PR_Panels.BuyWindow:SetPos(300,90)
                            --BuyWindow:SetTitle("")
                            --BuyWindow:SetVisible(true)
                            --BuyWindow:SetDraggable(true)
                            --BuyWindow:ShowCloseButton(true)
                            --BuyWindow:MakePopup()

                            local wp_dmg = 0
                            local wp_cal = ""
                            local wp_ntu = ""

                            local Model = vgui.Create("DModelPanel", PR_Panels.BuyWindow)
                            Model:SetPos(0, 150)
                            Model:SetSize(900, 430)
                            Model:SetText("")
                            Model:SetCamPos(Vector(-60, 0, 0))
                            Model:SetLookAng(Angle(0,0,0))
                            local mdl = v["ClassName"]
                            local NeedToUnlock = v["NeedToUnlock"]

                            for k,v in pairs (weapons.GetList()) do
                                if v["ClassName"] == mdl then
                                    Model:SetModel(v["WorldModel"])
                                    --PrintTable(v)
                                    wp_firerate = math.Round(60 / v["FireDelay"])
                                    wp_dmg = v["Damage"]
                                    wp_cal = v["Primary"]["Ammo"]
                                end
                            end

                            for k,weapon in pairs (PR_WS_List[ply:GetNWString("PR_fraction")]) do
                                --PrintTable(NeedToUnlock)
                                for k,v in pairs(NeedToUnlock) do
                                    if v == weapon["ClassName"] then
                                        print(weapon["Name"])
                                        if wp_ntu == "" then
                                            wp_ntu = weapon["Name"]
                                        else
                                            wp_ntu = wp_ntu .. " либо " .. weapon["Name"]
                                        end
                                    end
                                end
                            end


                            PR_Panels.BuyWindow.Paint = function ()
                                draw.RoundedBox(4,0,0,PR_Panels.BuyWindow:GetWide(), PR_Panels.BuyWindow:GetTall(), Color(80,80,80,255))
                                draw.RoundedBox(4,0,0,PR_Panels.BuyWindow:GetWide(), 21, Color(50,50,50,255))

                                draw.DrawText("Ранг: ".. v["Tier"], "panel_INFO_font", 25, 30, Color(255,255,255,255), 0)
                                draw.DrawText(v["Name"], "panel_INFO_font", 450, 30, Color(255,255,255,255), 1)
                                draw.DrawText("Цена: ".. v["Price"], "panel_INFO_font", 875, 30, Color(255,255,255,255), 2)

                                draw.DrawText("Калибр: ".. wp_cal, "panel_INFO_font", 600, 420, Color(255,255,255,255), 0)
                                draw.DrawText("Урон: ".. wp_dmg, "panel_INFO_font", 600, 453, Color(255,255,255,255), 0)
                                draw.DrawText("Скорострельность: ".. wp_firerate, "panel_INFO_font", 600, 485, Color(255,255,255,255), 0)

                                draw.DrawText("Exp: ".. v["Exp"], "panel_INFO_font", 25, 500, Color(255,255,255,255), 0)
                                if v["NeedToUnlock"] != "" and v["NeedToUnlock"] != nil then
                                    draw.DrawText("Разблокируется после: ".. tostring(wp_ntu), "panel_INFO_font", 25, 535, Color(255,255,255,255), 0)
                                end

                                draw.DrawText("Внимание! Моделька ниже не всегда корректная!", "DermaDefaultBold", 450, 155, Color(255,255,255,255), 1)

                                surface.SetDrawColor(255,255,255,255)
                                surface.DrawRect(0,580,PR_Panels.BuyWindow:GetWide(),5)
                            end

                            --if ply:GetNWInt("PR_money") >= v["Price"] then
                                local BuyButton = vgui.Create("DButton", PR_Panels.BuyWindow)
                                BuyButton:SetText("")
                                BuyButton:SetPos(365,590)
                                BuyButton:SetSize(160,60)

                                print("-------")

                                if not table.HasValue(PR_PurchasedWeapons, v["ClassName"]) then
                                    BuyButton.Paint = function()
                                        surface.SetDrawColor(10,10,10,255)
                                        surface.DrawRect(0,0, BuyButton:GetWide(), BuyButton:GetTall())

                                        draw.DrawText("Купить", "panel_INFO_font", BuyButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                                    end

                                    BuyButton.DoClick = function()
                                        local isPlyInBox
            
                                        net.Start("IsPlayerInBuyBox")
                                            net.WriteEntity(ply)
                                            net.WriteString("weapon")
                                        net.SendToServer()
            
                                        net.Receive("SendIsPlayerInBuyBox", function()
                                            isPlyInBox = net.ReadBool()
                                        end)

                                        timer.Simple(0.1, function()
                                            if ply:GetNWInt("PR_money") < v["Price"] then
                                                if not timer.Exists("NoMoney") then
                                                    local NoMoneyLabel = vgui.Create("DLabel", PR_Panels.BuyWindow)
                                                    NoMoneyLabel:SetSize(250,50)
                                                    NoMoneyLabel:SetPos(330,60)
                                                    NoMoneyLabel:SetText("")
                
                                                    NoMoneyLabel.Paint = function()
                                                        draw.DrawText("Не хватает денег!", "panel_INFO_font", NoMoneyLabel:GetWide()/2, 10, Color(255,255,255,timer.TimeLeft("NoMoney")*200), 1)
                                                    end
                
                                                    timer.Create( "NoMoney", 2, 1, function() NoMoneyLabel:Remove() end)
                                                end
                                            elseif ply:GetNWInt("PR_weapon_exp_".. ply:GetNWString("PR_fraction")) < v["Exp"] then
                                                if not timer.Exists("NoExp") then
                                                    local NoExpLabel = vgui.Create("DLabel", PR_Panels.BuyWindow)
                                                    NoExpLabel:SetSize(920,50)
                                                    NoExpLabel:SetPos(0,60)
                                                    NoExpLabel:SetText("")
                
                                                    NoExpLabel.Paint = function()
                                                        draw.DrawText("Не хватает попыта!", "panel_INFO_font", NoExpLabel:GetWide()/2, 10, Color(255,255,255,timer.TimeLeft("NoExp")*200), 1)
                                                    end
                
                                                    timer.Create("NoExp", 2, 1, function() NoExpLabel:Remove() end)
                                                end
                                            elseif WeapIsUnlock != true then
                                                if not timer.Exists("Lock") then
                                                    local LockLabel = vgui.Create("DLabel", PR_Panels.BuyWindow)
                                                    LockLabel:SetSize(920,50)
                                                    LockLabel:SetPos(0,60)
                                                    LockLabel:SetText("")
                
                                                    LockLabel.Paint = function()
                                                        draw.DrawText("У тебя не открыт " .. tostring(wp_ntu) .. "!", "panel_INFO_font", LockLabel:GetWide()/2, 10, Color(255,255,255,timer.TimeLeft("Lock")*200), 1)
                                                    end
                
                                                    timer.Create( "Lock", 2, 1, function() LockLabel:Remove() end)
                                                end
                                            elseif isPlyInBox != true then
                                                if not timer.Exists("NotInBox") then
                                                    local NotInBoxLabel = vgui.Create("DLabel", PR_Panels.BuyWindow)
                                                    NotInBoxLabel:SetSize(920,50)
                                                    NotInBoxLabel:SetPos(0,60)
                                                    NotInBoxLabel:SetText("")
                
                                                    NotInBoxLabel.Paint = function()
                                                        draw.DrawText("Ты не в зоне покупки!", "panel_INFO_font", NotInBoxLabel:GetWide()/2, 10, Color(255,255,255,timer.TimeLeft("NotInBox")*200), 1)
                                                    end
                
                                                    timer.Create( "NotInBox", 2, 1, function() NotInBoxLabel:Remove() end)
                                                end
                                            else
                                                net.Start("GiveWeapon")
                                                net.WriteString(v["ClassName"])
                                                net.WriteInt(v["Price"], 32)
                                                net.WriteInt(v["Exp"], 32)
                                                net.SendToServer()

                                                if not table.HasValue(PR_PurchasedWeapons, v["ClassName"]) then
                                                    table.insert(PR_PurchasedWeapons, v["ClassName"])
                                                end
                                                
                                                PR_Panels.BuyWindow:Remove()
                                            end
                                        end)
                                    end
                                else
                                    BuyButton.Paint = function()
                                        surface.SetDrawColor(10,10,10,255)
                                        surface.DrawRect(0,0, BuyButton:GetWide(), BuyButton:GetTall())
                            
                                        --draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
                                        draw.RoundedBox(0, 0, 0, BuyButton:GetWide(), 1, Color(255,255,255,255)) -- верхушка
                            
                                        draw.RoundedBox(0, 0, 0, 1, BuyButton:GetTall(), Color(255,255,255,255)) -- левушка
                            
                                        draw.RoundedBox(0, BuyButton:GetWide() - 1, 0, 1, BuyButton:GetTall(), Color(255,255,255,255)) -- правушка
                            
                                        draw.RoundedBox(0, 0, BuyButton:GetTall() - 1, BuyButton:GetWide(), 1, Color(255,255,255,255)) -- низушка

                                        draw.DrawText("Экипировать", "panel_INFO_font", BuyButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                                    end

                                    BuyButton.DoClick = function()
                                        local isPlyInBox
            
                                        net.Start("IsPlayerInBuyBox")
                                            net.WriteEntity(ply)
                                            net.WriteString("weapon")
                                        net.SendToServer()
            
                                        net.Receive("SendIsPlayerInBuyBox", function()
                                            isPlyInBox = net.ReadBool()
                                        end)

                                        timer.Simple(0.1, function()
                                            if isPlyInBox != true then
                                                if not timer.Exists("NotInBox") then
                                                    local NotInBoxLabel = vgui.Create("DLabel", PR_Panels.BuyWindow)
                                                    NotInBoxLabel:SetSize(920,50)
                                                    NotInBoxLabel:SetPos(0,60)
                                                    NotInBoxLabel:SetText("")
                
                                                    NotInBoxLabel.Paint = function()
                                                        draw.DrawText("Ты не в зоне покупки!", "panel_INFO_font", NotInBoxLabel:GetWide()/2, 10, Color(255,255,255,timer.TimeLeft("NotInBox")*200), 1)
                                                    end
                
                                                    timer.Create( "NotInBox", 2, 1, function() NotInBoxLabel:Remove() end)
                                                end
                                            else
                                                net.Start("GiveWeapon")
                                                net.WriteString(v["ClassName"])
                                                net.WriteInt(0, 32)
                                                net.WriteInt(0, 32)
                                                net.SendToServer()
                                            end
                                        end)
                                    end

                                    local PrimaryWeapSet = vgui.Create("DButton", PR_Panels.BuyWindow)
                                    PrimaryWeapSet:SetText("")
                                    PrimaryWeapSet:SetPos(0,590)
                                    PrimaryWeapSet:SetSize(175,40)

                                    local primWeap
                                    local sexWeap

                                    if PR_Preset["Primary"] != nil then
                                        if PR_Preset["Primary"]["Name"] != nil then
                                            primWeap = PR_Preset["Primary"]["Name"]
                                        end
                                    else
                                        primWeap = "---"
                                    end

                                    if PR_Preset["Secondary"] != nil then
                                        if PR_Preset["Secondary"]["Name"] != nil then
                                            sexWeap = PR_Preset["Secondary"]["Name"]
                                        end
                                    else
                                        sexWeap = "---"
                                    end

                                    PrimaryWeapSet.Paint = function()
                                        draw.RoundedBox(0, 0, 0, PrimaryWeapSet:GetWide(), PrimaryWeapSet:GetTall(), Color(0,0,0,255))
                            
                                        --draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
                                        draw.RoundedBox(0, 0, 0, PrimaryWeapSet:GetWide(), 1, Color(255,255,255,255)) -- верхушка
                            
                                        draw.RoundedBox(0, 0, 0, 1, PrimaryWeapSet:GetTall(), Color(255,255,255,255)) -- левушка
                            
                                        draw.RoundedBox(0, PrimaryWeapSet:GetWide() - 1, 0, 1, PrimaryWeapSet:GetTall(), Color(255,255,255,255)) -- правушка
                            
                                        draw.RoundedBox(0, 0, PrimaryWeapSet:GetTall() - 1, PrimaryWeapSet:GetWide(), 1, Color(255,255,255,255)) -- низушка
                            
                                        draw.SimpleText("Установить как первичное", "DermaDefaultBold", 3, 3, Color(255,255,255,255), 0)
                                        
                                        draw.SimpleText("Текущее: " .. primWeap, "DermaDefaultBold", 3, 18, Color(255,255,255,255), 0)
                                    end

                                    PrimaryWeapSet.DoClick = function()
                                        net.Start("Preset")
                                        net.WriteString(v["ClassName"])
                                        net.WriteString("Primary")
                                        net.WriteString(v["Name"])
                                        net.SendToServer()

                                        PR_Preset["Primary"] = {
                                            ["Item"] = v["ClassName"],
                                            ["Name"] = v["Name"]
                                        }
                                        primWeap = v["Name"]
                                    end

                                    local SecondaryWeapSet = vgui.Create("DButton", PR_Panels.BuyWindow)
                                    SecondaryWeapSet:SetText("")
                                    SecondaryWeapSet:SetPos(0,650)
                                    SecondaryWeapSet:SetSize(175,40)

                                    SecondaryWeapSet.Paint = function()
                                        draw.RoundedBox(0, 0, 0, SecondaryWeapSet:GetWide(), SecondaryWeapSet:GetTall(), Color(0,0,0,255))
                            
                                        --draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
                                        draw.RoundedBox(0, 0, 0, SecondaryWeapSet:GetWide(), 1, Color(255,255,255,255)) -- верхушка
                            
                                        draw.RoundedBox(0, 0, 0, 1, SecondaryWeapSet:GetTall(), Color(255,255,255,255)) -- левушка
                            
                                        draw.RoundedBox(0, SecondaryWeapSet:GetWide() - 1, 0, 1, SecondaryWeapSet:GetTall(), Color(255,255,255,255)) -- правушка
                            
                                        draw.RoundedBox(0, 0, SecondaryWeapSet:GetTall() - 1, SecondaryWeapSet:GetWide(), 1, Color(255,255,255,255)) -- низушка
                            
                                        draw.SimpleText("Установить как вторичное", "DermaDefaultBold", 3, 3, Color(255,255,255,255), 0)
                                        
                                        draw.SimpleText("Текущее: " .. sexWeap, "DermaDefaultBold", 3, 18, Color(255,255,255,255), 0)
                                    end

                                    SecondaryWeapSet.DoClick = function()
                                        net.Start("Preset")
                                        net.WriteString(v["ClassName"])
                                        net.WriteString("Secondary")
                                        net.WriteString(v["Name"])
                                        net.SendToServer()

                                        PR_Preset["Secondary"] = {
                                            ["Item"] = v["ClassName"],
                                            ["Name"] = v["Name"]
                                        }
                                        sexWeap = v["Name"]
                                    end
                                end
                            --end

                            local CloseButton = vgui.Create("DButton", PR_Panels.BuyWindow)
                            CloseButton:SetText("")
                            CloseButton:SetPos(870,0)
                            CloseButton:SetSize(30,30)

                            CloseButton.Paint = function()
                                surface.SetDrawColor(10,10,10,255)
                                surface.DrawRect(0,0, CloseButton:GetWide(), CloseButton:GetTall())

                                draw.DrawText("X", "panel_INFO_font", CloseButton:GetWide()/2, 1, Color(255,255,255,255), 1)
                            end

                            CloseButton.DoClick = function()
                                PR_Panels.BuyWindow:Remove()
                            end

                            if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
                                local DeleteButton = vgui.Create("DButton", PR_Panels.BuyWindow)
                                DeleteButton:SetText("")
                                DeleteButton:SetPos(750,680)
                                DeleteButton:SetSize(150,30)

                                DeleteButton.Paint = function()
                                    surface.SetDrawColor(10,10,10,255)
                                    surface.DrawRect(0,0, DeleteButton:GetWide(), DeleteButton:GetTall())

                                    draw.DrawText("Удолить", "panel_INFO_font", DeleteButton:GetWide()/2, 1, Color(255,255,255,255), 1)
                                end

                                DeleteButton.DoClick = function()
                                    table.RemoveByValue(PR_WS_List[ply:GetNWString("PR_fraction")], v)
                                    PR_Save_Weapons()
                                end

                                local AddNewUnlockWeaponButton = vgui.Create("DButton", PR_Panels.BuyWindow)
                                AddNewUnlockWeaponButton:SetText("")
                                AddNewUnlockWeaponButton:SetSize(350,30)
                                AddNewUnlockWeaponButton:SetPos(PR_Panels.BuyWindow:GetWide() / 2 - AddNewUnlockWeaponButton:GetWide() / 2,680)

                                AddNewUnlockWeaponButton.Paint = function()
                                    surface.SetDrawColor(10,10,10,255)
                                    surface.DrawRect(0,0, AddNewUnlockWeaponButton:GetWide(), AddNewUnlockWeaponButton:GetTall())

                                    draw.DrawText("Добавить пушку для анлока", "panel_INFO_font", AddNewUnlockWeaponButton:GetWide()/2, 1, Color(255,255,255,255), 1)
                                end

                                AddNewUnlockWeaponButton.DoClick = function()
                                    local BackGround = vgui.Create ("DFrame")
                                    BackGround:SetSize(300,200)
                                    BackGround:SetPos((ScrW()/2)-BackGround:GetWide(),(ScrH()/2)-BackGround:GetTall())
                                    BackGround:SetTitle("")
                                    BackGround:SetVisible(true)
                                    BackGround:SetDraggable(true)
                                    BackGround:ShowCloseButton(true)
                                    BackGround:MakePopup()
                                    BackGround.Paint = function ()
                                        draw.RoundedBox(4,0,0,BackGround:GetWide(), BackGround:GetTall(), Color(100,100,100,200))
                                        draw.RoundedBox(4,0,0,BackGround:GetWide()-4, 21, Color(50,50,50,200))
                                    end

                                    local PR_Unlock = "После какого оружия открывается"
                                    
                                    local ScrollUnlockButton = vgui.Create("DButton", BackGround)
                                    ScrollUnlockButton:SetPos(20,50)
                                    ScrollUnlockButton:SetSize(260,20)
                                    ScrollUnlockButton:SetText("")
                        
                                    ScrollUnlockButton.Paint = function()
                                        surface.SetDrawColor(50,50,50,255)
                                        surface.DrawRect(0,0, ScrollUnlockButton:GetWide(), ScrollUnlockButton:GetTall())
                                                
                                        draw.DrawText(PR_Unlock,"DermaDefaultBold", ScrollUnlockButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                                    end
                        
                                    ScrollUnlockButton.DoClick = function()
                                        if PR_WS_List[ply:GetNWString("PR_fraction")] != nil and PR_WS_List[ply:GetNWString("PR_fraction")] != {} then
                                            local ScrollUnlock = vgui.Create( "DScrollPanel", BackGround )
                                            ScrollUnlock:SetPos(20,20)
                                            ScrollUnlock:SetSize(260,350)
                                        
                                            local CloseButton = ScrollUnlock:Add( "DButton" )
                                            CloseButton:SetText("")
                                            CloseButton:Dock(TOP)
                                            CloseButton:DockMargin( 0, 0, 0, -2 )
                            
                                            CloseButton.Paint = function()
                                                surface.SetDrawColor(30,30,30,255)
                                                surface.DrawRect(0,0, ScrollUnlock:GetWide(), ScrollUnlock:GetTall())
                            
                                                draw.DrawText("Убрать","DermaDefaultBold", ScrollUnlock:GetWide() / 2, 2, Color(255,255,255,255),1)
                                            end
                            
                                            CloseButton.DoClick = function()
                                                PR_Unlock = ""
                                                ScrollUnlock:Remove()
                                            end
                        
                                            for k,v in pairs(PR_WS_List[ply:GetNWString("PR_fraction")]) do
                                                local DButton = ScrollUnlock:Add( "DButton" )
                                                DButton:SetText("")
                                                DButton:Dock(TOP)
                                                DButton:DockMargin( 0, 0, 0, 0 )
                        
                                                DButton.Paint = function()
                                                    surface.SetDrawColor(30,30,30,255)
                                                    surface.DrawRect(0,0, ScrollUnlock:GetWide(), ScrollUnlock:GetTall())
                        
                                                    draw.DrawText(v["Name"],"DermaDefaultBold", ScrollUnlock:GetWide() / 2, 2, Color(255,255,255,255),1)
                                                end
                        
                                                DButton.DoClick = function()
                                                    PR_Unlock = v["ClassName"]
                                                    ScrollUnlock:Remove()
                                                end
                                            end
                                        else
                                            return false
                                        end
                                    end

                                    local SaveButton = vgui.Create("DButton", BackGround)
                                    SaveButton:SetPos(20,140)
                                    SaveButton:SetSize(260,20)
                                    SaveButton:SetText("")
                        
                                    SaveButton.Paint = function()
                                        surface.SetDrawColor(50,50,50,255)
                                        surface.DrawRect(0,0, SaveButton:GetWide(), SaveButton:GetTall())
                                                
                                        draw.DrawText("Сохранить","DermaDefaultBold", SaveButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                                    end
                        
                                    SaveButton.DoClick = function()
                                        table.insert(v["NeedToUnlock"], PR_Unlock)
                                        PR_Save_Weapons()
                                        BackGround:Remove()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    net.Receive("WeaponTable", function()
        PR_WS_List = net.ReadTable()
    end)
end