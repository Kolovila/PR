include("shared.lua")

function ENT:Draw()
  	self:DrawModel()
end

function idkMenuOpen()
	local ply = LocalPlayer()

	local ent = net.ReadEntity()

	net.Start("GetPointsCfgs")
	net.WriteTable(PR_Capture_Points_List)
	net.SendToServer()

	local W, H 	= ScrW(), ScrH()
	local idkMenu = vgui.Create( "DFrame" )
	idkMenu:SetPos( 0, 0 )
	idkMenu:SetSize( W, H )
	idkMenu:SetTitle("")
	idkMenu:SetDraggable( true )
	idkMenu:ShowCloseButton( true )
	idkMenu:MakePopup()
	idkMenu.Paint = function()
		surface.SetDrawColor( 100, 100, 100, 150 )
		surface.DrawTexturedRect( 0, 0, W, H )
	end
	
	local takeMoney = vgui.Create( "DButton", idkMenu)
	takeMoney:SetPos( W*0.45, H*0.9 )
	takeMoney:SetText( "" )
	takeMoney:SetSize( 215, 70 )
	takeMoney.Paint = function()
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, takeMoney:GetWide(),takeMoney:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText( "забрать деньги", "DermaLarge", 9, 15, Color(255,255,255) )
	end
	takeMoney.DoClick = function()
		net.Start("SkamKazino")
		net.WriteInt(ent.Money, 32)
		net.SendToServer()
		ent.Money = 0
	end
	
	local upgradeMonik = vgui.Create( "DButton", idkMenu)
	upgradeMonik:SetPos( W*0.2, H*0.3 )
	upgradeMonik:SetText( "" )
	upgradeMonik:SetSize( 265, 70 )
	print(ent.UpgradeMonitor)
	upgradeMonik.Paint = function()
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, upgradeMonik:GetWide(),upgradeMonik:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText( "улучшить монитор", "DermaLarge", 14, 5, Color(255,255,255) )
		if ent.UpgradeMonitor == 0 then NforPriceMonitor = "30000" 
		elseif ent.UpgradeMonitor == 1 then NforPriceMonitor = "80000" 
		elseif ent.UpgradeMonitor == 2 then NforPriceMonitor = "180000" 
		elseif ent.UpgradeMonitor == 3 then NforPriceMonitor = "480000" 
		elseif ent.UpgradeMonitor >= 4 then NforPriceMonitor = "MAX" 
		end
		draw.SimpleText( "цена:".. NforPriceMonitor .."$", "DermaLarge", 50, 35, Color(255,255,255) )
	end
	upgradeMonik.DoClick = function()
		if ply:GetNWBool("PR_leader_" .. ply:GetNWString("PR_fraction")) != true then PR_CreateErrorNotice("Ты не лидер фракции") return false end
		if ent.UpgradeMonitor < 4 then
			if ply:GetNWInt("PR_money") >= tonumber(NforPriceMonitor) then
				ent.UpgradeMonitor = ent.UpgradeMonitor + 1
				net.Start("UpgradePoint")
				net.WriteEntity(ent)
				if NforPriceMonitor != "MAX" then
					net.WriteInt(NforPriceMonitor, 32)
				else
					net.WriteInt(0, 32)
				end
				net.WriteInt(1, 3)
				net.SendToServer()
				ent.Delay = CurTime() + 500 - ent.UpgradeMonitor * 100
			else
                PR_CreateErrorNotice("У тебя не хватает щекелей")
			end
		end
	end
	
	local upgradeComp = vgui.Create( "DButton", idkMenu)
	upgradeComp:SetPos( W*0.2, H*0.7 )
	upgradeComp:SetText( "" )
	upgradeComp:SetSize( 250, 70 )
	upgradeComp.Paint = function()
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, upgradeComp:GetWide(),upgradeComp:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText( "улучшить комп", "DermaLarge", 30, 5, Color(255,255,255) )
		if ent.UpgradeComputer == 1 then NforPriceComputer = "30000" 
		elseif ent.UpgradeComputer == 2 then NforPriceComputer = "80000" 
		elseif ent.UpgradeComputer == 3 then NforPriceComputer = "180000" 
		elseif ent.UpgradeComputer == 4 then NforPriceComputer = "480000" 
		elseif ent.UpgradeComputer >= 5 then NforPriceComputer = "MAX" 
		end
		draw.SimpleText( "цена:".. NforPriceComputer .."$", "DermaLarge", 50, 35, Color(255,255,255) )
	end
	upgradeComp.DoClick = function()
		if ply:GetNWBool("PR_leader_" .. ply:GetNWString("PR_fraction")) != true then PR_CreateErrorNotice("Ты не лидер фракции") return false end
		if ent.UpgradeComputer < 5 then
			if ply:GetNWInt("PR_money") >= tonumber(NforPriceComputer) then
				ent.UpgradeComputer = ent.UpgradeComputer + 1
				net.Start("UpgradePoint")
				net.WriteEntity(ent)
				if NforPriceComputer != "MAX" then
					net.WriteInt(NforPriceComputer, 32)
				else
					net.WriteInt(0, 32)
				end
				net.WriteInt(2, 3)
				net.SendToServer()
			else
                PR_CreateErrorNotice("У тебя не хватает щекелей")
			end
		end
	end
	
	local guardSpawn = vgui.Create( "DButton", idkMenu)
	guardSpawn:SetPos( W*0.5, H*0.3 )
	guardSpawn:SetText( "" )
	guardSpawn:SetSize( 285, 70 )
	guardSpawn.Paint = function()
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, guardSpawn:GetWide(),guardSpawn:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText( "призвать защитника", "DermaLarge", 10, 5, Color(255,255,255) )
	end
	guardSpawn.DoClick = function()
		local type_guard = ""
		local weap_guard = ""
		local healthy_guard = 1
		local sign_guard = false

		local type_guard_price = 0
		local weap_guard_price = 0
		local sign_guard_price = 0
		local price_guard = 0

		if ent.GuardianCount < ent.MaxGuardianCount then
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
			end

			local PR_GUARD_MENU = {}

			local type_guard_text = "тип челика"
			local weap_guard_text = "оружие челика"
			local healthy_guard_text = "живучесть челика"
			local sign_guard_text = "сигнал челика"

			local type_guard_btn =	vgui.Create("DButton", BuyWindow)
			type_guard_btn:SetText("")
			type_guard_btn:SetSize(285,50)
			type_guard_btn:SetPos(BuyWindow:GetWide()/2 - 285/2, 50)

			type_guard_btn.Paint = function()
				draw.RoundedBox(0, 0, 0, type_guard_btn:GetWide(), type_guard_btn:GetTall(), Color(50,50,50))
	
				--draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
				draw.RoundedBox(0, 0, 0, type_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- верхушка
	
				draw.RoundedBox(0, 0, 0, 1, type_guard_btn:GetTall(), Color(255,255,255,255)) -- левушка
	
				draw.RoundedBox(0, type_guard_btn:GetWide() - 1, 0, 1, type_guard_btn:GetTall(), Color(255,255,255,255)) -- правушка
	
				draw.RoundedBox(0, 0, type_guard_btn:GetTall() - 1, type_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- низушка
	
				draw.SimpleText(type_guard_text, "DermaLarge", 285/2, 5, Color(255,255,255), 1)
			end
			
			type_guard_btn.DoClick = function()
				local types = {
					["дикий"] = {
						["ClassName"] = "npc_vj_mishawild_sniper1",
						["Price"] = 2000
					},
					["ёбнутый"] = {
						["ClassName"] = "npc_vj_mishawild_sanitar_security1",
						["Price"] = 4000
					}
				}

                local DScrollPanel = vgui.Create( "DScrollPanel", BuyWindow )
                DScrollPanel:SetPos(type_guard_btn.x,type_guard_btn.y)
                DScrollPanel:SetSize(type_guard_btn:GetWide(),400)

                for k,v in pairs(types) do
                    local DButton = DScrollPanel:Add( "DButton" )
                    DButton:SetText("")
                    DButton:Dock(TOP)
                    DButton:SetSize(type_guard_btn:GetWide(), type_guard_btn:GetTall())
                    DButton:DockMargin( 0, 0, 0, 0 )

                    DButton.Paint = function()
                        surface.SetDrawColor(30,30,30,255)
                        surface.DrawRect(0,0, DScrollPanel:GetWide(), DScrollPanel:GetTall())

						draw.RoundedBox(0, 0, 0, DButton:GetWide(), 1, Color(255,255,255,255)) -- верхушка
			
						draw.RoundedBox(0, 0, 0, 1, DButton:GetTall(), Color(255,255,255,255)) -- левушка
			
						draw.RoundedBox(0, DButton:GetWide() - 1, 0, 1, DButton:GetTall(), Color(255,255,255,255)) -- правушка
			
						draw.RoundedBox(0, 0, DButton:GetTall() - 1, DButton:GetWide(), 1, Color(255,255,255,255)) -- низушка

                        draw.DrawText(k,"DermaDefaultBold", DScrollPanel:GetWide() / 2, 5, Color(255,255,255,255),1)
                        draw.DrawText("Цена: " .. v["Price"] .. "$","DermaDefaultBold", DScrollPanel:GetWide() / 2, 22, Color(255,255,255),1)
                    end

                    DButton.DoClick = function()
						type_guard = v["ClassName"]
						type_guard_text = k
						type_guard_price = v["Price"]

						weap_guard = ""
						weap_guard_text = "оружие челика"
						weap_guard_price = 0

						if PR_GUARD_MENU.WeaponScrollPanel then PR_GUARD_MENU.WeaponScrollPanel:Remove() end

                        DScrollPanel:Remove()
                    end
                end
			end

			local weap_guard_btn =	vgui.Create("DButton", BuyWindow)
			weap_guard_btn:SetText("")
			weap_guard_btn:SetSize(285,50)
			weap_guard_btn:SetPos(BuyWindow:GetWide()/2 - 285/2, 200)

			weap_guard_btn.Paint = function()
				draw.RoundedBox(0, 0, 0, weap_guard_btn:GetWide(), weap_guard_btn:GetTall(), Color(50,50,50))
	
				--draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
				draw.RoundedBox(0, 0, 0, weap_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- верхушка
	
				draw.RoundedBox(0, 0, 0, 1, weap_guard_btn:GetTall(), Color(255,255,255,255)) -- левушка
	
				draw.RoundedBox(0, weap_guard_btn:GetWide() - 1, 0, 1, weap_guard_btn:GetTall(), Color(255,255,255,255)) -- правушка
	
				draw.RoundedBox(0, 0, weap_guard_btn:GetTall() - 1, weap_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- низушка
	
				draw.SimpleText(weap_guard_text, "DermaLarge", 285/2, 5, Color(255,255,255), 1)
			end
			
			weap_guard_btn.DoClick = function()
				local weapons_get

				local SCAV_Weapons = {
					["Кедр"] = {
						["ClassName"] = "weapon_vj_meft_kedr",
						["Price"] = 1500
					}, 
					["Двухстволка"] = {
						["ClassName"] = "MR43",
						["Price"] = 1000
					}, 
					["МР153"] = {
						["ClassName"] = "weapon_vj_meft_mp153",
						["Price"] = 3000
					}, 
					["ПМ"] = {
						["ClassName"] = "weapon_vj_meft_pm",
						["Price"] = 2500
					},
					["ТОЗ-136"] = {
						["ClassName"] = "weapon_vj_meft_toz",
						["Price"] = 1500
					},
					["АКС-74У"] = {
						["ClassName"] = "weapon_vj_meft_aks74u",
						["Price"] = 1000
					},
					["АК-74М"] = {
						["ClassName"] = "weapon_vj_meft_ak74m",
						["Price"] = 1500
					}, 
					["Говностай"] = {
						["ClassName"] = "weapon_vj_meft_vpo215",
						["Price"] = 1500
					},
					["СКС"] = {
						["ClassName"] = "weapon_vj_meft_sks",
						["Price"] = 1000
					}, 
					["Мосинка"] = {
						["ClassName"] = "weapon_vj_meft_mosin",
						["Price"] = 3000
					}
				}
				local Sanitar_Guard_Weapons = {
					["АК-101"] = {
						["ClassName"] = "weapon_vj_meft_reshala_ak101",
						["Price"] = 3000
					},
					["UMP45"] = {
						["ClassName"] = "weapon_vj_meft_ump45",
						["Price"] = 1500
					},
					["SCAR"] = {
						["ClassName"] = "weapon_vj_meft_scar",
						["Price"] = 1000
					}, 
					["M4A1"] = {
						["ClassName"] = "weapon_vj_meft_m4a1",
						["Price"] = 3000
					},
					["АС ВАЛ"] = {
						["ClassName"] = "weapon_vj_meft_asval",
						["Price"] = 3000
					}
				}


				if type_guard_text == "дикий" then weapons_get = SCAV_Weapons
				elseif type_guard_text == "ёбнутый" then weapons_get = Sanitar_Guard_Weapons
				end

                PR_GUARD_MENU.WeaponScrollPanel = vgui.Create( "DScrollPanel", BuyWindow )
                PR_GUARD_MENU.WeaponScrollPanel:SetPos(weap_guard_btn.x,weap_guard_btn.y)
                PR_GUARD_MENU.WeaponScrollPanel:SetSize(weap_guard_btn:GetWide(),400)

                for k,v in pairs(weapons_get) do
                    local DButton = PR_GUARD_MENU.WeaponScrollPanel:Add( "DButton" )
                    DButton:SetText("")
                    DButton:Dock(TOP)
                    DButton:SetSize(weap_guard_btn:GetWide(), weap_guard_btn:GetTall())
                    DButton:DockMargin( 0, 0, 0, 0 )

                    DButton.Paint = function()
						surface.SetDrawColor(0,0,0)
                        surface.DrawRect(0,0, PR_GUARD_MENU.WeaponScrollPanel:GetWide(), PR_GUARD_MENU.WeaponScrollPanel:GetTall())

						draw.RoundedBox(0, 0, 0, DButton:GetWide(), 1, Color(255,255,255)) -- верхушка
			
						draw.RoundedBox(0, 0, 0, 1, DButton:GetTall(), Color(255,255,255)) -- левушка
			
						draw.RoundedBox(0, DButton:GetWide() - 1, 0, 1, DButton:GetTall(), Color(255,255,255)) -- правушка
			
						draw.RoundedBox(0, 0, DButton:GetTall() - 1, DButton:GetWide(), 1, Color(255,255,255)) -- низушка

                        draw.DrawText(k,"DermaDefaultBold", PR_GUARD_MENU.WeaponScrollPanel:GetWide() / 2, 5, Color(255,255,255),1)
                        draw.DrawText("Цена: " .. v["Price"] .. "$","DermaDefaultBold", PR_GUARD_MENU.WeaponScrollPanel:GetWide() / 2, 22, Color(255,255,255),1)
                    end

                    DButton.DoClick = function()
						weap_guard = v["ClassName"]
						weap_guard_text = k
						weap_guard_price = v["Price"]
                        PR_GUARD_MENU.WeaponScrollPanel:Remove()
                    end
                end
			end

			local healthy_guard_btn = vgui.Create("DButton", BuyWindow)
			healthy_guard_btn:SetText("")
			healthy_guard_btn:SetSize(285,50)
			healthy_guard_btn:SetPos(BuyWindow:GetWide()/2 - 350, 400)

			healthy_guard_btn.Paint = function()
				draw.RoundedBox(0, 0, 0, healthy_guard_btn:GetWide(), healthy_guard_btn:GetTall(), Color(50,50,50))
	
				--draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
				draw.RoundedBox(0, 0, 0, healthy_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- верхушка
	
				draw.RoundedBox(0, 0, 0, 1, healthy_guard_btn:GetTall(), Color(255,255,255,255)) -- левушка
	
				draw.RoundedBox(0, healthy_guard_btn:GetWide() - 1, 0, 1, healthy_guard_btn:GetTall(), Color(255,255,255,255)) -- правушка
	
				draw.RoundedBox(0, 0, healthy_guard_btn:GetTall() - 1, healthy_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- низушка
	
				draw.SimpleText(healthy_guard_text, "DermaLarge", 285/2, 5, Color(255,255,255), 1)
			end
			
			healthy_guard_btn.DoClick = function()
				local hp_multiplayer_list = {
					1,
					1.5,
					2,
					2.5
				}

                local DScrollPanel = vgui.Create( "DScrollPanel", BuyWindow )
                DScrollPanel:SetPos(healthy_guard_btn.x, healthy_guard_btn.y)
                DScrollPanel:SetSize(healthy_guard_btn:GetWide(),400)

                for k,v in pairs(hp_multiplayer_list) do
                    local DButton = DScrollPanel:Add( "DButton" )
                    DButton:SetText("")
                    DButton:Dock(TOP)
                    DButton:SetSize(healthy_guard_btn:GetWide(), healthy_guard_btn:GetTall())
                    DButton:DockMargin( 0, 0, 0, 0 )

                    DButton.Paint = function()
                        surface.SetDrawColor(30,30,30)
                        surface.DrawRect(0,0, DScrollPanel:GetWide(), DScrollPanel:GetTall())

						draw.RoundedBox(0, 0, 0, DButton:GetWide(), 1, Color(255,255,255)) -- верхушка
			
						draw.RoundedBox(0, 0, 0, 1, DButton:GetTall(), Color(255,255,255)) -- левушка
			
						draw.RoundedBox(0, DButton:GetWide() - 1, 0, 1, DButton:GetTall(), Color(255,255,255)) -- правушка
			
						draw.RoundedBox(0, 0, DButton:GetTall() - 1, DButton:GetWide(), 1, Color(255,255,255)) -- низушка

                        draw.DrawText("x" .. v,"DermaDefaultBold", DScrollPanel:GetWide() / 2, 5, Color(255,255,255),1)
                        draw.DrawText("Цена: " .. "x" .. v .. " от цены типа челика","DermaDefaultBold", DScrollPanel:GetWide() / 2, 22, Color(255,255,255),1)
                    end

                    DButton.DoClick = function()
						healthy_guard = v
						healthy_guard_text = "x" .. v
                        DScrollPanel:Remove()
                    end
                end
			end

			local signal_guard_btn = vgui.Create("DButton", BuyWindow)
			signal_guard_btn:SetText("")
			signal_guard_btn:SetSize(285,50)
			signal_guard_btn:SetPos(BuyWindow:GetWide()/2 + 50, 400)

			signal_guard_btn.Paint = function()
				draw.RoundedBox(0, 0, 0, signal_guard_btn:GetWide(), signal_guard_btn:GetTall(), Color(50,50,50))
	
				--draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )
				draw.RoundedBox(0, 0, 0, signal_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- верхушка
	
				draw.RoundedBox(0, 0, 0, 1, signal_guard_btn:GetTall(), Color(255,255,255,255)) -- левушка
	
				draw.RoundedBox(0, signal_guard_btn:GetWide() - 1, 0, 1, signal_guard_btn:GetTall(), Color(255,255,255,255)) -- правушка
	
				draw.RoundedBox(0, 0, signal_guard_btn:GetTall() - 1, signal_guard_btn:GetWide(), 1, Color(255,255,255,255)) -- низушка
	
				draw.SimpleText(sign_guard_text, "DermaLarge", 285/2, 5, Color(255,255,255), 1)
			end
			
			signal_guard_btn.DoClick = function()
				local sign_list = {
					["включить"] = {
						["Boolean"] = true,
						["Price"] = 500
					},
					["выключить"] = {
						["Boolean"] = false,
						["Price"] = 0
					}
				}

                local DScrollPanel = vgui.Create( "DScrollPanel", BuyWindow )
                DScrollPanel:SetPos(signal_guard_btn.x, signal_guard_btn.y)
                DScrollPanel:SetSize(signal_guard_btn:GetWide(),400)

                for k,v in pairs(sign_list) do
                    local DButton = DScrollPanel:Add( "DButton" )
                    DButton:SetText("")
                    DButton:Dock(TOP)
                    DButton:SetSize(signal_guard_btn:GetWide(), signal_guard_btn:GetTall())
                    DButton:DockMargin( 0, 0, 0, 0 )

                    DButton.Paint = function()
                        surface.SetDrawColor(30,30,30)
                        surface.DrawRect(0,0, DScrollPanel:GetWide(), DScrollPanel:GetTall())

						draw.RoundedBox(0, 0, 0, DButton:GetWide(), 1, Color(255,255,255)) -- верхушка
			
						draw.RoundedBox(0, 0, 0, 1, DButton:GetTall(), Color(255,255,255)) -- левушка
			
						draw.RoundedBox(0, DButton:GetWide() - 1, 0, 1, DButton:GetTall(), Color(255,255,255)) -- правушка
			
						draw.RoundedBox(0, 0, DButton:GetTall() - 1, DButton:GetWide(), 1, Color(255,255,255)) -- низушка

                        draw.DrawText(k,"DermaDefaultBold", DScrollPanel:GetWide() / 2, 5, Color(255,255,255),1)
                        draw.DrawText("Цена: " .. v["Price"] .. "$","DermaDefaultBold", DScrollPanel:GetWide() / 2, 22, Color(255,255,255),1)
                    end

                    DButton.DoClick = function()
						sign_guard = v["Boolean"]
						sign_guard_text = k
						sign_guard_price = v["Price"]
                        DScrollPanel:Remove()
                    end
                end
			end

			local MoneyText = vgui.Create( "DLabel", BuyWindow )
			MoneyText:SetPos(BuyWindow:GetWide()/2 - 285/2, 500)
			MoneyText:SetText( "" )
			MoneyText:SetSize( 285, 50)
			MoneyText.Paint = function()
				surface.SetDrawColor(50,50,50,255)
				surface.DrawRect(0,0, MoneyText:GetWide(),MoneyText:GetTall())
				surface.SetDrawColor(200,220,220,255)

				draw.RoundedBox(0, 0, 0, MoneyText:GetWide(), 1, Color(255,255,255,255)) -- верхушка
	
				draw.RoundedBox(0, 0, 0, 1, MoneyText:GetTall(), Color(255,255,255,255)) -- левушка
	
				draw.RoundedBox(0, MoneyText:GetWide() - 1, 0, 1, MoneyText:GetTall(), Color(255,255,255,255)) -- правушка
	
				draw.RoundedBox(0, 0, MoneyText:GetTall() - 1, MoneyText:GetWide(), 1, Color(255,255,255,255)) -- низушка

				draw.SimpleText((type_guard_price * healthy_guard) + weap_guard_price + sign_guard_price.. "$", "DermaLarge", MoneyText:GetWide()/2, 7, Color(255,255,255), 1)
			end

			local summon_guard = PR_CreateNewButton(butt, "призвать защитника", 285, 50, BuyWindow:GetWide()/2 - 285/2, 600, "", BuyWindow, Color(50,50,50), Color(255,255,255), 0, 10, 5, "DermaLarge")
			summon_guard.DoClick = function()
				price_guard = (type_guard_price * healthy_guard) + weap_guard_price + sign_guard_price
				if ent.MaxGuardianCount > ent.GuardianCount then
					if ply:GetNWInt("PR_money") >= price_guard then
						local npc_setting = {
							["npc"] = type_guard,
							["weapon"] = weap_guard,
							["healthy"] = healthy_guard,
							["signal"] = sign_guard,
							["price"] = price_guard
						}

						net.Start("SpawnGuardianNPC")
							net.WriteEntity(ent)
							net.WriteTable(npc_setting)
						net.SendToServer()
						ent.GuardianCount = ent.GuardianCount + 1
					else
						PR_CreateErrorNotice("У тебя не хватает щекелей")
					end
				else
					PR_CreateErrorNotice("Защитников уже максимальное количество")
				end
			end
		else
			PR_CreateErrorNotice("Защитников уже максимальное количество")
		end
	end
	
	local escapefromkazino = vgui.Create( "DButton", idkMenu)
	escapefromkazino:SetPos( W - 100, H*0.0001 )
	escapefromkazino:SetText( "" )
	escapefromkazino:SetSize( 100, ScrH() )
	escapefromkazino.Paint = function()
		surface.SetDrawColor(120,0,0,150)
		surface.DrawRect(0,0, escapefromkazino:GetWide(),escapefromkazino:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText( "X", "DermaLarge", 45, ScrH()/2, Color(255,255,255) )
	end
	escapefromkazino.DoClick = function()
		idkMenu:Remove()
	end

	local InfoText = vgui.Create( "DLabel", idkMenu )
	InfoText:SetPos( W*0.5, H*0.582 )
	InfoText:SetText( "" )
	InfoText:SetSize( 500, 200 )
	InfoText.Paint = function()
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, InfoText:GetWide(), InfoText:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText("Осталось: " .. math.Round(ent.Delay - CurTime(), 0) .. "с.", "DermaLarge", 35, 15, Color(255,255,255))
		draw.SimpleText("Приход: " .. ent.UpgradeComputer * 1000 .. "$", "DermaLarge", 35, 55, Color(255,255,255))
		draw.SimpleText("Защитников: " .. ent.GuardianCount .. "/" .. ent.MaxGuardianCount, "DermaLarge", 35, 100, Color(255,255,255))
		draw.SimpleText("Сейчас хранится: " .. ent.Money .. "$", "DermaLarge", 35, 150, Color(255,255,255))
	end

	function ent.Think()
		if CurTime() >= ent.Delay then
			ent.Delay = CurTime() + 450 - ent.UpgradeMonitor * 100
			ent.Money = ent.Money + ent.UpgradeComputer * 1000

			if !ply:Alive() then
				idkMenu:Remove()
			end
		end
	end
	
end

function ConfigAdminMenu()
	local ply = LocalPlayer()

	local ent = net.ReadEntity()

	PR_Capture_Points_List = PR_Capture_Points_List or {}

	if ent.CurPoint == nil then
		ent.CurPoint = ""
	end

	net.Start("GetPointsCfgs")
	net.WriteTable(PR_Capture_Points_List)
	net.SendToServer()

	local W, H 	= ScrW(), ScrH()
	local idkMenu = vgui.Create( "DFrame" )
	idkMenu:SetPos( W/2-500, H/2-250 )
	idkMenu:SetSize( 1000, 500 )
	idkMenu:SetTitle("")
	idkMenu:SetDraggable( true )
	idkMenu:ShowCloseButton( true )
	idkMenu:MakePopup()

	idkMenu.Paint = function()
		surface.SetDrawColor( 100, 100, 100, 150 )
		surface.DrawTexturedRect( 0, 0, W, H )

		local text = "Текущая точка: ".. ent.CurPoint
		
		surface.SetFont( "DermaLarge" )
		surface.SetTextPos( 100, 50 )

		for char = 1, #text do
			local col = HSVToColor( ( ( RealTime() * 100 ) - char * 15 ) % 360, 1, 1 )
			surface.SetTextColor( col.r, col.g, col.b )	  -- Providing 3 numbers to surface.SetTextColor rather 
		end
		surface.DrawText(text)	-- than a single color is faster
	end

	local ConfigsButton = vgui.Create("DButton", idkMenu)
	ConfigsButton:SetText("")
	ConfigsButton:SetPos(100,100)
	ConfigsButton:SetSize(225,40)

	ConfigsButton.Paint = function()
		surface.SetDrawColor(50, 50, 50, 255)
		surface.DrawRect(0, 0, ConfigsButton:GetWide(), ConfigsButton:GetTall())

		draw.DrawText("Выбрать точку", "DermaLarge", 18, 5, Color(255,255,255,255), 0)
	end
	
	ConfigsButton.DoClick = function()
		net.Start("GetPointsCfgs")
		net.SendToServer()

		if PR_Capture_Points_List.Config != {} and PR_Capture_Points_List.Config != nil then
			local ConfigScroll = vgui.Create("DScrollPanel", idkMenu)
			ConfigScroll:SetPos(100, 140)
			ConfigScroll:SetSize(225,120)
			
			local CfgButton = ConfigScroll:Add( "DButton" )
			CfgButton:SetText("")
			CfgButton:Dock(TOP)
			CfgButton:DockMargin( 0, 0, 0, -2 )

			CfgButton.Paint = function()
				surface.SetDrawColor(30,30,30,255)
				surface.DrawRect(0,0, CfgButton:GetWide(), CfgButton:GetTall())

				draw.DrawText("Закрыть","DermaDefaultBold", CfgButton:GetWide() / 2, 2, Color(255,255,255,255),1)
			end

			CfgButton.DoClick = function()
				ConfigScroll:Remove()
			end
			
			local NewCfgButton = ConfigScroll:Add( "DButton" )
			NewCfgButton:SetText("")
			NewCfgButton:Dock(TOP)
			NewCfgButton:DockMargin( 0, 0, 0, -2 )

			NewCfgButton.Paint = function()
				surface.SetDrawColor(30,30,30,255)
				surface.DrawRect(0,0, NewCfgButton:GetWide(), NewCfgButton:GetTall())

				draw.DrawText("Новый","DermaDefaultBold", NewCfgButton:GetWide() / 2, 2, Color(255,255,255,255),1)
			end

			NewCfgButton.DoClick = function()
				local SaveWindow = vgui.Create("DFrame")
				SaveWindow:SetSize(300,200)
				SaveWindow:Center()
				SaveWindow:SetTitle("")
				SaveWindow:SetVisible(true)
				SaveWindow:SetDraggable(true)
				SaveWindow:ShowCloseButton(true)
				SaveWindow:MakePopup()
				SaveWindow.Paint = function ()
					draw.RoundedBox(4,0,0,SaveWindow:GetWide(), SaveWindow:GetTall(), Color(80,80,80,255))
					draw.RoundedBox(4,0,0,SaveWindow:GetWide(), 21, Color(50,50,50,255))

					draw.DrawText("Название?", "DermaDefaultBold", 150, 30, Color(255,255,255,255), 1)
				end

				local ConfigName = vgui.Create("DTextEntry", SaveWindow)
				ConfigName:SetPos(20,85)
				ConfigName:SetTall(20)
				ConfigName:SetWide(260)
				ConfigName:SetEnterAllowed(true)
				
				local SaveCfgButton = vgui.Create("DButton", SaveWindow)
				SaveCfgButton:SetPos(75,150)
				SaveCfgButton:SetSize(150,20)
				SaveCfgButton:SetText("")

				SaveCfgButton.Paint = function()
					surface.SetDrawColor(50,50,50,255)
					surface.DrawRect(0,0, SaveCfgButton:GetWide(), SaveCfgButton:GetTall())
							
					draw.DrawText("Сохранить","DermaDefaultBold", SaveCfgButton:GetWide() / 2, 2, Color(255,255,255,255),1)
				end

				SaveCfgButton.DoClick = function()
					GetNewCfgs()
					net.Start("CreateNewCfgs")
						net.WriteString(ConfigName:GetValue())
						net.WriteEntity(ent)
					net.SendToServer()
					ent.CurPoint = ConfigName:GetValue()
					ConfigScroll:Remove()
					SaveWindow:Remove()
				end
			end

			for k,v in pairs(PR_Capture_Points_List.Config) do
				local CfgButton = ConfigScroll:Add( "DButton" )
				CfgButton:SetText("")
				CfgButton:Dock(TOP)
				CfgButton:DockMargin( 0, 0, 0, -2 )

				CfgButton.Paint = function()
					surface.SetDrawColor(30,30,30,255)
					surface.DrawRect(0,0, CfgButton:GetWide(), CfgButton:GetTall())

					draw.DrawText(k,"DermaDefaultBold", CfgButton:GetWide() / 2, 2, Color(255,255,255,255),1)
				end

				CfgButton.DoClick = function()
					net.Start("SetServerPointsCfgs")
						net.WriteString(k)
						net.WriteEntity(ent)
					net.SendToServer()

					PR_Capture_Points_List.Team = PR_Capture_Points_List.Config[k]["Team"]
					PR_Capture_Points_List.MonikUp = PR_Capture_Points_List.Config[k]["Monitor"]
					PR_Capture_Points_List.SistemnikUp = PR_Capture_Points_List.Config[k]["System"]

					ent.CurPoint = k

					ConfigScroll:Remove()
				end
			end
		end
	end

	local SetButton = vgui.Create("DButton", idkMenu)
	SetButton:SetText("")
	SetButton:SetPos(700, 100)
	SetButton:SetSize(238, 40)

	SetButton.Paint = function()
		surface.SetDrawColor(50, 50, 50, 255)
		surface.DrawRect(0, 0, SetButton:GetWide(), SetButton:GetTall())

		draw.DrawText("Установить точку", "DermaLarge", 5, 5, Color(255,255,255,255), 0)
	end
	
	SetButton.DoClick = function()
		net.Start("SetPoint")
		net.WriteEntity(ent)
		net.SendToServer()
		idkMenu:Remove()
	end
	
	local escapefromkazino = vgui.Create( "DButton", idkMenu)
	escapefromkazino:SetPos(950, 1)
	escapefromkazino:SetText( "" )
	escapefromkazino:SetSize( 50, 50 )
	escapefromkazino.Paint = function()
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, escapefromkazino:GetWide(),escapefromkazino:GetTall())
		surface.SetDrawColor(200,220,220,255)
		draw.SimpleText( "X", "DermaLarge", 17, 10, Color(255,255,255) )
	end
	escapefromkazino.DoClick = function()
		idkMenu:Remove()
	end

	function GetNewCfgs()
		local PointInfo = {PR_Capture_Points_List.Team, PR_Capture_Points_List.MonikUp, PR_Capture_Points_List.SistemnikUp}
		net.Start("GetNewCfgs")
			net.WriteTable(PointInfo)
		net.SendToServer()
	end
end

net.Receive( "SetClientNewPoint", function()
	ent = net.ReadEntity()
	ent.CaptureTeam = net.ReadString()
end)

net.Receive( "GivePointsCfgs", function()
	PR_Capture_Points_List.Config = net.ReadTable()
end)

net.Receive( "GuardianDown", function()
	ent = net.ReadEntity()
	ent.GuardianCount = ent.GuardianCount - 1
end)

net.Receive( "GivePointEnt", function()
	ent = net.ReadEntity()
	ent.CaptureTeam = net.ReadString()
	ent.UpgradeMonitor = net.ReadInt(8)
	ent.UpgradeComputer = net.ReadInt(8)
end)

net.Receive( "GivePointUpgrade", function()
	ent = net.ReadEntity()
	ent.UpgradeMonitor = net.ReadInt(8)
	ent.UpgradeComputer = net.ReadInt(8)
end)

net.Receive("OpenIDKPanel", idkMenuOpen )

net.Receive("OpenAdminPanel", ConfigAdminMenu )