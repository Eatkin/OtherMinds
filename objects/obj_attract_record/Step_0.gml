/// @description

//Activated AFTER the transition
if (!instance_exists(obj_transition) and active==false and global.softpause==false)
	{
		active=true;
		show_message("Recording!");
	}

if (active==false)
	{
		exit;
	}

//var gridwidth=ds_grid_width(recordings);
var gridheight=ds_grid_height(recordings);
ds_grid_resize(recordings,frames+1,gridheight);
/*S_inputs
//Reset simulated input:
s_hinput=0;
s_vinput=0;
s_jump=0;
s_jumphold=false;
s_b_two=0; //Interact
s_b_three=0; //Sage possess
s_b_four=0; //Pulling
*/
ds_grid_set(recordings,frames,0,global.inputs[0]);
ds_grid_set(recordings,frames,1,global.inputs[1]);
ds_grid_set(recordings,frames,2,global.inputs[4]);
ds_grid_set(recordings,frames,3,global.inputs[16]);
ds_grid_set(recordings,frames,4,global.inputs[5]);
ds_grid_set(recordings,frames,5,global.inputs[6]);
ds_grid_set(recordings,frames,6,global.inputs[19]);

frames+=1;
if (frames>1200)
	{
		instance_destroy();
	}