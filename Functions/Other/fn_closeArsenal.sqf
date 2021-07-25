/* ----------------------------------------------------------------------------
Function: BLWK_fnc_closeArsenal

Description:
	Closes the ACE or Vanilla arsenal display.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_closeArsenal;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_closeArsenal";

if (!hasInterface) exitWith {};

private _vanillaArsenalDisplay = uiNamespace getvariable ["RscDisplayArsenal",displayNull];
if (isNull _vanillaArsenalDisplay) then {

    if (["ace_arsenal"] call KISKA_fnc_isPatchLoaded) then {
        private _mainDisplay = findDisplay 46;
        private _aceArsenalDisplay = findDisplay 1127001;
        _aceArsenalDisplay closeDisplay 2;
    };

} else {
    _vanillaArsenalDisplay closeDisplay 2;

};
