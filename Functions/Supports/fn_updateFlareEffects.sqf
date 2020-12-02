if (!hasInterface) exitWith {};

params ["_light","_flare"];

if (isNull _flare) exitWith {};

_light setLightColor [1, 1, 1];
_light setLightAmbient [1, 1, 1];
_light setLightIntensity 100000;
_light setLightUseFlare true;
_light setLightFlareSize 10;
_light setLightFlareMaxDistance 600;
_light setLightDayLight true;
_light setLightAttenuation [4, 0, 0, 0.2, 1000, 2000];