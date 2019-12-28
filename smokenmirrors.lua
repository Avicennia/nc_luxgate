local thismod = "nc_luxgate:"



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
function portalhole(pos)
    minetest.add_particlespawner({
        amount = 110,
        time = 3,
        minpos = {x=pos.x-1.2, y=pos.y-2.4, z=pos.z-1.2},
        maxpos = {x=pos.x+1.2, y=pos.y+0.1, z=pos.z+1.2},
        minvel = {x=0, y=0.2, z=0},
        maxvel = {x=0, y=0.4, z=0},
        minacc = {x=0, y=0, z=0},
        maxacc = {x=0, y=1, z=0},
        minexptime = 0.2,
        maxexptime = 1.2,
        minsize = 1,
        maxsize = 1.6,
    
        collisiondetection = false,
        collision_removal = false,
        vertical = true,
        texture = "luxion_anim.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 0.8},
            {
                type = "sheet_2d",
                frames_w = 1,
                frames_h = 6,
                frame_length = 0.1,
            },
        glow = 4
    })

end

--  --  --  --  --  --  --  Beam Search
