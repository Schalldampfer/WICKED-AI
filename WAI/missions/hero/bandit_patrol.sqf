private ["_time","_mission","_position","_rndnum","_vehclass"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [10] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Bandit Patrol]: Starting... %1",_position];

// Spawn crates
[[
	[[4,0,5,3,2],crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0), (_position select 1) + 20, 0],[(_position select 0), (_position select 1) - 20, 0],50,2,pk_vehicle call BIS_fnc_selectRandom,"Easy","Bandit","Bandit",_mission] call vehicle_patrol;

//Spawn vehicle
_vehclass  = military_unarmed call BIS_fnc_selectRandom;
[_vehclass,_position,_mission] call custom_publish;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Patrol", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_BANDITPATROL_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BANDITPATROL_WIN", // mission success
	"STR_CL_HERO_BANDITPATROL_FAIL", // mission fail
	_time
] call mission_winorfail;
