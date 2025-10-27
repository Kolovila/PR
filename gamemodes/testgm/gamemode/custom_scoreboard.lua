local ScoreboardDerma = nil
local PlayerList

function GM:ScoreboardShow()
  
	if !IsValid(ScoreboardDerma) then
		ScoreboardDerma = vgui.Create("DFrame")
		ScoreboardDerma:SetSize(750,500)
		ScoreboardDerma:SetPos(ScrW()/2-325,ScrH()/2-250)
		ScoreboardDerma:SetTitle("Табилца игроков")
		ScoreboardDerma:SetDraggable(true)
		ScoreboardDerma:ShowCloseButton(false)
		ScoreboardDerma.Paint = function()
			draw.RoundedBox(5,0,0,ScoreboardDerma:GetWide(),ScoreboardDerma:GetTall(), Color(60,60,60,255))
		end
  
		local PlayerScrollPanel = vgui.Create("DScrollPanel", ScoreboardDerma)
		PlayerScrollPanel:SetSize(ScoreboardDerma:GetWide(),ScoreboardDerma:GetTall()-20)
		PlayerScrollPanel:SetPos(0,20)
		
		PlayerList = vgui.Create("DListLayout", PlayerScrollPanel)
		PlayerList:SetSize(PlayerScrollPanel:GetWide(),PlayerScrollPanel:GetTall())
		PlayerList:SetPos(0,0)
	end

   	if IsValid(ScoreboardDerma) then
		PlayerList:Clear()

		local PlayersPanelList = PlayersPanelList or {}

		local i = 0
		
		for k, v in pairs(player.GetAll()) do
			PlayersPanelList[i] = vgui.Create("DPanel", PlayerList)
			
			PlayersPanelList[i]:SetSize(PlayerList:GetWide(),50)
			PlayersPanelList[i]:SetPos(0,0)
			
			local Avatar = vgui.Create( "AvatarImage", PlayersPanelList[i] )
			Avatar:SetSize(32,32)
			Avatar:SetPlayer(v,32)
			Avatar:SetPos(10,PlayerList:GetWide()-740)

			if v:IsAdmin() or v:GetNWBool("PR_admin") == true then
				local AdminIcon = vgui.Create( "DImage", PlayersPanelList[i] )
				AdminIcon:SetSize(16,16)
				AdminIcon:SetPos(34, 2)
				AdminIcon:SetImage("test_gm_mat/icons/player_admin.png")
			end

			if v:GetNWBool("PR_leader_" .. v:GetNWString("PR_fraction")) == true then
				local LeaderIcon = vgui.Create( "DImage", PlayersPanelList[i] )
				LeaderIcon:SetSize(16,16)
				LeaderIcon:SetPos(0, 2)
				LeaderIcon:SetImage("test_gm_mat/icons/player_leader.png")
			end
			
			local somthingDo = vgui.Create( "DImageButton", PlayersPanelList[i] )
			somthingDo:SetPos(10,PlayerList:GetWide()-740)
			somthingDo:SetSize(32, 32)	 
			somthingDo.DoClick = function()
				for k, v in pairs(PlayersPanelList) do
					if v == somthingDo:GetParent() then
						PlayersPanelList[k]:SetSize(PlayerList:GetWide(), 150)
					end
				end
		 
				PlayersPanelList[k-1].Paint = function()
					draw.RoundedBox(0,0,0, 750, 150, Color(0,0,0,255))

					draw.RoundedBox(0,0,49, 750, 1, Color(255,255,255,255))

					draw.RoundedBox(0,0,149, 750, 1, Color(255,255,255,255))

					draw.RoundedBox(0,0,0, 1, 199, Color(255,255,255,255))
					draw.RoundedBox(0,749,0, 1, 199, Color(255,255,255,255))

					draw.RoundedBox(0,0,0, 750, 1, Color(255,255,255,255))
			 
					--if v:GetNWInt("LeaderTeamSSNK") == 1 or v:GetNWInt("LeaderTeamUSA") == 1 or v:GetNWInt("LeaderTeamGBC") == 1 or v:GetNWInt("LeaderTeamWN") == 1 then
						--draw.SimpleText("Лидер своей фракции","DermaDefault",380,30, Color(255,255,255,255))
					--end
					
					if v:IsValid() then
						local deathForKD
	
						if v:GetNWInt("PR_deaths") == 0 then
							deathForKD = 1
						else
							deathForKD = v:GetNWInt("PR_deaths")
						end
						
						draw.SimpleText(v:GetName().. " - Уровень: ".. v:GetNWInt("PR_level") .. " - " .. v:GetNWString("PR_fraction") .. ": " .. v:GetNWInt("PR_level_" .. v:GetNWString("PR_fraction")),"DermaDefault",55,10, Color(255,255,255,255))
						draw.SimpleText("Убийств игроков: "..v:GetNWInt("PR_kills"),"DermaDefault",PlayerList:GetWide()-20,3, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
						draw.SimpleText("Смертей: "..v:GetNWInt("PR_deaths"),"DermaDefault",PlayerList:GetWide()-20,18, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
						draw.SimpleText("Убийств NPC: "..v:GetNWInt("PR_kills_npc"),"DermaDefault",PlayerList:GetWide()-160,3, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
						draw.SimpleText("K/D: ".. math.Round(v:GetNWInt("PR_kills")/deathForKD, 2),"DermaDefault",PlayerList:GetWide()-20,33, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
						draw.SimpleText("Пинг: "..v:Ping(),"DermaDefault",PlayerList:GetWide()-160,30, Color(255,255,255,255), TEXT_ALIGN_RIGHT)

						if LocalPlayer():GetNWInt("PR_admin") == true or LocalPlayer():IsAdmin() then
							draw.SimpleText("HP: "..v:Health(),"DermaDefault",250,10,Color(255,255,255,255))
							draw.SimpleText("Armor: "..v:Armor(),"DermaDefault",250,25,Color(255,255,255,255))
							draw.SimpleText("$"..v:GetNWInt("PR_money") .. "/" .. v:GetNWInt("PR_Coin") .. "©","DermaDefault",55,25,Color(255,255,255,255))
							--draw.SimpleText(v:GetNWInt("MPcoin").. " ©","DermaDefault",200,25,Color(255,255,255,255))
						end
						if LocalPlayer():GetNWInt("PR_admin") == 1 or LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_leader_" .. LocalPlayer():GetNWString("PR_fraction")) == true then
							if v:GetNWString("PR_fraction") == LocalPlayer():GetNWString("PR_fraction") then
								draw.SimpleText("$"..v:GetNWInt("PR_money"),"DermaDefault",55,25,Color(255,255,255,255))
							end
						end
					end
				end

				--local AdminButton = vgui.Create("DButton", PlayersPanelList[k-1])
				--AdminButton:SetText("Дать админа (пр)")
				--AdminButton:SetSize(120,40)
				--AdminButton:SetPos(1,40)
				--AdminButton.DoClick = function()
				--	LocalPlayer():ConCommand("say " .. "/giveAdminPR " .. v:SteamID64())
				--end
		 
				--AdminButton.Paint = function()
				--	draw.RoundedBox(0,0,0, 750, 100,Color(255,255,255,255))
				--end

				
				if LocalPlayer():IsAdmin() or LocalPlayer():GetNWBool("PR_admin") == true then
					local AdminButton = PR_CreateNewButton(butt, "Дать/забрать админку", 180, 45, 25, 52, "admin.png", PlayersPanelList[k-1])
					AdminButton.DoClick = function()
						net.Start("SetAdminPR")
							net.WriteEntity(v)
						net.SendToServer()
					end

					local LeaderButton = PR_CreateNewButton(butt, "Отдать лидера фракции", 190, 45, 25, 102, "leader_squad.png", PlayersPanelList[k-1])
					LeaderButton.DoClick = function()
						net.Start("SetLeaderFracPR")
							net.WriteEntity(v)
						net.SendToServer()
					end
				
					local MoneyButton = PR_CreateNewButton(butt, "Изменить деньги (+/-)", 180, 45, 210, 52, "change_money.png", PlayersPanelList[k-1])
					MoneyButton.DoClick = function()
						local func = function(amount)
							net.Start("SetMoneyPR")
								net.WriteEntity(v)
								net.WriteInt(amount, 32)
							net.SendToServer()
						end
	
						PR_CreateWriteMenu(func, "Изменить деньги (+/-)")
					end

					local ExpButton = PR_CreateNewButton(butt, "Изменить опыт (+/-)", 170, 45, 395, 52, "change_exp.png", PlayersPanelList[k-1])
					ExpButton.DoClick = function()
						local func = function(amount)
							net.Start("SetExpPR")
								net.WriteEntity(v)
								net.WriteInt(amount, 32)
							net.SendToServer()
						end
	
						PR_CreateWriteMenu(func, "Изменить опыт (+/-)")
					end

					local MissionMoneyButton = PR_CreateNewButton(butt, "Дать деняг за миссию", 180, 45, 220, 102, "change_money_mission.png", PlayersPanelList[k-1])
					MissionMoneyButton.DoClick = function()
						local func = function(amount)
							net.Start("GiveMoneyForMissionPR")
								net.WriteEntity(v)
								net.WriteInt(amount, 32)
							net.SendToServer()
						end
	
						PR_CreateWriteMenu(func, "Дать деняг за миссию")
					end

					local ExpFractionButton = PR_CreateNewButton(butt, "Изменить опыт фракции", 190, 45, 405, 102, "change_frac_exp.png", PlayersPanelList[k-1])
					ExpFractionButton.DoClick = function()
						local func = function(amount)
							net.Start("SetExpFracPR")
								net.WriteEntity(v)
								net.WriteInt(amount, 32)
							net.SendToServer()
						end
	
						PR_CreateWriteMenu(func, "Изменить опыт фракции")
					end

					local CoinButton = PR_CreateNewButton(butt, "Изменить © (+/-)", 145, 45, 570, 52, "change_coins.png", PlayersPanelList[k-1])
					CoinButton.DoClick = function()
						local func = function(amount)
							net.Start("SetCoinPR")
								net.WriteEntity(v)
								net.WriteInt(amount, 32)
							net.SendToServer()
						end
	
						PR_CreateWriteMenu(func, "Изменить © (+/-)")
					end

					local KickButton = PR_CreateNewButton(butt, "КИК НАХУЙ", 115, 45, 600, 102, "kick.png", PlayersPanelList[k-1])
					KickButton.DoClick = function()
						net.Start("KickOffNahyiPR")
							net.WriteEntity(v)
						net.SendToServer()
					end
				elseif LocalPlayer():GetNWBool("PR_leader_" .. LocalPlayer():GetNWString("PR_fraction")) == true then
					if v:GetNWString("PR_fraction") == LocalPlayer():GetNWString("PR_fraction") then
						local LeaderButton = PR_CreateNewButton(butt, "Отдать лидера фракции", 190, 45, 25, 102, "leader_squad.png", PlayersPanelList[k-1])
						LeaderButton.DoClick = function()
							net.Start("SetLeaderFracPR")
								net.WriteEntity(v)
							net.SendToServer()
						end
					end
				end
			end
		 
			PlayersPanelList[i].Paint = function()
				draw.RoundedBox(0,0,0, 750, 50,Color(50,50,50,255))
				draw.RoundedBox(0,0,49, 750, 1, Color(255,255,255,255))
		 
				--if v:GetNWInt("LeaderTeamSSNK") == 1 or v:GetNWInt("LeaderTeamUSA") == 1 or v:GetNWInt("LeaderTeamGBC") == 1 or v:GetNWInt("LeaderTeamWN") == 1 then
					--draw.SimpleText("Лидер своей фракции","DermaDefault",380,30, Color(255,255,255,255))
				--end
		 
				if v:IsValid() then
					local deathForKD

					if v:GetNWInt("PR_deaths") == 0 then
						deathForKD = 1
					else
						deathForKD = v:GetNWInt("PR_deaths")
					end
					
					draw.SimpleText(v:GetName().. " - Уровень: ".. v:GetNWInt("PR_level") .. " - " .. v:GetNWString("PR_fraction") .. ": " .. v:GetNWInt("PR_level_" .. v:GetNWString("PR_fraction")),"DermaDefault",55,10, Color(255,255,255,255))
					draw.SimpleText("Убийств игроков: "..v:GetNWInt("PR_kills"),"DermaDefault",PlayerList:GetWide()-20,3, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
					draw.SimpleText("Смертей: "..v:GetNWInt("PR_deaths"),"DermaDefault",PlayerList:GetWide()-20,18, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
					draw.SimpleText("Убийств NPC: "..v:GetNWInt("PR_kills_npc"),"DermaDefault",PlayerList:GetWide()-160,3, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
					draw.SimpleText("K/D: ".. math.Round(v:GetNWInt("PR_kills") / deathForKD, 2),"DermaDefault",PlayerList:GetWide()-20,33, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
					draw.SimpleText("Пинг: "..v:Ping(),"DermaDefault",PlayerList:GetWide()-160,30, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
					if LocalPlayer():GetNWInt("PR_admin") == true or LocalPlayer():IsAdmin() then
						draw.SimpleText("HP: "..v:Health(),"DermaDefault",250,10,Color(255,255,255,255))
						draw.SimpleText("Armor: "..v:Armor(),"DermaDefault",250,25,Color(255,255,255,255))
						draw.SimpleText("$"..v:GetNWInt("PR_money") .. "/" .. v:GetNWInt("PR_Coin") .. "©","DermaDefault",55,25,Color(255,255,255,255))
					end
					if LocalPlayer():GetNWBool("PR_leader_" .. LocalPlayer():GetNWString("PR_fraction")) == true then
						if v:GetNWString("PR_fraction") == LocalPlayer():GetNWString("PR_fraction") then
							draw.SimpleText("$"..v:GetNWInt("PR_money"),"DermaDefault",55,25,Color(255,255,255,255))
						end
					end
				end
		 	end
			i = i + 1
		end
		--PrintTable(PlayersPanelList)
		 
	end
    ScoreboardDerma:Show()
	ScoreboardDerma:MakePopup()
	ScoreboardDerma:SetKeyboardInputEnabled(false)
end

function GM:ScoreboardHide()
	if IsValid(ScoreboardDerma) then
		ScoreboardDerma:Hide()
	end
end
