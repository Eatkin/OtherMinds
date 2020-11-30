/// @description Start the state and other boring variables for boring arseholes like me
// You can write your code in this editor

state=BOSS_STATE.INACTIVE;
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSDEFEATED)
	{
		state=BOSS_STATE.DEFEATED;
	}
	
//Triggers
lerpingcannonsin=false;

//These are the region lock blocks
block[0]=noone;
block[1]=noone;

//Boss kill things
cannon[0]=noone;
cannon[1]=noone;
cannon[2]=noone;

cannondestroyedtimer=0;
cannonsdestroyed=0;

//Spikes controller
var i;
for (i=0; i<23; i+=1)
	{
		spikes[i]=instance_create_layer(384+16*i,736,"objects",obj_spikes);
	}
spikestimer=45;

//Phase break platforms
platform[0]=noone;
/*
platform[1]=noone;
platform[2]=noone;*/

activated=false;

//Laser cannons
laser[0]=noone;
laser[1]=noone;
laser[2]=noone;
laserdestroyedtimer=0;
lasersdestroyed=0;
laseractive=0;

//Now finally the LHS spikes starting at y=496
for (i=29; i<56; i+=1)
	{
		spikes[i]=instance_create_layer(384,304+16*(i-29),"objects",obj_spikes);
		spikes[i].image_angle=-90;
		instance_deactivate_object(spikes[i]);
	}
	
//Sounds
sound_bullet=snd_bullet_fire;
//sound_cannon_wall=snd_cannon_into_wall;

//Some behaviour things
firelaser=false;

previousstate=state;
timeinstate=0;