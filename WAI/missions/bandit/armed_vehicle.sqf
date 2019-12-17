private ["_time","_mission","_rndnum","_vehname","_position","_vehclass","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = improved_vehicles call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [25] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Armed Vehicle]: Starting... %1",_position];

// Loot
_loot = [0,0,[15,crate_items_chainbullets],0,0];

//Spawn Crates
[[
	[_loot,crates_small,[0,5]]
],_position,_mission] call wai_spawnCrate;

//Troops
_rndnum = 3 + round (random 4);
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",["Random","AA"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",["Random","AA"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"extreme","KSVK_DZE",6,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) - 22, (_position select 1) - 56, 0],[(_position select 0) + 22, (_position select 1) + 56, 0],500,2,spg9_vehicles call BIS_fnc_selectRandom,"extreme","Hero","Hero",_mission] call vehicle_patrol;


//Static Guns
[[[(_position select 0) - 10, (_position select 1) + 10, 0],
  [(_position select 0) + 10, (_position select 1) - 10, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) + 10, (_position select 1) + 10, 0],
  [(_position select 0) - 10, (_position select 1) - 10, 0]
],"Igla_AA_pod_TK_EP1","Extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicles
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] armed_vehicle spawned a %1",_vehname];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	format["Captured %1",_vehname], // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_ARMEDVEHICLE_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_ARMEDVEHICLE_WIN", // mission success
	"STR_CL_BANDIT_ARMEDVEHICLE_FAIL", // mission fail
	_time
] call mission_winorfail;
