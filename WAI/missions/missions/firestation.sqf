private ["_rndnum","_mission","_position","_messages","_aiType","_missionType","_loot1","_loot2","_loot3"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [50] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Fire Station]: Starting... %1",_position,_missionType];

_loot1 = if (_missionType == "MainHero") then {Loot_Firestation1 select 0;} else {Loot_Firestation1 select 1;};
_loot2 = if (_missionType == "MainHero") then {Loot_Firestation2 select 0;} else {Loot_Firestation2 select 1;};
_loot3 = if (_missionType == "MainHero") then {Loot_Firestation3 select 0;} else {Loot_Firestation3 select 1;};

//Spawn Crates
[[
	[_loot1,crates_large,[-3.6,-4.4],-30],
	[_loot2,crates_large,[2,-1.1],-30]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_a_stationhouse",[0,0],-210],
	["Land_fort_bagfence_round",[3.5,-20],68],
	["Land_fort_bagfence_round",[-1,-23.3],219]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",["Random","AA"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",["Random","AA"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",2,4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",2,4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

// Spawn Vehicle
[_loot3,[(_position select 0) -9.5, (_position select 1) -6.8],_mission,true,-29] call custom_publish;

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,armed_vehicle call BIS_fnc_selectRandom,"Random",_aiType,_aiType,_mission] call vehicle_patrol;

//Heli Paradrop
[_position,800,armed_chopper call BIS_fnc_selectRandom,"East",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random",_aiType,"Random",_aiType,false,_mission] spawn heli_para;

//Static guns
[[
	[(_position select 0) + 1.5, (_position select 1) -21, 0],
	[(_position select 0) + 0.5, (_position select 1) - 21.8, 0]
],ai_static_weapons call BIS_fnc_selectRandom,"Hard",_aiType,_aiType,1,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_FIRESTATION_ANNOUNCE","STR_CL_HERO_FIRESTATION_WIN","STR_CL_HERO_FIRESTATION_FAIL"];
} else {
	["STR_CL_BANDIT_FIRESTATION_ANNOUNCE","STR_CL_BANDIT_FIRESTATION_WIN","STR_CL_BANDIT_FIRESTATION_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Fire Station", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;