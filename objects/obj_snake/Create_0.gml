/// @description

//Array of blocks and positions
for (var i=0; i<4; i+=1)
	{
		blockinfo[i,1]=xstart-16*i;
		blockinfo[i,2]=ystart;
		var block=instance_create_layer(blockinfo[i,1],blockinfo[i,2],"blocks",obj_snake_block);
		blockinfo[i,0]=block;
	}
	
timermax=30;
timer=timermax;

dir=0; //0 degrees
startdir=dir;
delay=0;