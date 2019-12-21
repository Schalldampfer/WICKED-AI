private ["_mission","_position","_rndnum","_messages","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [10] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Ural Attack]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_UralAttack select 0;} else {Loot_UralAttack select 1;};

//Spawn Crates
[[
	[_loot,crates_medium,[-5,-5]]
],_position,_mission] call wai_spawnCrate;

//Spawn Vehicle
[["Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","UralCivil_DZE","UralCivil2_DZE"] call BIS_fnc_selectRandom,_position,_mission] call custom_publish;

//Troops
[_position,5,"Easy",4,2,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Easy",4,2,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Easy",4,2,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0), (_position select 1) + 20, 0],[(_position select 0), (_position select 1) - 20, 0],50,2,pk_vehicle call BIS_fnc_selectRandom,"Easy",_aiType,_aiType,_mission] call vehicle_patrol;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_URAL_ANNOUNCE","STR_CL_HERO_URAL_WIN","STR_CL_HERO_URAL_FAIL"];
} else {
	["STR_CL_BANDIT_URAL_ANNOUNCE","STR_CL_BANDIT_URAL_WIN","STR_CL_BANDIT_URAL_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Ural Attack", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;