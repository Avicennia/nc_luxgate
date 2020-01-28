--minetest.override_item("nc_terrain:dirt", {on_punch = function() luxgate.core.oregive() end})
minetest.register_on_dignode(
    function(pos, oldnode, digger)
        if(oldnode.name == "nc_lode:ore")then
            local space = minetest.find_node_near(pos,1,"air",false)
        minetest.item_drop(ItemStack("nc_luxgate:shard_ulvo 5"),digger,space or pos)
        else end
    end)