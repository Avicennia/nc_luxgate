--minetest.override_item("nc_terrain:dirt", {on_punch = function() luxgate.core.oregive() end})
minetest.register_on_dignode(
    function(pos, oldnode, digger)
        if(oldnode.name == "nc_lode:ore")then
            if(math.random(100) >= 98)then
            local space = minetest.find_node_near(pos,1,"air",false)
        minetest.item_drop(ItemStack("nc_luxgate:shard_ilmenite 1"),digger,space or pos)
            else end
        else end
    end)

    minetest.register_abm({
        nodenames = {"group:paramag"},
        neighbors = {"air"},
        interval = 1,
        chance = 1, -- Select every 1 in 50 nodes
        action = function(pos, node, active_object_count,active_object_count_wider)
            local neighbor = minetest.find_node_near(pos, 1, "group:paramag", false)
            local smeta = minetest.get_meta(pos)

            if(neighbor)then
                local nmeta = minetest.get_meta(neighbor)
                
                if(nmeta:get_int("poled") == 0 and smeta:get_int("poled") == 0)then
                    
                    local space = minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name
                    if(space == "air")then
                        local neighname = minetest.get_node(neighbor).name
                        space = {x = pos.x - 1, y = pos.y, z = pos.z}
                       minetest.set_node(space, {name = neighname})
                       minetest.remove_node(neighbor)
                       nmeta = minetest.get_meta(space)
                       smeta:set_int("poled",1)
                       nmeta:set_int("poled",1)
                    else end
                    elseif(nmeta:get_int("poled") == 0 and smeta:get_int("poled") == 1)then
                        local neighname = minetest.get_node(neighbor).name
                        local space = minetest.find_node_near(pos, 1, "air", false)
                        if(space)then
                        minetest.set_node(space, {name = neighname})
                        nmeta = minetest.get_meta(space)
                        nmeta:set_int("poled",1)
                        minetest.remove_node(neighbor)
                        else end
                else end
            elseif (neighbor == nil) then smeta:set_int("poled",0)end
            --minetest.remove_node(pos)
        end
})
minetest.register_abm({
    nodenames = {"group:paramag_r"},
    neighbors = {"air"},
    interval = 1,
    chance = 1, -- Select every 1 in 50 nodes
    action = function(pos, node, active_object_count,active_object_count_wider)
        local neighbor = minetest.find_node_near(pos, 1, "group:paramag_r", false)
        local smeta = minetest.get_meta(pos)

        if(neighbor)then
            local nmeta = minetest.get_meta(neighbor)
            
            if(nmeta:get_int("poled") == 0 and smeta:get_int("poled") == 0)then
                
                local space = minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name
                if(space == "air")then
                    local neighname = minetest.get_node(neighbor).name
                    space = {x = pos.x - 1, y = pos.y, z = pos.z}
                   minetest.set_node(space, {name = neighname})
                   minetest.remove_node(neighbor)
                   nmeta = minetest.get_meta(space)
                   smeta:set_int("poled",1)
                   nmeta:set_int("poled",1)
                else end
                elseif(nmeta:get_int("poled") == 0 and smeta:get_int("poled") == 1)then
                    local neighname = minetest.get_node(neighbor).name
                    local space = minetest.find_node_near(pos, 1, "air", false)
                    if(space)then
                    minetest.set_node(space, {name = neighname})
                    nmeta = minetest.get_meta(space)
                    nmeta:set_int("poled",1)
                    minetest.remove_node(neighbor)
                    else end
            else end
        elseif (neighbor == nil) then smeta:set_int("poled",0)end
        --minetest.remove_node(pos)
    end
})
