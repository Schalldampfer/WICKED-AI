private ["_missionType","_messages","_aiType","_mission","_rndnum","_vehname","_position","_vehclass","_plane","_startArray","_startPos","_dropzone","_aigroup","_pilot","_wp","_complete","_timeout","_vehDropped","_vehicle","_parachute","_missionType","_color"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [20] call find_position;

//Armed Land Vehicle
_vehclass = (if (_missionType == "MainHero") then {Loot_VehicleDrop2 select 0} else {Loot_VehicleDrop2 select 1}) call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

// Plane
_airClass = ["C130J_US_EP1_DZ","MV22_DZ"] call BIS_fnc_selectRandom;
_airName = getText (configFile >> "CfgVehicles" >> _airClass >> "displayName");

diag_log format["WAI: [Mission:[%3] %1 Vehicle Drop]: Starting... %2",_vehname,_position,_missionType];

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
[_position,5,"Medium",["Random","AT"],3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

if(wai_debug_mode) then {
	diag_log format["WAI: [%3] %1 Vehicle Drop spawned a %2",_airName,_vehname,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	[["STR_CL_HERO_AIRDROP_ANNOUNCE",_airName,_vehname],["STR_CL_HERO_AIRDROP_CRASH",_airName],["STR_CL_HERO_AIRDROP_DROP",_vehname],["STR_CL_HERO_AIRDROP_WIN",_vehname],["STR_CL_HERO_AIRDROP_FAIL",_vehname]];
} else {
	[["STR_CL_BANDIT_AIRDROP_ANNOUNCE",_airName,_vehname],["STR_CL_BANDIT_AIRDROP_CRASH",_airName],["STR_CL_BANDIT_AIRDROP_DROP",_vehname],["STR_CL_BANDIT_AIRDROP_WIN",_vehname],["STR_CL_BANDIT_AIRDROP_FAIL",_vehname]];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["%1 Air Drop",_vehname], // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_airClass, // Class of plane to deliver the vehicle
	_vehclass, // Class of vehicle to air drop
	_messages
] call wai_air_drop;
