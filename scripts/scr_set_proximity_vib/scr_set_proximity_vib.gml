//Created 23/04/20
//Last updated 23/04/20

var maxdist=argument0;
var minvib=argument1;
var maxvib=argument2;

var dist=distance_to_object(global.currentinstance)
if (dist<maxdist)
	{
		var vib=1-dist/maxdist;
		vib*=maxvib;
		vib=max(vib,minvib);
		scr_set_vibration(vib,vib,3);
	}