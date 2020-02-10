private ["_mission","_position","_loot","_rndnum","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: Mission:[%2] Lumber Mill started at %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_LumberJack select 0;} else {Loot_LumberJack select 1;};

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
	//["UralWreck",[-17,5],59.2],
	["MAP_t_quercus3s",[22,25,-0.2]]
],_position,_mission] call wai_spawnObjects;

[cargo_trucks,[(_position select 0) - 17,(_position select 1) + 5],_mission,true,59.2] call custom_publish;

// Troops
[[(_position select 0) + 12, (_position select 1) + 22, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 11, 0],5,"Hard",["Random","AA"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) -  1, (_position select 1) -  1, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) - 23, 0],5,"Hard",1,2,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) - 23, 0],5,"Hard",2,5,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[[(_position select 0) + 30, (_position select 1) + 40, 0],
  [(_position select 0) - 30, (_position select 1) - 10, 0],
  [(_position select 0) - 20, (_position select 1) + 30, 0],
  [(_position select 0) + 20, (_position select 1) - 20, 0]
],ai_static_weapons call BIS_fnc_selectRandom,"Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_LUMBER_ANNOUNCE","STR_CL_HERO_LUMBER_WIN","STR_CL_HERO_LUMBER_FAIL"];
} else {
	["STR_CL_BANDIT_LUMBERMILL_ANNOUNCE","STR_CL_BANDIT_LUMBERMILL_WIN","STR_CL_BANDIT_LUMBERMILL_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lumber Mill", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;