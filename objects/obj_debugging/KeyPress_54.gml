/// @description Ed debug
// You can write your code in this editor

if (global.debugging=false or global.maincharacter==obj_Charlotte)
	{
		exit;
	}
	
if (!instance_exists(obj_Ed))
	{
		exit;
	}

if obj_Ed.state=PlayerState.debug
	{
		obj_Ed.state=PlayerState.idle;
	}
else
	{
		obj_Ed.state=PlayerState.debug;
	}

//Explode if you use this during a time trial
if (instance_exists(obj_timetrial))
	{
		with (obj_Ed)
			{
				scr_play_sound(snd_pop,0,0);
				instance_create_layer(x,y,layer,obj_smoke);
				state=PlayerState.dead;
				visible=false;
				if distance_to_object(global.currentinstance)<240
					{
						scr_set_vibration(1,1,15);
					}
			}
	}