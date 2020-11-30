/// @description

// Inherit the parent event
event_inherited();

if (global.hardpause==true)
	{
		exit;
	}

staticTimer-=1;
warningTimer-=1;

if (staticTimer==0 and tvSprite!=spr_smileyScreen)
	{
		warningTimer=warningTimerMax;
	}

if (staticTimer>0 and soundplaying==noone)
	{
		scr_play_sound(snd_shower,true,0);
	}
if (staticTimer<=0)
	{
		if (soundplaying!=noone)
			{
				audio_stop_sound(soundplaying);
				soundplaying=noone;
			}
	}
	
if (warningTimer==0)
	{
		tvSprite=spr_smileyScreen;
		staticTimer=staticTimerMax;
	}