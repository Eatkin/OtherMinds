/// @description Step code for movement etc
// You can write your code in this editor

event_inherited();

scr_states_step();

//Ochre 9 secret
if (room==rm_ochrehill_9 and global.currentinstance==id)
	{
		if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.COOLCATCLUB)==false and x==clamp(x,784,944) and y==clamp(y,0,64))
			{
				global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.COOLCATCLUB);
				scr_roomarray_set_secret_completed();
			}
	}

if global.currentinstance=id or global.hardpause=true or global.softpause=true
	{
		exit;
	}
	
//behaviours! there aren't many
if state=PlayerState.ledgegrab
	{
		s_vinput=1;
	}
	
//If we're on a cliff edge state we find which side the cliff edge is at and move away from it
if state!=PlayerState.idle and state!=PlayerState.running and state!=PlayerState.cliffedge
	{
		exit;
	}
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