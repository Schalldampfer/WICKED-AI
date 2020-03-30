private["_vehicle","_type","_inGear","_turretCount","_ammo","_rmWeapons"];

_vehicle = _this select 0;
_type = _this select 1;

if (count _this > 2) then {
	_inGear = _this select 2;
};

if(_vehicle isKindOf "ZU23_base") exitWith {
	_vehicle removeMagazines "40Rnd_23mm_AZP85";
	_vehicle removeWeapon "2A14";
	_vehicle addMagazine "1904Rnd_30mmAA_2A38M";
	_vehicle addWeapon "2A38M";
};

if(_vehicle isKindOf "Ural_ZU23_Base") exitWith {
	_vehicle addMagazine "2000Rnd_23mm_AZP85";
	_vehicle removeMagazines "40Rnd_23mm_AZP85";
};

if(_type == "KORD_high_TK_EP1") exitWith {
	_vehicle addMagazine "500Rnd_145x115_KPVT";
	_vehicle addMagazine "500Rnd_145x115_KPVT";
	_vehicle addMagazine "500Rnd_145x115_KPVT";
	_vehicle addWeapon "KPVT";
	_vehicle removeWeapon "KORD";
	_vehicle removeMagazines "50Rnd_127x108_KORD";
};

if(_type == "KORD_high_UN_EP1") exitWith {
	_vehicle addMagazine "2000Rnd_762x54_PKT";
	_vehicle addMagazine "2000Rnd_762x54_PKT";
	_vehicle addWeapon "PKT_MG_Nest";
	_vehicle removeWeapon "KORD";
	_vehicle removeMagazines "50Rnd_127x108_KORD";
};

if(_vehicle isKindOf "BAF_L2A1_ACOG_base") exitWith {
	_vehicle addMagazine "250Rnd_127x99_M3P";
	_vehicle addMagazine "250Rnd_127x99_M3P";
	_vehicle addWeapon "M3P";
	_vehicle removeWeapon "BAF_L2A1";
	_vehicle removeMagazines "100Rnd_127x99_M2";
};

if(_type == "TOW_TriPod_US_EP1") exitWith {
	_vehicle removeMagazine "6Rnd_TOW_HMMWV";
	_vehicle addMagazine "6Rnd_TOW2";
	_vehicle addMagazine "6Rnd_TOW2";
};

if(_type in ["Igla_AA_pod_East","Stinger_Pod"]) exitWith {
	_vehicle addWeapon "9M311Laucher";
	_vehicle addMagazine "8Rnd_9M311";
};

if(_type == "GNT_C185U_DZ") exitWith {
	_vehicle addWeapon "AirBombLauncher";
	_vehicle addMagazine "4Rnd_FAB_250";
	_vehicle addMagazine "4Rnd_FAB_250";
};

if(_type == "UH60M_EP1") exitWith {
	_vehicle addMagazineTurret ["4Rnd_AT3", [0]];
	_vehicle addMagazineTurret ["4Rnd_AT3", [1]];
	_vehicle addWeaponTurret ["AT3Launcher", [0]];
	_vehicle addWeaponTurret ["AT3Launcher", [1]];
	_vehicle addMagazineTurret ["4Rnd_Stinger", [0]];
	_vehicle addMagazineTurret ["4Rnd_Stinger", [1]];
	_vehicle addWeaponTurret ["StingerLaucher_4x", [0]];
	_vehicle addWeaponTurret ["StingerLaucher_4x", [1]];
};

//Refill _DZE vehicle's turret
_turretCount = count (configFile >> "CfgVehicles" >> _type >> "turrets");
for "_i" from 0 to (_turretCount) do {
	{
		_ammoArray = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
		if (count _ammoArray > 0) then {
			_ammo = _ammoArray select 0;
			if !(_ammo in (_vehicle magazinesTurret [_i])) then {
				_vehicle addMagazineTurret [_ammo,[_i]];
				//diag_log format["WAI: Load %1 %2(%4) with %3",_type,_x,_ammo,_i];
			};
			if !(isNil "_inGear") then {
				_vehicle addMagazineCargoGlobal [_ammo,_inGear];
				//diag_log format["WAI: inGear %1 %2(%4) with %3",_type,_x,_ammo,_i];
			};
		};
		//diag_log format["WAI: Load %1 %2 %3/%4",_x,_ammoArray,_i,_turretCount];
	} forEach (_vehicle weaponsTurret [_i]);
	//diag_log format["WAI: has %1 %2/%3",(_vehicle weaponsTurret [_i]),_i,_turretCount];
};

//Remove AGMs
_rmWeapons = [
	"CRV7_PG","HellfireLauncher","AT2Launcher","AT6Launcher","AT9Launcher","VikhrLauncher","MaverickLauncher","Ch29Launcher","Ch29Launcher_Su34"
];
if (_vehicle isKindOf "Air") then {
	for "_i" from 0 to (_turretCount + 1) do {
		{
			private ["_am"];
			if (_x in _rmWeapons) then {
				_am = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
				{
					_vehicle removeMagazinesTurret [_x,[_i - 1]];
				} forEach _am;
			};
		} foreach (_vehicle weaponsTurret [_i - 1]);
	};
	{
		private ["_am"];
		if (_x in _rmWeapons) then {
			_am = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
			{
				_vehicle removeMagazines _x;
			} forEach _am;
		};
	} foreach (weapons _vehicle);
};

if(_type in ["SectorMG_Ori","SectorMG2_Ori"]) exitWith {
	_vehicle addWeapon "M2BC";
};
