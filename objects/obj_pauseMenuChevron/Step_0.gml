/// @description

if (attachedTo==noone)
	exit;

timer+=8;
timer%=360;
var xtarget=attachedTo.x-28+4*dsin(timer);

x=lerp(x,xtarget,0.2);
var ytarget=attachedTo.y+yoffset;
y=lerp(y,ytarget,0.4);