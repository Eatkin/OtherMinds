/// @description

popUpSound=snd_spikes_eject;
activated=false;
y+=16;
ystart=y;

mySpikes=instance_create_layer(x,y,layer,obj_spikes);
instance_deactivate_object(mySpikes);