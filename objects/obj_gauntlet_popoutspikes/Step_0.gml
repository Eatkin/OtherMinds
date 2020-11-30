/// @description

//Stay dormant until activated

if (global.hardpause)
	exit;

if (activated)
	{
		instance_activate_object(mySpikes);
		if (y==ystart)
			{
				var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
				emit.soundid=popUpSound;
				scr_set_proximity_vib(128,0.5,1);
				scr_camera_screenshake_y(3);
			}
		var ytarget=ystart-16;
		ytarget=16*round(ytarget/16);
		y=lerp(y,ytarget,0.5);
		if (abs(y-ytarget)<1)
			{
				y=ytarget;
				//activated=false;
			}
		mySpikes.x=x;
		mySpikes.y=y;
		
		//Particles
		if (scr_on_camera()==true and irandom(60)==true)
			{
				//Okay these have origin top left
				//They are also rotated to arbitrary angles, so we must consider that
				var xx=x+random(sprite_width)*dcos(image_angle)+random(sprite_height*0.25)*dsin(image_angle);
				var yy=y+random(sprite_width)*dsin(image_angle)+random(sprite_height*0.25)*dcos(image_angle);
				part_particles_create(global.partSys,xx,yy,global.collectibleParticle,1);
			}
	}
else
	{
		if (instance_exists(mySpikes))
			{
				instance_deactivate_object(mySpikes);
			}
		y=lerp(y,ystart,0.2)
		if (abs(y-ystart)<1)
			{
				y=ystart;
			}
	}