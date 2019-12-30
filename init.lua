local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
tm = thismod..":"

luxgate = {
    functions = {},
    nodes = {names = {"nc_lode:block_annealed","nc_lode:block_tempered","nc_luxgate:frame_ohm","nc_luxgate:frame_lam","nc_luxgate:frame_v","nc_luxgate:frame_e"}},
    nodenumbers = {},
    dirs = {}
}

dofile(modpath .. "/smokenmirrors.lua")
dofile(modpath .. "/shem.lua")
dofile(modpath .. "/noctiluca.lua")
dofile(modpath .. "/brainything.lua")
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
    on_punch = function(pos)
        local proberes = luxgate.functions.line_probe(pos,20,3)
        minetest.chat_send_all(minetest.serialize(luxgate.functions.refl_find(luxgate.functions.line_inv(proberes))))
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
			{-0.125, 0, 0.001, 0.125, 0.3125, 0}, -- NodeBox1
		}
    },
    groups = {crumbly = 1},
    on_construct = function(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(3)
    end,
    on_timer = function(pos)
        portalhole(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(3)
    end
})
--- Env nodes ---^^^


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
        suffusion(pos)
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
        suffusion(pos)
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
            {-0.375, -0.5, -0.375, 0.375, -0.4375, 0.375}, -- NodeBox18
			{-0.4375, -0.4375, -0.375, 0.3125, -0.375, 0.375}, -- NodeBox19
			{-0.5, -0.375, -0.375, 0.25, -0.3125, 0.375}, -- NodeBox20
			{-0.5625, -0.3125, -0.375, 0.1875, -0.25, 0.375}, -- NodeBox21
			{-0.625, -0.25, -0.375, 0.125, -0.1875, 0.375}, -- NodeBox22
			{-0.6875, -0.1875, -0.375, 0.0625, -0.125, 0.375}, -- NodeBox23
			{-0.75, -0.125, -0.375, 0, -0.0625, 0.375}, -- NodeBox24
			{-0.8125, -0.0625, -0.375, -0.0625, 0, 0.375}, -- NodeBox25
			{-0.875, 0, -0.375, -0.125, 0.0625, 0.375}, -- NodeBox26
			{-0.9375, 0.0625, -0.375, -0.1875, 0.125, 0.375}, -- NodeBox27
			{-1, 0.125, -0.375, -0.25, 0.1875, 0.375}, -- NodeBox28
			{-1.0625, 0.1875, -0.375, -0.3125, 0.25, 0.375}, -- NodeBox29
			{-1.125, 0.25, -0.375, -0.375, 0.3125, 0.375}, -- NodeBox30
			{-1.1875, 0.3125, -0.375, -0.4375, 0.375, 0.375}, -- NodeBox31
			{-1.25, 0.375, -0.375, -0.5, 0.4375, 0.375}, -- NodeBox32
			{-1.3125, 0.4375, -0.375, -0.5625, 0.5, 0.375}, -- NodeBox33
        }
    },
    on_punch = function(pos)
        local prev = minetest.get_node(pos).param2 + 1
        minetest.set_node(pos, {name = "nc_luxgate:frame_v", param2 = prev})
    end
})

--  --  --  --  --  --  --  --  --  --  --  --  
