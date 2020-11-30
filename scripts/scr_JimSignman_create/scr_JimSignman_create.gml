//Created 07/10/19
//Last updated 07/10/19

//Uhh most of this doesn't actually matter because Jim Signman is invisible

scr_intrinsic_variables(scr_return_text(167), 0.1, 1, 1, 9, 6, 1, 1,2);
scr_bio(scr_return_text(168),scr_return_text(169),spr_arrowsign);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_arrowsign
sprite_defeated=spr_Jim_die_right;
sprite_idle=spr_arrowsign
sprite_air=spr_arrowsign;
//sprite_spin=spr_arrowsign;
#endregion

#region masks
masknormal=spr_signmask;
#endregion

#region sounds
sound_splat=snd_splat;
sound_spring=snd_spring;
sound_hurt=snd_hurt;
sound_jump=snd_jump;
sound_jumponenemy=snd_jumponenemy;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
canbehurtenabled=true;
jumpenabled=true;
jumpattackenabled=true;
enemiesattackenabled=true;
spinningenabled=true;
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