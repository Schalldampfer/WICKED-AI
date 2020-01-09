private ["_rndnum","_room","_mayor_himself","_mission","_position","_mansion","_mayor","_aiType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Mayors Mansion]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_Mayors select 0;} else {Loot_Mayors select 1;};

//Spawn Crates
[[
	[_loot,crates_large,[0,0,.25]]
],_position,_mission] call wai_spawnCrate;
 
// Spawn Objects
_mansion = [[
	["Land_A_Villa_EP1",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Medium",["Random","RPG7V"],3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Medium",["Random","RPG7V"],3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",3,"Random","BAF_Soldier_Officer_MTP_DZ","Random",_aiType,_mission] call spawn_group;

//The Mayor Himself
_mayor = [_position,1,"extreme","revolver_gold_EP1",2,"Random","Special","Random",[_aiType,100],_mission] call spawn_group;
_mayor setBehaviour "COMBAT";
_mayor_himself = (units _mayor) select 0;
_mayor_himself setUnitPos "UP";

//Put the Mayor in his room
_room = (6 + ceil(random(3)));
_mayor_himself disableAI "MOVE";
_mayor_himself setPos (_mansion buildingPos _room);

//Let him move once player is near
_mayor_himself spawn {
	private ["_mayor","_player_near"];
	_mayor = _this;
	_player_near = false;
	while {!_player_near} do {
		_player_near = [(position _mayor),30] call isNearPlayer;
		uiSleep 2;
	};
	_mayor enableAI "MOVE";
	doStop _mayor;
};

//Static mounted guns
_uG1=[[
	[(_position select 0) - 15, (_position select 1) + 15, 8],
	[(_position select 0) + 15, (_position select 1) - 15, 8]
],ai_static_weapons call BIS_fnc_selectRandom,"Medium",_aiType,_aiType,1,2,"Random","Random",_mission] call spawn_static;
_uG2=[[
	[(_position select 0) - 50,(_position select 1), 0]
],"Igla_AA_pod_TK_EP1","Extreme",_aiType,_aiType,0,2,"none","Random",_mission] call spawn_static;
(units _uG2) joinSilent _uG1;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Mayors Mansion", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["assassinate",_mayor], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_MAYOR_ANNOUNCE","STR_CL_MAYOR_WIN","STR_CL_MAYOR_FAIL"]
] call mission_winorfail;
