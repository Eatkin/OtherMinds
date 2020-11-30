/// @description

if global.hardpause=true
	{
		image_speed=0;
		exit;
	}
	
image_speed=1;

if (scr_on_camera()==true and irandom(30)==0)
	{
		var yy=y-irandom(7); //This is the number of pixels above the centre that encompasses the torch
		var xx=x-2+irandom(4); //Width of the actual flame
		part_particles_create(global.partSys,xx,yy,global.torchParticle,1);
	}