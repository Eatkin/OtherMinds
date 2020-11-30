/// @description Creation code
// You can write your code in this editor

event_inherited();

scr_intrinsic_variables(scr_return_text(460),0,0,0,0,0,1,true,HP.INF);
scr_modules_init();
scr_bio(scr_return_text(461), scr_return_text(462),sprite_index);

state=PlayerState.idle;

sprite_idle=sprite_index;

talkenabled=true;
xscaleflipenabled=false;
moveenabled=false;
gravityenabled=false;

//First dialogue
text[0]=scr_return_text(463);
text[1]=scr_return_text(464);
text[2]=scr_return_text(465);
text[3]=scr_return_text(466);
text[4]=scr_return_text(503);

//Second dialogue set
//We want to run this through a for loop with a switch statement and we break the loop once we find an event that hasn't been completed
//If associated event has been completed, _min+=1;
//Then _max=_min+2;
text[5]=scr_return_text(504); //Unlock teleporter in garden
text[6]=scr_return_text(505); //Unlock time trials
text[7]=scr_return_text(506); //Manipulate the balls
text[8]=scr_return_text(507); //Shower
text[9]=scr_return_text(508); //Treasure 1
text[10]=scr_return_text(509); //Augustine key
text[11]=scr_return_text(510); //LaserDisc Vol 1
text[12]=scr_return_text(511); //Treasure Map 2
text[13]=scr_return_text(512); //Lime Key
text[14]=scr_return_text(513); //LaserDisc Vol 2
text[15]=scr_return_text(720);	//Yellow Key
text[16]=scr_return_text(721);	//LaserDisc Vol 3
text[17]=scr_return_text(514); //No more hints!

var _min=0;
var _max=4;

scr_dialoguemap_init(_min,_max);


showinghints=false;
hintslist=ds_list_create();
hintsdialogue=false;

//Now updated dialogues if we are dispensing hints
//I don't know what the fuck this means to be perfectly honest, but just add an extra hint to the text array + it's condition below
if (scr_todo_checkComplete(13))
	{
		showinghints=true;
		//Set it to start from the smallest hing if we've check the todo
		for (var i=5; i<array_length_1d(text)-5; i+=1)
			{
				if (ds_list_size(hintslist)>=3)
					{
						break;
					}
				switch (i)
					{
						case 5:
							{
								//Teleporter in garden
								if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.ROCKTELEPORTACTIVE)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 6:
							{
								//Time trials
								if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.TIMETRIALSACTIVE)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 7:
							{
								//Grappa
								if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.GRAPPA) and !scr_inventory_check(obj_grappa))
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 8:
							{
								//Shower
								if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.OPENEDCELLAR)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 9:
							{
								//Treasure 1
								if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.COLLECTEDTREASUREMAP)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 10:
							{
								//Green key
								if (scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDGREENKEY)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 11:
							{
								//LaserDisc 1
								if (scr_inventory_check(obj_laser_diskvol1)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 12:
							{
								//Treasure 2
								if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.TREASURE_MAP)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 13:
							{
								//Lime key
								if (scr_inventory_check(obj_lime_key)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 14:
							{
								//LaserDisc 2
								if (scr_inventory_check(obj_laser_diskvol2)==false)
									{
										ds_list_add(hintslist,i);
									}
								break;
							}
						case 15:
							//Yellow key
							if (!scr_inventory_check(obj_yellowKey))
								ds_list_add(hintslist,i);
								
							break;
						case 16:
							//LaserDisc 3
							if (!scr_inventory_check(obj_laser_diskvol3))
								ds_list_add(hintslist,i);
								
							break;
					}
			}
		_max=array_length_1d(text)-1;
		if (ds_list_empty(hintslist)==true)
			{
				_min=_max;
			}
		else
			{
				_min=ds_list_find_value(hintslist,0);
			}
		if (ds_list_size(hintslist)<3)
			{
				ds_list_add(hintslist,_max);
			}
		else
			{
				_max=ds_list_find_value(hintslist,2);
			}
			
		_max=min(_max,array_length_1d(text)-1);
		scr_dialoguemap_init(_min,_max);
		//MANUALLY OVERRIDE
		dialogueprevious=_min-1;
	}