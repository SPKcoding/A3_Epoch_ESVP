params [["_player",objNull,[objNull]],["_token","",[""]]];
if !([_player,_token] call EPOCH_server_getPToken)exitWith{diag_log text format['(SPK-DEBUG) ESVP_SERVER: PLAYER %1 HAS NO TOKEN! MAYBE A TRY TO CHEAT?',_player]};
_ESVP_server_debugMode = getText(configFile >> 'CfgESVP' >> '_debugLog') isEqualTo str(true);
_srvLogged = missionNamespace getVariable['ESVP_srvLogged',[]];
if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: _srvLogged: %1',_srvLogged]};
_playerUID = getPlayerUID _player;
if(!isNil'_srvLogged')then{
	if !(_playerUID in _srvLogged)then{
		_srvLogged pushBack _playerUID;
		missionNamespace setVariable['ESVP_srvLogged',_srvLogged];
		if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: added playerUID %1 to _srvLogged: %2',_playerUID,missionNamespace getVariable['ESVP_srvLogged',[]]]}
	}else{
		[_player,['ESVP_plrLogged',1,false]] remoteExec ['setVariable',_player,false];
		if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: playerUID %1 already listed in _srvLogged. Set players variable ESVP_plrLogged to 1. OK!',_playerUID]}
	}
};
