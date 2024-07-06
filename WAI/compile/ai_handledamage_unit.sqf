private["_unit","_selection","_damage","_source","_ammo","_isMan"];

_unit = 		_this select 0;
_selection =	_this select 1;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};
//if !(_ammo isKindOf "Default") exitWith {0};

if (isPlayer _source) then {
	if (_selection == "head_hit") then {
		if (!(_unit getVariable["hitRegistered",false])) then {
			_source setVariable["headShots",(_source getVariable["headShots",0]) + 1,true];
			_unit setVariable["hitRegistered",true];
		};
	};
	if (_selection == "") then {
		{_x reveal [_source, 1.5];} forEach units group _unit;
		_unit suppressFor 1;
	};
};

_damage
