

-- AREA FETCHING THINGY

luxgate.core.area = function(pos,len,wid,hei) -- Grabs a len x wid x hei area of nodes and outputs them as a large table.
    local output = {};
    local ori = pos;
    local inc = 0
    for n = 1, hei, 1 do -- Y axis, height.
        for o = 1, len, 1 do -- Z axis, length.
            for t = 1, wid, 1 do -- X axis, girth. function that does the actual searching.
                ori.x = ori.x + 1
                inc = inc + 1
                output[inc] = minetest.get_node(ori).name
            end
            ori.x = ori.x - 5
            ori.z = ori.z + 1
        end
        ori.z = ori.z - 5
        ori.y = ori.y + 1
    end
    return output
end
--[[

            IDENTIFICATION  and ASSIGNMENT STUFF

]]
luxgate.core.area_decode = function(table) -- Converts certain table values into numbers for interpretation.
    local output = {};
    for n = 1, #table, 1 do
        if(table[n] == "air")then
            output[n] = 0;
        elseif(table[n] == luxgate.nodes.names[1])then
            output[n] = 1;
        elseif(table[n] == luxgate.nodes.names[2])then
            output[n] = 2;
        elseif(table[n] == luxgate.nodes.names[3])then
            output[n] = 3;
        elseif(table[n] == luxgate.nodes.names[4])then
            output[n] = 4;
        elseif(table[n] == luxgate.nodes.names[5])then
            output[n] = 5;
        elseif(table[n] == luxgate.nodes.names[6])then
            output[n] = 6;
        elseif(table[n] == luxgate.nodes.names[7])then
            output[n] = 7;
        elseif(table[n] == luxgate.nodes.names[8])then
            output[n] = 8;
        else output[n] = 9 end
    end
    return output
end

luxgate.core.unquestionablejudgement = function(table, guess) -- Give table, and template table (guess), and outputs true or false accordingly.
    local output = {}
    local rv = 0;
        if(table and guess)then

            if(#table == #guess)then -- checks if both tables line up for same values.
                for n = 1, #table, 1 do
                    if(table[n] == guess[n])then
                    output[n] = true
                    else output[n] = false
                    end
                end
            else output = {"wrong size", #table, #guess}
            end
        else end


        for n = 1, #output, 1 do -- Create a numerical record of how many trues in output.
            if(output[n] == true)then
                rv = rv + 1;
            else end
        end


        if(rv == #table)then
            output = nil;
            rv = "true";
        else end
        
return rv
end



luxgate.core.knockknock = function()
end

luxgate.core.whosthere = function(pos,areaparams) -- Confirms whether structure true passed by unquestionablejudgement is a valid structure and reports which it fits.
    
    local gather = luxgate.core.area(pos, areaparams[1], areaparams[2], areaparams[3])
    local digitize = luxgate.core.area_decode(gather)
    local antoninscalia = {}
    for n = 1, #luxgate.numberframe, 1 do
        if(luxgate.core.unquestionablejudgement(digitize,luxgate.numberframe[n]) == true)then
            antoninscalia[n] = true;
        else antoninscalia[n] = luxgate.core.unquestionablejudgement(digitize,luxgate.numberframe[n]) end
    end

    return antoninscalia;
end


--[[

            LUX POWER STUFF

]]

luxgate.core.powerpull = function(pos) -- Function for doing crude "energy pull" particle effect by ohmic or power trans frame nodes.
    local nod = {minetest.find_node_near(pos, 2, {"group:lux_emit"}, false)} -- Check for lux emit nodes, specifically the stone variants, and refusing flux.
    local val = 0;
    if(nod[1])then
        nod[2] = minetest.get_node(nod[1]).name
        if(nod[1] and nod[2] and tonumber(string.sub(nod[2],14)) > 1 and  minetest.get_meta(nod):get_int("occ") ~= 2)then
            minetest.get_meta(nod[1]):set_int("occ", 2)
            luxgate.particles.suffusion(pos,nod[1])
            val = string.sub(nod[2],14) * 8; 
            minetest.set_node(nod[1],{name = "nc_lux:cobble1"})
        else end 
    else end
    return val
end

--[[

            PORTAL CREATION STUFF

]]

luxgate.core.tetris = function(pos, areaparams)
    local structurekey = luxgate.core.whosthere(pos, areaparams);
    local numnum = #luxgate.core.whosthere(pos, areaparams)
    local areagrab = luxgate.core.area(pos,areaparams[1],areaparams[2],areaparams[3])
    local num;
    for ll = 1, #structurekey, 1 do
       if(structurekey[ll] == "true")then
        num = ll;
       else end
    end
        minetest.chat_send_all(minetest.serialize(num))
end


--[[
            LINE SEARCH FUNCTION STUFF
]]


luxgate.core.line_probe = function(pos,dis,dir) -- Searches along a line and returns all positions and nodenames found in a given direction for a given distance.
    local dahta = {nodes_n = {}, nodes_p = {}};
    if(pos and dis and dir)then
    local npos = pos;
    local dir = minetest.string_to_pos(luxgate.dirs[dir])
        for n = 1, dis, 1 do
            local npos = vector.add(npos,vector.multiply(dir,n));
            dahta.nodes_p[n] = npos;
            dahta.nodes_n[n] = minetest.get_node(npos).name
        end
    else end
    -- Verify equal quantity in both tables
    if(#dahta.nodes_n ~= #dahta.nodes_p)then
        dahta = {};
    else end
    return dahta -- Return value should contain 2 tables, 1 with names and 2 with positions of entries in 1.
end

luxgate.core.conscription = function(tab) -- specifically for return values of above function. force loads nodes.
    local rv = 0
    for n = 1, #tab.nodes_n, 1 do
        
        if(tab.nodes_n[n] == "ignore")then
            rv = n;
            break
        else end
    end
    return rv
end


luxgate.core.line_inv = function(table) -- Inspects table for nodenames that require quirky behaviour.
    local out = {noi = {poses = {}, names = {}, flags = {}}};
    local noi = {ignore = {"air","nc_optics:glass"}, reflect = {"nc_lode:block_annealed","nc_optics:glass_opaque","ignore"}, attenuate = {"nc_terrain:stone", "nc_terrain:dirt", "nc_lode:block_tempered"}}
    if(table.nodes_n and table.nodes_p)then
        for n = 1, #table.nodes_n, 1 do
            if(table.nodes_n[n] == noi.ignore[1] or table.nodes_n[n] == noi.ignore[2])then
                out.noi.names[n] = table.nodes_n[n]
                out.noi.poses[n] = table.nodes_p[n]
                out.noi.flags[n] = "traverse"
            elseif(table.nodes_n[n] == noi.attenuate[1] or table.nodes_n[n] == noi.attenuate[2] or table.nodes_n[n] == noi.attenuate[3])then
                out.noi.names[n] = table.nodes_n[n]
                out.noi.poses[n] = table.nodes_p[n]
                out.noi.flags[n] = "attenuate"
            elseif(table.nodes_n[n] == noi.reflect[1] or table.nodes_n[n] == noi.reflect[2] or table.nodes_n[n] == noi.reflect[3])then
                out.noi.names[n] = table.nodes_n[n]
                out.noi.poses[n] = table.nodes_p[n]
                out.noi.flags[n] = "reflect"
            elseif(table.nodes_n[n])then -- Abandoncase
                out.noi.names[n] = table.nodes_n[n]
                out.noi.poses[n] = table.nodes_p[n]
                out.noi.flags[n] = "traverse"
            end
        end

    else end
    return out.noi
end

--[[luxgate.core.atten_calc = function(tab)
 -- Attempt to quantify reduction in distance due to attenuation.(tab must contain tabs; names,poses and flags)
    local magnitude = 0
    local nodes_valid = {names = {"nc_lode:block_tempered","nc_terrain:dirt","nc_terrain:dirt_with_grass","nc_terrain:stone"}, values = {0.7,0.1,0.13,0.2}}
    local vals = {}
        for n = 1, #tab.flags, 1 do
            if(tab.flags[n])then
                for l = 1, #tab.flags[n],1 do
                    vals[n] = 0
                for o = 1, #nodes_valid.names, 1 do
                    if(tab.names[n] == nodes_valid.names[o])then
                        vals[n] = nodes_valid.values[o]
                    else end
                end
            end
            else
            end
        end
        for n = 2, #vals, 1 do -- Increasing the value of attenuation per node based on previous node's value.
            if(vals[n-1] == 0)then
            elseif(vals[n-1] >= 0 and vals[n] > 0 )then -- If there is an attenuating node behind the specified node, then the specified node's value should be increased by some value.
                vals[n] = vals[n]+(vals[n-1]*(n/10)) 
            elseif(vals[n-1] == nil)then
            end
        end
        for k,v in pairs(vals)do
            magnitude = magnitude + v
        end
        vals[#vals+1] = "Magnitude of ".. magnitude
    return vals
end]]

luxgate.core.refl_find = function(tab) -- Find all nodes that can cause ray reflection in the specified path.
    local data = {ind = false, quant = 0, poses = {}, names = {}}
        for n = 1, #tab.flags, 1 do
            if(tab.flags[n] ~= "reflect")then
            elseif(tab.flags[n] == "reflect")then
            data.quant = data.quant + 1;
            data.ind = true;
            data.poses[n] = tab.poses[n]
            data.names[n] = tab.names[n]
            else end
        end
        if(data.quant > 1)then
        local first = {ind = 0, keys = {}} -- We want the first reflective in the node path.
        for k,v in pairs(data.names)do
            first.ind = first.ind + 1
            first.keys[first.ind] = k;
        end
    local first = math.min(unpack(first.keys))
        data.ind = first; -- In this case, we want the lowest key to be prioritized and returned.
        first = nil;
    else end -- data.ind is false by default and when no reflective nodes are present, true if only one is present, and integral when there are multiple.
    return data
end

luxgate.core.refl_redir = function(pos,dir,oldline,rpos) -- essentially creates a new line from a pos, in a new dir, using the remaining data from and oldline
    
end

luxgate.core.incip_dir = function(pos)
-- Scans area, after a verification, searches for specific positions of annealed lode bars to determine which of the 2d primary and secondary cardinal directions to return. if false then reject.
    local data = {
        poses = {{x = pos.x + 2, y = pos.y + 1, z = pos.z + 2},{x = pos.x - 2, y = pos.y + 1, z = pos.z - 2},{x = pos.x + 2, y = pos.y + 1, z = pos.z - 2},{x = pos.x - 2, y = pos.y + 1, z = pos.z + 2}},
        region = {nodes = {}, rods = {}}
    }
    data.region.nodes[1],data.region.nodes[2] = minetest.find_node_near(pos,5,"nc_lode:block_annealed", false), minetest.find_node_near(pos,5,"nc_luxgate:vessicle", false);

    for n = 1, #data.poses, 1 do
        if(minetest.get_node(data.poses[n]).name == "nc_lode:rod_annealed")then
            data.region.rods[n] = "1";
        else data.region.rods[n] = "0";
        end
    end
    for n = 2, #data.region.rods, 1 do
        data.region.rods[1] = data.region.rods[1]..data.region.rods[n];
    end
    data.region.rods = unpack(data.region.rods);
    if(data.region.rods == "1111")then
        data.region.rods = {9,"none"};
    elseif(data.region.rods == "0000")then
        data.region.rods = {10, "any"};
    elseif(data.region.rods == "0101")then
        data.region.rods = {1, "east"};
    elseif(data.region.rods == "1001")then
        data.region.rods = {2, "south"};
    elseif(data.region.rods == "1010")then
        data.region.rods = {3, "west"};
    elseif(data.region.rods == "0110")then
        data.region.rods = {4, "north"};
    elseif(data.region.rods == "0111")then
        data.region.rods = {5, "northeast"};
    elseif(data.region.rods == "1101")then
        data.region.rods = {6, "southeast"};
    elseif(data.region.rods == "1011")then
        data.region.rods = {7, "southwest"};
    elseif(data.region.rods == "1110")then
        data.region.rods = {8, "northwest"};
    else data.region.rods = false;
    end
    return data.region.rods
end
--

--
luxgate.core.searchlight = function(pos, dir, dis, exc) -- Searches for nodes in a radius around a line at invervals.
    local origin = pos;
    local ray = {rate = {x=0,y=0,z=0}, nodes, mods = {}, interval = 10}
    local cess = origin;
    cess = cess + ( vector.multiply(minetest.string_to_pos(luxgate.dirs[dir]), dis) );

    ray.nodes = minetest.find_nodes_with_meta(origin, cess)

end

luxgate.core.recalc = function(original_line, traversed_distance, player)

end


luxgate.core.oregive = function()
    minetest.chat_send_all(minetest.serialize(minetest.registered_nodes["nc_lode:ore"].on_destruct))
end

nodecore.register_craft({
    label = "heat ilmenite and irreversibly reverse polarity",
    action = "cook",
    touchgroups = {flame = 1},
    duration = 5,
    cookfx = true,
    nodes = {
        {
            match = {groups = {paramag}},
            replace = "air"
        }
    }
})
nodecore.register_craft({
    label = "forge ilmenite block",
    action = "pummel",
    toolgroups = {thumpy = 1},
    nodes = {
        {
            match = {name = "nc_luxgate:shard_ilmenite", count = 8},
            replace = "air"
        }
    },
    items = {
        "nc_luxgate:block_ilmenite"
    }
})
