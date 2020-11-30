/// @description

// Inherit the parent event
event_inherited();

scr_states_step();

/*This is totally fucked and really broken and not good
What should happen:
Ed has nothing - New Deal just says his first few lines
Ed has only the master plan - New Deal talks about that as well
Ed has master plan AND Dr Death notes - New Deal says all dialogue
Ed had ONLY Dr Deaths note - New Deal says first dialogue, then skips the next dialogue and says about the note
*/

if (!ds_queue_empty(global.dialoguequeue))	{
	helloIAmTalking=true;
	//Check off visit New Deal event
	with (global.currentinstance)
		scr_todo_complete(8);
}

//Rewriting this becuase the below code is stupid bullshit fuckhead nonsense for retards
if (helloIAmTalking)	{
	//New Deal keeps talking until you've seen all dialogue!
	//WITH THE EXCEPTION THAT WE DON'T WANT THE MIDDLE DIALOGUE IF YOU DON'T HAVE THE MASTER PLAN!
	//HE ONLY MENTIONS THIS EXACTLY ONCE TOO - ONCE HE'S TALKED ABOUT IT, IT SKIPS OVER IT
	//I'M SHOUTING BECAUSE THIS IS RIDICULOUSLY STUPID AND CONFUSING AND COMPLICATED
	var talkAboutMasterPlan=(scr_inventory_check(obj_masterplan) and !scr_event_check_complete(global.officeevents,OFFICEEVENTS.NEWDEALMASTERPLAN))	?	true	:	false;
	if (dialogueprevious==7)	{
		global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.NEWDEALMASTERPLAN);
	}
	else if (dialogueprevious==clamp(dialogueprevious,2,7) and !talkAboutMasterPlan)
		dialogueprevious=7;
	
	if (!dialoguecomplete)
		scr_dialoguemap_queue();
		
	//NOW we can trigger events and shit
	//queueing dialouge sets dialogueprevious to the currently viewed piece of dialogue, if that makes sense (it doesn't)
	
	//Anyway, once we've seen the first bit of dialogue, we can discover "dig up dirt"
	if (dialogueprevious>=3)
		with (global.currentinstance)
			scr_todo_discover(16);
			
	//If we "hand over" the memo, we complete the event! AND also complete the todo
	if (dialogueprevious>=8)	{
		global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.NEWDEALDIALOGUECOMPLETE);
		with (global.currentinstance)	{
			scr_todo_complete(25);
			//We only complete this if we've already discovered it when picking up the note
			//So if we picked up the note before discovering the event, we need to complete it anyway
			scr_todo_complete(16);
		}
			
	}
			
	if (dialoguecomplete)
		helloIAmTalking=false;
}

#region ABSOLUTE FUCKING NONSENSE, PLEASE IGNORE
/*
//This will cleverly fill up the dialogue queue with all unread dialogue except it's stupid and broken and stupid fuck stupid shit fuck what the hell does this mean?
if (!ds_queue_empty(global.dialoguequeue))
	{
		//Check off the visit New Deal event
		with (global.currentinstance)
			scr_todo_complete(8);
		
		//This queues every piece of dialogue - dialoguecomplete is when dialogue max is queued
		while (!dialoguecomplete)
			scr_dialoguemap_queue();
		
		//DIsocver the 'dig up dirt' to do
		//This works by fucking bullshit
		//Basically slot 3 is "Go do some industrial espionage"
		//If we have dialogue beyond slot 3, it will trigger the even after viewing slot 3
		if (dialogueprevious==min(dialoguemax,3))
			with (global.currentinstance)
				scr_todo_discover(16);
			
		if (dialogueprevious==7)
			global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.NEWDEALMASTERPLAN);
			
		//This basically skips over the stuff about the master plan if we've already presented it to him
		//It's horrible confusing but if we hit the end of the first chunk of dialogue and we've already handed over the master plan
		//...Then it either skips it, or reverts the dialogue to only containing the first bit
		//I don't THINK this is necessary, but I'm going to do it anyway
		if ((scr_event_check_complete(global.officeevents,OFFICEEVENTS.NEWDEALMASTERPLAN) or !scr_inventory_check(obj_masterplan)) and dialogueprevious==3)
			{
				dialogueprevious=max(2,dialoguemax-4);
				if (dialogueprevious==2)
					scr_dialoguemap_init(0,3);
			}
	}
else	{
	//The final piece of dialogue is 11
	if (dialoguecomplete)
		with (global.currentinstance)
			scr_todo_complete(16);
}

*/
#endregion

//Behaviour here should be that he walks up to the window
if (global.currentinstance==id or global.hardpause==true)
	exit;
	
	
//We face Ed if talking to him
if (!ds_queue_empty(global.dialoguequeue))
	{
		walking=false;
		s_hinput=0;
		var targetDir=sign(parent_main_character.x-x);
		if (directionfacing!=targetDir)
			s_hinput=targetDir;
			
		exit;
	}
	
var _minx=192;
var _maxx=448;

if (x!=clamp(x,_minx,_maxx))
	{
		walking=true;
		walkingDir=sign(_minx-x);
		outsidePatrol=true;
	}
else
	{
		if (irandom(150)==0)
			walking=true;
	}
	
if (walking)
	{
		if (x==clamp(x,_minx,_maxx) and outsidePatrol)
			{
				walking=false;
				walkingDir=0;
				outsidePatrol=false;
			}
			
		if (walkingDir==0)
			walkingDir=choose(-1,1);
			
		//Check we shall not walk outside of our patrol area unless we are already outside
		var posCheck=x+walkingDir*20;
		if (posCheck!=clamp(posCheck,_minx,_maxx) and x==clamp(x,_minx,_maxx))
			{
				walkingDir=0
				walking=false;
			}
		else
			{
				s_hinput=walkingDir;
				if (irandom(90)==0)
					walkingDir=0;
			}
	}