private ["_time","_vehicle","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Stash House]: Starting... %1",_position];

// Loot
_loot = [2,2,6,4,1];

// Spawn crates
[[
	[_loot,crates_small,[0.7408,1.565,0.10033049]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_HouseV_1I4",[0,0],152.66766],
	["Land_kulna",[5.4585,-2.885],-28.282881]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 4.0796,(_position select 1) - 11.709,0],6,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 2.8872,(_position select 1) + 18.964,0],6,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) - 7.9,(_position select 1) + 13.78, 0],
	[(_position select 0) + 9.34,(_position select 1) - 14.17, 0]
],(ai_static_gpmg call BIS_fnc_selectRandom),"Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Stash House", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_DZMS_STASH_START", // mission announcement
	"STR_CL_DZMS_STASH_WIN", // mission success
	"STR_CL_DZMS_STASH_FAIL", // mission fail
	_time
] call mission_winorfail;
