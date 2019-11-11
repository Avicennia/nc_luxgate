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
