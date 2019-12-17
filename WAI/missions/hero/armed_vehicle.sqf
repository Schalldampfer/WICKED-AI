private ["_time","_mission","_rndnum","_vehname","_position","_vehclass","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [10] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Armed Vehicle]: Starting... %1",_position];

// Loot
_loot = [0,0,[12,crate_items_chainbullets],0,2];

//Spawn Crates
[[
	[_loot,crates_small,[0,5]]
],_position,_mission] call wai_spawnCrate;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0),(_position select 1) + 10, 0],[(_position select 0) + 0.1, (_position select 1) + 20, 0],50,2,armed_vehicle call BIS_fnc_selectRandom,"Medium","Bandit","Bandit",_mission] call vehicle_patrol;

//Spawn Vehicle
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] armed_vehicle spawned a %1",_vehname];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Disabled %1",_vehname], // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_ARMEDVEHICLE_ANNOUNCE",	// mission announcement
	"STR_CL_HERO_ARMEDVEHICLE_WIN", // mission success
	"STR_CL_HERO_ARMEDVEHICLE_FAIL", // mission fail
	_time
] call mission_winorfail;
