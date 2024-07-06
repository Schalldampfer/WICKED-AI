private["_unit","_part","_damage","_source","_ammo"];

_unit = 		_this select 0;
_part = 		_this select 1;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};
if !(_ammo isKindOf "Default") exitWith {0};

if (isPlayer _source) then {_unit doTarget _source;_x suppressFor 1;};

if (_part == "") then {_damage = _damage * 0.5;};

_damage
