/// @description

if (global.hardpause==true)
	{
		exit;
	}
	
if (timer==0)
	{
		timer=timermax;
		if (delay>0)
			{
				delay-=1;
				exit;
			}
		//Update block pos
		var xvec=dcos(dir);
		var yvec=dsin(dir);
		//This starts with the back block and shifts it to the next block pos
		for (var i=3; i>0; i-=1)
			{
				blockinfo[i,1]=blockinfo[i-1,1];
				blockinfo[i,2]=blockinfo[i-1,2];
			}
		//Then we update the leading block
		blockinfo[0,1]+=16*xvec;
		blockinfo[0,2]+=16*yvec;
		//Now physically shift all the blocks
		for (var i=0; i<4; i+=1)
			{
				blockinfo[i,0].x=blockinfo[i,1];
				blockinfo[i,0].y=blockinfo[i,2];
			}
		//Check for the last block colliding with a bomb block
		var _reset=false;
		with (blockinfo[3,0])
			{
				if (place_meeting(x,y,obj_bomb_outline))
					{
						_reset=true;
					}
			}
		//Check for an arrow block with the leading block
		with (blockinfo[0,0])
			{
				scr_play_sound(snd_platform_tick,false,0);
				var arrow=instance_place(x,y,obj_arrow_outline);
			}
		if (arrow!=noone)
			{
				dir=-arrow.image_angle;
			}
		if (_reset==true)
			{
				for (var i=0; i<4; i+=1)
					{
						instance_destroy(blockinfo[i,0]);
					}
				var newsnake=instance_create_layer(xstart,ystart,layer,object_index);
				newsnake.dir=startdir;
				newsnake.startdir=startdir;
				instance_destroy();
			}
	}
	
timer-=1;