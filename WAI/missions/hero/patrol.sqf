private ["_mission","_vehname","_vehicle","_position","_vehclass","_loot","_name","_locations","_location","_blacklist"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_locations = nearestLocations [getMarkerPos "center", ["NameCityCapital","NameCity","NameVillage"],15000];
_location = _locations call BIS_fnc_selectRandom;
_position = position _location;
_name = text _location;
_blacklist = ["Stary Sobor"];

{
	if ((text _x) == (text _location) || (text _x) in _blacklist) then {
		_locations set [_forEachIndex, "rem"];
		_locations = _locations - ["rem"];
	};
} forEach _locations;

diag_log format["WAI: [Mission:[Hero] Patrol]: Starting... %1",_position];

//Spawn units
_units = [[(_position select 0) + 4,(_position select 1),.1],3,"Hard","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Spawn vehicles
_vehicle = [_vehclass,_position,_mission] call custom_publish;

// load the guns
[_vehicle,_vehclass] call load_ammo;

// Loot

_loot = [[6,ai_wep_special_cheap],2,[3,["ItemBriefcaseS100oz","ItemBriefcase100oz"]],2,2];

((wai_mission_data select _mission) select 3) set [count ((wai_mission_data select _mission) select 3), [_vehicle,_loot]];

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] patrol spawned a %1",_vehname];
};

[
	_mission, // mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Patrol %1",_vehname], // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	3, // Number of wayPoints
	_locations, // WayPoints
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_HERO_PATROL_ANNOUNCE",_name], // mission announcement
	"STR_CL_HERO_PATROL_WIN", // mission success
	"STR_CL_HERO_PATROL_FAIL" // mission fail
] call patrol_winorfail;
