params ["_control","_display"];

private _systemOn = ["KISKA_musicSystemIsRunning",missionNamespace,false] call KISKA_fnc_getVariableTarget;
_control lbAdd "SYSTEM IS: OFF"; // 0
_control lbSetTooltip [0,"Setting the system directly to off while music is playing will have that song finish"];

_control lbAdd "SYSTEM IS: ON"; // 1
_control lbSetTooltip [1,"Committed playlist on server will immediately begin playing"];

_control lbAdd "DO SYSTEM RESET"; // 2
_control lbSetTooltip [2,"Current playing track from the playlist will cease on all machines and system will be set to off"];

_control ctrlSetFont "PuristaLight";
_control lbSetCurSel ([0,1] select _systemOn);

_control ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];
	
	switch (_selectedIndex) do {
		case 0:{ // system off
			missionNamespace setVariable ["KISKA_musicSystemIsRunning",false,[0,2] select isMultiplayer];
			
			if (missionNamespace getVariable ["BLWK_musicManager_reset",false]) then {
				//hint "System reseting...";
				missionNamespace setVariable ["BLWK_musicManager_reset",false];
			} else {
				hint "System OFF, last played song will finish...";
			};
		};
		case 1:{ // system on
			hint "System starting... Make sure you commited a playlist to the server";

			// if music is playing from the manager, stop the timeline
			if (uiNamespace getVariable ["BLWK_musicManager_doPlay",false]) then {
				uiNamespace setVariable ["BLWK_musicManager_doPlay",false];
				uiNamespace setVariable ["BLWK_musicManager_paused",true];
			};
			null = remoteExec ["KISKA_fnc_randomMusic",2];
		};
		case 2:{ // system reset
			null = [false] remoteExecCall ["KISKA_fnc_stopRandomMusicServer",2];
			missionNamespace setVariable ["BLWK_musicManager_reset",true];
			_control lbSetCurSel 0; // set to appear off
		};
	};
}];
