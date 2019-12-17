private ["_time","_mission","_position","_crate","_rndnum","_baserunover"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Weapon Cache]: Starting... %1",_position];

[[
	[[[6,ai_wep_special_cheap + ai_wep_special_good],0,[14,crate_ammo_cheap],[1,ai_launcher_special_cheap + ai_wep_special_rare],2],crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_fortified_nest_big_EP1",[-14,23.5],-210],
	["Land_fortified_nest_big_EP1",[12,-24,-0.01],-390],
	["Land_HBarrier_large",[-18,1,-0.3],90],
	["Land_HBarrier_large",[-8,-16,-0.3],30],
	["Land_HBarrier_large",[18,-1.5,-0.3],90],
	["Land_HBarrier_large",[7,16,-0.3],30],
	["DesertLargeCamoNet_DZ",[-1,0],-26]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = ceil(random 5);
[[(_position select 0) - 8,(_position select 1) + 14,0],5,"Easy",0,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 21,(_position select 1) - 12.5,0],_rndnum,"Easy",0,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 20, (_position select 1) + 20, 0]
],(ai_static_gpmg call BIS_fnc_selectRandom),"Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Weapon Cache", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_WEAPONCACHE_ANNOUNCE", // mission announcement
	"STR_CL_HERO_WEAPONCACHE_WIN", // mission success
	"STR_CL_HERO_WEAPONCACHE_FAIL", // mission fail
	_time
] call mission_winorfail;