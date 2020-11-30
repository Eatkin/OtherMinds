/// @description Insert description here
// You can write your code in this editor

drawbarrier=scr_bitflip(drawbarrier);
alarm[0]=flashtime;
numberofflashes-=1;
if drawbarrier=0
	{
		scr_play_sound(snd_barrier_destroy,false,0);
	}

var vibamount;
var dist=distance_to_object(global.currentinstance);
var maxdist=128;
vibamount=1-min(1,dist/maxdist);
if vibamount>0.5
	{
		vibamount=clamp(vibamount,0.5,0.8);
		scr_set_vibration(vibamount,vibamount,5);
	}

//Turn off alarm
if numberofflashes=0
	{
		alarm[0]=-1;
		drawbarrier=0;
		if state=BARRIER.REAPPEAR
			{
				state=BARRIER.NORMAL;
			}
	}