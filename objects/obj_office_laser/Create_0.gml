/// @description
dir=1; //Right
xbound=64; //Jiggle room left and right
maxspeed=4;
xspeed=0;

vrepeats=0;
myspikes=instance_create_layer(x,y,layer,obj_spikes);
myspikes.mask_index=spr_blocksmall;
myemitter=instance_create_layer(x,y,layer,obj_sound_emitter);
scr_object_resize(myspikes,6,1);
myspikes.visible=false;

myemitter.soundid=snd_shower;
myemitter.mode=EMITTER.LOOP;
myemitter.pitchoverride=0.2;