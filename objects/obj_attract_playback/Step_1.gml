/// @description

if (!instance_exists(obj_transition) and active==false)
	{
		active=true;
	}
if (active==false)
	{
		exit;
	}

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

var grid=inputsgrid;

for (var i=0; i<array_length_1d(global.inputs); i+=1)
	{
		global.inputs[i]=0;
	}


global.inputs[0]=ds_grid_get(grid,frame,0);
global.inputs[1]=ds_grid_get(grid,frame,1);
global.inputs[4]=ds_grid_get(grid,frame,2);
global.inputs[16]=ds_grid_get(grid,frame,3);
global.inputs[5]=ds_grid_get(grid,frame,4);
global.inputs[6]=ds_grid_get(grid,frame,5);
global.inputs[19]=ds_grid_get(grid,frame,6);

frame+=1;
if (frame>=1200)
	{
		scr_quit_to_menu();
	}