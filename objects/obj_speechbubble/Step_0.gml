/// @description Finds nearest talkable instance
// You can write your code in this editor

if (scr_is_disallowed_room(room))
	exit;

var player=global.currentinstance;

//This just exits for now but maybe Sage can talk to people in future
if (player.object_index==obj_sage)
	exit;

//Exit if paused
if (global.hardpause)
	{
		image_speed=0;
		exit;
	}
else
	image_speed=1;

var dist=0;
with (player)
	{
		var _near=scr_instance_nearest_notme(parent_possessable);
		if (_near!=noone)
			dist=distance_to_object(_near);
		else
			dist=1000;
	}


if (dist>global.talkdistance)
	{
		visible=false;
		exit;
	}
else
	visible=true;

var nearest=scr_instance_nth_nearest(player.x,player.y,parent_possessable,1);
if (nearest==global.currentinstance)
	nearest=scr_instance_nth_nearest(player.x,player.y,parent_possessable,2);
	
if (nearest!=noone)
	{
		//Oh I got the measurements wrong so it was allowing me to talk before the speech bubble appeared
		var distance;
		with (player)
			distance=distance_to_object(nearest);
		if (distance<global.talkdistance and collision_line(player.x,player.y,nearest.x,nearest.y,obj_solid,0,1)==noone and nearest.hasdialogue)
			{
				if (!visible)
					{
						visible=true;
						image_index=0;
						image_speed=1;
					}
				x=(nearest.bbox_left+nearest.bbox_right)*0.5;
				y=(global.gravdirection==90)	?	nearest.bbox_bottom-sprite_get_height(nearest.sprite_index)	:	nearest.bbox_top+sprite_get_height(nearest.sprite_index)
				image_yscale=(global.gravdirection==90)	?	1	:	-1;
				//Exception because Justin Wall looks stupid as fuck
				if (nearest.object_index==obj_justinwall)
					y=nearest.bbox_top-8;
			}
		else
			{
				visible=0;
				image_speed=0;
			}
		//Override
		if player.state!=PlayerState.idle and player.state!=PlayerState.running
			{
				visible=0;
				image_speed=0;
			}
		if nearest.state!=PlayerState.idle and nearest.state!=PlayerState.running
			{
				visible=0;
				image_speed=0;
			}
		if player.talkenabled=false
			{
				visible=0;
				image_speed=0;
			}
			
		if (!ds_queue_empty(global.dialoguequeue))
			visible=false;
			
		if (nearest.dialoguecomplete)
			sprite_index=spr_speechbubble;
		else
			sprite_index=spr_speechbubblegreen;
	}