private ["_time","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Tank Column]: Starting... %1",_position];

//Spawn Crates
[[
	[
		[[6,ai_wep_special_cheap],0,[10,crate_items_chainbullets],[3,ai_wep_special_rare],2]
	,crates_large,[.02,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_T34",[2.2,-12],91.28],
	["MAP_T34",[12.2,-12],92.01],
	["MAP_T34",[21,-13],108.4],
	["MAP_T34",[29,-16],112.3],
	["GUE_WarfareBVehicleServicePoint",[10,-19]],
	["MAP_Hlidac_budka",[10,-7]],
	["Land_tent_east",[-0.3,0.3],90],
	["MAP_t_picea2s",[-3,12]],
	["MAP_t_pinusN1s",[-12,3]],
	["MAP_t_pinusN2s",[-10,13,-0.02]],
	["MAP_t_acer2s",[9,2]],
	["Land_Fire_barrel_burning",[-9,-1]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 20, (_position select 1) + 40, 0],3,"extreme","KSVK_DZE",6,"Random","UN_CDF_Soldier_Guard_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 7, (_position select 1) - 10, 0],5,"extreme",[1,"M47Launcher_EP1"],4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 16, (_position select 1) - 5, 0],5,"extreme",[2,"Javelin"],4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"extreme",[2,"AA"],4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"extreme",[1,"Igla"],4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],300,2,ai_armored_vehicles  call BIS_fnc_selectRandom,"Hard","UN_CDF_Soldier_EP1_DZ","Hero",_mission] call vehicle_patrol;
[[(_position select 0) - 22, (_position select 1) - 32, 0],[(_position select 0) - 15, (_position select 1) + 33, 0],600,2,ai_antiair_vehicles call BIS_fnc_selectRandom,"Hard","UN_CDF_Soldier_EP1_DZ","Hero",_mission] call vehicle_patrol;
 
//Static Guns
[[[(_position select 0) + 8, (_position select 1) - 29, 0],
  [(_position select 0) + 12, (_position select 1) + 24, 0]
],"ZU23_CDF","extreme","UN_CDF_Soldier_EP1_DZ","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[
  [(_position select 0) + 25, (_position select 1) - 25, 0]
],"Igla_AA_pod_TK_EP1","Extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

_vehicle = [super_vehicles call BIS_fnc_selectRandom,[(_position select 0) + 41, (_position select 1) - 25,-0.0],_mission,true,112.3] call custom_publish;
_vehicle setFuel 0.01;

[
	_mission, // Mission number
	_position, // Position of mission
	"extreme", // Difficulty
	"Tank Column", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_TANK_ANNOUNCE",	// mission announcement
	"STR_CL_BANDIT_TANK_WIN", // mission success
	"STR_CL_BANDIT_TANK_FAIL", // mission fail
	_time
] call mission_winorfail;