/// @description Set transition size
// You can write your code in this editor

//Have to put this here otherwise the camera doesn't get repositioned
//Now get the player coords relative to the cam
var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);
var camwidth=camera_get_view_width(cam);
var camheight=camera_get_view_height(cam);

var player=parent_main_character;
//Prioritise dead characters -> Current instance
var _num=instance_number(parent_main_character)
if (_num>1)
	{
		player=global.currentinstance;
		for (var i=0; i<_num; i+=1)
			{
				var inst=instance_find(parent_main_character,i);
				if (inst.state==PlayerState.dead)
					{
						player=inst;
					}
			}
	}
var playerx=player.x;
var playery=player.y;
transitionx=playerx-camx;
transitionx+=guiwidth*0.5*(1-camwidth/guiwidth);
transitiony=playery-camy;
transitiony+=guiheight*0.5*(1-camheight/guiheight);
//This should be the circle max radius
//We calculate that radius here
//It just finds the max distance from player to each of the four corners
circlemaxradius=max(point_distance(playerx,playery,camx,camy),point_distance(playerx,playery,camx,camy+camheight),point_distance(playerx,playery,camx+camwidth,camy),point_distance(playerx,playery,camx+camwidth,camy+camheight));

switch (transition_type)
	{
		case TRANSITION.CIRCLE_OUT:	
			{
				//I do a weird lerp amount because otherwise it zooms out way too quick
				transitioncounter=lerp(transitioncounter,transitioncountermax,lerpamount*max(0.01,transitioncounter*0.1));
				if transitioncounter>transitioncountermax-0.1
					{
						instance_destroy();
					}
				if transitioncounter>transitioncountermax*0.5
					{
						global.softpause=0;
					}
				break;
			}
		case TRANSITION.CIRCLE_IN:
			{
				//Pause if we're leaving the level
				global.softpause=1;
				//Outward transition starts from max radius and gets smaller
				if transitioncounter=0
					{
						transitioncounter=transitioncountermax;
					}
				transitioncounter=lerp(transitioncounter,0,lerpamount);
				if transitioncounter<0.1
					{
						transitioncomplete=1;
					}
				break;
			}
		case TRANSITION.FADE_IN:
			{
				transitionalpha=transitioncounter/transitioncountermax;
				transitioncounter=lerp(transitioncounter,transitioncountermax,lerpamount*max(0.01,transitioncounter*0.1));
				if transitionalpha>0.9
					{
						transitioncomplete=true;
						transitionalpha=1;
					}
				break;
			}
		case TRANSITION.FADE_OUT:
			{
				transitionalpha=1-transitioncounter/transitioncountermax;
				transitioncounter=lerp(transitioncounter,transitioncountermax,lerpamount*max(0.01,transitioncounter*0.1));
				if transitionalpha<0.1
					{
						transitioncomplete=true;
						transitionalpha=0;
						instance_destroy();
					}
				break;
			}
		case TRANSITION.BLOCK_IN:
			{
				transitioncounter=lerp(transitioncounter,transitioncountermax,lerpamount*max(0.01,transitioncounter*0.1));
				if transitioncounter>0.9
					{
						transitioncomplete=true;
					}
				break;
			}
		case TRANSITION.BLOCK_OUT:
			{
				transitioncounter=lerp(transitioncounter,transitioncountermax,lerpamount*max(0.01,transitioncounter*0.1));
				if transitioncounter<0.1
					{
						transitioncomplete=true;
						instance_destroy();
					}
				break;
			}
		default:
			{
				if transitioncomplete=true
					{
						global.softpause=false;
						//A really fun programming quirk that has arrisen hahaha
						//I have to have T_NONE_IN and T_NONE_OUT even though they both do LITERALLY NOTHING
						if transition_type=TRANSITION.T_NONE_OUT
							{
								instance_destroy();
							}
					}
				break;
			}
	}
	
if (global.attract==true)
	{
		global.softpause=false;
		instance_destroy();
	}