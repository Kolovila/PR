if CLIENT then
    local ply

    function PR_Equip_Create(Tier, EquipName, EquipClass)
        local BackGround = vgui.Create ("DFrame")
		BackGround:SetSize(300,350)
		BackGround:SetPos((ScrW()/2)-BackGround:GetWide(),(ScrH()/2)-BackGround:GetTall())
		BackGround:SetTitle("")
		BackGround:SetVisible(true)
		BackGround:SetDraggable(true)
		BackGround:ShowCloseButton(true)
		BackGround:MakePopup()
		BackGround.Paint = function ()
		    draw.RoundedBox(4,0,0,BackGround:GetWide(), BackGround:GetTall(), Color(100,100,100,200))
			draw.RoundedBox(4,0,0,BackGround:GetWide()-4, 21, Color(50,50,50,200))
            draw.DrawText("Название","DermaDefaultBold", BackGround:GetWide() / 2, 40, Color(255,255,255,255),1)
            draw.DrawText("Цена","DermaDefaultBold", BackGround:GetWide() / 2, 90, Color(255,255,255,255),1)
            draw.DrawText("Введи её здесь","DermaDefaultBold", BackGround:GetWide() / 2, 180, Color(255,255,255,255),1)
		end

        -------------------------------------------------------------------

		local PR_Name = vgui.Create ("DTextEntry", BackGround)
		PR_Name:SetPos(20,60)
		PR_Name:SetTall(20)
		PR_Name:SetWide(260)
		PR_Name:SetEnterAllowed(true)

        if EquipName then 
            PR_Name:SetValue(EquipName)
        end

        -------------------------------------------------------------------
		
		local PR_Price = vgui.Create ("DTextEntry", BackGround)
		PR_Price:SetPos(20,110)
		PR_Price:SetTall(20)
		PR_Price:SetWide(260)
		PR_Price:SetEnterAllowed(true)

        -------------------------------------------------------------------

        local PR_Tier = "К какому снаряжению это относится"

        local TierScrollButton = vgui.Create("DButton", BackGround)
        TierScrollButton:SetPos(20,150)
        TierScrollButton:SetSize(260,20)
        TierScrollButton:SetText("")

        TierScrollButton.Paint = function()
            surface.SetDrawColor(50,50,50,255)
            surface.DrawRect(0,0, TierScrollButton:GetWide(), TierScrollButton:GetTall())
                    
            draw.DrawText(PR_Tier,"DermaDefaultBold", TierScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
        end

        if EquipClass then
            PR_Tier = Tier
        end

        TierScrollButton.DoClick = function()
            local TierScrollPanel = vgui.Create( "DScrollPanel", BackGround )
            TierScrollPanel:SetPos(20,20)
            TierScrollPanel:SetSize(260,350)
            
            local CloseButton = TierScrollPanel:Add( "DButton" )
            CloseButton:SetText("")
            CloseButton:Dock(TOP)
            CloseButton:DockMargin( 0, 0, 0, -2 )

            CloseButton.Paint = function()
                surface.SetDrawColor(30,30,30,255)
                surface.DrawRect(0,0, TierScrollButton:GetWide(), TierScrollButton:GetTall())

                draw.DrawText("Закрыть","DermaDefaultBold", TierScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            CloseButton.DoClick = function()
                TierScrollPanel:Remove()
            end

            local tiers = {"grenade_lethal", "grenade_unlethal", "explosion", "melee_weapon", "stims", "first_aid", "stations_device", "binoculars", "rocket_launchers", "signal_device", "armor_and_else"}

            for k,v in pairs (tiers) do
                local Button = TierScrollPanel:Add( "DButton" )
                Button:SetText("")
                Button:Dock(TOP)
                Button:DockMargin( 0, 0, 0, -2 )

                Button.Paint = function()
                    surface.SetDrawColor(30,30,30,255)
                    surface.DrawRect(0,0, TierScrollButton:GetWide(), TierScrollButton:GetTall())

                    draw.DrawText(v,"DermaDefaultBold", TierScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                end

                Button.DoClick = function()
                    PR_Tier = v
                    TierScrollPanel:Remove()
                end
            end
        end

        -------------------------------------------------------------------

		local PR_Entity = vgui.Create ("DTextEntry", BackGround)
		PR_Entity:SetPos(20,200)
		PR_Entity:SetTall(20)
		PR_Entity:SetWide(260)
		PR_Entity:SetEnterAllowed(true)
            
        local EntityScrollButton = vgui.Create("DButton", BackGround)
        EntityScrollButton:SetPos(20,250)
        EntityScrollButton:SetSize(260,20)
        EntityScrollButton:SetText("")

        EntityScrollButton.Paint = function()
            surface.SetDrawColor(50,50,50,255)
            surface.DrawRect(0,0, EntityScrollButton:GetWide(), EntityScrollButton:GetTall())
                    
            draw.DrawText("Либо найди здесь", "DermaDefaultBold", EntityScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
        end

        if EquipClass then
            PR_Entity:SetValue(EquipClass)
        end

        EntityScrollButton.DoClick = function()
            local Add_Entity_Frame = vgui.Create("DFrame")
            Add_Entity_Frame:SetTitle("Негры")
            Add_Entity_Frame:SetSize(555, 400)
            Add_Entity_Frame:Center()
            Add_Entity_Frame:MakePopup()

            local Add_Entity_Sort = vgui.Create("DTextEntry", Add_Entity_Frame)
            Add_Entity_Sort:SetPos(5,5)
            Add_Entity_Sort:SetTall(20)
            Add_Entity_Sort:SetWide(260)
            Add_Entity_Sort:SetEnterAllowed(true)

            local Add_Entity_Scroll = vgui.Create("DScrollPanel", Add_Entity_Frame)
            Add_Entity_Scroll:Dock(FILL)

            local List = vgui.Create("DIconLayout", Add_Entity_Scroll)
            List:Dock(FILL)
            List:SetSpaceY(5)
            List:SetSpaceX(5)

            for k,v in pairs(scripted_ents.GetList()) do
                local Icon_Entity = PR_GetIconForShop(v['t']['ClassName'])
                local Name_Entity = v['t']['PrintName']
                if Name_Entity then
                    local ListItems = List:Add("DPanel")
                    ListItems:SetSize(128, 128)
                    if Icon_Entity != "" and Icon_Entity != nil then 
                        ListItems.Paint = function()
                            surface.SetDrawColor(255, 255, 255, 255)
                            surface.SetMaterial(Material(Icon_Entity))
                            surface.DrawTexturedRect(0, 0, ListItems:GetWide(), ListItems:GetTall())
            
                            draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
            
                            
                            surface.SetDrawColor(200,220,220,255)
                            surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                            surface.DrawRect(0,0,ListItems:GetWide(),1)
                            surface.DrawRect(0,0,1,ListItems:GetTall())
                            surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                        end
                    else
                        ListItems.Paint = function()
                            surface.SetDrawColor(255, 255, 255, 255)
                            draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
            
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
                        PR_Entity:SetValue(v['t']['ClassName'])
                        PR_Name:SetValue(v['t']['PrintName'])
                        Add_Entity_Frame:Remove()
                    end
                end
            end

            for k,v in pairs (weapons.GetList()) do
                local Icon_Entity = PR_GetIconForShop(v["ClassName"])
                local Name_Entity = v["PrintName"]
                if Name_Entity and Name_Entity != "Scripted Weapon" and Name_Entity != "Base Weapon" then
                    local ListItems = List:Add("DPanel")
                    ListItems:SetSize(128, 128)
                    if Icon_Entity != "" and Icon_Entity != nil then 
                        ListItems.Paint = function()
                            surface.SetDrawColor(255, 255, 255, 255)
                            surface.SetMaterial(Material(Icon_Entity))
                            surface.DrawTexturedRect(0, 0, ListItems:GetWide(), ListItems:GetTall())
        
                            draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
        

                            surface.SetDrawColor(200,220,220,255)
                            surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                            surface.DrawRect(0,0,ListItems:GetWide(),1)
                            surface.DrawRect(0,0,1,ListItems:GetTall())
                            surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                        end
                    else
                        ListItems.Paint = function()
                            surface.SetDrawColor(255, 255, 255, 255)
                            draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
        
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
                        PR_Entity:SetValue(v["ClassName"])
                        PR_Name:SetValue(v["PrintName"])
                        Add_Entity_Frame:Remove()
                    end
                end
            end

            Add_Entity_Sort.OnValueChange = function(self)
                --print(ListItems)
                List:Remove()
                List = vgui.Create("DIconLayout", Add_Entity_Scroll)
                List:Dock(FILL)
                List:SetSpaceY(5)
                List:SetSpaceX(5)
                --for i, v in pairs(ListItems) do ListItems[i] = nil end

                for k,v in pairs (scripted_ents.GetList()) do
                    local Icon_Entity = PR_GetIconForShop(v['t']['ClassName'])
                    local Name_Entity = v['t']['PrintName']
                    if Name_Entity then
                        if string.find(string.lower(tostring(Name_Entity)), string.lower(tostring(self:GetValue()))) then
                            ListItems = List:Add("DPanel")
                            ListItems:SetSize(128, 128)
                            if Icon_Entity != "" and Icon_Entity != nil then 
                                ListItems.Paint = function()
                                    surface.SetDrawColor(255, 255, 255, 255)
                                    surface.SetMaterial(Material(Icon_Entity))
                                    surface.DrawTexturedRect(0, 0, ListItems:GetWide(), ListItems:GetTall())
        
                                    draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
        
                                    
                                    surface.SetDrawColor(200,220,220,255)
                                    surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                                    surface.DrawRect(0,0,ListItems:GetWide(),1)
                                    surface.DrawRect(0,0,1,ListItems:GetTall())
                                    surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                                end
                            else
                                ListItems.Paint = function()
                                    surface.SetDrawColor(255, 255, 255, 255)
                                    draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
        
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
                                PR_Entity:SetValue(v['t']['ClassName'])
                                PR_Name:SetValue(v['t']['PrintName'])
                                Add_Entity_Frame:Remove()
                            end
                        end
                    end
                end

                for k,v in pairs (weapons.GetList()) do
                    local Icon_Entity = PR_GetIconForShop(v["ClassName"])
                    local Name_Entity = v["PrintName"]
                    if Name_Entity and Name_Entity != "Scripted Weapon" and Name_Entity != "Base Weapon" then
                        if string.find(string.lower(tostring(Name_Entity)), string.lower(tostring(self:GetValue()))) then
                            local ListItems = List:Add("DPanel")
                            ListItems:SetSize(128, 128)
                            if Icon_Entity != "" and Icon_Entity != nil then 
                                ListItems.Paint = function()
                                    surface.SetDrawColor(255, 255, 255, 255)
                                    surface.SetMaterial(Material(Icon_Entity))
                                    surface.DrawTexturedRect(0, 0, ListItems:GetWide(), ListItems:GetTall())
                
                                    draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
                
        
                                    surface.SetDrawColor(200,220,220,255)
                                    surface.DrawRect(0,ListItems:GetTall()-1,ListItems:GetWide(),1)
                                    surface.DrawRect(0,0,ListItems:GetWide(),1)
                                    surface.DrawRect(0,0,1,ListItems:GetTall())
                                    surface.DrawRect(ListItems:GetWide()-1,0,1,ListItems:GetTall())
                                end
                            else
                                ListItems.Paint = function()
                                    surface.SetDrawColor(255, 255, 255, 255)
                                    draw.DrawText(Name_Entity, "DermaDefaultBold", 3, 1, Color(255,255,255,255), 0)
                
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
                                PR_Entity:SetValue(v["ClassName"])
                                PR_Name:SetValue(v["PrintName"])
                                Add_Entity_Frame:Remove()
                            end
                        end
                    end
                end
            end
        end

        -------------------------------------------------------------------

        local SaveButton = vgui.Create("DButton", BackGround)
        SaveButton:SetPos(20,310)
        SaveButton:SetSize(260,20)
        SaveButton:SetText("")

        SaveButton.Paint = function()
            surface.SetDrawColor(50,50,50,255)
            surface.DrawRect(0,0, SaveButton:GetWide(), SaveButton:GetTall())
                    
            draw.DrawText("Сохранить","DermaDefaultBold", SaveButton:GetWide() / 2, 2, Color(255,255,255,255),1)
        end

        SaveButton.DoClick = function()
            --if PR_Equip != nil and PR_Equip != "" and PR_Equip != "Теперь удачи найти это оружие" and PR_Name != nil and PR_Name != "" and PR_Price != nil and PR_Type != nil and PR_Type != "" and PR_Tier != nil and PR_Tier != "" then

            if PR_Name:GetValue() == nil or PR_Name:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл название")
                return false
            end

            if PR_Price:GetValue() == nil or PR_Price:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл цену")
                return false
            end

            if PR_Tier == nil or PR_Tier == "" or PR_Tier == "К какому снаряжению это относится" then
                PR_CreateErrorNotice("Ты не выбрал к какому снаряжению это относится")
                return false
            end

            if PR_Entity:GetValue() == nil or PR_Entity:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл её хуйню короче последнюю")
                return false
            end

            if PR_Equip_List != nil then
                PR_Equip_List = PR_Equip_List or {}
                table.insert(
                    PR_Equip_List,
                    {
                    ["Name"]=PR_Name:GetValue(),
                    ["ClassName"]=PR_Entity:GetValue(),
                    ["Price"]=tonumber(PR_Price:GetValue()),
                    ["Tier"]=PR_Tier
                    }
                )
            end

            PR_Save_Equip()

            --else
                --return false
            --end
        end

    end
    
    function PR_Show_Equip(Tier)
        PR_Clear_All_Parasha()

        PR_Panels.EquipBackGround = vgui.Create("DPanel", MainMenu)
        PR_Panels.EquipBackGround:SetPos(100, 25)
        PR_Panels.EquipBackGround:SetSize(750, 725)
        PR_Panels.EquipBackGround:SetText("")
        PR_Panels.EquipBackGround.Paint = function()
            surface.SetDrawColor(0,0,0,0)
            surface.DrawRect(0,0, PR_Panels.EquipBackGround:GetWide(), PR_Panels.EquipBackGround:GetTall())
        end


        local i = 10
        local h = 5
        if PR_Equip_List != nil then
            for k,v in pairs (PR_Equip_List) do
                if v["Tier"] == Tier then
                    local PR_Equip_Item = vgui.Create("DButton", PR_Panels.EquipBackGround)
                    PR_Equip_Item:SetText("")
                    PR_Equip_Item:SetPos(i,h)
                    PR_Equip_Item:SetSize(175,60)

                    PR_Equip_Item.Paint = function()
                        surface.SetDrawColor(255, 255, 255, 240)
                        surface.SetMaterial(Material("test_gm_mat/buttons/".. string.lower(ply:GetNWString("PR_fraction")) .."_button.png"))
                        surface.DrawTexturedRect(0, 0, PR_Equip_Item:GetWide(), PR_Equip_Item:GetTall())

                        draw.DrawText("Снаряга: ".. v["Name"], "DermaDefaultBold", 5, 5, Color(255,255,255,255), 0)
                        draw.DrawText("Цена: ".. v["Price"], "DermaDefaultBold", 5, 20, Color(255,255,255,255), 0)
                    end
                    
                    PR_Equip_Item.DoClick = function()
                        local BuyWindow = vgui.Create ("DFrame")
                        BuyWindow:SetSize(700,700)
                        BuyWindow:SetPos((ScrW()/2)-BuyWindow:GetWide()/2,(ScrH()/2)-BuyWindow:GetTall()/2)
                        BuyWindow:SetTitle("")
                        BuyWindow:SetVisible(true)
                        BuyWindow:SetDraggable(true)
                        BuyWindow:ShowCloseButton(true)
                        BuyWindow:MakePopup()
                        BuyWindow.Paint = function ()
                            draw.RoundedBox(4,0,0,BuyWindow:GetWide(), BuyWindow:GetTall(), Color(80,80,80,255))
                            draw.RoundedBox(4,0,0,BuyWindow:GetWide(), 21, Color(50,50,50,255))

                            draw.DrawText("Название: ".. v["Name"], "panel_INFO_font", 25, 30, Color(255,255,255,255), 0)
                            draw.DrawText("Цена: ".. v["Price"], "panel_INFO_font", 25, 60, Color(255,255,255,255), 0)
                            draw.DrawText("Внимание! Моделька ниже не всегда корректная!", "DermaDefaultBold", 350, 155, Color(255,255,255,255), 1)
                        end

                        local Model = vgui.Create("DModelPanel", BuyWindow)
                        Model:SetPos(100, 150)
                        Model:SetSize(500, 430)
                        Model:SetText("")
                        Model:SetCamPos(Vector(-40, 0, 0))
                        Model:SetLookAng(Angle(0,0,0))
                        if v["Type"] == "weapon" then
                            local mdl = v["ClassName"]
                            for k,v in pairs (weapons.GetList()) do
                                if v["ClassName"] == mdl then
                                    Model:SetModel(v["WorldModel"])
                                end
                            end
                        elseif v["Type"] == "entity" then
                            --local ent = ents.CreateClientside(v["ClassName"])
                            --Model:SetModel(ent:GetModel())
                            --PrintTable(scripted_ents.Get("tfa_ammo_357"))
                            Model:SetModel("models/error.mdl")
                            Model:SetCamPos(Vector(-100, 0, 40))
                        end

                        if ply:GetNWInt("PR_money") >= v["Price"] then
                            local BuyButton = vgui.Create("DButton", BuyWindow)
                            BuyButton:SetText("")
                            BuyButton:SetPos(275,600)
                            BuyButton:SetSize(150,60)

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
                                            local NoMoneyLabel = vgui.Create("DLabel", BuyWindow)
                                            NoMoneyLabel:SetSize(250,50)
                                            NoMoneyLabel:SetPos(BuyWindow:GetWide()/2 - 125,100)
                                            NoMoneyLabel:SetText("")

                                            NoMoneyLabel.Paint = function()
                                                draw.DrawText("Не хватает денег!", "panel_INFO_font", NoMoneyLabel:GetWide()/2, 10, Color(255,255,255,255), 1)
                                            end

                                            timer.Create("NoMoney", 2, 1, function() NoMoneyLabel:Remove() end)
                                        end
                                    elseif isPlyInBox != true then
                                        if not timer.Exists("NotInBox") then
                                            local NotInBoxLabel = vgui.Create("DLabel", BuyWindow)
                                            NotInBoxLabel:SetSize(250,50)
                                            NotInBoxLabel:SetPos(BuyWindow:GetWide()/2 - 125,100)
                                            NotInBoxLabel:SetText("")
        
                                            NotInBoxLabel.Paint = function()
                                                draw.DrawText("Ты не в зоне покупки!", "panel_INFO_font", NotInBoxLabel:GetWide()/2, 10, Color(255,255,255,timer.TimeLeft("NotInBox")*200), 1)
                                            end
        
                                            timer.Create( "NotInBox", 2, 1, function() NotInBoxLabel:Remove() end)
                                        end
                                    else
                                        net.Start("GiveEnity")
                                        net.WriteString(v["ClassName"])
                                        net.WriteInt(v["Price"], 32)
                                        net.SendToServer()
                                    end
                                end)
                            end
                        end

                        if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
                            local DeleteButton = vgui.Create("DButton", BuyWindow)
                            DeleteButton:SetText("")
                            DeleteButton:SetPos(500,600)
                            DeleteButton:SetSize(150,60)

                            DeleteButton.Paint = function()
                                surface.SetDrawColor(10,10,10,255)
                                surface.DrawRect(0,0, DeleteButton:GetWide(), DeleteButton:GetTall())

                                draw.DrawText("Удолить", "panel_INFO_font", DeleteButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                            end

                            DeleteButton.DoClick = function()
                                table.RemoveByValue(PR_Equip_List, v)
                                PR_Save_Equip()
                            end
                        end
                    end

                    
                    i = i + 185
                    if i == 750 then
                        i = 10
                        h = h + 65
                    end
                end
            end
        end
    end

    function PR_Create_Equip_Labels()
        ply = LocalPlayer()

        if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
            PR_Panels.CreateNewEquip = vgui.Create("DButton", MainMenu)
            PR_Panels.CreateNewEquip:SetPos(1000, 0)
            PR_Panels.CreateNewEquip:SetSize(200, 25)
            PR_Panels.CreateNewEquip:SetText("")

            PR_Panels.CreateNewEquip.Paint = function()
                surface.SetDrawColor(10,10,10,255)
                surface.DrawRect(0,0, PR_Panels.CreateNewEquip:GetWide(), PR_Panels.CreateNewEquip:GetTall())
                
                draw.DrawText("Добавить новую снарягу","DermaDefaultBold", PR_Panels.CreateNewEquip:GetWide() / 2, 5, Color(255,255,255,255),1)
            end

            PR_Panels.CreateNewEquip.DoClick = function()
                PR_Equip_Create()
            end
        end


        PR_Panels.LethalGrenades = vgui.Create("DButton", MainMenu)
        PR_Panels.LethalGrenades:SetPos(100, 25)
        PR_Panels.LethalGrenades:SetSize(1100, 70)
        PR_Panels.LethalGrenades:SetText("")
        PR_Panels.LethalGrenades.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/grenadesl.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.LethalGrenades:GetWide(), PR_Panels.LethalGrenades:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.LethalGrenades:GetWide(),1)
            surface.DrawRect(0,0,PR_Panels.LethalGrenades:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.LethalGrenades:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.LethalGrenades:GetTall())
        end
        PR_Panels.LethalGrenades.DoClick = function()
            PR_Show_Equip("grenade_lethal")
        end
        

        PR_Panels.UnLethalGrenades = vgui.Create("DButton", MainMenu)
        PR_Panels.UnLethalGrenades:SetPos(100, 95)
        PR_Panels.UnLethalGrenades:SetSize(1100, 70)
        PR_Panels.UnLethalGrenades:SetText("")
        PR_Panels.UnLethalGrenades.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/grenadesn.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.UnLethalGrenades:GetWide(), PR_Panels.UnLethalGrenades:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.UnLethalGrenades:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.UnLethalGrenades:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.UnLethalGrenades:GetTall())
        end
        PR_Panels.UnLethalGrenades.DoClick = function()
            PR_Show_Equip("grenade_unlethal")
        end


        PR_Panels.Explosive = vgui.Create("DButton", MainMenu)
        PR_Panels.Explosive:SetPos(100, 165)
        PR_Panels.Explosive:SetSize(1100, 70)
        PR_Panels.Explosive:SetText("")
        PR_Panels.Explosive.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/explosive.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Explosive:GetWide(), PR_Panels.Explosive:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Explosive:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Explosive:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Explosive:GetTall())
        end
        PR_Panels.Explosive.DoClick = function()
            PR_Show_Equip("explosion")
        end

        
        PR_Panels.Melee = vgui.Create("DButton", MainMenu)
        PR_Panels.Melee:SetPos(100, 235)
        PR_Panels.Melee:SetSize(1100, 70)
        PR_Panels.Melee:SetText("")
        
        PR_Panels.Melee.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/melee.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Melee:GetWide(), PR_Panels.Melee:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Melee:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Melee:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Melee:GetTall())
        end
        PR_Panels.Melee.DoClick = function()
            PR_Show_Equip("melee_weapon")
        end
        
        PR_Panels.Stims = vgui.Create("DButton", MainMenu)
        PR_Panels.Stims:SetPos(100, 305)
        PR_Panels.Stims:SetSize(1100, 70)
        PR_Panels.Stims:SetText("")
        
        PR_Panels.Stims.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/stims.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Stims:GetWide(), PR_Panels.Stims:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Stims:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Stims:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Stims:GetTall())
        end
        PR_Panels.Stims.DoClick = function()
            PR_Show_Equip("stims")
        end
        
        PR_Panels.Med = vgui.Create("DButton", MainMenu)
        PR_Panels.Med:SetPos(100, 375)
        PR_Panels.Med:SetSize(1100, 70)
        PR_Panels.Med:SetText("")
        
        PR_Panels.Med.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/med.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Med:GetWide(), PR_Panels.Med:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Med:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Med:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Med:GetTall())
        end
        PR_Panels.Med.DoClick = function()
            PR_Show_Equip("first_aid")
        end
        
        PR_Panels.Stationary = vgui.Create("DButton", MainMenu)
        PR_Panels.Stationary:SetPos(100, 445)
        PR_Panels.Stationary:SetSize(1100, 70)
        PR_Panels.Stationary:SetText("")
        
        PR_Panels.Stationary.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/stationary.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Stationary:GetWide(), PR_Panels.Stationary:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Stationary:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Stationary:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Stationary:GetTall())
        end
        PR_Panels.Stationary.DoClick = function()
            PR_Show_Equip("stations_device")
        end
        
        PR_Panels.Binoculars = vgui.Create("DButton", MainMenu)
        PR_Panels.Binoculars:SetPos(100, 515)
        PR_Panels.Binoculars:SetSize(1100, 70)
        PR_Panels.Binoculars:SetText("")
        
        PR_Panels.Binoculars.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/binocular.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Binoculars:GetWide(), PR_Panels.Binoculars:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Binoculars:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Binoculars:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Binoculars:GetTall())
        end
        PR_Panels.Binoculars.DoClick = function()
            PR_Show_Equip("binoculars")
        end
        
        PR_Panels.Launchers = vgui.Create("DButton", MainMenu)
        PR_Panels.Launchers:SetPos(100, 585)
        PR_Panels.Launchers:SetSize(1100, 70)
        PR_Panels.Launchers:SetText("")
        
        PR_Panels.Launchers.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/launchers.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Launchers:GetWide(), PR_Panels.Launchers:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Launchers:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Launchers:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Launchers:GetTall())
        end
        PR_Panels.Launchers.DoClick = function()
            PR_Show_Equip("rocket_launchers")
        end
        
        PR_Panels.Sign = vgui.Create("DButton", MainMenu)
        PR_Panels.Sign:SetPos(100, 655)
        PR_Panels.Sign:SetSize(1100, 70)
        PR_Panels.Sign:SetText("")
        
        PR_Panels.Sign.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/sign.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.Sign:GetWide(), PR_Panels.Sign:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.Sign:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.Sign:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.Sign:GetTall())
        end
        PR_Panels.Sign.DoClick = function()
            PR_Show_Equip("signal_device")
        end
        
        PR_Panels.ArmAndAcces = vgui.Create("DButton", MainMenu)
        PR_Panels.ArmAndAcces:SetPos(100, 725)
        PR_Panels.ArmAndAcces:SetSize(1100, 70)
        PR_Panels.ArmAndAcces:SetText("")
        
        PR_Panels.ArmAndAcces.Paint = function()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("test_gm_mat/equips/armandother.png"))
            surface.DrawTexturedRect(0, 0, PR_Panels.ArmAndAcces:GetWide(), PR_Panels.ArmAndAcces:GetTall())
            
            surface.SetDrawColor(200,220,220,255)
            surface.DrawRect(0,69,PR_Panels.ArmAndAcces:GetWide(),1)
            surface.DrawRect(0,0,1,PR_Panels.ArmAndAcces:GetTall())
            surface.DrawRect(1099,0,1,PR_Panels.ArmAndAcces:GetTall())
        end
        PR_Panels.ArmAndAcces.DoClick = function()
            PR_Show_Equip("armor_and_else")
        end
    end
    
    function PR_Save_Equip()
        net.Start("SaveEquipData")
        net.WriteTable(PR_Equip_List)
        net.SendToServer()
    end

    net.Receive("EquipTable", function()
        PR_Equip_List = net.ReadTable()
    end)
end