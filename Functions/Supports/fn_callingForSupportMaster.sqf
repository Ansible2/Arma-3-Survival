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
params ["_caller","_targetPosition","_supportClass"];

#define ADD_SUPPORT_BACK [_caller,_supportClass,nil,nil,""] call BIS_fnc_addCommMenuItem;

if (_targetPosition isEqualTo []) exitWith {
	hint "Position is invalid, try again";
	ADD_SUPPORT_BACK
};

#include "..\..\Headers\descriptionEXT\supportDefines.hpp"

#define CHECK_SUPPORT_CLASS(SUPPORT_CLASS_COMPARE) _supportClass == TO_STRING(SUPPORT_CLASS_COMPARE)


// cruise missile
if (CHECK_SUPPORT_CLASS(CRUISE_MISSILE_CLASS)) exitWith {
	null = [_targetPosition] spawn BLWK_fnc_cruiseMissileStrike;
	[TYPE_STRIKE] call BLWK_fnc_supportRadioGlobal;
};


#define ARTY_EXPRESSION(AMMO_TYPE) null = [_targetPosition,AMMO_TYPE] spawn BLWK_fnc_callForArtillery

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
	ARTY_EXPRESSION("Flare_82mm_AMOS_White")
};


// arsenal supply drop
if (CHECK_SUPPORT_CLASS(SUPPLY_ARSENAL_DROP_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_arsenalOut",false]) then {
		missionNamespace getVariable ["BLWK_arsenalOut",true,true];

		private _friendlyDropAircraftClass = [5] call BLWK_fnc_getFriendlyVehicleClass;
		[_targetPosition,_friendlyDropAircraftClass] call BLWK_fnc_arsenalSupplyDrop;
		[TYPE_SUPPLY_DROP_REQUEST] call BLWK_fnc_supportRadioGlobal;
	} else {
		hint "An arsenal is already in use";
		ADD_SUPPORT_BACK
	};
};


// CAS
#define CAS_RADIO [TYPE_CAS_REQUEST] call BLWK_fnc_supportRadioGlobal;
#define CAS_EXPRESSSION(CAS_TYPE) \
	_targetPosition = AGLToASL(_targetPosition);\
	private _friendlyAttackAircraftClass = [6] call BLWK_fnc_getFriendlyVehicleClass;\
	null = [_targetPosition,CAS_TYPE,getDir _caller,_friendlyAttackAircraftClass] spawn BLWK_fnc_CAS;\
	CAS_RADIO

if (CHECK_SUPPORT_CLASS(CAS_GUN_RUN_CLASS)) exitWith {
	CAS_EXPRESSSION(0)
};
if (CHECK_SUPPORT_CLASS(CAS_ROCKETS_CLASS)) exitWith {
	CAS_EXPRESSSION(1)
};
if (CHECK_SUPPORT_CLASS(CAS_GUNS_AND_ROCKETS_CLASS)) exitWith {
	CAS_EXPRESSSION(2)
};



// turret supports
#define TURRET_EXPRESSION(AIRCRAFT_TYPE,HEIGHT,RADIUS,DEFAULT_AIRCRAFT_TYPE,GUNNER_TYPE) \
	[AIRCRAFT_TYPE,HEIGHT,RADIUS,DEFAULT_AIRCRAFT_TYPE,GUNNER_TYPE] call BLWK_fnc_aircraftGunner;\
	CAS_RADIO
	
if (CHECK_SUPPORT_CLASS(TURRET_DOOR_GUNNER_CLASS)) exitWith {
	if (missionNamespace getVariable ["BLWK_doorGunnerInUse",false]) then {
		private _friendlyTransportHeliClass = [4] call BLWK_fnc_getFriendlyVehicleClass;
		TURRET_EXPRESSION(_friendlyTransportHeliClass,125,BLWK_playAreaRadius * 1.5,"B_Heli_Transport_01_F","BLWK_doorGunnerInUse")
	} else {
		hint "Only one door gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};
};
if (CHECK_SUPPORT_CLASS(TURRET_ATTACK_HELI_GUNNER_CLASS)) exitWith {
	if (missionNamespace getVariable ["BLWK_heliGunnerInUse",false]) then {
		private _friendlyAttackHeliClass = [7] call BLWK_fnc_getFriendlyVehicleClass;
		TURRET_EXPRESSION(_friendlyAttackHeliClass,400,550,"B_Heli_Attack_01_dynamicLoadout_F","BLWK_heliGunnerInUse")	
	} else {
		hint "Only one helicopter gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};
};
if (CHECK_SUPPORT_CLASS(TURRET_GUNSHIP_CLASS)) exitWith {
	if (missionNamespace getVariable ["BLWK_gunshipGunnerInUse",false]) then {
		private _friendlyGunshipClass = [8] call BLWK_fnc_getFriendlyVehicleClass;
		TURRET_EXPRESSION(_friendlyGunshipClass,700,1200,"B_T_VTOL_01_armed_F","BLWK_gunshipGunnerInUse")
	} else {
		hint "Only one heavy gunship gunner support may be active at a time.";
		ADD_SUPPORT_BACK
	};	
};