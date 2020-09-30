if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params ["_unit"];

if (!local _unit) exitWith {};

_unit addEventHandler ["KILLED",{
	[_this select 0,_thisEventHandler] remoteExecCall ["BLWK_fnc_removeDragAction",BLWK_allClientsTargetID,true];
}];