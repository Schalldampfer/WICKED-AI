private ["_mission","_position","_rndnum","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [20] call find_position;

diag_log format["WAI: [Mission:[%2] Black Hawk Crash]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_BHC select 0;} else {Loot_BHC select 1;};

//Spawn Crates
[[
	[_loot,crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Body",[3.2905,2.3438],61.798588],
	["Body",[3.8511,3.4346],52.402905],
	["Body",[2.435,4.4297],-117.27345],
	["Body2",[1.0337,5.5],23.664057]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Easy",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) +5, (_position select 1) +5]
],["UH1Wreck","UH60_wreck_EP1"] call BIS_fnc_selectRandom,"Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

[[
	[(_position select 0) + 25, (_position select 1) + 25, 0],
	[(_position select 0) - 25, (_position select 1) - 25, 0]
],ai_static_gpmg call BIS_fnc_selectRandom,"Easy",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_BHCRASH_ANNOUNCE","STR_CL_HERO_BHCRASH_WIN","STR_CL_HERO_BHCRASH_FAIL"];
} else {
	["STR_CL_BANDIT_BHCRASH_ANNOUNCE","STR_CL_BANDIT_BHCRASH_WIN","STR_CL_BANDIT_BHCRASH_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Black Hawk Crash", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
