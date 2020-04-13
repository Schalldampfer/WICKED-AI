private["_unit","_damage","_source","_ammo"];

_unit = 		_this select 0;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};
if !(_ammo isKindOf "Default") exitWith {0};

if (isPlayer _source) then {_unit doTarget _source;_x suppressFor 1;};

if (({_ammo isKindOf _x} count ["RocketBase","ARTY_Sh_Base","Sh_122_HE","Sh_82_HE","Sh_81_HE","120mmHE_M120","BombCore"]) > 0) then {
	if (isNull (effectiveCommander _source)) then {
		_damage = 0;
	} else {
		if ((_unit distance _source) > 1570) then {
			_damage = 0;
		} else {
			_damage = _damage * 0.07;
		};
	};
};

_damage
