/// @description

var file=file_text_open_write(filename);
var gridstring=ds_grid_write(recordings);
file_text_write_string(file,roomname);
file_text_writeln(file);
//file_text_write_string(file,rngseed);
//file_text_writeln(file);
file_text_write_string(file,global.rng);
file_text_writeln(file);
file_text_write_string(file,gridstring);
file_text_close(file);

scr_quit_to_menu();