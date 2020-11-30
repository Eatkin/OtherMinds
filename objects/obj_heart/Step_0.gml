/// @description

event_inherited();

if global.hardpause=true
	{
		scr_pause_alarms();
		exit;
	}
	
//Flash 
if alarm[0]%5=0 and alarm[0]>0
	{
		visible=visible^1;
	}

//Don't execute any code whilst off camera
if scr_on_camera()=false or collectable=false
	{
		exit;
	}
	
//Move y pos
y=ystart+2*dcos(timer);
timer+=1;

var _list=ds_list_create();

if place_meeting(x,y,parent_possessable)
	{
		var char=instance_place(x,y,parent_possessable)
		var _hp=char.hp;
		var _hpmax=char.hpmax;
		if (object_is_ancestor(char.object_index,parent_main_character)==true)
			{
				_hpmax=scr_return_adjusted_hpmax();
			}
		if _hp<_hpmax and _hp>=0
			{
				var emit=instance_create_layer(x,y,layer,obj_sound_emitter)
				emit.soundid=snd_heart_regen;
				char.hp+=1;
				if (object_is_ancestor(char.object_index,parent_main_character)==true)
					{
						global.Edhealth+=1;
					}
				instance_destroy();
				scr_set_vibration(1,1,5);
			}
	}
	
ds_list_destroy(_list);