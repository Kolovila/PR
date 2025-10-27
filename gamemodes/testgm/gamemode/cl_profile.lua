function PR_Show_Stats()
    local ply = LocalPlayer()

    PR_Panels.ProfileBackGround = vgui.Create("DPanel", MainMenu)
    PR_Panels.ProfileBackGround:SetPos(100, 26)
    PR_Panels.ProfileBackGround:SetSize(1100, 775)
    PR_Panels.ProfileBackGround:SetText("")
    PR_Panels.ProfileBackGround.Paint = function()
        surface.SetDrawColor(0,0,0,0)
        surface.DrawRect(0,0, PR_Panels.ProfileBackGround:GetWide(), PR_Panels.ProfileBackGround:GetTall())
    end

    local function PR_CrateProfileLabel(text, x, y)
        surface.SetFont( "testgm_INFO_font" )
        local textWidth, textHeight = surface.GetTextSize( text )

        local DLabel = vgui.Create( "DLabel", PR_Panels.ProfileBackGround )
        DLabel:SetPos( x, y )
        DLabel:SetFont("testgm_INFO_font")
        DLabel:SetSize(textWidth + 15, textHeight)
        DLabel:SetText(" " .. text)

        DLabel.Paint = function()
            surface.SetDrawColor(0,0,0,220)
            surface.DrawRect(0,0, DLabel:GetWide(), DLabel:GetTall())

            draw.RoundedBox(0, 0, 0, DLabel:GetWide(), 1, Color(255,255,255,255)) -- верхушка

            draw.RoundedBox(0, 0, 0, 1, DLabel:GetTall(), Color(255,255,255,255)) -- левушка

            draw.RoundedBox(0, DLabel:GetWide() - 1, 0, 1, DLabel:GetTall(), Color(255,255,255,255)) -- правушка

            draw.RoundedBox(0, 0, DLabel:GetTall() - 1, DLabel:GetWide(), 1, Color(255,255,255,255)) -- низушка
        end

        return DLabel
    end

    local frac = PR_CrateProfileLabel("FRACTION: " .. ply:GetNWString("PR_Fraction"), 40, 40)

    local flag = vgui.Create("DImage", PR_Panels.ProfileBackGround)
    flag:SetSize(50, 30)
    flag:SetPos(40 + frac:GetWide() + 5, 40)
    flag:SetImage("test_gm_mat/flags/" .. ply:GetNWString("PR_Fraction") .. ".png")

    PR_CrateProfileLabel(math.Round(ply:GetNWInt("PR_money")).. "$", 40 , 100)

    PR_CrateProfileLabel("LVL: " ..ply:GetNWInt("PR_level"), 40 , 160)

    PR_CrateProfileLabel("EXP: " ..ply:GetNWInt("PR_exp").. "" .."/" .. ply:GetNWInt("PR_level")*100, 40 , 220)

    PR_CrateProfileLabel("LVL " .. ply:GetNWString("PR_fraction") .. ": " ..ply:GetNWInt("PR_level_" .. ply:GetNWString("PR_fraction")), 40 , 280)

    PR_CrateProfileLabel("EXP ".. ply:GetNWString("PR_fraction") .. ": " ..ply:GetNWInt("PR_exp_" .. ply:GetNWString("PR_fraction")).. "" .."/" .. ply:GetNWInt("PR_level_" .. ply:GetNWString("PR_fraction"))*100, 40 , 340)

    PR_CrateProfileLabel(ply:GetNWInt("MPcoin").. "©", 40 , 400)
end