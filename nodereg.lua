minetest.register_node("nc_luxgate:astrolabe",{
    description = "Box thing",
    drawtype = "mesh",
    tiles = {"nc_lode_annealed.png"},
    mesh = "director.b3d",
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 1,
    on_punch = function(pos,node,puncher)
        --minetest.chat_send_all(luxgate.core.whosthere(pos))
    
    if(puncher:get_player_control().sneak == true)then
   return minetest.add_entity(pos, "nc_luxgate:icelandspar", nil)
    elseif(puncher:get_player_control().RMB == true)then
    return minetest.remove_node(pos)
    end
    minetest.chat_send_all(minetest.serialize(luxgate.bill.gates))
    local prev = minetest.get_node(pos).param2 + 1
    minetest.set_node(pos, {name = "nc_luxgate:astrolabe", param2 = prev})
    end
})
minetest.register_node("nc_luxgate:vessicle",{
    description = "-NULL-",
    drawtype = "glasslike",
    tiles = {"dev.png"},
    light_source = 7,
    walkable = false,
    pointable = true,
    node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0, 0.001, 0.125, 0.3125, 0},
		}
    },
    groups = {crumbly = 1, luxg = 1},
    on_construct = function(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(3)
    end,
    on_timer = function(pos)
        luxgate.particles.portalhole(pos)

        --minetest.chat_send_all(minetest.serialize(luxgate.bill.gates))
        
        luxgate.core.socialmediapost(pos)

        luxgate.core.portalwork(pos)
        --else minetest.chat_send_all(minetest.serialize("something")) end

        local timer = minetest.get_node_timer(pos)
        timer:start(3)
    end,
    on_punch = function(pos)
   -- minetest.chat_send_all(luxgate.core.knockknock(pos))
    --minetest.chat_send_all(minetest.serialize(luxgate.core.whosthere(pos)))
    minetest.set_node(pos, {name = "nc_luxgate:vessicle"})
    minetest.chat_send_all(minetest.serialize(luxgate.core.seekout(pos)))
    --minetest.chat_send_all(minetest.serialize(luxgate.core.decode(luxgate.bill.gates[#luxgate.bill.gates])))
    end
})
--- Control nodes ---^^^


--  --  --  --  --  --  Frame nodes --  --  --  --  --  -- 

minetest.register_node("nc_luxgate:frame_ohm",{
    description = "-NULL-",
    tiles = {{name ="ohm_anim.png",
    animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 1},
        {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 7,
            frame_length = 0.1,
        }
    }},
    groups = { luxg = 1,cracky =1},
    on_punch = function(pos)
        luxgate.core.powerpull(pos)
    end
    
})
minetest.register_node("nc_luxgate:frame_lam",{
    description = "-NULL-",
    tiles = {{name ="lam_anim.png",
    animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 1},
        {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 13,
            frame_length = 0.1,
        }
    }},
    groups = { luxg = 1,cracky =1},
    on_punch = function(pos)
    minetest.chat_send_all(minetest.serialize(luxgate.core.whosthere(pos,{5,5,5})))
    
    end
})

minetest.register_node("nc_luxgate:crystal",{
    description = "Gate crystal",
    drawtype = "mesh",
    paramtype = "light",
   -- paramtype2 = "facedir",
    tiles = {"nc_optics_glass_frost.png"},
    groups = { luxg = 1,crumbly = 1},
    mesh = "dacrystal.b3d",
    on_punch = function(pos)
   --     local prev = minetest.get_node(pos).param2 + 1
   -- minetest.set_node(pos, {name = "nc_luxgate:crystal", param2 = prev})
    end
})
minetest.register_node("nc_luxgate:frame_e",{
    description = "Gate frame Extension",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = { luxg = 1,crumbly = 1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
        }
    },
    tiles = {{name ="e_anim.png",
    animation = {
        type = "vertical_frames",
        aspect_w = 12,
        aspect_h = 16,
        length = 1},
        {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 7,
            frame_length = 0.1,
        }
    }},
    on_punch = function(pos)
        luxgate.particles.suffusion(pos)
    end
})
minetest.register_node("nc_luxgate:frame_v",{
    description = "Gate frame Vane",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = { luxg = 1,crumbly = 1},
    tiles = {"canvas2.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.375, -0.5, -0.375, 0.375, -0.4375, 0.375},
			{-0.4375, -0.4375, -0.375, 0.3125, -0.375, 0.375},
			{-0.5, -0.375, -0.375, 0.25, -0.3125, 0.375},
			{-0.5625, -0.3125, -0.375, 0.1875, -0.25, 0.375},
			{-0.625, -0.25, -0.375, 0.125, -0.1875, 0.375},
			{-0.6875, -0.1875, -0.375, 0.0625, -0.125, 0.375},
			{-0.75, -0.125, -0.375, 0, -0.0625, 0.375}, 
			{-0.8125, -0.0625, -0.375, -0.0625, 0, 0.375}, 
			{-0.875, 0, -0.375, -0.125, 0.0625, 0.375},
			{-0.9375, 0.0625, -0.375, -0.1875, 0.125, 0.375}, 
			{-1, 0.125, -0.375, -0.25, 0.1875, 0.375},
			{-1.0625, 0.1875, -0.375, -0.3125, 0.25, 0.375}, 
			{-1.125, 0.25, -0.375, -0.375, 0.3125, 0.375}, 
			{-1.1875, 0.3125, -0.375, -0.4375, 0.375, 0.375},
			{-1.25, 0.375, -0.375, -0.5, 0.4375, 0.375},
			{-1.3125, 0.4375, -0.375, -0.5625, 0.5, 0.375},
        }
    },
    on_punch = function(pos)
        local prev = minetest.get_node(pos).param2 + 1
        minetest.set_node(pos, {name = "nc_luxgate:frame_v", param2 = prev})
    end
})

   minetest.register_node("nc_luxgate:block_ilmenite",{
    description = "ilmenite block",
    paramtype = "light",
    tiles = {"block_ilmenite.png"},
    groups = { luxg = 1,crumbly = 1,falling_node = 1, paramag = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
   })
   minetest.register_node("nc_luxgate:cobble_ilmenite",{
    description = "ilmenite block",
    paramtype = "light",
    tiles = {"block_ilmenite.png^nc_terrain_cobble.png"},
    groups = { luxg = 1,crumbly = 1,falling_node = 1, paramag = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
   })
   minetest.register_node("nc_luxgate:block_ilmenite_inv",{
    description = "ilmenite block",
    paramtype = "light",
    tiles = {"block_ilmenite_shifted.png"},
    groups = { luxg = 1,crumbly = 1,falling_node = 1, paramag_r = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
    
   })
   minetest.register_node("nc_luxgate:cobble_ilmenite_inv",{
    description = "ilmenite block",
    paramtype = "light",
    tiles = {"block_ilmenite_shifted.png^nc_terrain_cobble.png"},
    groups = { luxg = 1,crumbly = 1,falling_node = 1, paramag_r = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
   })
   minetest.register_node("nc_luxgate:ulvstone",{
    description = "Ulvstone",
    paramtype = "light",
    tiles = {"canvas2.png"},
    groups = { luxg = 1,crumbly = 1,falling_node = 1, ulv = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
   })
--  --  --  --  --  --  --  --  --  --  --  --  
minetest.register_craftitem("nc_luxgate:shard_ilmenite", {
    description = "ilmenite shard",
    inventory_image = "shard_ilmenite.png",
    wield_image = "shard_ilmenite.png",
    wield_scale = {x = 1.25, y = 1.25, z = 1.75},
    sounds = nodecore.sounds("nc_luxgate_ilmenite"),
    groups = { luxg = 1,paramag = 1}
})

nodecore.register_craft({
    label = "macerate ilmenite block to cobble",
    action = "pummel",
    nodes = {
        {match = "nc_luxgate:block_ilmenite", replace = "nc_luxgate:cobble_ilmenite"}
    },
    toolgroups = { luxg = 1,cracky = 2},

})
nodecore.register_craft({
    label = "pound ilmenite cobble into a solid node",
    action = "pummel",
    nodes = {
        {match = "nc_luxgate:cobble_ilmenite", replace = "nc_luxgate:block_ilmenite"}
    },
    toolgroups = { luxg = 1,thumpy = 3},
})