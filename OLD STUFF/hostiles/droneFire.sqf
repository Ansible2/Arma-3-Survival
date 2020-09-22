_curWave = BLWK_currentWaveNumber;

waitUntil {waveSpawned};

while {_curWave == BLWK_currentWaveNumber} do {
  _drone = leader selectRandom droneSquad;
  if (alive _drone) then {
    _drone fireAtTarget [bulwarkBox];
    sleep 30;
  }else{
    sleep 0.5;
  };
};
