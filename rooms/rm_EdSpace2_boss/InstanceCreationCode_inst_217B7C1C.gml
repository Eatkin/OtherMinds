var num=instance_number(obj_gauntlet_popoutspikes);
var minx=4480;
var maxx=4560;
var count=0;
for (var i=0; i<num; i+=1)
	{
		var inst=instance_find(obj_gauntlet_popoutspikes,i);
		if (inst.x==clamp(inst.x,minx,maxx))
			{
				linkedinstance[count]=inst;
				count+=1;
			}
	}