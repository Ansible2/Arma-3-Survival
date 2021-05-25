/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addOpenShopAction

Description:
	Adds an action to the passed object that allows it to open the shop.

Parameters:
	0: _object : <OBJECT> - The object to add the action to

Returns:
	<NUMBER> - The Action ID number

Examples:
    (begin example)
		_actionId = [anObject] call BLWK_fnc_addOpenShopAction;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_addOpenShopAction";

if (!hasInterface) exitWith {
	-1
};

params ["_object"];

if (isNull _object) exitWith {
	["_object was null, will not add action, exiting...",true] call KISKA_fnc_log;
	-1
};

private _id = _object addAction [ 
	"<t color='#00ff00'>-- Open Shop --</t>",  
	{
		call BLWK_fnc_openShop;
	}, 
	nil, 
	1000,  
	true,  
	false,  
	"", 
	"", 
	2.5 
];


_id