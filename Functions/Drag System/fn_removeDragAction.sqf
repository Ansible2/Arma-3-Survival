if (!hasInterface) exitWith {};

params ["_unit","_eventHandlerId"];

if (local _unit) then {
	_unit removeEventHandler ["KILLED",_eventHandlerId];
};

private _actionId = _unit getVariable "BLWK_dragActionId";
if (!isNil "_actionId") then {
	_unit removeAction _actionId;
};