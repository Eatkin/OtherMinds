//Created 15/10/19
//Last updated 15/10/19

//Calculates the highest jump height possible
//We lose height global.grav every frame
//We lose height global.grav*0.75 for holding jump

/*Soooo:
sum of the first n numbers is 0.5*(n^2+n)
Modified global.grav/2*(x^2+x) where x=1/global.grav
*/
var _jump=jumpheight;
if argument_count>0
	{
		_jump=argument[0];
	}
var grav=global.gravstrength*0.75;
var n=abs(_jump)/grav;
var maxheight=grav*0.5*(sqr(n)+n);

//Adjust for the bounding box
maxheight-=(bbox_bottom-y);
maxheight=max(0,maxheight);

return maxheight;