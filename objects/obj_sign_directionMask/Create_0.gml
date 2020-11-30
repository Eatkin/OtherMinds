/// @description Sets up some variables
// You can write your code in this editor

event_inherited();
scr_intrinsic_variables("Arroworth", 0, 0, 0, 0, 0, 0, false,HP.INF);
scr_bio("Air traffic controller","Getting you to your destination",spr_arrowsign);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_idle=spr_arrowsign
#endregion

#region masks
masknormal=spr_signmask;
#endregion

#region sounds

#endregion

scr_snap_to_floor();

#region modules
spinningenabled=true;
isasignenabled=true;
xscaleflipenabled=false;
interactwithblocksenabled=false;
#endregion


directionfacing=1;


//This is to do with the interactable object associated with Jim Signman
owner=noone;