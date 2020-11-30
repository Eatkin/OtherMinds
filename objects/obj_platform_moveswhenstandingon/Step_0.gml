/// @description Moves
// You can write your code in this editor

/*Plan for this thing:
Moving when something jumps on it
We keep track of yunperturbed for collission checks
We keep track of instance number on top
If it increases, we apply a perturbation which lerps towards a perturbation value
Then once there it lerps back
If another instance joins while lerping back, it move towards the perturbation value again
*/

event_inherited();

if global.hardpause=1
	{
		exit;
	}
	
//Xspeed and yspeed additions
var _list=ds_list_create();

var angle=dir*pi*0.5;
xspeed+=acc*cos(angle);
yspeed-=acc*sin(angle);
xspeed=clamp(xspeed,-maxspeed,maxspeed);
yspeed=clamp(yspeed,-maxspeed,maxspeed);

//state management, for conservation of momentum etc
if xspeed!=0 or yspeed!=0
	{
		state=PlayerState.moving;
	}
else
	{
		state=PlayerState.idle;
	}

//The player on top can be anyone
//So let's create a list of instances to move all of them as appropriate
//Start timer to disappear when player leaves
var _num=collision_line_list(x,y-1,x+sprite_width,y-1,parent_possessable,0,1,_list,false);		
var i;
for (i=0; i<_num; i+=1)
	{
		var inst=_list[| i];
		//This will remove the instance from the list if its below the surface of the platform
		if inst.bbox_bottom>=y or inst.yspeed<0
			{
				ds_list_delete(_list,i);
				//Also set i back 1 because we've replaced the position in the list
				i-=1;
			}
		//As we're dynamically reshaping the list we need to have an exit condition
		if i=ds_list_size(_list)-1
			{
				break;
			}
	}
//Update number of instances
_num=ds_list_size(_list)
if _num=0
	{
		dir=startdir+2;
		if dir>4
			{
				dir-=4;
			}
		var _lay=layer_get_id("objects");
		depth=layer_get_depth(_lay);
	}
else
	{
		dir=startdir;
		
		var _lay=layer_get_id("objects");
		depth=layer_get_depth(_lay)-1;
	}
//Start to apply a perturbation
if _num>instancesontop and !place_meeting(x,y,obj_semisolid)
	{
		var createParticles=false;
		if (perturb==0)
			{
				perturb=1;
				yunperturbed=y;
				perturbationdir=1;
				createParticles=true;
			}
		else if (perturbationdir=-1)
			{
				perturbationdir=1;
				createParticles=true;
			}
		if (createParticles==true)
			{
				var particleNum=irandom(10);
				repeat(particleNum)
					{
						var xx=x+random(sprite_width);
						var yy=y+sprite_height*0.5+random(sprite_height*0.5);
						part_particles_create(global.partSys,xx,yy,global.dirtParticle,1);
					}
			}
	}
instancesontop=_num;
	
//Now we mobe
//Oh god how many nested brackets???!
repeat(ceil(abs(xspeed)))
	{
		if x=xstart and dir!=startdir
			{
				break;
			}
		if !place_meeting(x+cos(angle),yunperturbed,obj_solid)
			{
				x+=cos(angle);
				if _num!=0
					{
						for (i=0; i<_num; i+=1)
							{
								with (_list[| i])
									{
										if !place_meeting(x+cos(angle),y,obj_solid)
											{
												x+=cos(angle);
											}
										if x<0 or x>room_width
											{
												x=xprevious;
											}
									}
							}
					}
			}
		else
			{
				break;
			}
	}
//Remember that y axis is reversed so move in the negative y direction
repeat(ceil(abs(yspeed)))
	{
		if yunperturbed=ystart and dir!=startdir
			{
				break;
			}
		if bbox_bottom<0 and sign(yspeed)=-1
			{
				break;
			}
		//We add sprite_height if moving down because the collision box is only a line
		var yy=yunperturbed;
		if (dir==3)
			yy+=sprite_height;
		if !place_meeting(x,yy-sin(angle),obj_solid)
			{
				y-=sin(angle);
				if _num!=0
					{
						for (i=0; i<_num; i+=1)
							{
								with (_list[| i])
									{
										if !place_meeting(x,y-sin(angle),obj_solid)
											{
												y-=sin(angle);
											}
										else
											{
												//Fall through platform
												state=PlayerState.air;
											}
									}
							}
					}
					yunperturbed-=sin(angle);
			}
		else
			{
				break;
			}
	}
//Now here we can apply the perturbation
if perturb=1
{
	var _y=y;
	if perturbationdir=1
		{
			y=lerp(y,yunperturbed+perturbamount,0.05);
			y=ceil(y);
			if y>=yunperturbed+perturbamount-0.2
				{
					y=yunperturbed+perturbamount;
					perturbationdir=-1;
				}
		}
	else
		{
			y=lerp(y,yunperturbed,0.05);
			y=floor(y);
			if y<yunperturbed+0.2
				{
					y=yunperturbed;
					perturb=0;
				}
		}
	//Update the carried objects y position
	var yperturbation=y-_y;
	if _num!=0
		{
			for (i=0; i<_num; i+=1)
				{
					with (_list[| i])
						{
							if !place_meeting(x,y+yperturbation,obj_solid)
								{
									y+=yperturbation;
								}
						}
				}
		}
}

ds_list_destroy(_list);