private ["_time","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Hero Outpost]: Starting... %1",_position];

//Spawn Crates
[[
	[[[8,(ai_wep_special_good + ai_wep_special_cheap)],4,[10,crate_items_sniper],2,1],crates_large,[0,0]]
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
_rndnum = 3 + round (random 5);
[[(_position select 0) + 2,_position select 1,0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 8,_position select 1,0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 2,_position select 1,0],_rndnum,"Hard",["M60A4_EP1_DZE","AA"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) - 30, (_position select 1) + 40, 0],
  [(_position select 0) + 20, (_position select 1) - 30, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Heli Para Drop
[[(_position select 0),(_position select 1),0],800,(armed_chopper call BIS_fnc_selectRandom),"South",[3000,4000],150,1.0,200,4,"Random","Random",4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Outpost", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_HEROOUTPOST_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_HEROOUTPOST_WIN", // mission success
	"STR_CL_BANDIT_HEROOUTPOST_FAIL", // mission fail
	_time
] call mission_winorfail;