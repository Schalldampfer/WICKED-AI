private["_unit","_selection","_damage","_source","_ammo"];

_unit = 		_this select 0;
_selection =	_this select 1;
_damage = 		_this select 2;
_source = 		_this select 3;
_ammo = 		_this select 4;

if (_source == _unit) exitWith {0};
if !(_ammo isKindOf "Default") exitWith {0};

if (({_ammo isKindOf _x} count ["B_127x99_Ball","B_127x107_Ball","RocketBase","ARTY_Sh_Base","Sh_122_HE","120mmHE_M120","BombCore"]) > 0) then {
	_damage = _damage * 0.125;
};

if (WAI_Overpoch) then { //Taser for OVP
	_this call DDOPP_taser_handleHit;
};

if (isPlayer _source) then {
	if (_selection == "head_hit") then {
		if (!(_unit getVariable["hitRegistered",false])) then {
			_source setVariable["headShots",(_source getVariable["headShots",0]) + 1,true];
			_unit setVariable["hitRegistered",true];
		};
	};
};

_damage
