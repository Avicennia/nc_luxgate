local thismod = "nc_luxgate:"



--  --  --  --  --  --  --  Particles

luxgate.particles.suffusion = function(pos, dest)

    if(pos and dest)then

        local velv = vector.subtract(pos,dest)

        minetest.add_particlespawner({
            amount = 90,
            time = 3,
            minpos = {x=dest.x-0.6, y=dest.y-0.6, z=dest.z-0.6},
            maxpos = {x=dest.x+0.6, y=dest.y+0.6, z=dest.z+0.6},
            minvel = {x=velv.x, y=velv.y, z=velv.z},
            maxvel = {x=velv.x+0.1, y=velv.y+0.1, z=velv.z+0.1},
            minacc = {x=0, y=0, z=0},
            maxacc = {x=0.05, y=0.05, z=0.05},
            minexptime = 0.2,
            maxexptime = 0.9,
            minsize = 1.6,
            maxsize = 2.2,
        
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
function luxgate.particles.portalhole(pos, qty)
    minetest.add_particlespawner({
        amount = qty or 110,
        time = 3,
        minpos = {x=pos.x-1.2, y=pos.y-0.4, z=pos.z-1.2},
        maxpos = {x=pos.x+1.2, y=pos.y+2.1, z=pos.z+1.2},
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

function luxgate.particles.darkchain(pos1, pos2)

    local dirp = vector.direction(pos1, pos2)
    
    minetest.add_particlespawner({
        amount = 100,
        time = 10,
        minpos = {x=pos1.x, y=pos1.y + 0.5, z=pos1.z},
        maxpos = {x=pos1.x, y=pos1.y + 0.5, z=pos1.z},
        minvel = {x=dirp.x, y=dirp.y, z=dirp.z},
        maxvel = {x=dirp.x, y=dirp.y, z=dirp.z},
        minacc = {x=0, y=0, z=0},
        maxacc = {x=0, y=0, z=0},
        minexptime = 2.0,
        maxexptime = 2.1,
        minsize = 1,
        maxsize = 1.2,
    
        collisiondetection = false,
        collision_removal = false,
        vertical = false,
        texture = "darkcurl.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 0.2},
            {
                type = "sheet_2d",
                frames_w = 1,
                frames_h = 4,
                frame_length = 0.1,
            },
        glow = 4
    })

end
function luxgate.particles.powah(pos1, pos2, dir)

    local dirp = vector.direction(pos1, pos2)
    if(dir == "x")then
        dirp.z,dirp.y = 0,0
    elseif(dir == "y")then
        dirp.z,dirp.x = 0,0
    elseif(dir == "z")then
        dirp.y,dirp.x = 0,0
    else end

    minetest.add_particlespawner({
        amount = 100,
        time = 4,
        minpos = {x=pos1.x, y=pos1.y, z=pos1.z},
        maxpos = {x=pos1.x, y=pos1.y, z=pos1.z},
        minvel = {x=dirp.x*2, y=dirp.y, z=dirp.z*2},
        maxvel = {x=dirp.x*2, y=dirp.y, z=dirp.z*2},
        minacc = {x=0, y=0, z=0},
        maxacc = {x=0, y=0, z=0},
        minexptime = 1,
        maxexptime = 1,
        minsize = 1,
        maxsize = 1.2,
    
        collisiondetection = false,
        collision_removal = false,
        vertical = false,
        texture = "darkcurl.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 0.2},
            {
                type = "sheet_2d",
                frames_w = 1,
                frames_h = 4,
                frame_length = 0.1,
            },
        glow = 4
    })

end

function luxgate.particles.seenoevil(player)
    if(player)then
        local pos = player:get_pos()
        player:set_look_vertical(1)
        pos.y = pos.y
        for n = 1, 8, 1 do
        minetest.add_particlespawner({
            amount = 10,
            time = 2,
            minpos = vector.add(pos,vector.divide(luxgate.dirs[n])),
            maxpos = vector.add(pos,vector.divide(luxgate.dirs[n])),
            minvel = {x=0, y=1, z=0},
            maxvel = {x=0, y=2, z=0},
            minacc = {x=0, y=0.3, z=0},
            maxacc = {x=0, y=0, z=0},
            minexptime = 3.0,
            maxexptime = 3.1,
            minsize = 8,
            maxsize = 8,
        
            collisiondetection = false,
            collision_removal = false,
            vertical = true,
            texture = "canvas2.png",
            glow = 4
        })
    end
    
    else end
end


