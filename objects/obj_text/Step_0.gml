/// @description controls movement
// You can write your code in this editor


if global.hardpause=true
	{
		exit;
	}
	
x=xstart+amplitude*dsin(ticker);
ticker+=3;
y-=1;

if scr_on_camera()=false
	{
		instance_destroy();
	}