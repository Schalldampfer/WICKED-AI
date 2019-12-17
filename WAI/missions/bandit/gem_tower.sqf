private ["_time","_mission","_position","_loot","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [100] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Gem Tower]: Starting... %1",_position];

// Loot
_loot = [[3,ai_wep_special_cheap + ai_wep_special_good],[3,crate_tools_sniper],[6,crate_items_gems],[1,ai_wep_special_delux + ai_launcher_special_delux],[2,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_medium,[-20,11]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Misc_Coltan_Heap_EP1",[-3.41,16.4,-2.5],-82.16],
	["Land_Misc_Coltan_Heap_EP1",[-31,12,-2],8.27],
	["Land_Misc_Coltan_Heap_EP1",[-26,34,-2]],
	["GraveCrossHelmet",[-20,11]]
],_position,_mission] call wai_spawnObjects;
[[
	["Land_Ind_SiloVelke_01",[-0.01,-0.01,-0.25]],
	["Land_Ind_SiloVelke_01",[-21,-0.4,-0.25],182.209],
	["Land_A_Castle_Bastion",[-21,11,-0.2]]
],_position,-1] call wai_spawnObjects;

//Troops
[[(_position select 0) + 60, (_position select 1) - 40, 0],5,"extreme",[1,"M47Launcher_EP1"],4,"Random","TK_CIV_Takistani01_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 40, (_position select 1) + 40, 0],5,"extreme",[1,"AT"],4,"Random","TK_CIV_Takistani03_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 60, (_position select 1) - 40, 0],5,"extreme",[2,"Igla"],4,"Random","TK_CIV_Takistani04_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 40, (_position select 1) - 40, 0],5,"extreme",[2,"AA"],4,"Random","TK_CIV_Takistani06_EP1_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 20, (_position select 1) + 40, 0],3,"extreme",["Anzio_20_DZ","KSVK_DZE"] call BIS_fnc_selectRandom,6,"Random","TK_INS_Warlord_EP1_DZ","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],450,4,ai_armored_vehicles call BIS_fnc_selectRandom,"extreme","TK_INS_Soldier_EP1_DZ","Hero",_mission] call vehicle_patrol;
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) + 60, _position select 1, 0],450,4,ai_antiair_vehicles call BIS_fnc_selectRandom,"extreme","TK_INS_Soldier_EP1_DZ","Hero",_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) - 1, (_position select 1) + 39, 0],
	[(_position select 0) + 33, (_position select 1) - 21, 0]
],"ZU23_TK_GUE_EP1","extreme","TK_INS_Soldier_EP1_DZ","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[
	[(_position select 0) + 1, (_position select 1) - 39, 0],
	[(_position select 0) + 33, (_position select 1) + 21, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"extreme","TK_INS_Soldier_EP1_DZ","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[
  [(_position select 0) + 20, (_position select 1) - 20, 0]
],"Igla_AA_pod_TK_EP1","Extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Paradrop after mission
[_position,100,armed_chopper call BIS_fnc_selectRandom,["North","South","East","West"] call BIS_fnc_selectRandom,[4000,5000],100,0.4,300,6,"Random",0,4,"Random","Bandit","Random","Bandit",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"extreme", // Difficulty
	"Gem Tower", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_GEMTOWER_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_GEMTOWER_WIN", // mission success
	"STR_CL_GENERAL_GEMTOWER_FAIL", // mission fail
	_time
] call mission_winorfail;
