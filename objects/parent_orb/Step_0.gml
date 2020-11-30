/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (instance_exists(obj_transition))
	{
		exit;
	}

//Here I'll move the orb randomly
//Also get collected if colliding with player!
if global.hardpause=1
	{
		scr_pause_alarms();
		exit;
	}
	
if (alarm[0]==1)
	{
		var bounds=4;
		x+=irandom(2)-1;
		y+=irandom(2)-1;
		if x>xstart+bounds
			{
				x-=1;
			}
		if x<xstart-bounds
			{
				x+=1;
			}
		if y>ystart+bounds
			{
				y-=1;
			}
		if y<ystart-bounds
			{
				y+=1;
			}
	}
	
//C9ollected by player
if (collected==true)
	{
		//Collect!
		var emit=instance_create_layer(x,y,layer,obj_sound_emitter)
		emit.soundid=snd_item_collect;
		scr_set_vibration(1,1,10);
		//Add to inventory
		scr_inventory_add();
		scr_itemmap_setcollected();
		scr_roomarray_check_orbs_completed();
		
		//Orange
		if (object_index==obj_orb_orange)
			{
				with (global.currentinstance)	{
					scr_todo_discover(19);
					if (scr_inventory_check_quantity(obj_orb_orange)>=39)
						scr_todo_complete(19);
				}
			}
		
		//Red orbs
		if (object_index==obj_orb_red)
			{
				with (global.currentinstance)	{
					scr_todo_discover(1);
					if (scr_inventory_check_quantity(obj_orb_red)>=27)
						scr_todo_complete(1);
				}
			}
			
		//White orbs
		if (object_index==obj_orb_white)
			with (global.currentinstance)	{
				scr_todo_discover(2);
				if (scr_inventory_check_quantity(obj_orb_white)>=42)
					scr_todo_complete(2);
			}
				
		//Green orbs
		if (object_index==obj_orb_green)
			{
				with (global.currentinstance)	{
					scr_todo_discover(10);
					if (scr_inventory_check_quantity(obj_orb_green)>=50)
						scr_todo_complete(10);
				}
			}
			
		//Useless
		if (object_index==obj_uselessCollectible)
			with (global.currentinstance)	{
				scr_todo_discover(26);
				if (scr_inventory_check_quantity(obj_uselessCollectible)>=52)
						scr_todo_complete(26);
			}
		//Update map enhancer
		scr_mapenhancer_orbupdate();
		if (scr_event_check_complete(global.hint_events,EVENTS_HINTS.VIEWMAP)==false)
			{
				global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.VIEWMAP);
				scr_queue_notification(scr_return_text(399),NOTIFICATION.HINT);
				scr_queue_notification(scr_return_text(679),NOTIFICATION.HINT);
			}
		instance_destroy();
	}
	
//create particles
if (scr_on_camera()==true and irandom(20)==0)
	{
		var xx=random(sprite_width)-sprite_xoffset*image_xscale;
		var yy=random(sprite_height)-sprite_yoffset*image_yscale;
		part_particles_create_colour(global.partSys,x+xx,y+yy,global.orbParticle,particleColour,1);
	}