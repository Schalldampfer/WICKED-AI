local _loot = _this select 0;
local _type = _this select 1;
local _posArray = _this select 2;
local _mission = _this select 3;
local _position = _posArray select 0;
local _dir = 0;

if (count _posArray > 1) then {
	_position = _posArray call BIS_fnc_selectRandom;
};

local _pos = _position select 0;

if (count _position > 1) then {
	_dir = _position select 1;
};

local _pos = [(_pos select 0), (_pos select 1), ([0, (_pos select 2)] select (count _pos == 3))];

if (typeName _type == "ARRAY") then {
	_type = _type call BIS_fnc_selectRandom;
};

local _crate = _type createVehicle [0,0,0];

_crate setDir _dir;

if (surfaceIsWater _pos) then {
	_crate setPosASL _pos;
} else {
	_crate setPosATL _pos;
};

_crate setVariable ["permaLoot",true];
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
_crate addEventHandler ["HandleDamage", {0}];
_crate enableSimulation false;
((WAI_MissionData select _mission) select 2) set [count ((WAI_MissionData select _mission) select 2), [_crate,_loot]];