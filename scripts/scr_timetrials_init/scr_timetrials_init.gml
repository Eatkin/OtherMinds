//Created 15/03/20
//Last updated who knows when because I never change this lol


//Anyway we make a ds grid containing all the best times (also room names, NAMES!! We use names now so indices do not change)
var timeTrialCount=3;
global.besttimes=ds_grid_create(5,timeTrialCount);
var grid=global.besttimes;
var num=0;
ds_grid_set(grid,BESTTIMES.ROOMNAME,num,room_get_name(rm_EdSpace_z1_challenge));
ds_grid_set(grid,BESTTIMES.TARGETTIME,num,50);
ds_grid_set(grid,BESTTIMES.BESTTIME,num,600);
ds_grid_set(grid,BESTTIMES.DEVTIME,num,36.93);
ds_grid_set(grid,BESTTIMES.REF,num,TIMETRIALS.EDSPACE_Z1_TRIAL); //The enum reference
num+=1;

//Ochre Challenge
ds_grid_set(grid,BESTTIMES.ROOMNAME,num,room_get_name(rm_OchreHill_challenge));
ds_grid_set(grid,BESTTIMES.TARGETTIME,num,36);
ds_grid_set(grid,BESTTIMES.BESTTIME,num,600);
ds_grid_set(grid,BESTTIMES.DEVTIME,num,23.10);
ds_grid_set(grid,BESTTIMES.REF,num,TIMETRIALS.OCHRE_TRIAL);
num+=1;

//EdSpace 2
ds_grid_set(grid,BESTTIMES.ROOMNAME,num,room_get_name(rm_EdSpace_z2_challenge));
ds_grid_set(grid,BESTTIMES.TARGETTIME,num,27);
ds_grid_set(grid,BESTTIMES.BESTTIME,num,600);
ds_grid_set(grid,BESTTIMES.DEVTIME,num,22.15);
ds_grid_set(grid,BESTTIMES.REF,num,TIMETRIALS.EDSPACE_Z2_TRIAL);
num+=1;

//RESIZE THE GRID BEFORE YOU ADD ANYMORE
//ALSO ADD A NEW ENUM REFERENCE
//PS DON'T BE AN IDIOT WHEN UPDATING THIS BECAUSE I USUALLY AM