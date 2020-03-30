private ["_arty","_logic","_fmTemplate","_pos","_ammo","_battery","_time","_knowsAbout"];

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

while {{alive _x} count _arty > 0} do {
	//interval
	_time = 60 + (random 30);

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
		//find position
		_pos = getPosASL _x;
		_pos = [(_pos select 0) - 15 + (random 30),(_pos select 1) - 15 + (random 30),_pos select 2];

		//target found or not
		_knowsAbout = _battery knowsAbout _x;
		if (_knowsAbout > 1.5 && !((vehicle _x) isKindOf "Air")) then {
			//ammo selection
			_ammo = "HE";
			if (sunOrMoon != 1 && random 1 < 0.2) then {
				_ammo="ILLUM";
			};
			_fmTemplate = ["IMMEDIATE", _ammo, 10.0/_knowsAbout, round(_knowsAbout - 1)];

			//in range
			if ([_logic, _pos, _fmTemplate select 1] call BIS_ARTY_F_PosInRange && {!isPlayer _x} count (_x nearEntities ["CAManBase", 40]) < 1) then {
				//fire
				[_logic, _pos, _fmTemplate] call BIS_ARTY_F_ExecuteTemplateMission;
				if (wai_debug_mode) then {diag_log format["WAI:Firing %3 on %4 at %2 by %1",_logic, _pos, _fmTemplate, name _x];};

				sleep (random _time);
			};
		};
	} forEach playableUnits;
	if (wai_debug_mode) then {diag_log format["WAI:Fire mission check by %1 is finished. Wait %2 sec",_logic,_time];};

	sleep _time;
};

if (wai_debug_mode) then {diag_log format["WAI:Fire mission by %1 has finished",_logic];}
deleteVehicle _logic;
