if !(isServer) exitWith {};

private _paramClasses = "true" configClasses (missionConfigFile >> "Params");

private "_configName";
_paramClasses apply {
	_configName = configName _x;

	// check to see if they are just the header or space entries for readability
	if (!("SPACE" in _configName) AND {!("LABEL" in _configName)}) then {
		[_configName] call BLWK_fnc_setParam;
	};
};

saveProfileNamespace;

["Mission parameters saved"] remoteExecCall ["hint",remoteExecutedOwner];