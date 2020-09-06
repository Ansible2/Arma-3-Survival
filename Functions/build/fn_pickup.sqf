/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pickupBuidlableObject

Description:
	Executes the action to pick up a building object

	Executed from ""

Parameters:
	0: _object : <OBJECT> - The object to pickup

Returns:
	Nothing

Examples:
    (begin example)

		[myObject] call BLWK_fnc_pickupBuidlableObject;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
_object = _this select 0;
_caller = _this select 1;
_pos = _this select 2;

_playerArr = [_caller];

if (!(player getVariable "buildItemHeld")) then {

		if (isNil "_pos") then {
			[_object, _caller] call BIS_fnc_attachToRelative ;
		} else {
			_object attachTo [_caller, _pos, "Pelvis"];
			_playerDir = _caller getRelDir _object;
			_dir = _this select 3;
			_holdDir = _playerDir + _dir;
			_object setdir _holdDir;
		};

		{
			[_object, _x] remoteExec ["disableCollisionWith", 0];
		} forEach playableUnits;

		[_object] remoteExec ["removeAllActions", 0];

		_caller addAction [
			"<t color='#00ffff'>Drop Object (Snap To Ground)</t>",
			'[_this select 3, _this select 1, _this select 2] call BLWK_fnc_drop;',
			_object
		];

		_caller addAction [
			"<t color='#00ffff'>Place Object (Floating)</t>",
			'[_this select 3, _this select 1, _this select 2] call BLWK_fnc_place;',
			_object
		];

		 _caller setVariable ["buildItemHeld", true, true];
		 _object setVariable ["buildItemHeld", true, true];

} else {

	[format ["<t size='0.6' color='#ff3300'>You're already carrying an object!</t>"], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;

};
