/// @description

if (global.hardpause==true)
	{
		part_system_clear(global.atmPartSys);
		exit;
	}

if (part_particles_count(global.atmPartSys)<maxParticles)
	{
		var xx=random(room_width);
		var yy=random(room_height);
		part_particles_create_colour(global.atmPartSys,xx,yy,global.atmParticle,particleColour,1);
	}