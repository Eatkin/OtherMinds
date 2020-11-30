//Created 06/10/19
//Last updated 06/10/19

scr_intrinsic_variables(scr_return_text(158),0.1,1,1,10,4,0,0,0);
scr_bio(scr_return_text(138),scr_return_text(139),spr_greenslimemoving);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_waiting=spr_greenslimesleeping;
sprite_run=spr_greenslimemoving;
sprite_defeated=spr_greenslimedead;
sprite_idle=spr_greenslimeidle;
sprite_slideoffcliff=spr_greenslimeslideoffcliff;
sprite_air=spr_greenslimeair;
sprite_splat=spr_greenslime_splat;
sprite_throughgrate=spr_greenslime_throughgrate;
sprite_spring=spr_greenslimonspring; //Spelt the sprite name wrong lol
sprite_blink=spr_gloop_blink;
sprite_push=spr_gloop_push;
sprite_lookup=spr_gloop_lookup;
sprite_duck=spr_gloop_duck;

//Replace these if we're Augustine
if object_get_parent(object_index)=obj_Augustine
	{
		sprite_waiting=spr_augustinesleep;
		sprite_run=spr_augustinemoving;
		sprite_idle=spr_augustineidle;
		sprite_slideoffcliff=spr_augustineoffcliff;
		sprite_air=spr_augustineair;
		sprite_splat=spr_augustinesplat;
		sprite_push=spr_augustinepush;
		sprite_lookup=spr_augustinelookup;
		sprite_blink=spr_augustineblink;
		sprite_duck=spr_augustineduck;
		sprite_teleport=spr_augustineteleport;
		sprite_teleport_backwards=spr_augustineteleportbackwards;
	}
	
//Randomise starting frame
image_index=irandom_range(0,image_number);
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=mask_greenslime;
maskduck=mask_greenslimeduck;
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
canhurtenabled=true;
waitinganimationenabled=true;
springsenabled=true;
slideoffcliffenabled=true;
splatenabled=true;
airspriteflipenabled=true; //This flips the yscale of sprites in the air depending on movement direction
jumpenabled=true;
jumpattackenabled=true;
blinkingenabled=true;
pushingenabled=true;
lookupenabled=true;
duckenabled=true;
#endregion

pushspeed=1;

//Now an array of harmful objects
harmful[0]=obj_spikes;

//Array of interactable objects
interactable[0]=obj_grate;

directionfacing=-1;

scr_add_inv_heart();