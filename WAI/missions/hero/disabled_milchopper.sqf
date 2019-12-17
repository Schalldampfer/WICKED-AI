private ["_time","_rndnum","_mission","_vehname","_vehicle","_position","_vehclass","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Military Chopper
_vehclass = armed_chopper call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [20] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Disabled Military Chopper]: Starting... %1",_position];

// Loot
_loot = [[5,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2];

//Spawn Crates
[[
	[_loot,crates_medium,[0,10]]
],_position,_mission] call wai_spawnCrate;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",[2,"RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium",[2,"RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium",1,3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 30, (_position select 1) - 30, 0],
	[(_position select 0) + 30, (_position select 1) + 30, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicle
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] disabled_milchopper spawned a %1",_vehname];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Disabled %1", _vehname], // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_MILCHOPPER_ANNOUNCE", // mission announcement
	"STR_CL_HERO_MILCHOPPER_WIN", // mission success
	"STR_CL_HERO_MILCHOPPER_FAIL", // mission fail
	_time
] call mission_winorfail;
