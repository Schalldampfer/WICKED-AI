private ["_time","_vehicle","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [50] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Construction Site]: Starting... %1",_position];

// Loot
_loot = [[1,crate_weapons_buildables],[2,crate_tools_buildable],[20,crate_items_buildables+crate_items_wood],0,2];

// Spawn crates
[[
	[_loot,crates_medium,[7.6,10.3,0.50]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_A_BuildingWIP",[-2,1,.04],-30],
	["Land_Ind_Workshop01_01",[-27,-15],-31.6],
	["Land_Ind_Workshop01_03",[9,38],-72],
	["Land_Misc_Cargo1Ao",[31,20],99.8],
	["Land_Misc_Cargo1B",[-36,2]],
	["Land_Ind_TankSmall",[18,21],59],
	["Land_Ind_TankBig",[37,-7]],
	["Land_Ind_TankBig",[-13,-35]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 21,(_position select 1) + 32,0],5,"Medium",["Random","RPG7V"],2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 56,(_position select 1) + 27,0],4,"Medium",["Random","RPG7V"],2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 27,(_position select 1) - 52,0],5,"Medium","Random",2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 41,(_position select 1) - 20,0],6,"Medium","Random",2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 42.57,(_position select 1) - 4.7, 10],
	[(_position select 0) - 16.45,(_position select 1) - 38.5, 10],
	[(_position select 0) + 2.05,(_position select 1) + 16, 12.3]
],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Construction Site", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_DZMS_CONST_START", // mission announcement
	"STR_CL_DZMS_CONST_WIN", // mission success
	"STR_CL_DZMS_CONST_FAIL", // mission fail
	_time
] call mission_winorfail;
