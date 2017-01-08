[] spawn {
	waitUntil{if(isNil"EPOCH_LoadingScreenDone")then[{uiSleep 0.5;false},{true}]};
	if(!isDedicated && hasInterface)then{
		_load = diag_tickTime;
		ESVP_codeDone = false;
		isESVP = false;
		player setVariable['ESVP_loginDone',0,false];
		player setVariable['ESVP_plrLogged',0,false];
		[player,Epoch_personalToken] remoteExec ['SPK_fnc_ESVP_loginCheck',2];
		uiSleep 1;

		ESVP_showNotes = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_showNotes') isEqualTo str(true);
		ESVP_showChatMsg = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_showChatMsg') isEqualTo str(true);
		ESVP_useInfoMsg = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_useInfoMsg') isEqualTo str(true);
		ESVP_useVehProt = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_useVehProt') isEqualTo str(true);
		ESVP_useAccessGUI = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_useAccessGUI') isEqualTo str(true);
		ESVP_plrTP = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_usePlayerTP') isEqualTo str(true);
		ESVP_pPlacePlrTP = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_pPlacePlrTP') isEqualTo str(true);
		ESVP_useRestDrvMsg = getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_useRestDrvMsg') isEqualTo str(true);
		ESVP_restDrvMsg = getText(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'chat' >> '_restDrvMsg');
		_getSafezones = getArray(missionConfigFile >> 'CfgESVP' >> 'safezones' >> '_defineSafezones');

		if(ESVP_useVehProt)then{
			_ESVP_EH_getInMan1 = player addEventHandler['GetInMan',{_var=(_this select 2) getVariable['vehOwners',nil];if(isNil'_var')then{(_this select 2) setVariable['vehOwners',[(getPlayerUID (_this select 0))],true]}}];
			if(getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_restrictDrv') isEqualTo str(true))then{
				_ESVP_EH_getInMan2 = player addEventHandler['GetInMan',{if(isESVP)then{private _var=(_this select 2) getVariable['vehOwners',nil];if(!isNil'_var' && !(getPlayerUID (_this select 0) isEqualTo (_var select 0)))then{if((_this select 1) isEqualTo 'driver')then{if(ESVP_useRestDrvMsg)then{systemChat format['%1',ESVP_restDrvMsg]};(_this select 0) Action['GetOut',_this select 2]}}}}];
				_ESVP_EH_seatSwitchedMan1 = player addEventHandler['SeatSwitchedMan',{if(isESVP)then{private _var=(_this select 2) getVariable['vehOwners',nil];if(!isNil'_var' && !(getPlayerUID (_this select 0) isEqualTo (_var select 0)))then{if(driver (_this select 2) == (_this select 0))then{if(ESVP_useRestDrvMsg)then{systemChat format['%1',ESVP_restDrvMsg]};(_this select 0) Action['GetOut',_this select 2]}}}}]
			}
		};

		usePlayerTP = compileFinal "
			if(player getVariable 'ESVP_plrLogged' == 0)then{
				private _pos = getPosATL player;
				_bjr = getNumber(missionConfigFile >> 'CfgEpochClient' >> 'buildingJammerRange');
				_min = getNumber(missionConfigFile >> 'CfgESVP' >> 'options' >> '_minRangePlrTP');
				_max = getNumber(missionConfigFile >> 'CfgESVP' >> 'options' >> '_maxRangePlrTP');
				_newPos = [_pos,_min,_max,3,0,50,0] call BIS_fnc_findSafePos;
				_newPos = [_newPos select 0,_newPos select 1,0];
				if(count(_newPos nearObjects['PlotPole_EPOCH',_bjr]) == 0)then{[player,Epoch_personalToken,_newPos,_bjr,_min,_max] remoteExec ['SPK_fnc_ESVP_secureTP',2]};
				_id=player getVariable['safezoneID',nil];
				if(!isNil'_id' && _id != 'none')then{[] spawn usePlayerTP}
			}
		";
		showNoteESVP = compileFinal "if(_this)then[{(getArray(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'notes' >> '_enter')) call BIS_fnc_showNotification},{(getArray(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'notes' >> '_leave')) call BIS_fnc_showNotification}]";
		addProtPlr = compileFinal "
			player allowDamage false;
			EH_firedESVP1 = player addEventHandler['Fired',{deleteVehicle (_this select 6)}];
			EH_handleDmgESVP1 = player addEventHandler['HandleDamage',{false}];
			plrProtAdded = true
		";
		remProtPlr = compileFinal "
			player allowDamage true;
			if(!isNil'EH_firedESVP1')then{player removeEventHandler['Fired',EH_firedESVP1]};
			if(!isNil'EH_handleDmgESVP1')then{player removeEventHandler['HandleDamage',EH_handleDmgESVP1]};
			plrProtAdded = nil
		";
		showMsg = compileFinal "if(_this)then[{[format['%1',getText(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'info' >> '_infoMsg1')],5] call Epoch_message},{[format['%1',getText(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'info' >> '_infoMsg2')],5] call Epoch_message}]";
		accessCheck = compileFinal "
			accessCheckEject = {
				waitUntil{if(vehicle player == player)then{uiSleep .2;false}else{true}};
				_var = vehicle player getVariable['vehOwners',nil];
				if(!isNil'_var')then{if !(getPlayerUID player in _var)then{player Action['GetOut',vehicle player];closeDialog 0}}
			};
			loadedAccessCheckESVP = true;
			while{true}do{
				waitUntil{if({if(cursorTarget isKindOf _x)exitWith{1}}count['Car','Air','Motorcycle','Tank','Ship'] == 0)then{uiSleep .2;false};if(({if(cursorTarget isKindOf _x)exitWith{1}}count['Car','Air','Motorcycle','Tank','Ship'] == 1) || !isESVP)then{true}};
				if(!isESVP)exitWith{loadedAccessCheckESVP = false};
				_var = cursorTarget getVariable['vehOwners',nil];
				if(!isNil'_var')then{if !(getPlayerUID player in _var)then{cursorTarget lock true;uiSleep .1;cursorTarget lock true;[] spawn accessCheckEject}};
				waitUntil{if(locked cursorTarget isEqualTo 0)then[{uiSleep .2;false},{if((locked cursorTarget isEqualTo 1) || !isESVP)then{true}}]};
				if(!isESVP)exitWith{loadedAccessCheckESVP = false}
			}
		";
		addProtVeh = compileFinal "
			if(_this)then{
				private _veh = vehicle player;
				_ESVP_vad = _veh allowDamage false;
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
			if(!isNil'_var')then{vehicle player setVariable['vehOwners',nil,true]};
			_ESVP_vad = vehicle player allowDamage true
		";
		codeFailsafe = compileFinal "
			while{true}do{
				waitUntil{if(vehicle player == player)then{uiSleep 4};(vehicle player != player) || !alive player};
				if(!alive player || isESVP)exitWith{};
				_ESVP_vad = vehicle player allowDamage true;
				if(!isNil'EH_handleDmgESVP2')then{
					vehicle player removeEventHandler['HandleDamage',EH_handleDmgESVP2];
				};
				if(ESVP_useVehProt)then{
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
					if(isNil'plrProtAdded')then{call addProtPlr};
					EH_firedESVP2 = vehicle player addEventHandler['Fired',{deleteVehicle (_this select 6)}];
					EH_handleDmgESVP2 = vehicle player addEventHandler['HandleDamage',{false}];
					if(ESVP_useVehProt)then{
						if(_this select 1)then{true spawn addProtVeh};
						if(ESVP_useAccessGUI)then{
							if(driver vehicle player == player)then{
								if(!isNil'ESVP_AC_GUI')then{vehicle player removeAction ESVP_AC_GUI};
								uiSleep 0.6;
								[] spawn{
									while{true}do{
										waitUntil{((vehicle player != player) && (driver vehicle player == player))};
										_veh = vehicle player;
										if(driver _veh == player)then{
											_vehVar = _veh getVariable['vehOwners',nil];
											if(!isNil'_vehVar')then{
												_owner = _vehVar select 0;
												if(getPlayerUID player isEqualTo _owner)then{
													ESVP_AC_GUI = _veh addaction['<img size=""0.6"" image=""SPKcode\ESVP\ctrl\lock.paa""/><t> Access Control</t>',{createDialog 'SPK_ESVP_PassengersGUI'},nil,0,false]
												}
											}
										};
										waitUntil{(driver _veh != player)||(vehicle player == player)|| !isESVP};
										if(true)exitWith{_veh removeAction ESVP_AC_GUI}
									}
								}
							}
						}
					}
				};
				waitUntil{if(isESVP)then{uiSleep 1.2};(!isESVP && (vehicle player != player))||(!isESVP && (vehicle player == player))||(isESVP && (vehicle player == player))|| !alive player};
				if(!alive player)exitWith{player allowDamage true;player removeEventHandler['Fired',EH_firedESVP1];player removeEventHandler['HandleDamage',EH_handleDmgESVP1]};
				if(!isESVP && (vehicle player != player))exitWith{
					private _curVeh = vehicle player;
					_curVeh removeAllEventHandlers 'Fired';
					_curVeh removeAllEventHandlers 'HandleDamage';
					if(ESVP_useVehProt)then{call remProtVeh};
					if(!isNil'plrProtAdded')then{call remProtPlr};
					[] spawn codeFailsafe;
					[] spawn firstCheck
				};
				if(!isESVP && (vehicle player == player))exitWith{
					if(!isNil'plrProtAdded')then{call remProtPlr};
					[] spawn codeFailsafe;
					[] spawn firstCheck
				};
				if(isESVP && (vehicle player == player))exitWith{false spawn thirdCheck}
			}
		";
		thirdCheck = compileFinal "
			while{!_this}do{
				if(isESVP)then{if(isNil'plrProtAdded')then{call addProtPlr}};
				waitUntil{if(isESVP)then{uiSleep 1.2};(!isESVP && (vehicle player == player))||(isESVP && (vehicle player != player))|| !alive player};
				if(!alive player)exitWith{player allowDamage true;player removeEventHandler['Fired',EH_firedESVP1];player removeEventHandler['HandleDamage',EH_handleDmgESVP1]};
				if(!isESVP && (vehicle player == player))exitWith{
					call remProtPlr;
					[] spawn codeFailsafe;
					[] spawn firstCheck
				};
				if(isESVP && (vehicle player != player))exitWith{[true,false] spawn secondCheck}
			}
		";
		for "_t" from 0 to (count _getSafezones -1) step 1 do {
			_zone = createTrigger['EmptyDetector',(_getSafezones select _t) select 1];
			_zone setTriggerArea[(_getSafezones select _t) select 2,(_getSafezones select _t) select 2,0,true];
			_zone setTriggerActivation['ANY','PRESENT',true];
			_zone setTriggerStatements["(vehicle player) in thisList","isESVP=true;_getID=(format['ID_%1'," + str ((_getSafezones select _t)select 0) + "]);_id=player getvariable['safezoneID',nil];_plrLogged=player getVariable['ESVP_plrLogged',nil];_login=player getVariable['ESVP_loginDone',nil];if(ESVP_plrTP && isNil'_id' && _login isEqualTo 0 && (!isNil'_plrLogged' && _plrLogged isEqualTo 0))then[{call usePlayerTP},{player setVariable['safezoneID',_getID,true];player setVariable['ESVP_loginDone',1,false];ESVP_plrTP=false;if(ESVP_showNotes)then{true spawn showNoteESVP};if(ESVP_showChatMsg)then{systemChat format['%1 %2',getText(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'chat' >> '_chatMsgEnter')," + str ((_getSafezones select _t)select 0) + "]};if(ESVP_useInfoMsg)then{if(ESVP_useVehProt)then[{true call showMsg},{false call showMsg}]}}];if(ESVP_useVehProt && ESVP_useAccessGUI && (driver vehicle player == player))then{call SPK_fnc_ESVP_checkCrew};","isESVP=false;player setVariable['ESVP_loginDone',1,false];player setVariable['safezoneID','none',true];if(!ESVP_plrTP)then{if(ESVP_showNotes)then{false spawn showNoteESVP};if(ESVP_showChatMsg)then{systemChat format['%1 %2',getText(missionConfigFile >> 'CfgESVP' >> 'messages' >> 'chat' >> '_chatMsgLeave')," + str ((_getSafezones select _t)select 0) + "]}};ESVP_plrTP=false;if(ESVP_useVehProt && ESVP_useAccessGUI && (driver vehicle player == player))then{vehicle player setVariable['RegNames',[],true]};"]
		};
		[] spawn firstCheck;
		if(ESVP_plrTP)then{
			[] spawn {
				if(!isESVP)then{
					_a = diag_tickTime;
					waitUntil{isESVP || (!isESVP && ((diag_tickTime - _a) > 2))};
					if(ESVP_pPlacePlrTP)then{
						if(player getVariable 'ESVP_plrLogged' == 0)then{
							_bjr = getNumber(missionConfigFile >> 'CfgEpochClient' >> 'buildingJammerRange');
							_min = getNumber(missionConfigFile >> 'CfgESVP' >> 'options' >> '_minRangePlrTP');
							_max = getNumber(missionConfigFile >> 'CfgESVP' >> 'options' >> '_maxRangePlrTP');
							[player,Epoch_personalToken,getPos player,_bjr,_min,_max] remoteExec ['SPK_fnc_ESVP_plrCheckPos',2]
						}
					};
					if(!isESVP && ((diag_tickTime - _a) > 2))exitWith{player setVariable['safezoneID','none',true];player setVariable['ESVP_loginDone',1,false];ESVP_plrTP=false;player setVariable['ESVP_plrLogged',1,false]};
					waitUntil{!isESVP};
					_id=player getVariable['safezoneID',nil];
					_login=player getVariable['ESVP_loginDone',nil];
					if(isNil'_id' && _login isEqualTo 0)then{player setVariable['safezoneID','none',true];player setVariable['ESVP_loginDone',1,false];ESVP_plrTP=false;player setVariable['ESVP_plrLogged',1,false]}
				}
			}
		};
		ESVP_codeDone = true;
		if((getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_useVehLifted') isEqualTo str(true)) && ESVP_useVehProt)then{execFSM "SPKcode\ESVP\system\ESVP_slingProcess.fsm"};
		if(getText(missionConfigFile >> 'CfgESVP' >> 'debug' >> '_debugLog') isEqualTo str(true))then{diag_log text format ["(SPK-DEBUG) ESVP: client functions loaded in %1",diag_tickTime - _load]}
	}
};
