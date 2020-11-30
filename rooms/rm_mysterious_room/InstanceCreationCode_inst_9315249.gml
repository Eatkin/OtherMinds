//Create all the other lights
sprite_index=spr_mysteriousRoomLights;
image_index=0;
image_index+=4*scr_event_check_complete(global.mysteriousRoomEvents,1);
image_speed=0;
for (var i=1; i<4; i+=1)	{
	var newLight=instance_create_layer(x+320*i,y,layer,obj_nothing);
	with (newLight)	{
		sprite_index=spr_mysteriousRoomLights;
		image_index=i;
		image_index+=4*scr_event_check_complete(global.mysteriousRoomEvents,power(2,i));
		image_speed=0;
	}
}