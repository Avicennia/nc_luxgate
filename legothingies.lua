
-- STRUCTURE NUMERIC SCHEMATICS


-- portal frame dimensions are 5x5, ranvier_pads are 3x3

--[[
	values for luxgate.numberframe table structure encoding
1 = max
2 = max_alt
3 = ranvier_pad
]]
luxgate.numberframe = {
	{1,2,10,2,1,2,9,9,9,2,10,9,10,9,10,2,9,9,9,2,1,2,10,2,1,0,0,0,0,0,0,0,0,0,0,0,5,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,8,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,5,0,5,3,0,0,0,0,0,0,0,0,0,0},
	{1,2,10,2,1,2,9,9,9,2,10,9,10,9,10,2,9,9,9,2,1,2,10,2,1,0,0,0,0,0,0,0,5,0,0,0,0,4,0,0,0,0,5,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,3,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,3,0,0,0,0,5,0,0,0,0,0,0,0,0,0,5,0,0,0,0,3,0,0},
	{1,1,1,1,4,1,1,1,1,0,0,0,0,8,0,0,0,0}
}


nodecore.register_craft({
	label = "carbonize node",
	action = "pummel",
	pumparticles = {
		minsize = 0.8,
		maxsize = 1,
		forcetexture = "nc_writing_del.png"
	},
	duration = 6,
	wield = {name = "nc_fire:lump_coal", count = 8},
	consumewield = 8,
	check = function(pos, data)
		return minetest.get_node(data.pointed.under).name == "nc_luxgate:block_ilmenite_inv"
	end,
	nodes = {{match = {walkable = true}}},
	after = function(pos, data)
			return minetest.set_node(data.pointed.under, {
			name = "nc_luxgate:ulvstone"})
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
	duration = 5,
	wield = {name = "nc_luxgate:shard_ilmenite", count = 1},
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
			minetest.chat_send_all(tab)
			
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
			else end
		return minetest.set_node(lam,{name = "nc_luxgate:vessicle"})
		elseif(tab == "1332")then
			minetest.chat_send_all(tab)
			
        	for n=1, #chainpairs, 1 do
        	luxgate.particles.darkchain(chainpairs[n][1],chainpairs[n][2])
			end

			
			minetest.after(5, function()

				local structure = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y, z = pos.z - 1},{x = pos.x + 1, y = pos.y, z = pos.z + 1},"group:luxg")
				local luxy = minetest.find_nodes_in_area({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},"group:lux_emit")
				local dir = vector.direction(luxy[1],luxy[2])
				minetest.chat_send_all(minetest.serialize(dir))
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
				else minetest.chat_send_all("WRONG") 
				end
			
			local lam = minetest.find_node_near(pos,2,"nc_luxgate:frame_lam", true)	
			if(lam.y)then
				lam.y = lam.y + 1
			else end
		return minetest.set_node(lam,{name = "nc_luxgate:vessicle"})end)
	else minetest.chat_send_all(tab) end
	end
})





--			SCHEMATICS			--
n1 = { name = "air", prob = 0 }
n2 = { name = "nc_lode:block_annealed" }
n3 = { name = "nc_lode:block_tempered" }
n4 = { name = "nc_luxgate:block_ilmenite_inv" }
n5 = { name = "nc_luxgate:block_ilmenite" }
n6 = { name = "nc_luxgate:frame_v", param2 = 18 }
n7 = { name = "nc_luxgate:frame_lam" }
n8 = { name = "nc_luxgate:frame_v", param2 = 12 }
n9 = { name = "nc_luxgate:frame_ohm" }
n10 = { name = "nc_luxgate:vessicle" }
n11 = { name = "nc_luxgate:frame_e", param2 = 3 }
n12 = { name = "nc_luxgate:frame_e", param2 = 1 }

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
n1, n1, n2, n3, n4, n3, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n3, n5, n5, n5, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n4, n5, n4, n5, n4, n1, n1, n1, n6, n7, n8, n1, n1, 
n1, n9, n1, n10, n1, n9, n1, n1, n11, n1, n1, n1, n12, n1, n1, n9, 
n8, n1, n6, n9, n1, n1, n3, n5, n5, n5, n3, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n2, n3, n4, n3, n2, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, 

}
}

n1 = { name = "air", prob = 0 }
n2 = { name = "nc_lode:block_annealed" }
n3 = { name = "nc_lode:block_tempered" }
n4 = { name = "nc_luxgate:block_ilmenite_inv" }
n5 = { name = "nc_luxgate:frame_ohm" }
n6 = { name = "nc_luxgate:frame_e", param2 = 2 }
n7 = { name = "nc_luxgate:block_ilmenite" }
n8 = { name = "nc_luxgate:frame_v", param2 = 9 }
n9 = { name = "nc_luxgate:frame_v", param2 = 7 }
n10 = { name = "nc_luxgate:frame_lam" }
n11 = { name = "nc_luxgate:vessicle" }
n12 = { name = "nc_luxgate:frame_e" }

luxgate.schem.gate2 = {
	size = {
		y = 5,
		x = 7,
		z = 7
	}
,
	data = {
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n2, n3, n4, n3, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n5, n1, n1, n1, n1, n1, n1, n6, n1, n1, n1, n1, n1, n1, n5, n1, 
n1, n1, n1, n3, n7, n7, n7, n3, n1, n1, n1, n1, n8, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n9, 
n1, n1, n1, n1, n4, n7, n4, n7, n4, n1, n1, n1, n1, n10, n1, n1, n1, 
n1, n1, n1, n11, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n3, n7, n7, n7, n3, n1, n1, n1, n1, n9, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n8, n1, n1, n1, n1, n2, n3, n4, n3, n2, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n5, n1, n1, n1, n1, n1, n1, n12, n1, n1, n1, n1, 
n1, n1, n5, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, 

}
}

n1 = { name = "air", prob = 0 }
n2 = { name = "nc_lode:block_annealed" }
n3 = { name = "nc_luxgate:frame_lam" }
n4 = { name = "nc_luxgate:vessicle" }

luxgate.schem.pad = {
	size = {
		y = 3,
		x = 5,
		z = 5
	}
,
data = {
	n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, 
	n2, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n3, n2, 
	n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, n2, n1, n1, 
	n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
	n1, n1, n1, n1, n1, n1, n1, 
}
}

local ss = {
    initial_properties = {
        hp_max = 1,
        physical = true,
        collide_with_objects = false,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
		visual = "wielditem",
        visual_size = {x = 0.8, y = 1},
        textures = {"nc_luxgate:crystal"},
        spritediv = {x = 1, y = 1},
		initial_sprite_basepos = {x = 0, y = 0},
		
		
	},
	on_punch = function(self, puncher)
		local pdir = puncher:get_look_dir()
		self.object:set_rotation(pdir)
		minetest.chat_send_all(minetest.serialize(self.object:get_rotation()))
		self.object:set_nametag_attributes({text = "WhenMeaningFallsInSplinters", color =  {a=250, r=250, g=250, b=255}})
		
		if(puncher:get_player_control().sneak == true)then
			return self.object:remove()
			 else end	
	end,
	}
	minetest.register_entity("nc_luxgate:icelandspar", ss)