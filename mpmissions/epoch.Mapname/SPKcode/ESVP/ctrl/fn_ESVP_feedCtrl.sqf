ctrlInput = compileFinal "
	disableSerialization;
	ESVP_debugMode = getText(missionConfigFile >> 'CfgESVP' >> 'debug' >> '_debugLog') isEqualTo str(true);
	_dsp = uiNamespace getVariable['SPK_ESVP_dialog',displayNull];
	if !(isNull _dsp)then{
		_ctrl = _dsp displayCtrl 1;
		if !(param [0,'',['']] isEqualTo 'load')then{_ctrl lbSetCurSel -1};
		lbClear _ctrl;
		private['_id','_veh','_owners'];
		_zones = getArray(missionConfigFile >> 'CfgESVP' >> 'safezones' >> '_defineSafezones');
		_id = player getVariable['safezoneID',nil];
		_zoneID = '';
		_plrData = [];
		if(!isNil'_id' && _id != 'none')then[{
			_getZoneData = {
				private['_this select 0','_this select 1','_zoneData'];
				_ret = [];
				if !((_this select 0) isEqualTo [])then[{
					if !(format['ID_%1',((_this select 0)select 0)select 0] isEqualTo (_this select 1))then{
						(_this select 0) deleteAt 0;
						[_this select 0,_this select 1] call _getZoneData
					}else{
						if(format['ID_%1',((_this select 0)select 0)select 0] isEqualTo (_this select 1))exitWith{
							_zoneData = (_this select 0)select 0;
							_ret = _zoneData;
							_ret
						}
					}
				},{
					if((_this select 0) isEqualTo [])exitWith{_ret = ['FAILURE'];_ret}
				}]
			};
			_zoneData = [_zones,_id] call _getZoneData;
			if !(_zoneData isEqualTo ['FAILURE'])then[{
				_veh = vehicle player;
				_owners = _veh getVariable['vehOwners',nil];
				if(!isNil'_owners')then[{
					_zoneID = format['ID_%1',_zoneData select 0];
					_getPlrs = (_zoneData select 1) nearEntities['Man',_zoneData select 2];
					_plrData = [];
					{
						if(!isNull _x)then{
							if(isPlayer _x)then{
								if !(getPlayerUID _x in _owners)then{
									_plrData pushBack [name _x,getPlayerUID _x];
									_ctrl lbAdd format['%1',name _x]
								}
							}
						}
					}forEach _getPlrs;
					if(_plrData isEqualTo [])then{systemChat 'NO PLAYERS AVAILABLE TO GRANT ACCESS TO...'}
				},{
					if(ESVP_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP: Could not load _owners variable! Result: %1',_owners]};
					systemChat 'PLEASE RE-ENTER THE SAFEZONE TO USE THIS FEATURE...'
				}]
			},{
				if(ESVP_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP: Failed to get _zoneData! Result: %1',_zoneData]};
				systemChat 'ERROR: TRY TO RE-ENTER THE SAFEZONE OR CALL AN ADMIN...'
			}]
		},{
			if(ESVP_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP: Error with players safezoneID! Result: %1',_id]};
			systemChat 'ERROR: TRY TO RE-ENTER THE SAFEZONE OR CALL AN ADMIN...'
		}];
		_ctrl setVariable['ListData',_plrData]
	};
	true
";
disableSerialization;
_dsp = uiNamespace getVariable['SPK_ESVP_dialog',displayNull];
if !(isNull _dsp)then{
	_ctrlList = _dsp displayCtrl 1;
	['load'] call ctrlInput
};
true
