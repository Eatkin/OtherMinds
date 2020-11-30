/// @description

event_inherited();

label=scr_return_text(440);
active=false;
haslaserdisc=false;

if (scr_inventory_check(obj_laser_diskvol1)==true)
	{
		haslaserdisc=true;
	}
if (scr_inventory_check(obj_laser_diskvol2)==true)
	{
		haslaserdisc=true;
	}