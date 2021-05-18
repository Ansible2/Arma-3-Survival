#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callingForSupportMaster

Description:
	Gets the called support and verifies there is a valid position to attack.
	Refunds the appropriate support if not.

Parameters:
	0: _caller <OBJECT> - The player calling for support
	1: _targetPosition <ARRAY> - The position (AGLS) at which the call is being made
		(where the player is looking or if in the map, the position where their cursor is)
	2: _supportClass <STRING> - The class as defined in the CfgCommunicationMenu

Returns:
	NOTHING

Examples:
    (begin example)
		[_caller,_targetPosition,"someClass"] call BLWK_fnc_callingForSupportMaster;
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

#define GET_AMMO_TYPE(CONFIG) getText(missionConfigFile >> "CfgCommunicationMenu" >> TO_STRING(CONFIG) >> "ammoType")
#define ARTY_EXPRESSION(CONFIG) CHECK_POSITION [_targetPosition,GET_AMMO_TYPE(CONFIG)] spawn BLWK_fnc_callForArtillery
#define ARTY_EXPRESSION_FULL(CONFIG) \
	if (CHECK_SUPPORT_CLASS(CONFIG)) exitWith { \
		ARTY_EXPRESSION(CONFIG) \
	};

#define CAS_RADIO [TYPE_CAS_REQUEST] call BLWK_fnc_supportRadioGlobal;

#define CAS_EXPRESSSION(CAS_TYPE) \
	CHECK_POSITION \
	_targetPosition = AGLToASL(_targetPosition);\
	private _friendlyAttackAircraftClass = [6] call BLWK_fnc_getFriendlyVehicleClass;\
	[_targetPosition,CAS_TYPE,getDir _caller,_friendlyAttackAircraftClass] spawn KISKA_fnc_CAS;\
	CAS_RADIO

#define TURRET_EXPRESSION(AIRCRAFT_TYPE,HEIGHT,RADIUS,DEFAULT_AIRCRAFT_TYPE,GUNNER_TYPE) \
	[AIRCRAFT_TYPE,HEIGHT,RADIUS,DEFAULT_AIRCRAFT_TYPE,GUNNER_TYPE] call BLWK_fnc_aircraftGunner;\
	CAS_RADIO

#define NUMBER_OF_PARATROOPERS 5

#define HELI_CAS_EXPRESSION(VEHICLE_TYPE,TIME_ON_STATION,FLYIN_ALT,DEFAULT_TYPE,GLOBAL_VAR) \
	[BLWK_playAreaCenter,BLWK_playAreaRadius,VEHICLE_TYPE,TIME_ON_STATION,10,FLYIN_ALT,-1,DEFAULT_TYPE,GLOBAL_VAR] call BLWK_fnc_passiveHelicopterGunner; \
	CAS_RADIO


params ["_caller","_targetPosition","_supportClass"];


// if a ctrl key is held and one left clicks to select the support while in the map, they can call in an infinite number of the support
if (visibleMap AND {missionNamespace getVariable ["KISKA_ctrlDown",false]}) exitWith {
	hint parseText "<t color='#ff0000'>You can't call in a support while holding down a crtl key and in the map. It causes a bug with the support menu.</t>";
	ADD_SUPPORT_BACK
};


/* ----------------------------------------------------------------------------
	Other
---------------------------------------------------------------------------- */
// cruise missile
if (CHECK_SUPPORT_CLASS(CRUISE_MISSILE_CLASS)) exitWith {
	CHECK_POSITION
	[_targetPosition] spawn BLWK_fnc_cruiseMissileStrike;
	[TYPE_STRIKE] call BLWK_fnc_supportRadioGlobal;
};

if (CHECK_SUPPORT_CLASS(DAISY_CUTTER_CLASS)) exitWith {
	CHECK_POSITION
	private _friendlyDropAircraftClass = [5] call BLWK_fnc_getFriendlyVehicleClass;
	[_targetPosition,40,_friendlyDropAircraftClass] spawn BLWK_fnc_daisyCutter;
	[TYPE_STRIKE] call BLWK_fnc_supportRadioGlobal;
};


/* ----------------------------------------------------------------------------
	155 Artillery
---------------------------------------------------------------------------- */
// 155 HE
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_155MM_HE_CLASS)
// 155 Cluster
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_155MM_CLUSTER_CLASS)
// 155 Mines
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_155MM_MINES_CLASS)
// 155 AT Mines
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_155MM_AT_MINES_CLASS)


/* ----------------------------------------------------------------------------
	120 Artillery
---------------------------------------------------------------------------- */
// 120 HE
ARTY_EXPRESSION_FULL(CANNON_120MM_HE_CLASS)
// 120 Cluster
ARTY_EXPRESSION_FULL(CANNON_120MM_CLUSTER_CLASS)
// 120 AT Mines
ARTY_EXPRESSION_FULL(CANNON_120MM_AT_MINES_CLASS)
// 120 Mines
ARTY_EXPRESSION_FULL(CANNON_120MM_MINES_CLASS)
// 120 Smoke
ARTY_EXPRESSION_FULL(CANNON_120MM_SMOKE_CLASS)


/* ----------------------------------------------------------------------------
	82 Mortar
---------------------------------------------------------------------------- */
// 82 HE
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_82MM_HE_CLASS)
// 82 Smoke
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_82MM_SMOKE_CLASS)
// 82 Flare
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_82MM_FLARE_CLASS)


/* ----------------------------------------------------------------------------
	SOG PF Arty
---------------------------------------------------------------------------- */
// 105 airburst
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_105MM_AB_CLASS)
// 105 HE
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_105MM_HE_CLASS)
// 105 Chem
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_105MM_CHEM_CLASS)
// 105 Frag
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_105MM_FRAG_CLASS)
// 105 White Phosphorus
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_105MM_WP_CLASS)
// 85 HE
ARTY_EXPRESSION_FULL(ARTILLERY_STRIKE_85MM_HE_CLASS)
// 60 HE
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_60MM_HE_CLASS)
// 60 White Phosphorus
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_60MM_WP_CLASS)
// 81 HE
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_81MM_HE_CLASS)
// 81 White Phosphorus
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_81MM_WP_CLASS)
// 81 Smoke
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_81MM_SMOKE_CLASS)
// 82 HE
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_82MM_HE_SOGPF_CLASS)
// 82 White Phosphorus
ARTY_EXPRESSION_FULL(MORTAR_STRIKE_82MM_WP_CLASS)

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
if (CHECK_SUPPORT_CLASS(CAS_BOMB_LGB_CLASS)) exitWith {
	CAS_EXPRESSSION(6)
};
if (CHECK_SUPPORT_CLASS(CAS_BOMB_CLUSTER_CLASS)) exitWith {
	CAS_EXPRESSSION(7)
};

// napalm
if (CHECK_SUPPORT_CLASS(CAS_BOMB_NAPALM_CLASS)) exitWith {
	CHECK_POSITION
	_targetPosition = AGLToASL(_targetPosition);
	private _friendlyAttackAircraftClass = [6] call BLWK_fnc_getFriendlyVehicleClass;
	[_targetPosition,[8,"vn_bomb_f4_in_500_blu1b_fb_mag_x1"],getDir _caller,_friendlyAttackAircraftClass] spawn KISKA_fnc_CAS;
	CAS_RADIO
};
if (CHECK_SUPPORT_CLASS(CAS_BOMB_NAPALM_2_CLASS)) exitWith {
	CHECK_POSITION
	_targetPosition = AGLToASL(_targetPosition);
	private _friendlyAttackAircraftClass = [6] call BLWK_fnc_getFriendlyVehicleClass;
	[_targetPosition,[8,"vn_bomb_f4_in_500_blu1b_fb_mag_x2"],getDir _caller,_friendlyAttackAircraftClass] spawn KISKA_fnc_CAS;
	CAS_RADIO
};


/* ----------------------------------------------------------------------------
	Helicopter CAS
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(PASS_ATTACK_GUNNER_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_heliGunnerInUse",false]) then {
		private _vehicleClass = [7] call BLWK_fnc_getFriendlyVehicleClass;
		HELI_CAS_EXPRESSION(_vehicleClass,180,100,"B_Heli_Attack_01_dynamicLoadout_F","BLWK_heliGunnerInUse")
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

	//[BLWK_zeus, [_unitsToDrop,false]] remoteExecCall ["addCuratorEditableObjects",2];
	[_targetPosition,_unitsToDrop,"B_T_VTOL_01_infantry_F"] spawn KISKA_fnc_paratroopers;
};


/* ----------------------------------------------------------------------------
	Recon
---------------------------------------------------------------------------- */
if (CHECK_SUPPORT_CLASS(RECON_UAV_CLASS)) exitWith {
	if !(missionNamespace getVariable ["BLWK_reconUavActive",false]) then {
		remoteExec ["BLWK_fnc_reconUAV",2];
		[TYPE_UAV_REQUEST] call BLWK_fnc_supportRadioGlobal;
	} else {
		ADD_SUPPORT_BACK
		hint "Recon UAV is already active";
	};
};
