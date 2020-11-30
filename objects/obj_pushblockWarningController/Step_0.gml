/// @description

if (global.hardpause)
	exit;

var _num=instance_number(parent_push);

var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camw=camera_get_view_width(cam);


//What we do is find each push block
//If it's; a) not moving, b) already created a warning or c) not on camera, we ignore it
//When one meets the conditions otherwise, it finds it's collision with the floor below it
//It creates a warning sign at the position where it is potentially going to collide
//Then it excludes itself from future checks
for (var i=0; i<_num; i+=1)
	{
		var inst=instance_find(parent_push,i);
		if (inst.yspeed==0 or !is_undefined(ds_map_find_value(instanceMap,inst)) or inst.x!=clamp(inst.x,camx-inst.sprite_width,camx+camw))
			continue;

		var xx=inst.x+inst.sprite_width*0.5;
		var yy=inst.bbox_bottom;
		//Round it so we only have to check collisions grid-wise
		yy=floor(yy/16)*16;
		for (var j=16; j<room_height;j+=16)
			{
				if (place_meeting(xx,yy+j,obj_solid) or place_meeting(xx,yy+j,obj_semisolid))
					{
						if (j==16)
							break;
						instance_create_layer(xx,yy+j-sprite_height*1.5,"objects",obj_pushblockWarningSign);
						ds_map_add(instanceMap,inst,0);		//Add to the map
						break;
					}
			}
	}