/// @description

if (global.hardpause==true)
	{
		exit;
	}
	
popouttime-=1;
if (popouttime<=0)
	{
		popouttime=popouttimemax;
		poppedout=poppedout^1;
		//Mirror the coordinates because there's some hitbox shit that's annoying and it gets them out the way
		x=-x;
		y=-y;
		var emitter=instance_create_layer(x,y,layer,obj_sound_emitter);
		emitter.soundid=snd_spikes_eject;
		var vibamount;
		var dist=distance_to_object(global.currentinstance);
		var maxdist=128;
		if (dist<maxdist)
			{
				vibamount=1-min(0.5,dist/maxdist);
				scr_set_vibration(vibamount,vibamount,10);
			}
		if (poppedout==false)
			{
				emitter.gainoverride=0.9;
			}
		
		//Add some screenshake!
		scr_camera_screenshake_y(2);
	}