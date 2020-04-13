private ["_arty","_logic","_fmTemplate","_pos","_ammo","_battery","_time","_mission","_unitGroups","_player","_isArty","_side","_r","_t","_rnd"];
_isArty = { /* https://forums.bohemia.net/forums/topic/126834-detect-artillery-capable-vehicles/ */
	private ["_class","_result"];
	_class = typeOf _this;
	_result = false;
	if (isNumber (configFile >> "CfgVehicles" >> _class >> "artilleryScanner")) then {
		_result = getNumber (configFile >> "CfgVehicles" >> _class >> "artilleryScanner") > 0;
	};
	_result
};

//arty logic
_logic = createAgent ["BIS_ARTY_Logic",[0,0,0],[],0,"NONE"];

_battery = _this;
_arty = [];
{
	_arty set [count _arty, vehicle _x];
	_logic synchronizeObjectsAdd [vehicle _x];
	[vehicle _x] call BIS_ARTY_F_initVehicle;
} forEach (units _battery);

[_logic] call BIS_ARTY_F_Firebase;
if (wai_debug_mode) then {diag_log format["WAI:Fire mission starting by %1",_logic];};

_mission = (leader _battery) getVariable ["mission" + dayz_serverKey, nil];
_unitGroups = wai_static_data select 1;
if (!isNil "_mission") then {
	_unitGroups = (wai_mission_data select _mission) select 1;
};
_side = side _battery;

while {{alive _x} count _arty > 0} do {
	//interval
	_time = 60 + (random 60);

	//check ammo
	{
		if (needReload _x == 1) then {
			_x addMagazine "8Rnd_81mmHE_M252";
			_x addMagazine "8Rnd_82mmHE_2B14";
			_x addMagazine "8Rnd_81mmILLUM_M252";
			_x addMagazine "8Rnd_82mmILLUM_2B14";
			if (wai_debug_mode) then {diag_log format["WAI:Reloading mortar rounds of %2 by %1",_logic, typeOf _x];};
		};
	} forEach _arty;

	//check players
	{
		_player = _x;

		//find position
		_pos = getPosASL _player;

		//target found or not
		if ({_x knowsAbout _player > 1.5} count _unitGroups > 0 && !((vehicle _player) isKindOf "Air") || (vehicle _player) call _isArty) then {
			//ammo selection
			if (random 1 < 0.2) then {
				if (sunOrMoon != 1) then {
					_ammo="ILLUM";
					_rnd = 1;
				} else {
					_ammo="WP";
					_rnd = 2;
				};
			} else {
				_ammo = "HE";
				_rnd = round(random 2) + 2;
				if (vehicle _player == _player) then {
					_r = 6 + random 14;
					_t = random 360;
					_pos = [(_pos select 0) + (_r*sin(_t)), (_pos select 1) + (_r*cos(_t)), _pos select 2];
				};
			};
			_fmTemplate = ["IMMEDIATE", _ammo, 5.0 + (random 5), _rnd];

			//in range
			if ([_logic, _pos, _fmTemplate select 1] call BIS_ARTY_F_PosInRange && {(side _x) == _side} count (_player nearEntities ["CAManBase", 40]) < 1) then {
				//fire
				[_logic, _pos, _fmTemplate] call BIS_ARTY_F_ExecuteTemplateMission;
				if (wai_debug_mode) then {diag_log format["WAI:Firing %3 on %4 at %2 by %1",_logic, _pos, _fmTemplate, name _x];};

				sleep (random _time/2);
			};
		};
	} forEach playableUnits;
	if (wai_debug_mode) then {diag_log format["WAI:Fire mission check by %1 is finished. Wait %2 sec",_logic,_time];};

	sleep _time;
};

if (wai_debug_mode) then {diag_log format["WAI:Fire mission by %1 has finished",_logic];};
deleteVehicle _logic;
