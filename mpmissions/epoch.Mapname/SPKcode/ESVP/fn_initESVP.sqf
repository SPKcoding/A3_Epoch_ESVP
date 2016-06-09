[] spawn {
	waitUntil{if(isNil"EPOCH_LoadingScreenDone")then[{uiSleep 0.5;false},{true}]};
	#include "config.sqf"
	isESVP=false;
	addProtPlr = compileFinal "
		player allowDamage false;
		EH_firedESVP = player addEventHandler['Fired',{deleteVehicle (_this select 6)}];
		EH_handleDmgESVP = player addEventHandler['HandleDamage',{false}];
		plrProtAdded = true
	";
	remProtPlr = compileFinal "
		player allowDamage true;
		player removeEventHandler['Fired',EH_firedESVP];
		player removeEventHandler['HandleDamage',EH_handleDmgESVP];
		plrProtAdded = nil
	";
	showMsg = {[format["<t shadow='1' size='0.75' shadowColor='#000000' color='#ff0000'><img size='0.75' shadowColor='#000000' image='SPKcode\ESVP\lock.paa' color='#ffff00'/> %1</t>",defineInfoMsg],0,1,5,1,0.15,789] spawn BIS_fnc_dynamicText};
	accessCheck = compileFinal "
		loadedAccessCheckESVP = true;
		while{true}do{
			waitUntil{if({if(cursorTarget isKindOf _x)exitWith{1}}count['Car','Air','Motorcycle','Tank'] == 0)then{uiSleep .2;false};if(({if(cursorTarget isKindOf _x)exitWith{1}}count['Car','Air','Motorcycle','Tank'] == 1) || !isESVP)then{true}};
			if(!isESVP)exitWith{loadedAccessCheckESVP = false};
			_var = cursorTarget getVariable['vehOwners',nil];
			if(!isNil'_var')then{if !(getPlayerUID player in _var)then{cursorTarget lock true;uiSleep .1;cursorTarget lock true}};
			waitUntil{if(locked cursorTarget isEqualTo 0)then[{uiSleep .2;false},{if((locked cursorTarget isEqualTo 1) || !isESVP)then{true}}]};
			if(!isESVP)exitWith{loadedAccessCheckESVP = false}
		}
	";
	addProtVeh = compileFinal "
		if(_this)then{
			private _veh = vehicle player;
			vehProtOwners = [];
			{
				private '_crew';
				_crew = getPlayerUID _x;
				vehProtOwners pushBack _crew
			}forEach crew _veh;
			_veh setVariable['vehOwners',vehProtOwners,true];
		};
		if(isNil'loadedAccessCheckESVP')then{loadedAccessCheckESVP=false};
		if(!loadedAccessCheckESVP)then{[] spawn accessCheck}
	";
	remProtVeh = compileFinal "
		private _var = vehicle player getVariable['vehOwners',nil];
		if(!isNil'_var')then{vehicle player setVariable['vehOwners',nil,true]}
	";
	codeBugFix = compileFinal "
		while{true}do{
			waitUntil{if(vehicle player == player)then{uiSleep 4};(vehicle player != player) || !alive player};
			if(!alive player || isESVP)exitWith{};
			vehicle player removeAllEventHandlers 'HandleDamage';
			if(useVehProt)then{
				private _ownrVar = vehicle player getVariable['vehOwners',nil];
				if(!isNil'_ownrVar')then{vehicle player setVariable['vehOwners',nil,true]}
			};
			waitUntil{if(vehicle player != player)then{uiSleep 4};(vehicle player == player) || !alive player};
			if(!alive player || isESVP)exitWith{}
		}
	";
	firstCheck = compileFinal "
		waitUntil{if(!isESVP)then{uiSleep 1.2};((isESVP && (vehicle player == player)) || (isESVP && (vehicle player != player))) || !alive player};
		if(!alive player)exitWith{};
		if(vehicle player == player)exitWith{false spawn thirdCheck;false spawn addProtVeh};
		if(vehicle player != player)exitWith{[true,true] spawn secondCheck}
	";
	secondCheck = compileFinal "
		while{_this select 0}do{
			if(isESVP && (vehicle player != player))then{
				vehicle player addEventHandler['Fired',{deleteVehicle (_this select 6)}];
				vehicle player addEventHandler['HandleDamage',{false}];
				if(useVehProt)then{if(_this select 1)then{true spawn addProtVeh}}
			};
			waitUntil{if(isESVP)then{uiSleep 1.2};(!isESVP && (vehicle player != player))||(!isESVP && (vehicle player == player))||(isESVP && (vehicle player == player))|| !alive player};
			if(!alive player)exitWith{player allowDamage true;player removeAllEventHandlers 'Fired';player removeAllEventHandlers 'HandleDamage'};
			if(!isESVP && (vehicle player != player))exitWith{
				vehicle player removeAllEventHandlers 'Fired';
				vehicle player removeAllEventHandlers 'HandleDamage';
				if(useVehProt)then{call remProtVeh};
				if(!isNil'plrProtAdded')then{call remProtPlr};
				[] spawn codeBugFix;
				[] spawn firstCheck
			};
			if(!isESVP && (vehicle player == player))exitWith{
				if(!isNil'plrProtAdded')then{call remProtPlr};
				[] spawn codeBugFix;
				[] spawn firstCheck
			};
			if(isESVP && (vehicle player == player))exitWith{false spawn thirdCheck}
		}
	";
	thirdCheck = compileFinal "
		while{!_this}do{
			if(isESVP)then{if(isNil'plrProtAdded')then{call addProtPlr}};
			waitUntil{if(isESVP)then{uiSleep 1.2};(!isESVP && (vehicle player == player))||(isESVP && (vehicle player != player))|| !alive player};
			if(!alive player)exitWith{player allowDamage true;player removeAllEventHandlers 'Fired';player removeAllEventHandlers 'HandleDamage'};
			if(!isESVP && (vehicle player == player))exitWith{
				call remProtPlr;
				[] spawn codeBugFix;
				[] spawn firstCheck
			};
			if(isESVP && (vehicle player != player))exitWith{[true,false] spawn secondCheck}
		}
	";
	for "_t" from 0 to (count _defineSafezones -1) step 1 do {
		_zone = createTrigger['EmptyDetector',(_defineSafezones select _t) select 1];
		_zone setTriggerArea[(_defineSafezones select _t) select 2,(_defineSafezones select _t) select 2,0,true];
		_zone setTriggerActivation['ANY','PRESENT',true];
		_zone setTriggerStatements["(vehicle player) in thisList","isESVP=true;if(showNotesESVP)then{true spawn showNoteESVP};if(showSystemchatESVP)then{systemChat format['%1 %2',chatMsgEnter," + str ((_defineSafezones select _t)select 0) + "]};if(useInfoMsg)then{call showMsg};","isESVP=false;if(showNotesESVP)then{false spawn showNoteESVP};if(showSystemchatESVP)then{systemChat format['%1 %2',chatMsgLeave," + str ((_defineSafezones select _t)select 0) + "]};"];
	};
	[] spawn firstCheck
};
