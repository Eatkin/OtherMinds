/// @description Creation code
// You can write your code in this editor

event_inherited();

scr_intrinsic_variables(scr_return_text(418),0.2,2,2,5,7,1,false,9);
scr_modules_init();

scr_bio(scr_return_text(419), scr_return_text(420) ,spr_frankie_idle);

state=PlayerState.idle;
if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDFRANKIE)==false)
	{
		state=PlayerState.caged;
	}
else
	{
		instance_create_layer(x,y,layer,obj_petfrankie);
	}
	
if (global.maincharacter==obj_Charlotte)
	{
		hasdialogue=true;
	}
	
text[0]=scr_return_text(493);
text[1]=scr_return_text(494);
text[2]=scr_return_text(495);
text[3]=scr_return_text(492);

var _min=0;
var _max=3;

scr_dialoguemap_init(_min,_max);

//Other stuff
pushspeed=1;
ledgextranslation=14;
ledgeytranslation=13;

#region sprites
sprite_idle=spr_frankie_idle;
sprite_duck=spr_frankie_duck;
sprite_run=spr_frankie_run;
sprite_air=spr_frankie_jump;
//sprite_push=spr_Mig_push;
sprite_lookup=spr_frankie_lookup;
sprite_cliff=spr_frankie_cliff;
sprite_cliffbackwards=spr_frankie_cliffbackwards;
sprite_blink=spr_frankie_blink;
sprite_waiting=spr_frankie_sleep;
sprite_defeated=spr_frankie_defeated;
sprite_ledgehold=spr_frankie_ledgehold;
sprite_onwall=spr_frankie_ledgehold;
sprite_wallclimb=spr_frankie_wallclimb;
sprite_ledgeclimb=spr_frankie_ledgeclimb;
sprite_caged=spr_frankie_caged;
#endregion

#region masks
masknormal=mask_mig;
maskduck=mask_mig_duck;
maskwall=mask_mig_air;
maskclimb[0]=spr_franke_ledgemask1;
maskclimb[1]=spr_franke_ledgemask2;
maskclimb[2]=spr_franke_ledgemask3;
maskclimb[3]=spr_franke_ledgemask4;
maskclimb[4]=spr_franke_ledgemask5;
maskclimb[5]=spr_franke_ledgemask6;
maskclimb[6]=spr_franke_ledgemask7;
maskclimb[7]=spr_franke_ledgemask8;
maskclimb[8]=spr_franke_ledgemask9;
maskclimb[9]=spr_franke_ledgemask10;
#endregion

#region sounds
sound_jump=snd_jump;
//sound_spring=snd_spring;
//sound_jumponenemy=snd_jumponenemy;
sound_hurt=snd_hurt;
sound_wallclimb=snd_platform_tick;
sound_wallclimb=snd_morse_short;
#endregion

scr_snap_to_floor();

#region modules
jumpenabled=true;
lookupenabled=true;
duckenabled=true;
gravityenabled=true;
canbehurtenabled=true;
enemiesattackenabled=true;
//smoothaccelerationenabled=true;
cliffedgeenabled=true;
waitinganimationenabled=true;
blinkingenabled=true;
//pushingenabled=true;
runenabled=true;
jumpattackenabled=true;
walljumpenabled=true;
wallclimbenabled=true;
collectitemsenabled=true;
ledgeclimbenabled=true;
wallmaskenabled=true;
pausemenuoutline=true;
#endregion

//Now an array of harmful objects
//harmful[0]=...

//Array of interactable objects
interactable[0]=noone;

wallclimbspeed=1;

if (room!=rm_ochrehill_8 and scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDFRANKIE)==false)
	{
		instance_destroy();
	}