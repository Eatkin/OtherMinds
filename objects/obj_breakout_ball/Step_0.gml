/// @description

if (global.hardpause==true)
	{
		exit;
	}
	
if (activated==true)
	{
		var playsound=false;
		_speed+=0.001;
		var maxspeed=4;
		if (scr_return_difficulty()>=DIFFICULTY.HARD)
			{
				_speed+=0.0001;
				maxspeed=5;
			}
		else if (scr_return_difficulty()<=DIFFICULTY.EASY)
			{
				_speed-=0.0001;
				maxspeed=3;
			}
		_speed=clamp(_speed,0,maxspeed);
		//Now move around and collide and stuff
		var xsp=_speed*cos(angle);
		var ysp=_speed*sin(angle);
		var xrepeats=max(ceil(abs(xsp)),1);
		for (var i=0; i<xrepeats; i+=1)
			{
				if (place_meeting(x+sign(xsp),y,obj_solid) or place_meeting(x+sign(xsp),y,obj_breakout_paddle))
					{
						xsp=-xsp;
						playsound=true;
					}
				var breakblock=instance_place(x+sign(xsp),y,obj_breakout_block)
				if (breakblock!=noone)
					{
						xsp=-xsp;
						instance_destroy(breakblock);
						playsound=true;
					}
				//Need to apply residues here
				x+=sign(xsp)*min(abs(i-abs(xsp)),1);
			}
		var yrepeats=max(ceil(abs(ysp)),1);
		for (var i=0; i<yrepeats; i+=1)
			{
				if (place_meeting(x,y+sign(ysp),obj_solid))
					{
						ysp=-ysp;
						playsound=true;
					}
				var breakblock=instance_place(x,y+sign(ysp),obj_breakout_block)
				if (breakblock!=noone)
					{
						ysp=-ysp;
						instance_destroy(breakblock);
						playsound=true;
					}
				if (place_meeting(x,y+sign(ysp),obj_breakout_paddle))
					{
						//This is different because we want to alter the angle based on how far along the paddle we collide
						//angle=whatevers
						var my_x=x-obj_breakout_paddle.x;
						//This gives us a number between 0 and 1 depending where we hit the paddle
						var x_proportion=my_x/obj_breakout_paddle.sprite_width;
						x_proportion-=0.5;
						angle=-90+x_proportion*60;
						angle=degtorad(angle);
						//angle=-pi*0.5+y_proportion*pi*0.2;
						xsp=_speed*cos(angle);
						ysp=_speed*sin(angle);
						playsound=true;
					}
				
				//Residues pls
				y+=sign(ysp)*min(abs(i-abs(ysp)),1);
			}
			
		if (playsound==true)
			{
				//PLAY DE SOUND
				var snd=audio_play_sound(snd_menu_confirm,0,false);
				audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
				audio_sound_pitch(snd,1.5+random(0.1));
				scr_set_vibration(0.7,0.7,10);
			}
			
		//Now resolve the speeds to return the new angle
		angle=arctan2(ysp,xsp);
	}