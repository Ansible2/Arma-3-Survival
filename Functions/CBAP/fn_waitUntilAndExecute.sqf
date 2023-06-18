/* ----------------------------------------------------------------------------
Function: CBAP_fnc_waitUntilAndExecute

Description:
    A cheap imitation of CBA_fnc_waitUntilAndExecute that uses scheduled environment.

	The actual code to run (_function) will be executed in an unscheduled environment.

	Avoid using this.

Parameters:
    0: _condition <CODE> - The function to evaluate as condition
    1: _statement <CODE> - The function to run once the condition is true
	2: _args <ANY> - Parameters passed to the functions (statement and condition) executing
	3: _timeout <NUMBER> - If >= 0, timeout for the condition in seconds.  If < 0, no timeout.
			Exactly 0 means timeout immediately on the next iteration
	4: _timeoutCode <CODE> - Will execute instead of _statement if the condition times out

Returns:
    NOTHING

Example:
    (begin example)
		[
			{
				(_this select 0) == vehicle (_this select 0)
			},
			{
				(_this select 0) setDamage 1;
			}, 
			[player]
		] call CBAP_fnc_waitUntilAndExecute;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */

if (["cba_common"] call KISKA_fnc_isPatchLoaded) exitWith {
	_this call CBA_fnc_waitUntilAndExecute;
};

params [
    ["_condition", {}, [{}]],
    ["_statement", {}, [{}]],
    ["_args", []],
    ["_timeout", -1, [0]],
    ["_timeoutCode", {}, [{}]]
];

_this spawn {
	params ["_condition","_statement","_args","_timeout","_timeoutCode"];

	private _hasTimeout = _timeout >= 0;
	private _timeoutTime = time + _timeout;
	waitUntil {
		if (_args call _condition) exitWith {
			[_statement, _args] call CBAP_fnc_directCall;
		};

		if (_hasTimeout AND (time >= _timeoutTime)) exitWith {
			[_timeoutCode, _args] call CBAP_fnc_directCall;
		};

		true
	};
};


nil
