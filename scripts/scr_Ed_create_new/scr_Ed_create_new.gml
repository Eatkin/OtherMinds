//Created: 23/05/19
//Last updated: 06/08/19

healthregen=-1;
regenrate=600;
var diff=scr_return_difficulty();

if (diff==DIFFICULTY.EXTRAEASY)
	{
		healthregen=regenrate; //10 seconds to regen a heart
	}
else
	{
		healthregen=-1;
	}

var jumpH=9;
if (diff<=DIFFICULTY.EASY)
	jumpH+=0.5;
if (diff>=DIFFICULTY.HARD)
	jumpH-=0.5;

scr_intrinsic_variables(scr_return_text(156),0.05,1.5,4,9,jumpH,global.playerpowerlevel,0,global.Edhealth); //HP doesn't matter because Ed is controlled seperately
scr_modules_init();


hpmax=scr_return_adjusted_hpmax();
hp=clamp(hp,-1,hpmax);
global.Edhealth=hp;

//Auto-set hp on time trials and attract mode
if (instance_exists(obj_timetrial) or global.attract==true)
	{
		global.Edhealth=2;
		hp=global.Edhealth;
		hpmax=global.Edhealth;
	}

scr_bio(scr_return_text(134), scr_return_text(135),spr_Ed_waiting);

//Don't actually know what needs to go here at the moment
//Actually yes I do
//Seriously why do I write these comments
state=PlayerState.idle;

//Other stuff
pushspeed=1;
ledgextranslation=14;
ledgeytranslation=32;

#region sprites
sprite_idle=spr_Ed_idle;
sprite_duck=spr_Ed_duck;
sprite_run=spr_Ed_run;
sprite_air=spr_Ed_air;
sprite_push=spr_Ed_push;
sprite_pull=spr_Ed_pull;
sprite_lookup=spr_Ed_lookup;
sprite_ledgehold=spr_Ed_ledgehold;
sprite_ledgeholdaway=spr_Ed_ledgeholdaway;
sprite_ledgeclimb=spr_Ed_ledgeclimb;
sprite_cliff=spr_Ed_cliff;
sprite_cliffbackwards=spr_Ed_cliffbackwards;
sprite_teleport=spr_Ed_teleport;
sprite_teleport_backwards=spr_Ed_teleport_backwards;
sprite_blink=spr_Ed_blink;
sprite_waiting=spr_Ed_waiting;
sprite_holding=spr_Ed_holding;
sprite_holding_air=spr_Ed_holdingair;
sprite_spring=spr_Ed_spring;
sprite_defeated=spr_Ed_dead;
sprite_shoes=spr_Ed_shoes;
sprite_carried=spr_Ed_carried;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
maskclimb[0]=mask_ledge1;
maskclimb[1]=mask_ledge2;
maskclimb[2]=mask_ledge3;
maskclimb[3]=mask_ledge4;
maskclimb[4]=mask_ledge5;
maskclimb[5]=mask_ledge6;
maskclimb[6]=mask_ledge7;
maskclimb[7]=mask_ledge8;
masknormal=mask_Ed;
maskduck=mask_Ed_half;
#endregion

#region sounds
sound_jump=snd_jump;
sound_spring=snd_spring;
sound_jumponenemy=snd_jumponenemy;
sound_hurt=snd_hurt;
sound_tap=snd_foot_tap;
sound_regen=snd_heart_regen;
sound_impact=snd_foot_tap;
#endregion

//Variable for foot tapping
sound_on=false;

#region modules
jumpenabled=true;
lookupenabled=true;
duckenabled=true;
ledgegrabenabled=true;
ledgeclimbenabled=true;
gravityenabled=true;
canbehurtenabled=true;
enemiesattackenabled=true;
smoothaccelerationenabled=true;
collectitemsenabled=true;
cliffedgeenabled=true;
waitinganimationenabled=true;
waitingtimeoutenabled=true;
blinkingenabled=true;
pushingenabled=true;
pullingenabled=true;
teleportenabled=true;
springsenabled=true;
dustenabled=true;
offscreenmarkerenabled=true;
talkenabled=true;
runenabled=true;
foottapenabled=true;
springsenabled=true;
jumpattackenabled=true;
shoesenabled=true;
ledgeholdawayenabled=true;
moveoffscreenenabled=true;
//impactsoundenabled=true;
#endregion

//Now an array of harmful objects
harmful[0]=obj_spikes;
harmful[1]=obj_boss_laser;
harmful[2]=obj_boss_widelaser;
harmful[3]=obj_deadlyhoney_hurtmask;

//Array of interactable objects
interactable[0]=parent_interactive;