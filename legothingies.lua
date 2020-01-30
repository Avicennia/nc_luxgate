
shem_gate_max = {
    id = 3,
	size = {
		y = 4,
		x = 5,
		z = 3
	}
,
data = {
    { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, 
    { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "nc_luxgate:frame_lam" }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "nc_luxgate:frame_ohm" }, { name = "nc_luxgate:frame_v", param2 = 14 }, { name = "air", prob = 0 }, { name = "nc_luxgate:frame_v", param2 = 16 }, { name = "nc_luxgate:frame_ohm" }, { name = "nc_luxgate:frame_e", param2 = 3 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, 
    { name = "nc_luxgate:frame_e", param2 = 1 }, { name = "nc_luxgate:frame_ohm" }, { name = "nc_luxgate:frame_v", param2 = 12 }, { name = "nc_luxgate:vessicle"}, { name = "nc_luxgate:frame_v", param2 = 18 }, { name = "nc_luxgate:frame_ohm" }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, 
    { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, { name = "air", prob = 0 }, 
    
    }
}

-- STRUCTURE NUMERIC SCHEMATICS


-- portal frame dimensions are 5x5, ranvier_pads are 3x3

--[[
	values for luxgate.numberframe table structure encoding
1 = max
2 = max_alt
3 = ranvier_pad
]]
luxgate.numberframe = {
	{1,2,10,2,1,2,9,9,9,2,10,9,10,9,10,2,9,9,9,2,1,2,10,2,1,0,0,0,0,0,0,0,0,0,0,0,5,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,8,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,5,0,5,3,0,0,0,0,0,0,0,0,0,0},
	{1,2,10,2,1,2,9,9,9,2,10,9,10,9,10,2,9,9,9,2,1,2,10,2,1,0,0,0,0,0,0,0,5,0,0,0,0,4,0,0,0,0,5,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,3,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,3,0,0,0,0,5,0,0,0,0,0,0,0,0,0,5,0,0,0,0,3,0,0},
	{1,1,1,1,4,1,1,1,1,0,0,0,0,8,0,0,0,0}
}
