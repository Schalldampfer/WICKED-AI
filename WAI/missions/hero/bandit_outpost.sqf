private ["_time","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Bandit Outpost]: Starting... %1",_position];

// Spawn crates
[[
	[[6,4,[16,crate_ammo_cheap],2,1],crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_76n6_ClamShell",[-6,25],172],
	["MAP_budova4_in",[-29,18],0.24],
	["MAP_budova4_in",[-29,8],0.24],
	["MAP_Mil_Barracks_L",[-23,-13],-119],
	["MAP_CamoNetB_NATO",[1.6,0],-203],
	["MAP_fort_watchtower",[19,11],-185],
	["MAP_fort_watchtower",[4,-20],-103]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 2,_position select 1,0],5,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 2,_position select 1,0],_rndnum,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 20, (_position select 1) - 20, 0]
],(ai_static_gpmg call BIS_fnc_selectRandom),"Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Outpost", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_BANDITOUTPOST_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BANDITOUTPOST_WIN", // mission success
	"STR_CL_HERO_BANDITOUTPOST_FAIL", // mission fail
	_time
] call mission_winorfail;