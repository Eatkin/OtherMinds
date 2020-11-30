/// @description destroy all my buttons

var len=array_length_1d(button);

for (var i=0; i<len; i+=1)
	instance_destroy(button[i]);
	
instance_destroy(chevron);