private ["_time","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [20] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Black Hawk Crash]: Starting... %1",_position];

//Spawn Crates
[[
	[[5,5,10,3,2],crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Body",[3.2905,2.3438],61.798588],
	["Body",[3.8511,3.4346],52.402905],
	["Body",[2.435,4.4297],-117.27345],
	["Body2",[1.0337,5.5],23.664057]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) - 20, (_position select 1) - 20, 0]
],(ai_static_gpmg call BIS_fnc_selectRandom),"Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Static Guns
[[
	[(_position select 0) +5, (_position select 1) +5]
],(["UH1Wreck","UH60_wreck_EP1"] call BIS_fnc_selectRandom),"Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Black Hawk Crash", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_BHCRASH_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BHCRASH_WIN", // mission success
	"STR_CL_HERO_BHCRASH_FAIL", // mission fail
	_time
] call mission_winorfail;