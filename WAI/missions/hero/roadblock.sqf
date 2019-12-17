private ["_crate","_mission","_poss","_position","_roads","_num","_obj","_crate_type","_base1","_baserunover"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_poss = nearestLocations [getMarkerPos "center", ["NameCityCapital","NameCity"],(getMarkerSize "center") select 1];
_position = locationPosition (_poss call BIS_fnc_selectRandom);
while {!([_position] call wai_validSpotCheck)} do {
	sleep 2;
	_position = locationPosition (_poss call BIS_fnc_selectRandom);
};

// search road nearby
_roads = _position nearroads 200;
if (count _roads > 0) then {
	_position = getPos (_roads call BIS_fnc_selectRandom);
};

diag_log  format["WAI: [Mission:[Hero] Road Block]: Starting... %1",_position];

//Spawn Crates
[[
	[[2,2,6,4,2],crates_small,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Spawn Roadblocks
_num = 8 + round(random 4);
_obj = ["Land_HBarrier1_DZ","Land_HBarrier1_DZ","Hedgehog_DZ","Hedgehog_DZ","Mine"] call BIS_fnc_selectRandom;
for "_i" from 1 to _num do {
	_base1 = createVehicle [_obj, [(_position select 0)+5.5*cos(_i*360/_num), (_position select 1)+5.5*sin(_i*360/_num),-0.2],[], 0, "CAN_COLLIDE"];
	_base1 setVariable ["ObjectID", "1", true];
	_base1 setVariable ["ObjectUID", "1", true];
	((wai_mission_data select _mission) select 6) set [count ((wai_mission_data select _mission) select 6), _base1];
};
diag_log  format["WAI: Roadblock spawned %2 %1s",_obj,_num];

//Troops
[[_position select 0,_position select 1,0],6,"Easy",4,4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Road Block", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	false, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"There are rumors of bandits blocking a road. Keep your eyes open!", // mission announcement
	"The roadblock has been cleared!", // mission success
	"Bandits have left the road block." // mission fail
] call mission_winorfail;
