//States - this is definitely not a redundent comment
#region states
enum PlayerState
	{
		idle,			//0
		running,
		air,
		onwall,
		lookup,
		duck,			//5
		pushing,
		cliffedge,
		ledgegrab,
		pulling,
		ledgeclimb,		//10
		flying,
		possessing,
		spring,
		sleeping,
		defeated,		//15
		hurt,
		slideoffcliff,
		splat,
		slidethroughgrate,
		spinning,		//20
		moving,
		teleport,
		dead,
		debug,
		holding,
		attacking,
		shooting,
		freeflying,
		wallclimb,
		dashing,
		petcat,
		carrying,
		beingcarried,
		digging,
		wallfall,
		caged,
		bee,
		GravityFlip
	}
	
enum BOSS_STATE
	{
		INACTIVE,
		PHASEONE,
		BREAKONE,
		PHASETWO,
		BREAKTWO,
		PHASETHREE,
		BREAKTHREE,
		PHASEFOUR,
		BREAKFOUR,
		DEFEATED
	}
#endregion

//Other enums
#region UI elements
enum Menu	{
	PressAnyKey,
	Main,
	NewGame,
	LoadGame,
	Options,
	LevelSelect,
	Connect
}

enum PauseMenu	{
	None,
	Main,
	Inventory,
	ToDo,
	Guide,
	Options
}

enum HUDTips
	{
		BUTTON=0,
		TEXT=1
	}
	
//Camera enums
enum CAMERA_MODE
	{
		CAM_FOLLOW,
		CAM_SCROLLUP,
		CAM_SCROLLDOWN,
		CAM_FIXED,
		CAM_SNAP,
		CAM_ZOOM,
		CAM_ZOOMOUT,
		CAM_NOCAM
	}
//Transitions
enum TRANSITION
	{
		T_NONE_IN,
		T_NONE_OUT,
		T_IN,
		T_OUT,
		CIRCLE_IN,
		CIRCLE_OUT,
		FADE_IN,
		FADE_OUT,
		BLOCK_IN,
		BLOCK_OUT
	}
	
//Positioning
enum POSITION
	{
		TOPLEFT,
		TOPRIGHT,
		BOTTOMLEFT,
		BOTTOMRIGHT
	}
	
enum OPTIONS
	{
		MAIN,
		GRAPHICS,
		CONTROL,
		SOUND,
		GAMEPLAY,
		SAVE,
		EXIT
	}
	
enum PAUSETAB
	{
		BIO,
		TODO,
		INVENTORY,
		GUIDE,
		OPTIONS
	}

enum MAPDATA
	{
		ROOMNUMBER,
		X,
		Y,
		XSCALE,
		YSCALE,
		ORBS,
		SECRETS
	}
	
enum CONNECTION
	{
		X_1,
		Y_1,
		X_2,
		Y_2,
		ROOM_1,
		ROOM_2
	}
	
enum NOTIFICATION
	{
		TODONEW,
		TODOCOMPLETE,
		TODOFAIL,
		ACHIEVEMENT,
		HINT
	}
	
enum MAINTAB
	{
		TITLE,
		MAIN,
		NEWGAME,
		CHARACTERSELECT,
		LOAD,
		OPTIONS,
		ADDOPTIONS
	}
#endregion

#region music and sounds
//Music
enum MUSIC
	{
		SOUND_ID,
		NAME,
		MAINLOOP,
		LOOPEND
	}
#endregion


#region object-related
//Barrier
enum BARRIER
	{
		NORMAL,
		DISAPPEAR,
		REAPPEAR
	}
	
//Health
enum HP
	{
		INF=10000
	}
#endregion
	
	
#region events
//Events
//ALL SUCCESSIVE POWERS OF TWO, DON'T FUCK IT UP OR IT WON'T WORK
//I'm going to denote these as 'passes', which will be triggered at certain points in the game to unlock the next set of to dos
enum EVENTS_GLOBAL
	{
		PASSONE=1,						//This is triggered when you collect your first set of events from the calander
		RESCUEDCATS=2,
		TALKTOSENTIENTROCK=4,
		LEFTSENTIENTROCK=8,
		ROCKTELEPORTACTIVE=16,
		TIMETRIALSACTIVE=32,
		PASSTWO=64,						//This is when you have completed all day one calander events
		VIEWEDPASSTWOCUTSCENE=128,		//This is the cutscene when you enter the house after completing day one calendar events
		PASSTHREE=256					//This is triggered when you collect your second set of events from the calendar
		
	}
enum EVENTS_EDSPACE_ONE
	{
		COMPLETEDEDSPACETHREE=1,
		OPENEDGREENLOCK=2,
		PLATFORMLOWERED=4,
		EDSPACEFOUR_PLATFORMONE=8,
		EDSPACEFOUR_PLATFORMTWO=16,
		EDSPACEFOUR_ROOMFOURCOMPLETE=32,
		BOSSDEFEATED=64,
		COLLECTEDGREENKEY=128,
		EDSPACEFIVE_PLATFORM=256,
		COLLECTEDMASTERPLAN=512,
		RETURNHOMEDIALOGUE=1024,
		BOSSPHASETWO=2048,
		FIRSTCUTSCENE=4096,
		ILLHANDLETHIS=8192,
		SIGNCREATED=16384,
		GLOOPCUTSCENE=32768,
		SECRETCUTSCENE=65536,
		BOSSCUTSCENE=131072,
		PLATFORMLOWEREDNEW=262144
	}
enum EVENTS_HINTS
	{
		HAS_JUMPED=1,
		LONG_JUMP=2,
		ENEMY_JUMP=4,
		USED_SAGE=8,
		SAGE_BARRIER=16,
		PUSH_PULL=32,
		FLOATING_PLATFORM=64,
		ENEMY_RESPAWN=128,
		CANTURNOFFHINTS=256,
		RAISEDIFFICULTY=512,
		LOWERDIFFICULTY=1024,
		HOLDAWAYFROMLEDGE=2048,
		VIEWMAP=4096,
		VIEWINVENTORY=8192
	}
enum EVENTS_EDHOUSE
	{
		EDSPACE_ONE_COMPLETE=1,
		PUSHEDBEDROOMBLOCK=2,
		SHOWERSECRET=4,
		OPENEDSAFE=8,
		OPENEDCELLAR=16,
		COLLECTEDTREASUREMAP=32,
		GRAPPA=64,
		GRANITE=128,
		SPAREBEDROOMSECRET=256,
		EDSPACE_TWO_COMPLETE=512
	}
enum OVERWORLD_EVENTS
	{
		ENTEREDPUZZLECAVE=1,
		PUZZLECAVECOMPLETE=2,
		EGGBERTHATCHED=4,
		OFFICEBLOCKSBROKEN=8,
		LEAVEHOUSECUTSCENE=16,
		MYSTERIOUSROOMCUTSCENE=32,
		ENDCUTSCENE=64,
		MYSTERIOUSROOMSECRET=128
	}
enum OCHRE_EVENTS
	{
		COLLECTEDLIMEKEY=1,
		UNLOCKED_DOOR=2,
		TREASURE_MAP=4,
		OCHRE_5_REACHED=8,
		JUSTIN_WALLED=16,
		INTERACTIVEPLATFORM=32,
		RESCUEDSAM=64,
		INTERACTIVEPLATFORM_2=128,
		INTERACTIVEPLATFORM_3=256,
		INTERACTIVEPLATFORM_4=512,
		HEP_BEE_DEFEATED=1024,
		INTERACTIVEPLATFORM_5=2048,
		RESCUEDFRANKIE=4096,
		INTERACTIVEPLATFORM_6=8192,
		COOLCATCLUB=16384,
		BREAKOUT=32768,
		OCHREHILLCOMPLETE=65536,
		BLOCKCUTSCENE=131072,
		SIMCUTSCENE=262144,
		FRANKIECUTSCENE=524288
	}
enum TIMETRIALS
	{
		EDSPACE_Z1_TRIAL=1,
		OCHRE_TRIAL=2,
		EDSPACE_Z2_TRIAL=4
	}
enum OFFICEEVENTS
	{
		VENTROOM1_SNAKES=1,
		VENTROOM1_CARD=2,
		VENTROOM2_SNAKES=4,
		VENTROOM2_CARD=8,
		VENTROOM3_SNAKES=16,
		VENTROOM3_CARD=32,
		MEMO_COLLECTED=64,
		GAUNTLET_COMPLETE=128,
		BLOCKSEXPLODE=256,
		NEWDEALMASTERPLAN=512,
		NEWDEALDIALOGUECOMPLETE=1024,
		COLLAPSEDFLOOR=2048,
		ENTEREDGAUNTLET=4096,
		VENTROOMCUTSCENE=8192,
		DRDCUTSCENE=16384
	}
	
enum EdSpaceTwoEvents
	{
		COLLECTEDYELLOWKEY=1,
		OPENEDYELLOWLOCK=2,
		DEFEATEDDRD=4
	}
	
enum TutorialTownEvents	{
	FirstCutscene=1,
	SecondCutscene=2,
	ThirdCutscene=4
}

enum MysteriousRoomEvents	{
	Red=1,
	Green=2,
	Orange=4,
	White=8
}
#endregion

#region inventory
enum INVENTORY
	{
		ITEMID,
		ITEMNAME,
		QUANTITY,
		SPRITE,
		DESCRIPTION,
		OBJNAME
	}
	
enum INSTANCEMAP
	{
		ACTIVE,
		INACTIVE
	}
	
enum InstanceGrid	{
	RoomName,
	X,
	Y,
	CollectedStatus,
	Max
}
#endregion

#region rooms

enum ROOMGROUP
	{
		TUTORIAL,
		EDSPACE_ONE,
		ED_HOUSE,
		OVERWORLD,
		OCHREHILL,
		EDSPACE_ONE_CHALLENGE,
		OFFICES,
		EDSPACE_TWO,
		RHYTHM,
		EDSPACE_ONEBETA,
		OCHREALPHA
	}
	
enum ROOMARRAY
	{
		ROOM,
		ROOMSET,
		ORBSFOUND,
		SECRETSFOUND,		//Boolean
		SECRETSNUMBER,		//Remainder
		DISCOVERED,
		ROOMNAME,
		ORBSNUMBER,
		SECRETSDISCOVERED,	//FOUND
		MAX
	}
	
enum ROOMGROUPCONSTS
	{
		REF,
		NAME
	}

#endregion

#region to do
enum TODO
	{
		REF,
		NAME,
		DESCRIPTION,
		STATUS
	}
	
enum TODOSTATUS
	{
		UNDISCOVERED,
		INCOMPLETE,
		COMPLETE,
		FAILED
	}
#endregion

#region saving
//DO NOT CHANGE THE ORDER OF THESE OR IT WILL BREAK SAVING/LOADING
//Some of these are unused but whatever
enum SAVE
	{
		PLAYER,
		ROOM,
		PREVIOUSROOM,
		VERSION,
		NAME,
		POWERLEVEL,
		HEALTH,
		MAXHEALTH,
		DEATHS,
		INVENTORY,
		EVENTS,
		ITEMMAP,
		ROOMARRAY,
		TODO,
		CHECKSUM,
		CHARID,
		DIALOGUEMAP,
		ROOMDATA,
		MAX
	}
#endregion

#region I dunno gameplay variables I guess
enum DIFFICULTY
	{
		EXTRAEASY,
		EASY,
		NORMAL,
		HARD,
		EXTRAHARD
	}
enum PAD
	{
		XBOX,
		PS,
		NINTENDO,
		MAX
	}
#endregion

#region Sound?
enum EMITTER
	{
		NORMAL,
		FADEOUT,
		LOOP
	}
#endregion

#region time trials
enum BESTTIMES
	{
		ROOMNAME,
		TARGETTIME,
		BESTTIME,
		DEVTIME,
		REF
	}
#endregion

enum LANGUAGE
	{
		ENGLISH,
		GERMAN
	}
	
enum BACKGROUND
	{
		PARALLAX,
		STATIC,
		SCROLLING
	}
	
enum MAPENHANCER
	{
		ROOM,
		ITEMID,
		ITEMTYPE,
		ITEMX,
		ITEMY
	}

enum ME_TYPE
	{
		ORB,
		TELEPORTER,
		DOOR,
		ITEM
	}
	
enum CREDITS
	{
		WORD,
		LINE,
		PARAGRAPH,
		BEAT,
		X_POS,
		Y_POS,
		CURRENT_Y_POS
	}
	
enum UPDATESTATE
	{
		CHECKING,
		FAILED,
		UPDATEFOUND,
		NOUPDATE
	}