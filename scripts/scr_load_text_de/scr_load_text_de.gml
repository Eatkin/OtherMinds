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
text[2]="Inventar";
text[3]="Ratgeber"; //mika, test
text[4]="Optionen";
#endregion
 
#region Options
text[5]="Gameplay";
text[6]="Grafik";
text[7]="Audio";
text[8]="Steuerung";
text[9]="Spiel Speichern oder Laden";
text[10]="Zurück zu Eds Haus";
text[11]="Spiel beenden";
#endregion
 
#region Graphics options
text[12]="Vollbild";
text[13]="Größe"; //Only available for windowed
text[14]="Helligkeit";
text[15]="Szenenübergang";
text[16]="Vsync ein";
text[17]="Schriftart";
text[18]="Gamepad Stil";
#endregion
 
//What an option
text[19]="Zurück";
 
#region controls
text[20]="Springen";
text[21]="Interaktion";
text[22]="Aktion";
text[23]="Sage verwenden/Reden";
text[24]="Links bewegen";
text[25]="Rechts bewegen";
text[26]="Hochsehen";
text[27]="Runtersehen";
text[28]="Menü links";
text[29]="Menü rechts";
text[30]="Standard zurücksetzen";
#endregion
 
#region sound options
text[31]="Soundeffekte ein";
text[32]="Musik ein";
text[33]="Soundlautstärke";
text[34]="Musiklautstärke";
text[35]="3D Sound ein";
#endregion
 
#region gameplay options
text[36]="Hilfeleiste ein";
text[37]="Position Energieleiste";
text[38]="Tipps ein";
text[39]="Schwierigkeitsgrad";
text[301]="Gamepad Vibration ein";
#endregion
 
#region saving and exiting
text[40]="Spiel speichern";
text[41]="Spiel laden";
text[42]="Speichern und zurück zum Hauptmenü";
#endregion
 
//Next scripts are pause step and pause draw
#region pause menu stuff and also used for main menu
text[43]="Power-Level";
text[44]="Leer";
text[45]="Nur Fenstermodus";
//transitions
text[46]="Keine";
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
text[54]="Taste belegt";
text[55]="wurde neu zugewiesen";
text[56]="Tastenbelegung nicht zulässig";
text[57]="Taste festlegen";
//Position information
text[58]="Oben links";
text[59]="Unten links";
//Difficulties
text[60]="Weichei, Energie regeneriert";
text[61]="Einfach";
text[233]="Normal (empfohlen)"; //Oops fucked up the indices
text[62]="Schwer";
text[63]="Super schwer";
//Save game stuff
text[64]="Spiel gespeichert!";
text[65]="Savedatei beschädigt";
//START FROM ADDITIONAL SURFACE HERE!!!!!!!!!!!
text[66]="To do-Liste leer";
text[67]="Inventar leer";
//The guide key
text[68]="Key";
text[69]="Orbs"+"\n"+"übrig"; //\n is the new line thingy
text[70]="Secrets"+"\n"+"übrig";
//More save game menu things
text[71]="Neu";
text[72]="Spiel"; //In the context of "save 1" etc
#endregion
 
#region keyboard control strings
text[73]="links";
text[74]="rechts";
text[75]="hoch";
text[76]="runter";
text[77]="enter";
text[78]="esc";
text[79]="leer";
text[80]="shift";
text[81]="strg";
text[82]="alt";
text[83]="rück";
text[84]="tab";
text[85]="pos1";
text[86]="ende";
text[87]="entf";
text[88]="einfg";
text[89]="bild auf";
text[90]="bild ab";
text[91]="pause";
text[92]="print";
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
text[115]="multiplizieren";
text[116]="teilen";
text[117]="plus";
text[118]="minus";
text[119]="dezimal";
#endregion
 
#region more keyboard control strings, for the first play scr
text[180]="Springen/Menüauswahl";
text[181]="Benutzen";
text[182]="Aktion/Menü zurück";
text[183]="Sage aktivieren/Sprechen";
text[184]="Menü nach links";
text[185]="Menü nach rechts";
text[186]="Pause";
text[187]="Karte anzeigen";
text[188]="Beliebige Taste zum fortfahren";
#endregion
 
#region main menu text,largely shared with menu texts
text[120]="Spiel fortsetzen";
text[121]="Steuerung anzeigen";
text[122]="Neues Spiel";
text[123]="Spiel beenden";
//Save game
text[124]="Keine Daten";
text[125]="Datei"; //In the context of File n: SaveName
text[133]="Spielstand beschädigt";
//The main menu credits
text[126]="Ein Spiel von Edward Atkin";
text[127]="Komposition von Richard Kerry";
text[128]="Sounddesign von Mark Mauer";
//Name selection screen
text[129]="Fertig";
text[130]="Zurück";
text[132]="Wähle einen Dateinamen";
//Press any key, why is this a comment
text[131]="Beliebige Taste drücken";
#endregion
#endregion
 
#region character bios etc
//Ed
text[134]="Rechtschaffender Alleskönner";
text[135]="Selektiv Stumm";
//Sage
text[136]="Grünes schwebendes Bewusstsein";
text[137]="Ein guter Freund";
//Gloops
text[138]="Grüner Blob";
text[139]="Kann nicht viel";
//Augustine
text[140]="Schlüsselfigur";
text[141]="Unsterblich";
//Jim Signman
text[168]="Fällt nie aus dem Raster";
text[169]="Guter Orientierungssinn";
//Dr Death
text[171]="Höchster exekutiver Nihilist";
text[172]="Großer Strickwestenfan";
//Mig
text[178]="Glücklose schwarze Katze";
text[179]="Verbringt den ganzen Tag im Bett";
//Cannonballs
text[237]="Eine große Kugel";
text[238]="Hat einen Pilotenschein";
text[240]="Begeisterter Podcasthörer";
text[241]="Bekommt schnell Heimweh";
text[298]="Eine normale Kugel"; //Cannon ball bio 1
text[299]="In der Flugschule durchgefallen"; //Cannon ball bio 2
//Chilli
text[308]="Gravitationsneuling";
text[309]="Athlet";
//Desmond
text[313]="Ewig unglücklich";
text[314]="Klebrig";
#endregion
 
#region dialogues
//Augustines first dialogue set
text[142]="Hi, wie gehts?";
text[143]="Fragst du dich manchmal wie es ist ein amorpher Blob zu sein? Wir haben nicht viel zu tun.";
text[144]="Du willst durch diese Tür? Naja ich habe den Schlüssel versteckt und es gibt nichts interessantes da drin.";
text[145]="Du bist wirklich sehr gesprächig was?"; // mika: Ed is not really talking at all lol
text[146]="Okay okay, wenn du darauf bestehst hier ein kleiner Tipp: springe nicht ins erste oder dritte Loch.";
text[147]="Ich könnte jetzt tot sein wenn ich kein knochenloser Blob wäre.";
text[148]="Ich hoffe es hat sich gelohnt mich die Klippe hinunterzuwerfen.";
text[149]="Du willst durch diese Tür? Naja das kannst du jetzt da du meinen Schlüssel geklaut hast.";
//Jim Signman stuff
text[161]="Du findest ein sprechendes Schild verrückt? Du bist derjenige der einen Wegweiser angesprochen hat.";
text[162]="Ich bin aus empfindsamen Kiefernholz.";
text[163]="Und wo gehen wir hin?";
text[164]="Mir gehen die originellen Kommentare aus.";
//Bedroom cutscene
text[251]="Guten Morgen, Ed.";
text[252]="Hattest du wieder Alpträume über Doktor Death?";
text[253]= "Ed, er versucht nicht dich zu töten. Warum sollte er dich umbringen wollen?";
text[254]="Wir haben heute mehrere Jobs zu erledigen, lass' uns in den Kalender sehen.";
text[255]="Moment mal wo hast du diesen grünen Schlüssel her?";
text[256]="Wo kommt diese Laserdisc her?";
text[257]="Und was ist das, ein Masterplan? Wo hast du das gefunden?";
//Calander dialogue, first set of jobs
text[282]="Der Kalender. Zum Glück haben wir den um den Überblick über unsere Jobs zu behalten.";
text[283]="Heute sollen wir verirrte Katzen retten und ein Ventilationssystem von Schlangen säubern.";
text[284]="Was für ein komischer Job, wie sind die Schlangen überhaupt da hin gekommen?";
text[285]="Egal, außerdem will uns New Deal treffen, er sagt er hat einen wichtigen Job für uns.";
text[286]="Und vergiss' nicht wir treffen heute Augustine auf eine Tasse Tee.";
 
#endregion
 
#region to dos
//Augustines first set of jobs
text[150]="Schlüssel bewachen";
text[151]="Verwahre den grünen Schlüssel in Sicherheit";
text[152]="Nicht viel";
text[153]="Sollte vielleicht schlafen";
//Jim Signman's jobs
text[165]="Verfolge Leute";
text[166]="Wenn niemand zusieht";
//Dr Death's first set of todos
text[173]="Besiege Ed";
text[174]="Besiege den lästigen Alleskönner";
//EdSpace Zone 1 to dos and orbs
text[201]="Wach auf";
text[202]="Wach auf zur Arbeit";
text[203]="Finde die roten Orbs";
text[204]="Rote Orbs sind überall in der Welt versteckt";
text[205]="Finde die weißen Orbs";
text[206]="Seltene weiße Orbs sinde überall in der Welt versteckt";
text[207]="Besiege Doktor Death";
text[208]="Doktor Death versucht wahrscheinlich dich zu töten";
//Ed House events
text[209]="Öffne den Safe";
text[210]="Die Safekombination muss irgendwo im Haus aufgeschrieben sein";
text[211]="Gehe in den Keller";
text[212]="Öffne den Keller mit dem Kellerschlüssel und sieh was du finden kannst";
//Calender events part one
text[213]="Rette die Katzen in Ochre Hill";
text[214]="Charlotte berichtet ihre Katzen sind verschwunden";
text[215]="Entferne Schlangen aus den Ventilationskanälen";
text[216]="Doktor Death hat ein Problem mit einem Schlangenbefall in seinem Büro";
text[217]="Treffe New Deal";
text[218]="New Deal hat einen wichtigen Job für dich, triff ihn in seinem Büro";
text[219]="Genieße eine Tasse Tee mit Augustine";
text[220]="Gehe zu Augustines Höhle für eine Tasse Tee";
#endregion
 
#region inventories
text[154]="Grüner Schlüssel";
text[155]="Ein grüner Schlüssel zum beschützen";
text[175]="Masterplan";
text[176]="Ein grober Plan um die nächste Wahl zu gewinnen";
text[189]="Roter Orb";
text[190]="Ein mysteriöser roter Orb";
text[191]="Weißer Orb";
text[192]="Ein seltener und ungewöhnlicher weißer Orb";
text[193]="Grüner Schlüssel EdSpace";
text[194]="Augustines grüner Schlüssel. Gefunden in EdSpace Zone 1";
text[195]="LaserDisc Volume 1";
text[196]="Volume 1 einer laser disk Sammlung";
text[197]="Masterplan";
text[198]="Doktor Deaths grober plan um die nächste Wahl zu gewinnen";
text[199]="Kellerschlüssel";
text[200]="Ein rostiger alter Schlüssel der deinen Keller öffnet";
text[295]="Heilendes Herz";
text[296]="Ein Herz das deine Gesundheit wiederherstellt";
text[305]="Erste Schatzkarte";
text[306]="This will actually say something useful in a future release";
#endregion

#region names
text[156]="Ed";
text[157]="Sage";
text[158]="Gloop";
text[159]="Augustine";
text[167]="Jim Signman";
text[170]="Doktor Death";
text[177]="Mig";
text[236]="Dave";
text[239]="Tim";
text[297]="Danny"; //Cannon ball name
text[307]="Chilli";
text[312]="Desmond";
#endregion
 
#region help bar data
text[258]="Safe verlassen";
text[259]="Springen";
text[260]="Drehen";
text[261]="Sprich mit "; //"Talk to ______";
text[262]="Sage aktivieren";
text[263]="Ziehen";
text[264]="Runterspringen";
text[265]="Hochklettern";
text[266]="Verlassen"; //Cancel possessing someone
text[267]="Explodieren!";
text[268]="Klettern";
text[269]="Zurück zu "; //Return to ____
text[270]="Steuere "; //Control ____
text[271]="Halte und gehe zurück zu "; //Hold (button) to return to
text[272]="Level "; //Level n, whenever you try possess something that has a higher level than you. You won't have seen this because everything is lower than you.
text[273]="Ziel auswählen";
text[274]="Traumtagebuch verlassen";
text[276]="Unpause";
text[277]="Nach links"; //Move one tab to the left
text[278]="Nach rechts"; //As above
text[279]="Auswahl"; //Select and option
text[280]="Zurück"; //Back from an option
text[310]="Dash";
text[311]="Zurück zum Absender";
#endregion
 
#region hints
text[221]="Der Schwierigkeitsgrad kann im Gameplaymenü gesenkt werden";
text[222]="Tipps können in den Optionen deaktiviert werden";
text[223]="Spring den Vorsprung hoch um fortzufahren";
text[224]="Ist jemand hier?";
text[225]="Halte Springen um höher zu springen";
text[226]="Springe auf Gegner um sie zu besiegen"; // mika: is "head" here important story/theme-wise ?
text[227]="Aktiviere Sage um Gegner zu kontrollieren";
text[228]="Sage kann nicht durch Barrieren gehen";
text[229]="Du kannst manche Objekte schieben oder ziehen";
text[230]="Springe auf die Platform und sie beginnt zu schweben";
text[231]="Gegner werden außerhalb der Kamera wiederbelebt";
text[232]="Der Schwierigkeitsgrad kann im Gameplaymenü erhöht werden";
text[293]="Vom Optionsmenü gelangst du zurück zum Titelbild";
text[315]="Halte in Sprungrichtung an Kanten für weitere Sprünge";
#endregion
 
#region interactive object labels
text[160]="Schild drehen";
text[234]="Gehe durch die Tür";
text[235]="Gehe durch das Tor";
text[242]="Ausruhen"; //You know, like sleeping
text[243]="Schlagzeugsolo";
text[244]="Aufhören";
text[245]="Traumtagebuch ansehen";
text[246]="Dusche einschalten";
text[247]="Dusche ausschalten";
text[248]="Safe ansehen";
text[249]="Drücke diesen super geheimen Kaminschalter";
text[250]="Kalender ansehen";
text[300]="Keller verlassen";
text[316]="Mig streicheln";
#endregion
 
#region rooms
text[275]="EdSpace Zone 1"; //If you didn't get the joke for some reason, this is a play on headspace
text[287]="Eds Haus";
#endregion

//map legend
text[302]="Tür";
text[303]="Item";
text[304]="Teleporter";

//Anything else
text[281]="Make a bigger sprite"; //This should only appear if a notification is too big to fit in the box and noone will ever see it (hopefully)
text[288]="hat "; //(name) has (object)
text[294]=" gefunden"; // found!
//Notification types, as before \n is line break
text[289]="To do: \n";
text[290]="Aufgabe \nerledigt: \n";
text[291]="Aufgabe verfehlt: \n";
text[292]="Achievement \nerhalten: \n"; //I don't have achievements so this will never show


    }


//Now reload some arrays to over-write the data
ds_grid_destroy(global.inventory);
scr_inventory_init();
ds_grid_destroy(global.todo);
scr_create_todo();
ds_grid_destroy(global.roomarray);
scr_roomarray_setup();
ds_grid_destroy(global.roomsets);
scr_roomsets_setup();