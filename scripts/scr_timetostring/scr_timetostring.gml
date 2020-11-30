//Created 15/03/20
//Last updated 15/03/20

//Converts a numerical time to minutes and seconds
var time=argument0;
var minutes=floor(time/60);
var seconds=time%60;
var milliseconds=round(frac(seconds)*100);
milliseconds=string_copy(milliseconds,1,2);
seconds=floor(seconds);

minutes=string(minutes);
seconds=string(seconds);
milliseconds=string(milliseconds);
while (string_length(minutes)<2)
	{
		minutes="0"+minutes;
	}
while (string_length(seconds)<2)
	{
		seconds="0"+seconds;
	}
while (string_length(milliseconds)<2)
	{
		milliseconds+="0";
	}
	
var totaltime=minutes+":"+seconds+"."+milliseconds;

return totaltime;