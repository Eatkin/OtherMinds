/// @description Creation code
// You can write your code in this editor

event_inherited();

instance_create_layer(x,y,layer,obj_petmig);

scr_intrinsic_variables(scr_return_text(177),0.05,5,2,5,6,1,false,9);
scr_modules_init();

if (global.maincharacter==obj_Charlotte)
	{
		hasdialogue=true;
	}
	
text[0]=scr_return_text(490);
text[1]=scr_return_text(491);
text[2]=scr_return_text(492);

var _min=0;
var _max=2;

scr_dialoguemap_init(_min,_max);

scr_bio(scr_return_text(178), scr_return_text(179),spr_mig_idle);

state=PlayerState.idle;
timeinstate=300; //This should force a sleep animation

//Other stuff
pushspeed=1;
ledgextranslation=14;
ledgeytranslation=13;

#region sprites
sprite_idle=spr_mig_idle;
sprite_duck=spr_Mig_duck;
sprite_run=spr_mig_running;
sprite_air=spr_Mig_jump;
sprite_push=spr_Mig_push;
sprite_lookup=spr_Mig_lookup;
sprite_cliff=spr_Mig_cliffedge;
sprite_cliffbackwards=spr_Mig_cliffbackwards;
sprite_blink=spr_mig_blinking;
sprite_waiting=spr_mig_sleeping;
//sprite_defeated=spr_Ed_dead;
sprite_ledgehold=spr_Mig_ledgehold;
sprite_onwall=spr_Mig_ledgehold;
sprite_wallclimb=spr_Mig_wallclimb;
sprite_ledgeclimb=spr_Mig_ledgeclimb;
#endregion

#region masks
masknormal=mask_mig;
maskduck=mask_mig_duck;
maskwall=mask_mig_air;
maskclimb[0]=mask_climb1;
maskclimb[1]=mask_climb2;
maskclimb[2]=mask_climb3;
maskclimb[3]=mask_climb4;
maskclimb[4]=mask_climb5;
maskclimb[5]=mask_climb6;
maskclimb[6]=mask_climb7;
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
smoothaccelerationenabled=true;
cliffedgeenabled=true;
waitinganimationenabled=true;
blinkingenabled=true;
pushingenabled=true;
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