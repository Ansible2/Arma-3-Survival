waitUntil {
	if (missionNamespace getVariable ["BLWK_serverInitialized",false]) exitWith {true};
	false
};
