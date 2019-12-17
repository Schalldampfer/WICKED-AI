private ["_time","_mission","_position","_loot","_rndnum"];

_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: Mission:[Bandit] Lumber Mill started at %1",_position];

// Loot
_loot = [[3,crate_weapons_buildables],[3,crate_tools_buildable],[20,crate_items_wood],0,[2,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_large,[5,7]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Ind_SawMill",[-2.4,24]],
	["Land_Ind_Timbers",[11,8.6,-.1]],
	["Land_Ind_Timbers",[16,12,-.1],-10.45],
	["Land_Ind_Timbers",[6,-15],104.95],
	["Misc_palletsfoiled",[5,-9,-0.009]],
	["Misc_palletsfoiled_heap",[9,-8,-0.05]],
	["Land_water_tank",[-10,-7]],
//	["UralWreck",[-17,5],59.2],
	["MAP_t_quercus3s",[22,25,-0.2]]
],_position,_mission] call wai_spawnObjects;

// Troops
_rndnum = round (random 5);
[[(_position select 0) + 12, (_position select 1) + 22.5, 0],5,"hard",["random","at"],3,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 11, 0],5,"hard",["random","at"],3,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) - 1.12, (_position select 1) - 0.43, 0],5,"Hard",["random","aa"],3,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) - 23, 0],_rndnum,"Hard",2,3,"random","Hero","random","Hero",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) + 30, (_position select 1) + 40, 0],
  [(_position select 0) - 30, (_position select 1) - 10, 0],
  [(_position select 0) - 20, (_position select 1) + 30, 0],
  [(_position select 0) + 20, (_position select 1) - 20, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 17, _position select 1, 0],250,2,(armed_vehicle call BIS_fnc_selectRandom),"Hard","Hero","Hero",_mission] call vehicle_patrol;

[cargo_trucks,[(_position select 0) - 17,(_position select 1) + 5],_mission,true,59.2] call custom_publish;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lumber Mill", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_LUMBERMILL_ANNOUNCE",	// mission announcement
	"STR_CL_BANDIT_LUMBERMILL_WIN",	// mission success
	"STR_CL_BANDIT_LUMBERMILL_FAIL", // mission fail
	_time
] call mission_winorfail;