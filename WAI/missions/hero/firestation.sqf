private ["_time","_rndnum","_mission","_position","_loot1","_loot2"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [50] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Fire Station]: Starting... %1",_position];

_loot1 = [0,[2,crate_weapons_buildables],[5,crate_items_buildables],0,1];
_loot2 = [[6,ai_wep_special_cheap],5,[10,crate_items_vehicle_repair],3,1];

[[
	[_loot1,crates_large,[2,-1.1],-30],
	[_loot2,crates_large,[-3.6,-4.4],-30]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_a_stationhouse",[0,0],-210],
	["Land_fort_bagfence_round",[3.5,-20],68],
	["Land_fort_bagfence_round",[-1,-23.3],219]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Spawn vehicles
_vehclass = refuel_trucks call BIS_fnc_selectRandom;
[_vehclass,[(_position select 0) -9.5, (_position select 1) -6.8],_mission,true,-29] call custom_publish;

//Heli Paradrop
[_position,800,"MH6J_DZ","East",[3000,4000],150,1.0,200,5,"Random","Random",4,"Random","Bandit","Random","Bandit",false,_mission] spawn heli_para;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Fire Station", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_FIRESTATION_ANNOUNCE", // mission announcement
	"STR_CL_HERO_FIRESTATION_WIN", // mission success
	"STR_CL_HERO_FIRESTATION_FAIL", // mission fail
	_time
] call mission_winorfail;