//Created 10/10/19
//Last updated 10/10/19

//Finds a list of all enemies underneath you and finds the one highest in the air
var ydir=dsin(global.gravdirection);
var _enemy=noone;
var _list=ds_list_create();
var num=instance_place_list(x,y+ydir,parent_enemy,_list,false);

if num=0
	{
		ds_list_destroy(_list);
		return noone;
	}
//Now go through the list and find the highest instance
var yhigh=room_height; //Find the instance with the highest y position
var ylow=0;
for (var i=0;i<ds_list_size(_list);i+=1)
	{
		var inst=_list[| i];
		//Checks height, checks it hasn't collided with itself and checks to positioning 
		if (ydir==1)
			{
				if (inst.y==min(inst.y,yhigh) and inst!=id and inst.bbox_top>y)
					_enemy=inst;
			}
		else
			{
				if (inst.y==max(inst.y,ylow) and inst!=id and inst.bbox_bottom<y)
					_enemy=inst;
			}
	}
ds_list_destroy(_list);
		
return _enemy;