/// @description States and stuff
// You can write your code in this editor

event_inherited();

scr_states_step();

//Behaviour
if global.currentinstance=id or scr_on_camera()=false or global.softpause=true or global.hardpause=true
	{
		exit;
	}

#region Big Slime
if (name==scr_return_text(373))
	{
		directionfacing=scr_sign_nonzero(global.currentinstance.x-x);
		if (talking==true)
			{
				state=PlayerState.idle;
				timeinstate=0;
				waiting=false;
				
				//Roll for a dialogue
				var dialoguechoice=dialogueprevious+1;
				dialoguechoice=min(2,dialoguechoice);
				if (dialoguechoice==2)
					{
						dialoguecomplete=true;
					}
				dialogueprevious=dialoguechoice;
				if scr_inventory_check(obj_grappa)
					{
						instance_create_layer(x,y,layer,obj_granite_surface);
						scr_inventory_remove(obj_granite_surface,localinventory);
						//Modify text
						text[0]=scr_return_text(386);
						text[1]=scr_return_text(387);
						text[2]=scr_return_text(388);
						//Todo and events
						scr_todo_complete(0,localtodo);
						global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.GRAPPA);
						dialoguechoice=3;
						dialogueprevious=-1;
						with (global.currentinstance)
							{
								scr_todo_complete(11);
							}
						scr_inventory_remove(obj_grappa);
						scr_inventory_add(obj_grappa,localinventory);
					}
				with (global.currentinstance)
					{
						scr_todo_discover(11);
					}
				scr_queue_dialogue_box(text[dialoguechoice]);
				talking=0;
			}
		exit;
	}
#endregion

//A few behaviours
//We'll attack when an enemy is in range and set idling at a random chance (1 in 500 maybe)
var attacking=false;
var idling=false;

//Find the nearest instance and see if its in range
//This is a dumb stupid way of doing it, I should use a for loop and find the ith nearest instance
//If it fulfills the conditions I don't need to find anymore
//If it is outside of attackrange then I can exit
//Easy
//Okay I got rid of the dumb idiot way of doing it
var attackrange=192;
var _nearest;

//Go from the second nearest instance and do some checks to see if its valid
for (i=2; i<=instance_number(parent_possessable);i+=1)
	{
		//We don't need to refind the 2nd nearest instance because we've already found it
		_nearest=scr_instance_nth_nearest(x,y,parent_possessable,i);
		
		//Range check
		if distance_to_object(_nearest)>attackrange
			{
				_nearest=noone;
				break;
			}
		//Check if we should attack the found instance
		//This is nested so to break the loop if all conditions are passed
		if _nearest.enemiesattackenabled=false
			{
				_nearest=noone;
				continue;
			}
		else
			{
				//Check for line of sight
				//The object is not in line of sight if off camera to avoid stupid stuff happening
				if collision_line(x,y,_nearest.x,_nearest.y,obj_solid,false,true)!=noone or scr_on_camera(_nearest)=false
					{
						_nearest=noone;
						continue;
					}
				else
					{
						if _nearest.state=PlayerState.defeated or _nearest.state=PlayerState.dead
							{
								_nearest=noone;
								continue;
							}
						break;
					}
			}
	}
	
if _nearest!=noone
	{
		attacking=true;
	}
else
	{
		idling=true;
	}
	
//We can go attack that nearest instance
if attacking=true
	{
		var jumprange=32; //This is the distance at which the gloop tries to jump at the object
		var nearestx=_nearest.x+_nearest.sprite_width*0.5-_nearest.sprite_xoffset;
		var attackdirection=scr_sign_nonzero(nearestx-x);
		var attackdistance=abs(nearestx-x);
		//The gloop commits to any jump it makes
		if state=PlayerState.air
			{
				s_jumphold=true;
				s_hinput=sign(xspeed);
				if xspeed=0
					{
						s_hinput=attackdirection;
					}
			}
		else
			{
				s_hinput=attackdirection;
			}
		
		//At the very least we turn to face the enemy and wake up
		directionfacing=attackdirection;
		waiting=false;
		
		//Let's make sure we're not about to fall off a cliff - slow down if one is detected
		/*This is where the code is failing!
		BIG LETTERS TO CATCH MY ATTENTION!!!!*/
		if !position_meeting(x+attackdirection*16,bbox_bottom+1,obj_solid) and !position_meeting(x+attackdirection*16,bbox_bottom+1,obj_semisolid)
			{
				//We commit to a jump though
				if state!=PlayerState.air
					{
						s_hinput=0;
					}
			}
		//Jump at the enemy if they are close enough - small random element
		if attackdistance<jumprange and irandom(10)=0
			{
				s_jump=true;
			}
	}

//Now we also want to jump when they are 'crowded' by objects
if instance_position(x,y,parent_possessable)!=id and instance_position(x,y,parent_possessable)!=noone
	{
		//Add a little randomness to it
		if irandom(60)=0
			{
				s_jump=true;
			}
	}
	
	
//Idling around behaviour
if idling=true
	{
		//"Hold" jump when jumping
		if state=PlayerState.air
			{
				s_jumphold=true;
			}
		//Firstly we check if we're moving and do cliff checks, then roll to check if we want to stop moving
		//We have the stopping variable to determine whether we have rolled to slow down and stop
		//When we've stopped we reset that
		var movementdir=sign(xspeed);
		if movementdir=0
			{
				stopping=false;
			}
		if place_meeting(x+movementdir*8,y,obj_solid)
			{
				stopping=true;
			}
		if !position_meeting(x+movementdir*16,bbox_bottom+1,obj_solid) and !position_meeting(x+movementdir*16,bbox_bottom+1,obj_semisolid)
			{
				stopping=true;
			}
		if movementdir!=0 and stopping=false
			{
				s_hinput=movementdir;
				var roll=irandom(100)
				//Roll for a jump but NOT on a button
				if (roll==0 and !place_meeting(x,y,obj_button_on_off))
					{
						s_jump=true;
					}
				//Roll for whether to decide to shop
				if roll>98
					{
						stopping=true;
					}
			}
		var roll=-1;
		//There's a 1/200 chance if asleep to idle around or 1/500 if not (or whatever)
		if waiting=true
			{
				var roll=irandom(100);
			}
		else
			{
				var roll=irandom(200);
			}

		//Wake up and determine a direction if random chance occurs - only if we're not already moving
		if roll=0 and movementdir=0
			{
				var _dir=choose(-1,1);
				var cancel=false;
				//Check for a cliff (both directions, set cancel to true if we can't move)
				if !position_meeting(x+_dir*16,bbox_bottom+1,obj_solid) and !position_meeting(x+_dir*16,bbox_bottom+1,obj_semisolid)
					{
						_dir=-_dir;
						if !position_meeting(x+_dir*16,bbox_bottom+1,obj_solid) and !position_meeting(x+_dir*16,bbox_bottom+1,obj_semisolid)
							{
								cancel=true;
							}
					}
				//This will start moving and won't stop unti a roll stops it
				if cancel=false
					{
						s_hinput=_dir;
					}
			}
	}
