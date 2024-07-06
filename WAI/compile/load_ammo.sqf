/*
	Add Ammo to the turrets and gear of DZE vehicles.
	
	Note: Most of the helicopters can have flares added with the line below if you want.
	TURRET("60Rnd_CMFlareMagazine",-1) // also uses "120Rnd_CMFlareMagazine","240Rnd_CMFlareMagazine","60Rnd_CMFlare_Chaff_Magazine","120Rnd_CMFlare_Chaff_Magazine","240Rnd_CMFlare_Chaff_Magazine"
	
	Caution: Ammo like Hydras and Sidewinders will result in Battleye kicks. You will have to add exceptions to createVehicle.txt.
*/

#define GEAR(mag) if !(isNil "_inGear") then {_vehicle addMagazineCargoGlobal [mag,_inGear];};
#define TURRET(mag,num) _vehicle addMagazineTurret [mag,[num]];

local _vehicle = _this select 0;
local _type = _this select 1;
local _inGear = nil;

if (count _this > 2) then {
	_inGear = _this select 2;
};

if(_type == "HMMWV_Avenger") exitWith {
	_vehicle addMagazine "8Rnd_Sidewinder_AH64";
	_vehicle addMagazine "8Rnd_Sidewinder_AH64";
	_vehicle addWeapon "SidewinderLaucher_AH64";
	_vehicle removeMagazines "8Rnd_Stinger";
	_vehicle removeWeapon "StingerLaucher";
};

if(_type == "BAF_GPMG_Minitripod_W") exitWith {
	_vehicle addMagazine "200Rnd_762x54_PKT";
	_vehicle addMagazine "200Rnd_762x54_PKT";
	_vehicle addWeapon "PKT_high_AI_dispersion";
	_vehicle removeMagazines "200Rnd_762x54_GPMG";
	_vehicle removeWeapon "BAF_L7A2";
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
	_vehicle addWeapon "PKT_high_AI_dispersion";
	_vehicle removeWeapon "KORD";
	_vehicle removeMagazines "50Rnd_127x108_KORD";
};

if(_type == "ZU23_Ins") exitWith {
	_vehicle addMagazine "1904Rnd_30mmAA_2A38M";
	_vehicle addMagazine "1904Rnd_30mmAA_2A38M";
	_vehicle addWeapon "2A38M";
	_vehicle removeWeapon "2A14";
	_vehicle removeMagazines "40Rnd_23mm_AZP85";
};

if(_type in ["Igla_AA_pod_TK_EP1","Stinger_Pod"]) exitWith {
	_vehicle addMagazine "8Rnd_9M311";
	_vehicle addMagazine "8Rnd_9M311";
	_vehicle addWeapon "9M311Laucher";
	_vehicle removeWeapon "StingerLauncher_twice";
	_vehicle removeWeapon "Igla_twice";
	_vehicle addMagazine "4Rnd_AT3";
	_vehicle addWeapon "AT3Launcher";
};

if(_type in ["Igla_AA_pod_East","Stinger_Pod_US_EP1"]) exitWith {
	_vehicle addMagazine "4Rnd_R73";
	_vehicle addMagazine "4Rnd_R73";
	_vehicle addMagazine "4Rnd_R73";
	_vehicle addWeapon "R73Launcher";
	_vehicle addMagazine "5Rnd_AT11_T90";
	_vehicle addWeapon "AT11LauncherSingle";
};

//if (_type == "Ka137_MG_PMC") exitWith {
//	_vehicle removeWeapon "PKT_high_AI_dispersion";
//	_vehicle addWeapon "PKT_MG_Nest";
//};

//Refill _DZE vehicle's turret
_turretCount = count (configFile >> "CfgVehicles" >> _type >> "turrets");
for "_i" from -1 to (_turretCount) do {
	{
		_ammoArray = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
		if (count _ammoArray > 0) then {
			_ammo = _ammoArray select 0;
			if !(_ammo in (_vehicle magazinesTurret [_i])) then {
				 TURRET(_ammo,_i)
				 TURRET(_ammo,_i)
				 TURRET(_ammo,_i)
				if (_x in ["SPG9","RBS70","M32_heli","Igla_twice","AALauncher_twice","StingerLauncher_twice"]) then {
					for "_i" from 1 to 10 do {
						 TURRET(_ammo,_i)
					};
				};
				//diag_log format["WAI: Load %1 %2(%4) with %3",_type,_x,_ammo,_i];
			};
			GEAR(_ammo)
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
