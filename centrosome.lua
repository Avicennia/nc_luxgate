
-- STRUCTURE NUMERIC SCHEMATICS


-- portal frame dimensions are 5x5, dash_pads are 3x3

--[[
	values for luxgate.numberframe table structure encoding
1 = max
2 = max_alt
3 = dash_pad
]]

luxgate.numberframe = {
	{1,2,2,2,1,2,9,9,9,2,2,9,2,9,2,2,9,9,9,2,1,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,5,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,8,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,5,0,5,3,0,0,0,0,0,0,0,0,0,0},
	
	{1,2,2,2,1,2,9,9,9,2,2,9,2,9,2,2,9,9,9,2,1,2,2,2,1,0,0,0,0,0,0,0,5,0,0,0,0,4,0,0,0,0,5,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,3,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,3,0,0,0,0,5,0,0,0,0,0,0,0,0,0,5,0,0,0,0,3,0,0},
	
	{2,2,2,2,4,2,2,2,2,0,0,0,0,8,0,0,0,0}
}

nodecore.register_craft({
    label = "heat ilmenite and irreversibly destroy polarity",
    action = "cook",
    touchgroups = {flame = 1},
    duration = 10,
    cookfx = true,
    nodes = {
        {
            match = {groups = {paramag = true}},
            replace = "nc_terrain:stone"
        }
    }
})
nodecore.register_craft({
    label = "forge ilmenite block",
    action = "pummel",
    toolgroups = {thumpy = 1},
    nodes = {
        {
            match = {name = "nc_luxgate:shard_ilmenite", count = 8},
            replace = "air"
        }
    },
    items = {
        "nc_luxgate:block_ilmenite"
    }
})

nodecore.register_craft({
	label = "carbonize node",
	action = "pummel",
	pumparticles = {
		minsize = 0.8,
		maxsize = 1,
		forcetexture = "nc_writing_del.png"
	},
	duration = 0.5,
	wield = {name = "nc_fire:lump_coal", count = 6},
	consumewield = 6,
	check = function(pos, data)

		return minetest.get_node(data.pointed.under).name == "nc_luxgate:block_ilmenite"
	
	end,
	nodes = {{match = {walkable = true}}},
	after = function(pos, data)
			
			return minetest.set_node(data.pointed.under, {name = "nc_luxgate:ulvstone"})
	end
})

nodecore.register_craft({
	label = "invoke gate",
	action = "pummel",
	pumparticles = {
		minsize = 0.6,
		maxsize = 0.8,
		forcetexture = "nc_writing_geq.png"
	},
	duration = 4,
	wield = {name = "nc_luxgate:shard_ilmenite"},
	consumewield = 1,
	check = function(pos,data)
		
		return minetest.get_node(data.pointed.under).name == "nc_luxgate:block_ilmenite"
	end,
	nodes = {{match = {name = "nc_luxgate:block_ilmenite"}}},
	after = function(pos, data)
		
		local pos = data.pointed.under
		local tab = "";
		local chainpairs;
		
		if(pos)then

			local structure = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},"group:ulv")
			tab = tab .. #structure
			structure = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},"group:paramag")
			tab = tab .. #structure
			structure = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},"group:lux_emit")
			tab = tab .. #structure

			chainpairs = {{{x = pos.x - 2, y = pos.y + 1, z = pos.z},{x = pos.x - 1, y = pos.y + 1, z = pos.z - 2}},
                            {{x = pos.x - 1, y = pos.y + 1, z = pos.z - 2},{x = pos.x + 1, y = pos.y + 1, z = pos.z - 2}},
                            {{x = pos.x + 1, y = pos.y + 1, z = pos.z - 2},{x = pos.x + 2, y = pos.y + 1, z = pos.z}},
                            {{x = pos.x + 2, y = pos.y + 1, z = pos.z},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 2}},
                            {{x = pos.x + 1, y = pos.y + 1, z = pos.z + 2},{x = pos.x - 1, y = pos.y + 1, z = pos.z + 2}},
                            {{x = pos.x - 1, y = pos.y + 1, z = pos.z + 2},{x = pos.x - 2, y = pos.y + 1, z = pos.z}},
                        }       
		else end

	if(tab == "1350")then
			
        	for n=1, #chainpairs, 1 do
        	luxgate.particles.darkchain(chainpairs[n][1],chainpairs[n][2])
			end

			local structure = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y, z = pos.z - 1},{x = pos.x + 1, y = pos.y, z = pos.z + 1},"group:luxg")
			
			for n = 1, #structure, 1 do
			minetest.remove_node(structure[n])
			end
			
			minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}, luxgate.schem.pad, _,_,true)
			
			local lam = minetest.find_node_near(pos,2,"nc_luxgate:frame_lam", true)	
			
			if(lam.y)then
				lam.y = lam.y + 1
				minetest.remove.node(lam)
				minetest.set_node(lam,{name = "nc_luxgate:vessicle"})
				lam.y = lam.y - 1
				minetest.remove.node(lam)
				minetest.set_node(lam,{name = "nc_luxgate:frame_lam"})
			else end
		
			return 
	elseif(tab == "1332")then
			
			
		for n=1, #chainpairs, 1 do
			
			luxgate.particles.darkchain(chainpairs[n][1],chainpairs[n][2])
			
		end

			
		minetest.after(5, function()

			local structure = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y, z = pos.z - 1},{x = pos.x + 1, y = pos.y, z = pos.z + 1},"group:luxg")
			local luxy = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},"group:lux_emit")
			local dir = vector.direction(luxy[1],luxy[2])

			--luxgate.log(minetest.serialize(dir))

				if(dir and dir.x ~= 0)then
					dir = true
				elseif(dir and dir.z ~= 0)then
					dir = false
				else end

			for n = 1, #structure, 1 do
				minetest.remove_node(structure[n])
			end

				if(dir == true)then
					minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3}, luxgate.schem.gate1, _,_,true)
				elseif(dir == false)then
					minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3}, luxgate.schem.gate2, _,_,true)
				else end
		
		return end)
	
	else end

end
})





--			SCHEMATICS			--
local n1 = { name = "air", prob = 0 }
local n2 = { name = "nc_luxgate:ulvstone_i" }
local n3 = { name = "nc_luxgate:ulvstone" }
local n5 = { name = "nc_luxgate:frame_ohm" }
local n6 = { name = "nc_luxgate:frame_e", param2 = 2 }
local n7 = { name = "nc_luxgate:ulvstone_c", param2 = 24 }
local n8 = { name = "nc_luxgate:ulvstone_c", param2 = 23 }
local n9 = { name = "nc_luxgate:ulvstone_c", param2 = 27 }
local n10 = { name = "nc_luxgate:frame_v", param2 = 9 }
local n11 = { name = "nc_luxgate:frame_v", param2 = 7 }
local n12 = { name = "nc_luxgate:ulvstone_c", param2 = 22 }
local n13 = { name = "nc_luxgate:ulvstone_c", param2 = 84 }
local n14 = { name = "nc_luxgate:frame_lam" }
local n15 = { name = "nc_luxgate:vessicleNull" }
local n16 = { name = "nc_luxgate:ulvstone_c", param2 = 25 }
local n17 = { name = "nc_luxgate:ulvstone_c", param2 = 21 }
local n18 = { name = "nc_luxgate:ulvstone_c", param2 = 26 }
local n19 = { name = "nc_luxgate:frame_e" }

luxgate.schem.gate2 =	{
	size = {
		y = 5,
		x = 7,
		z = 7
	}
,
	data = {
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n2, n3, n3, n3, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n5, n1, n1, n1, n1, n1, n1, n6, n1, n1, n1, n1, n1, n1, n5, n1, 
n1, n1, n1, n3, n7, n8, n9, n3, n1, n1, n1, n1, n10, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n11, 
n1, n1, n1, n1, n3, n12, n3, n13, n3, n1, n1, n1, n1, n14, n1, n1, 
n1, n1, n1, n1, n15, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n3, n16, n17, n18, n3, n1, n1, n1, n1, n11, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n10, n1, n1, n1, n1, n2, n3, n3, n3, n2, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n5, n1, n1, n1, n1, n1, n1, n19, n1, n1, 
n1, n1, n1, n1, n5, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, 

}
}

local n1 = { name = "air", prob = 0 }
local n2 = { name = "nc_luxgate:ulvstone_i" }
local n3 = { name = "nc_luxgate:ulvstone" }
local n5 = { name = "nc_luxgate:ulvstone_c", param2 = 24 }
local n6 = { name = "nc_luxgate:ulvstone_c", param2 = 23 }
local n7 = { name = "nc_luxgate:ulvstone_c", param2 = 27 }
local n8 = { name = "nc_luxgate:ulvstone_c", param2 = 22 }
local n9 = { name = "nc_luxgate:ulvstone_c", param2 = 52 }
local n10 = { name = "nc_luxgate:frame_v", param2 = 18 }
local n11 = { name = "nc_luxgate:frame_lam" }
local n12 = { name = "nc_luxgate:frame_v", param2 = 12 }
local n13 = { name = "nc_luxgate:frame_ohm" }
local n14 = { name = "nc_luxgate:vessicleNull" }
local n15 = { name = "nc_luxgate:frame_e", param2 = 3 }
local n16 = { name = "nc_luxgate:frame_e", param2 = 1 }
local n17 = { name = "nc_luxgate:ulvstone_c", param2 = 25 }
local n18 = { name = "nc_luxgate:ulvstone_c", param2 = 21 }
local n19 = { name = "nc_luxgate:ulvstone_c", param2 = 26 }

luxgate.schem.gate1 = {

	size = {
		y = 5,
		x = 7,
		z = 7
	}
,
	data = {
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n2, n3, n3, n3, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n3, n5, n6, n7, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n3, n8, n3, n9, n3, n1, n1, n1, n10, n11, n12, n1, 
n1, n1, n13, n1, n14, n1, n13, n1, n1, n15, n1, n1, n1, n16, n1, n1, 
n13, n12, n1, n10, n13, n1, n1, n3, n17, n18, n19, n3, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n3, n3, n3, n2, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 

}
}

