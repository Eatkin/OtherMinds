/// @description Creation code
// You can write your code in this editor

event_inherited();

scr_intrinsic_variables(scr_return_text(400),0.1,4,6,5,8,1,false,9);
scr_modules_init();

scr_bio(scr_return_text(407), scr_return_text(408),spr_Sim_idle);

state=PlayerState.idle;
if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDSAM)==false)
	{
		state=PlayerState.caged;
	}
else
	{
		instance_create_layer(x,y,layer,obj_petsim);
	}

if (global.maincharacter==obj_Charlotte)
	{
		hasdialogue=true;
	}

text[0]=scr_return_text(496);
text[1]=scr_return_text(497);
text[2]=scr_return_text(492);

var _min=0;
var _max=2;

scr_dialoguemap_init(_min,_max);

//Other stuff
pushspeed=1;

#region sprites
sprite_idle=spr_Sim_idle;
sprite_duck=spr_Sim_duck;
sprite_run=spr_Sim_run;
sprite_air=spr_Sim_jump;
sprite_push=spr_Sim_pushing;
sprite_lookup=spr_Sim_lookup;
sprite_cliff=spr_Sim_cliffeedge;
sprite_cliffbackwards=spr_Sim_cliffedgebackwards;
sprite_blink=spr_Sim_blinking;
sprite_caged=spr_Sim_caged;
sprite_waiting=spr_Sim_sleeping;
sprite_defeated=spr_Sim_defeated;
//sprite_ledgehold=spr_Mig_ledgehold;
//sprite_onwall=spr_Mig_ledgehold;
//sprite_wallclimb=spr_Mig_wallclimb;
//sprite_ledgeclimb=spr_Mig_ledgeclimb;
#endregion

#region masks
masknormal=spr_Sim_idlemask;
maskduck=spr_Sim_duckmask;
#endregion

#region sounds
sound_jump=snd_jump;
//sound_spring=snd_spring;
sound_jumponenemy=snd_jumponenemy;
sound_hurt=snd_hurt;
#endregion

scr_snap_to_floor();

#region modules
jumpenabled=true;
lookupenabled=true;
duckenabled=true;
gravityenabled=true;
canbehurtenabled=true;
enemiesattackenabled=true;
smoothaccelerationenabled=true;
cliffedgeenabled=true;
waitinganimationenabled=true;
blinkingenabled=true;
pushingenabled=true;
runenabled=true;
jumpattackenabled=true;
//walljumpenabled=true;
//wallclimbenabled=true;
collectitemsenabled=true;
//ledgeclimbenabled=true;
//wallmaskenabled=true;
pausemenuoutline=true;
#endregion

//Now an array of harmful objects
harmful[0]=obj_spikes;

//Array of interactable objects
interactable[0]=noone;

wallclimbspeed=1;

if (room!=rm_ochrehill_5 and scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDSAM)==false)
	{
		instance_destroy();
	}