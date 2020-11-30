/// @description Step code for movement etc
// You can write your code in this editor

event_inherited();

scr_states_step();

if global.currentinstance=id or global.hardpause=true or global.softpause=true
	{
		exit;
	}
	
if (talking==true)
	{
		var otherx=parent_main_character.x;
		directionfacing=scr_sign_nonzero(otherx-x);
		//Roll for a dialogue
		var dialoguechoice=dialogueprevious+1;
		dialoguechoice=min(dialoguechoice,dialoguemax);
		dialogueprevious=dialoguechoice;
		scr_queue_dialogue_box(text[dialoguechoice]);
		talking=0;
		if dialoguechoice=dialoguemax
			{
				dialoguecomplete=true;
			}
	}

//behaviours! there aren't many
	
//Cliff edge, move away
//Also local vars
var followplayer=false;
var overpit=false;
/*
if (state==PlayerState.cliffedge)
	{
		var cliffedge=0;
		if !instance_position(bbox_left,bbox_bottom+2,obj_solid) and !instance_position(bbox_left,bbox_bottom+2,obj_semisolid)
			{
				cliffedge=-1;
			}

		if !instance_position(bbox_right,bbox_bottom+2,obj_solid) and !instance_position(bbox_right,bbox_bottom+2,obj_semisolid)
			{
				cliffedge=1;
			}

		s_hinput=-cliffedge;
	}*/

var player=instance_nearest(x,y,parent_main_character);
var dist=abs(player.x-x);
var mindist=16;
var maxdist=112;
var _dir=sign(player.x-x);
var collision=collision_line(x,bbox_top,player.x,player.bbox_top,obj_solid,false,true);
if (dist==clamp(dist,mindist,maxdist) and collision==noone and y==clamp(y,player.y-128,player.y+128))
	{
		followplayer=true;
	}
	
if (followplayer==true)
	{
		s_hinput=_dir;
	}
if (place_meeting(x+sign(xspeed)*max(abs(xspeed)*2,4),y,obj_solid) and state!=PlayerState.air)
	{
		s_jump=true;
	}

//This jumps at any cliff edges detected
var col_pos=x+xspeed*2;
if (state!=PlayerState.air and !place_meeting(col_pos,y+1,obj_solid) and !place_meeting(col_pos,y+1,obj_semisolid) and col_pos==clamp(col_pos,0,room_width))
	{
		s_jump=true;
	}

//Hold jump and try go back to xsafe
if (state==PlayerState.air)
	{
		s_jumphold=true;
		//Check if we're over a 'bottomless' pit (actually only checks approx 1.5x screen height)
		if (followplayer==false)
			{
				overpit=true;
				for (var i=1; i<=8; i+=1)
					{
						if (place_meeting(x,y+32*i,obj_solid) or place_meeting(x,y+32*i,obj_semisolid))
							{
								overpit=false;
								break;
							}
					}
				//So we try go to safety if over a hole, otherwise we just commit to the jump we made UNLESS we are within a larger range of the player
				if overpit=true
					{
						var safedist=abs(xsafe-x);
						var safedir=sign(xsafe-x);
						if (safedist>16)
							{
								//This has purpose - there is a quicker turnaround time if we release all keys and then re-press
								if (sign(xspeed)!=-safedir)
									{
										s_hinput=safedir;
									}
							}
					}
				else if (xspeed!=0 and dist>maxdist*2)
					{
						s_hinput=sign(xspeed);
					}
				else
					{
						s_hinput=_dir;
					}
			}
	}