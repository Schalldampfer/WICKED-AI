private ["_rndnum","_mission","_position","_aiType","_messages","_missionType","_loot","_loot1","_loot2","_loot3"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Lunch break Convoy]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_IkeaConvoy select 0;} else {Loot_IkeaConvoy select 1;};
_loot1 = if (_missionType == "MainHero") then {Loot_IkeaConvoy1 select 0;} else {Loot_IkeaConvoy1 select 1;};
_loot2 = if (_missionType == "MainHero") then {Loot_IkeaConvoy2 select 0;} else {Loot_IkeaConvoy2 select 1;};
_loot3 = if (_missionType == "MainHero") then {Loot_IkeaConvoy3 select 0;} else {Loot_IkeaConvoy3 select 1;};

// Spawn Objects
[[
	["US_WarfareBFieldhHospital_Base_EP1",[2,5]],
	["MASH_EP1",[-24,-5]],
	["MASH_EP1",[-17,-5]],
	["MASH_EP1",[-10,-5]]
],_position,_mission] call wai_spawnObjects;

//Spawn Crates
[[
	[_loot,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Hard",["Random","AT"],4,"Random","Worker1_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",["Random","AA"],4,"Random","Worker3_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random","Worker4_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",1,2,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",2,6,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
_uG1=[[(_position select 0) + 55, _position select 1, 0],       [(_position select 0) - 50, _position select 1, 0],500,2,armed_vehicle call BIS_fnc_selectRandom,"Hard","Soldier_Bodyguard_AA12_PMC_DZ",_aiType,_mission] call vehicle_patrol;
_uG2=[[(_position select 0) +  2, (_position select 1) + 48, 0],[(_position select 0) - 48, _position select 1, 0],250,2,armed_vehicle call BIS_fnc_selectRandom,"Hard","Soldier_Bodyguard_AA12_PMC_DZ",_aiType,_mission] call vehicle_patrol;
(units _uG2) joinSilent _uG1;
_uG2=[[(_position select 0) - 55, (_position select 1) + 48, 0],[(_position select 0) + 48, _position select 1, 0],150,2,spg9_vehicles call BIS_fnc_selectRandom,"Hard","Soldier_Bodyguard_AA12_PMC_DZ",_aiType,_mission] call vehicle_patrol;
(units _uG2) joinSilent _uG1;

[_loot1,[(_position select 0) + 19,(_position select 1) + 11],_mission,true,90] call custom_publish;
[_loot2,[(_position select 0) - 14,(_position select 1) - 14],_mission,true,-90] call custom_publish;
[_loot3,[(_position select 0) - 20,(_position select 1) - 6],_mission,true,-90] call custom_publish;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_IKEA_ANNOUNCE","STR_CL_HERO_IKEA_WIN","STR_CL_HERO_IKEA_FAIL"];
} else {
	["STR_CL_BANDIT_IKEA_ANNOUNCE","STR_CL_BANDIT_IKEA_WIN","STR_CL_BANDIT_IKEA_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"IKEA Convoy", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
