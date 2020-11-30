//Created 03/10/19
//Last updated 03/10/19

var _string=string_lower(argument0);
var morsestring="";

//First lets set up the morse code array
var morse;
morse[0]=".-";
morse[1]="-...";
morse[2]="-.-.";
morse[3]="-..";
morse[4]=".";
morse[5]="..-.";
morse[6]="--.";
morse[7]="....";
morse[8]="..";
morse[9]=".---";
morse[10]="-.-"
morse[11]=".-..";
morse[12]="--";
morse[13]="-.";
morse[14]="---";
morse[15]=".--.";
morse[16]="--.-";
morse[17]=".-.";
morse[18]="...";
morse[19]="-";
morse[20]="..-";
morse[21]="...-";
morse[22]=".--";
morse[23]="-..-";
morse[24]="-.--";
morse[25]="--..";

//Then loop through the string and create a new string
for (var i=0; i<string_length(_string);i+=1)
	{
		var character=string_char_at(_string,i);
		var code=ord(character)-97;
		if code!=clamp(code,0,25)
			{
				continue;
			}
		morsestring+=morse[code];
	}
	
return morsestring;