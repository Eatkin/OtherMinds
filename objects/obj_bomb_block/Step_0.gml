/// @description

// Inherit the parent event
event_inherited();

if (global.hardpause==true)
	{
		scr_pause_alarms();
		image_speed=0;
		exit;
	}

if (alarm[0]>0)
	{
		xstart=x;
		ystart=y;
	}

if (exploding==true)
	{
		explodetimer-=1;
		image_speed=1;
	}
else if ((x!=xstart or y!=ystart))
	{
		exploding=true;
		explodetimer=explodetimermax;
	}

if (exploding==false)
	{
		image_speed=0;
		image_index=0;
	}
	
if (exploding==true and explodetimer%room_speed==0 and explodetimer!=0)
	{
		var _text=instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,"objects",obj_text);
		_text.text=string(explodetimer/room_speed);
		emit=instance_create_layer(x,y,layer,obj_sound_emitter);
		emit.soundid=snd_bomb_beep;
		emit.pitchoverride=1+(3-explodetimer/room_speed)*0.2;
	}
	
if (explodetimer<=0)
	{
		var snd=instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,"objects",obj_sound_emitter);
		snd.soundid=snd_cannon_destroy;
		instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,"objects",obj_smoke);
		explodetimer=explodetimermax;
		exploding=false;
		var range=24;
		var x1=x-range;
		var x2=x+sprite_width+range
		var y1=y-range;
		var y2=y+sprite_height+range;
		
		var vibamount;
		var dist=distance_to_object(global.currentinstance);
		var maxdist=365; //Arbitrary
		if (dist<maxdist)
			{
				//If we're within 64 then full vib applies
				vibamount=1-min(0.5,max(0,(dist-64))/maxdist);
				scr_set_vibration(vibamount,vibamount,20);
				var shake=4*vibamount;
				with (global.currentinstance)
					{
						scr_camera_screenshake_x(shake);
						scr_camera_screenshake_y(shake);
					}
			}

		with (parent_possessable)
			{
				if (x==clamp(x,x1,x2) and y==clamp(y,y1,y2))
					{
						scr_get_hurt();
					}
			}
		with (obj_crackedblock)
			{
				if (x==clamp(x,x1,x2) and y==clamp(y,y1,y2))
					{
						instance_destroy();
					}
			}
		var _id=id;
		with (obj_bomb_block)
			{
				if (id!=_id and x==clamp(x,x1,x2) and y==clamp(y,y1,y2))
					{
						explodetimer=irandom(15);
						exploding=true;
					}
			}
		with (obj_tet_block)
			{
				if (x==clamp(x,x1,x2) and y==clamp(y,y1,y2))
					{
						instance_destroy();
					}
			}
		instance_destroy();
	}
	
if (y>room_height)
	{
		exploding=false;
		instance_destroy();
	}