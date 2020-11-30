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

if place_meeting(x,y,obj_boss_widelaser)
	{
		destroyed=true;
	}
if destroyed=true
	{
		if destroyedtimer>30+irandom(abs(120-destroyedtimer))
			{
				yspeed+=global.gravstrength;
			}
		destroyedtimer+=1;
		if destroyedtimer%3=0
			{
				flashwhite=flashwhite^1;
			}
	}

var _list=ds_list_create();
	
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
//Only the player will be on these but whatever you know who cares mate
_num=ds_list_size(_list);
			
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
						part_particles_create(global.partSys,xx,yy,global.platformParticle,1);
					}
			}
	}
instancesontop=_num;
	
//Now we mobe
//This only moves left
x-=xspeed;
if _num!=0
	{
		var yunp=yunperturbed;
		var xspd=-xspeed;
		for (i=0; i<_num; i+=1)
			{
				with (_list[| i])
					{
						if !place_meeting(x+xspd,yunp,obj_solid)
							{
								x+=xspd;
							}
						if x<0 or x>room_width
							{
								x=xprevious;
							}
					}
			}
	}
	
y+=yspeed;
if _num!=0
	{
		var yspd=yspeed;
		for (i=0; i<_num; i+=1)
			{
				with (_list[| i])
					{
						repeat(ceil(abs(yspeed)))
							{
								if !place_meeting(x,y+sign(yspeed),obj_solid)
									{
										y+=yspd;
									}
							}
					}
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

//Now just destroy self if off camera
//There's a couple platforms to keep when xspeed=0 before boss starts
var bossstate=obj_boss_controller.state;
if x!=clamp(x,319,833) and xspeed!=0 and bossstate!=BOSS_STATE.DEFEATED
	{
		instance_destroy();
	}