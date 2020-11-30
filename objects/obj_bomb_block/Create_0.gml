/// @description

// Inherit the parent event
event_inherited();

explodetimermax=room_speed*3;
explodetimer=explodetimermax;
exploding=false;

if (scr_return_difficulty()<=DIFFICULTY.EASY)
	explodetimermax+=room_speed;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	explodetimermax-=room_speed;

whitesprite=false;

alarm[0]=15; //The bomb doesn't start blowing up for some frames
//That's what this alarm is for