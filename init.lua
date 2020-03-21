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
        names = {[0] = "air","nc_luxgate:ulvstone_i","nc_luxgate:ulvstone","nc_luxgate:frame_ohm","nc_luxgate:frame_lam","nc_luxgate:frame_v","nc_luxgate:frame_e","nc_lode:rod_annealed","nc_luxgate:vessicle" or "nc_luxgate:vessicleNull","nc_luxgate:ulvstone_c","nc_terrain:stone"}},
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
    chests = {},
    vests = {}
}

dofile(modpath .. "/chromatophore.lua")

dofile(modpath .. "/centrosome.lua")

dofile(modpath .. "/ganglion.lua")

dofile(modpath .. "/nodereg.lua")

luxgate.core.backupquery(false) -- Pull any existing mod storage data for vessicle locations.
