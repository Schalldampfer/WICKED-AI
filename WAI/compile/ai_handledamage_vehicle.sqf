private["_unit","_damage","_source","_ammo"];

_unit = 		_this select 0;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};

if (isPlayer _source) then {_unit doTarget _source;};

if !(_ammo isKindOf "Default") then {
	diag_log format["[Dmg] %1 from %2",_ammo,_source];
	_damage = 0;
};

_damage
