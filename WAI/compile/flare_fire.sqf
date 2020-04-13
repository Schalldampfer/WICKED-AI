private ["_weapon","_magazine","_flareMuz","_flareMag","_mags","_interval","_grp","_unit","_pos","_invT"];

//settings
_weapon = "AK74_GL_DZ"; // Classname of weapon with GP25/M203
_flareMuz = "GP25Muzzle"; // Muzzle name of GP25/M203
_flareMag = ["FlareWhite_GP25","FlareGreen_GP25","FlareRed_GP25","FlareYellow_GP25"] call BIS_fnc_selectRandom; // Classname of flare magazine
_magazine = _weapon call find_suitable_ammunition; // Classname of normal magazine
_mags = 3; // No. of Normal magazines
_interval = 150; //Interval of firing in seconds

//_this = group;
_grp = _this;
_unit = leader _this;
if (wai_debug_mode) then {diag_log format["WAI: Preparing Flare of %1",name _unit];};

//add GP25 weapon & flare
_unit removeMagazines ((primaryWeapon _unit) call find_suitable_ammunition);
_unit removeWeapon (primaryWeapon _unit);
_unit addWeapon _weapon;
for "_i" from 1 to _mags do {
	_unit addMagazine _magazine;
};
_unit addMagazine _flareMag;
sleep (random 8);

//check night and GP25
while {alive _unit} do {
	if (sunOrMoon != 1) then {
		//find target in range
		_targ = _unit;
		{
			if (alive _x && ((_grp knowsAbout _x) > 1.5 || !terrainIntersectASL [aimPos _unit,aimPos _x]) && (_unit distance _targ) < 1300) then {_targ = _x};
		} forEach playableUnits;
		//if found
		if (_targ != _unit) then {
			if (wai_debug_mode) then {diag_log format["WAI: Firing Flare on %1",name _targ];};
			//aim target pos
			_pos = getPos _targ;
			_invT = "HeliHEmpty" createVehicle _pos;
			_invT setPos [(_pos select 0)+(random 20),(_pos select 1)+(random 20),(_unit distance _targ)/10.0];
			sleep 0.5;
			_unit selectWeapon _flareMuz;
			_unit doTarget _invT;
			sleep 0.5;
			//fire
			_unit selectWeapon _flareMuz;
			_unit fire [_flareMuz, _flareMuz, _flareMag];
			deleteVehicle _invT;
			//refill
			_unit addMagazine _flareMag;
		};
	};

	//wait
	sleep _interval;
};
