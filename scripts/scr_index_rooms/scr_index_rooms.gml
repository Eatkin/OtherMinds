//Created 01/01/20
//Last update 01/01/20

//I need this to make sure rooms are indexed correctly when I apply updates to the game
var fname="room_indices.txt";
var file=file_text_open_write(fname);

for (var i=room_first; i<=room_last; i+=1;)
	{
		file_text_write_real(file,i);
		file_text_write_string(file," "+room_get_name(i));
		file_text_writeln(file);
	}

file_text_close(file);