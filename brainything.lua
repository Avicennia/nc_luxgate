
-- UTIL
luxgate.core.adiff = function(num1, num2)
    if(num1 <= 0 and num2 >= 0)then
        return math.abs(num1 - num2)
    elseif(num1 >= 0 and num2 <= 0)then
        return math.abs(num1 - num2)
    elseif(num1 <= 0 and num2 <= 0)then
        return math.abs(math.abs(num1) - math.abs(num2))
    else return math.abs(num1 - num2)
    end
end


-- AREA FETCHING THINGY

luxgate.core.area = function(pos,len,wid,hei) -- Grabs a len x wid x hei area of nodes and outputs them as a large table.
    local output = {}; -- NOTE: NOT a corner search
    local ori = pos;
    local inc = 0
    for n = 1, hei, 1 do -- Y axis, height.
        for o = 1, len, 1 do -- Z axis, length.
            for t = 1, wid, 1 do -- X axis, girth. function that does the actual searching.
                ori.x = ori.x + 1
                inc = inc + 1
                output[inc] = minetest.get_node(ori).name
            end
            ori.x = ori.x - len
            ori.z = ori.z + 1
        end
        ori.z = ori.z - wid
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
        elseif(table[n] == luxgate.nodes.names[9])then
            output[n] = 9;
        elseif(table[n] == luxgate.nodes.names[10])then
            output[n] = 10;
        else output[n] = "x" end
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



luxgate.core.knockknock = function(pos) -- finds the node near the node below pos to determine which of the three structures it should be.
    local dat = {
        below = {x = pos.x, y= pos.y -1, z = pos.z},
        lamb = false,
        sample = nil,
        tipo = nil
    };
    if(minetest.get_node(dat.below).name == luxgate.nodes.names[4])then
    dat.lamb = true;
    else end
    
    if(dat.lamb == true)then
        dat.sample = minetest.get_node({x = dat.below.x - 1, y = dat.below.y, z = dat.below.z}).name
        dat.sample2 = minetest.get_node({x = dat.below.x, y = dat.below.y, z = dat.below.z - 1}).name
    else end

    if(dat.sample == "nc_luxgate:frame_v" and dat.sample2 == "air")then
        dat.tipo = 1
    elseif(dat.sample == "air" and dat.sample2 == "nc_luxgate:frame_v")then
        dat.tipo = 2
    elseif(dat.sample == "nc_lode:block_annealed")then
        dat.tipo = 3
else dat.tipo = 0 end
return dat.tipo
end

luxgate.core.whosthere = function(pos) -- Confirms whether structure true passed by unquestionablejudgement is a valid structure and reports which it fits.
    local areaparams;
    local ori = {x = pos.x, y = pos.y, z = pos.z}
    local num = luxgate.core.knockknock(pos)
   if(num == 3)then
    areaparams = {3,3,2}
        ori.y = ori.y - 1
        ori.x = ori.x - 2
        ori.z = ori.z - 1
    elseif(num == 1 or num == 2)then
    areaparams = {5,5,5}
        ori.y = ori.y - 2
        ori.x = ori.x - 3
        ori.z = ori.z - 2
    else end

    if(type(areaparams) == "table" )then
    local gather = luxgate.core.area(ori, areaparams[1], areaparams[2], areaparams[3])
    local digitize = luxgate.core.area_decode(gather)
    local antoninscalia = {}
     --minetest.chat_send_all("batty "..num)
        if(luxgate.core.unquestionablejudgement(digitize,luxgate.numberframe[num]) == "true")then
            antoninscalia = num;
        else antoninscalia = 0; 
            minetest.chat_send_all(minetest.serialize(digitize))
            minetest.chat_send_all(minetest.serialize(luxgate.numberframe[num]))end


        return antoninscalia
    else end
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


luxgate.core.socialmediapost = function(pos) -- checks if the vessicle at pos is registered. If not, assigns it to active.
    local val = luxgate.core.whosthere(pos) 
    if(val)then
    local postring = pos.x.."x"..pos.y.."y"..pos.z.."z"..val
    local ind;
    for n = 0, #luxgate.bill.gates, 1 do
        if(luxgate.bill.gates[n] == postring)then
            ind = n
            return
        else end
    end
    if(ind == nil)then
        table.insert(luxgate.bill.gates,postring)
    else end
else end
end


luxgate.core.decode = function(str)
local x,y,z = string.find(str,"x"),string.find(str,"y"),string.find(str,"z")
ix, iy, iz, it = tonumber(string.sub(str,1, x - 1)),tonumber(string.sub(str, x + 1, y - 1)),tonumber(string.sub(str, y + 1, z - 1)),tonumber(string.sub(str, z + 1))

return {{ix,iy,iz}, it}
end  

luxgate.core.seekout = function(pos)
    local vd = {}
    for _,v in pairs(luxgate.bill.gates)do
        local dc = luxgate.core.decode(v)[1]
        table.insert(vd, {luxgate.core.adiff(pos.x,dc[1]),luxgate.core.adiff(pos.y,dc[2]),luxgate.core.adiff(pos.z,dc[3])})
    end
    return vd
end

luxgate.core.portalwork = function(pos)
    local objs = minetest.get_objects_inside_radius(pos, 1)
    if(objs and #objs > 1)then
        local players = {}
        local rabble = {}
        for n = 1, #objs, 1 do
            if(objs[n]:is_player() == true)then
                table.insert(players, objs[n])
            else table.insert(rabble, objs[n])
            end
        end
        local num = luxgate.core.incip_dir(pos)
   --local tab = luxgate.core.line_probe(pos,250,1).nodes_p[something]
    --if(tab)then
        local dd = luxgate.core.incip_dir(pos)
        
    else end
end

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




luxgate.core.incip_dir = function(pos)
-- Scans area, after a verification, searches for specific positions of annealed lode bars to determine which of the 2d primary and secondary cardinal directions to return. if false then reject.
    local data = {
        poses = {{x = pos.x + 2, y = pos.y - 1, z = pos.z + 2},{x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},{x = pos.x + 2, y = pos.y - 1, z = pos.z - 2},{x = pos.x - 2, y = pos.y - 1, z = pos.z + 2}},
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
    --minetest.chat_send_all(minetest.serialize(data.region.rods))
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
    data.region.rods = data.region.rods or {1}
    return data.region.rods[1]
end
--

--






nodecore.register_craft({
    label = "heat ilmenite and irreversibly reverse polarity",
    action = "cook",
    touchgroups = {flame = 2},
    duration = 5,
    cookfx = true,
    nodes = {
        {
            match = {groups = {paramag = true}},
            replace = "nc_luxgate:block_ilmenite_inv"
        }
    }
})
nodecore.register_craft({
    label = "heat ilmenite and irreversibly destroy polarity 1",
    action = "cook",
    touchgroups = {flame = 1},
    duration = 10,
    cookfx = true,
    nodes = {
        {
            match = {groups = {paramag = true, paramag_r = true}},
            replace = "nc_terrain:stone"
        }
    }
})
nodecore.register_craft({
    label = "heat ilmenite and irreversibly destroy polarity 2",
    action = "cook",
    touchgroups = {flame = 1},
    duration = 10,
    cookfx = true,
    nodes = {
        {
            match = {groups = {paramag_r = true}},
            replace = "nc_terrain:stone"
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
