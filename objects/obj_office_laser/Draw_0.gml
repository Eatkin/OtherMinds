/// @description

draw_self();

var spr=spr_office_actuallaser;
for (var i=1; i<vrepeats; i+=1)
	{
		if (i==vrepeats-1)
			{
				spr=spr_office_actuallaserbase;
			}
		draw_sprite(spr,image_index,x,y+16*i);
	}