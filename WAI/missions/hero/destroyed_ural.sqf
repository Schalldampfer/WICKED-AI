private ["_time","_mission","_position","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [10] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Ural Attack]: Starting... %1",_position];

//Spawn Crates
[[
	[[0,6,6,0,2],crates_medium,[-5,-5]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Body",[-2.2905,-3.3438],61.798588],
	["Body",[-2.8511,-2.4346],52.402905],
	["Body",[-3.435,-1.4297],-117.27345],
	["Body2",[-4.0337,0.5],23.664057]
],_position,_mission] call wai_spawnObjects;

//Spawn Vehicle
[["Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","UralCivil_DZE","UralCivil2_DZE"] call BIS_fnc_selectRandom,_position,_mission] call custom_publish;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0), (_position select 1) + 20, 0],[(_position select 0), (_position select 1) - 20, 0],50,2,pk_vehicle call BIS_fnc_selectRandom,"Easy","Bandit","Bandit",_mission] call vehicle_patrol;

//Condition
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Ural Attack", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_URAL_ANNOUNCE",	// mission announcement
	"STR_CL_HERO_URAL_WIN", // mission success
	"STR_CL_HERO_URAL_FAIL", // mission fail
	_time
] call mission_winorfail;