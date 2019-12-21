private ["_mission","_position","_rndnum","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: Mission:[%2] Radio Tower started at %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_Radioshack select 0;} else {Loot_Radioshack select 1;};

//Spawn Crates
[[
	[_loot,"UNBasicWeapons_EP1",[.01,.01]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_cihlovej_dum_in",[-3,-1]],
	//["LADAWreck",[-7.5,-3]],
	["FoldTable",[-1.2,-4]],
	["FoldChair",[-1,-3]],
	["SmallTV",[-1.7,-4,0.82]],
	["SatPhone",[-0.8,-4,0.82],-201.34],
	["MAP_t_picea2s",[-4.5,7]],
	["MAP_t_picea2s",[13,10]],
	["MAP_t_pinusN2s",[3,9]],
	["MAP_t_pinusN1s",[8,17]],
	["MAP_t_picea1s",[7,10]],
	["MAP_t_picea2s",[34,-29]],
	["MAP_t_fraxinus2s",[-14,1]],
	["MAP_t_carpinus2s",[28,-13]]
],_position,_mission] call wai_spawnObjects;
_tower=[[
	["Land_Com_tower_ep1",[5,-2]]
],_position,-1] call wai_spawnObjects;

//Spawn Vehicle
[civil_vehicles call BIS_fnc_selectRandom,[(_position select 0) -7.5, (_position select 1) -3,0],_mission,true,0] call custom_publish;

//Sound effect
[_position,_tower] spawn {
	private ["_pos","_running","_tower"];
	_pos = _this select 0;
	_tower = _this select 1;
	_running = true;
	while {_running} do {
		sleep 5;
		{
			if ((isPlayer _x) && (_x distance _pos < 5)) exitWith { _running = false;};
		} count playableUnits;
	};
	[_tower] call wai_fnc_remove;
};

// Troops
[[(_position select 0) - 1, (_position select 1) - 20, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 4, (_position select 1) + 16, 0],5,"Hard",["Random","AA"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 17, (_position select 1) - 4, 0],5,"Hard",1,2,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 14, (_position select 1) - 3, 0],5,"Hard",1,2,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 14, (_position select 1) - 3, 0],5,"Hard",2,5,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[[(_position select 0) - 32, (_position select 1) - 18, 0],
  [(_position select 0) + 12, (_position select 1) + 40, 0]
],ai_static_weapons call BIS_fnc_selectRandom,"Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_RADIO_ANNOUNCE","STR_CL_HERO_RADIO_WIN","STR_CL_HERO_RADIO_FAIL"];
} else {
	["STR_CL_BANDIT_RADIOTOWER_ANNOUNCE","STR_CL_BANDIT_RADIOTOWER_WIN","STR_CL_BANDIT_RADIOTOWER_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Radio Tower", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;