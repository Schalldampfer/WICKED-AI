private ["_time","_rndnum","_mission","_vehname","_vehicle","_position","_vehclass","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Military Chopper
_vehclass = armed_chopper call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [30] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Sniper Extraction]: Starting... %1",_position];

// Loot
_loot = [[6,(ai_wep_sniper + ai_wep_special_good + ai_wep_special_cheap)],[4,crate_tools_sniper],[6,crate_items_sniper],0,2];

//Spawn Crates
[[
	[_loot,crates_medium,[0,10]]
],_position,_mission] call wai_spawnCrate;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Hard",[2,"AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[2,"AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard","KSVK_DZE",2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Hard",[2,"AA"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],450,4,spg9_vehicles call BIS_fnc_selectRandom,"Hard","Random","Hero",_mission] call vehicle_patrol;

//Static Guns
[[
	[(_position select 0) + 30, (_position select 1) - 30, 0],
	[(_position select 0) + 30, (_position select 1) + 30, 0],
	[(_position select 0) - 30, (_position select 1) - 30, 0],
	[(_position select 0) - 30, (_position select 1) + 30, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicle
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] sniper_extraction spawned a %1",_vehname];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	format["Sniper Extraction %1", _vehname], // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_EXTRACTION_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_EXTRACTION_WIN", // mission success
	"STR_CL_BANDIT_EXTRACTION_FAIL", // mission fail
	_time
] call mission_winorfail;
