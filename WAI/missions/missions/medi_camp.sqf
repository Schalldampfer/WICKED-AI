private ["_rndnum","_mission","_position","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Medical Supply Camp]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_MediCamp select 0;} else {Loot_MediCamp select 1;};

//Spawn Crates
[[
	[_loot,"USVehicleBox_EP1",[0,0],60]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_fort_watchtower",[1.5,12.6],-210],
	["MAP_MASH",[-17,5.3],60],
	["MAP_Stan_east",[-16.5,15.9],-30],
	["USMC_WarfareBFieldhHospital",[3,-4.4],60],
	["MAP_Stan_east",[-10,19.6],-30],
	["MAP_MASH",[-14,-0.4],60]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 7.5,(_position select 1) + 7.9,0],5,"Medium",["Random","RPG7V"],3,"Random","US_Soldier_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 7.5,(_position select 1) + 7.9,0],5,"Medium",["Random","RPG7V"],3,"Random","US_Soldier_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 26,(_position select 1) - 2.4,0],5,"Medium","Random",3,"Random","RUS_Soldier1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 26,(_position select 1) - 2.4,0],5,"Medium","Random",3,"Random","RUS_Soldier1_DZ","Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 35, _position select 1, 0],       [(_position select 0) + 30, _position select 1, 0],50,2,"M1114_AGS_ACR","Medium","GER_Soldier_TL_EP1_DZ",_aiType,_mission] call vehicle_patrol;
[[(_position select 0) +  2, (_position select 1) + 38, 0],[(_position select 0) - 28, _position select 1, 0],50,2,"M1114_DSK_ACR","Medium","GER_Soldier_TL_EP1_DZ",_aiType,_mission] call vehicle_patrol;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_MSC_ANNOUNCE","STR_CL_HERO_MSC_WIN","STR_CL_HERO_MSC_FAIL"];
} else {
	["STR_CL_BANDIT_MSC_ANNOUNCE","STR_CL_BANDIT_MSC_WIN","STR_CL_BANDIT_MSC_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Medical Supply Camp", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;