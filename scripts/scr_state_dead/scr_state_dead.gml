//Created 06/10/19
//Last updated 06/10/19

//This is one where main characters and enemies branch off

if (object_get_parent(object_index)==parent_main_character)
	{
		image_speed=0;
		image_index=image_number-1;
		global.Edhealth=hpmax;
		global.restarting=true; //This makes sure not to update the previous_room variable
		if (!instance_exists(obj_transition))
			{
				global.deaths+=1;
				scr_create_transition(TRANSITION.T_IN);
			}
		else if (obj_transition.transitioncomplete==true)
			{
				/*Secret tutorial
				Scrapped
				Now found in the beta levels area
				if (room==room_EdSpace1_1 and global.localdeaths>4)
					room_goto(rm_secret_tutorial);
				else*/
				room_restart();
			}
			
		repeat(abs(ceil(yspeed)))
			{
				if (!interactwithblocksenabled)
					y+=sign(yspeed);

				//This also has to make sure we aren't IN a semisolid otherwise we just kind of stay there looking dumb
				else if (!place_meeting(x,y+sign(yspeed),obj_solid) and (!place_meeting(x,y+sign(yspeed),obj_semisolid) or place_meeting(x,y,obj_semisolid)))
					y+=sign(yspeed);
				else
					{
						if (explodeonwallsenabled)
							{
								var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
								emitter.soundid=sound_explode;
								instance_destroy();
							}
						yspeed=0;
					}
			}
		if (y>room_height+sprite_height)
			{
				y=room_height+sprite_height;
				yspeed=0;
			}
	}
else
	{
		//Move enemy really far away and make invisible
		if (visible==true)
			{
				visible=false;
				x=-1000;
				y=-1000;
			}
			
		if (!respawnenabled)
			exit;
		//Make sure camera isn't zoomed in UNLESS there's a zoom object
		var camwidth;
		with (obj_camera)
			camwidth=camera_get_view_width(camera);
			
		if (camwidth!=obj_camera.thecamwidth and !instance_exists(cam_zoom_controller))
			exit;

		//This sets the enemy to respawn when it's 1.1 screen width's away from player in both directions
		var player=instance_nearest(xstart,ystart,parent_main_character);
		//var camw=camera_get_view_width(view_camera[0]);
		var camh=camera_get_view_height(view_camera[0]);
		//var dist=sqrt(sqr(camw/2)+sqr(camh/2))*1.3;
		var oncamera=false;
		x=xstart;
		y=ystart;
		oncamera=scr_on_camera();
		x=-1000;
		y=-1000;
		if (!place_meeting(xstart,ystart,obj_solid) and point_distance(xstart,ystart,player.x,player.y)>=camh and !oncamera)
			{
				x=xstart;
				y=ystart;
				visible=1;
				hp=hpmax;
				state=PlayerState.idle;
			}
	}