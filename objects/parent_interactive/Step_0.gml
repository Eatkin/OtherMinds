/// @description

// Inherit the parent event
event_inherited();

//Particles
if (global.hardpause==false and scr_on_camera()==true and irandom(60)==0)
	{
		var xx=random(sprite_width)-sprite_xoffset*image_xscale;
		var yy=random(sprite_height)-sprite_yoffset*image_yscale;
		part_particles_create(global.partSys,x+xx,y+yy,global.collectibleParticle,1);
	}