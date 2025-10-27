ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Category = "TestPR"

ENT.PrintName = "точка ануса"
ENT.Author = "Loh"
ENT.Contact = ""
ENT.Purpose = "zahvati"
ENT.Instructions = "ojko"
ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.BaseHealth = 1000000000

ENT.Model =  "models/props_wasteland/kitchen_counter001d.mdl"

ENT.CurPoint = "Point"
ENT.CaptureTeam = ""
ENT.UpgradeMonitor = 0
ENT.UpgradeComputer = 1

ENT.img = ""

ENT.GuardianCount = 0
ENT.MaxGuardianCount = 5

if CLIENT then
    ENT.Money = 0
    ENT.Delay = 0
end

if SERVER then
    util.AddNetworkString("SkamKazino")

    net.Receive("SkamKazino", function(len, ply)
        local money = net.ReadInt(32)

        ply:SetNWInt("PR_money", ply:GetNWInt("PR_money") + money)
    end)
end
