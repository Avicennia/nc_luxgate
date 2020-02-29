

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


luxgate.core.transcribe = function(mesa) -- Returns a table containing numerical index values for every name in table <mesa>.
    local out = {};

    for n = 1, #mesa, 1 do
        
        for o = 0, #luxgate.nodes.names, 1 do
        
            if(mesa[n] == luxgate.nodes.names[o])then
                out[n] = o
            else end

        end

    end

    return out
end

luxgate.core.unquestionablejudgement = function(table, guess) -- Give table, and template table (guess), and outputs true or false accordingly.
    local output = {}
    local rv = 0;
        if(table and guess and #table == #guess)then
            for n = 1, #table, 1 do
                if(table[n] == guess[n])then
                output[n] = true
                else output[n] = false
                end
            end
        else return "UNQJ-tablemismatch ERROR" 
        end


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
    local bel = {x = pos.x, y= pos.y -1, z = pos.z}
    local dat = {
        lamb = (minetest.get_node(bel).name == luxgate.nodes.names[4]),
        sample = nil,
        tipo = nil
    };
    
    if(dat.lamb)then
        dat.sample = minetest.get_node({x = bel.x - 1, y = bel.y, z = bel.z}).name
        dat.sample2 = minetest.get_node({x = bel.x, y = bel.y, z = bel.z - 1}).name
    else end

    if(dat.sample == "nc_luxgate:frame_v" and dat.sample2 == "air")then
        dat.tipo = 1
    elseif(dat.sample == "air" and dat.sample2 == "nc_luxgate:frame_v")then
        dat.tipo = 2
    elseif(dat.sample == "nc_luxgate:ulvstone")then
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

    local gat = luxgate.core.area(ori, areaparams[1], areaparams[2], areaparams[3])
    local dig = luxgate.core.transcribe(gat)
    local anton = {}

        if(luxgate.core.unquestionablejudgement(dig,luxgate.numberframe[num]) == "true")then
            
            anton = num;
        
        else anton = 0; 
            
            minetest.chat_send_all(minetest.serialize(dig))
            minetest.chat_send_all(minetest.serialize(luxgate.numberframe[num]))
        
        end

        return anton
    else end

end
    


--[[

            LUX POWER STUFF

]]

luxgate.core.powerpull = function(pos) -- Function for doing crude "energy pull" particle effect by ohmic or power trans frame nodes.

    local nod = {minetest.find_node_near(pos, 2, {"group:lux_cobble"}, false)} -- Check for lux emit nodes, specifically the stone variants, and refusing flux.
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

luxgate.core.powercalc = function(pos) 

    local nod = {minetest.find_node_near(pos, 2, {"group:lux_cobble"}, false)} -- Check for lux emit nodes, specifically the stone variants, and refusing flux.
    local val = 0;
    
    if(nod[1])then

        nod[2] = minetest.get_node(nod[1]).name

        if(nod[1] and nod[2] and tonumber(string.sub(nod[2],14)) > 1 and  minetest.get_meta(nod):get_int("occ") ~= 2)then
            
            minetest.get_meta(nod[1]):set_int("occ", 2)
            
            val = string.sub(nod[2],14) * 8; 
            
            minetest.get_meta(nod[1]):set_int("occ", 0)
        
        else end 
    
    else end
    
    return val
end
--[[

            PORTAL CREATION STUFF

]]


luxgate.core.shitpost = function(pos) -- checks if the vessicle at pos is registered. If not, assigns it to active.
    local val = luxgate.core.whosthere(pos) 
    if(val and val > 0)then
    local postring = pos.x.."x"..pos.y.."y"..pos.z.."z"..val
    if(luxgate.vests)then
        table.insert(luxgate.vests,postring)
        luxgate.core.backupquery(true)
    else end
else end
end

luxgate.core.shitunpost = function(pos) -- Removes self from table repository.
    
    local val = luxgate.core.whosthere(pos) 
    
    if(val)then
    
    local postring = pos.x.."x"..pos.y.."y"..pos.z.."z"..val
    local ind;
    
        for k,_ in pairs(luxgate.vests) do 
        
            if(luxgate.vests[k] == postring)then
                
                local rem = table.remove(luxgate.vests,k)
                return minetest.chat_send_all("Removed vessicle with data  "..rem.."  !"),luxgate.core.backupquery(true)

            else end
    
        end
    
        if(ind == nil)then
        
            minetest.chat_send_all("I am an undocumented, illegal Vessicle, please fix the vessicle census functions!")
    
        else end

    else end

end


luxgate.core.backupquery = function(req)

    if(req == true)then

        luxgate.box:set_string("vref",minetest.serialize(luxgate.vests))
    
    else luxgate.vests = minetest.deserialize(luxgate.box:get_string("vref")) or luxgate.vests
    end

end




luxgate.core.decode = function(str) 

    if(str:find(":"))then
        str = str:sub(6)
    else end


    local x,y,z = string.find(str,"x"),string.find(str,"y"),string.find(str,"z")

    ix, iy, iz, it = tonumber(string.sub(str,1, x - 1)),tonumber(string.sub(str, x + 1, y - 1)),tonumber(string.sub(str, y + 1, z - 1)),tonumber(string.sub(str, z + 1))

return {{ix,iy,iz}, it}
end  


luxgate.core.portalwork = function(pos)
    local button = minetest.find_node_near(pos,5,"nc_luxgate:button",false)
    
    local objs = minetest.get_objects_inside_radius(pos, 1)
    
    if(objs)then

        local players = {}
        local rabble = {}
        
        for n = 1, #objs, 1 do
            if(objs[n]:is_player() == true)then
                table.insert(players, objs[n])
            else table.insert(rabble, objs[n])
            end
        
        end

        if(players[1])then
    
            if(button)then
        
                local meta = minetest.get_meta(button)
                destin = meta:get_string("infotext")
                ddestin = luxgate.core.decode(destin)[1]
                ddestin = {x = ddestin[1],y = ddestin[2], z = ddestin[3]}
        
        
                if(luxgate.core.destiny(pos, button) < minetest.get_meta(pos):get_int("power"))then

                    minetest.get_meta(pos):set_int("power",minetest.get_meta(pos):get_int("power") - luxgate.core.destiny(pos, button))
                    luxgate.core.geriatrics(players[1],ddestin)
                
                elseif(luxgate.core.destiny(pos, button) == minetest.get_meta(pos):get_int("power"))then
                
                    luxgate.core.geriatrics(players[1],ddestin)
                
                    --minetest.set_node(pos, {name = "nc_luxgate:vessicleNull"})  MAKE PARTICLE EFFECT HERE.
                else return end
    
            else end   

        else end
   
    else end
    
end


luxgate.core.destiny = function(pos,but) -- Calculates rough distance between pos and destination derived from button metadata.
    
    if(but)then
        
        des = tonumber(string.sub(minetest.get_meta(but):get_string("infotext"),minetest.get_meta(but):get_string("infotext"):find(";")+1))
    
        return des
    
    elseif(pos and not but)then
        
        but = minetest.find_node_near(pos,4,"nc_luxgate:button",false)
        des = tonumber(string.sub(minetest.get_meta(but):get_string("infotext"),minetest.get_meta(but):get_string("infotext"):find(";")+1))
        
        return des
    
    else end

end

luxgate.core.geriatrics = function(user,dest)
    
    local nam = minetest.get_node(dest).name
    local st = user:get_pos()

    user:set_pos(dest)

    minetest.after(1, function()
        luxgate.core.followup(st,user)
    end) 

end

luxgate.core.followup = function(pos, user)
    local ves = minetest.find_node_near(user:get_pos(),6,"nc_luxgate:vessicle",true)
    
    if(not ves)then

        user:set_pos(pos) 

    else end

end

luxgate.core.xenithcore = function(pos)

    local ps = minetest.find_nodes_in_area({x = pos.x -2, y = pos.y - 2, z = pos.z - 2},{x = pos.x + 2, y = pos.y + 2, z = pos.z + 2},"nc_luxgate:frame_ohm")
    local powarr = 0

    for n = 1, #ps, 1 do
        powarr = powarr + luxgate.core.powerpull(ps[n])
    end
    
    return powarr
end

luxgate.core.holdmycalc = function(pos)
    local ps = minetest.find_nodes_in_area({x = pos.x -2, y = pos.y - 2, z = pos.z - 2},{x = pos.x + 2, y = pos.y + 2, z = pos.z + 2},"nc_luxgate:frame_ohm")
    local powarr = 0

    for n = 1, #ps, 1 do
        powarr = powarr + luxgate.core.powercalc(ps[n])
    end
    
    return powarr
end


nodecore.register_craft({
    label = "heat ilmenite and irreversibly destroy polarity 1",
    action = "cook",
    touchgroups = {flame = 1},
    duration = 10,
    cookfx = true,
    nodes = {
        {
            match = {groups = {paramag = true}},
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
