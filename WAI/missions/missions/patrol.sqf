local _mission = count WAI_MissionData -1;
local _aiType = _this select 0; // "Hero" or "Bandit"
local _position = [30] call WAI_FindPosForest;
local _hero = (_aiType == "Hero");
local _localName = localize "STR_CL_WAIPATROL_TITLE";
local _startTime = diag_tickTime;
local _difficulty = "Medium";
local _name = "STR_CL_WAIPATROL_TITLE";
local _localized = ["STR_CL_MISSION_BANDIT", "STR_CL_MISSION_HERO"] select (_aiType == "Hero");
local _locationName = "";
local _nearestCity = nearestLocations [_position, ['NameCityCapital','NameCity','NameVillage','NameLocal','NameMarine','Hill','Mount'],750];
while {(_locationName == '') && (count _nearestCity > 0)} do {
	_locationName = text (_nearestCity select 0);
	_nearestCity = _nearestCity - [_nearestCity select 0];
};
if (_locationName == '') then {_locationName = 'Somewhere';};

diag_log format["[WAI]: %1 %2 started at %3.",_aiType,_name,_position];

local _messages = if (_hero) then {
	[["STR_CL_HERO_PATROL_ANNOUNCE",_locationName],"STR_CL_HERO_PATROL_WIN","STR_CL_HERO_PATROL_FAIL"];
} else {
	[["STR_CL_BANDIT_PATROL_ANNOUNCE",_locationName],"STR_CL_BANDIT_PATROL_WIN","STR_CL_BANDIT_PATROL_FAIL"];
};

////////////////////// Do not edit this section ///////////////////////////
local _markers = [1,1,1,1];
//[position,createMarker,setMarkerColor,setMarkerType,setMarkerShape,setMarkerBrush,setMarkerSize,setMarkerText,setMarkerAlpha]
_markers set [0, [_position, "WAI" + str(_mission), "ColorYellow", "", "ELLIPSE", "Solid", [300,300], [], 0]];
_markers set [1, [_position, "WAI" + str(_mission) + "dot", "ColorBlack", "hd_dot", "", "", [], [_localized,_localName], 0]];
if (WAI_AutoClaim) then {_markers set [2, [_position, "WAI" + str(_mission) + "auto", "ColorRed", "", "ELLIPSE", "Border", [WAI_AcAlertDistance,WAI_AcAlertDistance], [], 0]];};
DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers]; // Markers added to global array for JIP player requests.
_markerIndex = count DZE_ServerMarkerArray - 1;
PVDZ_ServerMarkerSend = ["start",_markers];
publicVariable "PVDZ_ServerMarkerSend";

WAI_MarkerReady = true;

// Add the mission's position to the global array so that other missions do not spawn near it.
DZE_MissionPositions set [count DZE_MissionPositions, _position];
local _posIndex = count DZE_MissionPositions - 1;

// Send announcement
[_difficulty,(_messages select 0)] call WAI_Message;

// Wait until a player is within range or timeout is reached.
local _timeout = false;
local _claimPlayer = objNull;

while {WAI_WaitForPlayer && !_timeout && {isNull _claimPlayer}} do {
	_claimPlayer = [_position, WAI_TimeoutDist] call isClosestPlayer;
	
	if (diag_tickTime - _startTime >= (WAI_Timeout * 60)) then {
		_timeout = true;
	};
	uiSleep 1;
};

if (_timeout) exitWith {
	[_mission, _aiType, _markerIndex, _posIndex] call WAI_AbortMission;
	[_difficulty,(_messages select 2)] call WAI_Message;
	diag_log format["WAI: %1 %2 aborted.",_aiType,_name,_position];
};
//////////////////////////////// End //////////////////////////////////////

//Spawn Crates
local _loot = if (_aiType == "Hero") then {Loot_Patrol select 0;} else {Loot_Patrol select 1;};
[[
	[_loot,WAI_CrateMd,[.3,0]]
],_position,_mission] call WAI_SpawnCrate;

//Troops
[_position,5,_difficulty,"random","AT","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;
[_position,5,_difficulty,"random","","random","Hero","random",_aiType,_mission] call WAI_SpawnGroup;
[_position,4,_difficulty,"random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;
[_position,4,_difficulty,"random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;

//Static Guns
[[
	[(_position select 0) + 0.1, (_position select 1) + 20, 0],
	[(_position select 0) + 0.1, (_position select 1) - 20, 0]
],"BAF_GPMG_Minitripod_W","Easy",_aiType,_aiType,"random","random","random",_mission] call WAI_SpawnStatic;

[
	_mission, // Mission number
	_position, // Position of mission
	_difficulty, // Difficulty
	_name, // Name of Mission
	_localName, // localized marker text
	_aiType, // "Bandit" or "Hero"
	_markerIndex,
	_posIndex,
	_claimPlayer,
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;