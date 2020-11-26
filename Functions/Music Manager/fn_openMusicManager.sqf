// check if player is host or admin
if (!(call BIS_fnc_admin > 0) AND {clientOwner != 2}) exitWith {
	hint "Only admins and hosts can open the manager";
};

createDialog "musicManagerDialog"; 