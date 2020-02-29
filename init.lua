local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
tm = thismod..":"


luxgate = {
    ticker = 0,
    tick = false,
    pons = {},
    box = minetest.get_mod_storage(),
    core = {},
    particles = {},
    schem = {},
    nodes = {
        ilmenite = {},
        names = {"nc_luxgate:ulvstone_i","nc_luxgate:ulvstone","nc_luxgate:frame_ohm","nc_luxgate:frame_lam","nc_luxgate:frame_v","nc_luxgate:frame_e","nc_lode:rod_annealed","nc_luxgate:vessicle","nc_luxgate:block_ilmenite","nc_terrain:stone"}},
    nodenumbers = {},
    dirs = {
        {x=1,y=0,z=0},  -- East
        {x=-1,y=0,z=0}, -- West
        {x=0,y=0,z=1}, -- North
        {0,0,-1}, -- South
        {1,0,1}, -- NorthEast
        {-1,0,-1}, -- SouthWest
        {1,0,-1}, -- SouthEast
        {-1,0,1}, -- NorthWest
        {x=1,y=0,z=0},
        {x=1,y=0,z=0}
    },
    bill = {gates = {}}
}



dofile(modpath .. "/smokenmirrors.lua")
dofile(modpath .. "/legothingies.lua")
dofile(modpath .. "/brainything.lua")
dofile(modpath .. "/paramag.lua")
dofile(modpath .. "/nodereg.lua")

luxgate.core.backupquery(false)

minetest.register_abm({
    nodenames = {"nc_luxgate:vessicle"},
    neighbors = {"nc_luxgate:frame_lam"},
    interval = 3,
    chance = 100,
    action = function(pos, node, active_object_count,active_object_count_wider)
        luxgate.core.portalwork(pos)
    end
})



minetest.register_globalstep(function(dtime)
    luxgate.ticker = luxgate.ticker + 0.1
   
end)

minetest.register_globalstep(function(dtime)
    if(luxgate.ticker >= 10)then
        minetest.chat_send_all("vref is: ")
        minetest.chat_send_all(luxgate.box:get_string("vref"))
        minetest.chat_send_all("Gates Is: ")
        minetest.chat_send_all(minetest.serialize(luxgate.bill.gates))
        luxgate.ticker = 0
    else end
end)
