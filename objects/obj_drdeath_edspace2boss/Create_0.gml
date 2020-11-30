/// @description Insert description here
// You can write your code in this editor

event_inherited();

myMusic=mus_edspace2_boss;

var _bossHp=3;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	_bossHp+=1;
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	_bossHp-=1;
scr_intrinsic_variables(scr_return_text(170),0.05,3.5,3,9,10.5,1,0,_bossHp);
scr_modules_init();

state=PlayerState.idle;

scr_bio(scr_return_text(171),scr_return_text(172) ,spr_drdeath_idle);

//Sprites
sprite_idle=spr_drdeath_idle;
sprite_duck=spr_drdeath_duck;
sprite_run=spr_drdeath_run;
sprite_air=spr_drdeath_air;
sprite_push=spr_drdeath_push;
sprite_lookup=spr_drdeath_lookup;
sprite_ledgehold=spr_drdeath_ledgehold;
sprite_cliff=spr_drdeath_cliff;
sprite_cliffbackwards=spr_drdeath_cliffbackwards;
sprite_blink=spr_drdeath_blink;
sprite_waiting=spr_drdeath_laugh;
sprite_defeated=spr_drdeath_defeated;

//Masks
masknormal=spr_drdeathmask;
maskduck=spr_drdeathmaskhalf;

//Sounds
sound_jump=snd_jump;
sound_hurt=snd_hurt;
sound_jumponenemy=snd_jumponenemy;

#region modules
jumpenabled=true;
lookupenabled=true;
duckenabled=true;
gravityenabled=true;
canbehurtenabled=true;
smoothaccelerationenabled=true;
cliffedgeenabled=true;
waitinganimationenabled=true;
waitingtimeoutenabled=true;
blinkingenabled=true;
dustenabled=true;
runenabled=true;
jumpattackenabled=true;
ledgegrabenabled=true;
pushingenabled=true;
respawnenabled=false;
jumponedenabled=true;
offscreenmarkerenabled=true;
moveoffscreenenabled=true;
pushingenabled=true;
#endregion

pushspeed=1;

//Now an array of harmful objects
harmful[0]=obj_spikes;

directionfacing=-1;

//Triggers for behaviour
bossState=BOSS_STATE.INACTIVE;
bossStarted=false;
//We're going to have lots of buttons so let's pop all the hit button triggers as a number and use bitmasking
hitButton=0;
bossStartCountdown=60;

phaseTwoRegionLocked=false;

phaseThreeGravNormal=false;
lasersCreated=false;
phaseThreeSlowLaser=noone;

genericTimer=0;

//Now store the button IDs for easy reference
button[0]=inst_40434669;	//Phase one
button[1]=inst_2D6E78D5;	//Phase two
button[2]=inst_50EA977C;	//Phase three
button[3]=inst_311BE2F9;	//Phase three

//For the final fight
button[4]=inst_FEB3270;
button[5]=inst_5735F06F;
button[6]=inst_5212EF1B;
	
scr_add_todo(0,scr_return_text(655),scr_return_text(656), localtodo);
scr_todo_discover(0,localtodo);

//Start from checkpoint
if (global.checkpoint[0]==inst_54DC63E)
	{
		//Start from checkpoint
		bossState=BOSS_STATE.BREAKTHREE;
		x=2544;
		y=560;
	}
	
breakThreeFirstPos=false;
breakThreeSecondPos=false;

var diff=scr_return_difficulty();
evasion=20;							//Lower = better evasion
aggression=20;						//Lower = more aggressive
range=96;							//Larger = better evasion, checks either side so real range is range*2;
if (diff==DIFFICULTY.NORMAL)	
	{
		evasion*=0.5;
		aggression*=0.5;
	}
if (diff>DIFFICULTY.NORMAL)
	{
		evasion*=0.25;
		aggression*=0.25;
	}

targetButton=noone;

harmful[0]=obj_cannon_ball;
harmful[1]=obj_saw

if (scr_event_check_complete(global.edSpaceTwoEvents,EdSpaceTwoEvents.DEFEATEDDRD))
	{
		state=PlayerState.dead;
		bossState=BOSS_STATE.DEFEATED;
		visible=false;
		with (obj_block_on)
			instance_destroy();
		with (obj_block_off)
			instance_destroy();
						
		instance_create_layer(1008,720,"objects",obj_edspace2LiftPlatform);
		instance_create_layer(1152,672,"objects",obj_edspace2LiftPlatform);
		instance_create_layer(1296,624,"objects",obj_edspace2LiftPlatform);
		
		instance_activate_object(inst_C97CC9F);
	}
	