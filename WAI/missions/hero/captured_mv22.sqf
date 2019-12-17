private ["_time","_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Captured MV22]: Starting... %1",_position];

// Loot
_loot = [0,4,[14,(crate_items_medical + crate_items_skin)],0,1];

//Spawn Crates
[[
	[_loot,crates_medium,[11.2,12.2,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["USMC_WarfareBFieldhHospital",[12.7,6.5],-210],
	["Barrack2",[16,-11],150],
	["Misc_cargo_cont_small",[2.8,17.4],12.5],
	["Barrack2",[9,-15],150],
	["Misc_cargo_cont_small",[6.7,18.3],12.5]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 33,(_position select 1) - 18,0],5,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 1,(_position select 1) + 29,0],_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 33,(_position select 1) - 7,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,4,"Easy","Unarmed",4,"none","Doctor_DZ","Random","Hero"] call spawn_group;
 
//Humvee Patrol
[[(_position select 0) + 0.1, (_position select 1) + 20, 0],[(_position select 0) + 0.1, (_position select 1) - 20, 0],50,2,armed_vehicle call BIS_fnc_selectRandom,"Medium","Bandit","Bandit",_mission] call vehicle_patrol;

//MV22
["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] captured_mv22 spawned a MV22 at %1", _position];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Captured MV22", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_MV22_ANNOUNCE", // mission announcement
	"STR_CL_HERO_MV22_WIN", // mission success
	"STR_CL_HERO_MV22_FAIL", // mission fail
	_time
] call mission_winorfail;
