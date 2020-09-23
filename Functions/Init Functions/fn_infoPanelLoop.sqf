// This may be replaced in the future with an update function that simply acts as an event that must be called
// I am curious to see if the performance of this loop is negligible enough though, 
/// that it would be more effective to just have these update automatically

if (!hasInterface) exitWith {};

params [
	["_player",player,[objNull]]
];

#define INFO_PANEL_IDC 99999

disableSerialization;

waitUntil {!isNil "BLWK_playerKillPoints" AND {!isNil "BLWK_numRespawnTickets"} AND {!isNil "BLWK_currentWaveNumber"}};

private _playerName = name _player;
private _playerPoints = BLWK_playerKillPoints;
private _numRespawnTickets = BLWK_numRespawnTickets;
private _currentWave = BLWK_currentWaveNumber;
private "_text";

private _fn_updateInfoPanel = {
	_playerPoints = BLWK_playerKillPoints;
	_numRespawnTickets = BLWK_numRespawnTickets
	_currentWave = BLWK_currentWaveNumber;

	if (_numRespawnTickets < 0) then {
		_numRespawnTickets = 0;
	};
	
	_text = format [
		"<t size='1.2' color='#ffffff'>%1</t>
		<br/>
		<t size='1.5' color='#dddddd'>%2</t>
		<br/>
		<t size='0.9' color='#cee5d0'>Wave: %3</t>
		<br/>
		<t size='0.9' color='#cee5d0'>Tickets: %4</t>"
		,_playerName, _playerPoints, _currentWave, _numRespawnTickets
	];

    // CIPHER COMMENT: why are we redisplaying this value instead of just updating it?
    // is this constantly adding another layer on top?
    1000 cutRsc ["BLWK_infoPanel","PLAIN"];
    private _infoPanelDisplay = uiNameSpace getVariable "BLWK_infoPanel";
    private _infoPanelControl = _infoPanelDisplay displayCtrl INFO_PANEL_IDC;
    _infoPanelControl ctrlSetStructuredText parseText _text;
    _infoPanelControl ctrlCommit 0;
};


while {true} do {
	if (
		_playerPoints != BLWK_playerKillPoints OR 
		{_numRespawnTickets != BLWK_numRespawnTickets} OR
		{_currentWave != BLWK_currentWaveNumber}
	) then {
		call _fn_updateInfoPanel
	};

	sleep 2;
};