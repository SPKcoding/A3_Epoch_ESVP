####Extended Safezones with Vehicle Protection for A3-EPOCH
<br/>
- Title: `SPK_ESVP`
- Author: `Sp4rkY` [Link](https://github.com/SPKcoding)
- Description: `Extended Safezones with Vehicle Protection for Arma 3 Epoch`
- Version: `0.893`
- Required: `Arma 3 1.66+ / Epoch 0.4+`
- Credits:<br/>`IT07 (Thx for many brain)` [Link](https://github.com/IT07)<br/>`|V.I.P.| CH!LL3R (Thx for thoughts & testing!)`<br/>

___
<br/>
######FEATURES:
- Fully customizable
- Works with all maps
- Works for players and vehicles
- No more `"ProtectionZone_Invisible_F"` is needed (usually found in map config in a3_epoch_server_settings.pbo)
- Fired bullets will automatically be deleted in safezones
- (optional) Teleport players out of safezones after restart
- (optional) Teleport players away from the parking place (if used) after restart
- Protection from idiots trying to drive over other players (including traders)
- Check vehicle ownership of bought vehicles
- (optional) Teleport vehicles out of safezones at server restart to:
	* (optional) a given distance from the respective safezone
	* (optional) a static parking place (you can use your own map addition and define as many parking lots you want)
* (optional) Restricted vehicle´s access in safezones (only the owner(s) can enter the vehicle)
* (optional) Restricted vehicle´s gear-access in safezones (only the owner(s) can access the vehicle´s inventory)
* (optional) Protection for lifted vehicle´s
	* If using this feature, there will be also a check for the owner, so stealing is not possible
* (optional) Unlock teleported vehicles
* 2 ways of info messages (depends on if vehicle protection is used or not)
* (optional) Vehicle Access Menu:
	* "Refresh" button to update the player-list while menu is open
	* "Registered" listing to see which players are added to your vehicle
	* "Clear" button to remove the added players
* (optional) restrict access to driver seat for primary vehicle owner
* slingload check for bought vehicles (you can not steal cars or ships)
* (optional) info messages for prohibited lifting
* (optional) Prevent spawning of antagonists (UAV, Sappers, Snakes, Cultists) in safezones
* (optional) Allow/disallow to chop/sledge/chainsaw anything in safezones
* If using the serverside "vehicle teleporting WITHOUT Parking Place" - function: 
	* the vehicles get teleported to a random position within the given radius out of the safezones
* If using the serverside "vehicle teleporting WITH Parking Place" - function, it will works like this:
	* server restarts, vehicles in safezones will be teleported to a parking place
	* vehicles which are present at the parking place are getting teleported to a random location on the map, new vehicles (in safezones) are ported to the parking place
* If the respective safezone contains water, ships are treated like this:
	* if ships are located at water surface, they gets teleported close to the safezone´s shore at given radius
	* if ships are located at terrain surface because of lifting or simliar, they gets ported random at the maps shore
* If not using "vehicle teleporting" - function, remaining vehicles in safezones are indestructible after restart
* Debug option for better determine errors (client & server)
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
* Use your favourite text/C++ editor, open the `settings.h` and customize it to your wishes (every option should be self-explaining by looking at their comments)
* Save the file
* Open `epoch_SPK_ESVP.pbo` with your PBO-Manager & delete all files in it
* Copy & Paste all files of the `epoch_SPK_ESVP` folder into the `epoch_SPK_ESVP.pbo`
* Upload this PBO to your servers `@epochhive\addons\` folder
<br/>
* New way of enabling SPKcode scripts:
* Upload the `epoch_SPKcode_config.pbo` also to your servers `@epochhive\addons\` folder
* At the moment there is no need to cange anything in this PBO, just upload it and you are good to go. (will be updated as soon as more scripts are available)

<br/>

_CLIENT:_
<br/>
`If you have any problems with following these instructions, take a look at the "mpmissions\epoch.Mapname" folder of this package. Every file which needs to get edited you can find there`<br/>
<br/>
* Download and unPbo your `epoch.Mapname.pbo` ("Mapname" depends on which map you use (example: epoch.Altis.pbo))
* Open your `epoch.Mapname\description.ext` and place the following at the bottom:
```C++
#include "SPKcode\config.cpp"
```
* Open your `epoch.Mapname\epoch_config\Configs\CfgFunctions.hpp` and place the following `before` the last closing bracket:
```C++
#include "SPK_CfgFunctions.hpp"
```
* Copy the file `epoch.Mapname\epoch_config\Configs\SPK_CfgFunctions.hpp` to the same directory in your missionfile
* Copy the file `epoch.Mapname\epoch_config\Configs\CfgRemoteExec.hpp` to the same directory in your missionfile (overwrite the existing one)
	* it´s prepared for Epoch 0.4 (if you already have custom changes in it, just merge it)
* Copy the file `epoch.Mapname\epoch_config\Configs\SPK_CfgRemoteExec.hpp` to the same directory in your missionfile
* If you already have a `class CfgNotifications` anywhere in your missionfile, just open the file `epoch.Mapname\SPKcode\config.cpp` and comment out the line `#include "notes.h"` with `//` 
	* after that merge the content of `epoch.Mapname\SPKcode\notes.h` with your existing `class CfgNotifications`
* If you wish to prohibit using of melee weapons while in safezones, copy the file `epoch.Mapname\epoch_code\compile\functions\EPOCH_fnc_playerFired.sqf` to the same directory in your missionfile (overwrite the existing one)
	* it´s prepared for Epoch 0.4 (if you already have custom changes in it, just merge it)
* Copy the folder `epoch.Mapname\SPKcode` from this package into the root of your `epoch.Mapname`
* Open the file `epoch.Mapname\SPKcode\ESVP\config.cpp` in your mission and customize the client functions to your wishes. Read the self-explaining comments
* Once you are ready with customization, repack your missionfile `epoch.Mapname` and upload it back to your server
<br/>

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
* Check the battleye folder in this package and add the specific filters to your ones
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
- The serverside addon was optional, now you have to use it!
<br/>
- Added a second serverside PBO just for enable/disable SPKcode scripts easily.
<br/>

___
<br/>

######W.I.P:
- support for IgiLoad or other Towing scripts
- integration of Epoch Group System
<br/>

___
<br/>

######BUGS & ERRORS:
- Teleporting players produce a serverside rpt entry if using EpochAH (but the function is working well)
- No other known bugs present so far but if you notice some, please report them to this Git or to the respective forum thread. I will try to fix them asap. Thx
<br/>

___
<br/>
