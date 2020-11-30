/// @description lock region, deactivate all bad stuff

with (obj_saw)
	{
		audio_stop_sound(soundplaying);
		soundplaying=noone;
		if (id==inst_6F0D1A86 and scr_event_check_complete(global.officeevents,OFFICEEVENTS.GAUNTLET_COMPLETE)==true)
			{
				instance_destroy(myspikes);
				instance_destroy();
			}
	}
instance_deactivate_object(obj_saw);

with (obj_office_laser)
	{
		instance_deactivate_object(myspikes);
		instance_deactivate_object(myemitter);
	}
instance_deactivate_object(obj_office_laser);

with (obj_cannon)
	{
		activated=false;
	}
	
scr_regionlock(56,68,true);

//Deactivate falling push blocks (except some)
with (parent_push)
	{
		sprite_index=spr_crate;
		if (x!=clamp(x,2736,3056))
			{
				instance_deactivate_object(id);
			}
	}
	
//Reactivate specific instances
instance_activate_object(inst_6259C516);
instance_activate_object(inst_5B3D30D5);
instance_activate_object(inst_47DAE1F7);
instance_activate_object(inst_61341046);
instance_activate_object(inst_6D60A252);
instance_activate_object(inst_247303CD);

if (global.checkpoint[0]==inst_694D051F or global.checkpoint[0]==inst_58991BD)
	{
		scr_regionunlock();
	}
	
if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.GAUNTLET_COMPLETE)==true)
	{
		scr_regionunlock();
		inst_1E3B1DFF.activated=true;
		inst_1E3B1DFF.firerate=60;
		with (obj_gauntletPlatformDrop)
			{
				if (x!=clamp(x,2064,2304) and id!=inst_328C9266)
					{
						instance_destroy();
					}
			}
		//Drop blocks to allow progression in the drop pit
		instance_activate_object(inst_279068AC);
		instance_activate_object(inst_DA9348A);
		instance_activate_object(inst_155B7019);
		instance_activate_object(inst_36B62668);
		instance_activate_object(inst_2FF287C5);
		instance_activate_object(inst_1A223AFB);
		instance_activate_object(inst_3138EC32);
		instance_activate_object(inst_77946BFF);
		instance_activate_object(inst_40D45CDA);
		instance_activate_object(inst_73EF5C97);
		instance_activate_object(inst_74E88097);
		
		//End saw and laser xspeed=0
		inst_73EF5C97.maxspeed=0;
		inst_74E88097.maxspeed=0;
		
		with (obj_block_on)
			{
				activated=true;
			}
			
		with (obj_gauntlet_popoutspikes)
			{
				instance_destroy();
			}
		
		//Adjust positioning of one of the saws
		inst_5B3D30D5.x+=16;
		//Adjust laser position
		inst_74E88097.x-=64;
		
		//Destroy that one snake block that spawns in the air
		with (inst_294152C2)
			{
				for (var i=0; i<4; i+=1)
					{
						instance_destroy(blockinfo[i,0]);
					}
				instance_destroy();
			}
		
		//Die
		instance_destroy();
	}
else
	{
		//Destroy the temporary blocks which help you get the orb
		with (obj_platform_disappearwhenair)
			{
				if (x==clamp(x,2560,2656))
					{
						instance_destroy();
					}
			}
			
		//Destroy the floaty snake block
		with (inst_ABC772E)
			{
				for (var i=0; i<4; i+=1)
					{
						instance_destroy(blockinfo[i,0]);
					}
				instance_destroy();
			}
		with (inst_7979272A)
			{
				for (var i=0; i<4; i+=1)
					{
						instance_destroy(blockinfo[i,0]);
					}
				instance_destroy();
			}
		with (inst_54B682B4)
			{
				for (var i=0; i<4; i+=1)
					{
						instance_destroy(blockinfo[i,0]);
					}
				instance_destroy();
			}
	}