/// @description

activated=false;
phase=0;
spikes=false;
spikestimer=0;
spikestimermax=50;
ballrespawning=false;
ballspawntimer=0;
ballspawntimermax=60;
myballs=noone; //LOL WHAT A FUNNY JOKE!!!!

if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.BREAKOUT)==true)
	{
		with (obj_breakout_block)
			{
				instance_destroy();
			}
		instance_destroy();
	}