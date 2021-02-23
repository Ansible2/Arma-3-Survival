#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callingForSupportMaster

Description:
	Gets the called support and verifies there is a valid position to attack.
	Refunds the appropriate support if not.

Parameters:
	0: _caller <OBJECT> - The player calling for support
	1: _targetPosition <ARRAY> - The position at which the call it being made
	2: _supportClass <STRING> - The class as defined in the CfgCommunicationMenu

Returns:
	NOTHING

Examples:
    (begin example)
		[_caller,_targetPosition] call BLWK_fnc_callingForSupportMaster;
    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define ADD_SUPPORT_BACK [_caller,_supportClass,nil,nil,""] call BIS_fnc_addCommMenuItem;

#define CHECK_POSITION \
if (_targetPosition isEqualTo []) exitWith { \
	hint "Position is invalid, try again"; \
	ADD_SUPPORT_BACK \
};

#define CHECK_SUPPORT_CLASS(SUPPORT_CLASS_COMPARE) _supportClass == TO_STRING(SUPPORT_CLASS_COMPARE)

#define ARTY_EXPRESSION(AMMO_TYPE) CHECK_POSITION null = [_targetPosition,AMMO_TYPE] spawn BLWK_fnc_callForArtillery

#define CAS_RADIO [TYPE_CAS_REQUEST] call BLWK_fnc_supportRadioGlobal;

#define CAS_EXPRESSSION(CAS_TYPE) \
	CHECK_POSITION \
	_targetPosition = AGLToASL(_targetPosition);\
	private _friendlyAttackAircraftClass = [6] call BLWK_fnc_getFriendlyVehicleClass;\
	null = [_targetPosition,CAS_TYPE,getDir _caller,_friendlyAttackAircraftClass] spawn KISKA_fnc_CAS;\
	CAS_RADIO

#define TURRET_EXPRESSION(AIRCRAFT_TYPE,HEIGHT,RADIUS,DEFAULT_AIRCRAFT_TYPE,GUNNER_TYPE) \
	[AIRCRAFT_TYPE,HEIGHT,RADIUS,DEFAULT_AIRCRAFT_TYPE,GUNNER_TYPE] call BLWK_fnc_aircraftGunner;\
	CAS_RADIO

#define NUMBER_OF_PARATROOPERS 5

#define HELI_CAS_EXPRESSION(VEHICLE_TYPE,TIME_ON_STATION,FLYIN_ALT,DEFAULT_TYPE,GLOBAL_VAR) \
	[BLWK_playAreaCenter,BLWK_playAreaRadius,VEHICLE_TYPE,TIME_ON_STATION,10,FLYIN_ALT,-1,DEFAULT_TYPE,GLOBAL_VAR] call BLWK_fnc_passiveHelicopterGunner; \
	CAS_RADIO


params ["_caller","_targetPosition","_supportClass"];

/* ----------------------------------------------------------------------------
	Other
---------------------------------------------------------------------------- */
// cruise missile
if (CHECK_SUPPORT_CLASS(CRUISE_MISSILE_CLASS)) exitWith {
	CHECK_POSITION
	null = [_targetPosition] spawn BLWK_fnc_cruiseMissileStrike;
	[TYPE_STRIKE] call BLWK_fnc_supportRadioGlobal;
};

if (CHECK_SUPPORT_CLASS(DAISY_CUTTER_CLASS)) exitWith {
	CHECK_POSITION
	private _friendlyDropAircraftClass = [5] call BLWK_fnc_getFriendlyVehicleClass;
	null = [_targetPosition,40,_friendlyDropAircraftClass] spawn BLWK_fnc_daisyCutter;
	[TYPE_STRIKE] call BLWK_fnc_supportRadioGlobal;
};


/* ----------------------------------------------------------------------------
	155 Artillery
---------------------------------------------------------------------------- */
// 155 HE
if (CHECK_SUPPORT_CLASS(ARTILLERY_STRIKE_155MM_HE_CLASS)) exitWith {
	ARTY_EXPRESSION("Sh_155mm_AMOS")
};
// 155 Cluster
if (CHECK_SUPPORT_CLASS(ARTILLERY_STRIKE_155MM_CLUSTER_CLASS)) exitWith {
	ARTY_EXPRESSION("Cluster_155mm_AMOS")
};
// 155 Mines
if (CHECK_SUPPORT_CLASS(ARTILLERY_STRIKE_155MM_MINES_CLASS)) exitWith {
	ARTY_EXPRESSION("Mine_155mm_AMOS_range")
};
// 155 AT Mines
if (CHECK_SUPPORT_CLASS(ARTILLERY_STRIKE_155MM_AT_MINES_CLASS)) exitWith {
	ARTY_EXPRESSION("AT_Mine_155mm_AMOS_range")
};


/* ----------------------------------------------------------------------------
	120 Artillery
---------------------------------------------------------------------------- */
// 120 HE
if (CHECK_SUPPORT_CLASS(CANNON_120MM_HE_CLASS)) exitWith {
	ARTY_EXPRESSION("ammo_ShipCannon_120mm_HE")
};
// 120 Cluster
if (CHECK_SUPPORT_CLASS(CANNON_120MM_CLUSTER_CLASS)) exitWith {
	ARTY_EXPRESSION("ammo_ShipCannon_120mm_HE_cluster")
};
// 120 Mines
if (CHECK_SUPPORT_CLASS(CANNON_120MM_AT_MINES_CLASS)) exitWith {
	ARTY_EXPRESSION("ammo_ShipCannon_120mm_AT_mine")
};
// 120 AT Mines
if (CHECK_SUPPORT_CLASS(CANNON_120MM_MINES_CLASS)) exitWith {
	ARTY_EXPRESSION("ammo_ShipCannon_120mm_mine")
};
// 120 Smoke
if (CHECK_SUPPORT_CLASS(CANNON_120MM_SMOKE_CLASS)) exitWith {
	ARTY_EXPRESSION("ammo_ShipCannon_120mm_smoke")
};


/* ----------------------------------------------------------------------------
	82 Mortar
---------------------------------------------------------------------------- */
// 82 HE
if (CHECK_SUPPORT_CLASS(MORTAR_STRIKE_82MM_HE_CLASS)) exitWith {
	ARTY_EXPRESSION("Sh_82mm_AMOS")
};
// 82 Smoke
if (CHECK_SUPPORT_CLASS(MORTAR_STRIKE_82MM_SMOKE_CLASS)) exitWith {
	ARTY_EXPRESSION("Smoke_82mm_AMOS_White")
};
// 82 Flare
if (CHECK_SUPPORT_CLASS(MORTAR_STRIKE_82MM_FLARE_CLASS)) exitWith {
	ARTY_EXPRESSION("F_20mm_white")
};


/* ----------------------------------------------------------------------------
	Supplies
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(SUPPLY_ARSENAL_DROP_CLASS)) exitWith {
	CHECK_POSITION

	if !(missionNamespace getVariable ["BLWK_arsenalOut",false]) then {
		missionNamespace setVariable ["BLWK_arsenalOut",true,true];

		private _friendlyDropAircraftClass = [5] call BLWK_fnc_getFriendlyVehicleClass;
		[_targetPosition,_friendlyDropAircraftClass] call BLWK_fnc_arsenalSupplyDrop;
		[TYPE_SUPPLY_DROP_REQUEST] call BLWK_fnc_supportRadioGlobal;
	} else {
		hint "An arsenal is already in use";
		ADD_SUPPORT_BACK
	};
};


/* ----------------------------------------------------------------------------
	CAS
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(CAS_GUN_RUN_CLASS)) exitWith {
	CAS_EXPRESSSION(0)
};
if (CHECK_SUPPORT_CLASS(CAS_GUNS_AND_ROCKETS_AP_CLASS)) exitWith {
	CAS_EXPRESSSION(1)
};
if (CHECK_SUPPORT_CLASS(CAS_GUNS_AND_ROCKETS_HE_CLASS)) exitWith {
	CAS_EXPRESSSION(2)
};
if (CHECK_SUPPORT_CLASS(CAS_ROCKETS_AP_CLASS)) exitWith {
	CAS_EXPRESSSION(3)
};
if (CHECK_SUPPORT_CLASS(CAS_ROCKETS_HE_CLASS)) exitWith {
	CAS_EXPRESSSION(4)
};
if (CHECK_SUPPORT_CLASS(CAS_AGM_CLASS)) exitWith {
	CAS_EXPRESSSION(5)
};
if (CHECK_SUPPORT_CLASS(CAS_BOMB_UGB_CLASS)) exitWith {
	CAS_EXPRESSSION(6)
};
if (CHECK_SUPPORT_CLASS(CAS_BOMB_CLUSTER_CLASS)) exitWith {
	CAS_EXPRESSSION(7)
};


/* ----------------------------------------------------------------------------
	Helicopter CAS
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(PASS_ATTACK_GUNNER_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_heliGunnerInUse",false]) then {
		private _vehicleClass = [7] call BLWK_fnc_getFriendlyVehicleClass;
		HELI_CAS_EXPRESSION(_vehicleClass,180,125,"B_Heli_Attack_01_dynamicLoadout_F","BLWK_heliGunnerInUse")
	} else {
		hint "Only one helicopter gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};
};
if (CHECK_SUPPORT_CLASS(PASS_DOOR_GUNNER_CLASS)) exitWith {	
	if !(missionNamespace getVariable ["BLWK_doorGunnerInUse",false]) then {
		private _vehicleClass = [4,false] call BLWK_fnc_getFriendlyVehicleClass;
		HELI_CAS_EXPRESSION(_vehicleClass,180,50,"B_Heli_Transport_01_F","BLWK_doorGunnerInUse")
	} else {
		hint "Only one door gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};
};


/* ----------------------------------------------------------------------------
	Aircraft Gunner
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(TURRET_DOOR_GUNNER_CLASS)) exitWith {
	if (missionNamespace getVariable ["BLWK_isAircraftGunner",false]) exitWith {
		hint "You can not go straight into another gunner support";
	};

	if !(missionNamespace getVariable ["BLWK_doorGunnerInUse",false]) then {
		private _friendlyTransportHeliClass = [4,false] call BLWK_fnc_getFriendlyVehicleClass;
		TURRET_EXPRESSION(_friendlyTransportHeliClass,125,BLWK_playAreaRadius * 1.5,"B_Heli_Transport_01_F","BLWK_doorGunnerInUse")
	} else {
		hint "Only one door gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};
};
if (CHECK_SUPPORT_CLASS(TURRET_ATTACK_HELI_GUNNER_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_heliGunnerInUse",false]) then {
		private _friendlyAttackHeliClass = [7] call BLWK_fnc_getFriendlyVehicleClass;
		TURRET_EXPRESSION(_friendlyAttackHeliClass,400,550,"B_Heli_Attack_01_dynamicLoadout_F","BLWK_heliGunnerInUse")	
	} else {
		hint "Only one helicopter gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};
};
if (CHECK_SUPPORT_CLASS(TURRET_GUNSHIP_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_gunshipGunnerInUse",false]) then {
		private _friendlyGunshipClass = [8,false] call BLWK_fnc_getFriendlyVehicleClass;
		TURRET_EXPRESSION(_friendlyGunshipClass,700,1200,"B_T_VTOL_01_armed_F","BLWK_gunshipGunnerInUse")
	} else {
		hint "Only one heavy gunship gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};	
};


/* ----------------------------------------------------------------------------
	Reinforcements
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(REINFORCE_PARATROOPERS_CLASS)) exitWith {
	CHECK_POSITION

	[TYPE_TRANSPORT_REQUEST] call BLWK_fnc_supportRadioGlobal;

	private _playerGroup = group _caller;
	if (isNull _playerGroup) then {
		_playerGroup = BLWK_playerGroup;
	};
	
	private "_unit_temp";
	private _unitsToDrop = [];
	for "_i" from 1 to NUMBER_OF_PARATROOPERS do {
		_unit_temp = _playerGroup createUnit [selectRandom BLWK_friendly_menClasses,[0,0,0],[],0,"NONE"];
		[_unit_temp] joinSilent _playerGroup;
		_unitsToDrop pushBack _unit_temp;
	};
	
	[BLWK_zeus, [_unitsToDrop,false]] remoteExecCall ["addCuratorEditableObjects",2];
	null = [_targetPosition,_unitsToDrop,"B_T_VTOL_01_infantry_F"] spawn BLWK_fnc_paratroopers;	
};


/* ----------------------------------------------------------------------------
	Recon
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(RECON_UAV_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_reconUavActive",false]) then {
		null = remoteExec ["BLWK_fnc_reconUAV",2];
		[TYPE_UAV_REQUEST] call BLWK_fnc_supportRadioGlobal;
	} else {
		ADD_SUPPORT_BACK
		hint "Recon UAV is already active";
	};
};