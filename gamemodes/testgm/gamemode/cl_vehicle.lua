if CLIENT then

    function PR_Vehicle_Create()
        local BackGround = vgui.Create ("DFrame")
		BackGround:SetSize(300,380)
		BackGround:SetPos((ScrW()/2)-BackGround:GetWide(),(ScrH()/2)-BackGround:GetTall())
		BackGround:SetTitle("")
		BackGround:SetVisible(true)
		BackGround:SetDraggable(true)
		BackGround:ShowCloseButton(true)
		BackGround:MakePopup()
		BackGround.Paint = function ()
		    draw.RoundedBox(4,0,0,BackGround:GetWide(), BackGround:GetTall(), Color(100,100,100,200))
			draw.RoundedBox(4,0,0,BackGround:GetWide()-4, 21, Color(50,50,50,200))
            draw.DrawText("Название","DermaDefaultBold", BackGround:GetWide() / 2, 90, Color(255,255,255,255),1)
            draw.DrawText("Цена","DermaDefaultBold", BackGround:GetWide() / 2, 140, Color(255,255,255,255),1)
            draw.DrawText("Введи её здесь","DermaDefaultBold", BackGround:GetWide() / 2, 280, Color(255,255,255,255),1)
		end

        -------------------------------------------------------------------

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

        -------------------------------------------------------------------

		local PR_Name = vgui.Create ("DTextEntry", BackGround)
		PR_Name:SetPos(20,110)
		PR_Name:SetTall(20)
		PR_Name:SetWide(260)
		PR_Name:SetEnterAllowed(true)

        -------------------------------------------------------------------
		
		local PR_Price = vgui.Create ("DTextEntry", BackGround)
		PR_Price:SetPos(20,160)
		PR_Price:SetTall(20)
		PR_Price:SetWide(260)
		PR_Price:SetEnterAllowed(true)

        -------------------------------------------------------------------

        local PR_Type = "К какому типу относится техника"

        local TypeScrollButton = vgui.Create("DButton", BackGround)
        TypeScrollButton:SetPos(20,200)
        TypeScrollButton:SetSize(260,20)
        TypeScrollButton:SetText("")

        TypeScrollButton.Paint = function()
            surface.SetDrawColor(50,50,50,255)
            surface.DrawRect(0,0, TypeScrollButton:GetWide(), TypeScrollButton:GetTall())
                    
            draw.DrawText(PR_Type,"DermaDefaultBold", TypeScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
        end

        TypeScrollButton.DoClick = function()
            local TypecrollPanel = vgui.Create( "DScrollPanel", BackGround )
            TypecrollPanel:SetPos(20,20)
            TypecrollPanel:SetSize(260,350)
            
            local CloseButton = TypecrollPanel:Add( "DButton" )
            CloseButton:SetText("")
            CloseButton:Dock(TOP)
            CloseButton:DockMargin( 0, 0, 0, -2 )

            CloseButton.Paint = function()
                surface.SetDrawColor(30,30,30,255)
                surface.DrawRect(0,0, TypeScrollButton:GetWide(), TypeScrollButton:GetTall())

                draw.DrawText("Закрыть","DermaDefaultBold", TypeScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            CloseButton.DoClick = function()
                TypecrollPanel:Remove()
            end

            local types = {"light_armor", "support_vehicle", "bmp_and_btr", "tanks", "jets", "helicopters"}

            for k,v in pairs (types) do
                local Button = TypecrollPanel:Add( "DButton" )
                Button:SetText("")
                Button:Dock(TOP)
                Button:DockMargin( 0, 0, 0, -2 )

                Button.Paint = function()
                    surface.SetDrawColor(30,30,30,255)
                    surface.DrawRect(0,0, TypeScrollButton:GetWide(), TypeScrollButton:GetTall())

                    draw.DrawText(v,"DermaDefaultBold", TypeScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                end

                Button.DoClick = function()
                    PR_Type = v
                    TypecrollPanel:Remove()
                end
            end
        end
        -------------------------------------------------------------------

        local PR_Mod = "В каком моде техника"

        local ModScrollButton = vgui.Create("DButton", BackGround)
        ModScrollButton:SetPos(20,240)
        ModScrollButton:SetSize(260,20)
        ModScrollButton:SetText("")

        ModScrollButton.Paint = function()
            surface.SetDrawColor(50,50,50,255)
            surface.DrawRect(0,0, ModScrollButton:GetWide(), ModScrollButton:GetTall())
                    
            draw.DrawText(PR_Mod,"DermaDefaultBold", ModScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
        end

        ModScrollButton.DoClick = function()
            local ModScrollPanel = vgui.Create( "DScrollPanel", BackGround )
            ModScrollPanel:SetPos(20,20)
            ModScrollPanel:SetSize(260,350)
            
            local CloseButton = ModScrollPanel:Add( "DButton" )
            CloseButton:SetText("")
            CloseButton:Dock(TOP)
            CloseButton:DockMargin( 0, 0, 0, -2 )

            CloseButton.Paint = function()
                surface.SetDrawColor(30,30,30,255)
                surface.DrawRect(0,0, ModScrollButton:GetWide(), ModScrollButton:GetTall())

                draw.DrawText("Закрыть","DermaDefaultBold", ModScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
            end

            CloseButton.DoClick = function()
                ModScrollPanel:Remove()
            end

            local mods = {"simfphys", "no_simfphys"}

            for k,v in pairs(mods) do
                local Button = ModScrollPanel:Add( "DButton" )
                Button:SetText("")
                Button:Dock(TOP)
                Button:DockMargin( 0, 0, 0, -2 )

                Button.Paint = function()
                    surface.SetDrawColor(30,30,30,255)
                    surface.DrawRect(0,0, ModScrollButton:GetWide(), ModScrollButton:GetTall())

                    draw.DrawText(v,"DermaDefaultBold", ModScrollButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                end

                Button.DoClick = function()
                    PR_Mod = v
                    ModScrollPanel:Remove()
                end
            end
        end

        -------------------------------------------------------------------

		local PR_Entity = vgui.Create ("DTextEntry", BackGround)
		PR_Entity:SetPos(20,300)
		PR_Entity:SetTall(20)
		PR_Entity:SetWide(260)
		PR_Entity:SetEnterAllowed(true)

        -------------------------------------------------------------------

        local SaveButton = vgui.Create("DButton", BackGround)
        SaveButton:SetPos(20,340)
        SaveButton:SetSize(260,20)
        SaveButton:SetText("")

        SaveButton.Paint = function()
            surface.SetDrawColor(50,50,50,255)
            surface.DrawRect(0,0, SaveButton:GetWide(), SaveButton:GetTall())
                    
            draw.DrawText("Сохранить","DermaDefaultBold", SaveButton:GetWide() / 2, 2, Color(255,255,255,255),1)
        end

        SaveButton.DoClick = function()
            if PR_Fraction == nil or PR_Fraction == "" or PR_Fraction == "Фракция" then
                PR_CreateErrorNotice("Ты не ввёл фракцию")
                return false
            end

            if PR_Name:GetValue() == nil or PR_Name:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл название")
                return false
            end

            if PR_Price:GetValue() == nil or PR_Price:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл цену")
                return false
            end

            if PR_Type == nil or PR_Type == "" or PR_Type == "К какому типу относится техника" then
                PR_CreateErrorNotice("Ты не выбрал к какому типу техника относится")
                return false
            end

            if PR_Mod == nil or PR_Mod == "" or PR_Mod == "В каком моде техника" then
                PR_CreateErrorNotice("Ты не выбрал в каком моде находится техника")
                return false
            end

            if PR_Entity:GetValue() == nil or PR_Entity:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл её хуйню короче последнюю")
                return false
            end

            if PR_Vehicle_List != nil then
                PR_Vehicle_List[PR_Fraction] = PR_Vehicle_List[PR_Fraction] or {}
                
                for k,v in pairs(PR_Vehicle_List[PR_Fraction]) do
                    if v["ClassName"] == PR_Weapon then
                        PR_CreateErrorNotice("Такая техника уже есть во фракции " .. PR_Fraction .. "\nПроверка идёт по её Class Name (самое последнее выбранное)")
                        return false
                    end
                end

                table.insert(
                    PR_Vehicle_List[PR_Fraction],
                    {
                    ["Name"]=PR_Name:GetValue(),
                    ["ClassName"]=PR_Entity:GetValue(),
                    ["Price"]=tonumber(PR_Price:GetValue()),
                    ["Type"]=PR_Type,
                    ["Mod"]=PR_Mod
                    }
                )
            end

            PR_Save_Vehicle()

            --else
                --return false
            --end
        end

    end

    function PR_Show_Veh(veh_type)
        PR_Clear_All_Parasha()
        
        PR_Panels.Veh_ScrollPanel = vgui.Create("DScrollPanel", MainMenu)
        PR_Panels.Veh_ScrollPanel:SetPos(100,25)
        PR_Panels.Veh_ScrollPanel:SetSize(1100,775)

        local ply = LocalPlayer()

        if PR_Vehicle_List != nil then
            if PR_Vehicle_List[ply:GetNWString("PR_Fraction")] != nil then
                for k,v in pairs(PR_Vehicle_List[ply:GetNWString("PR_Fraction")]) do
                    if v["Type"] == veh_type then
                        local PR_Vehicle = PR_Panels.Veh_ScrollPanel:Add("DButton")
                        PR_Vehicle:SetText("")
                        PR_Vehicle:SetSize(PR_Panels.Veh_ScrollPanel:GetWide(),500)
                        PR_Vehicle:Dock( TOP )
                        PR_Vehicle:DockMargin( 0, 0, 0, 0 )

                        PR_Vehicle.Paint = function()
                            surface.SetDrawColor(255, 255, 255, 240)
                            surface.SetMaterial(Material("test_gm_mat/buttons/".. string.lower(ply:GetNWString("PR_Fraction")) .."_button.png"))

                            surface.DrawTexturedRect(0, 0, PR_Vehicle:GetWide(), PR_Vehicle:GetTall())

                            draw.DrawText(v["Name"], "DermaLarge", PR_Vehicle:GetWide()/2, PR_Vehicle:GetTall()-PR_Vehicle:GetTall() + 20, Color(255,255,255,255), 1)
                            draw.DrawText("Цена: " .. v["Price"], "DermaLarge", PR_Vehicle:GetWide() - PR_Vehicle:GetWide() + 20, PR_Vehicle:GetTall()-PR_Vehicle:GetTall() + 70, Color(255,255,255,255), 0)
                
                            surface.SetDrawColor(200,220,220,255)
                            surface.DrawRect(0,499,PR_Vehicle:GetWide(),1)
                            surface.DrawRect(0,0,1,PR_Vehicle:GetTall())
                            surface.DrawRect(PR_Vehicle:GetWide()-1,0,1,PR_Vehicle:GetTall())
                        end

                        local Model = vgui.Create("DModelPanel", PR_Vehicle)
                        Model:SetPos(0, 150)
                        Model:SetSize(PR_Vehicle:GetWide(), PR_Vehicle:GetTall())
                        Model:SetText("")
                        Model:SetCamPos(Vector(-500, 0, 20))
                        Model:SetLookAng(Angle(0,0,0))
                        local mdl = v["ClassName"]

                        for k,v in pairs(list.Get("simfphys_vehicles")) do
                            -- k - это classname (ахуевали всем селом)
                            if k == mdl then
                                Model:SetModel(v["Model"])
                                --print(v["Model"])
                                --PrintTable(v)
                            end
                        end

                        if not Model:GetModel() then
                            for k,v in pairs(scripted_ents.GetList()) do
                                -- k - это classname (ахуевали всем селом)
                                --print(k)
                                if k == mdl then
                                    Model:SetModel(v["t"]["MDL"])
                                    Model:SetCamPos(Vector(-1000, 0, 20))
                                    --PrintTable(v["t"])
                                end
                            end
                        end

                        Model.DoClick = function()
                            PR_Vehicle.DoClick()
                        end

                        if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
                            local DeleteButton = vgui.Create("DButton", PR_Vehicle)
                            DeleteButton:SetText("")
                            DeleteButton:SetPos(PR_Vehicle:GetWide() - 170, PR_Vehicle:GetTall() - 35)
                            DeleteButton:SetSize(150,30)

                            DeleteButton.Paint = function()
                                surface.SetDrawColor(255,255,255,200)
                                surface.DrawRect(0,0, DeleteButton:GetWide(), DeleteButton:GetTall())

                                draw.DrawText("Удолить", "panel_INFO_font", DeleteButton:GetWide()/2, 1, Color(10,10,10,255), 1)
                            end

                            DeleteButton.DoClick = function()
                                table.RemoveByValue(PR_Vehicle_List[ply:GetNWString("PR_fraction")], v)
                                PR_Save_Vehicle()
                            end
                        end
                        
                        PR_Vehicle.DoClick = function()
                            if PR_Panels.BuyWindow != nil then
                                PR_Panels.BuyWindow:Remove()
                            end
                            PR_Panels.BuyWindow = vgui.Create("DPanel", PR_Vehicle)
                            PR_Panels.BuyWindow:SetSize(400, 200)
                            PR_Panels.BuyWindow:SetPos(PR_Vehicle:GetWide() / 2 - PR_Panels.BuyWindow:GetWide() / 2, PR_Vehicle:GetTall() / 2 - PR_Panels.BuyWindow:GetTall() / 2 + 100)

                            PR_Panels.BuyWindow.Paint = function ()
                                draw.RoundedBox(4,0,0,PR_Panels.BuyWindow:GetWide(), PR_Panels.BuyWindow:GetTall(), Color(80,80,80,200))
                                draw.RoundedBox(4,0,0,PR_Panels.BuyWindow:GetWide(), 21, Color(50,50,50,100))

                                draw.DrawText("Вы уверены, что хотите купить " .. v["Name"] .. "?", "DermaDefaultBold", PR_Panels.BuyWindow:GetWide() / 2, PR_Panels.BuyWindow:GetTall() - PR_Panels.BuyWindow:GetTall() + 30, Color(255,255,255,255), 1)
                                draw.DrawText("Цена: ".. v["Price"], "DermaDefaultBold", PR_Panels.BuyWindow:GetWide() / 2, PR_Panels.BuyWindow:GetTall() - PR_Panels.BuyWindow:GetTall() + 60, Color(255,255,255,255), 1)

                                surface.SetDrawColor(255,255,255,255)
                                surface.DrawRect(0,580,PR_Panels.BuyWindow:GetWide(),5)
                            end

                            local BuyButton = vgui.Create("DButton", PR_Panels.BuyWindow)
                            BuyButton:SetText("")
                            BuyButton:SetSize(160,60)
                            BuyButton:SetPos(PR_Panels.BuyWindow:GetWide() / 2 - BuyButton:GetWide() / 2, PR_Panels.BuyWindow:GetTall() / 2)

                            
                            BuyButton.Paint = function()
                                surface.SetDrawColor(10,10,10,255)
                                surface.DrawRect(0,0, BuyButton:GetWide(), BuyButton:GetTall())
                    
                                --draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
                                draw.RoundedBox(0, 0, 0, BuyButton:GetWide(), 1, Color(255,255,255,255)) -- верхушка
                    
                                draw.RoundedBox(0, 0, 0, 1, BuyButton:GetTall(), Color(255,255,255,255)) -- левушка
                    
                                draw.RoundedBox(0, BuyButton:GetWide() - 1, 0, 1, BuyButton:GetTall(), Color(255,255,255,255)) -- правушка
                    
                                draw.RoundedBox(0, 0, BuyButton:GetTall() - 1, BuyButton:GetWide(), 1, Color(255,255,255,255)) -- низушка

                                draw.DrawText("Купить", "panel_INFO_font", BuyButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                            end

                            BuyButton.DoClick = function()
                                local DeploySpots

                                if veh_type == "jets" or veh_type == "helicopters" then
                                    DeploySpots = {
                                        ["Город"] = Vector(-12486, -2897, -350)
                                    }
                                else
                                    DeploySpots = {
                                        ["Южная военка"] = Vector(-11599, -6272, -353),
                                        ["Северная военка"] = Vector(12800, -4566, -353)
                                    }
                                end

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

                                local PR_DeployVector

                                local PR_Deploy = "Куда вызвать?"
                                
                                local ScrollUnlockButton = vgui.Create("DButton", BackGround)
                                ScrollUnlockButton:SetPos(20,50)
                                ScrollUnlockButton:SetSize(260,20)
                                ScrollUnlockButton:SetText("")
                    
                                ScrollUnlockButton.Paint = function()
                                    surface.SetDrawColor(50,50,50,255)
                                    surface.DrawRect(0,0, ScrollUnlockButton:GetWide(), ScrollUnlockButton:GetTall())
                                            
                                    draw.DrawText(PR_Deploy,"DermaDefaultBold", ScrollUnlockButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                                end
                    
                                ScrollUnlockButton.DoClick = function()
                                    local ScrollUnlock = vgui.Create( "DScrollPanel", BackGround )
                                    ScrollUnlock:SetPos(20,50)
                                    ScrollUnlock:SetSize(260,350)
                    
                                    for k,v in pairs(DeploySpots) do
                                        local DButton = ScrollUnlock:Add( "DButton" )
                                        DButton:SetText("")
                                        DButton:Dock(TOP)
                                        DButton:DockMargin( 0, 0, 0, 0 )
                    
                                        DButton.Paint = function()
                                            surface.SetDrawColor(30,30,30,255)
                                            surface.DrawRect(0,0, ScrollUnlock:GetWide(), ScrollUnlock:GetTall())
                    
                                            draw.DrawText(k,"DermaDefaultBold", ScrollUnlock:GetWide() / 2, 2, Color(255,255,255,255),1)
                                        end
                    
                                        DButton.DoClick = function()
                                            PR_Deploy = k
                                            PR_DeployVector = v
                                            ScrollUnlock:Remove()
                                        end
                                    end
                                end
                                
                                local SpawnButton = vgui.Create("DButton", BackGround)
                                SpawnButton:SetPos(20,140)
                                SpawnButton:SetSize(260,20)
                                SpawnButton:SetText("")
                    
                                SpawnButton.Paint = function()
                                    surface.SetDrawColor(50,50,50,255)
                                    surface.DrawRect(0,0, SpawnButton:GetWide(), SpawnButton:GetTall())
                                            
                                    draw.DrawText("Вызвать","DermaDefaultBold", SpawnButton:GetWide() / 2, 2, Color(255,255,255,255),1)
                                end
                    
                                SpawnButton.DoClick = function()
                                    net.Start("GiveVehicle")
                                    net.WriteInt(v["Price"], 32)
                                    net.WriteString(v["ClassName"])
                                    net.WriteString(v["Mod"])
                                    net.WriteVector(PR_DeployVector)
                                    net.SendToServer()
                                    BackGround:Remove()
                                end
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
                                    table.RemoveByValue(PR_Vehicle_List[ply:GetNWString("PR_fraction")], v)
                                    PR_Save_Vehicle()
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    function PR_Create_Veh_Labels()
        ply = LocalPlayer()

        if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
            PR_Panels.CreateNewVehicle = vgui.Create("DButton", MainMenu)
            PR_Panels.CreateNewVehicle:SetPos(1000, 0)
            PR_Panels.CreateNewVehicle:SetSize(200, 25)
            PR_Panels.CreateNewVehicle:SetText("")

            PR_Panels.CreateNewVehicle.Paint = function()
                surface.SetDrawColor(10,10,10,255)
                surface.DrawRect(0,0, PR_Panels.CreateNewVehicle:GetWide(), PR_Panels.CreateNewVehicle:GetTall())
                
                draw.DrawText("Добавить новую технику","DermaDefaultBold", PR_Panels.CreateNewVehicle:GetWide() / 2, 5, Color(255,255,255,255),1)
            end

            PR_Panels.CreateNewVehicle.DoClick = function()
                PR_Vehicle_Create()
            end
        end

        PR_Panels.VehBackGround = vgui.Create("DPanel", MainMenu)
        PR_Panels.VehBackGround:SetPos(100, 26)
        PR_Panels.VehBackGround:SetSize(1100, 775)
        PR_Panels.VehBackGround:SetText("")
        PR_Panels.VehBackGround.Paint = function()
            surface.SetDrawColor(0,0,0,0)
            surface.DrawRect(0,0, PR_Panels.VehBackGround:GetWide(), PR_Panels.VehBackGround:GetTall())
        end

        local function PR_Create_Veh_Button(x, y, img, veh_type)
            PR_Panels.LightVeh = vgui.Create("DButton", PR_Panels.VehBackGround)
            PR_Panels.LightVeh:SetPos(x, y)
            PR_Panels.LightVeh:SetSize(421, 200)
            PR_Panels.LightVeh:SetText("")
            PR_Panels.LightVeh.Paint = function()
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material(img))
                surface.DrawTexturedRect(0, 0, PR_Panels.LightVeh:GetWide(), PR_Panels.LightVeh:GetTall())
            end
            PR_Panels.LightVeh.DoClick = function()
                if PR_Panels.Veh_ScrollPanel != nil then
                    PR_Panels.Veh_ScrollPanel:Remove()
                end

                PR_Show_Veh(veh_type)
            end
        end

        PR_Create_Veh_Button(50, 25, "test_gm_mat/vehicles/light_veh.png", "light_armor")
        PR_Create_Veh_Button(620, 25, "test_gm_mat/vehicles/sup_veh.png", "support_vehicle")
        PR_Create_Veh_Button(50, 255, "test_gm_mat/vehicles/bmp_veh.png", "bmp_and_btr")
        PR_Create_Veh_Button(620, 255, "test_gm_mat/vehicles/tanks_veh.png", "tanks")
        PR_Create_Veh_Button(50, 485, "test_gm_mat/vehicles/jets_veh.png", "jets")
        PR_Create_Veh_Button(620, 485, "test_gm_mat/vehicles/hel_veh.png", "helicopters")
    end

    function PR_Save_Vehicle()
        net.Start("SaveVehicleData")
        net.WriteTable(PR_Vehicle_List)
        net.SendToServer()
    end

    net.Receive("VehicleTable", function()
        PR_Vehicle_List = net.ReadTable()
    end)
end