if (count WAI_StaticList == 0) exitWith {
	diag_log "WAI: There are no static missions listed in WAI_StaticList";
};

local _array = [];
local _mission = "";
local _count = 0;
local _num = 1; // This is a safety control to end the loop if incorrect settings are used.
WAI_StaticMarkerReady = true;

if (!WAI_RandomStatic) then {WAI_StaticLimit = count WAI_StaticList;};


while {_count < WAI_StaticLimit && _num < 500} do {
	if (WAI_StaticMarkerReady) then {
		if (WAI_RandomStatic) then {
			_mission = WAI_StaticList call BIS_fnc_selectRandom;
			if !(_mission in _array) then {
				WAI_MissionData = WAI_MissionData + [[0,[],[],[],[],[]]]; // [AI Count, UnitGroups, Crates, AI Vehicles, Vehicles, Objects]
				execVM format["\z\addons\dayz_server\WAI\static\missions\%1.sqf", _mission];
				_array set [count _array, _mission];
				_count = _count + 1;
				WAI_StaticMarkerReady = false;
			};
		} else {
			_mission = WAI_StaticList select _count;
			WAI_MissionData = WAI_MissionData + [[0,[],[],[],[],[]]]; // [AI Count, UnitGroups, Crates, AI Vehicles, Vehicles, Objects]
			execVM format["\z\addons\dayz_server\WAI\static\missions\%1.sqf", _mission];
			_count = _count + 1;
			WAI_StaticMarkerReady = false;
		};
		_num = _num + 1;
	};
	uiSleep 1;
};