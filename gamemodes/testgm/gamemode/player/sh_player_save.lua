if SERVER then
    util.AddNetworkString("PurchasedTable")
end

if CLIENT then
    net.Receive("PurchasedTable", function()
        PR_PurchasedModels = net.ReadTable()
        PR_PurchasedWeapons = net.ReadTable()
        PR_Preset = net.ReadTable()
        --PrintTable(ply.PurchasedModels)
        --print(ply)
        --print("------------------------------------------------------------------------------------")
    end)
end

    local Save_List = Save_List or {}

    function PR_Save_Player(ply)
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        if not file.Exists( "pr_gamemode/players.txt", "DATA" ) then
            file.Write("pr_gamemode/players.txt")
        end

        local SaveData = file.Read("pr_gamemode/players.txt", "DATA")
        Save_List = util.JSONToTable(SaveData) or {}

        Save_List[ply:Nick()] = Save_List[ply:Nick()] or {}

        Save_List[ply:Nick()] = {
            ["Money"] = ply:GetNWInt("PR_money"),
            ["Exp"] = ply:GetNWInt("PR_exp"),
            ["Coin"] = ply:GetNWInt("PR_coin"),
            ["Level"] = ply:GetNWInt("PR_level"),
            ["Fraction"] = ply:GetNWString("PR_fraction"),
            ["Admin"] = ply:GetNWBool("PR_admin"),

            ["Kills"] = ply:GetNWInt("PR_kills"),
            ["Kills_Npc"] = ply:GetNWInt("PR_kills_npc"),
            ["Deaths"] = ply:GetNWInt("PR_deaths"),

            ["PurchasedModels"] = ply.PurchasedModels,

            ["PurchasedWeapons"] = ply.PurchasedWeapons,

            ["Preset"] = ply.Preset,

            ["Money_SSNK"]=ply:GetNWInt("PR_money_SSNK"),
            ["Exp_SSNK"]=ply:GetNWInt("PR_exp_SSNK"),
            ["Level_SSNK"]=ply:GetNWInt("PR_level_SSNK"),
            ["Weapon_exp_SSNK"]=ply:GetNWInt("PR_weapon_exp_SSNK"),
            ["Leader_SSNK"]=ply:GetNWBool("PR_leader_SSNK"),
            
            ["Money_USA"]=ply:GetNWInt("PR_money_USA"),
            ["Exp_USA"]=ply:GetNWInt("PR_exp_USA"),
            ["Level_USA"]=ply:GetNWInt("PR_level_USA"),
            ["Weapon_exp_USA"]=ply:GetNWInt("PR_weapon_exp_USA"),
            ["Leader_USA"]=ply:GetNWBool("PR_leader_USA"),
            
            ["Money_GBC"]=ply:GetNWInt("PR_money_GBC"),
            ["Exp_GBC"]=ply:GetNWInt("PR_exp_GBC"),
            ["Level_GBC"]=ply:GetNWInt("PR_level_GBC"),
            ["Weapon_exp_GBC"]=ply:GetNWInt("PR_weapon_exp_GBC"),
            ["Leader_GBC"]=ply:GetNWBool("PR_leader_GBC"),
            
            ["Money_WN"]=ply:GetNWInt("PR_money_WN"),
            ["Exp_WN"]=ply:GetNWInt("PR_exp_WN"),
            ["Level_WN"]=ply:GetNWInt("PR_level_WN"),
            ["Weapon_exp_WN"]=ply:GetNWInt("PR_weapon_exp_WN"),
            ["Leader_WN"]=ply:GetNWBool("PR_leader_WN")
        }

        file.Write("pr_gamemode/players.txt", util.TableToJSON(Save_List, true))
    end

    function PR_Load_Player(ply)
        if not file.Exists("pr_gamemode", "DATA") then
            file.CreateDir("pr_gamemode")
        end

        if not file.Exists( "pr_gamemode/players.txt", "DATA" ) then
            file.Write("pr_gamemode/players.txt")
        end

        local SaveData = file.Read("pr_gamemode/players.txt", "DATA")
        Save_List = util.JSONToTable(SaveData) or {}

        if not Save_List[ply:Nick()] then
            ply:SetNWInt("PR_money", 0)
            ply:SetNWInt("PR_exp", 0)
            ply:SetNWInt("PR_coin", 0)
            ply:SetNWInt("PR_level", 1)
            ply:SetNWString("PR_fraction", "")
            ply:SetNWBool("PR_admin", false)

            ply:SetNWInt("PR_kills", 0)
            ply:SetNWInt("PR_kills_npc", 0)
            ply:SetNWInt("PR_deaths", 0)

            ply.PurchasedModels = {}

            ply.PurchasedWeapons = {}

            ply.Preset = {}

            ply:SetNWInt("PR_money_SSNK", 0)
            ply:SetNWInt("PR_exp_SSNK", 0)
            ply:SetNWInt("PR_level_SSNK", 1)
            ply:SetNWInt("PR_weapon_exp_SSNK", 0)
            ply:SetNWBool("PR_leader_SSNK", false)

            ply:SetNWInt("PR_money_USA", 0)
            ply:SetNWInt("PR_exp_USA", 0)
            ply:SetNWInt("PR_level_USA", 1)
            ply:SetNWInt("PR_weapon_exp_USA", 0)
            ply:SetNWBool("PR_leader_USA", false)

            ply:SetNWInt("PR_money_GBC", 0)
            ply:SetNWInt("PR_exp_GBC", 0)
            ply:SetNWInt("PR_level_GBC", 1)
            ply:SetNWInt("PR_weapon_exp_GBC", 0)
            ply:SetNWBool("PR_leader_GBC", false)

            ply:SetNWInt("PR_money_WN", 0)
            ply:SetNWInt("PR_exp_WN", 0)
            ply:SetNWInt("PR_level_WN", 1)
            ply:SetNWInt("PR_weapon_exp_WN", 0)
            ply:SetNWBool("PR_leader_WN", false)

            Save_List[ply:Nick()] = Save_List[ply:Nick()] or {}

            Save_List[ply:Nick()] = {
                    ["Money"] = ply:GetNWInt("PR_money"),
                    ["Exp"] = ply:GetNWInt("PR_exp"),
                    ["Coin"] = ply:GetNWInt("PR_coin"),
                    ["Level"] = ply:GetNWInt("PR_level"),
                    ["Fraction"] = ply:GetNWString("PR_fraction"),
                    ["Admin"] = ply:GetNWBool("PR_admin"),

                    ["Kills"] = ply:GetNWInt("PR_kills"),
                    ["Kills_Npc"] = ply:GetNWInt("PR_kills_npc"),
                    ["Deaths"] = ply:GetNWInt("PR_deaths"),

                    ["PurchasedModels"] = ply.PurchasedModels,

                    ["PurchasedWeapons"] = ply.PurchasedWeapons,

                    ["Preset"] = ply.Preset,

                    ["Money_SSNK"]=ply:GetNWInt("PR_money_SSNK"),
                    ["Exp_SSNK"]=ply:GetNWInt("PR_exp_SSNK"),
                    ["Level_SSNK"]=ply:GetNWInt("PR_level_SSNK"),
                    ["Weapon_exp_SSNK"]=ply:GetNWInt("PR_weapon_exp_SSNK"),
                    ["Leader_SSNK"]=ply:GetNWBool("PR_leader_SSNK"),
                    
                    ["Money_USA"]=ply:GetNWInt("PR_money_USA"),
                    ["Exp_USA"]=ply:GetNWInt("PR_exp_USA"),
                    ["Level_USA"]=ply:GetNWInt("PR_level_USA"),
                    ["Weapon_exp_USA"]=ply:GetNWInt("PR_weapon_exp_USA"),
                    ["Leader_USA"]=ply:GetNWBool("PR_leader_USA"),
                    
                    ["Money_GBC"]=ply:GetNWInt("PR_money_GBC"),
                    ["Exp_GBC"]=ply:GetNWInt("PR_exp_GBC"),
                    ["Level_GBC"]=ply:GetNWInt("PR_level_GBC"),
                    ["Weapon_exp_GBC"]=ply:GetNWInt("PR_weapon_exp_GBC"),
                    ["Leader_GBC"]=ply:GetNWBool("PR_leader_GBC"),
                    
                    ["Money_WN"]=ply:GetNWInt("PR_money_WN"),
                    ["Exp_WN"]=ply:GetNWInt("PR_exp_WN"),
                    ["Level_WN"]=ply:GetNWInt("PR_level_WN"),
                    ["Weapon_exp_WN"]=ply:GetNWInt("PR_weapon_exp_WN"),
                    ["Leader_WN"]=ply:GetNWBool("PR_leader_WN")
            }

            file.Write("pr_gamemode/players.txt", util.TableToJSON(Save_List, true))
        else
            ply:SetNWInt("PR_money", Save_List[ply:Nick()]["Money"])
            ply:SetNWInt("PR_exp", Save_List[ply:Nick()]["Exp"])
            ply:SetNWInt("PR_coin", Save_List[ply:Nick()]["Coin"])
            ply:SetNWInt("PR_level", Save_List[ply:Nick()]["Level"])
            ply:SetNWString("PR_fraction", Save_List[ply:Nick()]["Fraction"])
            ply:SetNWBool("PR_admin", Save_List[ply:Nick()]["Admin"])

            ply:SetNWInt("PR_kills", Save_List[ply:Nick()]["Kills"])
            ply:SetNWInt("PR_kills_npc", Save_List[ply:Nick()]["Kills_Npc"])
            ply:SetNWInt("PR_deaths", Save_List[ply:Nick()]["Deaths"])

            ply.PurchasedModels = Save_List[ply:Nick()]["PurchasedModels"]

            ply.PurchasedWeapons = Save_List[ply:Nick()]["PurchasedWeapons"]

            ply.Preset = Save_List[ply:Nick()]["Preset"]
            
            if ply.PurchasedModels != nil or ply.PurchasedWeapons != nil or Preset != nil then
                net.Start("PurchasedTable")
                    net.WriteTable(ply.PurchasedModels)
                    net.WriteTable(ply.PurchasedWeapons)
                    net.WriteTable(ply.Preset)
                net.Send(ply)
            end

            ply:SetNWInt("PR_money_SSNK", Save_List[ply:Nick()]["Money_SSNK"])
            ply:SetNWInt("PR_exp_SSNK", Save_List[ply:Nick()]["Exp_SSNK"])
            ply:SetNWInt("PR_level_SSNK", Save_List[ply:Nick()]["Level_SSNK"])
            ply:SetNWInt("PR_weapon_exp_SSNK", Save_List[ply:Nick()]["Weapon_exp_SSNK"])
            ply:SetNWBool("PR_leader_SSNK", Save_List[ply:Nick()]["Leader_SSNK"])

            ply:SetNWInt("PR_money_USA", Save_List[ply:Nick()]["Money_USA"])
            ply:SetNWInt("PR_exp_USA", Save_List[ply:Nick()]["Exp_USA"])
            ply:SetNWInt("PR_level_USA", Save_List[ply:Nick()]["Level_USA"])
            ply:SetNWInt("PR_weapon_exp_USA", Save_List[ply:Nick()]["Weapon_exp_USA"])
            ply:SetNWBool("PR_leader_USA", Save_List[ply:Nick()]["Leader_USA"])

            ply:SetNWInt("PR_money_GBC", Save_List[ply:Nick()]["Money_GBC"])
            ply:SetNWInt("PR_exp_GBC", Save_List[ply:Nick()]["Exp_GBC"])
            ply:SetNWInt("PR_level_GBC", Save_List[ply:Nick()]["Level_GBC"])
            ply:SetNWInt("PR_weapon_exp_GBC", Save_List[ply:Nick()]["Weapon_exp_GBC"])
            ply:SetNWBool("PR_leader_GBC", Save_List[ply:Nick()]["Leader_GBC"])

            ply:SetNWInt("PR_money_WN", Save_List[ply:Nick()]["Money_WN"])
            ply:SetNWInt("PR_exp_WN", Save_List[ply:Nick()]["Exp_WN"])
            ply:SetNWInt("PR_level_WN", Save_List[ply:Nick()]["Level_WN"])
            ply:SetNWInt("PR_weapon_exp_WN", Save_List[ply:Nick()]["Weapon_exp_WN"])
            ply:SetNWBool("PR_leader_WN", Save_List[ply:Nick()]["Leader_WN"])
        end
        
    end

    if SERVER then
        hook.Add("PlayerInitialSpawn", "loadniggerdata", PR_Load_Player)
        hook.Add("PlayerDisconnected", "saveniggerdata", PR_Save_Player)
    end
--end