
luxgate.dirs = {
"(1,0,0)",  -- East
"(-1,0,0)", -- West
"(0,0,1)", -- North
"(0,0,-1)", -- South
"(1,0,1)", -- NorthEast
"(-1,0,-1)", -- SouthWest
"(1,0,-1)", -- SouthEast
"(-1,0,1)" -- NorthWest
}


luxgate.functions.digitizer = function(tab)
    local nodes = {
        names = {"nc_lode:block_annealed","nc_lode:block_tempered","nc_luxgate:frame_ohm","nc_luxgate:frame_lam","nc_luxgate:frame_v","nc_luxgate:frame_e"},
        output = {}
    }
    for x = 1, #tab, 1 do
        for n = 1, #nodes.names, 1 do
            if(tab[x] == nodes.names[n])then
                nodes.output[x] = n
            else end
        end
    end
    return nodes.output
end

luxgate.functions.papersplease = function(origin, intable, temptable)
    if(origin and intable and outable)then
        local data = {
            incoming = {seq = intable},
            template = {seq = temptable},
            outgoing = {seq}
        }
    else end
end



luxgate.functions.area = function(pos) -- Grabs a 5x5x6 area of nodes and outputs their names as a table.
    local output = {};
    local ori = pos;
    local inc = 0
    for n = 1, 6, 1 do -- Y axis, height.
        for o = 1, 5, 1 do -- Z axis, length.
            for t = 1, 5, 1 do -- X axis, girth. function that does the actual searching.
                ori.x = ori.x + 1
                inc = inc + 1
                output[inc] = minetest.get_node(ori)
            end
            ori.x = ori.x - 5
            ori.z = ori.z + 1
        end
        ori.z = ori.z - 5
        ori.y = ori.y + 1
    end
    return output
end

luxgate.functions.area_decode = function(table) -- Converts certain table values into numbers for interpretation.
    local output = {};
    for n = 1, #table, 1 do
        if(table[n].name == "air")then
            output[n] = 0;
        elseif(table[n].name == luxgate.nodes.names[1])then
            output[n] = 1;
        elseif(table[n].name == luxgate.nodes.names[2])then
            output[n] = 2;
        elseif(table[n].name == luxgate.nodes.names[3])then
            output[n] = 3;
        elseif(table[n].name == luxgate.nodes.names[4])then
            output[n] = 4;
        elseif(table[n].name == luxgate.nodes.names[5])then
            output[n] = 5;
        elseif(table[n].name == luxgate.nodes.names[6])then
            output[n] = 6;
        else output[n] = 9 end
    end
    return output
end

luxgate.functions.unquestionablejudgement = function(table, guess) -- Give table, and template table (guess), and outputs true or false accordingly.
    local output = {}
        if(table and guess)then
        if(#table == #guess)then
    for n = 1, #table, 1 do
        if(table[n] == guess[n])then
            output[n] = true
        else output[n] = false
        end
    end
else 
end
else end
return output
end

luxgate.functions.redlightgreenlight = function(t1)
    local ind = 0
    local dni = 0
    for n = 1, #t1, 1 do
        if(t1[n] == true)then
            ind = ind + 1;
        elseif(t1[n] == false)then
            dni = dni + 1;
        end
    end
    if(ind == #t1)then
        ind = true
    elseif(ind ~= #t1)then
        ind = "Size error " .. #t1 .. " || ".. ind .. " || " .. dni;
else end
    return ind
end

luxgate.functions.modcalc = function(tab)
local modifiers = {"reflect","conduct","attenuate","absorb"} -- For altering actual distance, direction, etc.
local output = {}


end
--[[
            LINE SEARCH FUNCTION STUFF
]]
luxgate.functions.line_probe = function(pos,dis,dir) -- Searches along a line and returns all positions and nodenames found in a given direction for a given distance.
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

luxgate.functions.line_inv = function(table) -- Inspects table for nodenames that require quirky behaviour.
    local out = {noi = {poses = {}, names = {}, flags = {}}};
    local noi = {ignore = {"air","nc_optics:glass"}, reflect = {"nc_lode:block_annealed","nc_optics:glass_opaque",}, attenuate = {"nc_terrain:stone", "nc_terrain:dirt", "nc_lode:block_tempered"}}
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
            elseif(table.nodes_n[n] == noi.reflect[1] or table.nodes_n[n] == noi.reflect[2])then
                out.noi.names[n] = table.nodes_n[n]
                out.noi.poses[n] = table.nodes_p[n]
                out.noi.flags[n] = "reflect"
            elseif(table.nodes_n[n])then
                out.noi.names[n] = table.nodes_n[n]
                out.noi.poses[n] = table.nodes_p[n]
                out.noi.flags[n] = "attenuate_u"
            end
        end

    else end
    return out.noi
end

luxgate.functions.atten_calc = function(tab)
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
            else minetest.chat_send_all("nonattenuate")
            end
        end
        for n = 2, #vals, 1 do -- Increasing the value of attenuation per node based on previous node's value.
            if(vals[n-1] == 0)then
            elseif(vals[n-1] >= 0 and vals[n] > 0 )then
                vals[n] = vals[n]+(vals[n-1]*(n/10))
            elseif(vals[n-1] == nil)then
            end
        end
        for k,v in pairs(vals)do
            magnitude = magnitude + v
        end
        vals[#vals+1] = "Magnitude of ".. magnitude
    return vals
end

luxgate.functions.refl_find = function(tab)
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
    local first = {ind = 0, keys = {}}
        for k,v in pairs(data.names)do
            first.ind = first.ind + 1
            first.keys[first.ind] = k;
        end
    local first = math.min(unpack(first.keys))
        data.ind = first;
        first = nil;
    return data
end
--

--
luxgate.functions.searchlight = function(pos, dir, dist, mod)
    local origin = pos;
    local ray = {rate = {x=0,y=0,z=0}, dir = false, mods = {}}
    local exception;
    local dirs = {"(1,0,0)",  -- East
                   "(-1,0,0)", -- West
                    "(0,0,1)", -- North
                     "(0,0,-1)", -- South
                      "(1,0,1)", -- NorthEast
                       "(-1,0,-1)", -- SouthWest
                        "(1,0,-1)", -- SouthEast
                         "(-1,0,1)"}-- For actually pulling positions for the ray's path.
        if(origin and dir and dist and ray)then
        local looper = {max = 6, cur = 0}
        while(luxgate.functions.forward(origin, dir, dist, ray) == 0 and looper.cur <= looper.max)do
            luxgate.functions.forward(origin, dir, dist, ray)
            looper.cur = looper.cur + 1;
        end
        else end
end

