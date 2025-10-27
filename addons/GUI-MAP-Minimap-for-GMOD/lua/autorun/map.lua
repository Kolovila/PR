if not MAP then   
    MAP = {}
end

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("SendMAPSize")
	util.AddNetworkString("RequestMAPSize")

	function CalculateSize(na, size, nb, x, y, z, try)
		local res
		local End = 0

		for i = na, size, nb do
			if util.IsInWorld(Vector(x or i, y or i, z or i)) and End < try then
				res = i

				if End > 0 then
					End = 0
				end
			else
				End = End + 1

				if End >= try then
					break
				end
			end
		end
        return res
	end

	function GetMapSize()
		local nb = 45
		local try = 3
		local size = 99999999


		for k, v in pairs(ents.GetAll()) do
			if string.find(v:GetClass(), "info_player_") then
				MAP.SizeHeight = CalculateSize(v:GetPos().z, size, nb, v:GetPos().x, v:GetPos().y, nil, try)

				MAP.SizeN = CalculateSize(v:GetPos().y, size, nb, v:GetPos().x, nil, MAP.SizeHeight, try)
				MAP.SizeW = CalculateSize(v:GetPos().x, -size, -nb, nil, v:GetPos().y, MAP.SizeHeight, try)
				MAP.SizeS = CalculateSize(v:GetPos().y, -size, -nb, v:GetPos().x, nil, MAP.SizeHeight, try)
				MAP.SizeE = CalculateSize(v:GetPos().x, size, nb, nil, v:GetPos().y, MAP.SizeHeight, try)
                
                MAP.SizeHeight = math.Round(MAP.SizeHeight) + 128
				MAP.SizeN = math.Round(MAP.SizeN) - 64
				MAP.SizeW = math.Round(MAP.SizeW) + 64
				MAP.SizeS = math.Round(MAP.SizeS) + 64
				MAP.SizeE = math.Round(MAP.SizeE) - 64

				MAP.SizeX = MAP.SizeE + math.abs(MAP.SizeW)
				MAP.SizeY = MAP.SizeN + math.abs(MAP.SizeS)

				MAP.SizeX = math.abs(MAP.SizeX)
				MAP.SizeY = math.abs(MAP.SizeY)
			end
		end

		return MAP
	end

	net.Receive("RequestMAPSize", function(len, ply)
		net.Start("SendMAPSize")
		net.WriteTable(GetMapSize())
		net.Send(ply)
	end)
end

if CLIENT then

CreateClientConVar("cl_point_r", 0, true, false)
CreateClientConVar("cl_point_g", 174, true, false)
CreateClientConVar("cl_point_b", 222, true, false)

CreateClientConVar("cl_friendpoint_r", 25, true, false)
CreateClientConVar("cl_friendpoint_g", 184, true, false)
CreateClientConVar("cl_friendpoint_b", 11, true, false)

CreateClientConVar("cl_map_displayfriends", 1, true, false)

surface.CreateFont("MapFont1", {
	font = "DermaLarge",
	weight = 600,
	size = 14,
})

surface.CreateFont("MapFont2", {
	font = "Trebuchet24",
	weight = 600,
	size = 30,
})

	function RequestMAPSize()
		net.Start("RequestMAPSize")
		net.SendToServer()
	end

	net.Receive("SendMAPSize", function()
		local tbl = net.ReadTable()

		MAP = tbl

	end)
    
    if not map then
        local map
    end
	
    function test_gm_OpenMap()
    	if IsValid(map) then
    		map:Remove()
    	else
		local colorr, colorg, colorb = GetConVarNumber("cl_point_r"), GetConVarNumber("cl_point_g"), GetConVarNumber("cl_point_b")
		local fcolorr, fcolorg, fcolorb = GetConVarNumber("cl_friendpoint_r"), GetConVarNumber("cl_friendpoint_g"), GetConVarNumber("cl_friendpoint_b")
		RequestMAPSize()

		map = vgui.Create("DPanel")
		--map:SetParent(MainMenu)
		map:SetSize(756, 756)
		map:SetPos(ScrW()/2 - map:GetWide()/2, ScrH()/2 - map:GetTall()/2)

		map.Paint = function(self)
			draw.RoundedBox(3, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 200))
            
                --if file.Exists("materials/test_gm_mat/rp_desert_conflict.jpg", "DATA") then
            	    surface.SetDrawColor(255, 255, 255, 255)
            	    surface.SetMaterial(Material("materials/test_gm_mat/rp_desert_conflict.png"))
            	    surface.DrawTexturedRect(0, 0, self:GetWide(), self:GetTall())
            	    if not MAP.SizeHeight or not MAP.SizeW or not MAP.SizeE or not MAP.SizeS or not MAP.SizeN then 
            	    	RequestMAPSize()
            	    	return
            	    end
                    
                    if MAP.SizeS > 0 then
                		a = LocalPlayer():GetPos().y + MAP.SizeN
                    else
                	    a = LocalPlayer():GetPos().y - MAP.SizeS
                    end
                    if MAP.SizeW > 0 then
                        b = LocalPlayer():GetPos().x + MAP.SizeE
                    else
                	    b = LocalPlayer():GetPos().x - MAP.SizeW
                    end

                    local numa = 750
                    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ) - 8, self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 10, 12, 4, Color(0, 0, 0, 255))
            	    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ) - 4, self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 6, 4, 12, Color(0, 0, 0, 255))

            	    draw.RoundedBox(100, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ), self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) - 5, 8, 8, Color(255, 0, 0, 255))
            	    --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ) - 4, self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 6, 3, 11, Color(colorr, colorg, colorb, 255))
            	    --draw.SimpleText(string.sub(LocalPlayer():Nick(), 1, 8),  "MapFont1", math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide()) + 1, 
            	    	--self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 11, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)  
            	    draw.SimpleText(string.sub(LocalPlayer():Nick(), 1, 8),  "MapFont1", math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide()), 
            	    	self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 5, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
            	    if tobool(GetConVarNumber("cl_map_displayfriends")) then
            	    	for _, pl in pairs(player.GetAll()) do
            	    		if pl != LocalPlayer() and pl:GetNWString("PR_fraction") == LocalPlayer():GetNWString("PR_fraction") then
            	    			if MAP.SizeS > 0 then
                                	a = pl:GetPos().y + MAP.SizeN
                                else
                	                a = pl:GetPos().y - MAP.SizeS
                                end
                                if MAP.SizeW > 0 then
                                    b = pl:GetPos().x + MAP.SizeE
                                else
                	                b = pl:GetPos().x - MAP.SizeW
                                end

                                local numa = ScrH() * 0.7
                                --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ) - 5, self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()), 12, 4, Color(0, 0, 0, 255))
            	                --draw.RoundedBox(0, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ) - 1, self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) - 4, 4, 12, Color(0, 0, 0, 255))

            	                draw.RoundedBox(100, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ), self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) - 5, 8, 8, Color(0, 255, 0, 255))
            	                --draw.RoundedBox(100, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ) - 1, self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) - 4, 3, 11, Color(fcolorr, fcolorg, fcolorb, 255))
            	                draw.SimpleText(string.sub(pl:Nick(), 1, 8),  "MapFont1", math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide()) + 1, 
            	                	self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 5, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER)  
            	                --draw.SimpleText(string.sub(pl:Nick(), 1, 8),  "MapFont1", math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide()), 
            	                --	self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 10, Color(fcolorr, fcolorg, fcolorb, 255), TEXT_ALIGN_CENTER)	
            	    		end
            	    	end
            	    	for _, point in pairs(ents.GetAll()) do
							if point:GetClass() == "zahvat_ojka" then
								if MAP.SizeS > 0 then
									a = point:GetPos().y + MAP.SizeN
								else
									a = point:GetPos().y - MAP.SizeS
								end
								if MAP.SizeW > 0 then
									b = point:GetPos().x + MAP.SizeE
								else
									b = point:GetPos().x - MAP.SizeW
								end

								local numa = ScrH() * 0.7

								local flag_point = point.CaptureTeam

								if point.img == "" or not point.img:IsValid() then
									point.img = vgui.Create("DImage", map)
									point.img:SetSize(32, 32)
								else
									point.img:SetPos(math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ), self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) - 5)
									point.img:SetImage("test_gm_mat/mini_flags/" .. string.lower(flag_point) .. ".png")

									--draw.RoundedBox(100, math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide() ), self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) - 5, 8, 8, Color(0, 255, 0, 255))
									--draw.SimpleText(flag_point,  "MapFont1", math.Clamp(b/MAP.SizeX * numa, 0, self:GetWide()) + 10, 
									--	self:GetTall() - math.Clamp(a/MAP.SizeY * numa, 0, self:GetTall()) + 25, Color(0, 0, 255, 255), TEXT_ALIGN_CENTER)
								end
							end
            	    	end
            	    end
                --else
            	    --RebuildMapImage(self:GetWide() , self:GetTall())
                --end


		    end

		    map.OnRemove = function(self)
			    if IsValid(tools) then
			    	tools:Remove()
			    end

			    if IsValid(buddypanel) then
			    	buddypanel:Remove()
			    end
		    end
		end
    end
    
    concommand.Add("openmap", test_gm_OpenMap)

	function RebuildMapImage(w, h)
		RequestMAPSize()

		if not MAP.SizeHeight or not MAP.SizeW or not MAP.SizeE or not MAP.SizeS or not MAP.SizeN then return end
		
		if not file.IsDir("mapimages", "DATA") then
			file.CreateDir("mapimages")
		end
		local data = {
			angles = Angle(90, 90, 0),
			origin = Vector(0, 0, MAP.SizeHeight * 0.8),
			x = 0,
			y = 0,
			w = w,
			h = h,
			bloomtone = false,
			drawviewmodel = false,
			ortho = true,
			ortholeft = MAP.SizeW,
			orthoright = MAP.SizeE,
			orthotop = MAP.SizeS,
			orthobottom =  MAP.SizeN 
		}

		render.ClearStencil()
		render.SetStencilEnable(true)

		render.SetStencilWriteMask(255)
		render.SetStencilTestMask(255)
		render.SetStencilReferenceValue(255)
		render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
		render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)

		render.SuppressEngineLighting(true)
		render.SetColorModulation(0, 1, 0)
		render.SetBlend(0.4)

		render.RenderView(data)


           local tbl = render.Capture({
			format = "jpeg",
			quality = 100,
			w = w, 
			h = h,
			x = 0,
			y = 0
		})

		render.SuppressEngineLighting(false)
		render.SetColorModulation(1, 1, 1)
		render.SetBlend(1)

		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilEnable(false)
		local image = file.Open("mapimages/"..game.GetMap()..w.."x"..h..".jpg", "wb", "DATA")
		image:Write(tbl)
		image:Close()



	end
end
