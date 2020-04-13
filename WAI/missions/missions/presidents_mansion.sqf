private ["_rndnum","_president_himself","_mission","_position","_president","_firstlady","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [50] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Presidents in Town]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_Presidents select 0;} else {Loot_Presidents select 1;};

//Spawn Crates
[[
	[_loot,crates_large,[0,0,.25]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_A_Office01",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Hard",[0,"AT"],2,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",[1,"AT"],5,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",[0,"AA"],2,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",[1,"AA"],5,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",2,3,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard",2,3,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random",_aiType,_mission] call spawn_group;

//The President Himself
_president = [[((_position select 0) + 5), _position select 1, 4.1],1,"extreme","revolver_gold_EP1",2,"none","Special","Random",[_aiType,200],_mission] call spawn_group;
_president setBehaviour "COMBAT";

_president_himself = (units _president) select 0;
_president_himself setUnitPos "UP";
_president_himself disableAI "MOVE";

//Let him move once player is near
_president_himself spawn {
	private ["_president","_player_near"];
	_president = _this;
	_player_near = false;
	while {!_player_near} do {
		_player_near = [(position _president),50] call isNearPlayer;
		uiSleep 1;
	};
	_president enableAI "MOVE";
	doStop _president;
};

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],500,2,ai_antiair_vehicles call BIS_fnc_selectRandom,"Random",_aiType,_aiType,_mission] call vehicle_patrol;

//Static guns
[[
	[(_position select 0) - 13.135, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 14.225, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 1.97, (_position select 1) - 2.368, 11.5]
],ai_static_weapons call BIS_fnc_selectRandom,"Hard",_aiType,_aiType,1,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"President's in Town", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["assassinate",_president], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_PRESIDENT_ANNOUNCE","STR_CL_PRESIDENT_WIN","STR_CL_PRESIDENT_FAIL"]
] call mission_winorfail;