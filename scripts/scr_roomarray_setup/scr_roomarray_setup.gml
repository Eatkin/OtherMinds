//Created 30/08/19
//Last updated 30/08/19

/*Lets talk about what we need to store here
We need to store the room id
The room grouping
We need to store whether all the secrets have been found
We need to store whether all the orbs have been found
I can in future add any other room properties necessary

Also just need a couple scripts to set all secrets found
and all orbs found
We'll do a check whenever we trigger and event, start the room, or collect an orb*/

//Now we just need a way of updating when secrets are found - in particular the teleporters are annoying because they need to only decrease the count exactly once
//So I guess we now need a teleporters grid to go alongside everything else
//Or just use the events system - but that leads to an incredibly long list of exceptions in the ports themselves, so grid is nicer its a single check

global.roomarray=ds_grid_create(ROOMARRAY.MAX,0);

//Argument0 - room reference
//Argument1 - room group
//Argument2 - All orbs found
//Argument3 - All secrets found
//Argument4 - Number of secrets

var set=ROOMGROUP.TUTORIAL;
scr_roomarray_add_room(room_Tutorials_1,set,true,true,0);
scr_roomarray_add_room(room_Tutorials_2,set,true,true,0);
scr_roomarray_add_room(room_Tutorials_3,set,true,true,0);
scr_roomarray_add_room(room_Tutorials_4,set,true,true,0);
scr_roomarray_add_room(room_Tutorials_5,set,false,false,1); //One teleporter

set=ROOMGROUP.EDSPACE_ONE;
scr_roomarray_add_room(rm_EdSpace1_1,set,false,false,3);	//Key, unlock door, push button
scr_roomarray_add_room(rm_EdSpace1_2,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace1_3,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace1_4,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace1_4_5,set,false,true,0);
scr_roomarray_add_room(room_EdSpace1_5,set,false,false,2);	//Boss!
scr_roomarray_add_room(rm_EdSpace1_6,set,true,true,0);
scr_roomarray_add_room(rm_EdSpace1_secret,set,true,false,1);		//Lazor Disk

set=ROOMGROUP.ED_HOUSE;
scr_roomarray_add_room(rm_Edbedroom,set,false,false,1);
scr_roomarray_add_room(rm_Edhallway,set,false,true,0);
scr_roomarray_add_room(rm_Edsparebedroom,set,false,false,1);
scr_roomarray_add_room(rm_Edbathroom,set,true,false,1); //The secret is the fogged up mirror
scr_roomarray_add_room(rm_Edguestbedroom,set,false,false,2); //The secret is the safe being unlocked AND big Slime's Granite Surface
scr_roomarray_add_room(rm_Edkitchen,set,true,true,0);
scr_roomarray_add_room(rm_Edlivingroom,set,true,true,0);
scr_roomarray_add_room(rm_Edgarden,set,false,false,2); //The secret is the cellar unlocking AND the teleporter
scr_roomarray_add_room(rm_Edcellar,set,false,false,1);

set=ROOMGROUP.OVERWORLD;
scr_roomarray_add_room(rm_overworld_edhouse,set,true,true,0);
scr_roomarray_add_room(rm_overworld_ochrehill,set,true,true,0);
scr_roomarray_add_room(rm_overworld_puzzlecave,set,true,false,1);
scr_roomarray_add_room(rm_puzzlecavechamber,set,false,true,0);
scr_roomarray_add_room(rm_overworld_outhouse,set,true,true,0);
scr_roomarray_add_room(rm_inside_outhouse,set,true,false,3);		//3 glitchy artifacts
scr_roomarray_add_room(rm_mysterious_room,set,true,false,1);		//The secret is getting to a certain point in the room
scr_roomarray_add_room(rm_overworld_officeblock,set,false,true,0);
scr_roomarray_add_room(rm_endTimes,set,true,true,0);				//Nothing

set=ROOMGROUP.OCHREHILL;
scr_roomarray_add_room(rm_ochrehill_1,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_2,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_3,set,false,false,4); //Teleporter, collect key, unlock key and treasure map!
scr_roomarray_add_room(rm_ochrehill_4,set,false,false,1); //Grappa
scr_roomarray_add_room(rm_ochrehill_5,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_6,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_secret,set,true,false,1); //1 secret, the laserdisc volume 2!
scr_roomarray_add_room(rm_ochrehill_7,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_8,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_9,set,false,false,1); //The cool cat's club
scr_roomarray_add_room(rm_ochrehill_11,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_bonus,set,false,false,1); //Teleporter

//I named this badly, its all the challenge rooms so it doesn't clutte the menu
set=ROOMGROUP.EDSPACE_ONE_CHALLENGE;
scr_roomarray_add_room(rm_EdSpace_z1_challenge,set,true,true,0);
scr_roomarray_add_room(rm_EdSpace_z2_challenge,set,true,true,0);
scr_roomarray_add_room(rm_OchreHill_challenge,set,true,true,0);

set=ROOMGROUP.OFFICES;
scr_roomarray_add_room(rm_office_reception,set,true,true,0);
scr_roomarray_add_room(rm_office_floor_one,set,false,true,0);
scr_roomarray_add_room(rm_office_vent_room_one,set,false,false,2); //Key card, snakes (keycard shard)
scr_roomarray_add_room(rm_office_vent_room_two,set,false,false,2); //Key card B, snakes (keycard shard)
scr_roomarray_add_room(rm_office_vent_room_three,set,false,false,2); //Key card C, snakes (keycard shard)
scr_roomarray_add_room(rm_office_floor_two,set,true,true,0);
scr_roomarray_add_room(rm_office_dr_ds_office,set,true,false,1); //Memo
scr_roomarray_add_room(rm_office_gauntlet,set,false,true,0);
scr_roomarray_add_room(rm_officeGauntletEscape,set,true,true,0);
scr_roomarray_add_room(rm_office_new_ds_office,set,true,true,0);

set=ROOMGROUP.EDSPACE_TWO;
scr_roomarray_add_room(rm_EdSpace2_1,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace2_2,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace2_3,set,false,false,1);		//The secret is the secret level
scr_roomarray_add_room(rm_EdSpace2_4,set,false,false,1);		//The secret is the key
scr_roomarray_add_room(rm_EdSpace2_5,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace2_secret,set,false,false,1);	//LaserDisc
scr_roomarray_add_room(rm_EdSpace2_boss,set,false,true,0);
scr_roomarray_add_room(rm_EdSpace2_6,set,true,false,1);			//No orbs but we have the scroll

//Rhythm challenges
set=ROOMGROUP.RHYTHM;
scr_roomarray_add_room(rm_EdSpace1_Rhythm,set,true,false,1);	//Glitchy artifact
scr_roomarray_add_room(rm_Ochre_Rhythm,set,true,false,1);		//Glitchy artifact
scr_roomarray_add_room(rm_EdSpace2_Rhythm,set,true,false,1);		//Glitchy artifact
scr_roomarray_add_room(rm_whiteRhythm,set,true,false,1);		//Glitchy artifact

set=ROOMGROUP.EDSPACE_ONEBETA;
scr_roomarray_add_room(room_EdSpace1_1,set,false,true,0);
scr_roomarray_add_room(rm_secret_tutorial,set,true,true,0);
scr_roomarray_add_room(room_EdSpace1_2,set,false,true,0);
scr_roomarray_add_room(room_EdSpace1_3,set,false,true,0);
scr_roomarray_add_room(room_EdSpace1_4,set,false,true,0);
scr_roomarray_add_room(room_EdSpace1_6,set,true,true,0);
scr_roomarray_add_room(room_EdSpace1_7,set,true,true,0);

set=ROOMGROUP.OCHREALPHA;
scr_roomarray_add_room(rm_ochrehill_10,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_4OLD,set,false,true,0);
scr_roomarray_add_room(rm_ochrehill_9OLD,set,false,true,0);


global.percentagePointsAdjustment=0;			//This is how many TRUEs there are for all orbs found and all secrets found

//Now loop thru to find all the TRUEs
var grid=global.roomarray;
var height=ds_grid_height(grid);

for (var i=0; i<height; i+=1)	{
	var orbsFound=ds_grid_get(grid,ROOMARRAY.ORBSFOUND,i);
	var secretsFound=ds_grid_get(grid,ROOMARRAY.SECRETSFOUND,i)
	global.percentagePointsAdjustment+=orbsFound+secretsFound;
}