params [["_player",objNull,[objNull]],["_token","",[""]],["_pos",[],[[]]]];
if !([_player,_token] call EPOCH_server_getPToken)exitWith{diag_log text format['(SPK-DEBUG) ESVP_SERVER: PLAYER %1 HAS NO TOKEN! MAYBE A TRY TO CHEAT?',_player]};
_state = getText(configFile >> "CfgEpochServer" >> "antihack_Enabled");
_playerTP = compileFinal "
	params [['_player',objNull,[objNull]],['_pos',[],[[]]],'_AH'];
	if(_AH)then[{[_player,_pos] call EPOCH_server_movePlayer},{_player setPos _pos}];
	[_player,['ESVP_loginDone',1,false]] remoteExec ['setVariable',_player,false]
";
if !(isNull _player)then{
	[_player,_pos,if(_state isEqualTo str(true))then[{true},{if(_state isEqualTo str(false))then{false}}]] call _playerTP
}else{
	if(getText(configFile >> 'CfgESVP' >> '_debugLog') isEqualTo str(true))then{diag_log text '(SPK-DEBUG) ESVP_SERVER: ERROR WHILE TRYING TO TELEPORT PLAYER, OBJECT PLAYER IS NULL! (fn_ESVP_secureTP.sqf)'}
};
