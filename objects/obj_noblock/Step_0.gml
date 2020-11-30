/// @description

var player=global.currentinstance;
if player.object_index=obj_redslime
	{
		instance_activate_object(noblock);
	}
else
	{
		instance_deactivate_object(noblock);
		exit;
	}
	
var blockx=noblock.x+16;
var blocky=noblock.y+8;
var dist=point_distance(player.x,player.y,blockx,blocky);
if dist>160
	{
		noblock.image_alpha=0;
		exit;
	}
dist=max(dist,1); //No don't divide by 0
noblock.image_alpha=min(1,64/dist);