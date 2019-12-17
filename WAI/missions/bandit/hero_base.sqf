private ["_time","_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [60] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Hero Base]: Starting... %1",_position];

// Loot
_loot = [[8,ai_wep_special_good + ai_launcher_special_cheap],8,0,[2,ai_wep_special_rare + ai_launcher_special_cheap],[4,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["land_fortified_nest_big",[-40,0],90],
	["land_fortified_nest_big",[40,0],270],
	["land_fortified_nest_big",[0,-40]],
	["land_fortified_nest_big",[0,40],180],
	["Land_Fort_Watchtower",[-10,0]],
	["Land_Fort_Watchtower",[10,0],180],
	["Land_Fort_Watchtower",[0,-10],270],
	["Land_Fort_Watchtower",[0,10],90]
],_position,_mission] call wai_spawnObjects;

//Group Spawning
_rndnum = 3 + round (random 4);
[[_position select 0,_position select 1,0],6,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],6,"Hard",["Random","AA"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],6,"Hard",["Random","AA"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Hard","KSVK_DZE",6,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) - 10, (_position select 1) + 10, 0],
  [(_position select 0) + 10, (_position select 1) - 10, 0],
  [(_position select 0) + 10, (_position select 1) + 10, 0],
  [(_position select 0) - 10, (_position select 1) - 10, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Extreme","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;
[[
  [(_position select 0) + 20, (_position select 1) - 20, 0]
],"Igla_AA_pod_TK_EP1","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Heli Paradrop
[[(_position select 0) + 200, (_position select 1), 0],800,armed_chopper call BIS_fnc_selectRandom,"East",[4000,5000],150,1.0,200,10,"Hard",["Random","at"],4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Base", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_HEROBASE_ANNOUNCE",	// mission announcement
	"STR_CL_BANDIT_HEROBASE_WIN", // mission success
	"STR_CL_BANDIT_HEROBASE_FAIL", // mission fail
	_time
] call mission_winorfail;
