/// @description

//Super easy - this is just linked to the main pause menu
timer=obj_mainPauseMenuContainer.timer;

var easingProportion=scr_easeInOutSin(timer);
x=xstart-easingProportion*480;

sprImageIndex+=sprite_get_speed(mySpr)/60;
sprImageIndex%=sprite_get_number(mySpr);