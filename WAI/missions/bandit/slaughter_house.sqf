private ["_time","_rndnum","_mission","_position","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Slaughter House]: Starting... %1",_position];

// Loot
_loot = [[1,crate_weapons_buildables],0,[20,crate_items_food+crate_items_chainbullets],0,[2,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_medium,[2.5,0,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_aif_tovarna1",[-0.01,-0.01,-0.02]],
	["Land_stand_meat_EP1",[-4,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[0.001,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-1,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[4,2,-0.02],0.3693],
	["Mass_grave_DZ",[-3,20,-0.02]],
	["Mass_grave_DZ",[4,18,-0.02]],
	["Mass_grave_DZ",[0,-15,-0.02]],
	["Axe_woodblock",[-4,-14,-0.02],-25],
	["Land_Table_EP1",[2,-2,-0.02]],
	["MAP_icebox",[-2,-0.01,-0.02]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Hard",["Random","AA"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],_rndnum,"Hard",2,3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],50,2,(armed_vehicle call BIS_fnc_selectRandom),"Hard","Hero","Hero",_mission] call vehicle_patrol;

//Static Guns
[[[(_position select 0) - 32, (_position select 1) - 18, 0],
  [(_position select 0) + 12, (_position select 1) + 40, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Slaughter House", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_SLAUGHTERHOUSE_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_SLAUGHTERHOUSE_WIN", // mission success
	"STR_CL_GENERAL_SLAUGHTERHOUSE_FAIL", // mission fail
	_time
] call mission_winorfail;