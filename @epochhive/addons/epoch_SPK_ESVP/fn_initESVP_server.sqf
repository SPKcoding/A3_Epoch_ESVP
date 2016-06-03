[] spawn {
	waitUntil{missionNamespace getVariable "EPOCH_SERVER_READY"};
	private["_safezones","_veh","_pos"];
	_coords = getArray(configFile >> "CfgESVP" >> "_safezoneCoords");
	_lotPos = getArray(configFile >> "CfgESVP" >> "_pLotArr");
	if(getNumber(configFile >> "CfgESVP" >> "_clearAntags") isEqualTo 1)then{_coords spawn SPK_fnc_preventAntags};
	if(getNumber(configFile >> "CfgESVP" >> "_useRestartVehTP") isEqualTo 1)then[{
		if(getNumber(configFile >> "CfgESVP" >> "_tpStyle") isEqualTo 0)then[{
			{
				_vehs = (_x select 0) nearEntities[["Car","Tank","Motorcycle","Air"],_x select 1];
				{
					_pos = [getPos _x,getNumber(configFile >> "CfgESVP" >> "_tpRangeMin"),getNumber(configFile >> "CfgESVP" >> "_tpRangeMax"),3,0,50,0] call BIS_fnc_findSafePos;
					_x allowDamage false;
					_x setPos _pos;
					_x allowDamage true;
					_x call EPOCH_server_save_vehicle
				}forEach _vehs;
				if(getNumber(configFile >> "CfgESVP" >> "_checkWater") isEqualTo 1)then{
					shipESVP = (_x select 0) nearEntities["Ship",_x select 1];
					{
						if(surfaceIsWater position _x)then[{
							newWaterPos = [getPos _x,getNumber(configFile >> "CfgESVP" >> "_tpRangeMin"),getNumber(configFile >> "CfgESVP" >> "_tpRangeMax"),3,2,0,1] call BIS_fnc_findSafePos
						},{
							if !(surfaceIsWater position _x)then{
								newWaterPos = [getMarkerPos "center",50,(worldSize/2) - 500,3,2,50,1] call BIS_fnc_findSafePos
							}
						}];
						_x allowDamage false;
						_x setPos newWaterPos;
						_x allowDamage true;
						_x call EPOCH_server_save_vehicle
					}forEach shipESVP
				}
			}forEach _coords
		},{
			if(getNumber(configFile >> "CfgESVP" >> "_tpStyle") isEqualTo 1)then{
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
						_x setPos _rndPos;
						_x allowDamage true;
						_x call EPOCH_server_save_vehicle
					}forEach _toClear
				};
				waitUntil{if({if(count(_x nearEntities[["LandVehicle","Tank","Air"],10]) isEqualTo 0)exitWith{true}}forEach _lotPos)then{true}};
				{
					for "_h" from 0 to (count _lotPos -1) do {
						vehsESVP = (_x select 0) nearEntities[["LandVehicle","Tank","Air"],_x select 1];
						{
							private "_newPos";
							_newPos = _lotPos select _h;
							if(count(_newPos nearEntities[["LandVehicle","Tank","Air"],10]) == 0)then{
								_actVeh = selectRandom vehsESVP;
								_actVeh allowDamage false;
								_actVeh setPos _newPos;
								_actVeh setDir 0;
								_actVeh allowDamage true;
								_actVeh call EPOCH_server_save_vehicle
							}
						}forEach vehsESVP
					};
					if(getNumber(configFile >> "CfgESVP" >> "_checkWater") isEqualTo 1)then{
						shipESVP = (_x select 0) nearEntities["Ship",_x select 1];
						{
							if(surfaceIsWater position _x)then[{
								newWaterPos = [getPos _x,getNumber(configFile >> "CfgESVP" >> "_tpRangeMin"),getNumber(configFile >> "CfgESVP" >> "_tpRangeMax"),3,2,0,1] call BIS_fnc_findSafePos
							},{
								if !(surfaceIsWater position _x)then{
									newWaterPos = [getMarkerPos "center",50,(worldSize/2) - 500,3,2,50,1] call BIS_fnc_findSafePos
								}
							}];
							_x allowDamage false;
							_x setPos newWaterPos;
							_x allowDamage true;
							_x call EPOCH_server_save_vehicle
						}forEach shipESVP
					}
				}forEach _coords
			}
		}]
	},{
		if(getNumber(configFile >> "CfgESVP" >> "_useRestartVehTP") isEqualTo 0)then{
			{
				_vehs = (_x select 0) nearEntities[["Car","Tank","Motorcycle","Air"],_x select 1];
				{
					_x allowDamage false;
					_x addEventHandler["HandleDamage",{false}]
				}forEach _vehs
			}forEach _coords
		}
	}]
};