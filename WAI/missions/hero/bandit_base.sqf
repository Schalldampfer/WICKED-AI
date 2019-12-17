private ["_time","_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [60] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Bandit Base]: Starting... %1",_position];

// Loot
_loot = [10,[8,crate_tools_sniper],[2,crate_items_high_value],[2,ai_launcher_special_cheap + ai_wep_pistol],[4,crate_backpacks_large]];

// Spawn crates
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

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium",["Random","AT"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Random","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) - 10, (_position select 1) + 10, 0],
  [(_position select 0) + 10, (_position select 1) - 10, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Base", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_BANDITBASE_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BANDITBASE_WIN", // mission success
	"STR_CL_HERO_BANDITBASE_FAIL", // mission fail
	_time
] call mission_winorfail;