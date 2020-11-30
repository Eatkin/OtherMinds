/// @description

transitionobj=noone;

//Update font to get spacing correct
draw_set_font(global.font);

//Audio information
var bpm=98.5;
var bps=bpm/60;
spb=1/bps;

//Might gate this behind an alarm if it's too jarring
music=audio_play_sound(mus_credits,0,0);

//Drawing information
paragraphdrawing=1;

creditsgrid=ds_grid_create(7,0);

//Now add all the credits using a custom script which resizes stuff
//This is all extremely tedious, sorry
#region timings
var line=1;
var par=1;
scr_add_credit("Thank ",line,par,0);
scr_add_credit("you ",line,par,2);
scr_add_credit("for ",line,par,2.5);
scr_add_credit("playing",line,par,3);
line=2;
scr_add_credit("Other ",line, par,6);
scr_add_credit("Minds",line,par,10);
line=1;
par=2;
scr_add_credit("Design, ",line, par,10.5);
scr_add_credit("programming ",line, par, 12);
scr_add_credit("and ",line,par,16.5);
scr_add_credit("graphics ",line, par,17.5);
scr_add_credit("by",line, par, 20);
line=2;
scr_add_credit("Edward ",line,par,22);
scr_add_credit("Atkin ",line,par,24.5);
line=1;
par=3;
scr_add_credit("Music ",line,par,26);
scr_add_credit("by",line,par,30);
line=2;
scr_add_credit("Richard ",line,par,30.5);
scr_add_credit("Kerry",line,par,32);
par=4;
line=1;
scr_add_credit("Sound ",line,par,36);
scr_add_credit("by",line,par,38);
line=2;
scr_add_credit("Mark ",line,par,38.5);
scr_add_credit("Mauer",line,par,39);
par=5;
line=1;
scr_add_credit("Advice ",line,par,42);
scr_add_credit("by ",line,par,44.5);
line=2;
scr_add_credit("Benjamin ",line,par,45.5);
scr_add_credit("Fearn",line,par,50);
line=3;
scr_add_credit("Richard ",line,par,52);
scr_add_credit("Kerry",line,par,53.5);
line=4;
scr_add_credit("MikaPyon",line,par,58);
par=6;
line=1;
scr_add_credit("German ",line,par,60);
scr_add_credit("localisation ",line,par,64);
scr_add_credit("and ",line,par,70);
scr_add_credit("lead ",line,par,72);
scr_add_credit("testing ",line,par,72.5);
scr_add_credit("by",line,par,74);
line=2;
scr_add_credit("MikaPyon",line,par,76);
par=7;
line=1;
scr_add_credit("Game ",line,par,80.5);
scr_add_credit("testing ",line,par,81.5);
scr_add_credit("by",line,par,84);
line=2;
scr_add_credit("Albatross ",line,par,86);
scr_add_credit("Wirehead",line,par,88);
line=3
scr_add_credit("Benjamin ",line,par,94);
scr_add_credit("Fearn",line,par,96);
line=4;
scr_add_credit("Dean ",line,par,98);
scr_add_credit("Davis",line,par,100);
line=5;
scr_add_credit("Derek ",line,par,101.5);
scr_add_credit(chr(34)+"Ancalabro"+chr(34)+" ",line,par,104);
scr_add_credit("Brown",line,par,109.5);
line=6;
scr_add_credit("Eli ",line,par,110);
scr_add_credit("Golden",line,par,114);
par=8;
line=1;
scr_add_credit("Jeremy ",line,par,115);
scr_add_credit("Scott",line,par,120);
line=2;
scr_add_credit("Mark ",line,par,122);
scr_add_credit("Mauer",line,par,122.5);
line=3;
scr_add_credit("Richard ",line,par,124);
scr_add_credit("Kerry",line,par,128);
line=4;
scr_add_credit("Sheeye",line,par,129.5);
line=5;
scr_add_credit("Sir",line,par,132);
scr_add_credit("Lion",line,par,134);
scr_add_credit("174",line,par,136.5);
scr_add_credit("",line,par,137); //Dummy value because I can't be bothered to debug why the last y position is 0
#endregion

//After that automatically calculate all the x-positions and y-positions, won't that be fun
/*Calculate x-pos: start at 0, move down the grid until the line number changes
add all the text lengths together, first x-pos is half of this number
then add the length of the previous string
Move i along to the next line index*/

var i,j,k, endofline, text;
var grid=creditsgrid;
var currentline=1;
var currentparagraph=1;
var linewidth=0;
var wordnumber=1;
var xposoffset=0;
#region don't look at this it is horrible
for (i=0; i<ds_grid_height(grid); i+=1)
	{
		//We loop through to find the end of the first line or paragraph
		//Then we update the line and paragraph numbers
		for (j=i;j<ds_grid_height(grid);j+=1)
			{
				if ds_grid_get(grid,CREDITS.LINE,j)!=currentline
					{
						currentline=ds_grid_get(grid,CREDITS.LINE,j);
						currentparagraph=ds_grid_get(grid,CREDITS.PARAGRAPH,j);
						endofline=j;
						break;
					}
				//I don't think this is ever triggered, but if we have a single-line paragraph, this catches it
				if ds_grid_get(grid,CREDITS.PARAGRAPH,j)!=currentparagraph
					{
						currentline=ds_grid_get(grid,CREDITS.LINE,j);
						currentparagraph=ds_grid_get(grid,CREDITS.PARAGRAPH,j);
						endofline=j;
						break;
					}
				text=ds_grid_get(grid,CREDITS.WORD,j);
				linewidth+=string_width(text);
				if j=ds_grid_height(grid)-1
					{
						endofline=j+1;
					}
			}
		for (k=i;k<j;k+=1)
			{
				text=ds_grid_get(grid,CREDITS.WORD,k);
				if wordnumber=1
					{
						xposoffset=(room_width-linewidth)*0.5;
						ds_grid_set(grid,CREDITS.X_POS,k,xposoffset);
						xposoffset+=string_width(text);
					}
				else
					{
						ds_grid_set(grid,CREDITS.X_POS,k,xposoffset);
						xposoffset+=string_width(text);
					}
				wordnumber+=1;
			}
			
		//reset linewidth and word number and xposoffet
		linewidth=0;
		wordnumber=1;
		xposoffset=0;
		i=endofline-1;
	}
#endregion

/*Calculate y-pos: Start at 0, find how many lines are in the paragraph, the height is the sum of the line number*height of an A
then add spacing
Starting y-pos is half this height
Each subsequent line is +height+spacing
Then add room_height so they start off screen
*/

currentparagraph=1;
currentline=1;
var linenumber=0;
var spacing=string_height("A")*1.5;
var yposoffset=0;
var paragraphheight=0;
var endofparagraph=0;
#region also horrible do not look
for (i=0; i<ds_grid_height(grid); i+=1)
	{
		//First find how many lines are in the paragraph
		for (j=i;j<ds_grid_height(grid);j+=1)
			{
				if ds_grid_get(grid,CREDITS.PARAGRAPH,j)!=currentparagraph
					{
						linenumber=ds_grid_get(grid,CREDITS.LINE,j-1);
						endofparagraph=j;
						currentparagraph+=1;
						break;
					}
				if j=ds_grid_height(grid)-1
					{
						linenumber=ds_grid_get(grid,CREDITS.LINE,j);
						endofparagraph=j+1; //This makes sure it breaks the loop at the end
						break;
					}
			}
		//Height of the full paragraph
		paragraphheight=linenumber*spacing;
		linenumber=1;
		for (k=i;k<j;k+=1)
			{
				if k=i
					{
						yposoffset=(room_height-paragraphheight)*0.5;
						ds_grid_set(grid,CREDITS.Y_POS,k,yposoffset);
					}
				else
					{
						ds_grid_set(grid,CREDITS.Y_POS,k,yposoffset);
					}
				//Update linenumber if you need to
				if linenumber!=ds_grid_get(grid,CREDITS.LINE,k)
					{
						linenumber+=1;
						yposoffset+=spacing;
						ds_grid_set(grid,CREDITS.Y_POS,k,yposoffset);
					}
			}
				
		
		linenumber=0;
		yposoffset=0;
		i=endofparagraph-1;
	}
#endregion

//Now finally we will add room_height to all y_poses so they start off screen
for (i=0; i<ds_grid_height(grid); i+=1)
	{
		var ypos=ds_grid_get(grid,CREDITS.Y_POS,i);
		ds_grid_set(grid,CREDITS.CURRENT_Y_POS,i,ypos+room_height);
	}

#region time codes and lyrics dump
/*Time codes dump
TCs (in beat numbers!):
98.5bpm so (98.5/60)bps therefore (60/98.5)*beat_number is the TC
0: thank
2: you
2.5: for
3: playing
6: other
10: minds
10.5: designed
12: programmed
16.5: and
17.5: graphics
20: by
22: Edward
24.5: atkin
26: Music
30: by
30.5: Richard
32: kerry
36: sound
38: by
38.5: mark
39: mauers
42: advice
44.5: by
45.5: Benjamin
50: fearn
52: Richard
53.5: kerry
56: and
58: MikaPyon
60: German
64: localisation
70: and
72: lead
72.5: testing
74: by
76: MikaPyon
80.5: game
81.5: testing
84: by
86: albatross
88: wirehead
94: Benjamin
96: fearn
98: dean
100: davis
101.5: Derek
104: ancalabro
109.5: brown
110: Eli
112: Golden
115: Jeremy
120: Scott
122: Mark
122.5: Mauers
124:Richard
128: Kerry
129.5: Sheeye
132: Sir
134: Lion
136.5: 174
*/

/*Credits dump
Thank you for playing
Other Minds

Design, programming and graphics by
Edward Atkin

Music by
Richard Kerry

Sound by
Mark Mauer

Advice by
Benjamin Fearn
Richard Kerry
Mikapyon

German localisation and lead testing by
Mikapyon

Game testing by
Albatross Wirehead
Benjamin Fearn
Dean Davis
Derek "Ancalabro" Brown
Eli Goldin
Jeremy Scott
Mark Mauer
Richard Kerry
Sheeye
SirLion174
*/
#endregion

//Stuff for skipping credits
skippingtimermax=3*room_speed;
skippingtimer=skippingtimermax;
holdingtoskip=false;