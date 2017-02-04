####Changelog
<br/>

`v0.894`<br/>
	* [fixed] missing activation of ppEffects while gui is open<br/>
<br/>
`v0.893`<br/>
	* [fixed] projectiles of armed vehicles are still getting deleted after leaving safezones<br/>
	* [updated] BE filters (scripts.txt)<br/>
<br/>
`v0.891`<br/>
	* [fixed] small syntax error in the FSM<br/>
<br/>
`v0.89`<br/>
	* [added] option to allow/disallow to chop/sledge/chainsaw anything in safezones<br/>
	* [added] option to teleport players out of safezones after restart<br/>
	* [added] option to teleport players away from the parking place after restart<br/>
	* [added] check vehicle ownership of bought vehicles<br/>
	* [added] two ways of info messages (depends on if vehicle protection is used or not)<br/>
	* [added] Vehicle Access Menu:<br/>
	* 		- "Refresh" button to update the player-list while menu is open<br/>
	* 		- "Registered" listing to see which players are added to your vehicle<br/>
	* 		- "Clear" button to remove the added players<br/>
	* [added] option to restrict access to driver seat for primary vehicle owner<br/>
	* [added] slingload check for bought vehicles (you can not steal cars or ships)<br/>
	* [added] info messages for prohibited lifting (optional)<br/>
	* [added] classnames of Ryan´s Zombies to the array for deleting antagonists in safezones<br/>
	* [added] debug option for better determine errors (client & server)<br/>
	* [fixed] vehicle lifted check is also running if _useVehProt is false<br/>
	* [fixed] vehicle protection doesn´t works for ships<br/>
	* [fixed] ability to kill players with sledgehammer in safezones<br/>
	* [fixed] bug with godmode for choppers in safezone<br/>
	* [fixed] serverside typos<br/>
	* [fixed] if not using vehicle TP, ships still have godmode<br/>
	* [fixed] major FSM overhaul<br/>
	* [fixed] major code optimization<br/>
	* [changed] client settings is now a real missionConfigFile<br/>
	* [changed] CfgFunctions now via #include for easy setup<br/>
	* [changed] serverside addon was optional, now it´s imperative!<br/>
	* [updated] BE filters<br/>
<br/>
`v0.564`<br/>
	* [fixed] issue where fresh-spawns are able to steal a not-owned vehicle in half a second<br/>
	* [added] if using the "lifted vehicles protection", there will also be a check for the owners, so stealing is not possible<br/>
<br/>
`v0.502`<br/>
	* [added] (optional) owner check for lifted vehicles (they also are protected now)<br/>
	* [added] new variable in clientside config.sqf (useVehLifted [true|false] recommended is true)<br/>
<br/>
`v0.444`<br/>
	* [fixed] if entered a safezone with a vehicle, you can get killed from a player standing outside of the zone<br/>
<br/>
`v0.443`<br/>
	* [fixed] issue with chopping trees after leaving a safezone (thx to ReDBaroN for noticing this bug)<br/>
	* [added] (optional) prohibit players to chop trees while in safezones (EPOCH_fnc_playerFired.sqf / check instructions in README.md)<br/>
	* [added] (optional) using chainsaws or sledgehammers in safezones will have no result (EPOCH_fnc_playerFired.sqf / check instructions in README.md)<br/>
	* [updated] BattlEye Filters<br/>
<br/>
`v0.436`<br/>
	* [added] option to unlock teleported vehicles (_unlockAfterVehTP	= 1; in serverside settings.h)<br/>
<br/>
`v0.432`<br/>
	* release<br/>
