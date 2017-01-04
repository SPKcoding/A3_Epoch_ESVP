disableSerialization;
_dsp = uiNamespace getVariable['SPK_ESVP_dialog',displayNull];
if(!isNull _dsp)then{
	_ctrl = _dsp displayCtrl 2;
	_res = vehicle player getVariable['RegNames',[]];
	_result = _ctrl getVariable 'ListData';
	ESVP_debugMode = getText(missionConfigFile >> 'CfgESVP' >> 'debug' >> '_debugLog') isEqualTo str(true);
	if(count _result > 0)then{
		private['_veh','_owners'];
		_veh = vehicle player;
		_owners = _veh getVariable['vehOwners',nil];
		if(!isNil'_owners' && !(_owners isEqualTo []))then{
			for "_i" from 0 to (count _result) -1 do {
				_owners pushBack ((_result select _i)select 1);
				_res pushBack ((_result select _i)select 0)
			};
			_veh setVariable['vehOwners',_owners,true];
			_res = _res arrayIntersect _res;
			_veh setVariable['RegNames',_res,true]
		}else{
			if(ESVP_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP: Failed to add players! Empty or nil vehOwners variable. Result: %1',_owners]};
			systemChat 'ERROR: TRY TO RE-ENTER THE SAFEZONE OR CALL AN ADMIN...'
		}
	}
};
true
