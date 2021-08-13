/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addSurvivalDiaryEntry

Description:
	Used as a unified point of adding diary entries under the Survival subject.

Parameters:
	0: _textEntry <STRING or ARRAY> - The text entry in createDiaryRecord.
	1: _showTitle <BOOL> - Whether or not to show title in the description section as well

Returns:
	DIARY RECORD

Examples:
    (begin example)
		[["test title","test text"]] call BLWK_fnc_addSurvivalDiaryEntry;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_addSurvivalDiaryEntry";

#define DIARY_SUBJECT "Survival"

if !(hasInterface) exitWith {};

if !(player diarySubjectExists DIARY_SUBJECT) then {
	player createDiarySubject [DIARY_SUBJECT, DIARY_SUBJECT];
};

params [
	["_textEntry","",["",[]]],
	["_showTitle",true,[true]]
];

player createDiaryRecord [DIARY_SUBJECT,_textEntry,taskNull,"",_showTitle];
