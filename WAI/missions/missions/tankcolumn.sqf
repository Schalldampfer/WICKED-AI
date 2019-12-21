private ["_rndnum","_mission","_position","_aiType","_messages","_missionType","_loot","_loot2"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Tank Column]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_TankColumn1 select 0;} else {Loot_TankColumn1 select 1;};
_loot2 = if (_missionType == "MainHero") then {Loot_TankColumn2 select 0;} else {Loot_TankColumn2 select 1;};

//Spawn Crates
[[
	[_loot,crates_large,[.02,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	//["MAP_T34",[2.2,-12],91.28],
	["MAP_T34",[12.2,-12],92.01],
	["MAP_T34",[21,-13],108.4],
	["MAP_T34",[29,-16],112.3],
	["GUE_WarfareBVehicleServicePoint",[10,-19]],
	["MAP_Hlidac_budka",[10,-7]],
	["Land_tent_east",[-0.3,0.3],90],
	["MAP_t_picea2s",[-3,12]],
	["MAP_t_pinusN1s",[-12,3]],
	["MAP_t_pinusN2s",[-10,13,-0.02]],
	["MAP_t_acer2s",[9,2]],
	["Land_Fire_barrel_burning",[-9,-1]]
],_position,_mission] call wai_spawnObjects;

// Spawn Vehicle
[_loot2,[(_position select 0) +2.2, (_position select 1) -12],_mission,true,91.28] call custom_publish;

//Troops
[[(_position select 0) - 7, (_position select 1) - 10, 0],5,"Extreme","KSVK_DZE",6,"Random","UN_CDF_Soldier_Guard_EP1","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 16, (_position select 1) - 5, 0],5,"Extreme",[1,"M47Launcher_EP1"],4,"Random","UN_CDF_Soldier_Guard_EP1","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"Extreme",[2,"Javelin"],4,"Random","UN_CDF_Soldier_Guard_EP1","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"Extreme",[2,"AA"],4,"Random","UN_CDF_Soldier_Guard_EP1","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"Extreme",[1,"Igla"],4,"Random","UN_CDF_Soldier_Guard_EP1","Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],500,3,ai_armored_vehicles call BIS_fnc_selectRandom,"Extreme","UN_CDF_Soldier_EP1_DZ",_aiType,_mission] call vehicle_patrol;
[[(_position select 0) - 22, (_position select 1) - 32, 0],[(_position select 0) - 15, (_position select 1) + 33, 0],500,3,ai_antiair_vehicles call BIS_fnc_selectRandom,"Extreme","UN_CDF_Soldier_EP1_DZ",_aiType,_mission] call vehicle_patrol;

//Static Guns
[[
	[(_position select 0) + 8, (_position select 1) - 29, 0],
	[(_position select 0) + 12, (_position select 1) + 24, 0]
],"ZU23_CDF","Extreme",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;
[[
	[(_position select 0) - 8, (_position select 1) + 29, 0],
	[(_position select 0) - 12, (_position select 1) - 24, 0]
],ai_static_weapons call BIS_fnc_selectRandom,"Extreme",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;
[[
	[(_position select 0) + 25, (_position select 1) - 25, 0]
],"Igla_AA_pod_TK_EP1","Extreme",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_TANK_ANNOUNCE","STR_CL_HERO_TANK_WIN","STR_CL_HERO_TANK_FAIL"];
} else {
	["STR_CL_BANDIT_TANK_ANNOUNCE","STR_CL_BANDIT_TANK_WIN","STR_CL_BANDIT_TANK_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Extreme", // Difficulty
	"Tank Column", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
