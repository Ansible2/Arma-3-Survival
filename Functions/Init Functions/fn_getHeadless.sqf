private _allPlayers = call BIS_fnc_listPlayers;
private _index = _allPlayers findIf {_x isKindOf "HeadlessClient_F"};

if (_index isEqualTo -1) then {
	objNull
} else {
	_allPlayers select _index
};