private ["_time","_mission","_position","_rndnum","_loot1","_loot2"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Firebase]: Starting... %1",_position];

// Spawn crates
_loot1 = [[1,crate_weapons_buildables],[1,crate_weapons_buildables],[10,crate_items_buildables+crate_items_vehicle_repair],0,2];
_loot2 = [[5,ai_wep_special_good + ai_wep_special_cheap],[2,crate_tools_sniper],[5,crate_items_sniper],[1,ai_wep_special_delux + ai_wep_special_rare],0];
[[
	[_loot1,crates_large,[2,-4],-30],
	[_loot1,crates_large,[-2,4],-30],
	[_loot2,crates_medium,[5,3.3],60],
	[_loot2,crates_medium,[-5,-2.5],60]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Ind_IlluminantTower",[0,0],random 360],
	["MAP_fort_rampart",[8,-14],-30],
	["MAP_fort_rampart",[-9,15],-210],
	["MAP_fort_rampart",[-16.6,-8.9],60],
	["MAP_fort_rampart",[16,10],-120],
	["MAP_HBarrier5",[2.3,-8.5],-30],
	["MAP_HBarrier5",[-8.9,-2.3],60],
	["MAP_HBarrier5",[6.9,7.2],60],
	["MAP_HBarrier5",[-6.1,6.8],-30],
	["MAP_fort_watchtower",[4.4,14.3],60],
	["MAP_fort_watchtower",[-15.3,2.3],60],
	["MAP_fort_watchtower",[15.7,-2.5],-120],
	["MAP_fort_watchtower",[-4.6,-14.1],-120]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 12,(_position select 1) - 23,0],6,"Hard",[1,"AT"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 24,(_position select 1) - 13,0],6,"Hard",[1,"AT"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 13,(_position select 1) + 25,0],6,"Hard",[1,"AA"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 26,(_position select 1) + 14,0],6,"Hard",["Anzio_20_DZ","KSVK_DZE"] call BIS_fnc_selectRandom,6,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 18.45,(_position select 1) - 8.41, 0],
	[(_position select 0) + 12.85,(_position select 1) + 18.51, 0],
	[(_position select 0) - 18.09,(_position select 1) + 9, 0],
	[(_position select 0) - 13.46,(_position select 1) - 17.78, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Heli Paradrop
[[(_position select 0) + 200, (_position select 1), 0],800,armed_chopper call BIS_fnc_selectRandom,"East",[3000,4000],150,1.0,200,10,"Hard",["Random","at"],4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;
[[(_position select 0) - 200, (_position select 1), 0],800,armed_chopper call BIS_fnc_selectRandom,"West",[3000,4000],150,1.0,200,10,"Hard",["Random","at"],4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Firebase", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_DZMS_FB_START", // mission announcement
	"STR_CL_DZMS_FB_WIN", // mission success
	"STR_CL_DZMS_FB_FAIL", // mission fail
	_time
] call mission_winorfail;
