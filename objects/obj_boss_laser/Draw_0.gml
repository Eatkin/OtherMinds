/// @description Draw the barrier
// You can write your code in this editor

//Note here the barrier is rotated 270 degrees
//As origin is top left we need to translate the x position

//I'm going to draw a new sprite for this so don't really need the draw sprite ext after that
if drawbarrier=1 or state=BARRIER.NORMAL
	{
		draw_set_alpha(alpha);
		var i;
		for (i=0;i<barrierrepeats;i+=1)
			{
				draw_sprite(spr_laser,-1,x,y+32*i);
			}
	}
draw_set_alpha(1);
	/* Probably don't need this but I'll leave it in anyway
else
	{
		i=barrierrepeats;
	}*/