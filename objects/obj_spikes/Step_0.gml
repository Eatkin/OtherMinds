/// @description

if (global.hardpause)
	exit;
	
if (scr_on_camera()==true and irandom(60)==true)
	{
		//Okay these have origin top left
		//They are also rotated to arbitrary angles, so we must consider that
		//Note the -sins, because y-axis is inverted
		var xx=x+random(sprite_width)*dcos(image_angle)-random(sprite_height*0.25)*dsin(image_angle);
		var yy=y-random(sprite_width)*dsin(image_angle)+random(sprite_height*0.25)*dcos(image_angle);
		part_particles_create(global.partSys,xx,yy,global.collectibleParticle,1);
	}