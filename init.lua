local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
tm = thismod..":"


luxgate = {
    core = {},
    particles = {},
    nodes = {
        ilmenite = {},
        names = {"nc_lode:block_annealed","nc_lode:block_tempered","nc_luxgate:frame_ohm","nc_luxgate:frame_lam","nc_luxgate:frame_v","nc_luxgate:frame_e","nc_lode:rod_annealed","nc_luxgate:vessicle"}},
    nodenumbers = {},
    dirs = {
        "(1,0,0)",  -- East
        "(-1,0,0)", -- West
        "(0,0,1)", -- North
        "(0,0,-1)", -- South
        "(1,0,1)", -- NorthEast
        "(-1,0,-1)", -- SouthWest
        "(1,0,-1)", -- SouthEast
        "(-1,0,1)" -- NorthWest
        }
}

dofile(modpath .. "/smokenmirrors.lua")
dofile(modpath .. "/legothingies.lua")
dofile(modpath .. "/brainything.lua")
dofile(modpath .. "/paramag.lua")

--- NAMING ---

--- NAMING ---^^^

--  --  --  --  --  --  Env nodes --  --  --  --  --  -- 
minetest.register_node("nc_luxgate:luxblende",{
    description = "Lux Vessicle",
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125}
        }
    },
    tiles = {"canvas2.png"},
    on_punch = function(pos,node,puncher)
        --minetest.chat_send_all(luxgate.core.whosthere(pos))

        --DARKCHAIN TESTING STUFF
        --[[local chainpairs = {{{x = pos.x - 2, y = pos.y + 1, z = pos.z},{x = pos.x - 1, y = pos.y + 1, z = pos.z - 2}},
                            {{x = pos.x - 1, y = pos.y + 1, z = pos.z - 2},{x = pos.x + 1, y = pos.y + 1, z = pos.z - 2}},
                            {{x = pos.x + 1, y = pos.y + 1, z = pos.z - 2},{x = pos.x + 2, y = pos.y + 1, z = pos.z}},
                            {{x = pos.x + 2, y = pos.y + 1, z = pos.z},{x = pos.x + 1, y = pos.y + 1, z = pos.z + 2}},
                            {{x = pos.x + 1, y = pos.y + 1, z = pos.z + 2},{x = pos.x - 1, y = pos.y + 1, z = pos.z + 2}},
                            {{x = pos.x - 1, y = pos.y + 1, z = pos.z + 2},{x = pos.x - 2, y = pos.y + 1, z = pos.z}},
                            {{x = pos.x + 1, y = pos.y + 1, z = pos.z + 2},{x = pos.x, y = pos.y + 1, z = pos.z}},
                            {{x = pos.x, y = pos.y + 1, z = pos.z},{x = pos.x + 1, y = pos.y + 1, z = pos.z - 2}},
                            {{x = pos.x, y = pos.y + 1, z = pos.z},{x = pos.x - 2, y = pos.y + 1, z = pos.z }}
                        }

        for n=1, #chainpairs, 1 do
        luxgate.particles.darkchain(chainpairs[n][1],chainpairs[n][2])
        end]]



        --POWERPULL TESTING STUFF
        --[[local places = minetest.find_nodes_in_area({x=pos.x-2, y=pos.y-2,z=pos.z-2},{x=pos.x+2, y=pos.y+2,z=pos.z+2},"nc_luxgate:frame_ohm")
        local vale = 0;
        for n=1,#places,1 do
            vale = vale + luxgate.core.powerpull(places[n])
        end
        minetest.chat_send_all(vale.." "..vale / 4)
        --luxgate.core.tetris(pos, {5,5,6})]]

        local something = luxgate.core.conscription(luxgate.core.line_probe(pos,250, 3))
        local tab = luxgate.core.line_probe(pos,250,3).nodes_p[something]
        if(tab)then
            minetest.chat_send_all(minetest.serialize(tab))
            puncher:set_pos(tab)
            luxgate.particles.seenoevil(puncher)
        else minetest.chat_send_all("nothing") end



    end
})
minetest.register_node("nc_luxgate:vessicle",{
    description = "-NULL-",
    drawtype = "glasslike",
    tiles = {"dev.png"},
    walkable = false,
    node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0, 0.001, 0.125, 0.3125, 0},
		}
    },
    groups = {crumbly = 1},
    on_construct = function(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(3)
    end,
    on_timer = function(pos)
        luxgate.particles.portalhole(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(3)
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
    groups = {cracky =1},
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
    groups = {cracky =1}
})

minetest.register_node("nc_luxgate:frame_b",{
    description = "Gate frame Bottom",
    drawtype = "nodebox",
    paramtype = "light",
    glow = 3,
    paramtype2 = "facedir",
    tiles = {"canvas2.png"},
    groups = {crumbly = 1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
			{-0.1875, -0.4375, -0.25, 0.1875, -0.375, 0.25},
			{-0.125, -0.375, -0.25, 0.125, -0.3125, 0.25},
			{0, -0.3125, -0.1875, 0.0625, 0.5, -0.0625},
			{0, -0.3125, 0.0625, 0.0625, 0.5, 0.1875},
        }
    },
})
minetest.register_node("nc_luxgate:frame_e",{
    description = "Gate frame Extension",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {crumbly = 1},
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
    groups = {crumbly = 1},
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
minetest.register_node("nc_luxgate:shard_ilmenite_int",{
    description = "ilmenite",
    drawtype = "airlike",
    paramtype = "light",
    groups = {crumbly = 1},
    on_construct = function(pos)
        nodecore.item_eject(pos, "nc_luxgate:shard_ilmenite_hot",9,1, {x = 0, y = 3, z = 0})
        minetest.remove_node(pos)
    end
   })
   minetest.register_node("nc_luxgate:block_ilmenite",{
    description = "ilmenite block",
    drawtype = "allfaces_optional",
    paramtype = "light",
    tiles = {"block_ilmenite.png"},
    groups = {crumbly = 1, paramag = 1},
    on_punch = function(pos)
    local meta = minetest.get_meta(pos)
    minetest.chat_send_all(meta:get_int("poled"))
    end
   })
--  --  --  --  --  --  --  --  --  --  --  --  
minetest.register_craftitem("nc_luxgate:shard_ilmenite", {
    description = "ilmenite shard",
    inventory_image = "shard_ilmenite.png",
    wield_image = "shard_ilmenite.png",
    wield_scale = {x = 1.25, y = 1.25, z = 1.75},
    sounds = nodecore.sounds("nc_terrain_stony"),
    groups = {paramag = 1}
})
minetest.register_craftitem("nc_luxgate:shard_ilmenite_hot", {
    description = "ilmenite shard",
    inventory_image = "shard_ilmenite_hot.png",
    wield_image = "shard_ilmenite_hot.png",
    wield_scale = {x = 1.25, y = 1.25, z = 1.75},
    sounds = nodecore.sounds("nc_terrain_stony")

})