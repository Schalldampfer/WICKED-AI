private ["_time","_mission","_rndnum","_vehname","_position","_vehclass","_plane","_startArray","_startPos","_dropzone","_aigroup","_pilot","_wp","_complete","_timeout","_vehDropped","_vehicle","_parachute","_missionType","_color"];

_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = improved_vehicles call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

// Plane
_airClass = ["C130J_US_EP1_DZ","MV22_DZ"] call BIS_fnc_selectRandom;
_airName = getText (configFile >> "CfgVehicles" >> _airClass >> "displayName");

_position = [20] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] %1 Vehicle Drop]: Starting... %2",_airName,_position];

// Spawn Objects
[[
	["Land_fort_artillery_nest",[-5.939,10.0459],-31.158424],
	["Land_fort_artillery_nest",[6.3374,-11.1944],-211.14516],
	["Land_fort_rampart",[12.2456,6.249],-120.93051],
	["Land_fort_rampart",[-11.4253,-7.628],59.42643],
	["Land_CamoNetVar_EAST",[4.1738,-7.9112],-27.004126],
	["PowGen_Big",[-0.8936,8.1582],-56.044361],
	["Barrel5",[-2.5074,7.3466]],
	["Barrel5",[-3.293,7.9179]],
	["Land_Campfire_burning",[3.1367,-5.087]],
	["FoldChair",[0.8589,-6.2676],-132.43658],
	["FoldChair",[2.6909,-7.4805],-184.45828],
	["FoldChair",[5.4175,-5.4903],96.993355],
	["FoldChair",[4.5722,-7.2305],142.91867],
	["FoldChair",[5.0542,-3.4649],55.969147]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Hard","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[_position,5,"Hard","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"extreme",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"extreme",["Random","AA"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],250,4,spg9_vehicles call BIS_fnc_selectRandom,"Hard","Random","Hero",_mission] call vehicle_patrol;
[[(_position select 0) - 50, _position select 1, 0],[(_position select 0) + 60, _position select 1, 0],450,4,armed_vehicle call BIS_fnc_selectRandom,"Hard","Random","Hero",_mission] call vehicle_patrol;


if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] %1 Vehicle Drop spawned a %2",_airName,_vehname];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	format["%1 Air Drop",_vehname], // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_airClass, // Class of plane to deliver the vehicle
	_vehclass, // Class of vehicle to air drop
	["STR_CL_BANDIT_AIRDROP_ANNOUNCE",_airName,_vehname], // mission announcement
	["STR_CL_BANDIT_AIRDROP_CRASH",_airName], // aircraft crashed
	["STR_CL_BANDIT_AIRDROP_DROP",_vehname], // vehicle dropped
	["STR_CL_BANDIT_AIRDROP_WIN",_vehname], // mission success
	["STR_CL_BANDIT_AIRDROP_FAIL",_vehname], // mission fail
	_time
] call wai_air_drop;