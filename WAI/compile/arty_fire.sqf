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

_mission = (leader _battery) getVariable ["mission" + dayz_serverKey, 0];
_unitGroups = (WAI_MissionData select _mission) select 1;
_side = side _battery;

while {{alive gunner _x} count _arty > 0} do {
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
			_rnd = round(random 2) + 2;
			if (random 1 < 0.25) then {
				if (sunOrMoon != 1) then {
					_ammo="ILLUM";
				} else {
					_ammo="WP";
				};
			} else {
				_ammo = "HE";
				if (vehicle _player == _player) then {
					_r = 6 + random 14;
					_t = random 360;
					_pos = [(_pos select 0) + (_r*sin(_t)), (_pos select 1) + (_r*cos(_t)), _pos select 2];
				};
			};
			_fmTemplate = ["IMMEDIATE", _ammo, 5.0 + (random 5), _rnd];

			//in range
			if ([_logic, _pos, _fmTemplate select 1] call BIS_ARTY_F_PosInRange && {(side _x) == _side} count (_player nearEntities ["CAManBase", 40]) < 1 && {_player distance (_x select 0) < (_x select 1)} count DZE_SafeZonePosArray < 1) then {
				//fire
				[_logic, _pos, _fmTemplate] call BIS_ARTY_F_ExecuteTemplateMission;
				if (wai_debug_mode) then {diag_log format["WAI:Firing %3 on %4 at %2 by %1",_logic, _pos, _fmTemplate, name _player];};
				RemoteMessage = ["dynamic_text",["You are under artillery fire!","Get out of here!"],["0.40","#FFFFFF","0.60","#ff3300",0,-.35,10,0.5]];
				(owner _player) publicVariableClient "RemoteMessage";

				sleep (random _time/2);
			};
		};
	} forEach playableUnits;
	if (wai_debug_mode) then {diag_log format["WAI:Fire mission check by %1 is finished. Wait %2 sec",_logic,_time];};

	sleep _time;
};

if (wai_debug_mode) then {diag_log format["WAI:Fire mission by %1 has finished",_logic];};
deleteVehicle _logic;
