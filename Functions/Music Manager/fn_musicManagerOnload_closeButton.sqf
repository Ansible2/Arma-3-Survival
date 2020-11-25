params ["_control"];

_control ctrlAddEventHandler ["ButtonClick",{
	(uiNamespace getVariable "BLWK_musicManager_display") closeDisplay 2;
}];