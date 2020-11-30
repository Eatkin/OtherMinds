/// @description update position
// You can write your code in this editor
event_inherited();

var player=global.currentinstance;
x=player.x;
y=player.y;

x=clamp(x,owner.bbox_left,owner.bbox_right);
y=clamp(y,owner.bbox_top,owner.bbox_bottom);

if owner.state=BARRIER.DISAPPEAR and alarm[0]=-1
	{
		alarm[0]=40;
	}

//Decrease volume and pitch if barrier is destroyed
if alarm[0]!=-1
	{
		gainoverride=lerp(gainoverride,0,0.19);
		pitchoverride=lerp(pitchoverride,0,0.19);
	}