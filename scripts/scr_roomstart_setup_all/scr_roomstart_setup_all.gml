//Created: 23/05/19
//Last updated: 12/10/19

global.roomspeed=60;
exit;

/*
CRAPPY CRAP AND SHIT
This was to account for a bug in gamemaker but it's now fixed lol
//So we've set the roomspeed to 60 fps, we then measure how long 1 step takes in delta time
//We can use that to make an adjustment to the room speed

//1 second SHOULD take 60*dt
//But we want 1s=x*dt, => x=1/dt where x=fps
//We round it to the nearest 30;
var _fps=power(10,6)/delta_time;
_fps=max(1,round(_fps/30)*30); //This just makes sure room speed isn't negative
global.roomspeed=_fps;

//alarm[1]=1;*/