if (!instance_exists(obj_textholder))
	var textholder=instance_create_layer(0,0,layer,obj_textholder);
else
	var textholder=instance_nearest(0,0,obj_textholder);

with (textholder)
	{

#region Menu texts
#region Pause menu tabs
text[0]="Bio";
text[1]="To do";
text[2]="Inventory";
text[3]="Guidebook";
text[4]="Options";
#endregion

#region Options
text[5]="Gameplay";
text[6]="Graphics";
text[7]="Audio";
text[8]="Key bindings";
text[9]="Save or Load Game";
text[10]="Return to Ed's house";
text[11]="Quit game";
#endregion

#region Graphics options
text[12]="Full screen";
text[13]="Scale"; //Only available for windowed
text[14]="Brightness";
text[15]="Transition Type";
text[16]="Enable Vsync";
text[17]="Font";
text[18]="Gamepad Style";
#endregion

//What an option
text[19]="Back";

#region controls
text[20]="Jump";
text[21]="Interact";
text[22]="Action";
text[23]="Play as Sage/Talk";
text[24]="Move left";
text[25]="Move right";
text[26]="Look up";
text[27]="Look down";
text[28]="Navigate menu left";
text[29]="Navigate menu right";
text[30]="Restore defaults";
#endregion

#region sound options
text[31]="Enable sound effects";
text[32]="Enable music";
text[33]="Sound effect volume";
text[34]="Music volume";
text[35]="3D sound enabled";
#endregion

#region gameplay options
text[36]="Enable help bar";
text[37]="Health bar position";
text[38]="Enable hints";
text[39]="Difficulty";
text[301]="Enable gamepad vibration";
#endregion

#region saving and exiting
text[40]="Save game";
text[41]="Load game";
text[42]="Save and exit to menu";
#endregion

//Next scripts are pause step and pause draw
#region pause menu stuff and also used for main menu
text[43]="Power level";
text[44]="Nothing here"; //For when inventory is empty etc
text[45]="Windowed mode only";
//transitions
text[46]="None";
text[47]="Iris";
text[48]="Fade";
//Fonts
text[49]="Standard";
text[50]="Alternative";
//Gamepad types
text[51]="XBox";
text[52]="Playstation";
text[53]="Nintendo";
//Key binding
text[54]="Conflict found";
text[55]="has been reassigned"; //[key] has been reassigned
text[56]="Key bind not allowed";
text[57]="Define key now";
//Position information
text[58]="Top left";
text[59]="Bottom left";
//Difficulties
text[60]="Weenie";
text[61]="Easy";
text[233]="Normal"; //Oops fucked up the indices
text[62]="Hard";
text[63]="Super hard";
//Save game stuff
text[64]="Game saved!";
text[65]="Save file damaged";
//START FROM ADDITIONAL SURFACE HERE!!!!!!!!!!!
text[66]="To do list empty";
text[67]="Inventory empty";
//The guide key
text[68]="Key";
text[69]="Orbs"+"\n"+"available"; //\n is the new line thingy
text[70]="Secrets"+"\n"+"available";
//More save game menu things
text[71]="No Data";
text[72]="Save"; //In the context of "save 1" etc
#endregion

#region keyboard control strings
text[73]="left";
text[74]="right";
text[75]="up";
text[76]="down";
text[77]="ent";
text[78]="esc";
text[79]="spc";
text[80]="shft";
text[81]="ctrl";
text[82]="alt";
text[83]="bspc";
text[84]="tab";
text[85]="home";
text[86]="end";
text[87]="del";
text[88]="ins";
text[89]="pgup";
text[90]="pgdown";
text[91]="pause";
text[92]="printscreen";
text[93]="f1";
text[94]="f2";
text[95]="f3";
text[96]="f4";
text[97]="f5";
text[98]="f6";
text[99]="f7";
text[100]="f8";
text[101]="f9";
text[102]="f10";
text[103]="f11";
text[104]="f12";
text[105]="num 0";
text[106]="num 1";
text[107]="num 2";
text[108]="num 3";
text[109]="num 4";
text[110]="num 5";
text[111]="num 6";
text[112]="num 7";
text[113]="num 8";
text[114]="num 9";
text[115]="multiply";
text[116]="divide";
text[117]="add";
text[118]="subtract";
text[119]="decimal";
#endregion

#region more keyboard control strings, for the first play screen, and also the press any key to continue dialogue
text[180]="Jump/Menu select";
text[181]="Interact";
text[182]="Action/Menu back";
text[183]="Play Sage/Talk";
text[184]="Navigate menu left";
text[185]="Navigate menu right";
text[186]="Pause";
text[187]="View map";
text[188]="Press any key to continue";
#endregion

#region main menu text,largely shared with menu texts
text[120]="Continue Game";
text[121]="View Controls";
text[122]="New Game";
text[123]="Quit Game";
//Save game
text[124]="No Data";
text[125]="File"; //In the context of File n: SaveName
text[133]="Save game damaged";
//The main menu credits
text[126]="A game by Edward Atkin";
text[127]="Composition by Richard Kerry";
text[128]="Sound design by Mark Mauer";
//Name selection screen
text[129]="Done";
text[130]="Back";
text[132]="Choose file name";
//Press any key, why is this a comment
text[131]="Press any key";

text[807]="Level Select";
#endregion
#endregion

#region character bios etc
//Ed
text[134]="Virtuous handyman";
text[135]="Selective mute";
//Sage
text[136]="Green floating consciousness";
text[137]="A good friend";
//Gloops
text[138]="Green blob";
text[139]="Can't do very much";
//Augustine
text[140]="Key holder";
text[141]="Immortal";
//Jim Signman
text[168]="Always aligned with the grid";
text[169]="Good with directions";
//Doctor Death
text[171]="Supreme executive nihilist";
text[172]="A huge fan of waistcoats";
//Mig
text[178]="Unlucky black cat";
text[179]="Likes to stay in bed all day";
//Cannonballs
text[237]="A big ball";
text[238]="Has a pilot's licence";
text[240]="Podcast enthusiast";
text[241]="Gets homesick easily";
text[298]="A regular ball"; //Cannon ball bio 1
text[299]="Failed flying school"; //Cannon ball bio 2
//Chilli
text[308]="Gravity novice";
text[309]="Athlete";
//Desmond
text[313]="Eternally miserable";
text[314]="Sticky";
#endregion

#region dialogues
//Augustines first dialogue set
text[142]="Oh hello, Ed. Do you ever wonder what it's like to be an amorphous blob? We don't really get to do much.";
text[143]="I bet you want to go through this locked door, don't you? Well you will need the green key.";
text[144]="You'll never find it. You'll never find it because I swallowed it.";
text[145]="You really like talking.";
text[146]="Okay fine, if you insist on me telling you something useful, don't jump down the first or third holes.";
text[147]="If I wasn't a boneless blob I could be dead.";
text[148]="I hope that throwing me off a cliff was worth it.";
text[149]="Do you want to go through this door? Well you can now seeing as you stole my key.";
//Jim Signman stuff
text[161]="You think it's crazy that I'm a talking sign? You're the one talking to a sign post.";
text[162]="I'm made of sentient pine.";
text[163]="So where are we going?";
text[164]="I only have so many original thoughts, you know.";
//Bedroom cutscene
/*
text[251]=
*/
text[251]="Good morning, Ed.";
text[252]="It's time to get to work. We have plenty of jobs to do today.";
text[253]="Ed, I swear Doctor Death is not trying to kill you. Stop being ridiculous.";
text[254]="Anyway, let's go check the calendar and find out what we've got to do today.";
text[255]="Oh you brought that green key back with you? I don't know why you think that'll be useful.";
text[256]="I'm sure we can find a use for this LaserDisc.";
text[257]="And what is that, Doctor Death's master plan? We should probably return that to him I suppose...";
//Calander dialogue, first set of jobs
text[282]="The calendar. I'm glad we got this to keep track of all our jobs.";
text[283]="Today we have to rescue some lost cats and evict some snakes from a ventilation system.";
text[284]="What a strange job, how did the snakes even get there?";
text[285]="Anyway, New Deal would like to meet us as well, he says he has an important job for us.";
text[286]="And don't forget we are meeting Augustine for a cup of tea today.";
						
#endregion

#region to dos
//Augustines first set of jobs
text[150]="Keep keys";
text[151]="Keep the green key safe";
text[152]="Not much";
text[153]="Consider having a sleep";
//Jim Signman's jobs
text[165]="Follow people around";
text[166]="Make sure they're not looking";
//Doctor Death's first set of todos
text[173]="Defeat Ed";
text[174]="Defeat that meddlesome handyman";
//EdSpace Zone 1 to dos and orbs
text[201]="Wake up";
text[202]="Get up for work";
text[203]="Find the red orbs";
text[204]="Red orbs are hidden throughout the world";
text[205]="Find the white orbs";
text[206]="Rare white orbs are hidden within the world";
text[207]="Defeat Doctor Death";
text[208]="Doctor Death is probably trying to kill me";
//Ed House events
text[209]="Unlock the safe";
text[210]="The safe combination must be written down somewhere in my house";
text[211]="Visit the cellar";
text[212]="Unlock the cellar with the cellar key and see what I can find";
//Calender events part one
text[213]="Rescue the cats at Ochre Hill";
text[214]="Charlotte has reported her cats have gone missing";
text[215]="Clear snakes from the ventilation ducts";
text[216]="Doctor Death has a problem with a snake infestation at his office";
text[217]="Visit New Deal";
text[218]="New Deal has an important job for you, meet him at his office";
text[219]="Enjoy a cup of tea with Augustine";
text[220]="Go to Augustine's cave for some tea";
#endregion

#region inventories
text[154]="Green Key";
text[155]="A green key to keep safe";
text[175]="Master Plan";
text[176]="A vague plan for winning the next general election";
text[189]="Red Orb";
text[190]="A mysterious red orb";
text[191]="White Orb";
text[192]="A rare and unusual white orb";
text[193]="EdSpace Green Key";
text[194]="Augustine's green key. Found in EdSpace Zone 1";
text[195]="LaserDisc Volume 1";
text[196]="Volume 1 of a LaserDisc collection";
text[197]="Master Plan";
text[198]="Doctor Death's vague plan for winning the next general election";
text[199]="Cellar Key";
text[200]="A rusty old key to open up your cellar";
text[295]="Healing heart";
text[296]="A heart to heal your health";
text[305]="First Treasure Map";
text[306]="It says: Go to Ochre Hill. Bring a stone to a locked door.";
#endregion

#region names
text[156]="Ed";
text[157]="Sage";
text[158]="Gloop";
text[159]="Augustine";
text[167]="Jim Signman";
text[170]="Doctor Death";
text[177]="Mig";
text[236]="Dave";
text[239]="Tim";
text[297]="Danny";
text[307]="Chilli";
text[312]="Desmond";
#endregion

#region help bar data
text[258]="Leave safe";
text[259]="Jump";
text[260]="Spin";
text[261]="Talk to "; //"Talk to ______";
text[262]="Play as Sage";
text[263]="Pull";
text[264]="Drop down";
text[265]="Climb up";
text[266]="Cancel"; //Cancel possessing someone
text[267]="Explode!";
text[268]="Climb";
text[269]="Return to "; //Return to ____
text[270]="Control "; //Control ____
text[271]="Hold to return to "; //Hold (button) to return to Ed
text[272]="Level "; //Level n, whenever you try possess something that has a higher level than you. You won't have seen this because everything is lower than you.
text[273]="Select destination";
text[274]="Exit dream diary";
text[276]="Unpause";
text[277]="Shift left"; //Move one tab to the left
text[278]="Shift right"; //As above
text[279]="Select"; //Select an option
text[280]="Back"; //Back from an option
text[310]="Dash";
text[311]="Return to sender";
#endregion

#region hints
text[221]="You can lower difficulty from the gameplay options";
text[222]="You can turn off hints from the options menu";
text[223]="Jump up the ledges to continue";
text[224]="Is anyone there?";
text[225]="Hold jump for a higher jump";
text[226]="Jump on enemies to defeat them";
text[227]="Use Sage to possess enemies";
text[228]="Sage can't move through barriers";
text[229]="You can push and pull some objects";
text[230]="Jump on the floating platform to start it moving";
text[231]="Enemies can respawn off camera";
text[232]="You can increase difficulty from the gameplay options";
text[293]="You can return home from the pause menu";
text[315]="Hold away from ledges for a boosted jump";
#endregion

#region interactive object labels
text[160]="Spin sign";
text[234]="Enter door";
text[235]="Go through grate";
text[242]="Rest"; //You know, like sleeping
text[243]="Drum solo";
text[244]="Stop soloing";
text[245]="View dream diary";
text[246]="Turn on shower";
text[247]="Turn off shower";
text[248]="View safe";
text[249]="Press this super secret fireplace button";
text[250]="View calendar";
text[300]="Leave cellar";
text[316]="Pet Mig";
#endregion

#region rooms
text[275]="EdSpace Zone 1"; //If you didn't get the joke for some reason, this is a play on headspace
text[287]="Ed's House";
#endregion

//map legend
text[302]="Door";
text[303]="Item";
text[304]="Teleporter";

//Anything else
text[281]="Make a bigger sprite"; //This should only appear if a notification is too big to fit in the box and noone will ever see it (hopefully)
text[288]="found the "; //(name) found the (object)!
text[294]="";
//Notification types, as before \n is line break
text[289]="To do: \n";
text[290]="Task \ncompleted: \n";
text[291]="Task failed: \n";
text[292]="Achievement \nunlocked: \n"; //I don't have achievements so this will never show

//New texts from here!!!
//Some new Augustine dialogue
text[317]="If you need to get to Ochre Hill, you'll have to break a few eggs. Know what I mean?";
text[318]="Do you think we really need electricity, even in the modern world? Well my electricity has been cut off. So I can't make us a cup of tea.";
text[319]="Maybe we can meet at your house for tea next time. I can't really get there very easily, because I'm an amorphous blob.";
text[320]="Doctor Death is trying to drive fear. He knows you're the only person who's going to stop him. He knows you're the only person willing to do anything.";
text[321]="He knows you're the only person who can't see the utter pointlessness of this whole adventure.";
//Augustine's new to-dos
text[322]="Pay the electricity bill";
text[323]="Remember to pay the electricity bill on time";
text[324]="Meet Ed for tea";
text[325]="Ed is coming over for a cup of tea";

//Text to tell you off if you try leave the house before getting events
text[326]="Check the calander for jobs before leaving.";

//Mineshaft elevator text
text[327]="Use mineshaft";
text[328]="The electricity has been cut off.";

//Room set name
text[329]="Overworld";

//Text for signs
text[330]="Sign"; //Name
text[331]="Points you in the right direction";
text[332]="Constructed from wood";

//Signposts telling you where to go
text[333]="To Ochre Hill";

//Stuff for Richard
text[334]="Richard";
text[335]="A LaserDisc player";
text[336]="Expert composer and aspiring philosopher";

//Eggberts stuff
text[337]="Eggbert";
text[338]="Waiting to hatch";
text[339]="There's no place like home";

//A clue in the cave for you to read
text[340]="It says there's a clue outside."; //Dialogue box
text[341]="View cave painting"; //Label for help bar

//Richard's to dos
text[342]="Play LaserDiscs!";
text[343]="A LaserDisc player was born to play LaserDiscs";

//Eggbert hatched
text[344]="Has recently come out of his shell";
text[345]="Cluck cluck cluck. Beware the bee.";
text[346]="Worms are nutritious! Bah-gawk!"; //Chicken noises lol, I actually looked up chicken onomatopoeia. Wikipedia handily has a 'list of animal sounds'

//Level set name
text[347]="Ochre Hill";

//Green orbs
text[348]="Green orb";
text[349]="A bright green orb";
text[350]="Find the green orbs";
text[351]="Green orbs are scattered across the world";

//Bird boi
text[352]="Fly higher";
text[353]="Slow descent";
text[354]="River"; //Name
text[355]="Feeling blue";
text[356]="A high flyer";
text[357]="Carry";
text[358]="Release";

//Lime key
text[359]="Lime key"; //As in the colour
text[360]="A key that looks kind of like a lime";

//TEXT 306 (for the treasure map) HAS BEEN UPDATED!!
text[361]="Map Enhancer";
text[362]="PLACEHOLDER TEXT";

text[363]="Not that one."; //Not that [block]

//Appleworm
text[364]="Apple-worm";
text[365]="Delicious fruit";
text[366]="Possibly controlled by a secret worm";
//Normal worm
text[367]="Normal-worm";
text[368]="Flighty";
text[369]="Not controlled by a secret apple";
text[370]="Dig";

//Slum house in Ochre hill
text[371]="The door is locked";
text[372]="To let"; //Sign outside

//Introducing a new character - this is supposed to be like a Northern English accent, sorry Mika
text[373]="Big Slime";
text[374]="Amorphous but thoroughly pleasant";
text[375]="Not actually very big";
text[376]="Alright, buddy? You got any grappa?";
text[377]="I'm alright, you know. Same old, same old.";
text[378]="I feel like drinking some grappa, its just one of those things, you know.";
text[379]="Ah you got me some grappa. Thanks, me old.";
//Associated events
text[380]="Get Grappa";
text[381]="Bring some Grappa home for Big Slime";
//The grappa item
text[382]="Grappa";
text[383]="A bottle of strong, grape-based alcohol";
//Big Slime's to do
text[384]="Acquire some Grappa";
text[385]="Surely someone will bring me some Grappa";
//Slightly modified dialogues for when you've brought him the grappa
text[386]="Alright, buddy. Thanks for the Grappa.";
text[387]="I'm all the better for having some Grappa.";
text[388]="I think I'm going to have myself a little Grappa now, infact.";

//Granite surface
text[389]="Granite surface";
text[390]="Who just carries around a granite surface?";

//Justin Wall
text[391]="Justin Wall";
text[392]="Famous for intruding the night";
text[393]="Bass player";
//Here's his dialogue, its a poem for some reason
text[394]="I'm just a wall, I hope I don't fall.";
text[395]="It would be terrible if I were to be hit by a cannon ball.";
text[396]="I am no longer going to speak to you.";
text[397]="........";

//Some stuff for the pause menu
text[398]="Current \nlocation";
//Hint
text[399]="View the map to review orb locations.";

//Sim
text[400]="Sim";
text[401]="Pet Sim";

//Hint
text[402]="View a character's inventory from the pause menu";

//Signpost helpers
text[403]="Play as Sage here";
text[404]="Duck under the spikes";
text[405]="Bring the platform with you";
text[406]="Hold jump for a higher jump";

//Sim bio
text[407]="Very fast cat";
text[408]="Eats all the food";

//LaserDisk Vol 2
text[409]="LaserDisc Volume 2";
text[410]="Volume 2 of a LaserDisc collection";

//Hepatitis Bee
text[411]="Hepatitis Bee";
text[412]="Queen Bee";
text[413]="Frequent flyer";

//Bee ball
text[414]="Beeball";
text[415]="Explosive";
text[416]="Sharp shooter";

//Shooting
text[417]="Shoot bee cannon";

//Frankie
text[418]="Frankie";
text[419]="Big fluffy cat";
text[420]="Sleeps on the floor";
text[421]="Pet Frankie";

//Miscellaneous - specifically this shows when you try and possess Hepatitis Bee before entering the boss arena and it detects you 'cheating'
text[422]="No!";

//Eggbert warning you about H.B.
text[423]="Beware the bee. She has a bee cannon.";
text[500]="What must it be like to be a bee? Do bees have a sense of self? Luckily, I am a chicken and most certainly have a sense of self.";
text[501]="Don't forget to eat your worms and stay healthy.";

//Augustine's 2nd EdSpace appearance (rng event)
text[424]="Your dream ends here. Make sure you haven't forgotten anything. Although you can always come back.";
text[425]="What am I talking about? Not really important. Perhaps we can enjoy some tea together some time.";
text[426]="I'm a rare NPC, by the way. 25% chance of showing up.";

//CyberPup
text[427]="Cyberpup";
text[428]="Hunts for evidence of life";
text[429]="Spaceman's best friend"; //Play on man's best friend
text[430]="Why are you talking to a dog? Do you think I'll have something useful to say?";
text[431]="Are you just talking to me because you want something? Is anything we do ever for selfless reasons?";
text[432]="Pet Cyberpup";
text[433]="Do you talk to dogs often? We don't really have the same life experiences. Woof!";

//Dialogue for Richard
text[434]="You know I have a Master's degree in Composition?";
text[435]="Everybody said 'you can't do it, you're a LaserDisc Player!', I showed them!";
text[436]="Did you know I can also play LaserDiscs?";

//Feedback from sleeping in the bed
text[437]="Your health has been restored to full.";
text[438]="You feel better but your health wasn't restored because it was already full.";

//Hold to skip [credits]
text[439]="Hold to skip";

//LaserDisc levels
text[440]="Insert LaserDisc";
text[441]="Play LaserDisc";
text[442]="Leave menu";
text[443]="You don't have any LaserDiscs";
text[444]="Target time: ";
text[445]="Best time: ";
text[446]="Developer time: ";
text[447]="New best time!";
text[448]="???"; //This refers to an unknown location
text[449]="Restart trial"; //Restart [time] trial

//Signpost
text[450]="Welcome to the Cool Cat's Club";

//Text for the secret tutorial level
text[451]="Welcome to the secret tutorial level. Only the best players will find this level.";
text[452]="If you want to leave, you can go through this door. But who would want to leave?";
text[453]="You've got to jump over this gap. You can manage that, right?";
text[454]="Hold down jump for a higher jump.";
text[455]="Grab that ledge and pull yourself up! You got this!";
text[456]="Enemies up ahead. Jump on them to defeat them. Don't worry, they don't really do much.";
text[457]="Play as Sage and possess this Gloop. He can press that button for you.";
text[458]="Tap jump to do a short hop. It's pretty tricky.";
text[459]="The Gloop will respawn off screen if you accidentally defeat them.";

//Sentient Rock bio etc and texts
text[460]="Sentient Rock";
text[461]="Two billion years old";
text[462]="Omniscient";
text[463]="I am two billion years old. I cannot move, no-one comes to see me.";
text[464]="I've been here for so long that I now know everything there is to know. I am the origin of all life.";
text[465]="I'm probably the greatest mind anyone will ever know. And I'm stuck here, because I'm a rock.";
text[466]="Just like everyone else has, I bet you will leave and never come here again. You will forget I even existed.";

//Eggbert's profound dialogue (rng event)
text[467]="What existed before the Universe? Some people think that the Universe has always existed.";
text[468]="The Universe infinitely existing or at one point not existing are both deeply troubling concepts.";
text[469]="And yet, some people think belief in a divine creator is ridiculous.";
text[470]="We have never been correct about how the world works.";
text[471]="I eat worms.";

//Eggbert's todo list
text[472]="Hatch";
text[473]="Escape this dark prison";

//Charlotte, dialogues etc
text[474]="I'm not going outside and leaving the cats.";
text[475]="Charlotte";
text[476]="Enjoys tea";
text[477]="Can communicate with cats";
text[478]="Mig told me that the boys had gone to Ochre Hill last night and never returned.";
text[479]="I hope that Frankie and Sim are okay. I don't want them to get into an encounter with that giant Ochre Hill Bee.";
text[480]="I wish you would stay home more. Perhaps you could try some nettle tea.";
text[481]="Thank you for bringing the cats home. Stay safe, Ed.";
text[482]="Perhaps you would like some of my new lemon and ginger tea?";
text[483]="You know sometimes it's really hard living with a mute. I wonder what goes on in your head.";
text[484]="I will not set foot in that dank cellar."

//Augustine alt dialogue
text[485]="Break the egg.";
text[486]="Kill the bee.";
text[487]="Kill the Doctor. You must kill him. It's the only way. No time for morality. KILL HIM!";
text[488]="redundant redundant redundant redundant redundant redundant redundant";
text[489]="Oh, did I just give you a prophecy? That's cool.";

//Mig and Frankie dialogues
text[490]="Frankie is always bothering me when I just want to sleep.";
text[491]="We have a Cool Cat's Club out in Ochre Hill, maybe you could come see us there.";
text[492]="I'm hungry, can you get me some food?";
text[493]="Doctor Death put Sam and I in cages whilst we were heading to the Cool Cat's Club.";
text[494]="He was mumbling something about why Ed couldn't have just become a Philosopher like everyone else.";
text[495]="Please tell Ed to be careful, I want him to come home.";
text[496]="I never did get to visit the Cool Cat's Club.";
text[497]="Doctor Death does not have a conscience, do not trust him.";

//To do for continue exploring Ochre Hill
text[498]="Explore Ochre Hill";
text[499]="Continue exploring Ochre Hill to see what I can find";

text[502]="RUN!";

//Sentient Rock is happy you returned and gives you some hints
text[503]="Perhaps I have some helpful hints to tell you. But only three hints!";
text[504]="If you fully explore Ochre Hill, a visitor in your garden can take you back here. Stand on a rock.";
text[505]="To unlock the time trials, you must first get the LaserDiscs, then go to the toilet.";
text[506]="To get the grappa, first you must manipulate the balls. Then bring the grappa to Big Slime.";
text[507]="To get into the cellar, you must get hot and steamy with the shower.";
text[508]="The cellar holds the first clue in a series of clues.";
text[509]="Augustine holds the green key. You must possess her mind.";
text[510]="The green key will lead you to LaserDisc Volume 1.";
text[511]="The blue bird will help you to find the second treasure map.";
text[512]="To get the lime key, you must enter a useless gap.";
text[513]="LaserDisc Volume 2 lies behind a locked door in Ochre Hill.";
text[720]="Augustine is the key master. She holds the yellow key. This time you may use the power of conversation.";
text[721]="The yellow key is in your head. It leads to LaserDisc Volume 3.";
text[514]="That's it, I don't have any more hints.";

//Keep Sentient Rock company - gets player to read all the dialogue
text[515]="Keep Sentient Rock company";
text[516]="Talk to Sentient Rock, he's clearly lonely";

//Tutorial signgs
text[517]="You can read signs! Oh, you already knew that?"
text[518]="When you play as Sage, you can possess nearby characters.";
text[519]="Go left to skip the tutorial.";
text[520]="Tutorial Town";
text[521]="Be sure to utilise your ability to duck.";
text[522]="You might find some things you can't yet see.";

//A helpful sign telling you to get to Ochre Hill
text[523]="Ochre Hill is up there. Eggbert knows how to get there!";

//End game things
text[524]="Thank you for playing the Other Minds demo!";
text[525]="Feedback helps me make improvements to the final product!";
text[526]="Anyone who leaves feedback will be credited under Game Testers!";
text[527]="No thank you, just quit!";
text[528]="Leave structured feedback";		//UNUSED
text[529]="Join the Other Minds Discord";
text[530]="Talk to me on Twitter";
text[531]="Leave a comment on itch.io";		//UNUSED

//Boring update things
text[532]="New update available.";
text[533]="Changelog and download page will open a window in your web browser.";
text[534]="Continue anyway";
text[535]="View changelog";
text[536]="Go to download page";
text[537]="View credits";

text[538]="Disabled"; //Difficulty setting is disabled during timetrials

//Roomset and office texts
text[539]="Office";
text[540]="Enter elevator";
text[541]="Leave elevator";

//Keycards
text[542]="'A' Key Card";
text[543]="A blue key card that says 'A'";
text[544]="'B' Key Card";
text[545]="A red key card that says 'B'";
text[546]="Ground floor: Reception";
text[547]="First floor: Ventilation";
text[548]="'C' Key Card";
text[549]="A yellow key card that says 'C'";
text[550]="You don't have the correct key card";
text[551]="Use key card";
text[552]="'D' Key Card shard";
text[553]="'D' Key Card";
text[554]="A jagged piece of a key card";
text[555]="A green key card that says 'D'";

//Snakes
text[556]="Simon";
text[557]="Cute green snake";
text[558]="The most evil being in this world";

text[559]="The key card pieces fit together to form a full, working key card!";

//Floor two of office
text[560]="Second floor: Doctor Death's office";
text[561]="View PhD certificate";
text[562]="William Quentin Death: Doctor of Economics";
text[563]="Pick up suspicious memo";
text[564]="Suspicious Doctor Death memo";
text[565]="A memo that conveniently details vote stuffing plans";

//Checkpoint
text[566]="Checkpoint";

//End gauntlet 'cutscene'
text[567]="You know I keep saying Doctor Death isn't trying to kill you? Maybe I was wrong.";
text[568]="That was a very elaborate way to try and kill you as well.";
text[569]="Does he think this is some kind of game?";
text[570]="Oh, it looks like we missed a snake as well. Over there. Maybe it'll be helpful.";
text[571]="Let's get out of here and show this suspicious note to New Deal, I think he will be very interested.";

//Menu text
text[572]="Changing difficulty will restart the level!";
text[573]="Use keyboard";
text[574]="Weenie";	//Difficulties
text[575]="Normal";

//Difficulty Descriptions
text[576]="Same as easy, but with regenerating health.";
text[577]="More casual experience; more health, less obstacles, less enemies, extra checkpoints, things move slower, less fun.";
text[578]="As intended.";
text[579]="Less health, more enemies, more obstacles, things move faster, lower jump height. For those who don't mind dying and retrying.";
text[580]="Same as hard but with no health pickups. Ever. Even the developer has trouble with this sometimes. For those who like to eat boiled nails for breakfast.";

//First time notifications
text[581]="Difficulty can be changed at any time from the options menu";

//Floor collapse button
text[583]="Press 'collapse floor' button";

//New todo
text[582]="Go to Doctor Death's office";
text[584]="I should let him know we got rid of the snakes";

//Notifications
text[585]="All orbs found in this room";
text[586]="All secrets found in this room";

//Defeat Hep Bee
text[587]="Defeat Hepatitis Bee";
text[588]="Why is everything trying to kill me?";

//New Deal's stuff
text[589]="Third Floor: New Deal's Office";
text[590]="New Deal";
text[591]="Philanthropic politician";
text[592]="Hates cheese";
//Dialogue
text[593]="Ed my good buddy, I see you got my note. I need you to do some industrial espionage for me.";
text[594]="Doctor Death has always hated me since he realised I had a bigger office than him.";
text[595]="He stands no chance of winning tomorrow's election and he has no interest in living a good life.";
text[596]="I suspect he's up to something. Perhaps you can find some incriminating evidence for me?";
//Some additional New Deal dialogue, I forgot that the master plan existed when I wrote his dialogues
text[682]="What's this, a master plan? Where did you get this?";
text[683]="I don't think we can use this as evidence.";
text[684]="What're we going to say? Ed found this in his own head?";
text[685]="No, nobody will take that seriously, we'll have to think of something else.";
//When you have the memo
text[597]="Aha, you have a memo from old Willie's desk!";
text[598]="This seems to say that he is going to rig the election by vote stuffing.";
text[599]="How convenient that was just laying around for you to take! Just what I needed!";
text[600]="Well thank you again for your help, Ed. It was good to see you.";

text[601]="Dig up dirt on Doctor Death";
text[602]="I'll probably find some incriminating evidence in his office";

//Dialogue for finishing all events
text[603]="Okay Ed, that's all our tasks for today completed.";
text[604]="We can head back home whenever you're ready.";
text[605]="Feel free to stretch your legs a bit more first though. It's a nice evening.";

//Todo
text[606]="Head back home";
text[607]="I should go home to relax a little before bedtime";
//Todo for New Deal
text[608]="Win my campaign";
text[609]="It's the last day before the general election, I hope I don't lose to Doctor Death";

//Simone the snake's stuff
text[610]="Simone";
text[611]="Snake in the grass";
text[612]="Vegetarian";
text[613]="I hope you don't mind me staying here.";
text[614]="Don't worry about killing all my evil brothers by the way, they were evil after all.";
text[615]="Doctor Death let us live in the air vents for years, I don't know why he suddenly decided to get rid of us.";
text[616]="You know, I suspect Doctor Death is up to something. I hope he isn't trying to commit snake genocide. Or worse!";

//Vending machine
text[617]="Insert coin";
text[618]="You need a coin to purchase something from the vending machine";

//EdSpace 2
text[619]="EdSpace Zone 2";

//New Charlotte dialogue for when you get home
text[620]="I don't know why you work all day, you could be like everybody else. Endlessly thinking about things.";
text[621]="You could ask questions like; how strong is the relationship between music and the natural world?";
text[622]="You could be wondering why we're here, how we can live a good life?";
text[623]="You spend so much time out, I don't know what dangers you get yourself into. At the end of the day, it's all just a waste of time.";
text[624]="I'm not really worried about philosophy, but I'm worried about you. Don't do anything dangerous just because you think you should.";

//Bedtime to do
text[625]="Head to bed";
text[626]="Get a good night's sleep";

//Augustine's new dialogue for night time
text[627]="Good evening Ed, isn't it great to live in a cave? No endlessly striving for perfection here, it's already perfect.";
text[628]="I don't have any electricity because I didn't pay my bill so I can't have any hot drinks, but it's still perfect.";
text[629]="What you do is commendable, but probably pointless. One day you will die.";

//Eggbert's night time dialogue
text[630]="It's amazing isn't it, a whole universe out there and we'll never ever understand it.";
text[631]="By looking to the sky, we actually look to the past. Bah-kawk!";
text[632]="Sometimes you have to escape your own mind and appreciate just how amazing and how deeply troubling the world is.";
text[633]="I'm going to meditate on those thoughts, then go back to looking forward to worms for breakfast.";

//IMPORTANT TEXT
//CUT OFF - above has already been sent to Mika
text[634]="Flip gravity";

//Orange orbs
text[635]="Find the orange orbs";
text[636]="Orange orbs are concealed in various locations around the globe";
text[637]="Orange orb";
text[638]="A luminous orange orb";

//Augustine dialogue, EdSpace 2
text[639]="When you have dreams this vividly, do you start to question your senses?";
text[640]="Maybe dreams are more real than you think. Or maybe reality is less real than you think.";
text[641]="I have another key, you can just have this one. No need to hurl me off a cliff for this one.";
text[644]="You expect me to just be a bottomless pit of conversation, don't you?";
text[645]="You just had to do it didn't you? You couldn't have just asked?";
//Alt for when you have the key
text[646]="Don't lose that key, it's the only one.";
text[647]="How would you like it if I went and threw you off a cliff next time?";

//Yellow key
text[642]="Yellow key";
text[643]="A key that is helpfully colour coded";

//Augustine to do
text[648]="Give Ed the key";
text[649]="If I don't give Ed the key, he'll probably throw me off a cliff for some reason";

//LaserDisc vol 3
text[650]="LaserDisc Volume 3";
text[651]="Volume 3 of a LaserDisc collection";

//Text for after day one
text[652]="We better get some rest before work tomorrow.";

//Return to Sentient Rock event for hints
text[653]="Return to Sentient Rock for hints";
text[654]="Lonely Sentient Rock will exchange conversation for hints";

//Dr D second boss fight to do etc
text[655]="Thwart Ed";
text[656]="Thwart that pesky handyman";

//Ed's second defeat Dr D
text[657]="Deafeat Doctor Death part 2";
text[658]="How do I keep finding myself in these situations?";

//Scroll of ineffible wisdom stuff
text[659]="Power Up Scroll";
text[660]="It's a scroll. It powers you up. Probably magical.";
text[661]="Ed's power level increased to 2!";

//Waking up cutscene 2
text[662]="Good morning Ed, it's a new day full of possibilities!";
text[663]="We've got to go around, fighting the autocrats! If we don't do it, then nobody will!";
text[664]="I hope you're not still shaken up by that death gauntlet thing. I'm sure it wasn't anything personal.";
text[665]="That gauntlet must have been expensive too. I wonder where he's getting all his money from...";
text[666]="Alright, let's get moving anyway. Remember to check the calendar for jobs again!";

//Calendar 2 events
text[667]="Have fun!";
text[668]="Yes this is a cop-out. There's no more events in this version of the game.";

text[669]="Hmm, there doesn't actually seem to be anything specific to do today.";
text[670]="Oh well, I'm sure there will be more things to do if you have a wander around.";

//Yellow gloops bio
text[671]="Pepper";
text[672]="Party animal";
text[673]="Turns the house upside-down";		//Dont know if you have an equivalent saying? You might 'turn the house upside-down' whilst looking for something you have lost to indicate you've looked everywhere

//New to do
text[674]="Wake Up Part 2";
text[675]="Get up for the daily grind again";

//More level names
text[676]="Bonus World";

//Rare artifact
text[677]="Glitchy artifact";
text[678]="What is this?";

//Hint
text[679]="Orbs are used to unlock new areas.";

//Todo
text[680]="Find all the glitchy artifacts.";
text[681]="These will be useful. Surely.";

//EdSpace 1_1 new dialogues
text[686]="Okay Ed, enough messing around. We should get out of here.";
text[687]="We've got work to do in the morning.";
text[691]="By the way, make sure you grab those orbs. If you find all of them, they can be used to unlock secret areas.";
text[719]="You can open the map to see where there's still orbs and secrets to find.";

text[688]="If you want to head back home, open the pause menu and select 'Return to Ed's House'";

//Room set
text[689]="EdSpace Zone 1 (Alpha Levels)";

//More EdSpace Z1 cutscenes
text[690]="Wait here, Ed. I'll handle this puzzle.";

text[692]="Hey, Ed. If you kill a Gloop that you needed to use, they will reappear off-camera.";
text[693]="Just walk away and they'll come back.";
text[694]="If you get a Gloop somewhere they're no longer useful, just jump on them or kill them some other way.";
text[695]="Don't worry, they're only amorphous blobs. The grey ones look like they want to be put out of their misery, anyway...";


//Tutorial scenes
text[696]="This area will teach you how to play the game.";
text[697]="If you don't think you need to learn how to play, head over to the left to skip it.";
text[698]="Who knows what you will miss if you skip the tutorial though!";

text[699]="I'll possess this Gloop and use him to push that block out our path.";

text[700]="Hey Ed, have a look around and see if you can find a way to get that orb.";
text[701]="It can't just be there for no reason.";

//Secret area
text[702]="It's a secret area! We can find LaserDiscs here.";
text[703]="LaserDiscs are not only extremely cool, but they also unlock the LaserDisc levels.";
text[704]="Once you beat the LaserDisc level, you'll get something really cool and useful.";
text[705]="Well, I hope you'll get something really cool and useful, anyway.";

//After boss
text[706]="Something tells me that Dr Death is up to no good.";
text[707]="I don't think he's trying to kill you though. Why would he want to kill you?";
text[708]="He's a very good person to work for. Infact, I think we have a job to do for him tomorrow.";
text[709]="He wouldn't want to kill you because if he did, nobody would do that job for him!";
text[710]="We're his favourite duo to call on, after all!";
text[711]="I think this is probably just a mix up of some sort.";

//Talk to the Gloop
text[712]="I'm not like them. Don't stomp on me.";
text[713]="We may be amorphous blobs, but we still think. Some of us are quite renowned Philosophers.";
text[714]="Have you met Augustine? She is somewhat of a sceptic, but she's extremely knowledgable.";
text[715]="She seems to know everything, actually. It's kind of weird sometimes.";
text[716]="Red";		//Name
text[717]="Pascifist";
text[718]="Competes in athletics";

//Ochre Hill Cutscenes
text[722]="Hey Ed, this purple block looks like it is extremely important.";
text[723]="Don't forget about it.";

text[724]="Sim is very fast, so he can jump large distances.";
text[725]="He can help us here. Obviously. That's why I'm telling you this.";
text[726]="Of course, he won't be able to help us right now because you left him locked in a cage. Go back and rescue him!";

text[727]="That's both our cats rescued. We should keep going though.";
text[728]="Ochre Hill is a big loop, we'll eventually get back to the start.";
text[729]="Hopefully we'll find some useful things on the way, too.";

text[730]="Frankie can climb up walls with his sharp claws.";
text[731]="He can help us get past this block.";
text[732]="Well, he could help us if you'd actually bothered to rescue him, anyway. Go and free him from that cage!";

//Bring memo to New Deal
text[733]="Show the memo to New Deal";
text[734]="New Deal will be very interested in this suspicious memo I found.";

//Reminder to check to do list cutscene
text[735]="If you ever get lost and don't know what to do, open up the menu and check your to do list.";
text[736]="We should try and do everything on it.";
text[737]="Ochre Hill is off to the left. We have to climb up some rocks to get there.";
text[738]="We'll find Dr Death's and New Deal's offices over to the right.";
text[739]="Let's get going!";

//Mysterious room
text[740]="Looks like some old abandoned areas. Maybe we could check them out.";
text[741]="The signs will tell us a little about each area.";
text[742]="They are optional though, so feel free to ignore them.";

//Begin room descriptions
//Alpha EdSpace 1_1
text[743]="This was my first level. I made it when I didn't know how to make levels.";
text[744]="My idea was to make it straightforward, but add a few hidden secrets for people who wanted to explore more.";
text[745]="Some players got confused by the multiple possible paths and could not progress past it.";
text[746]="There was also no tutorial at this point, so this was what you would be first faced with.";
text[747]="- Ed";

//Useless collectible
text[748]="Useless Collectible";
text[749]="It is useless. I'm not joking, it literally does nothing.";
text[750]="Find all the useless collectibles!";
text[751]="Find them all, you know, if you actually want to.";

//Augustines dialogue for alpha level
text[752]="You found a secret area!";
text[753]="What do you want, a medal or something? This level is optional.";

//Alpha EdSpace 1_2
text[754]="This level features a lot of verticality. I was watching Super Mario World ROM hack videos and was inspired by them.";
text[755]="The verticality works much better in SMW ROM hacks than in this game. I have not made a vertical climb level again.";
text[756]="It also introduced several mechanics at once which again, proved confusing without a tutorial to help.";

//Alpha EdSpace 1_3
text[757]="This level is more interesting, however it is vast and probably confusing.";
text[758]="In this level you must search for three slimes and bring them all to the same area to open the path to the exit.";
text[759]="A lot of people could not work out to do and ended up backtracking.";
text[760]="At this point I started adding a lot of sign posts for hints.";
text[761]="This felt like applying a bandage, and I eventually scrapped these levels to avoid any confusion.";
text[762]="Also the scales caused some pretty major problems due to poor coding.";

//Alpha EdSpace 1_4
text[763]="This level is a huge, confusing maze. I have no idea what I was thinking. It's a mess."
text[764]="Start by heading to the left. You will then have to solve a series of puzzles.";
text[765]="After the puzzles, you will find yourself back at the beginning of the level.";
text[766]="You can now use Jim Signman to solve a final puzzle and reach the exit.";
text[767]="Jim Signman lives on in one of the early levels. I didn't have the heart to scrap him entirely.";

//Alpha 1_6
text[768]="This is the first secret level where you would acquire Laser Disc Volume 1.";
text[769]="The disc is replaced by a useless collectible in this version.";
text[770]="It's fairly straightforward and linear. No real problems.";
text[771]="I remade it anyway to base it around moving platforms with ever-increasing speed.";

//Alpha 1_7
text[772]="This is just a drop to exit EdSpace Zone 1.";
text[773]="Sometimes Augustine shows up to talk to you, but otherwise it is nothing interesting.";
text[786]="She will not show the correct dialogue though.";

//Ochre 4 Old
text[774]="This is just an old version of a level in Ochre Hill.";
text[775]="The new version was cut down in length and the level became much more focussed on the main puzzle.";

//Ochre 9 Old
text[776]="This is another old version of an Ochre Hill level.";
text[777]="This level had a puzzle removed because I felt like it was slightly too tedious.";

//Ochre 10
text[778]="This level was the original route to Sentient Rock. His area was preivously optional.";
text[779]="I made it mandatory to pass by Sentient Rock because I didn't want anyone to miss his hints.";
text[780]="This level was also removed because I felt Ochre Hill was far too long.";

//Room set name
text[781]="Ochre Hill (alpha levels)";

//Secret tutorial
text[782]="The secret tutorial level. Accessible only when you die 5 times on the first level.";
text[783]="I pretty much immediately regretted making this level.";
text[784]="It was supposed to be a joke that nobody would find.";
text[785]="Some people got stuck on the first level and actually found it though.";

//Sage's monologue at game end
text[787]="This is it, this is our reward for all that work. Nothing. The view is okay though.";
text[788]="Who can't appreciate a good view? I think no matter who you are, we all love a good view.";
text[789]="Do you ever stop and wonder why we're doing all this?";
text[790]="Why we're working, trying to make something of ourselves, fighting political corruption?";
text[791]="Not many people seem to care about what we do right now, just imagine in 100 years.";
text[792]="Who will remember then? We're just an insignificant blip in history.";
text[793]="Nothing that we do really matters, does it?";
text[794]="Even if Dr Death takes over the world, death will, ironically, eventually take him.";
text[795]="How do we even know he's a living, conscious being? You only know you have consciousness because you experience it.";
text[796]="For all we know, he could just be a pre-programmed NPC in a simulation that we're living in.";
text[797]="But even so, does it matter?";
text[798]="Not really. It doesn't change anything.";
text[799]="Nothing we do really changes anything.";
text[800]="You could say, this was all a pointless exercise.";
text[801]="A waste of time.";
text[802]="I bet nobody will even know what we've accomplished.";
text[803]="They probably don't even care what we've done.";
text[804]="They'll just move on with their life. Maybe think 'Oh, Ed and Sage did that? That's cool.'.";
text[805]="And that'll be it.";

//Treasure map 2 temp dialogue
text[806]="Orb locations and items will now show on the map screen!";

//More menu
text[808]="WARNING: This will erase existing data.";
text[809]="Confirm overwrite?";
text[810]="Yes";
text[811]="No";
text[812]="Using Level Select May Cause Unexpected Behaviour!";

//Key rebinding
text[813]="Release all buttons";
text[814]="Key rebind successful!";
text[815]="No input detected";
text[816]="Rebinding";			//Rebinding: Jump (for example)

//Some stuff for the areas menu
text[817]="Orbs to collect";
text[818]="Secrets to find";
text[819]="Current location";
text[820]="All orbs found";
text[821]="All secrets found";

//Connect menu
text[822]="Connect";
text[823]="Itch io";
text[824]="Twitter";
text[825]="Discord";
text[826]="Website";

//Bee cannon and stuff
text[827]="Bee Cannon";
text[828]="A cannon for shooting bees at your enemies";

//Vent room cutscene
text[829]="This is the place. We will have to clear out those snakes.";
text[830]="Don't feel bad, I heard most snakes are really evil anyway.";
text[831]="But what defines evil?";
text[832]="Anyway, no time for philosophical thought right now. Let's get killing them.";
text[833]="Maybe the snakes will have something useful and it'll all be worth it.";

//Dr D's office cutscene
text[834]="We need some keycards to get through to Dr Death's Office.";
text[835]="I don't think he wants people snooping around.";
text[836]="We should definitely find those keycards and snoop around.";
text[837]="Actually we have those keycards already. Let's go through!";

//Eggbert day two dialogue
text[838]="It's hard to imagine, this planet has been around for millions of years.";
text[839]="If I'm lucky, I'll be around eight years.";
text[840]="An incomprehensible amount of time ago, a different species ruled the planet.";
text[841]="They ruled the planet for an incomprehensible amount of time.";
text[842]="Really makes me want to stop worrying and eat more worms.";

//Augustine day two dialogue
text[843]="Sometimes you set out on a big adventure. And it turns out to be too big.";
text[844]="You give up, but you shouldn't feel bad.";
text[845]="You just gave yourself too much adventuring to do.";
text[846]="We need to plan for how we will feel in the future.";
text[847]="Most importantly, do what makes you happy.";

//Charlotte day two dialogue
text[848]="I wish you would learn to relax.";
text[849]="It's like you can't switch off from this damn adventure you're on.";
text[850]="What is even the point of it? What are you going to achieve?";
text[851]="We don't spend enough time together anymore.";
text[852]="You seem to be out talking to other adventurers more than you talk to me.";
text[853]="At least stop home for some tea before you go back out.";

//Justin Wlal day 2
text[854]="I've had a night to think about it and I've decided; I'm still not talking to you.";

//Changing to-dos so they're first person
//Arbitrary text changes - text[71], text[208], text[306], text[210], text[212], text[499]
//"Use Sage" -> "Play as Sage" in a few places
//Also changed all "Dr Death"s to "Doctor Death"

//Changed 142->144

//Changed 251->257

//Also changed from paste bin 628, 629, 646 (if that was even included in the first place)
//60,233 changed
//8 changes from control to key bindings
//3 changed from guide to guidebook
//Changed 293
	}

//Now reload some arrays to over-write the data (if they exist)
if (room!=room_setup)
	{
		ds_grid_destroy(global.inventory);
		scr_inventory_init();
		ds_grid_destroy(global.todo);
		scr_create_todo();
		ds_grid_destroy(global.roomarray);
		scr_roomarray_setup();
		ds_grid_destroy(global.roomsets);
		scr_roomsets_setup();
	}