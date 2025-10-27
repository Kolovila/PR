if CLIENT then
    local ply

    function PR_Cloth_Create()
        local BackGround = vgui.Create ("DFrame")
		BackGround:SetSize(300,290)
		BackGround:SetPos((ScrW()/2)-BackGround:GetWide(),(ScrH()/2)-BackGround:GetTall())
		BackGround:SetTitle("")
		BackGround:SetVisible(true)
		BackGround:SetDraggable(true)
		BackGround:ShowCloseButton(true)
		BackGround:MakePopup()
		BackGround.Paint = function ()
		    draw.RoundedBox(4,0,0,BackGround:GetWide(), BackGround:GetTall(), Color(100,100,100,200))
			draw.RoundedBox(4,0,0,BackGround:GetWide()-4, 21, Color(50,50,50,200))
            draw.DrawText("Цена","DermaDefaultBold", BackGround:GetWide() / 2, 90, Color(255,255,255,255),1)
            draw.DrawText("Уровень","DermaDefaultBold", BackGround:GetWide() / 2, 140, Color(255,255,255,255),1)
            draw.DrawText("Моделька","DermaDefaultBold", BackGround:GetWide() / 2, 190, Color(255,255,255,255),1)
		end

        -------------------------------------------------------------------

        local PR_Fraction = "Фракция"
        
        local ScrollButton = vgui.Create("DButton", BackGround)
        ScrollButton:SetPos(20,60)
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
                DButton:SetText("")
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
		
		local PR_Price = vgui.Create ("DTextEntry", BackGround)
		PR_Price:SetPos(20,110)
		PR_Price:SetTall(20)
		PR_Price:SetWide(260)
		PR_Price:SetEnterAllowed(true)

        -------------------------------------------------------------------

		local PR_Level = vgui.Create ("DTextEntry", BackGround)
		PR_Level:SetPos(20,160)
		PR_Level:SetTall(20)
		PR_Level:SetWide(260)
		PR_Level:SetEnterAllowed(true)

        -------------------------------------------------------------------

		local PR_Cloth = vgui.Create ("DTextEntry", BackGround)
		PR_Cloth:SetPos(20,210)
		PR_Cloth:SetTall(20)
		PR_Cloth:SetWide(260)
		PR_Cloth:SetEnterAllowed(true)

        -------------------------------------------------------------------

        local SaveButton = vgui.Create("DButton", BackGround)
        SaveButton:SetPos(20,260)
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

            if PR_Price:GetValue() == nil or PR_Price:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл цену")
                return false
            end

            if PR_Level:GetValue() == nil or PR_Level:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл уровень")
                return false
            end

            if PR_Cloth:GetValue() == nil or PR_Cloth:GetValue() == "" then
                PR_CreateErrorNotice("Ты не ввёл одежду")
                return false
            end

            PR_Cloth_List[PR_Fraction] = PR_Cloth_List[PR_Fraction] or {}

            if PR_Cloth_List[PR_Fraction] != nil then
                PR_Cloth_List[PR_Fraction] = PR_Cloth_List[PR_Fraction] or {}
                table.insert( PR_Cloth_List[PR_Fraction], {
                    ["Price"]=tonumber(PR_Price:GetValue()),
                    ["Level"]=tonumber(PR_Level:GetValue()),
                    ["Model"]=PR_Cloth:GetValue()
                })
            end

            PR_Save_Cloth()
        end

    end

    function PR_Show_Cloth()
        PR_Clear_All_Parasha()

        ply = LocalPlayer()

        if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
            PR_Panels.CreateNewCloth = vgui.Create("DButton", MainMenu)
            PR_Panels.CreateNewCloth:SetPos(1000, 0)
            PR_Panels.CreateNewCloth:SetSize(200, 25)
            PR_Panels.CreateNewCloth:SetText("")

            PR_Panels.CreateNewCloth.Paint = function()
                surface.SetDrawColor(10,10,10,255)
                surface.DrawRect(0,0, PR_Panels.CreateNewCloth:GetWide(), PR_Panels.CreateNewCloth:GetTall())
                
                draw.DrawText("Добавить новую одежду","DermaDefaultBold", PR_Panels.CreateNewCloth:GetWide() / 2, 5, Color(255,255,255,255),1)
            end

            PR_Panels.CreateNewCloth.DoClick = function()
                PR_Cloth_Create()
            end
        end

        PR_Panels.ClothBackGround = vgui.Create("DPanel", MainMenu)
        PR_Panels.ClothBackGround:SetPos(100, 26)
        PR_Panels.ClothBackGround:SetSize(1100, 775)
        PR_Panels.ClothBackGround:SetText("")
        PR_Panels.ClothBackGround.Paint = function()
            surface.SetDrawColor(0,0,0,0)
            surface.DrawRect(0,0, PR_Panels.ClothBackGround:GetWide(), PR_Panels.ClothBackGround:GetTall())
        end

        local i = 11
        local h = 5
        if PR_Cloth_List != nil then
            if PR_Cloth_List[ply:GetNWString("PR_fraction")] != nil then
                for k,v in pairs (PR_Cloth_List[ply:GetNWString("PR_fraction")]) do
                    if (ply:GetNWInt("PR_level") >= v["Level"]) then
                        PR_CS_Cloth_BackGround = vgui.Create("DPanel", PR_Panels.ClothBackGround)
                        PR_CS_Cloth_BackGround:SetPos(i, h)
                        PR_CS_Cloth_BackGround:SetSize(140, 140)
                        PR_CS_Cloth_BackGround:SetText("")
                        PR_CS_Cloth_BackGround.Paint = function()
                            surface.SetDrawColor(80,80,80,255)
                            surface.DrawRect(0,0, PR_CS_Cloth_BackGround:GetWide(), PR_CS_Cloth_BackGround:GetTall())

                            surface.SetDrawColor(200,220,220,255)

                            surface.DrawRect(0,139,PR_CS_Cloth_BackGround:GetWide(),1)
                            surface.DrawRect(139,0,1,PR_CS_Cloth_BackGround:GetTall())

                            surface.DrawRect(0,0,PR_CS_Cloth_BackGround:GetWide(),1)
                            surface.DrawRect(0,0,1,PR_CS_Cloth_BackGround:GetTall())
                        end

                        local PR_CS_Cloth = vgui.Create( "DModelPanel", PR_Panels.ClothBackGround)
                        PR_CS_Cloth:SetPos(i,h)
                        PR_CS_Cloth:SetSize(150,139)
                        PR_CS_Cloth:SetModel(v["Model"])
                        
                        function PR_CS_Cloth:LayoutEntity(ent) return end

                        if PR_CS_Cloth.Entity != nil then
                            local eyepos = PR_CS_Cloth.Entity:GetBonePosition(PR_CS_Cloth.Entity:LookupBone("ValveBiped.Bip01_Head1"))
                            eyepos:Add(Vector(0, 1, -2))
                            PR_CS_Cloth:SetLookAt(eyepos)
                            PR_CS_Cloth:SetCamPos(eyepos-Vector(-20, 0, 0))
                            PR_CS_Cloth.Entity:SetEyeTarget(eyepos-Vector(-12, 0, 0))
                        end
                        

                        PR_CS_Cloth.DoClick = function()
                            PR_Panels.ClothBackGround:Remove()

                            local BuyWindow = vgui.Create ("DFrame")
                            BuyWindow:SetSize(800,700)
                            BuyWindow:SetPos((ScrW()/2)-BuyWindow:GetWide()/2,(ScrH()/2)-BuyWindow:GetTall()/2)
                            BuyWindow:SetTitle("")
                            BuyWindow:SetVisible(true)
                            BuyWindow:SetDraggable(true)
                            BuyWindow:ShowCloseButton(true)
                            BuyWindow:MakePopup()
                            BuyWindow.Paint = function ()
                                draw.RoundedBox(4,0,0,BuyWindow:GetWide(), BuyWindow:GetTall(), Color(80,80,80,255))
                                draw.RoundedBox(4,0,0,BuyWindow:GetWide(), 21, Color(50,50,50,255))

                                draw.DrawText("Цена: ".. v["Price"], "panel_INFO_font", 25, 60, Color(255,255,255,255), 0)
                            end

                            local Model = vgui.Create("DModelPanel", BuyWindow)
                            Model:SetPos(100, 150)
                            Model:SetSize(500, 430)
                            Model:SetText("")
                            Model:SetCamPos(Vector(-75, 0, 35))
                            Model:SetLookAng(Angle(0,0,0))
                            Model:SetModel(v["Model"])

                            local bodygroups = {}
                            local dh = 50
                            for k,v in pairs(Model.Entity:GetBodyGroups()) do
                                if #v["submodels"] != 0 then
                                    local DermaNumSlider = vgui.Create("DNumSlider", BuyWindow)
                                    DermaNumSlider:SetPos(500, dh)
                                    DermaNumSlider:SetSize(300, 20)
                                    DermaNumSlider:SetText(v["name"])
                                    DermaNumSlider:SetMin(0)
                                    DermaNumSlider:SetMax(Model.Entity:GetBodygroupCount(v["id"]) - 1)
                                    DermaNumSlider:SetDecimals(0)

                                    DermaNumSlider.OnValueChanged = function(self, value)
                                        Model.Entity:SetBodygroup(v["id"],math.Round(value))
                                        bodygroups[v["id"]] = math.Round(value)
                                        --print(v["id"])
                                        --print(math.Round(value)
                                    end
                                    dh = dh + 50
                                end
                            end

                            if ply:GetNWInt("PR_money") >= v["Price"] then
                                local BuyButton = vgui.Create("DButton", BuyWindow)
                                BuyButton:SetText("")
                                BuyButton:SetPos(275,600)
                                BuyButton:SetSize(150,60)

                                PR_PurchasedModels = PR_PurchasedModels or {}

                                if not table.HasValue(PR_PurchasedModels, v["Model"]) then
                                    BuyButton.Paint = function()
                                        surface.SetDrawColor(10,10,10,255)
                                        surface.DrawRect(0,0, BuyButton:GetWide(), BuyButton:GetTall())

                                        draw.DrawText("Купить", "panel_INFO_font", BuyButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                                    end

                                    BuyButton.DoClick = function()
                                        if ply:GetNWInt("PR_money") >= v["Price"] then
                                            net.Start("BuyPlayerModel")
                                            net.WriteString(v["Model"])
                                            net.WriteTable(bodygroups)
                                            net.WriteInt(v["Price"], 32)
                                            net.SendToServer()

                                            if not table.HasValue(PR_PurchasedModels, v["Model"]) then
                                                table.insert(PR_PurchasedModels, v["Model"])
                                            end
                                            
                                            BuyButton.Paint = function()
                                                surface.SetDrawColor(10,10,10,255)
                                                surface.DrawRect(0,0, BuyButton:GetWide(), BuyButton:GetTall())
        
                                                draw.DrawText("Надеть", "panel_INFO_font", BuyButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                                            end
        
                                            BuyButton.DoClick = function()
                                                net.Start("BuyPlayerModel")
                                                net.WriteString(v["Model"])
                                                net.WriteTable(bodygroups)
                                                net.WriteInt(0, 32)
                                                net.SendToServer()
                                            end
                                        else
                                            if not timer.Exists("NoMoney") then
                                                local NoMoneyLabel = vgui.Create("DLabel", BuyWindow)
                                                NoMoneyLabel:SetSize(250,50)
                                                NoMoneyLabel:SetPos(250,21)
                                                NoMoneyLabel:SetText("")

                                                NoMoneyLabel.Paint = function()
                                                    draw.DrawText("Не хватает денег!", "panel_INFO_font", NoMoneyLabel:GetWide()/2, 10, Color(255,255,255,255), 1)
                                                end

                                                timer.Create("NoMoney", 2, 1, function() NoMoneyLabel:Remove() end)
                                            end
                                        end
                                    end
                                else
                                    BuyButton.Paint = function()
                                        surface.SetDrawColor(10,10,10,255)
                                        surface.DrawRect(0,0, BuyButton:GetWide(), BuyButton:GetTall())

                                        draw.DrawText("Надеть", "panel_INFO_font", BuyButton:GetWide()/2, 13, Color(255,255,255,255), 1)
                                    end

                                    BuyButton.DoClick = function()
                                        net.Start("BuyPlayerModel")
                                        net.WriteString(v["Model"])
                                        net.WriteTable(bodygroups)
                                        net.WriteInt(0, 32)
                                        net.SendToServer()
                                    end
                                end
                            end

                            BuyWindow.Close = function()
                                PR_Show_Cloth()
                                BuyWindow:Remove()
                            end
                        end

                        
                        i = i + 156
                        if i >= 1050 then
                            i = 11
                            h = h + 156
                        end
                    end
                end
            end
        end
    end
    
    function PR_Save_Cloth()
        net.Start("SaveClothData")
        net.WriteTable(PR_Cloth_List)
        net.SendToServer()
    end

    net.Receive("ClothTable", function()
        PR_Cloth_List = net.ReadTable()
    end)
end