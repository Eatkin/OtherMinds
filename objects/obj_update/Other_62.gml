/// @description

if (ds_map_find_value(async_load, "id") == get)
	{
		if (ds_map_find_value(async_load, "status") == 0)
			{
				text = ds_map_find_value(async_load, "result");
			}
	}
	
if (ds_map_find_value(async_load, "status")<0)
	{
		state=UPDATESTATE.FAILED;
		exit;
	}
	
//We have loaded a ds map as a string

var _map=ds_map_create();
ds_map_read(_map,text);
var _version=ds_map_find_value(_map,"version");
var _changelogurl=ds_map_find_value(_map,"changelogurl");
var _downloadurl=ds_map_find_value(_map,"downloadurl");

ds_map_destroy(_map);
if (is_undefined(_version) or is_undefined(_changelogurl) or is_undefined(_downloadurl))
	{
		state=UPDATESTATE.FAILED;
		exit;
	}

version=_version;
changelogurl=_changelogurl;
downloadlink=_downloadurl;

if (version!=global.currentversion)
	{
		state=UPDATESTATE.UPDATEFOUND;
	}
else
	{
		state=UPDATESTATE.NOUPDATE;
	}