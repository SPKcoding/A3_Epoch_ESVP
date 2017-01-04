params [["_player",objNull,[objNull]],["_token","",[""]],["_pos",[],[[]]],["_jammerRange",0,[0]],["_minRange",0,[0]],["_maxRange",0,[0]]];
if !([_player,_token] call EPOCH_server_getPToken)exitWith{diag_log text format['(SPK-DEBUG) ESVP_SERVER: PLAYER %1 HAS NO TOKEN! MAYBE A TRY TO CHEAT?',_player]};
_ESVP_server_debugMode = getText(configFile >> 'CfgESVP' >> '_debugLog') isEqualTo str(true);
if !(isNull _player)then{
	if((getNumber(configFile >> 'CfgESVP' >> '_useRestartVehTP') == 1)&&(getNumber(configFile >> 'CfgESVP' >> '_tpStyle') == 1))then{
		fnc_ESVP_checkPos = {
			params [['_player',objNull,[objNull]],['_token','',['']],['_pos',[],[[]]],['_jammerRange',0,[0]],['_minRange',0,[0]],['_maxRange',0,[0]],['_pPlaceSpot',[],[[]]],['_size',0,[0]],'_debug'];
			_disAdd = 1000;
			_pos = [_pos,_minRange + _disAdd,_maxRange + _disAdd,3,0,30,0] call BIS_fnc_findSafePos;
			_pos = [_pos select 0,_pos select 1,0];
			if(_debug)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: Found new position %1 for player [%2, UID: %3]',_pos,name _player,getPlayerUID _player]};
			if((_pos distance _pPlaceSpot) <= (_minRange + _disAdd))then[{
				if(_debug)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: Position %1 is too close to the parking place! Searching for a new position...',_pos]};
				[_player,_token,_pos,_jammerRange,_minRange,_maxRange,_pPlaceSpot,_size,_debug] call fnc_ESVP_checkPos
			},{
				if((_pos distance _pPlaceSpot) > (_minRange + _disAdd))then{
					if(count(_pos nearObjects['PlotPole_EPOCH',_jammerRange]) != 0)then[{
						if(_debug)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: Position %1 is too close to a Frequency Jammer! Searching for a new position...',_pos]};
						[_player,_token,_pos,_jammerRange,_minRange,_maxRange,_pPlaceSpot,_size,_debug] call fnc_ESVP_checkPos
					},{
						if(_debug)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: Position %1 is fine! Teleporting player [%2, UID: %3] now!',_pos,name _player,getPlayerUID _player]};
						[_player,_token,_pos] call SPK_fnc_ESVP_secureTP
					}]
				}
			}]
		};
		_pPlaceSpot = getArray(configFile >> 'CfgESVP' >> '_pPlaceCoords');
		_size = getNumber(configFile >> 'CfgESVP' >> '_pPlaceSize');
		_dis = _pos distance _pPlaceSpot;
		if(_dis <= _minRange)then{
			if(_ESVP_server_debugMode)then{diag_log text format['(SPK-DEBUG) ESVP_SERVER: Trying to find a position to teleport the player [%1, UID: %2] away from the parking place...',name _player,getPlayerUID _player]};
			[_player,_token,_pos,_jammerRange,_minRange,_maxRange,_pPlaceSpot,_size,_ESVP_server_debugMode] call fnc_ESVP_checkPos
		}
	}
}else{
	if(_ESVP_server_debugMode)then{diag_log text '(SPK-DEBUG) ESVP_SERVER: ERROR WHILE TRYING TO TELEPORT PLAYER, OBJECT PLAYER IS NULL! (fn_ESVP_plrCheckPos.sqf)'}
};
