//Created 09/10/19
//Last updated 09/10/19

//Silly cheat codes depending on save game name

var savename=argument0;

//Reset all cheats
global.fatmode=false;
global.moonwalk=false;

switch(savename)
	{
		case "FATMODE":
			{
				global.fatmode=true;
				break;
			}
		case "MIKAPYON":
			{
				var arraylength=array_length_1d(obj_textholder.text);
				for (var i=0; i<arraylength;i+=1)
					{
						obj_textholder.text[i]="MikaPyon";
					}
				break;
			}
		case "DEBUG":
			{
				global.debugging=true;
				break;
			}
		case "MOONWALK":
			{
				global.moonwalk=true;
				break;
			}
	}