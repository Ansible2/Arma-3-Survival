if !(["OPTRE_Core"] call BLWK_fnc_isPatchLoaded) exitWith {};

[] spawn {
while {sleep 3; (!BLWK_dontUseRevive)} do {

_num = {_x == "OPTRE_MedKit"} count (items player);

if (_num > 0) then {
for "_i" from 1 to _num do {
player removeItem "OPTRE_MedKit";
player addItem "FirstAidKit"; 
};

};


  
};

};

//OPTRE_Biofoam