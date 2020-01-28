private ["_ainum","_vehicle","_aiskin","_skin","_mission","_aitype","_aicskill", "_gunner", "_wpnum","_radius","_skillarray","_startingpos","_veh_class","_veh","_unitGroup","_pilot","_skill","_position","_wp"];

if (!wai_enable_patrols) exitWith {};

_position		= _this select 0;
_startingpos	= _this select 1;
_radius			= _this select 2;
_wpnum			= _this select 3;
_veh_class		= _this select 4;
_skill			= _this select 5;
_skin			= _this select 6;
_aitype			= _this select 7;

if (count _this > 8) then {
	_mission = _this select 8;
} else {
	_mission = nil;
};

_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

call {
	if(_skill == "easy") 		exitWith { _aicskill = ai_skill_easy; };
	if(_skill == "medium") 		exitWith { _aicskill = ai_skill_medium; };
	if(_skill == "hard") 		exitWith { _aicskill = ai_skill_hard; };
	if(_skill == "extreme") 	exitWith { _aicskill = ai_skill_extreme; };
	if(_skill == "random") 		exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
	_aicskill = ai_skill_random call BIS_fnc_selectRandom;
};

call {
	if(_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
	if(_skin == "hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom; };
	if(_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
	if(_skin == "special") 	exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
	_aiskin = _skin;
};

if(typeName _aiskin == "ARRAY") then {
	_aiskin = _aiskin call BIS_fnc_selectRandom;
};

if(_aitype == "Hero") then {
	_unitGroup	= createGroup RESISTANCE;
} else {
	_unitGroup	= createGroup EAST;
};

_pilot = _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
[_pilot] joinSilent _unitGroup;

call {
	if (_aitype == "hero") 		exitWith {_pilot setVariable ["Hero",true,false]; _pilot setVariable ["humanity", ai_remove_humanity];};
	if (_aitype == "bandit") 	exitWith {_pilot setVariable ["Bandit",true,false]; _pilot setVariable ["humanity", ai_add_humanity];};
	if (_aitype == "special") 	exitWith {_pilot setVariable ["Special",true,false]; _pilot setVariable ["humanity", ai_special_humanity];};
};

_vehicle = createVehicle [_veh_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
_vehicle setFuel 1;
_vehicle engineOn true;
_vehicle setVehicleAmmo 1;
_vehicle addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
_vehicle addEventHandler ["HandleDamage",{_this call WAI_HandleDamage_Vehicle}];
_vehicle addEventHandler ["Killed",{_this call WAI_Killed_Vehicle}];
_vehicle allowCrewInImmobile true; 
_vehicle lock true;
[_vehicle,_veh_class] call load_ammo;

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_vehicle];

_pilot assignAsDriver _vehicle;
_pilot moveInDriver _vehicle;

_turretCount = count (configFile >> "CfgVehicles" >> _veh_class >> "turrets");
for "_i" from 0 to (_turretCount - 1) do {
	_gunner = _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
	_gunner assignAsGunner _vehicle;
	_gunner moveInTurret [_vehicle,[_i]];
	
	[_gunner] joinSilent _unitGroup;
	
	{
		_gunner 	setSkill [(_x select 0),(_x select 1)];
	} count _aicskill;
};

call {
	if (_aitype == "Hero") 		exitWith {{ _x setVariable ["Hero",true,false]; _x setVariable ["humanity", ai_remove_humanity];} count (units _unitgroup); };
	if (_aitype == "Bandit") 	exitWith {{ _x setVariable ["Bandit",true,false]; _x setVariable ["humanity", ai_add_humanity];} count (units _unitgroup); };
	if (_aitype == "Special") 	exitWith {{ _x setVariable ["Special",true,false]; _x setVariable ["humanity", ai_special_humanity];} count (units _unitgroup); };
};

{
	_pilot setSkill [_x,1]
} count _skillarray;

{
	_x addWeapon "Makarov_DZ";
	_x addMagazine "8Rnd_9x18_Makarov";
	_x addMagazine "8Rnd_9x18_Makarov";
	if (sunOrMoon != 1) then {
		_x addweapon "NVGoggles";
	};
	_x setVariable ["bodyName",(name _x)];
} count (units _unitgroup);

{
	_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];
	_x addEventHandler ["HandleDamage",{_this call WAI_HandleDamage_Unit}];
} forEach (units _unitgroup);

if (!isNil "_mission") then {
	_vehicle setVariable ["mission" + dayz_serverKey, _mission, false];
	
	((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _unitGroup];
	((wai_mission_data select _mission) select 4) set [count ((wai_mission_data select _mission) select 4), _vehicle];
	{
		_ainum = (wai_mission_data select _mission) select 0;
		wai_mission_data select _mission set [0, (_ainum + 1)];
		_x setVariable ["mission" + dayz_serverKey, _mission, false];
		_x setVariable ["noKey",true];
	} count (crew _vehicle);
} else {
	{wai_static_data set [0, ((wai_static_data select 0) + 1)];} count (crew _vehicle);
	(wai_static_data select 1) set [count (wai_static_data select 1), _unitGroup];
	(wai_static_data select 2) set [count (wai_static_data select 2), _vehicle];
};

_unitGroup allowFleeing 0;

if(_aitype == "Hero") then {
	_unitGroup setCombatMode ai_hero_combatmode;
	_unitGroup setBehaviour ai_hero_behaviour;
} else {
	_unitGroup setCombatMode ai_bandit_combatmode;
	_unitGroup setBehaviour ai_bandit_behaviour;
};

if(_wpnum > 0) then {

	for "_x" from 1 to _wpnum do
	{		
		_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
		_wp setWaypointType "SAD";
		_wp setWaypointCompletionRadius 200;
	};

};

if (_veh_class in ["ori_ZAZ968M","ori_taviander","ori_buchanka","ori_m3","ori_maniac","ori_KaTransp","ori_ScrapRaft","ori_bike_d2","ori_col_truck_tent","ori_col_truck_fuel","ori_gaika","ori_rth_originsmod_bathmobile","ori_ScrapBuggy","ori_submarine","ori_bigRaft"]) then {
	_vehicle animate ["hopa",1];
	_vehicle animate ["doska",1];
};

_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 200;

if(wai_debug_mode) then {diag_log format ["WAI: Spawned in %1 %2",_veh_class,_position];};

_unitGroup

