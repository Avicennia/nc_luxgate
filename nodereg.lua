

minetest.register_node("nc_luxgate:vessicleNull",{
    description = "-NULL-",
    drawtype = "nodebox",
    tiles = {"portalhole.png"},
    light_source = 4,
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
        local val = luxgate.core.whosthere(pos) 
        local idx = math.random(1,9)
        if(val)then
        local postring = pos.x.."x"..pos.y.."y"..pos.z.."z"..val
        local meta = minetest.get_meta(pos)

    
        luxgate.box:set_string("vref",luxgate.box:get_string("vref")..idx)
        luxgate.box:set_int("qref",luxgate.box:get_int("qref") + 1)

        meta:set_string("vrf",idx.."|"..string.len(luxgate.box:get_string("vref")))
        meta:set_string("id",postring)
        
        else end
    end,
    on_destruct = function(pos)
        local meta = minetest.get_meta(pos)
        local mtab = {meta:get_string("vrf")}
        luxgate.box:set_int("qref",luxgate.box:get_int("qref") - 1)

        minetest.after(1, function()
        if(minetest.get_node(pos).name == "nc_luxgate:vessicle")then
            local meta = minetest.get_meta(pos)
            meta:set_string("vrf",mtab[1])
        else end end)

    end,
    on_punch = function(pos)
    minetest.chat_send_all(luxgate.box:get_string("vref"))
    minetest.chat_send_all(luxgate.box:get_int("qref"))
    local meta = minetest.get_meta(pos)
    minetest.chat_send_all(meta:get_string("vrf"))
    end
})
minetest.register_node("nc_luxgate:vessicle",{
    description = "-NULL-",
    diggable = false,
    pointable = false,
    drawtype = "nodebox",
    tiles = {"portalhole.png^[makealpha:250,255,201"},
    light_source = 9,
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

    luxgate.core.shitpost(pos) -- Register self to table.

    end,

    on_punch = function(pos)

    local meta = minetest.get_meta(pos)
    minetest.chat_send_all(minetest.serialize(luxgate.vests))
    minetest.chat_send_all(luxgate.box:get_string("vref").."!!!!")
    --luxgate.box:set_string("vref","")
    end
})



--  --  --  --  --  --  Frame nodes --  --  --  --  --  -- 

minetest.register_node("nc_luxgate:frame_ohm",{
    description = "Omega Gate Frame",
    diggable = false,
    pointable = false,
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
    groups = {luxg = 1},
})
minetest.register_node("nc_luxgate:frame_lam",{
    description = "Lambda Gate Frame",
    diggable = false,
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
    on_construct = function(pos, node)
    minetest.get_meta(pos):set_string("infotext","Node:".. node.name .. " | ".." Dist; "..0)
    end,
    on_punch = function(pos, node, puncher)
            local ves = minetest.find_node_near(pos,4,"nc_luxgate:vessicle",false)
            local nves = minetest.find_node_near(pos,4,"nc_luxgate:vessicleNull",false)
            
        
                if(ves and luxgate.core.holdmycalc(ves) >= 16)then
        
                    local meta = minetest.get_meta(ves)
                    meta:set_int("power",(meta:get_int("power") + luxgate.core.xenithcore(ves)))
        
        
                elseif(nves and luxgate.core.holdmycalc(nves) >= 10)then
        
                    minetest.set_node(nves,{name = "nc_luxgate:vessicle"})
        
                    local meta = minetest.get_meta(nves)
                    meta:set_int("power",luxgate.core.xenithcore(nves) - 10)
                else  end
        
        
                if(puncher:get_player_control().sneak == true)then
                    
                local ves = minetest.find_node_near(pos,4,"nc_luxgate:vessicle",false)
                local meta = minetest.get_meta(pos)
                meta:set_int("gindex",meta:get_int("gindex") + 1 )
        
                if(meta:get_int("gindex") > #luxgate.vests)then
                    meta:set_int("gindex",1)
                else end
        
        
                local ps = luxgate.core.decode(luxgate.vests[meta:get_int("gindex")])[1]
                local dpos = {x = ps[1], y = ps[2], z = ps[3]}
                local nam;
                if(minetest.get_node(dpos).name == "ignore")then
                    nam = "ignore"
                elseif(minetest.get_node(dpos).name == "nc_luxgate:vessicle")then
                    nam = "vessicle"
                elseif(minetest.get_node(dpos).name == "nc_luxgate:vessicleNull")then
                    nam = "Depl Vessicle"
                else end
                meta:set_string("infotext","Node:".. nam .. " | ".." Dist; "..vector.distance(ves,dpos))
                minetest.chat_send_all(meta:get_int("gindex"))
        
                else end
            end
})


minetest.register_node("nc_luxgate:frame_e",{
    description = "Gate frame Extension",
    drawtype = "nodebox",
    paramtype = "light",
    diggable = false,
    pointable = false,
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
    diggable = false,
    pointable = false,
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
        minetest.chat_send_all(luxgate.box:get_string("vref"))
    end
})

   minetest.register_node("nc_luxgate:block_ilmenite",{
    description = "ilmenite block",
    paramtype = "light",
    tiles = {"block_ilmenite.png"},
    groups = { luxg = 1,crumbly = 1, paramag = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
   })
   minetest.register_node("nc_luxgate:cobble_ilmenite",{
    description = "ilmenite block",
    paramtype = "light",
    tiles = {"block_ilmenite.png^nc_terrain_cobble.png"},
    groups = { luxg = 1,crumbly = 1, paramag = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
   })
   minetest.register_node("nc_luxgate:ulvstone",{
    description = "Ulvstone",
    paramtype = "light",
    tiles = {"canvas2.png"},
    groups = { luxg = 1,crumbly = 1, ulv = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    on_punch = function()
    end
    
   })
   minetest.register_node("nc_luxgate:ulvstone_i",{
    description = "Ulvstone",
    diggable = false,
    paramtype = "light",
    tiles = {"canvas2t.png"},
    groups = { luxg = 1,crumbly = 1, ulv = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    on_punch = function(pos)
        local lam = minetest.find_node_near(pos,3,"nc_luxgate:frame_lam", false)
        minetest.chat_send_all(luxgate.core.tumb(lam) or "//")
    end
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