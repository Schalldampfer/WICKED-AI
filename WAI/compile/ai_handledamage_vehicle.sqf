private["_unit","_damage","_source","_ammo"];

_unit = 		_this select 0;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};

if (isPlayer _source) then {_unit doTarget _source;};

if !(_ammo isKindOf "Default") then {
	diag_log format["[Dmg] %1 on %2 from %3",_ammo,typeOf _unit,_source];
	_damage = 0;
};

if ((_this select 1) == "" && !isPlayer _source) then {
	diag_log format["[Dmg] %1(%2) on %3 from %4",_damage,_ammo,typeOf _unit,_source];
};

_damage
