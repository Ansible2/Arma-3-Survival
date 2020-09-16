_spawnObject = _this select 0;
_dir = _this select 1;
_objectPos = getPosASL _spawnObject vectorAdd [0,0,0.15];

_edges = [];

// CIPHER COMMENT: from what I can tell, they seem to think that this will somehow get 
for ("_i") from 0 to 3 do {
	_relPos = [_objectPos, 10, _dir + (90 * _i)] call BIS_fnc_relPos;
	_rayIntersect = lineIntersectsSurfaces [_objectPos, _relPos, _spawnObject, _spawnObject, true, 1, "GEOM", "NONE"];
	if (count _rayIntersect == 0) exitWith {};
	_hit = _rayIntersect select 0; // get the first postion of intersect (prsumably the house wall in that direction)
	_edge = _hit select 0; // get the position asl of that intersect point
	_edges append [_edge]; // pushBack (or append cuz you're daft)
}; 

if(count _edges < 4) exitWith {
    [false,[0,0,0],[0,0,0],[0,0,0],[0,0,0],0,0]
};

_top    = _edges select 0;
_right  = _edges select 1;
_bottom = _edges select 2;
_left   = _edges select 3;

_w = (_right select 0) - (_left select 0);
_h = (_top select 1) - (_bottom select 1);

[true, _top, _right, _bottom, _left, _w, _h];


/*
To do this properly:
1. use nearObjects to get the buildings from the location point.
	- BLWK_playAreaCenter nearObjects ["House", BLWK_playAreaRadius];
2. use findIf to just get the first building/room that meets the criteria
	- nearObjects is already a pseudo-random array so no need to go through EVERY BUILDING, create a list, and THEN selectRandom
3. This is clearly not volume of a room. to get that:
	- using lineIntersectsSurfaces...
	- Get a position 10m above and below the cfg buildingPos you are checking
	- Then get 4 sides or every 90 degrees
	- lastly, compare the intersect positions from the top & bottom, compare 0 & 180 sides, and 90 and 270 sides
	- The difference between these can be length * width * height = volume
*/