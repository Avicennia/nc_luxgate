local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
local tm = thismod..":"
dofile(modpath .. "/recog.lua")
dofile(modpath .. "/shem.lua")

--- NAMING ---
local lodeb = "nc_lode:block_";
local nlg = {fe = tm.."frame_e", fv = tm .. "frame_v", ig = "air", tl = lodeb .."tempered",
al = lodeb .. "annealed", gl = "nc_optics:glass", oh = tm .. "frame_ohm", lb = tm .. "frame_lam";}
local lluxgate = {
nodenames = {tm .. "frame_b", tm .. "frame_e",tm .. "frame_v"},
functions = {},
structures = {
    pylon = { l=5, w=5, h=5,
       csa = {{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.al,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},
             {nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.fv,nlg.ig,nlg.ig,nlg.ig,nlg.fv},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.fe,nlg.ig,nlg.fe,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.fv,nlg.ig,nlg.fv,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.al,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig}}
            },
    gate_minimal = { l=5, w=5, h=6, 
        csa = {{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.al,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.al,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig}}},
    gate_standard = { l=5, w=5, h=5, 
        csa = {{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.al,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.tl,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.tl,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fe,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.tl,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.fv,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.tl,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},}},
    gate_maximal = { l=5, w=5, h=5, 
        csa = {{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.al,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},{nlg.tl,nlg.tl,nlg.tl,nlg.tl,nlg.tl},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.lb,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.oh,nlg.fv,nlg.ig,nlg.fv,nlg.oh},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.fe,nlg.ig,nlg.ig,nlg.ig,nlg.fe},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             {nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.oh,nlg.fv,nlg.ig,nlg.fv,nlg.oh},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},{nlg.ig,nlg.ig,nlg.ig,nlg.ig,nlg.ig},
             
        }}
}}
--- NAMING ---^^^

--  --  --  --  --  --  Frame nodes --  --  --  --  --  -- 
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
    on_punch = function(pos, node, puncher)
        pshem(pos,"shem_gate_max",puncher:get_look_dir())
        local reltab = minetest.find_nodes_in_area({x=pos.x-4,y=pos.y,z=pos.z-4},{x=pos.x+4,y=pos.y+6,z=pos.z+4},"nc_luxgate:vessicle")
        for k,v in pairs(reltab) do
            local mm = minetest.get_meta(v)
            if(mm:get_string("USID") == "")then
                mm:set_string("USID",ugid(6))
            elseif(mm:get_string("USID") ~= nil)then
                --minetest.chat_send_all("STRING ALREADY SET TO: "..mm:get_string("USID"))
            else
             --minetest.chat_send_all("Error - ID string")
            end
            --minetest.chat_send_all(mm:get_string("USID"))
        end 
    end

})
minetest.register_node("nc_luxgate:vessicle",{
    description = "-NULL-",
    drawtype = "glasslike",
    tiles = {"dev.png"},
    color = {"blue"},
    walkable = false,
    on_punch = function(pos,node, puncher)
    --structure_scan(lluxgate.structures.gate_maximal,pos)
    --[[local player = minetest.get_objects_inside_radius(pos,2)[1]
    local playern = player:get_player_name()
    local homepos = pos
    local locale = minetest.find_nodes_in_area({x=pos.x-20,y=pos.y-1,z=pos.z-20},{x=pos.x+20,y=pos.y+1,z=pos.z+20},"nc_lode:block_annealed")
    if(minetest.get_node({x=locale[1].x, y=locale[1].y-1, z=locale[1].z}).name == "nc_lode:block_annealed")then
    player:move_to(locale[1])
    else minetest.chat_send_all(minetest.get_node({x=locale[1].x, y=locale[1].y-1, z=locale[1].z}).name) end]]
    local mm = minetest.get_meta(pos)
    minetest.chat_send_all(mm:get_string("USID"))
    end
})
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
    on_punch = function(pos,node,puncher)
        local mn = linesrc(pos,60,"north")
        if mn then
        puncher:move_to({x=mn.x,y=mn.y+3,z=mn.z})
        else end
        minetest.chat_send_all(minetest.serialize(puncher:get_look_dir()))
        local nmeta = minetest.get_meta(pos)
        if(nmeta:get_int("charge")==0)then
        local timer = minetest.get_node_timer(pos)
        timer:start(3)
        nmeta:set_int("charge",1)
        else end
        suffusion(pos)
    end,
    on_timer= function(pos)
        
        --[[local vespos = minetest.find_nodes_with_meta({x=pos.x-2,y=pos.y,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2})
        local objs = minetest.get_objects_inside_radius(vespos[1],4)
        local player = objs[1]
        player:move_to({x=pos.x,y=pos.y+4,z=pos.z})]]
        local nmeta = minetest.get_meta(pos)
        nmeta:set_int("charge",0)
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

minetest.register_node(lluxgate.nodenames[1],{
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
    }
})
minetest.register_node(lluxgate.nodenames[2],{
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
    }}
})
minetest.register_node(lluxgate.nodenames[3],{
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
        
    end
})
--  --  --  --  --  --  --  --  --  --  --  --  
