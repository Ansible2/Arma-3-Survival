#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_supportRadioGlobal

Description:
	Decides what radio message to play to all players when a support is called.

Parameters:
	0: _messageType <STRING> - The type of radio message to send

Returns:
	NOTHING

Examples:
    (begin example)

		["artillery"] call BLWK_fnc_supportRadioGlobal;

    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	"_messageType",
	["_caller",player,[objNull]]
];

private "_messageArray";
switch _messageType do {
	case TYPE_ARTILLERY: {
		_messageArray = [
			"mp_groundsupport_45_artillery_BHQ_0",
			"mp_groundsupport_45_artillery_BHQ_1",
			"mp_groundsupport_45_artillery_BHQ_2",
			"mp_groundsupport_45_artillery_IHQ_0",
			"mp_groundsupport_45_artillery_IHQ_1",
			"mp_groundsupport_45_artillery_IHQ_2"
		];
	};

	case TYPE_STRIKE: {
		_messageArray = [
			"mp_groundsupport_70_tacticalstrikeinbound_BHQ_0",
			"mp_groundsupport_70_tacticalstrikeinbound_BHQ_1",
			"mp_groundsupport_70_tacticalstrikeinbound_BHQ_2",
			"mp_groundsupport_70_tacticalstrikeinbound_BHQ_3",
			"mp_groundsupport_70_tacticalstrikeinbound_BHQ_4",
			"mp_groundsupport_70_tacticalstrikeinbound_IHQ_0",
			"mp_groundsupport_70_tacticalstrikeinbound_IHQ_1",
			"mp_groundsupport_70_tacticalstrikeinbound_IHQ_2",
			"mp_groundsupport_70_tacticalstrikeinbound_IHQ_3",
			"mp_groundsupport_70_tacticalstrikeinbound_IHQ_4"
		];
	};

	case TYPE_SUPPLY_DROP: {
		_messageArray = [
			"mp_groundsupport_10_slingloadsucceeded_BHQ_0",
			"mp_groundsupport_10_slingloadsucceeded_BHQ_1",
			"mp_groundsupport_10_slingloadsucceeded_BHQ_2",
			"mp_groundsupport_10_slingloadsucceeded_IHQ_0",
			"mp_groundsupport_10_slingloadsucceeded_IHQ_1",
			"mp_groundsupport_10_slingloadsucceeded_IHQ_2"
		];
	};

	case TYPE_SUPPLY_DROP_REQUEST: {
		_messageArray = [
			"mp_groundsupport_01_slingloadrequested_BHQ_0",
			"mp_groundsupport_01_slingloadrequested_BHQ_1",
			"mp_groundsupport_01_slingloadrequested_BHQ_2",
			"mp_groundsupport_01_slingloadrequested_IHQ_0",
			"mp_groundsupport_01_slingloadrequested_IHQ_1",
			"mp_groundsupport_01_slingloadrequested_IHQ_2"
		];
	};

	case TYPE_CAS_REQUEST: {
		_messageArray = [
			"mp_groundsupport_01_casrequested_BHQ_0",
			"mp_groundsupport_01_casrequested_BHQ_1",
			"mp_groundsupport_01_casrequested_BHQ_2",
			"mp_groundsupport_01_casrequested_IHQ_0",
			"mp_groundsupport_01_casrequested_IHQ_1",
			"mp_groundsupport_01_casrequested_IHQ_2",
			"mp_groundsupport_50_cas_BHQ_0",
			"mp_groundsupport_50_cas_BHQ_1",
			"mp_groundsupport_50_cas_BHQ_2",
			"mp_groundsupport_50_cas_IHQ_0",
			"mp_groundsupport_50_cas_IHQ_1",
			"mp_groundsupport_50_cas_IHQ_2"
		];
	};

	case TYPE_CAS_ABORT: {
		_messageArray = [
			"mp_groundsupport_05_casaborted_BHQ_0",
			"mp_groundsupport_05_casaborted_BHQ_1",
			"mp_groundsupport_05_casaborted_BHQ_2",
			"mp_groundsupport_05_casaborted_IHQ_0",
			"mp_groundsupport_05_casaborted_IHQ_1",
			"mp_groundsupport_05_casaborted_IHQ_2"
		];
	};

	case TYPE_HELO_DOWN: {
		_messageArray = [
			"mp_groundsupport_65_chopperdown_BHQ_0",
			"mp_groundsupport_65_chopperdown_BHQ_1",
			"mp_groundsupport_65_chopperdown_BHQ_2",
			"mp_groundsupport_65_chopperdown_IHQ_0",
			"mp_groundsupport_65_chopperdown_IHQ_1",
			"mp_groundsupport_65_chopperdown_IHQ_2"
		];
	};

	case TYPE_UAV_REQUEST: {
		_messageArray = [
			"mp_groundsupport_60_uav_BHQ_0",
			"mp_groundsupport_60_uav_BHQ_1",
			"mp_groundsupport_60_uav_BHQ_2",
			"mp_groundsupport_60_uav_IHQ_0",
			"mp_groundsupport_60_uav_IHQ_1",
			"mp_groundsupport_60_uav_IHQ_2"
		];
	};

	case TYPE_TRANSPORT_REQUEST: {
		_messageArray = [
			"mp_groundsupport_01_transportrequested_BHQ_0",
			"mp_groundsupport_01_transportrequested_BHQ_1",
			"mp_groundsupport_01_transportrequested_BHQ_2",
			"mp_groundsupport_01_transportrequested_IHQ_0",
			"mp_groundsupport_01_transportrequested_IHQ_1",
			"mp_groundsupport_01_transportrequested_IHQ_2"
		];
	};

	default {
		_messageArray = ["mp_groundsupport_70_tacticalstrikeinbound_BHQ_0"];
	};
};

private _message = selectRandom _messageArray;

[_caller,_message] remoteExec ["sideRadio",BLWK_allClientsTargetID];