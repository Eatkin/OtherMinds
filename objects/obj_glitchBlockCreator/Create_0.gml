/// @description

var repeats=scr_inventory_check_quantity(obj_artifact);

//Override - there's 7 artifacts at the moment
//For testing
//repeats=7;

for (var i=0; i<repeats; i+=1)
	instance_create_layer(x+128*i,y,layer,obj_glitchBlock);