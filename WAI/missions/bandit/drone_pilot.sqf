private ["_time","_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Drone Pilot]: Starting... %1",_position];

// Loot
_loot = [0,[8,crate_tools_sniper],[3,crate_items_high_value],4,[2,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_large,[2,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
//	[(["Ka137_MG_PMC","Ka137_PMC","Pchela1T","Chukar","MQ9PredatorB","AH6X_EP1"] call BIS_fnc_selectRandom),[11,-28]],
	[(["CDF_WarfareBUAVterminal","TK_GUE_WarfareBUAVterminal_EP1","INS_WarfareBUAVterminal","GUE_WarfareBUAVterminal","RU_WarfareBUAVterminal"] call BIS_fnc_selectRandom),[-6,-15],-153.81],
	["Land_budova4_in",[-13,3.5]],
	["Land_Vysilac_FM",[-10,-7]],
	["MAP_runway_poj_draha",[10,5]],
	["ClutterCutter_EP1",[10,36]],
	["ClutterCutter_EP1",[10,30]],
	["ClutterCutter_EP1",[10,24]],
	["ClutterCutter_EP1",[10,18]],
	["ClutterCutter_EP1",[10,12]],
	["ClutterCutter_EP1",[10,6]],
	["ClutterCutter_EP1",[10,0.1]],
	["ClutterCutter_EP1",[10,-6]],
	["ClutterCutter_EP1",[10,-12]],
	["ClutterCutter_EP1",[10,-18]],
	["ClutterCutter_EP1",[10,-24]],
	["ClutterCutter_EP1",[-4,-5]]
],_position,_mission] call wai_spawnObjects;

//Group Spawning
_rndnum = round (random 5);
[[(_position select 0) + 17, (_position select 1) - 18, 0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 11, (_position select 1) + 9, 0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 15, (_position select 1) - 15, 0],5,"Hard",["Random","AT"],3,"Random","Bandit","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 2, (_position select 1) + 18, 0],_rndnum,"extreme",[2,"AA"],3,"Random","USMC_Soldier_Pilot_DZ","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 55, _position select 1, 0],[(_position select 0) + 17, _position select 1, 0],50,2,"HMMWV_Avenger","Hard","Hero","Hero",_mission] call vehicle_patrol;

//Static Guns
[[[(_position select 0) - 7, (_position select 1) + 19, 0]],"Rbs70_ACR","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) - 41, (_position select 1) + 0.1, 0]],"SearchLight_CDF","extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Patrol Drone
[_position,200,4,"Ka137_MG_PMC","Hard","Random","Hero",_mission] call heli_patrol;

//Spawn vehicles
[["Ka137_MG_PMC","Ka137_PMC","Pchela1T","Pchela1T_CDF","AH6X_DZ","MQ9PredatorB"],[(_position select 0) + 11, (_position select 1) - 28, 0],_mission] call custom_publish;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Drone Pilot", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_DRONEPILOT_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_DRONEPILOT_WIN", // mission success
	"STR_CL_BANDIT_DRONEPILOT_FAIL", // mission fail
	_time
] call mission_winorfail;
