if (global.checkpoint[0]==inst_6F853F63)
	{
		var repeats=obj_music_controls.position;
		repeat (repeats)
			{
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
			}
	}