local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
tm = thismod..":"


luxgate = {
    core = {},
    particles = {},
    schem = {},
    nodes = {
        ilmenite = {},
        names = {"nc_lode:block_annealed","nc_lode:block_tempered","nc_luxgate:frame_ohm","nc_luxgate:frame_lam","nc_luxgate:frame_v","nc_luxgate:frame_e","nc_lode:rod_annealed","nc_luxgate:vessicle","nc_luxgate:block_ilmenite","nc_luxgate:block_ilmenite_inv"}},
    nodenumbers = {},
    dirs = {
        "(1,0,0)",  -- East
        "(-1,0,0)", -- West
        "(0,0,1)", -- North
        "(0,0,-1)", -- South
        "(1,0,1)", -- NorthEast
        "(-1,0,-1)", -- SouthWest
        "(1,0,-1)", -- SouthEast
        "(-1,0,1)" -- NorthWest
        }
}

dofile(modpath .. "/smokenmirrors.lua")
dofile(modpath .. "/legothingies.lua")
dofile(modpath .. "/brainything.lua")
dofile(modpath .. "/paramag.lua")
dofile(modpath .. "/nodereg.lua")
