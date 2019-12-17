private["_unit","_damage","_source","_ammo"];

_unit = 		_this select 0;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (WAI_Overpoch) then { //Taser for OVP
	_this call DDOPP_taser_handleHit;
};

if (_ammo == "") exitWith {0};

{
	if (_ammo isKindOf _x) exitWith {
		_damage = _damage * 0.10;
	};
} foreach ["M_Stinger_AA","M_Strela_AA","M_R73_AA","M_Sidewinder_AA","M_9M311_AA"];

if !(_ammo isKindOf "Default") then {
	diag_log format["[Dmg] %1 from %2",_ammo,_source];
};

_damage
