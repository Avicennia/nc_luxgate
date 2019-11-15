minetest.register_node(tm .. "sponge_e",{
    description = "Sponge",
    drawtype = "glasslike",
    paramtype = "light",
    groups = {crumbly = 1},
    tiles = {"sponge_epi.png^(nc_terrain_water.png^[opacity:96)"},
    on_punch = function(pos)
        local tab = minetest.find_nodes_in_area({x=pos.x-10,y=pos.y,z=pos.z-10},{x=pos.x+10,y=pos.y,z=pos.z+10},"nc_terrain:water_source")
        for n = 1, #tab, 1 do 
            minetest.set_node(tab[n], {name = "nc_sponge:sponge_living"})
        end
    end
})
minetest.register_node(tm .. "sponge_s",{
    description = "Sickly Sponge",
    drawtype = "glasslike",
    paramtype = "light",
    groups = {crumbly = 1},
    tiles = {"sponge_sickly.png^(nc_terrain_dirt.png^[opacity:96)"},
   
})
minetest.register_node(tm .. "sponge_h",{
    description = "Wasting Sponge",
    drawtype = "glasslike",
    paramtype = "light",
    groups = {crumbly = 1},
    tiles = {"sponge_host.png"},
    light_source = 1
})
minetest.register_node(tm .. "lucshard",{
    description = "Shard of Luciferin",
    drawtype = "nodebox",
    paramtype = "light",
    groups = {crumbly = 1},
    tiles = {"luctex.png"},
    node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, 0, 0, -0.25, 0.0625}, -- NodeBox1
			{0, -0.5, -0.0625, 0.0625, -0.3125, 0}, -- NodeBox2
			{0, -0.5, 0, 0.0625, -0.3125, 0.0625}, -- NodeBox3
			{-0.0625, -0.5, -0.0625, 0, -0.375, 0}, -- NodeBox4
		}
    }
})
--  --  --  --  --  --  ABM's   --  --  --  --  --  --
minetest.register_abm(
{
    label = "Sponge Infection Neg",
 
    nodenames = {"nc_sponge:sponge_living"},
   
    neighbors = {},
    interval = 2.0,
    chance = 91,
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local heur = math.random(0,100);
        local herd = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_s")
        local herd_c = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_h")
        local closeherd = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y-1,z=pos.z-1},{x=pos.x+1,y=pos.y+1,z=pos.z+1},"nc_luxgate:sponge_s")
        local closeherd_c = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y-1,z=pos.z-1},{x=pos.x+1,y=pos.y+1,z=pos.z+1},"nc_luxgate:sponge_h")

        heur = heur + (#herd*2 + #herd_c) + (#closeherd*6 + #closeherd_c*8);
        if(heur >= 90)then
            minetest.set_node(pos, {name = "nc_luxgate:sponge_s"})
        else 
        end
    end
})
minetest.register_abm(
{
    label = "Sponge Infection Epi",
 
    nodenames = {"nc_sponge:sponge_living"},
   
    neighbors = {},
    interval = 2.0,
    chance = 98,
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local heur = math.random(0,100);
        local herd = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_s")
        local herd_c = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_h")

        heur = heur + (#herd*4 + #herd_c*4);
        if(heur >= 98)then
            minetest.set_node(pos, {name = "nc_luxgate:sponge_e"})
        else 
        end
    end
})
minetest.register_abm(
{
    label = "Sponge Infection Sero",
 
    nodenames = {"nc_luxgate:sponge_e"},
   
    neighbors = {},
    interval = 2.0,
    chance = 16,
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local heur = math.random(0,98);
        local herd = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_s")
        local herd_c = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_h")

        local closeherd = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y-1,z=pos.z-1},{x=pos.x+1,y=pos.y+1,z=pos.z+1},"nc_luxgate:sponge_s")
        local closeherd_c = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y-1,z=pos.z-1},{x=pos.x+1,y=pos.y+1,z=pos.z+1},"nc_luxgate:sponge_h")

        heur = heur + (#herd*2 + #herd_c) +(#closeherd*4 + #closeherd_c*8);
        if(heur >= 98)then
            minetest.set_node(pos, {name = "nc_luxgate:sponge_s"})
        else 
        end
    end
})
minetest.register_abm(
{
    label = "Sponge Wasting Disease",
 
    nodenames = {"nc_luxgate:sponge_s"},
   
    neighbors = {},
    interval = 2.0,
    chance = 61,
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local heur = math.random(0,100);
        local herd = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_s")
        local herd_c = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},{x=pos.x+2,y=pos.y+2,z=pos.z+2},"nc_luxgate:sponge_h")

        local closeherd = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y-1,z=pos.z-1},{x=pos.x+1,y=pos.y+1,z=pos.z+1},"nc_luxgate:sponge_s")
        local closeherd_c = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y-1,z=pos.z-1},{x=pos.x+1,y=pos.y+1,z=pos.z+1},"nc_luxgate:sponge_h")

        heur = heur + (#herd*2 + #herd_c) +(#closeherd*4 + #closeherd_c*8);
        if(heur >= 78)then
            minetest.set_node(pos, {name = "nc_luxgate:sponge_h"})
        else 
        end
    end
})
--  --  --  --  --  --  Crafting    --  --  --  --  --  --  --
nodecore.register_craft({
    label = "Prune sponge crystal growths",
    action = "pummel",
    priority = 1,
    toolgroups = {snappy = 1},
    nodes = {
        {
            match = tm .. "sponge_h",
            replace = "nc_terrain:sand"
        },
    },
    items = {
        {name = tm .. "lucshard", count = 2, scatter = 5}
    },
    itemscatter = 5;
})
nodecore.register_craft({
    label = "Prune sponge crystal growths epiphytic",
    action = "pummel",
    priority = 1,
    toolgroups = {snappy = 1},
    nodes = {
        {
            match = tm .. "sponge_e",
            replace = "nc_sponge:sponge_living"
        },
    },
    items = {
        {name = tm .. "lucshard", count = 1, scatter = 5}
    },
    itemscatter = 5;

})