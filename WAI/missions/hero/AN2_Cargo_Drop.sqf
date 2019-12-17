private ["_time","_mission","_rndnum","_vehname","_position","_vehclass","_plane","_startArray","_startPos","_dropzone","_aigroup","_pilot","_wp","_complete","_timeout","_vehDropped","_vehicle","_parachute","_missionType","_color"];

_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

// Plane
_airClass = ["AN2_DZ","AN2_2_DZ","An2_2_TK_CIV_EP1_DZ"] call BIS_fnc_selectRandom;
_airName = getText (configFile >> "CfgVehicles" >> _airClass >> "displayName");

_position = [30] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] %1 Vehicle Drop]: Starting... %2",_airName,_position];

// Spawn Objects
[[
	["US_WarfareBFieldhHospital_Base_EP1",[2,5]],
	["MASH_EP1",[-24,-5]],
	["MASH_EP1",[-17,-5]],
	["MASH_EP1",[-10,-5]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,5,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,4,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,4,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],250,4,pk_vehicle call BIS_fnc_selectRandom,"Medium","Random","Bandit",_mission] call vehicle_patrol;
[[(_position select 0) - 50, _position select 1, 0],[(_position select 0) + 60, _position select 1, 0],450,4,armed_vehicle call BIS_fnc_selectRandom,"Medium","Random","Bandit",_mission] call vehicle_patrol;


if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] %1 Vehicle Drop spawned a %2",_airName,_vehname];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"AN2 Supply Drop", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_airClass, // Class of plane to deliver the vehicle
	_vehclass, // Class of vehicle to air drop
	["STR_CL_HERO_AIRDROP_ANNOUNCE",_airName,_vehname], // mission announcement
	["STR_CL_HERO_AIRDROP_CRASH",_airName], // aircraft crashed
	["STR_CL_HERO_AIRDROP_DROP",_vehname], // vehicle dropped
	["STR_CL_HERO_AIRDROP_WIN",_vehname], // mission success
	["STR_CL_HERO_AIRDROP_FAIL",_vehname], // mission fail
	_time
] call wai_air_drop;