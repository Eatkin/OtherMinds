/// @description

event_inherited();

retractedtimermax=45;
retractedtimer=retractedtimermax;
ejectedtimermax=25;
ejectedtimer=ejectedtimermax;
spikesejected=false;
numberofspikes=4;

//Create some spikes
var xspawn=48;
var yspawn=576;
var xspacing=16;

for (var i=0; i<numberofspikes; i+=1)
	{
		spikes[i]=instance_create_layer(xspawn+xspacing*i,yspawn,"objects",obj_ochrespikes);
		spikes[i].image_yscale=-1;
	}