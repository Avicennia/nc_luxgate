local thismod = "nc_luxgate:"


function sl_src(pos,len)
   local ntab = {}
   for n = 1, len, 1 do
    ntab[n] = minetest.get_node({x=pos.x + n,y=pos.y,z=pos.z}).name
   end
   return ntab
end

function sl_comp(tabsamp,tabcont)
    local tft = {}
    if(#tabsamp == #tabcont)then
        for n=1, #tabsamp, 1 do
            if(tabsamp[n] == tabcont[n])then
                tft[n] = 1
            elseif(tabsamp[n] ~= tabcont[n]) then
                tft[n] = 0
            end
        end
    else minetest.chat_send_all("tabulation maximum error!")
end 
return tft 
end
       
function sl_compver(tab)
    local ind = 0
    local ans = nil
    for n=1, #tab, 1 do
        ind = ind + tab[n]
    end
    if (ind == #tab) then
        ans = true
    elseif (ind ~= #tab) then
        ans = false
    end
    return ans
end

function csa_scan(def, pos)
    local total = def.l * def.w;
    local ledgerline = {pos,{x=pos.x,y=pos.y,z=pos.z+1},{x=pos.x,y=pos.y,z=pos.z+2},
    {x=pos.x,y=pos.y,z=pos.z+3},{x=pos.x,y=pos.y,z=pos.z+4}};

end
function structure_scan(def, origin)
    local ppos = origin
    src_iter = def.l * def.w;
    local exes = {}
    local ind = 0
    for l = 1, def.h, 1 do
    for n = 1, def.l, 1 do
        ind = ind + 1
      table.insert(exes,sl_compver(sl_comp(sl_src(origin,def.l),def.csa[ind])))
       origin.z = origin.z + 1
    end
    origin.y = origin.y + 1
    origin.z = origin.z - def.w
end
minetest.chat_send_all(minetest.serialize(exes))
end
function ugid(length)
    local time = minetest.get_us_time()
    local ggl = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
    local presult = {}
    local selvar;
    local result = ""
    for n = 1, length, 1 do
        local rnum = math.random(1,66)
        if(rnum <= 26)then
        table.insert(presult,ggl[rnum])
        elseif(rnum >= 27)then
            table.insert(presult,rnum)
        else end

    end
    for n = 1, #presult, 1 do
        result = result .. presult[n]
    end
    return result
end
--  --  --  --  --  --  --  Particles

function suffusion(pos)
    local orig = pos
    local dest = (minetest.find_node_near(pos, 3, {"group:lux_emit"}, false) or false)
    
    if(orig and dest ~= false)then
    local velv = vector.subtract(orig,dest) or {0,0,0}
    minetest.add_particlespawner({
        amount = 120,
        time = 10,
        minpos = {x=dest.x-0.6, y=dest.y-0.6, z=dest.z-0.6},
        maxpos = {x=dest.x+0.6, y=dest.y+0.6, z=dest.z+0.6},
        minvel = {x=velv.x, y=velv.y, z=velv.z},
        maxvel = {x=velv.x+0.1, y=velv.y+0.1, z=velv.z+0.1},
        minacc = {x=0, y=0, z=0},
        maxacc = {x=0.05, y=0.05, z=0.05},
        minexptime = 0.2,
        maxexptime = 0.9,
        minsize = 0.8,
        maxsize = 1.2,
    
        collisiondetection = false,
        collision_removal = false,
        vertical = false,
        texture = "luxion_anim.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 0.5},
            {
                type = "sheet_2d",
                frames_w = 1,
                frames_h = 6,
                frame_length = 0.5,
            },
        glow = 4
    })
else end
end

--  --  --  --  --  --  --  Bilateral Search
function linesrc(pos, dist, dir)
    local data = {
        copy = {pos, dist, dir},
        pseudo = {samp = {},found = {}}
    }
    for n = 1, dist, 1 do
        local eppos = {x=pos.x + n * 5,y=pos.y,z=pos.z}
        data.pseudo.samp[n] = eppos
        minetest.set_node(eppos, {name = "nc_luxgate:frame_lam"})
        local box = minetest.find_node_near(eppos,2,"nc_luxgate:vessicle",true)
        table.insert(data.pseudo.found,box)
    end
    return data.pseudo.found[1]
end