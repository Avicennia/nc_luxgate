shem_gate_min = {
    id = 1,
	size = {
		y = 4,
		x = 3,
		z = 3
	}
,
	data = {
{name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name = "nc_luxgate:frame_v"}, { name = "nc_luxgate:frame_v", param2 = 22 }, { name = "nc_luxgate:frame_e" }, {name="air"}, 
{ name = "nc_luxgate:frame_e" }, { name = "nc_luxgate:frame_e", param2 = 3 }, {name="nc_luxgate:vessicle"}, { name = "nc_luxgate:frame_e", param2 = 1 }, { name = "nc_luxgate:frame_v", param2 = 2 }, {name="air"}, {name = "nc_luxgate:frame_v"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, {name="air"}, 
{name="air"}, {name="air"}, 

}
}


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
function pshem(pos, shem)
	if(shem == "shem_gate_min")then
minetest.place_schematic({x=pos.x-1,y=pos.y,z=pos.z-1}, shem_gate_min, 0,_, true)
	elseif(shem == "shem_gate_max")then
		minetest.place_schematic({x=pos.x-2,y=pos.y,z=pos.z-1}, shem_gate_max, 0,_, true)
	else return end
end