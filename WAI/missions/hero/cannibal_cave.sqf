private ["_time","_mission","_position","_rndnum","_loot"];

_mission = count wai_mission_data -1;

_position = [80] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: Mission:[Hero] Cannibal started at %1",_position];

// Loot
_loot = [[8,ai_wep_special_cheap],0,[2,crate_items_gems],[3,ai_wep_special_good],[4,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_large,[5,7]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_R2_RockWall",[10,28,-4.15]],
	["MAP_R2_RockWall",[-23,9,-6.55],-96.315],
	["MAP_R2_RockWall",[25,4,-7.74],262.32],
	["MAP_R2_RockWall",[1,7,10.81],-29.29],
	["MAP_R2_RockWall",[18,-11,-5.509],-222.72],
	["MAP_R2_RockWall",[-22,6,-11.55],-44.01],
	["MAP_t_picea2s",[-13,-32,-0.1]],
	["MAP_t_picea2s",[-17,6,-0.2]],
	["MAP_t_pinusN2s",[-24,-53,-0.2]],
	["MAP_t_pinusN1s",[-22,-42,-0.2]],
	["MAP_t_picea1s",[-22.3,-35,-0.2]],
	["MAP_t_picea2s",[-33,-53,-0.2]],
	["MAP_t_picea2s",[-3,-43,-0.2]],
	["MAP_t_picea2s",[28,-39,-0.2]],
	["MAP_t_picea2s",[13,43,-0.2]],
	["MAP_t_picea1s",[57,11,-0.2]],
	["MAP_t_quercus3s",[31,49.3,-0.2]],
	["MAP_t_quercus3s",[-47,20,-0.2]],
	["MAP_R2_Rock1",[-47,-45,-14.29]],
	["Land_Campfire_burning",[-0.01,-0.01]],
	["Mass_grave_DZ",[-6,-7,-0.02],-50.94],
	["SKODAWreck",[-11,-46],151.15],
//	["UralWreck",[-41.3,-26],19.15]
	["datsun01Wreck",[-2,-60],34.54]
],_position,_mission] call wai_spawnObjects;

//Spawn Vehicle
[civil_vehicles call BIS_fnc_selectRandom,[(_position select 0) - 41.3, (_position select 1) - 26,-0.02],_mission,true,19.15] call custom_publish;

//Static Guns
[[[(_position select 0) - 50, (_position select 1) + 40, 0],
  [(_position select 0) + 20, (_position select 1) - 50, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Easy","TK_Special_Forces_MG_EP1_DZ","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 12, (_position select 1) + 42.5, 0],5,"Medium","Random",3,"random","TK_Soldier_Sniper_EP1_DZ","random",["bandit",150],_mission] call spawn_group;
[[(_position select 0) + 11, (_position select 1) + 41, 0],5,"Medium",["Random","RPG7V"],3,"random","TK_INS_Soldier_EP1_DZ","random","bandit",_mission] call spawn_group;
[[(_position select 0) - 12, (_position select 1) - 43, 0],5,"Medium",["Random","RPG7V"],3,"random","TK_GUE_Soldier_EP1_DZ","random","bandit",_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) - 43, 0],_rndnum,"Medium","Random",3,"random","TK_INS_Soldier_AR_EP1_DZ","random","bandit",_mission] call spawn_group;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Cannibal Cave", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_CANNIBALCAVE_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_CANNIBALCAVE_WIN", // mission success
	"STR_CL_GENERAL_CANNIBALCAVE_FAIL", // mission fail
	_time
] call mission_winorfail;
