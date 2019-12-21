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
	["LADAWreck",[-7.5,-3]],
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

//Sound effect
[_position,_mission,_tower] spawn {
	private ["_pos","_mission","_running","_tower"];
	_pos = _this select 0;
	_mission = _this select 1;
	_tower = _this select 2;
	_running = true;
	while {_running} do {
		sleep ((random 2) + 2);
		_running = (typeName (wai_mission_data select _mission) == "ARRAY");
		{
			if ((isPlayer _x) && (_x distance _pos < 5)) exitWith { _running = false;};
			//if ((alive _x) && (_x distance _pos < 2000)) then {[objNull,_x,rSAY,"radionoise1",2] call RE;[nil,_x,"loc",rTITLETEXT,"[RADIO] . . .","PLAIN DOWN",2] call RE;};
		} count playableUnits;
	};
	[_tower] call wai_fnc_remove;
};

// Troops
[[(_position select 0) - 1.2, (_position select 1)  - 20, 0],5,"extreme",["random","at"],4,"random",_aiType,"random",[_aiType,150],_mission] call spawn_group;
[[(_position select 0) - 4, (_position select 1) + 16, 0],5,"hard","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 17, (_position select 1) - 4, 0],5,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 14, (_position select 1) - 3, 0],_rndnum,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 14, (_position select 1) - 3, 0],_rndnum,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;

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