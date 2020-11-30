/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

#region initialisation
scr_intrinsic_variables(scr_return_text(330), 0.1, 1, 2, 9, 6, 0, true,HP.INF);
scr_bio(scr_return_text(331),scr_return_text(332),spr_blanksignstatic);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=sprite_index;
sprite_idle=sprite_index;
sprite_air=sprite_index;
sprite_carried=sprite_index;
#endregion

#region masks
masknormal=spr_signmask;
#endregion

#region sounds
sound_spring=snd_spring;
sound_hurt=snd_hurt;
sound_jump=snd_jump;
sound_jumponenemy=snd_jumponenemy;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
jumpenabled=true;
//jumpattackenabled=true;
//enemiesattackenabled=true;
//spinningenabled=true;
isasignenabled=true;
dustenabled=true;
xscaleflipenabled=false;
#endregion


directionfacing=1;

//Dialogue
font=global.font;
dialogueprevious=-1; //I think this is orphaned

//This is to do with the interactable object associated with Jim Signman
owner=noone;
#endregion

//Dialogue
text[0]="Remember to add text!";

scr_dialoguemap_init(0,0);

//Move to object layer because it wants to go behind player
layer=layer_get_id("Objects");

image_speed=0;