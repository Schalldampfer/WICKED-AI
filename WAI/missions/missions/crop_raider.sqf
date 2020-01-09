private ["_mission","_position","_rndnum","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [60] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Hippy Commune]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_CropRaider select 0;} else {Loot_CropRaider select 1;};

//Spawn Crates
[[
	[_loot,crates_small,[2,0,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["fiberplant",[-10.8,-16.3]],
	["fiberplant",[16.2,-17.6]],
	["fiberplant",[-17.3,21]],
	["fiberplant",[28.6,29]],
	["fiberplant",[-29.8,-31.1]],
	["fiberplant",[30.2,-33]],
	["fiberplant",[-32,28.7]],
	["fiberplant",[-32,-1.1]],
	["fiberplant",[1.3,-28]],
	["fiberplant",[27,2]],
	["fiberplant",[-0.3,26]],
	["fiberplant",[35.9,39]],
	["fiberplant",[-39,-40.3]],
	["fiberplant",[-36.9,-38.6]],
	["fiberplant",[38,-38.9]],
	["fiberplant",[-37,39.7]],
	["fiberplant",[-0.1,42.3]],
	["fiberplant",[42.1,-0.1]],
	["fiberplant",[0.1,-40.2]],
	["hruzdum",[-0.01,-0.01]],
	["fiberplant",[-10,-11]],
	["fiberplant",[13,12.2]],
	["fiberplant",[12.3,-10.6]],
	["fiberplant",[-11.3,12.7]],
	["fiberplant",[15,10]]
],_position,_mission] call wai_spawnObjects;

//Spawn vehicles
if (WAI_Overpoch) then {
	[ow_patrol call BIS_fnc_selectRandom,[(_position select 0) - 9, (_position select 1) + 5,-0.01],_mission] call custom_publish;
} else {
	["LadaLM",[(_position select 0) - 9, (_position select 1) + 5,-0.01],_mission] call custom_publish;
};

//Group Spawning
[[(_position select 0) +  9, (_position select 1) - 13, 0],5,"Hard",["Random","AT"],4,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],5,"Hard",["Random","AA"],4,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],5,"Hard",["Random","AA"],4,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) + 15, 0],5,"Hard",1,2,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;
[[_position select 0       , _position select 1       , 0],5,"Hard",2,6,"Random","RU_Policeman_DZ","Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
_uG1=[[(_position select 0) + 55, _position select 1, 0],[(_position select 0) + 50, _position select 1, 0],150,2,"HMMWV_M1151_M2_CZ_DES_EP1","Hard","RU_Policeman_DZ",_aiType,_mission] call vehicle_patrol;
_uG2=[[(_position select 0) - 55, _position select 1, 0],[(_position select 0) - 50, _position select 1, 0],150,2,"HMMWV_M1151_M2_CZ_DES_EP1","Hard","RU_Policeman_DZ",_aiType,_mission] call vehicle_patrol;
(units _uG2) joinSilent _uG1;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Crop Raider", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_CROPRAIDER_ANNOUNCE","STR_CL_GENERAL_CROPRAIDER_WIN","STR_CL_GENERAL_CROPRAIDER_FAIL"]
] call mission_winorfail;
