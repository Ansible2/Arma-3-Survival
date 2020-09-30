params ["_unit"];

_unit removeEventHandler ["handleDamage",BLWK_handleDamageEh_ID];
_unit removeEventHandler ["animStateChanged",BLWK_animStateChangedEh_ID];
BLWK_animStateChangedEh_ID = nil
BLWK_handleDamageEh_ID = nil;