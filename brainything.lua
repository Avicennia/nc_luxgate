
luxgate.dirs = {
"(1,0,0)",  -- East
"(-1,0,0)", -- West
"(0,0,1)", -- North
"(0,0,-1)", -- South
"(1,0,1)", -- NorthEast
"(-1,0,-1)", -- SouthWest
"(1,0,-1)", -- SouthEast
"(-1,0,1)"}


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
--

--
luxgate.functions.forward = function(origin, dir, dist, ray)
    local exception = 0;
    for n = 1, dist, 1 do
        local dir_new = minetest.string_to_pos(luxgate.dirs[dir]); -- Turning specified dir_index into a vector for use.
        ray.rate.x,ray.rate.z = ray.rate.x + dir_new.x,ray.rate.z + dir_new.z; -- Using said values to affect rate.
        vector.add(origin,ray.rate); -- Adding rate value to original pos.
        local ahead = minetest.get_node(vector.add(origin, ray.rate)).name; -- Node in front of last checked pos.
            if(ahead == "air")then
                newpos = {x=origin.x + ray.rate.x, y= origin.y + ray.rate.y, z= origin.z + ray.rate.z}
                minetest.set_node(newpos, {name = "nc_lode:block_annealed"})
            else exception = ahead return end
    end
    return exception
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

