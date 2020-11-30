//Created 07/10/19
//Last updated 07/10/19

//A few Sage-specific variables
soundplaying=scr_play_sound(snd_sage_leave,false,0);
maxspeed=4;
canpossess=1;
possessionrange=96;
target=noone;

scr_intrinsic_variables(scr_return_text(157), 0.5, 1, 4, 4, 4, global.playerpowerlevel ,0,HP.INF);

#region Pathfinding
sage_grid=noone;
sage_path=path_add();
gridrefreshrate=15;
var cellwidth=8;
var cellheight=8;
//This is the amount we can move before the grid resets + possession range
var xrange=maxxspeed*gridrefreshrate+possessionrange;
var yrange=maxyspeed*gridrefreshrate+possessionrange;
var gridleft=max(0,floor((x-xrange)/cellwidth)*cellwidth);
var gridtop=max(0,floor((y-yrange)/cellheight)*cellheight);
var hrepeat=ceil((xrange*2)/cellwidth);
var vrepeat=ceil((yrange*2)/cellheight);
//Full room indexed
//sage_grid=mp_grid_create(0,0,room_width/cellwidth,room_height/cellheight,cellwidth,cellheight);
//Only index up to max range
sage_grid=mp_grid_create(gridleft,gridtop,hrepeat,vrepeat,cellwidth,cellheight);
mp_grid_add_instances(sage_grid,obj_solid,0);
path_speed=0;
pathavailable=0;

//Now we need to add the barriers to the grid
var numberofhbarriers=instance_number(obj_barrier_hor);
var numberofvbarriers=instance_number(obj_barrier_vert);
var i;
var barriernearest, barrierx, barriery;
//Urgh ugly code because the barrier technically don't exist
if numberofhbarriers!=0
	{
		for (i=0; i<numberofhbarriers;i+=1)
			{
				barriernearest=scr_instance_nth_nearest(x,y,obj_barrier_hor,i+1);
				barrierx=barriernearest.x;
				barriery=barriernearest.y;
				if barriernearest.state=BARRIER.NORMAL
					{
						mp_grid_add_rectangle(sage_grid,barrierx,barriery,barrierx+barriernearest.barrierrepeats*32,barriery+barriernearest.sprite_height);
					}
			}
	}
	
//Same for v barriers
if numberofvbarriers!=0
	{
		for (i=0; i<numberofvbarriers;i+=1)
			{
				barriernearest=scr_instance_nth_nearest(x,y,obj_barrier_vert,i+1);
				barrierx=barriernearest.x;
				barriery=barriernearest.y;
				if barriernearest.state=BARRIER.NORMAL
					{
						mp_grid_add_rectangle(sage_grid,barrierx,barriery,barrierx+barriernearest.sprite_width,barriery+barriernearest.barrierrepeats*32);
					}
			}
	}

//Now we need to clear rectangles that contain instances
for (var i=0; i<instance_number(parent_possessable); i+=1)
	{
		var inst=scr_instance_nth_nearest(x,y,parent_possessable,i+1);
		var x1=inst.bbox_left;
		var x2=inst.bbox_right;
		var y1=inst.bbox_top;
		var y2=inst.bbox_bottom;
		mp_grid_clear_rectangle(sage_grid,x1,y1,x2,y2);
	}

//Clear rectangle that contains myself
mp_grid_clear_rectangle(sage_grid,bbox_left,bbox_top,bbox_right,bbox_bottom);
#endregion

alarm[0]=gridrefreshrate; //For refreshing the grid once per second
	
//Audio
myemitter=noone;

//Just include this to not bugger up the camera
scr_bio(scr_return_text(136), scr_return_text(137),spr_Sage);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_idle=spr_Sage;
sprite_freeflying=spr_Sage;
sprite_possessing=spr_Sage;
#endregion

#region masks
masknormal=sprite_index;
#endregion

#region sounds (no sounds)
//No sounds
#endregion

#region modules
xscaleflipenabled=false;
possessingenabled=true;
freeflyingenabled=true;
manualscalingenabled=true;
#endregion

//This makes Sage grow when created
image_xscale=0.1;
image_yscale=0.1;

//There's also the 'pop' option
returntoedcounter=0;