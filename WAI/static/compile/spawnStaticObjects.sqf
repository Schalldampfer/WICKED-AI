// This is a modified version of the DayZ Epoch file fn_spawnObjects.sqf used to spawn WAI mission objects with static coordinates.

local _fires = [
	"Base_Fire_DZ",
	"flamable_DZ",
	"Land_Camp_Fire_DZ",
	"Land_Campfire",
	"Land_Campfire_burning",
	"Land_Fire",
	"Land_Fire_burning",
	"Land_Fire_DZ",
	"Land_Fire_barrel",
	"Land_Fire_barrel_burning",
	"Misc_TyreHeap"
];

// Override god mode on these objects so they can be destroyed if WAI_GodModeObj enabled.
local _destructables = [
	"Gold_Vein_DZE",
	"Iron_Vein_DZE",
	"Silver_Vein_DZE",
	"Supply_Crate_DZE"
];

// Mission objects that need to be locked so players can't access them.
local _locked = [
	//"MQ9PredatorB"
];

{
	local _type = _x select 0;
	local _pos = _x select 1;
	local _object = _type createVehicle [0,0,0];
	local _vectordirandup = false;
	local _vector = nil;
	//diag_log format ["SpawnStaticObjects current object type: %1",_type];
	
	if (_type in _locked) then {
		_object setVehicleLock "LOCKED";
	};
	
	if (count _x > 3) then {
		_vector = _x select 3; // [0,0,1] = setVectorUp, [[],[]] = setVectorDirAndUp
		if (typeName (_vector select 0) == "ARRAY") then {
		//if (count _vector == 2) then {
			_vectordirandup = true;
		};
	} else {
		_object setDir (_x select 2);
	};
	
	if (!_vectordirandup) then { // You don't need to set direction if vectorDir is used.
		_object setDir (_x select 2);
	};
	
	_object setPos _pos;
	
	if (!isNil "_vector") then {
		if (_vectordirandup) then {
			_object setVectorDirAndUp _vector;
		} else {
			_object setVectorUp _vector;
		};
	};
	
	if (WAI_GodModeObj) then {
		if !(_type in _destructables) then {
			_object addEventHandler ["HandleDamage",{0}];
			if !(_type in _fires) then {_object enableSimulation false;};
		};
	};
} count _this;
