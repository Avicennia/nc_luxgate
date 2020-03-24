

minetest.register_node("nc_luxgate:vessicleNull",{
    description = "-NULL-",
    drawtype = "nodebox",
    pointable = false,
    diggable = false,
    tiles = {"portalhole.png^[makealpha:250,255,201"},
    light_source = 4,
    walkable = false,
    pointable = true,
    node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0, 0.001, 0.125, 0.3125, 0},
		}
    },
    groups = {crumbly = 1, luxg = 1, luxv = 1},
    on_construct = function(pos)
        local val = luxgate.core.whosthere(pos)
        return (val > 0) or minetest.remove_node(pos)
    end,
    on_destruct = function(pos)

        minetest.after(1, function()
        if(minetest.get_node(pos).name == "nc_luxgate:vessicle")then
            local pos2 = minetest.find_node_near(pos,1,"nc_luxgate:frame_lam",false)
            local meta = minetest.get_meta(pos2)
            local srcs = {x = pos.x, y = pos.y, z = pos.z, v = luxgate.core.whosthere(pos)}
            for n = 1, #luxgate.vests, 1 do
                if(minetest.serialize(luxgate.vests[n]) == minetest.serialize(srcs))then
                    return meta:set_string("gindex",n)
                elseif(n == #luxgate.vests and minetest.serialize(luxgate.vests[n]) ~= minetest.serialize(srcs))then
                    return meta:set_string("gindex",n+1), table.insert(luxgate.vests, srcs)
                else end
            end
            
        end

    end)
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
    node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0, 0.001, 0.125, 0.3125, 0},
		}
    },
    groups = {crumbly = 1, luxv = 1},
    on_construct = function(pos)

    luxgate.core.shitpost(pos) -- Register self to table.

    end,
})



--  --  --  --  --  --  Frame nodes --  --  --  --  --  -- 

minetest.register_node("nc_luxgate:frame_ohm",{
    description = "Omega Gate Frame",
    diggable = false,
    pointable = false,
    tiles = {"canvas2.png", "ohm_anim.png", "ohm_anim.png", "ohm_anim.png", "ohm_anim.png", "ohm_anim.png"},
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
    on_construct = function(pos)
        local node = minetest.get_node(pos).name
    minetest.get_meta(pos):set_string("infotext","Node:".. node .. " | ".." Dist; "..0)
    end,
    on_punch = function(pos, node, puncher)
        if(puncher:get_player_control().sneak == false)then
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
        
        
        elseif(puncher:get_player_control().sneak == true)then
                    
                local ves = minetest.find_node_near(pos,4,"nc_luxgate:vessicle",false)
                local meta = minetest.get_meta(pos)
                meta:set_int("gindex",meta:get_int("gindex") + 1 )
        
                if(meta:get_int("gindex") > #luxgate.vests)then
                    meta:set_int("gindex",1)
                else end
        
                if(type(luxgate.vests[meta:get_int("gindex")]) == "table")then
                local ps = luxgate.core.decode(luxgate.vests[meta:get_int("gindex")])[1]
                local dpos = {x = ps[1], y = ps[2], z = ps[3]}
                local nam;
                if(minetest.get_node(dpos).name == "ignore")then
                    nam = "ignore"
                elseif(minetest.get_node(dpos).name == "nc_luxgate:vessicle")then
                    nam = "vessicle"
                elseif(minetest.get_node(dpos).name == "nc_luxgate:vessicleNull")then
                    nam = "Depl Vessicle"
                else nam = "ERROR" end
                if(ves)then
                meta:set_string("infotext","Node:".. nam .. " | ".." Dist; "..vector.distance(ves,dpos))
                --luxgate.log(meta:get_int("gindex"))
                else end
            else meta:set_string("infotext","Node: REDACTED") end
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
    tiles = {"canvas2.png"},
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
    }
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
    on_punch = function(pos)
    
        luxgate.particles.cyclicAMP(pos,"shard_anim.png",1.2, 4)
    end
})

minetest.register_node("nc_luxgate:ulvstone",{
    description = "Ulvstone",
    tiles = {"canvas2.png"},
    groups = { luxg = 1,crumbly = 2, ulv = 1, writable = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
    
})

minetest.register_node("nc_luxgate:ulvstone_i",{
    description = "Ulvstone",
    pointable = false,
    diggable = false,
    paramtype = "light",
    tiles = {"canvas2t.png"},
    groups = { luxg = 1,crumbly = 1, ulv = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
})

minetest.register_node("nc_luxgate:ulvstone_c",{
    description = "Ulvstone",
    pointable = false,
    diggable = false,
    paramtype = "light",
    tiles = 
    {"canvas2.png",
     "canvasvertex2.png",
     "canvas2.png",
     "canvas2.png",
     "canvas2.png",
     "canvas2.png",},
    paramtype2 = "facedir",
    groups = { luxg = 1,crumbly = 1, ulv = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
})

minetest.register_node("nc_luxgate:ulvstone_v",{
    description = "Ulvstone",
    pointable = false,
    diggable = false,
    paramtype = "light",
    tiles = {"canvasvertex.png"},
    paramtype2 = "facedir",
    groups = { luxg = 1,crumbly = 1, ulv = 1},
    sounds = nodecore.sounds("nc_luxgate_ilmenite2"),
})

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