####Extended Safezones with Vehicle Protection for A3-EPOCH
<br/>
- Title: `SPK_ESVP`
- Author: `Sp4rkY` [Link](https://github.com/SPKcoding)
- Description: `Extended Safezones with Vehicle Protection for Arma 3 Epoch`
- Version: `0.443`
- Required: `Arma 3 1.60+ / Epoch 0.3.8+`
- Credits:<br/>`IT07 (Thx for many brain)` [Link](https://github.com/IT07)<br/>`|V.I.P.| Chiller (Thx for thoughts & testing!)`<br/>

___
<br/>
######FEATURES:
- Fully customizable
- Works with all maps
- Works for players and vehicles
- No more `"ProtectionZone_Invisible_F"` is needed (usually found in map config in a3_epoch_server_settings.pbo)
- Fired bullets will automatically be deleted in safezones
- Protection from idiots trying to drive over other players (including traders)
- (optional) Teleport vehicles out of safezones at server restart to:
	* (optional) a given distance from the respective safezone
	* (optional) a static parking place (you can use your own map addition and define as many parking lots you want)
* (optional) Restricted vehicle´s access in safezones (only the owner(s) can enter the vehicle)
* (optional) Restricted vehicle´s gear-access in safezones (only the owner(s) can access the vehicle´s inventory)
* (optional) Unlock teleported vehicles
* (optional) Prevent spawning of antagonists (UAV, Sappers, Snakes, Cultists) in safezones
* (optional) Prohibite chopping trees while in safezones
* If using the serverside "vehicle teleporting WITHOUT Parking Place" - function: 
	* the vehicles get teleported to a random position within the given radius out of the safezones
* If using the serverside "vehicle teleporting WITH Parking Place" - function, it will works like this:
	* server restarts, vehicles in safezones will be teleported to a parking place
	* vehicles which are present at the parking place are getting teleported to a random location on the map, new vehicles (in safezones) are ported to the parking place
* If the respective safezone contains water, ships are treated like this:
	* if ships are located at water surface, they gets teleported close to the safezone´s shore at given radius
	* if ships are located at terrain surface because of lifting or simliar, they gets ported random at the maps shore
* If not using "vehicle teleporting" - function, remaining vehicles in safezones are indestructible after restart
* If you only want to use the vehicle teleport functions, let the missionfile untouched and only use the serverside pbo and ofcourse customize the settings
<br/>

___
<br/>

######INSTALL INSTRUCTIONS:
`Assumed you know how to use a Pbo-Manager and Notepad++ or similar tools. Otherwise click the following link:`<br/>
[Arma: Community Tools](https://community.bistudio.com/wiki/ArmA:_Community_Tools)
<br/>

`Once you have downloaded and extracted the files, start like this:`

_SERVER:_
<br/>
* Go to the downloaded folder `@epochhive\addons\epoch_SPK_ESVP\`
* Use your favourite text/C++ editor, open the `settings.h` and customize it to your wishes (every option should be self-explaining by looking at the comments)
* Save the file
* Open `epoch_SPK_ESVP.pbo` with your PBO-Manager & delete all files in it
* Copy & Paste all files of the `epoch_SPK_ESVP` folder into the `epoch_SPK_ESVP.pbo`
* Upload this PBO to your servers `@epochhive\addons\` folder

<br/>

_CLIENT:_
<br/>
`If you have any problems with following these instructions, take a look at the "mpmissions\epoch.Mapname" folder of this package. Every file which needs to get edited you can find there`<br/>
<br/>
* Download and unPbo your `epoch.Mapname.pbo` ("Mapname" depends on which map you use (example: epoch.Altis.pbo))
* Open your `epoch.Mapname\description.ext` and place the following at the bottom:
```C++
//ESVP
class CfgNotifications {
	#include "SPKcode\ESVP\notifications.h"
};
```
* Open your `epoch.Mapname\epoch_config\Configs\CfgFunctions.hpp` and place the following `before` the last closing bracket:
```C++
//ESVP
class SPKcode_client {
	tag = "SPK";
	class SPK_ESVP {
		file = "SPKcode\ESVP";
		class initESVP {postInit=1;};
	};
};
```
* If you already have a `class SPKcode_client` just add the `class SPK_ESVP` to it. Example like this:
```C++
class SPKcode_client {
	tag = "SPK";

	class SPK_EXISTING_EXAMPLE {
		file = "SPKcode\Example";
		class example {};
	};

	class SPK_ESVP {
		file = "SPKcode\ESVP";
		class initESVP {postInit=1;};
	};

};
```
* Copy the folder `epoch.Mapname\SPKcode` from this package into the root of your `epoch.Mapname`
* Open the file `epoch.Mapname\SPKcode\ESVP\config.sqf` in your mission and customize the client functions to your wishes. Read the self-explaining comments
* If you wish to prohibit chopping trees while in safezones, copy the file `epoch.Mapname\epoch_code\compile\functions\EPOCH_fnc_playerFired.sqf` to the same directory in your missionfile (overwrite the existing one)
* Once you are ready with customization, repack your missionfile `epoch.Mapname` and upload it back to your server

<br/>

_EPOCH STOCK ANTIHACK:_
<br/>
- No needed changes detected right now

<br/>

_INFISTAR:_
<br/>
- You have to set the following options like this:
```C++
/*  Revert allowDamage   */ _RAD = false;
/*  Revert HandleDamage  */ _RHD = false;
/*  Do not change EH_Fired at all! */ _NO_EHF = true;
```

<br/>

_BATTLEYE:_
<br/>
* Open your `scripts.txt` (usually found in "SC\BattlEye\")<br/>
* Search for the keyword:
```
7 "BIS_fnc_dynamictext"
```
* add the following filter to the beginning, right after the keyword, like this:
```
7 "BIS_fnc_dynamictext" !="'f00'/> %1</t>",defineInfoMsg],0,1,5,1,0.15,789] spawn BIS_fnc_dynamicText};'"
```
* Search for the keyword:
```
7 addEventHandler
```
* add the following filter to the beginning, right after the keyword, like this:
```
7 addEventHandler !="Fired"
```
* Search for the keyword:
```
7 removeAllEventHandlers
```
* add the following filter to the beginning, right after the keyword, like this:
```
7 removeAllEventHandlers !="Fired"
```
* Open your `setvariable.txt` (same directory)<br/>
* Add the following filter to the beginning, like this:
```
5 "" !=vehowners
```
* Done
<br/>

___
<br/>

######ADDITIONAL INFORMATIONS:

_Standard safezones:_
<br/>
- You don´t need to use `"ProtectionZone_Invisible_F"` anymore. (normally defined in "a3_epoch_server_settings\configs\maps\map.h")
<br/>

_Parking place addition:_
<br/>
- The existing parking place addition was made for Altis, it´s located in the salt desert. It´s just an example, so you can use it or create your own. :)
	* In case you want to create your own parking place addition:
		* for every single parking lot an empty helipad is needed `Land_HelipadEmpty_F`
		* you can create as many empty_helipads as you want, you only have to insert each coordinate (x,y,z) into the serverside configfile (settings.h)
<br/>

_Prevent antagonists in safezones:_
<br/>
- If you notice a bug of the trader missions, related to the UAV´s, simply remove `"I_UAV_01_F"` from the serverside configfile (settings.h)
<br/>

___
<br/>

######VERY IMPORTANT:
- The safezone coordinates in the serverside settings.h `HAVE TO` be exactly the same as in the clientside configfile, except the name of each zone !!!
<br/>
_Example:_
<br/>
* client: `[NAME, COORDS, RADIUS]`
* server: `[COORDS, RADIUS]`
<br/>

___
<br/>

######W.I.P:
- integrate support for Tow/Lift
- drop-down menu for vehicle owners to give access to specific players
<br/>

___
<br/>

######BUGS & ERRORS:
- No known bugs present so far but if you notice some, please report them to this Git or to the respective forum thread. I will try to fix them asap. Thx
<br/>

___
<br/>

######LIKE MY WORK ?
- If you think about a donation so I can buy some beers, just message me at `info@sp4rky.de`
- No have to ofcourse, but I would appreciate it
<br/>

___
<br/>

_Enjoy this stuff and have fun!_
<br/>
_cheers_
