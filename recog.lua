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
    local rnum = math.random(1,67)
    local ggl = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
    local presult = {}
    local selvar;
    local result = ""
    for n=1, length/2, 1 do
        local num = math.random(1,27)
        selvar = ggl[num]
        presult[n] = selvar
        if(num > 11)then
            presult[length-n] = math.random(1,num)
        else presult[length-n] = ggl[num]
        end
    end
    for n=1, #presult - 1, 1 do
        result = result..presult[n] or "x"
    end
    return result
end