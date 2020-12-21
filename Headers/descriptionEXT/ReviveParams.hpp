/*
	Adds server parameters related to revive.

	How to install:
	Include this file to description.ext of your mission.

	Example:
	class Params
	{
		#include "\a3\Functions_F\Params\paramRevive.inc"
	};

	Modified By: Ansible2 // Cipher
*/

class ReviveMode
{
	title = $STR_A3_ReviveMode;
	isGlobal = 1;

	values[] = {
		-100,
		0,
		1
	};
	texts[] = {
		$STR_A3_MissionDefault,
		$STR_A3_Disabled,
		$STR_A3_EnabledForAllPlayers
	};
	GET_DEFAULT_PARAM(ReviveMode,1)
	function = "bis_fnc_paramReviveMode";
};

class ReviveDuration
{
	title = $STR_A3_ReviveDuration;
	isGlobal = 1;

	values[] = {
		-100,
		6,
		8,
		10,
		12,
		15,
		20,
		25,
		30
	};
	texts[] = {
		$STR_A3_MissionDefault,
		6,
		8,
		10,
		12,
		15,
		20,
		25,
		30
	};
	GET_DEFAULT_PARAM(ReviveDuration,8)
	function = "bis_fnc_paramReviveDuration";
};

class ReviveRequiredTrait
{
	title = $STR_A3_RequiredTrait;
	isGlobal = 1;

	values[] = {
		-100,
		0,
		1
	};
	texts[] = {
		$STR_A3_MissionDefault,
		$STR_A3_None,
		$STR_A3_Medic
	};
	GET_DEFAULT_PARAM(ReviveRequiredTrait,0)
	function = "bis_fnc_paramReviveRequiredTrait";
};

class ReviveMedicSpeedMultiplier
{
	title = $STR_A3_RequiredTrait_MedicSpeedMultiplier;
	isGlobal = 1;

	values[] = {
		-100,
		1,
		1.5,
		2,
		2.5,
		3
	};
	texts[] = {
		$STR_A3_MissionDefault,
		"1x",
		"1.5x",
		"2x",
		"2.5x",
		"3x"
	};
	GET_DEFAULT_PARAM(ReviveMedicSpeedMultiplier,1)
	function = "bis_fnc_paramReviveMedicSpeedMultiplier";
};

class ReviveRequiredItems
{
	title = $STR_A3_RequiredItems;
	isGlobal = 1;

	values[] = {
		-100,
		0,
		1,
		2
	};
	texts[] = {
		$STR_A3_MissionDefault,
		$STR_A3_None,
		$STR_A3_Medikit,
		$STR_A3_FirstAidKitOrMedikit
	};
	GET_DEFAULT_PARAM(ReviveRequiredItems,2)
	function = "bis_fnc_paramReviveRequiredItems";
};

class UnconsciousStateMode
{
	title = $STR_A3_IncapacitationMode;
	isGlobal = 1;

	values[] = {
		-100,
		0,
		1
	};
	texts[] = {
		$STR_A3_MissionDefault,
		$STR_A3_Basic,
		$STR_A3_Advanced
	};
	GET_DEFAULT_PARAM(UnconsciousStateMode,-100)
	function = "bis_fnc_paramReviveUnconsciousStateMode";
};

class ReviveBleedOutDuration
{
	title = $STR_A3_BleedOutDuration;
	isGlobal = 1;

	values[] = {
		-100,
		10,
		15,
		20,
		30,
		45,
		60,
		90,
		120,
		180
	};
	texts[] = {
		$STR_A3_MissionDefault,
		10,
		15,
		20,
		30,
		45,
		60,
		90,
		120,
		180
	};
	GET_DEFAULT_PARAM(ReviveBleedOutDuration,120)
	function = "bis_fnc_paramReviveBleedOutDuration";
};

class ReviveForceRespawnDuration
{
	title = $STR_A3_ForceRespawnDuration;
	isGlobal = 1;

	values[] = {
		-100,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	};
	texts[] = {
		$STR_A3_MissionDefault,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	};
	GET_DEFAULT_PARAM(ReviveForceRespawnDuration,-100)
	function = "bis_fnc_paramReviveForceRespawnDuration";
};