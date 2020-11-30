//Created 06/10/19
//Last updated 06/10/19

if (teleportenabled==false)
	{
		state=PlayerState.idle;
		exit;
	}

var portpad=instance_place(x,y,obj_teleporter);

//If we somehow slip off the teleport location or something
if (portpad==noone)
	{
		if (sprite_index!=sprite_teleport_backwards)
			{
				state=PlayerState.idle;
				exit;
			}
		else
			{
				scr_play_sound(snd_teleport,0,0);
				scr_set_vibration(1,1,30);
			}
	}

if sprite_index!=sprite_teleport and sprite_index!=sprite_teleport_backwards
	{
		scr_play_sound(snd_teleport,0,0);
		sprite_index=sprite_teleport;
		image_index=0;
		image_speed=1;
		scr_set_vibration(1,1,30);
	}

if sprite_index=sprite_teleport_backwards
	{
		gainoverride=1-image_index/2*image_number;
	}
//Animation end - teleport to destination
if image_index>image_number-1
	{
		if sprite_index=sprite_teleport
			{
				var destinationpad=portpad.destination;
				x=destinationpad.x+destinationpad.sprite_width/2;
				//This places you properly but assumes your yoffset is central
				y=destinationpad.y+destinationpad.sprite_height-sprite_height/2;
				sprite_index=sprite_teleport_backwards;
				image_index=0;
				scr_set_vibration(1,1,30);
			}
		else
			{
				gainoverride=1;
				state=PlayerState.idle;
				exit;
			}
	}