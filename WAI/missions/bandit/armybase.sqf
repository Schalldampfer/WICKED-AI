private ["_time","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [65] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] ARMY Base]: Starting... %1",_position];

//Spawn Crates
[[
	[[[6,ai_wep_special_cheap],0,[10,crate_items_sniper],[3,ai_wep_special_rare],2],crates_small,[1.2,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["WarfareBCamp",[-1,-12.4,-0.12]],
	["Base_WarfareBBarrier10xTall",[15,-16,-0.64]],
	["Base_WarfareBBarrier10xTall",[-15,-16,-0.64]],
	["Base_WarfareBBarrier10xTall",[15,16,-0.64]],
	["Base_WarfareBBarrier10xTall",[-15,16,-0.64]],
	["MAP_posed",[17,11]],
	["MAP_posed",[-20,11]],
	["MAP_fort_artillery_nest",[-1,-31,-0.56],-178.615],
	["MAP_Fortress_02",[-27,-13]],
	["MAP_Fortress_02",[25,-13],-89.16],
	["MAP_fortified_nest_big",[26,13],-180.55],
	["MAP_fortified_nest_big",[-26,13],-179.808],
	["MAP_Barbedwire",[10,-20]],
	["MAP_Barbedwire",[-11,-20]],
	["MAP_Barbedwire",[16,-20]],
	["MAP_Barbedwire",[-17,-20]],
	["WarfareBDepot",[-0.02,20,-0.1],-179.832],
	["T72Wreck",[29,-30],82.75],
	["T72WreckTurret",[20,-36]],
//	["MAP_T34",[2,5],-71.49],
	["Land_Fort_Watchtower_EP1",[26,-4],-180.097],
	["Land_Fort_Watchtower_EP1",[-28,-6],0.999],
	["Land_transport_crates_EP1",[-18,-9],52.43],
	["MAP_Barel4",[-16,-10]],
	["MAP_Barel1",[-16,-11]],
	["MAP_t_picea3f",[-8,-6]],
	["MAP_t_picea3f",[16,20]],
	["MAP_t_pinusS2f",[14,9]],
	["MAP_t_pinusS2f",[-3,-6],-99.19],
	["MAP_t_picea3f",[10,-13]],
	["MAP_t_pinusN2s",[14,-8]],
	["MAP_t_pinusN2s",[12,19],-73.36],
	["MAP_t_pinusN2s",[-21,-13],52.65],
	["MAP_t_pinusS2f",[-34,12]],
	["MAP_t_picea3f",[-13,21]],
	["MAP_t_picea2s",[-17,21]],
	["MAP_t_picea2s",[13,-12]],
	["MAP_t_picea1s",[30,-0.01]],
	["MAP_t_picea2s",[-47,-21]],
	["MAP_t_picea2s",[34,-48]],
	["MAP_t_pinusN2s",[31,-52]],
	["MAP_t_pinusS2f",[12,-5]],
	["Land_Fire_barrel_burning",[-0.01,-0.01]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = 2 + round (random 4);
[[(_position select 0) - 12, (_position select 1) +  2, 0],5,"extreme",["Random","M47Launcher_EP1"],4,"Random","CZ_Soldier_Sniper_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 12, (_position select 1) - 22, 0],5,"extreme",["Random","AT"],4,"Random","CZ_Soldier_Sniper_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) +  2, (_position select 1) +  2, 0],5,"extreme",["Random","AA"],4,"Random","CZ_Soldier_SL_DES_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 14, (_position select 1) - 35, 0],5,"extreme",["Random","Igla"],4,"Random","CZ_Soldier_SL_DES_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 35, 0],_rndnum,"extreme","KSVK_DZE", 6,"Random","CZ_Special_Forces_GL_DES_EP1_DZ","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) - 22, (_position select 1) + 56, 0],[(_position select 0) + 22, (_position select 1) - 56, 0],450,2,ai_antiair_vehicles call BIS_fnc_selectRandom,"extreme","CZ_Special_Forces_GL_DES_EP1_DZ","Hero",_mission] call vehicle_patrol;
[[(_position select 0) - 22, (_position select 1) - 56, 0],[(_position select 0) + 22, (_position select 1) + 56, 0],50,2,ai_armored_vehicles call BIS_fnc_selectRandom,"extreme","CZ_Soldier_Sniper_EP1_DZ","Hero",_mission] call vehicle_patrol;
 
//Static Guns
[[[(_position select 0) - 0.1, (_position select 1) + 41, 0],
  [(_position select 0) + 0.1, (_position select 1) - 25, 0]
],"ZU23_CDF","extreme","CZ_Soldier_SL_DES_EP1_DZ","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) - 41, (_position select 1) + 0.1, 0],
  [(_position select 0) + 41, (_position select 1) - 0.1, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"hard","CZ_Soldier_SL_DES_EP1_DZ","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[
  [(_position select 0) + 30, (_position select 1) - 20, 0]
],"Igla_AA_pod_TK_EP1","Extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Spawn Vehicle
([super_vehicles call BIS_fnc_selectRandom,[(_position select 0) + 2, (_position select 1) + 5, 0.0],_mission,true,-71.49] call custom_publish) setFuel 0.01;

[
	_mission, // Mission number
	_position, // Position of mission
	"extreme", // Difficulty
	"ARMY Base", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_ARMYBASE_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_ARMYBASE_WIN", // mission success
	"STR_CL_GENERAL_ARMYBASE_FAIL", // mission fail
	_time
] call mission_winorfail;