//Created 05/04/20
//Last updated 05/04/20

/*This should see if our id is on the global ds map.
If not, add ourselves and add an empty array the size of text[]
If we are, we compare the length of text[] and the array within and make sure they are the same size
Reshape if not
We ALSO want to be given the min and max indices to decide what dialogueprevious to set and whether dialogue is complete*/

//Note: ds maps cannot hold arrays so I'm having to write lists as strings so this is total jank city

var _min=argument0;
var _max=argument1;
dialoguemax=_max;
dialoguecomplete=false;

//First of all let's create an entry if it doesn't exist
//We exit after because we're done!
var _undefined=is_undefined(ds_map_find_value(global.dialoguemap,id));
if (_undefined==true)
	{
		ds_map_set(global.dialoguemap,id,0);
		dialogueprevious=_min-1;
		exit;
	}
	
//Now load the list and we will reshape if necessary
var dialogues=ds_map_find_value(global.dialoguemap,id);

//Alright now we can find dialogueprevious and dialogue complete from the list values
dialogueprevious=_min-1;
var allbeenread=true;
var hasbeenread=false;
for (var i=_min; i<=_max; i+=1)
	{
		var hasbeenread=sign(dialogues&(power(2,i)));
		allbeenread*=hasbeenread;
		if (hasbeenread==true)
			{
				dialogueprevious+=1;
			}
		else
			{
				break;
			}
	}

if (allbeenread==true)
	{
		dialogueprevious=_min-1;
		dialoguecomplete=true;
	}