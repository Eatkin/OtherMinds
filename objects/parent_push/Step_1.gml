/// @description

outlineshader=false;

//Create the list before movement
ds_list_clear(_list);
collision_line_list(bbox_left,bbox_top-1,bbox_right,bbox_top-1,parent_possessable,false,true,_list,false);