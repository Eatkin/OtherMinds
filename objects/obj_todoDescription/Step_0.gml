/// @description

var tickSize=0.05;

if (active and obj_todoListContainer.timer>0.9)
	timer=min(1,timer+tickSize);
else
	timer=max(0,timer-tickSize);
	
var easingProportion=scr_easeInOutSin(timer);

x=xstart-480*easingProportion;

if (timer<=0 and !active)
	instance_destroy();