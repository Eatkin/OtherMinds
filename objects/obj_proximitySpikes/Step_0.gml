/// @description

// Inherit the parent event
event_inherited();

var player=parent_main_character;
var proximity=abs(player.x-x);
var ytarget=max(0,16*(1-proximity/32));
ytarget=ystart-ytarget;

y=lerp(y,ytarget,0.1);