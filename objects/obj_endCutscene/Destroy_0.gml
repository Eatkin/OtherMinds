/// @description Create credits and destroy exit

instance_create_layer(0,0,layer,obj_newCredits);
with (obj_dooractivateontouch)
	instance_destroy();