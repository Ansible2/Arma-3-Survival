/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addKiskaDiaryEntry

Description:
	Used as a unified point of adding diary entries for KISKA.

Parameters:
	0: _textEntry <STRING or ARRAY> - The text entry in createDiaryRecord.
		If array, format is [title,description].
	1: _task <TASK> - A task attached to the diary record
	2: _taskState <STRING> - The state of the task
	3: _showTitle <BOOL> - Whether or not to show title in the description section as well

Returns:
	DIARY RECORD

Examples:
    (begin example)
		[["test title","test text"]] call KISKA_fnc_addKiskaDiaryEntry;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
#define KISKA_DIARY "KISKA Systems"
scriptName "KISKA_fnc_addKiskaDiaryEntry";

if !(hasInterface) exitWith {diaryRecordNull};

if !(player diarySubjectExists KISKA_DIARY) then {
	player createDiarySubject [KISKA_DIARY, KISKA_DIARY];
};

params [
	["_textEntry","",["",[]]],
	["_task",taskNull,[taskNull]],
	["_taskState","",[""]],
	["_showTitle",true,[true]]
];

player createDiaryRecord [KISKA_DIARY,_textEntry,_task,_taskState,_showTitle];
