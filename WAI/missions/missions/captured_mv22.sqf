private ["_mission","_position","_rndnum","_loot","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Captured MV22]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_CapturedMV22 select 0;} else {Loot_CapturedMV22 select 1;};

//Spawn Crates
[[
	[_loot,"UNBasicWeapons_EP1",[11.2,12.2,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["USMC_WarfareBFieldhHospital",[12.7,6.5],-210],
	["Barrack2",[16,-11],150],
	["Misc_cargo_cont_small",[2.8,17.4],12.5],
	["Barrack2",[9,-15],150],
	["Misc_cargo_cont_small",[6.7,18.3],12.5]
],_position,_mission] call wai_spawnObjects;

//Troops
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random","UN_CDF_Soldier_Guard_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 33,(_position select 1) -  7,0.1],5,"Hard",1,2,"Random","RU_Doctor","Random",[_aiType,100],_mission] call spawn_group;
[[(_position select 0) - 33,(_position select 1) - 18,0.1],5,"Hard",["Random","AA"],4,"Random","UN_CDF_Soldier_Guard_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) +  1,(_position select 1) + 29,0.1],5,"Hard",["Random","RPG7V"],4,"Random","UN_CDF_Soldier_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) +  1,(_position select 1) + 29,0.1],5,"Hard",2,5,"Random","UN_CDF_Soldier_EP1_DZ","Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 0.1, (_position select 1) + 20, 0],[(_position select 0) + 0.1, (_position select 1) - 20, 0],50,2,armed_vehicle call BIS_fnc_selectRandom,"Hard","UN_CDF_Soldier_EP1_DZ",_aiType,_mission] call vehicle_patrol;

//Static Guns
_uG1=[[
	[(_position select 0) - 9.3, (_position select 1) + 11.2, 0],
	[(_position select 0) - 6, (_position select 1) - 21.4, 0]
],ai_static_weapons call BIS_fnc_selectRandom,"Hard","UN_CDF_Soldier_Guard_EP1_DZ",_aiType,0,2,"Random","Random",_mission] call spawn_static;
_uG2=[[
	[(_position select 0) + 19, (_position select 1) + 10, 0]
],"Igla_AA_pod_TK_EP1","Hard","UN_CDF_Soldier_Guard_EP1_DZ",_aiType,0,2,"Random","Random",_mission] call spawn_static;
(units _uG2) joinSilent _uG1;

//Spawn vehicles
["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [%2] captured_mv22 spawned a MV22 at %1", _position,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_MV22_ANNOUNCE","STR_CL_HERO_MV22_WIN","STR_CL_HERO_MV22_FAIL"];
} else {
	["STR_CL_BANDIT_MV22_ANNOUNCE","STR_CL_BANDIT_MV22_WIN","STR_CL_BANDIT_MV22_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Captured MV22", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
