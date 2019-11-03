waitUntil{missionNamespace getVariable  ['EPOCH_SERVER_READY',false]};
diag_log text '(SPK-DEBUG): loading ESVP serverside addon...';
_ESVP_server_debugMode = getText(configFile >> 'CfgESVP' >> '_debugLog') isEqualTo str(true);
_coords = getArray(configFile >> 'CfgESVP' >> '_safezoneCoords');
_lotPos = getArray(configFile >> 'CfgESVP' >> '_pLotArr');
_pPlaceVehDir = getNumber(configFile >> 'CfgESVP' >> '_pPlaceVehDir');
_useRestartVehTP = getNumber(configFile >> "CfgESVP" >> "_useRestartVehTP");
_tpStyle = getNumber(configFile >> "CfgESVP" >> "_tpStyle");
_newWaterPos = [];
if(getNumber(configFile >> 'CfgESVP' >> '_clearAntags') isEqualTo 1)then{_coords spawn SPK_fnc_preventAntags};
if(isNumber(configFile >> "CfgESVP" >> "_useRestartVehTP") && isNumber(configFile >> "CfgESVP" >> "_tpStyle"))then[{
	if(_ESVP_server_debugMode)then{
		if(!((_useRestartVehTP isEqualTo 0)||(_useRestartVehTP isEqualTo 1)) || !((_tpStyle isEqualTo 0)||(_tpStyle isEqualTo 1)))then{
			diag_log format['(SPK-DEBUG) ESVP_SERVER: ERROR WHILE TRYING TO TELEPORT VEHICLES, CHECK YOUR SETTINGS! _useRestartVehTP entry: %1, expected 0 or 1 | _tpStyle entry: %2, expected 0 or 1',_useRestartVehTP,_tpStyle]
		}
	};
	if(_useRestartVehTP == 1)then[{
		if(getNumber(configFile >> 'CfgESVP' >> '_unlockAfterVehTP') isEqualTo 1)then[{unlockAfterTP=true;unlockObj_ESVP = compileFinal "private '_this';_this setVehicleLock 'UNLOCKED'"},{unlockAfterTP=false}];
		if(_tpStyle isEqualTo 0)then[{
			{
				_vehs = (_x select 0) nearEntities[["Car","Tank","Motorcycle","Air"],_x select 1];
				{
					_pos = [getPosATL _x,getNumber(configFile >> "CfgESVP" >> "_tpRangeMin"),getNumber(configFile >> "CfgESVP" >> "_tpRangeMax"),3,0,50,0] call BIS_fnc_findSafePos;
					_x allowDamage false;
					_x setPosATL [_pos select 0,_pos select 1,0];
					if(unlockAfterTP)then{_x call unlockObj_ESVP};
					_x allowDamage true;
					_x call EPOCH_server_save_vehicle;
					if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: affected vehicle (land/air): %1 | ported to: %2',_x,getPosATL _x]}
				}forEach _vehs;
				if(getNumber(configFile >> "CfgESVP" >> "_checkWater") isEqualTo 1)then{
					_shipESVP = (_x select 0) nearEntities["Ship",_x select 1];
					{
						if(surfaceIsWater position _x)then[{
							_newWaterPos = [getPosASL _x,getNumber(configFile >> "CfgESVP" >> "_tpRangeMin"),getNumber(configFile >> "CfgESVP" >> "_tpRangeMax"),3,2,0,1] call BIS_fnc_findSafePos
						},{
							if !(surfaceIsWater position _x)then{
								_newWaterPos = [getMarkerPos "center",50,(worldSize/2) - 500,3,2,50,1] call BIS_fnc_findSafePos
							}
						}];
						_x allowDamage false;
						_x setPosASL [_newWaterPos select 0,_newWaterPos select 1,0];
						if(unlockAfterTP)then{_x call unlockObj_ESVP};
						_x allowDamage true;
						_x call EPOCH_server_save_vehicle;
						if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: affected vehicle (ship): %1 | ported to: %2',_x,getPosASL _x]}
					}forEach _shipESVP
				}
			}forEach _coords
		},{
			if(_tpStyle isEqualTo 1)then{
				call SPK_fnc_parkingSpotAddition;
				call SPK_fnc_parkingSpotOverhaul;
				_spot = getArray(configFile >> "CfgESVP" >> "_pPlaceCoords");
				_size = getNumber(configFile >> "CfgESVP" >> "_pPlaceSize");
				_toClear = _spot nearEntities[["LandVehicle","Tank","Air"],_size];
				if !(count _toClear isEqualTo 0)then{
					{
						private "_rndPos";
						_rndPos = [getMarkerPos "center",50,(worldSize/2) - 500,3,0,50,0] call BIS_fnc_findSafePos;
						_x allowDamage false;
						_x setPos [_rndPos select 0,_rndPos select 1,0];
						_x allowDamage true;
						_x call EPOCH_server_save_vehicle;
						if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: affected vehicle (land/air): %1 | was removed from parking place to a random spot: %2',_x,getPos _x]}
					}forEach _toClear
				};
				waitUntil{if({if(count(_x nearEntities[["LandVehicle","Tank","Air"],10]) isEqualTo 0)exitWith{true}}forEach _lotPos)then{true}};
				{
					for "_h" from 0 to (count _lotPos -1) do {
						_vehsESVP = (_x select 0) nearEntities[["LandVehicle","Tank","Air"],_x select 1];
						{
							private "_newPos";
							_newPos = _lotPos select _h;
							if(count(_newPos nearEntities[["LandVehicle","Tank","Air"],10]) == 0)then{
								_actVeh = selectRandom _vehsESVP;
								_actVeh allowDamage false;
								_actVeh setPosATL _newPos;
								if(unlockAfterTP)then{_actVeh call unlockObj_ESVP};
								_actVeh setDir _pPlaceVehDir;
								_actVeh allowDamage true;
								_actVeh call EPOCH_server_save_vehicle;
								if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: affected vehicle (land/air): %1 | searching for empty parking lot: %2 | direction: %3',_x,getPosATL _x,getDir _x]}
							}
						}forEach _vehsESVP
					};
					if(getNumber(configFile >> "CfgESVP" >> "_checkWater") isEqualTo 1)then{
						_shipESVP = (_x select 0) nearEntities["Ship",_x select 1];
						{
							if(surfaceIsWater position _x)then[{
								_newWaterPos = [getPosASL _x,getNumber(configFile >> "CfgESVP" >> "_tpRangeMin"),getNumber(configFile >> "CfgESVP" >> "_tpRangeMax"),3,2,0,1] call BIS_fnc_findSafePos
							},{
								if !(surfaceIsWater position _x)then{
									_newWaterPos = [getMarkerPos "center",50,(worldSize/2) - 500,3,2,50,1] call BIS_fnc_findSafePos
								}
							}];
							_x allowDamage false;
							_x setPosASL [_newWaterPos select 0,_newWaterPos select 1,0];
							if(unlockAfterTP)then{_x call unlockObj_ESVP};
							_x allowDamage true;
							_x call EPOCH_server_save_vehicle;
							if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: affected vehicle (ship): %1 | ported to a random spot at water: %2',_x,getPosASL _x]}
						}forEach _shipESVP
					}
				}forEach _coords
			}
		}]
	},{
		if(_useRestartVehTP == 0)then{
			{
				_vehs = (_x select 0) nearEntities[["Car","Tank","Motorcycle","Air","Ship"],_x select 1];
				{
					_x allowDamage false;
					_x addEventHandler["HandleDamage",{false}];
					if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: prevent godmode for vehicle: %1',_x]}
				}forEach _vehs
			}forEach _coords
		}
	}]
},{
	diag_log format['(SPK-DEBUG) ESVP_SERVER: ERROR IN SETTINGS, EXPECTED NUMBER, NOT A NUMBER! > _useRestartVehTP entry: %1, expected 0 or 1 | _tpStyle entry: %2, expected 0 or 1',_useRestartVehTP,_tpStyle]
}];
