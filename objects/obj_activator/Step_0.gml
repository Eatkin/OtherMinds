/// @description

for (var i=0; i<array_length_1d(linkedinstance); i+=1)
	if (linkedinstance[i]!=noone and instance_exists(linkedinstance[i]))
		linkedinstance[i].activated=activated;
		
//If we destroy when used, it marks all linked instances as noone
if (destroyOnActivation and activated)
	for (var i=0; i<array_length_1d(linkedinstance); i+=1)
		linkedinstance[i]=noone;