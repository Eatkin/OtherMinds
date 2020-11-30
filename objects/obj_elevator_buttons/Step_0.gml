/// @description

// Inherit the parent event
event_inherited();

if (global.hardpause==true)
	{
		exit;
	}

if (active==true)
	{
		var player=parent_main_character;
		global.softpause=true;
		if (playerinelevator==false)
			{
				//Check if within the elevator door bounds
				var clearanceleft=(player.bbox_left>obj_elevator_doors.x);
				var clearanceright=(player.bbox_right<obj_elevator_doors.x+sprite_get_width(spr_elevator_doors));
				var ismoving=abs(sign(player.xspeed));
				if (clearanceleft==true and clearanceright==true and ismoving==false)
					{
						playerinelevator=true;
					}
				else
					{
						player.s_hinput=clearanceright-clearanceleft;
					}
			}
		else
			{
				obj_elevator_doors.activated=true;
			}
		//TEMP before I implement a menu
		if (obj_elevator_doors.doorsclosed==true and !instance_exists(obj_elevator_menu))
			{
				active=false;
				instance_create_layer(0,0,layer,obj_elevator_menu);
			}
	}
else
	{
		playerinelevator=false;
	}