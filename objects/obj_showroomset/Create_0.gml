/// @description

text="";
textxpos[0]=0;; //Initial position
textxpos[1]=0; //Position for displaying
textxpos[2]=0; //Final position
drawxpos=-1000;
drawypos=display_get_gui_height()*0.05;
gottext=false;
holdingtime=0;
lerpspeed=0.05;
drifting=false;

state=0; //This can be moving to the middle, 1 to hold, 2 to move to the right


//Here's a ridiculous amount of code just to make sure that multiple room set names appear neatly
var _num=instance_number(object_index);
if (_num>1)
	{
		var ypos=ds_list_create();
		var inst, instypos;
		for (var i=0; i<_num; i+=1)
			{
				inst=instance_find(object_index,i);
				if (inst==id)
					{
						continue;
					}
				instypos=inst.drawypos;
				ds_list_add(ypos,instypos);
			}
		//Sort the list
		ds_list_sort(ypos,true);
		//Now go thru and find the first available "slot"
		for (var i=0; i<_num; i+=1)
			{
				instypos=ds_list_find_value(ypos,i);
				//If we find a 'slot' we terminate the event and destroy the list
				if (instypos!=drawypos*(i+1))
					{
						drawypos=drawypos*(i+1);
						ds_list_destroy(ypos);
						exit;
					}
			}
		//We only get here if we haven't found a slot, in which case we set the drawypos at the end
		drawypos=drawypos*_num;
		ds_list_destroy(ypos);
	}