/**
*  spin/animateWeapon
*
*  Raises and lowers the weapon holder for the loot box
*
*  Domain: Server
**/

#define SLEEP_TIME 0.03
#define NUMBER_OF_FRAMES 30

params ["_loweringWeapon","_boxPosition","_weaponToSpawn"];

// ultimately, we want the weapon to travel 1m in height (up or down) after all the "frames" are done
// so we get how much we would need to incriment each step for that to be the case
private _incriment = 1/NUMBER_OF_FRAMES;
if (_loweringWeapon) then {
    _incriment = -(_incriment);
};

for "_i" from 1 to NUMBER_OF_FRAMES do {
    _spawnedWeapon setPosWorld (_boxPosition vectorAdd [0,0,_incriment]);
    
    sleep SLEEP_TIME;
};