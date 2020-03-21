


--[[

    Utility Functions

]]

luxgate.log = function(thing, t)
    local thing = ((type(thing) == "string") and thing or minetest.serialize(thing))
    t = t or "action"
    return minetest.chat_send_all(thing), minetest.log(t,thing)
end

luxgate.plog = function(pl,th)
    pl = ((type(pl) == "string" and pl) or pl:get_player_name())
    th = ((type(th) == "string" and th) or minetest.serialize(th))
    return minetest.chat_send_player(pl,th)
end

luxgate.repl = function(pos)

local n = minetest.get_node(pos).name

return minetest.remove_node(pos), minetest.set_node(pos, {name = n})
end 

luxgate.veseek = function(pos)
if(luxgate.core.whosthere(pos) and luxgate.core.whosthere(pos) > 0)then
    local posn = tostring(pos.x..pos.y..pos.z..luxgate.core.whosthere(pos))    

    for n = 1, #luxgate.vests, 1 do
        
        if(type(luxgate.vests[n]) == "table")then
            
            local vesn = tostring(luxgate.vests[n].x..luxgate.vests[n].y..luxgate.vests[n].z..luxgate.vests[n].v)


            if(posn == vesn)then
            
                return n
        
            elseif(n == #luxgate.vests and posn ~= vesn)then 
            
                luxgate.repl(pos)
        
            else end
        
        else end

    end
else end
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
    local ans = {}

        if(luxgate.core.unquestionablejudgement(dig,luxgate.numberframe[num]) == "true")then
            
            ans = num;
        
        else ans = 0; 
            --luxgate.log(minetest.serialize(dig))        
        end

        return ans
    else end

end
    


--[[

            Gate Powering Functions

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


--[[

            Gate Vessicle Registering Functions

]]


luxgate.core.shitpost = function(pos) -- checks if the vessicle at pos is registered. If not, assigns it to active.
    local val = luxgate.core.whosthere(pos) 

    if(val and val > 0)then

    local postring = {x = pos.x, y = pos.y, z = pos.z, v = val}

    if(luxgate.vests)then

        table.insert(luxgate.vests,postring)
        luxgate.core.backupquery(true)

    else end

else end

end

luxgate.core.shitunpost = function(pos) -- Removes self from table repository.
    
    local val = luxgate.core.whosthere(pos) 
    
    if(val)then
    pos.v = val
    local postring = minetest.serialize(pos)
    local ind;
    
        for k,_ in pairs(luxgate.vests) do 
        
            if(luxgate.vests[k] == postring)then
                
                local rem = table.remove(luxgate.vests,k)
                return luxgate.log("Removed vessicle with data  "..rem.."  !"),luxgate.core.backupquery(true)

            else end
    
        end
    
        if(ind == nil)then
            luxgate.log("something is wrong here")
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
if(str)then

    local ix, iy, iz, iv = str.x, str.y, str.z, str.v
    
    return {{ix, iy, iz}, iv}
else end

end  


luxgate.core.vestRemove = function(pos)

    local ves = minetest.find_node_near(pos,3,"nc_luxgate:vessicle",true);
    ves.v = (ves and luxgate.core.whosthere(ves)) or nil;
    ves = minetest.serialize(ves);

    for n = 1, #luxgate.vests, 1 do
        if(minetest.serialize(luxgate.vests[n]) == ves)then
        
        luxgate.vests[n] = "R";
        luxgate.core.backupquery(true)
        
            minetest.chat_send_all(n)
        else end
    end

    ves = minetest.deserialize(ves)
    ves.v = nil;
    minetest.remove_node(ves)

end

luxgate.core.vestassert = function(pos)
local tves = minetest.find_node_near(pos, 3, "nc_luxgate:vessicle", true)

return (tves and false) and minetest.set_node(tves,{name = "nc_luxgate:vessicle"})

end
--[[

            Gate Warping Functions

]]

luxgate.core.portalwork = function(pos)
    local button = {x = pos.x, y= pos.y - 1, z = pos.z}
    
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
    
            if(minetest.get_node(button).name == "nc_luxgate:frame_lam")then
        
                local meta = minetest.get_meta(button)
                destin = meta:get_int("gindex")
                if(type(destin) == "number" and type(luxgate.vests[destin]) == "table")then
                    local des = luxgate.vests[destin]
                    ddestin = {x = des.x, y = des.y, z = des.z}
                    --local dt = des.v

                    local namesrc = function(name)
                        local name;
                        for n = 1, #luxgate.chests, 1 do
                            if(luxgate.chests[n] == players[1]:get_player_name())then
                                luxgate.log(minetest.serialize(luxgate.chests))
                                return true
                            else luxgate.log("noname") end
                        end
                    end

                    if(namesrc(players[1]) == true)then
                        return
                    else
                    if(luxgate.core.destiny(pos, button) < minetest.get_meta(pos):get_int("power"))then

                        minetest.get_meta(pos):set_int("power",minetest.get_meta(pos):get_int("power") - luxgate.core.destiny(pos, button))
                    
                        luxgate.particles.cyclicAMP(pos,"luxion_anim.png",1.2, 2)

                        return minetest.after(0.5, function() luxgate.core.geriatrics(players[1],ddestin) end)
                
                    elseif(luxgate.core.destiny(pos, button) == minetest.get_meta(pos):get_int("power") and minetest.get_meta(pos):get_int("power") ~= 0)then
                
                        luxgate.particles.cyclicAMP(pos,"luxion_anim.png",1.2, 2)

                        minetest.after(0.5, function() luxgate.core.geriatrics(players[1],ddestin) end)
                
                        return minetest.set_node(pos, {name = "nc_luxgate:vessicleNull"})--  MAKE PARTICLE EFFECT HERE.

                    else return end
                end
                else end
            else end   

        else end
   
    else end
    
end


luxgate.core.destiny = function(pos,but) -- Calculates rough distance between pos and destination derived from button metadata.
    local des;
    if(but)then
        
        des = luxgate.vests[minetest.get_meta(but):get_int("gindex")]
        des = {x = des.x, y = des.y, z = des.z}

        return vector.distance(pos,des)
    else end

end

luxgate.core.geriatrics = function(user,dest) -- sends player to destination and checks if area is satisfactory for teleport.
    if(user and dest)then
        --local nam = minetest.find_node_near(dest,2,"air",false)
        local st = user:get_pos()
        --if(nam)then
                user:set_pos(dest)
                table.insert(luxgate.chests,user:get_player_name())
                minetest.after(0.5, function()
                luxgate.core.followup(st,user)
            end)
        
        --else end
    else end
end

luxgate.core.followup = function(pos, user)
    local ves = minetest.find_node_near(user:get_pos(),3,"group:luxv",true)
    

    local namef = function(name)
        local na;
        for n = 0, #luxgate.chests, 1 do
            if(luxgate.chests[n] == name)then
                luxgate.chests[n] = nil;
            else end
        end
        return na
    end

    if(ves and luxgate.core.tvot(pos,ves))then
        luxgate.log(minetest.serialize(luxgate.core.tvot(pos,ves)))
    return minetest.after(5, function() namef(user:get_player_name()) end)

    elseif(not ves)then
        
        return user:set_pos(pos), minetest.after(5, function() namef(user:get_player_name()) end)

    elseif(ves and not luxgate.core.tvot(pos,ves))then

        return user:set_pos(pos), minetest.after(5, function() namef(user:get_player_name()) end)

    else end
    return minetest.after(5, function() namef(user:get_player_name()) end)
end



--[[

    CCTP-related Functions

]]

luxgate.core.tumb = function(pos)
    -- West -> South -> North -> East is the order that find_nodes_in_area() seems to select preferentially.
    local pos = minetest.find_node_near(pos,6,"nc_luxgate:frame_lam",true)
    local tumblers = minetest.find_nodes_in_area({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},{x = pos.x + 3, y = pos.y + 1, z = pos.z + 3},"group:alpha_glyph")
    
    if(tumblers and #tumblers >= 1)then
        
        for n = 1, #tumblers,1 do
        tumblers[n] = minetest.get_node(tumblers[n]).name
        end

    return minetest.serialize(tumblers)

    else
    end
end

luxgate.core.tvot = function(p1,p2)
    local p11 = luxgate.core.tumb(p1);
    local p22 = luxgate.core.tumb(p2);
    if(p22 == "" or p22 == nil)then
        p22 = p11
    end
    
    if(not p22 and not p11)then
        return true
    else end

    local t = (p11 == p22)
    luxgate.log(minetest.serialize({p11,p22}))
   return t
end


--[[

            Crafting Recipes

]]

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


-- ABM Functions

minetest.register_abm({
    nodenames = {"nc_luxgate:vessicle"},
    neighbors = {"nc_luxgate:frame_lam"},
    interval = 1,
    chance = 1,
    action = function(pos)
        local val = luxgate.core.whosthere(pos) -- Determine own gender.

    if(val and  type(val) == "number" and val > 0)then -- Check yourself for gender, if you like, then set timer for cooking your brand new turkey.
        luxgate.particles.portalhole(pos) -- Open oven and let nice smelling turkeywater steam particles waft out.
        
        luxgate.core.portalwork(pos) -- Check for turkey doneness with lua_toothpick, If done, grab turkey and fling to location determined by nearby button.        
        else end
    end
})
minetest.register_abm({
    nodenames = {"nc_luxgate:vessicle"},
    neighbors = {"nc_luxgate:frame_lam"},
    interval = 6.5,
    chance = 1,
    action = function(pos)
        minetest.sound_play({name = "gatewaveecho2"}, {pos = pos, max_hear_distance = 18})
    end
})


-- Ore registering function
minetest.register_on_dignode(
    function(pos, oldnode, digger)
        if(oldnode.name == "nc_lode:ore")then
            if(math.random(100) >= 63)then
            local space = minetest.find_node_near(pos,1,"air",false)
        minetest.item_drop(ItemStack("nc_luxgate:shard_ilmenite 1"),digger,space or pos)
            else end
        else end
    end)

-- Chat command functions
minetest.register_chatcommand("lgclear:chest",
{
    params = "<name> <privilege>",
    description = "Remove privilege from player",
    privs = {privs=true},
    func = function(name, param)
       for n = 0, #luxgate.chests, 1 do

        if(name == luxgate.chests[n])then
        
            return (luxgate.chests[n] == name and table.remove(luxgate.chests,n)) or minetest.chat_send_all("erruh")
        
        else end
        
        end
    end
                                  
})

minetest.register_chatcommand("lgvesremove",
{
    params = "<name> <privilege>",
    description = "Remove privilege from player",
    privs = {privs=true},
    func = function(name, param)
        minetest.chat_send_all("chickle")
        luxgate.core.vestRemove(minetest.get_player_by_name(name):get_pos())
    end
                                  
})

minetest.register_chatcommand("lgvesassert",
{
    params = "<name> <privilege>",
    description = "Remove privilege from player",
    privs = {privs=true},
    func = function(name, param)
        local pos = minetest.get_player_by_name(name):get_pos()
        local ves = minetest.find_node_near(pos, 3, "nc_luxgate:vessicle", true)
        return luxgate.veseek(ves)
    end
                                  
})

minetest.register_chatcommand("lglist:msves",
{
    params = "<name> <privilege>",
    description = "Remove privilege from player",
    privs = {privs=true},
    func = function(name, param)

        minetest.chat_send_all(luxgate.box:get_string("vref"))
        if(luxgate.box:get_string("vref") ~= "")then
        luxgate.log(#minetest.deserialize(luxgate.box:get_string("vref")) or "I'm empty")
        else end
    end
                                  
})
minetest.register_chatcommand("lglist:ves",
{
    params = "<name> <privilege>",
    description = "Remove privilege from player",
    privs = {privs=true},
    func = function(name, param)
        minetest.chat_send_all(minetest.serialize(luxgate.vests))
        luxgate.log(#luxgate.vests)
    end
                                  
})

minetest.register_chatcommand("lglist:ves:dupclear",
{
    params = "<name> <privilege>",
    description = "Remove privilege from player",
    privs = {privs=true},
    func = function(name, param)
        for n = 1, #luxgate.vests, 1 do
        local entry = luxgate.vests[n]
        local index = 0

            for o = 1, #luxgate.vests, 1 do
            
                if(entry.x == luxgate.vests[o].x and entry.y == luxgate.vests[o].y and entry.z == luxgate.vests[o].z and entry.v == luxgate.vests[o].v)then
                    index = index + 1
                    
                else end
                luxgate.log(index)
                if(index > 1)then
                        luxgate.vests[o] = "R"
                else end
            
            end
        
        
        
        
        end
    end
                                  
})