
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
        
        luxgate.core.socialmediapost(pos)

        luxgate.core.portalwork(pos)

        local timer = minetest.get_node_timer(pos)
        timer:start(3)
    end,
    on_punch = function(pos)
   -- minetest.chat_send_all(luxgate.core.knockknock(pos))
    --minetest.chat_send_all(minetest.serialize(luxgate.core.whosthere(pos)))
    minetest.set_node(pos, {name = "nc_luxgate:vessicle"})
    --minetest.chat_send_all(minetest.serialize(luxgate.core.seekout(pos)))
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
    self.object:set_nametag_attributes({text = "WhenMeaningFallsInSplinters", color =  {a=250, r=250, g=250, b=255}})

    end
})

minetest.register_node("nc_luxgate:button",{
    description = "Gate crystal",
    drawtype = "mesh",
    walkable = false,
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {"nc_lode_annealed.png"},
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.1875, -0.1875, -0.4375, 0.1875, 0.1875},
        },
    },
    groups = { luxg = 1,crumbly = 1},
    mesh = "button.b3d",
    on_punch = function(pos, node, puncher)
        local lam = minetest.find_node_near(pos,4,"nc_luxgate:frame_lam", false)
        if(lam)then
        minetest.add_entity(lam,"nc_luxgate:icelandspar",nil)
        else end
        if(puncher:get_player_control().sneak == true)then
            local prev = minetest.get_node(pos).param2 + 1
            minetest.set_node(pos, {name = "nc_luxgate:button", param2 = prev})
        else end
    end
})
minetest.register_node("nc_luxgate:geqbutton",{
    description = "Gate powerbutton",
    drawtype = "mesh",
    walkable = false,
    paramtype = "light",
    paramtype2 = "facedir",
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1875, -0.1875, -0.5, 0.1875, 0.1875, -0.4375},
        },
    },
    tiles = {"nc_lode_annealed.png"},
    groups = { luxg = 1,crumbly = 1},
    mesh = "geqbutton.b3d",
    on_punch = function(pos, node, puncher)
    local ves = minetest.find_node_near(pos,4,"nc_luxgate:vessicle",false)
        if(ves)then
        luxgate.core.xenithcore(ves)
        else end
        if(puncher:get_player_control().sneak == true)then
            local prev = minetest.get_node(pos).param2 + 1
    minetest.set_node(pos, {name = "nc_luxgate:geqbutton", param2 = prev})
        else end
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