# Other Minds

*Brutal collectathon platforming action with added mind control*

## About The Game

Other Minds is a pixel art style game where you play as Ed and Sage. Ed is your human who you can use for your standard platforming action, whereas Sage can fly around freely and take control of any other character.

You will take advantage of the other character’s abilities to solve puzzles, beat levels and uncover the nefarious plot of Dr Death. Ed and Sage must save the world because everybody else is too busy standing around thinking about things.

**Key Features:**
- 4 hours+ of classic platforming action with puzzles, collectibles and tough bosses
- Use Sage, a floating green consciousness, to possess and take control of basically anything that moves
- Loads of secrets and collectibles which are used to unlock time trials and rhythm levels
- Mostly made by one person

### Credits
- Programming, art and basically everything else by Edward Atkin
- Music by Richard Kerry
- Sound design and additional music by Mark Mauer
- Cover art by GrafxKid
- Trailer by Michael Electric

### Screenshots
![Ed attacks enemies whilst avoiding cannonball fire](https://img.itch.zone/aW1hZ2UvNTQwMDE1LzQ2OTcxMTUuZ2lm/347x500/Kd5dF6.gif)
![An example of a time trial level taking place in Ochre Hill](https://img.itch.zone/aW1hZ2UvNTQwMDE1LzQ2OTcxMTkuZ2lm/347x500/lmgeiV.gif)
![A challenge room featuring many obstacles such as cannons, lasers and saws](https://img.itch.zone/aW1hZ2UvNTQwMDE1LzQ2OTcxMTguZ2lm/347x500/kP8OkV.gif)
![Boss fight against a giant bee weilding a blunderbuss](https://img.itch.zone/aW1hZ2UvNTQwMDE1LzQ2OTcxMTYuZ2lm/347x500/%2Bs23aq.gif)
![Ed platforming and avoiding lasers](https://img.itch.zone/aW1hZ2UvNTQwMDE1LzQ2OTcxMTcuZ2lm/347x500/Jcjalr.gif)

### Videos
#### Trailer:

[![Other Minds Trailer](https://img.youtube.com/vi/0AfXycXbqj8/0.jpg)](https://www.youtube.com/watch?v=0AfXycXbqj8)

#### Longplay:

[![Other Minds 100% Longplay](https://img.youtube.com/vi/IJQ1HT4kFHg/0.jpg)](https://www.youtube.com/watch?v=IJQ1HT4kFHg)

### Releases

Other Minds is available for Windows and Linux on [itch.io](https://eatkin.itch.io/other-minds).

## Source code

Other Minds is created using Gamemaker Studio 2 (now Gamemaker) and built with version version 2.3.2.558.

### Important information

This was my first project after a long programming hiatus and the code is just *not very well written*. Successive Gamemaker updates have changed the way games are built, and now trying to build the game leads to many bugs.


### About the code

Other Minds was designed as a game where you could control every character. With this in mind, every character runs the exact same script to control its movement ([scr_states_step()](https://github.com/Eatkin/OtherMinds/blob/master/scripts/scr_states_step/scr_states_step.gml)).

The abilities of characters are determined by switching booleans on and off ([scr_modules_init()](https://github.com/Eatkin/OtherMinds/blob/master/scripts/scr_modules_init/scr_modules_init.gml)) and their variables such as jump height and movement speed are determined by ([scr_intrinsic_variables()](https://github.com/Eatkin/OtherMinds/blob/master/scripts/scr_intrinsic_variables/scr_intrinsic_variables.gml)).

Adding unique character and AI characters is done using simulated key presses, thus when a character is moving of its own accord, it will move in exactly the same way as when a player is controlling them. This can be used to create [very complex emergent behaviours](https://github.com/Eatkin/OtherMinds/blob/master/objects/obj_drdeath_edspaceboss/Step_0.gml#L518-896) such as the first Dr Death boss fight. [See an example here](https://youtu.be/IJQ1HT4kFHg?t=1083).
