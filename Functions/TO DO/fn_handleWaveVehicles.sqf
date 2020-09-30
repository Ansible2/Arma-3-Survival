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


if (!local BLWK_theAIHandler) exitWith {};

#define BASE_LIKELIHOOD_HEAVY_ARMOUR 0.10
#define BASE_LIKELIHOOD_LIGHT_ARMOUR 0.15
#define BASE_LIKELIHOOD_HEAVY_CAR 0.25
#define BASE_LIKELIHOOD_LIGHT_CAR 0.50

#define BASE_VEHICLE_SPAWN_LIKELIHOOD 0.20
#define VEHICLE_SPAWN_INCRIMENT 0.05
#define ROUNDS_SINCE_MINUS_TWO(TOTAL_ROUNDS_SINCE) TOTAL_ROUNDS_SINCE - 2 

// CIPHER COMMENT: check for max wave upon end wave (the ting that will end the mission)


if (BLWK_currentWaveNumber >= BLWK_vehicleStartWave) then {

	private _roundsSinceVehicleSpawned = missionNamespace getVariable ["BLWK_roundsSinceVehicleSpawned",2];

	// wait until it has been at least two rounds since a vehicle spawn to get another one
	if (_roundsSinceVehicleSpawned >= 2) then {
		
		// only the rounds after the two will contribute to the LIKELIHOOD percentage (5% per round)
		private _howLikelyIsAVehicleToSpawn = (ROUNDS_SINCE_MINUS_TWO(_roundsSinceVehicleSpawned) * VEHICLE_SPAWN_INCRIMENT) + BASE_VEHICLE_SPAWN_LIKELIHOOD;
		private _howLikelyIsAVheicleNOTToSpawn = 1 - _howLikelyIsAVehicleToSpawn;
		
		private _vehcileWillSpawn = selectRandomWeighted [true,_howLikelyIsAVehicleToSpawn,false,1 - _howLikelyIsAVehicleToSpawn];
		if (_vehicleWillSpawn) then {
			missionNamespace setVariable ["BLWK_roundsSinceVehicleSpawned",0];
			/*
				just use base likelihoods in a weighted array to get the type
				they will never change

				also, check see what vehicles are available from the current levels to determine
				what can actually be chosen.
				Do a pushBack of the probability into an array if the vehicle type is available

				Maybe ALL available levels should be used in the array of chances, not just the highest
				level currently. Could also do a mini random check between all of the available types between
				each level and then do one check between the winners of each type
			*/
			private _likelihoodItsHeavyArmour = BASE_LIKELIHOOD_HEAVY_ARMOUR;
			private _likelihoodItsLightArmour = BASE_LIKELIHOOD_LIGHT_ARMOUR;
			private _likelihoodItsHeavyCar = BASE_LIKELIHOOD_HEAVY_CAR;
			private _likelihoodItsLightCar = BASE_LIKELIHOOD_LIGHT_CAR;
			


		};
	};
};