surface.CreateFont( "testgm_HP_ARMOR_font", {
	font = "Snowstorm",
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "testgm_AMMO_font", {
	font = "Bender",
	extended = false,
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "testgm_CALIBER_font", {
	font = "Snowstorm",
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "testgm_INFO_font", {
	font = "Snowstorm",
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "panel_INFO_font", {
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local showhud = false

local CheckMagTime = 0

local magAmmo = ''

local BoxSize = 0
local BoxPosX = 0
local TextPosX = 0

function HUD()
    local client = LocalPlayer()
	
	if !client:Alive() then
	   return
	end

	--print(client:GetPos())

	--draw.RoundedBox(0,10, ScrH() - 120,320,60, Color(30,30,30,200))

	--[[ --hp
	draw.RoundedBox(5,15, ScrH() - 95,150,30, Color(0,30,0,255))
	draw.RoundedBox(5,15, ScrH() - 95,math.Clamp(client:Health(), 0, 100)*1.5,30, Color(0,170,0,255))
	draw.SimpleText("HP", "testgm_HP_ARMOR_font", 15, ScrH() - 122.5, Color(255,255,255,255),0)

	--armor
	draw.RoundedBox(5,175, ScrH() - 95,150,30, Color(0,0,30,255))
	draw.RoundedBox(5,175, ScrH() - 95,math.Clamp(client:Armor(), 0, 100)*1.5,30, Color(0,0,170,255))
	draw.SimpleText("ARM", "testgm_HP_ARMOR_font", 176, ScrH() - 122.5, Color(255,255,255,255),0) ]]

	--ammo
	local weap = client:GetActiveWeapon()
	concommand.Add("PR_Check_Ammo", function()
		if !client:Alive() then
		   return
		end

		if not timer.Exists("PR_MagCheckTimer") then
			if weap:GetPrimaryAmmoType() != -1 then
				if weap:Clip1() >= weap:GetMaxClip1() then
					magAmmo = "Полон"
					BoxPosX = 215
					BoxSize = 170
					TextPosX = 130
				elseif weap:Clip1() <= weap:GetMaxClip1() - 1 and weap:Clip1() >= weap:GetMaxClip1() / 1.5 then
					magAmmo = "Больше половины"
					BoxPosX = 400
					BoxSize = 355
					TextPosX = 222.5
				elseif weap:Clip1() < weap:GetMaxClip1() / 1.5 and weap:Clip1() >= weap:GetMaxClip1() / 3 then
					magAmmo = "Около половины"
					BoxPosX = 395
					BoxSize = 350
					TextPosX = 220
				elseif weap:Clip1() < weap:GetMaxClip1() / 3 and weap:Clip1() > 0 then
					magAmmo = "Почти пуст"
					BoxPosX = 280
					BoxSize = 235
					TextPosX = 165
				elseif weap:Clip1() == 0 then
					magAmmo = "Пуст"
					BoxPosX = 195
					BoxSize = 150
					TextPosX = 120
				end
			end

			timer.Create( "PR_MagCheckTimer", 3, 1, function() end)
		end
	end)

	if timer.Exists("PR_MagCheckTimer") then
		local BlackOut = timer.TimeLeft("PR_MagCheckTimer")*100

		draw.SimpleText(game.GetAmmoName(weap:GetPrimaryAmmoType()), "testgm_CALIBER_font", ScrW()-145, ScrH() - 50, Color(255,255,255,BlackOut),1)

		--Сколько в запасе патронов
		draw.RoundedBox(0,ScrW() - 195, ScrH() - 180,150,60, Color(30,30,30,BlackOut))
		draw.SimpleText(client:GetAmmoCount(weap:GetPrimaryAmmoType()), "testgm_AMMO_font", ScrW()-120, ScrH() - 175, Color(255,255,255,BlackOut),1)

		--Патроны в магазине
		draw.RoundedBox(0,ScrW() - BoxPosX, ScrH() - 120,BoxSize,60, Color(30,30,30,BlackOut))
		draw.SimpleText(magAmmo, "testgm_AMMO_font", ScrW()-TextPosX, ScrH() - 115, Color(255,255,255,BlackOut),1)

		if weap:GetSecondaryAmmoType() != -1 then
			draw.RoundedBox(0,ScrW() - 155, ScrH() - 240,110,60, Color(30,30,30,BlackOut-55))
			draw.SimpleText(client:GetAmmoCount(weap:GetSecondaryAmmoType()), "testgm_AMMO_font", ScrW()-100, ScrH() - 235, Color(255,255,255,BlackOut),1)
		end
	end
	
	--if client:KeyPressed(1) then
		--CheckMagTime = 0
	--end

	--if CheckMagTime > CurTime() then

		--Калибр
		--draw.RoundedBox(0,ScrW() - 245, ScrH() - 60,200,50, Color(30,30,30,BlackOut-55))
	--end

	--[[ local expToLevel = (client:GetNWInt("LVL") * 100)
	local ssnkExpToLevel = (client:GetNWInt("SSNKLVL") * 200)
	local usaExpToLevel = (client:GetNWInt("USALVL") * 200)
	local gbcExpToLevel = (client:GetNWInt("GBCLVL") * 200)
	local wnExpToLevel = (client:GetNWInt("WNLVL") * 200)
	]]
			
	--draw.RoundedBox(0,10, ScrH() - 320,320,200, Color(30,30,30,200))
	--if client:GetNWInt("LeaderTeamSSNK") == 1 or client:GetNWInt("LeaderTeamUSA") == 1 or client:GetNWInt("LeaderTeamGBC") == 1 or client:GetNWInt("LeaderTeamWN") == 1 then
	--	draw.SimpleText(math.Round(client:GetNWInt("PR_money")).. "$ / ".. client:GetNWInt("OffshorMoney").. "❖", "testgm_INFO_font", 15, ScrH() - 320, Color(255,255,255,255),0)
	--else
	--	draw.SimpleText(math.Round(client:GetNWInt("PR_money")).. "$", "testgm_INFO_font", 15, ScrH() - 320, Color(255,255,255,255),0)
	--end
	
	--draw.SimpleText(client:GetNWInt("MPcoin").. "©", "testgm_INFO_font", 325, ScrH() - 320, Color(255,255,255,255),2)

			
	--draw.SimpleText("LVL: " ..client:GetNWInt("PR_level"), "testgm_INFO_font", 15, ScrH() - 270, Color(255,255,255,255),0)
	--if client:GetNWString("PR_fraction") != "" then
	--	draw.SimpleText("LVL " .. client:GetNWString("PR_fraction") .. ": " ..client:GetNWInt("PR_level_" .. client:GetNWString("PR_fraction")), "testgm_INFO_font", 325, ScrH() - 270, Color(255,255,255,255),2)
	--end

	--draw.SimpleText("EXP: " ..client:GetNWInt("PR_exp").. "" .."/" .. client:GetNWInt("PR_level")*100, "testgm_INFO_font", 15, ScrH() - 220, Color(255,255,255,255),0)
	--if client:GetNWString("PR_fraction") != "" then
	--	draw.SimpleText("EXP ".. client:GetNWString("PR_fraction") .. ": " ..client:GetNWInt("PR_exp_" .. client:GetNWString("PR_fraction")).. "" .."/" .. client:GetNWInt("PR_level_" .. client:GetNWString("PR_fraction"))*100, "testgm_INFO_font", 15, ScrH() - 170, Color(255,255,255,255),0)
	--end

	--[[ draw.RoundedBox(0,15, ScrH() - 330,275,320, Color(0,0,0,240))

	draw.RoundedBox(0,30, ScrH() - 320,245,2, Color(255,255,255,255))
	draw.SimpleText("FRACTION: " .. LocalPlayer():GetNWString("PR_Fraction"), "testgm_INFO_font", 150, ScrH() - 305, Color(255,255,255,255),1,1)
	draw.RoundedBox(0,30, ScrH() - 290,245,2, Color(255,255,255,255))

	draw.SimpleText(math.Round(client:GetNWInt("PR_money")).. "$", "testgm_INFO_font", 35, ScrH() - 270, Color(255,255,255,255),0,1)

	draw.SimpleText("LVL: " ..client:GetNWInt("PR_level"), "testgm_INFO_font", 35, ScrH() - 240, Color(255,255,255,255),0,1)
	draw.SimpleText("EXP: " ..client:GetNWInt("PR_exp").. "" .."/" .. client:GetNWInt("PR_level")*100, "testgm_INFO_font", 35, ScrH() - 210, Color(255,255,255,255),0,1)

	if client:GetNWString("PR_fraction") != "" then
		draw.SimpleText("LVL " .. client:GetNWString("PR_fraction") .. ": " ..client:GetNWInt("PR_level_" .. client:GetNWString("PR_fraction")), "testgm_INFO_font", 35, ScrH() - 180, Color(255,255,255,255),0,1)
		draw.SimpleText("EXP ".. client:GetNWString("PR_fraction") .. ": " ..client:GetNWInt("PR_exp_" .. client:GetNWString("PR_fraction")).. "" .."/" .. client:GetNWInt("PR_level_" .. client:GetNWString("PR_fraction"))*100, "testgm_INFO_font", 35, ScrH() - 150, Color(255,255,255,255),0,1)
	end ]]

	--draw.SimpleText(math.Round(client:GetNWInt("PR_money")).. "$", "testgm_INFO_font", 35, ScrH() - 270, Color(255,255,255,255),0,1)
end

hook.Add("HUDPaint", "TestHud", HUD)

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudCrosshair"] = true,
	["CHudSuitPower"] = true,
	["CHudDeathNotice"] = true
}

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if (hide[name]) then
		return false
	end
end)

hook.Add("HUDDrawTargetID", "HidePlayerInfo", function()
	return false
end)