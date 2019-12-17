private ["_time","_mission","_position","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Weapons Cache]: Starting... %1",_position];

// Spawn crates
[[
	[
		[[10,(ai_wep_special_good + ai_wep_special_rare)],[4,crate_tools_sniper],[10,crate_ammo_good+crate_items_sniper],[1,(ai_wep_special_delux + ai_launcher_special_delux)],4]
	,crates_large,[0,0]]
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
_rndnum = round (random 5);
[[(_position select 0) + 6.5,(_position select 1) - 12,0],5,"Hard",[1,"AT"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0),(_position select 1),0],5,"Hard",[1,"AT"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 6.5,(_position select 1) - 12,0],5,"Hard",[1,"AT"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 8,(_position select 1) + 14,0],5,"Hard",[2,"AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 21,(_position select 1) - 12.5,0],_rndnum,"Hard",["KSVK_DZE","AA"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],50,2,"Dingo_DST_ACR","Hard","Hero","Hero",_mission] call vehicle_patrol;
[[(_position select 0) - 22, (_position select 1) - 32, 0],[(_position select 0) - 15, (_position select 1) + 33, 0],50,2,"M1114_DSK_ACR","Hard","Hero","Hero",_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) + 18, (_position select 1) - 13, 0],
	[(_position select 0) - 19.5, (_position select 1) + 12, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Weapon Cache", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_WEAPONCACHE_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_WEAPONCACHE_WIN", // mission success
	"STR_CL_BANDIT_WEAPONCACHE_FAIL", // mission fail
	_time
] call mission_winorfail;