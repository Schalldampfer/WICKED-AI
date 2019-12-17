private["_unit","_damage","_source","_ammo"];

_unit = 		_this select 0;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};

{
	if (_ammo isKindOf _x) then {
		_damage = _damage * 0.1;
	};
} foreach ["M_Stinger_AA","M_Strela_AA","M_R73_AA","M_Sidewinder_AA","M_9M311_AA"];

if (({_ammo isKindOf _x} count ["RocketBase","ARTY_Sh_Base","Sh_122_HE","Sh_82_HE","Sh_81_HE","120mmHE_M120"]) > 0) then {
	if (isNull _source) then {
		_damage = 0;
	} else {
		if ((_unit distance _source) > 1570) then {
			_damage = 0;
		};
	};
};

if (isPlayer _source) then {_unit doTarget _source;};

_damage
