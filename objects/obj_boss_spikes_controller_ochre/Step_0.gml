/// @description

event_inherited();

if (global.hardpause==true)
	{
		exit;
	}
	
//Pretty simple stuff, just ejects spikes and plays a sound, then retracts and plays a sound
//On a loop forever
//MAKE THIS AN AUDIO EMITTER!!!
	
if (spikesejected==true)
	{
		ejectedtimer-=1;
		var retracted=false;
		if (ejectedtimer<=0)
			{
				if (ejectedtimer==0)
					{
						pitchoverride=1;
						scr_play_sound(snd_spikes_eject,false,0);
					}
				for (var i=0; i<numberofspikes; i+=1)
					{
						with (spikes[i])
							{
								y=lerp(y,ystart,0.2);
								if (abs(y-ystart)<1)
									{
										y=ystart;
										retracted=true;
									}
							}
					}
			}
		if (retracted==true)
			{
				spikesejected=false;
				retractedtimer=retractedtimermax;
			}
	}
else
	{
		retractedtimer-=1;
		var ejected=false;
		if (retractedtimer<=0)
			{
				if (retractedtimer==0)
					{
						pitchoverride=0.8;
						scr_play_sound(snd_spikes_eject,false,0);
					}
				for (var i=0; i<numberofspikes; i+=1)
					{
						with (spikes[i])
							{
								y=lerp(y,ystart+16,0.2);
								if (abs(y-ystart)>15)
									{
										y=ystart+16;
										ejected=true;
									}
							}
					}
			}
		if (ejected==true)
			{
				spikesejected=true;
				ejectedtimer=ejectedtimermax;
			}
	}