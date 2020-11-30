/// @description

if (place_meeting(x,y,parent_main_character) and global.checkpoint[0]!=id)
	{
		var textObj=instance_create_layer(x,y,layer,obj_showroomset);
		global.checkpoint[0]=id;
		global.checkpoint[1]=room;
		textObj.text=scr_return_text(566);
		textObj.drawypos=display_get_gui_height()*0.8;
	}