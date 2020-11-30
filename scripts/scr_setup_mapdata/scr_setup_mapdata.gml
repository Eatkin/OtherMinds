//Created 20/09/19
//Last updated 20/09/19

/*I'm writing an ugly brute force method of returning map data
We'll find what level set we're in and pull up data based on that
It will be a ds grid containing the room number, x,y xscale, yscale, orbs and secrets status
Basically a bunch of nodes
I don't know how I'm going to tell the game that there's paths between levels yet*/

//This grid will need to be destroyed when the map object is destroyed!!!!!!
themap=ds_grid_create(7,0);
connections=ds_grid_create(6,0);

//Find the room aand roomset
var grid=global.roomarray
var i, roomset;
for (i=0; i<ds_grid_height(grid); i+=1)
	{
		if ds_grid_get(grid,ROOMARRAY.ROOM,i)=room
			{
				roomset=ds_grid_get(grid,ROOMARRAY.ROOMSET,i);
				break;
			}
	}
	

switch (roomset)
	{
		case ROOMGROUP.TUTORIAL:
			{
				#region tutorial
				/*
				Easy
				1-2-3-4-5
				012345678
				*/
				scr_map_add_reference(room_Tutorials_1,0,0,2,1);
				scr_map_add_reference(room_Tutorials_2,3,0,1,1);
				scr_map_add_reference(room_Tutorials_3,5,0,1,1);
				scr_map_add_reference(room_Tutorials_4,7,0,1,1);
				scr_map_add_reference(room_Tutorials_5,9,0,1,1);
				
				scr_connection_add(2,0.5,3,0.5,room_Tutorials_1,room_Tutorials_2);
				scr_connection_add(4,0.5,5,0.5,room_Tutorials_2,room_Tutorials_3);
				scr_connection_add(6,0.5,7,0.5,room_Tutorials_3,room_Tutorials_4);
				scr_connection_add(8,0.5,9,0.5,room_Tutorials_4,room_Tutorials_5);
				break;
				#endregion
			}
		
		case ROOMGROUP.EDSPACE_ONE:
			#region EdSpace 1
			//EdSpace layout mockup
			//This is actually copied from the beta levels, will be very similar probably
			/*
			0S  
			1|		  
			211-22-33-44-5-BB-66
			3			 	  66
			4			 	  66
			5			  	  66
			 012345678901234567*/
			scr_map_add_reference(rm_EdSpace1_secret,0,0,1,1);
			scr_map_add_reference(rm_EdSpace1_1,0,2,2,1);
			scr_map_add_reference(rm_EdSpace1_2,3,2,2,1);
			scr_map_add_reference(rm_EdSpace1_3,6,2,2,1);
			scr_map_add_reference(rm_EdSpace1_4,9,2,2,1);
			scr_map_add_reference(rm_EdSpace1_4_5,12,2,1,1);
			scr_map_add_reference(room_EdSpace1_5,14,2,2,1);
			scr_map_add_reference(rm_EdSpace1_6,17,2,1,4);
			
			scr_connection_add(0.2,1,0.2,2,rm_EdSpace1_secret,rm_EdSpace1_1);
			scr_connection_add(2,2.2,3,2.2,rm_EdSpace1_1,rm_EdSpace1_2);
			scr_connection_add(5,2.8,6,2.8,rm_EdSpace1_2,rm_EdSpace1_3);
			scr_connection_add(8,2.8,9,2.8,rm_EdSpace1_3,rm_EdSpace1_4);
			scr_connection_add(11,2.2,12,2.8,rm_EdSpace1_4,rm_EdSpace1_4_5);
			scr_connection_add(13,2.8,14,2.8,rm_EdSpace1_4_5,room_EdSpace1_5);
			scr_connection_add(16,2.8,17,2.2,room_EdSpace1_5,rm_EdSpace1_6);
			break;
			#endregion
		
		case ROOMGROUP.ED_HOUSE:
			{
				#region ed's house
				
				/*a difficult layout, might be better off using grid paper
				01 2 3 b
				1\ | | / gg
				2ll-h-k--gg
				3        |
				4        c
				 01234567890
				 */
				//Only got the bedroom at the moment
				scr_map_add_reference(rm_Edsparebedroom,0,0,1,1);
				scr_map_add_reference(rm_Edbedroom,2,0,1,1);
				scr_map_add_reference(rm_Edhallway,3,2,1,1);
				scr_map_add_reference(rm_Edguestbedroom,4,0,1,1);
				scr_map_add_reference(rm_Edbathroom,6,0,1,1);
				scr_map_add_reference(rm_Edkitchen,5,2,1,1);
				scr_map_add_reference(rm_Edlivingroom,0,2,2,1);
				scr_map_add_reference(rm_Edgarden,8,1,3,2);
				scr_map_add_reference(rm_Edcellar,8,4,1,1);
				
				//Connections
				scr_connection_add(0.5,1,3.1,2.2,rm_Edsparebedroom,rm_Edhallway);
				scr_connection_add(2.5,1,3.3,2.1,rm_Edbedroom,rm_Edhallway);
				scr_connection_add(3.7,2.1,4.5,0.9,rm_Edguestbedroom,rm_Edhallway);
				scr_connection_add(3.9,2.1,6.5,0.8,rm_Edhallway,rm_Edbathroom);
				scr_connection_add(4,2.5,5,2.5,rm_Edhallway,rm_Edkitchen);
				scr_connection_add(2,2.5,3,2.5,rm_Edlivingroom,rm_Edhallway);
				scr_connection_add(6,2.5,8,2.5,rm_Edkitchen,rm_Edgarden);
				scr_connection_add(8.5,2,8.5,4,rm_Edgarden,rm_Edcellar);
				
				break;
				#endregion
			}
		case ROOMGROUP.OVERWORLD:
			{
				#region overworld
				//I'm going to do all coordinates relative so I don't have to shift them
				/*
				0  O-E-O-O
				1   /  /\
				2C-C  T MMMMMMMM-End
				3
				4
				 0123456789012345678
				 E is (xcentre, ycentre)
				*/
				
				var xcentre=4;
				var ycentre=0;
				scr_map_add_reference(rm_overworld_edhouse,xcentre,ycentre,1,1);
				scr_map_add_reference(rm_overworld_ochrehill,xcentre-2,ycentre,1,1);
				scr_map_add_reference(rm_overworld_puzzlecave,xcentre-2,ycentre+2,1,1);
				scr_map_add_reference(rm_puzzlecavechamber,xcentre-4,ycentre+2,1,1);
				scr_map_add_reference(rm_overworld_outhouse,xcentre+2,ycentre,1,1);
				scr_map_add_reference(rm_inside_outhouse,xcentre+1,ycentre+2,1,1);
				scr_map_add_reference(rm_mysterious_room,xcentre+3,ycentre+2,8,1);
				scr_map_add_reference(rm_overworld_officeblock,xcentre+4,ycentre,1,1);
				scr_map_add_reference(rm_endTimes,xcentre+12,ycentre+2,4,1);
				
				//Connections
				scr_connection_add(xcentre-1,ycentre+0.5,xcentre,ycentre+0.5,rm_overworld_edhouse,rm_overworld_ochrehill);
				scr_connection_add(xcentre-1,ycentre+2.5,xcentre+0.5,ycentre+0.9,rm_overworld_ochrehill,rm_overworld_puzzlecave);
				scr_connection_add(xcentre-3,ycentre+2.5,xcentre-2,ycentre+2.5,rm_overworld_puzzlecave,rm_puzzlecavechamber);
				scr_connection_add(xcentre+1,ycentre+0.5,xcentre+2,ycentre+0.5,rm_overworld_edhouse,rm_overworld_outhouse);
				scr_connection_add(xcentre+1.5,ycentre+2,xcentre+2.7,ycentre+0.5,rm_overworld_outhouse,rm_inside_outhouse);
				scr_connection_add(xcentre+2.5,ycentre+1,xcentre+3.5,ycentre+2.5,rm_overworld_outhouse,rm_mysterious_room);
				scr_connection_add(xcentre+3,ycentre+0.5,xcentre+4,ycentre+0.5,rm_overworld_outhouse,rm_overworld_officeblock);
				scr_connection_add(xcentre+11,ycentre+2.5,xcentre+12,ycentre+2.5,rm_mysterious_room,rm_endTimes);
				break;
				#endregion
			}
		case ROOMGROUP.OCHREHILL:
			{
				#region ochre hill
				/*A little bit confusing - basically we do everything relative to the righmost and topmost coordinates!!!
			   -4           
			   ...
			   -2  88-99-b-1
			   -17/		   |
				t7     4-3-2-1
				17-6-5-4 3   1
				2        |
				3        s
				 210987654321r
				 */
				var right=12;
				var top=4;
				scr_map_add_reference(rm_ochrehill_1,right,top,1,2);
				scr_map_add_reference(rm_ochrehill_2,right-2,top,1,1);
				scr_map_add_reference(rm_ochrehill_3,right-4,top,1,2);
				scr_map_add_reference(rm_ochrehill_4,right-6,top,1,2);
				scr_map_add_reference(rm_ochrehill_5,right-8,top+1,1,1);
				scr_map_add_reference(rm_ochrehill_6,right-10,top+1,1,1);
				scr_map_add_reference(rm_ochrehill_secret,right-4,top+3,1,1);
				scr_map_add_reference(rm_ochrehill_7,right-12,top-1,1,3);
				scr_map_add_reference(rm_ochrehill_8,right-10,top-2,2,1);
				scr_map_add_reference(rm_ochrehill_9,right-7,top-2,2,1);
				scr_map_add_reference(rm_ochrehill_bonus,right-4,top-2,1,1);
				scr_map_add_reference(rm_ochrehill_11,right-2,top-2,1,1);
				//scr_map_add_reference(rm_ochrehill_bonus,right-2,top-4,1,1);
				
				//Make sure we go from left to right for some reason
				scr_connection_add(right-1,top+0.5,right,top+0.5,rm_ochrehill_1,rm_ochrehill_2);
				scr_connection_add(right-3,top+0.5,right-2,top+0.5,rm_ochrehill_2,rm_ochrehill_3);
				scr_connection_add(right-5,top+0.2,right-4,top+0.2,rm_ochrehill_3,rm_ochrehill_4);
				scr_connection_add(right-7,top+1.8,right-6,top+1.8,rm_ochrehill_4,rm_ochrehill_5);
				scr_connection_add(right-9,top+1.2,right-8,top+1.2,rm_ochrehill_5,rm_ochrehill_6);
				scr_connection_add(right-3.5,top+2,right-3.5,top+3,rm_ochrehill_3,rm_ochrehill_secret);
				scr_connection_add(right-11,top+1.9,right-10,top+1.9,rm_ochrehill_6,rm_ochrehill_7);
				scr_connection_add(right-11,top-0.9,right-10,top-1.1,rm_ochrehill_7,rm_ochrehill_8);
				scr_connection_add(right-8,top-1.1,right-7,top-1.1,rm_ochrehill_8,rm_ochrehill_9);
				scr_connection_add(right-5,top-1.1,right-4,top-1.1,rm_ochrehill_9,rm_ochrehill_bonus);
				scr_connection_add(right-3,top-1.1,right-2,top-1.1,rm_ochrehill_bonus,rm_ochrehill_11);
				scr_connection_add(right-1.5,top-1,right-1.5,top,rm_ochrehill_11,rm_ochrehill_2);
				//scr_connection_add(right-3,top-1.9,right-1.5,top-3.9,rm_ochrehill_10,rm_ochrehill_bonus);
				#endregion
				break;
			}
		case ROOMGROUP.EDSPACE_ONE_CHALLENGE:
			{
				#region challenges
				/*
				0EE   
				1EE OO EE
				012345678
				*/
				scr_map_add_reference(rm_EdSpace_z1_challenge,0,0,2,2);
				scr_map_add_reference(rm_OchreHill_challenge,4,1,2,1);
				scr_map_add_reference(rm_OchreHill_challenge,8,1,2,1);
				#endregion
				break;
			}
		case ROOMGROUP.OFFICES:
			{
				#region office block
				
				/*It's a tower but also has side bits at some point. Deal with that later lol
				0   6 not used
				1   |
				2   5 not used
				3   |
				4   4 not used
				5   |
				6  33
				7   |
				8D  2
				9 V | V
				0   1
				1 V |
				2   R
				3
				4GGGG-E
				5     E
				6     E
				 012345
				*/
				scr_map_add_reference(rm_office_reception,3,12,1,1);
				scr_map_add_reference(rm_office_floor_one,3,10,1,1);
				scr_map_add_reference(rm_office_vent_room_one,1,9,1,1);
				scr_map_add_reference(rm_office_vent_room_two,5,9,1,1);
				scr_map_add_reference(rm_office_vent_room_three,1,11,1,1);
				scr_map_add_reference(rm_office_floor_two,3,8,1,1);
				scr_map_add_reference(rm_office_dr_ds_office,0,8,1,1);
				scr_map_add_reference(rm_office_gauntlet,0,14,4,1);
				scr_map_add_reference(rm_officeGauntletEscape,5,14,1,3);
				scr_map_add_reference(rm_office_new_ds_office,2,6,2,1);
				
				scr_connection_add(3.5,11,3.5,12,rm_office_reception,rm_office_floor_one);
				scr_connection_add(2,9.5,3,10.5,rm_office_floor_one,rm_office_vent_room_one);
				scr_connection_add(4,10.5,5,9.5,rm_office_floor_one,rm_office_vent_room_two);
				scr_connection_add(2,11.5,3,10.5,rm_office_floor_one,rm_office_vent_room_three);
				scr_connection_add(3.5,9,3.5,10,rm_office_floor_one,rm_office_floor_two);
				scr_connection_add(1,8.5,3,8.5,rm_office_floor_two,rm_office_dr_ds_office);
				scr_connection_add(0.5,9,0.5,14,rm_office_dr_ds_office,rm_office_gauntlet);
				scr_connection_add(4,14.2,5,14.2,rm_officeGauntletEscape,rm_office_gauntlet);
				scr_connection_add(3.5,7,3.5,8,rm_office_floor_two,rm_office_new_ds_office);
				#endregion
				break;
			}
		case ROOMGROUP.EDSPACE_TWO:
			#region EdSpace 2
			scr_map_add_reference(rm_EdSpace2_secret,0,0,1,1);
			scr_map_add_reference(rm_EdSpace2_3,2,0,1,2);
			scr_map_add_reference(rm_EdSpace2_2,2,3,1,1);
			scr_map_add_reference(rm_EdSpace2_4,4,3,1,1);
			scr_map_add_reference(rm_EdSpace2_5,4,5,1,1);
			scr_map_add_reference(rm_EdSpace2_1,2,5,1,1);
			scr_map_add_reference(rm_EdSpace2_boss,2,7,4,1);
			scr_map_add_reference(rm_EdSpace2_6,6,5,1,1);
			
			/*Level order is kinda weird ecause I didn't build them in order
			It's also just kinda a weird layout anyway
			 0123456
			0S-3
			1  3
			2  |
			3  2-4
			4    |
			5  1-5 6
			6  |  /
			7  BBBB
			*/
			
			scr_connection_add(1,0.8,2,0.5,rm_EdSpace2_secret,rm_EdSpace2_3);
			scr_connection_add(2.8,2,2.2,3,rm_EdSpace2_3,rm_EdSpace2_2);
			scr_connection_add(3,3.5,4,3.5,rm_EdSpace2_2,rm_EdSpace2_4);
			scr_connection_add(4.8,4,4.8,5,rm_EdSpace2_4,rm_EdSpace2_5);
			scr_connection_add(3,5.8,4,5.5,rm_EdSpace2_1,rm_EdSpace2_5);
			scr_connection_add(2.5,6,2.5,7,rm_EdSpace2_boss,rm_EdSpace2_1);
			scr_connection_add(5.5,7,6.2,6,rm_EdSpace2_boss,rm_EdSpace2_6);
			break;
			#endregion
			
		case ROOMGROUP.RHYTHM:
			#region Rhythm Levels
			/*
			0EE   
			1EE OO EE WW
			012345678901
			*/
			scr_map_add_reference(rm_EdSpace1_Rhythm,0,0,2,2);
			scr_map_add_reference(rm_Ochre_Rhythm,4,1,2,1);
			scr_map_add_reference(rm_EdSpace2_Rhythm,7,1,2,1);
			scr_map_add_reference(rm_whiteRhythm,10,1,2,1);
			break;
			#endregion
			
		case ROOMGROUP.EDSPACE_ONEBETA:	
			{
				#region edspace zone one (BETA)
				//EdSpace layout mockup
				/*
				06    33
				1|  2-33-44-55-7
				211-2    44 55 7
				3|
				4TT
				 0123456789012345*/
				scr_map_add_reference(room_EdSpace1_1,0,2,2,1);
				scr_map_add_reference(rm_secret_tutorial,0,8,2,1);
				scr_map_add_reference(room_EdSpace1_2,3,1,1,2);
				scr_map_add_reference(room_EdSpace1_3,5,0,2,2);
				scr_map_add_reference(room_EdSpace1_4,8,1,2,2);
				scr_map_add_reference(room_EdSpace1_5,11,1,2,2);
				scr_map_add_reference(room_EdSpace1_6,0,0,1,1);
				scr_map_add_reference(room_EdSpace1_7,14,1,1,3);

				scr_connection_add(2,2.2,3,2.9,room_EdSpace1_1,room_EdSpace1_2); //Room 1 to 2
				scr_connection_add(1,3,1,8,room_EdSpace1_1,rm_secret_tutorial);
				scr_connection_add(0.25,2,0.25,1,room_EdSpace1_1,room_EdSpace1_6); //Room 1 to 6
				scr_connection_add(4,1.2,5,1.75,room_EdSpace1_2,room_EdSpace1_3); //Room 2 to 3
				scr_connection_add(7,1.75,8,1.75,room_EdSpace1_3,room_EdSpace1_4); //Room 3 to 4
				scr_connection_add(10,1.6,11,2.6,room_EdSpace1_4,room_EdSpace1_5); //Room 4 to 5
				scr_connection_add(13,1.9,14,1.1,room_EdSpace1_5,room_EdSpace1_7); //Room 5 to 7

				break;
				#endregion
			}
		
		case ROOMGROUP.OCHREALPHA:
			/*
			4-9-10
			01234
			*/
			scr_map_add_reference(rm_ochrehill_4OLD,0,0,1,1);
			scr_map_add_reference(rm_ochrehill_9OLD,2,0,1,1);
			scr_map_add_reference(rm_ochrehill_10,4,0,1,1);
			
			scr_connection_add(1,0.5,2,0.5,rm_ochrehill_4OLD,rm_ochrehill_9OLD);
			scr_connection_add(3,0.5,4,0.5,rm_ochrehill_10,rm_ochrehill_9OLD);
			break;
	}