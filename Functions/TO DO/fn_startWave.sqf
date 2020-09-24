// decide if special wave

// decide what AI should spawn

// start AI que loop

// spawn AI

// give AI the hit event handlers that add points

// inform pepople the round has started and what kind it is/number

//

if (!isServer) exitWith {};

call BLWK_fnc_spawnLoot;

BLWK_friendly_menClasses
BLWK_friendly_vehicleClasses
BLWK_level1_menClasses
BLWK_level1_vehicleClasses
BLWK_level2_menClasses
BLWK_level2_vehicleClasses
BLWK_level3_menClasses
BLWK_level3_vehicleClasses
BLWK_level4_menClasses
BLWK_level4_vehicleClasses
BLWK_level5_menClasses
BLWK_level5_vehicleClasses

/*
	VEHICLES:
		- any round with above 4 players can have 2 vehicles spawn but less, only one will spawn
		- Vehicles will be staggered by at least 120 seconds. So first 1 spawns then the 2nd
		- vehicles are seperated into light and heavy cars, and light and heavt armour
		- -	There will be max percentage changces that each of these will be able to spawn
		- - - These spawn rates will be affected by:
		- - - - player count
		- - - - how long its been since a vehicle spawned
		- - Use a weighted array to select what gets spawned
		- There will still be a param value to determine when vehicles can spawn
		- vehicles can not spawn 2 waves in a row
		- The percentage chance of ANY vehicle spawning will be affected by 
*/