WAI_GetTurrets = {
	// Adapted from KillZone Kid's KK_fnc_commonTurrets for Arma3.
	local _array = [];
	local _turrets = configFile >> "CfgVehicles" >> _this >> "Turrets";
	
	for "_i" from 0 to count _turrets - 1 do {
		_array set [count _array, [_i]];
	};
	_array
};

WAI_FindAmmo = {
	local _result = "";
	local _weapon = _this;
	local _array = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _array > 0) then {
		_result = _array select 0;
		call {
			if (_result == "20Rnd_556x45_Stanag") exitWith { _result = "30Rnd_556x45_Stanag"; };
			if (_result == "8Rnd_B_Saiga12_74Slug") exitWith { _result = "8Rnd_B_Saiga12_Pellets"; };
			if (_result == "8Rnd_12Gauge_Slug") exitWith { _result = "8Rnd_12Gauge_Buck"; };
			if (_result == "PG7V") exitWith { _result = "PG7VL"; };
		};
	};
	if (_result == "") then {
		diag_log format["WAI: Cannot find magazine for weapon - %1.", _weapon];
	};
	_result
};

WAI_SpawnCrate = {
	local _crates = _this select 0;
	local _pos = _this select 1;
	local _mission = _this select 2;
	local _z = [0, (_pos select 2)] select (count _pos == 3);
	
	{	
		local _loot = _x select 0;
		local _type = _x select 1;
		local _offset = _x select 2;
		
		local _position = [(_pos select 0) + (_offset select 0), (_pos select 1) + (_offset select 1), _z];
		
		if (count _offset > 2) then {
			_position set [2, (_offset select 2)];
		}; 
		
		if (typeName _type == "ARRAY") then {
			_type = _type call BIS_fnc_selectRandom;
		};
		
		local _crate = _type createVehicle [0,0,0];
		
		if (count _x > 3) then {
			_crate setDir (_x select 3);
		};
		
		if (surfaceIsWater _position) then {
			_crate setPosASL _position;
		} else {
			_crate setPos _position;
		};
		
		_crate setVariable ["permaLoot",true];
		clearWeaponCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		_crate addEventHandler ["HandleDamage", {0}];
		_crate enableSimulation false;
		((WAI_MissionData select _mission) select 2) set [count ((WAI_MissionData select _mission) select 2), [_crate,_loot]];
	} count _crates;
};

WAI_Message = {
	local _type = _this select 0;
	local _message = _this select 1;
	
	call {
		if (WAI_MessageType == "Radio") exitWith {
			RemoteMessage = ["radio",_message];
		};		
		if (WAI_MessageType == "DynamicText") exitWith {
			local _color = call {
				if(_type == "Easy") exitWith {"#00cc00"};
				if(_type == "Medium") exitWith {"#ffff66"};
				if(_type == "Hard") exitWith {"#990000"};
				if(_type == "Extreme") exitWith {"#33334d"};
				"#3339FF";
			};
			local _params = ["0.40","#FFFFFF","0.60",_color,0,-.35,10,0.5];
			RemoteMessage = ["dynamic_text", ["STR_CL_MISSION_ANNOUNCE",_message],_params];
		};		
		if (WAI_MessageType == "titleText") exitWith {
			RemoteMessage = ["titleText",_message];
		};
	};
	publicVariable "RemoteMessage";
};

WAI_AutoClaimAlert = {
	local _unit = _this select 0;
	local _mission = _this select 1;
	local _type = _this select 2;
	local _name = if (typeName _unit == "ARRAY") then {_unit select 1;} else {name _unit;};
	local _message = call {
		if (_type == "Start") exitWith {["STR_CL_AUTOCLAIM_ANNOUNCE",_mission,WAI_AcDelayTime];};
		if (_type == "Stop") exitWith {["STR_CL_AUTOCLAIM_NOCLAIM",_mission];};
		if (_type == "Return") exitWith {["STR_CL_AUTOCLAIM_RETURN",WAI_AcTimeout];};
		if (_type == "Reclaim") exitWith {"STR_CL_AUTOCLAIM_RECLAIM";};
		if (_type == "Claimed") exitWith {["STR_CL_AUTOCLAIM_CLAIM",_name,_mission];};
		if (_type == "Unclaim") exitWith {["STR_CL_AUTOCLAIM_ABANDON",_name,_mission];};
	};
	
	if (_type == "Claimed" || _type == "Unclaim") exitWith {
		RemoteMessage = ["IWAC",_message];
		publicVariable "RemoteMessage";
	};
	
	RemoteMessage = ["IWAC",_message];
	(owner _unit) publicVariableClient "RemoteMessage";
};

WAI_VehMonitor = {
	{
		if (alive _x && ({alive _x} count crew _x > 0)) then {
			_x setVehicleAmmo 1;
			_x setFuel 1;
		} else {
			_x setDamage 1;
		};
	} count _this;
};

WAI_CleanUp = {
	local _position = _this select 0;
	local _mission = _this select 1;
	local _objects = _this select 2;
	local _vehicles = _this select 3;
	local _crates = _this select 4;
	local _groups = _this select 5;
	local _aiVehicles = _this select 6;
	local _posIndex = _this select 7;
	local _time0ut = _this select 8;
	local _cleaned = false;
	local _time = diag_tickTime;
	
	while {!_cleaned} do {
		if (count _aiVehicles > 0) then {
			_aiVehicles call WAI_VehMonitor;
		};
		uiSleep 3;	
		if (WAI_CleanMissionTime > 0 || _time0ut) then {
			if ((diag_tickTime - _time) > (WAI_CleanMissionTime * 60) || _time0ut) then {
				
				// delete mission objects
				{
					deleteVehicle _x;
				} count _objects;
				
				// delete vehicles if they are not claimed
				{
					if (_x getVariable ["mission" + dayz_serverKey, nil] == _mission) then {
						_x call sched_co_deleteVehicle;
					};
				} count _vehicles;
				
				// Delete Remaining AI that are alive
				{
					if (_x getVariable ["mission" + dayz_serverKey, nil] == _mission) then {
						_x call sched_co_deleteVehicle;
					};
				} count allunits;
				
				// Delete AI Vehicles
				{
					_x call sched_co_deleteVehicle;
				} count _aiVehicles;
				
				// delete mission crates if enabled
				if (WAI_CleanMissionCrate || _time0ut) then {
					if (count _crates > 0) then {
						// Wait until players are at least 50 meters away
						if !([_position,50] call isNearPlayer) then {
							{
								deleteVehicle (_x select 0);
							} count _crates;
							_cleaned = true;
						};
					};
				} else {
					_cleaned = true;
				};
			};
		};
	};
	DZE_MissionPositions set [_posIndex, -1];
	diag_log format ["[WAI]: Cleanup for mission %1 complete.",_mission];
};

WAI_GenerateVehKey = {
	local _vehicle = _this select 0;
	local _mission = _this select 1;
	local _crates = _this select 2;
		
	if (WAI_VehKeys == "NoVehicleKey") exitWith {
		_vehicle setVariable ["CharacterID","0",true];
		_vehicle setVehicleLock "unlocked";
	};
	
	local _keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
	local _keyNumber = (ceil(random 2500)) + 1;
	local _keySelected = format["ItemKey%1%2",_keyColor,_keyNumber];
	local _isKeyOK = isClass(configFile >> "CfgWeapons" >> _keySelected);
	local _characterID = str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));
	
	if !(_isKeyOK) exitWith {
		_vehicle setVariable ["CharacterID","0",true];
		_vehicle setVehicleLock "unlocked";
		diag_log format["WAI: Failed to generate a key for vehicle %1 at mission %2",_vehicle,_mission];
	};
	
	_vehicle setVariable ["CharacterID",_characterID,true];
	
	if (WAI_VehKeys == "KeyinVehicle") exitWith {
		_vehicle addWeaponCargoGlobal [_keySelected,1];
		_vehicle setVehicleLock "unlocked";
	};
	if (WAI_VehKeys == "KeyinCrate") exitWith {
		local _crate = (_crates call BIS_fnc_selectRandom) select 0;
		_crate addWeaponCargoGlobal [_keySelected, 1];
	};			
	if (WAI_VehKeys == "KeyonAI") exitWith {
		local _ailist = [];
		{
			if ((_x getVariable ["mission" + dayz_serverKey,nil] == _mission) && (_x getVariable ["bodyName",nil] == "mission_ai") && !(_x getVariable ["noKey", false])) then {
				_ailist set [count _ailist, _x];
			};
		} count allDead;
		
		local _unit = _ailist call BIS_fnc_selectRandom;
		_unit addWeapon _keySelected;
		
		if(WAI_DebugMode) then {
			diag_log format["There are %1 Dead AI for mission %2 vehicle key",_ailist,_mission];
			diag_log format["Key added to %1 for vehicle %2",_unit,_vehicle];
		};
	};
};

WAI_CompletionCheck = {
	local _mission = _this select 0;
	local _completionType = _this select 1;
	local _killpercent = _this select 2;
	local _position = _this select 3;
	local _complete = false;
	
	call
	{
		if (_completionType select 0 == "crate") exitWith {

			if (WAI_KillPercent == 0) then {
				_complete = [_position,20] call isNearPlayer;
			} else {
				if (((WAI_MissionData select _mission) select 0) <= _killpercent) then {
					_complete = [_position,20] call isNearPlayer;
				};
			};
		};
		
		if (_completionType select 0 == "kill") exitWith {
			if(((WAI_MissionData select _mission) select 0) == 0) then {
				_complete = true;
			};
		};
		
		if (_completionType select 0 == "assassinate") exitWith {
			local _objectivetarget = _completionType select 1;
			{
				if !(alive _x) exitWith {_complete = true;};
			} count units _objectivetarget;
		};

		/* no missions are using this function at the moment
		if (_completionType == "resource") exitWith {
			_node = _completionType select 1;
			_resource = _node getVariable ["Resource", 0];
			if (_resource == 0) then {
				if ([_position,80] call isNearPlayer) then {
					_complete = true;
				} else {
					_timeout = true;
				};
			};
		}; */
	};
	_complete
};

WAI_CleanAircraft = {
	local _veh = _this select 0;
	local _group = _this select 1;
	uiSleep 60;
	deleteVehicle _veh;
	
	while {(count (wayPoints _group)) > 0} do {
		deleteWaypoint ((wayPoints _group) select 0);
	};
	
	{
		deleteVehicle _x;
	} count (units _group);
	uiSleep 10;
	deleteGroup _group;
	if (WAI_DebugMode) then {diag_log "WAI: Aircraft Cleaned";};
};

WAI_MineField = {
	local _position = _this select 0;
	local _min = _this select 1;
	local _max = _this select 2;
	local _num = _this select 3;
	local _mines = [];
	
	for "_x" from 1 to _num do {
		local _pos = [_position,_min,_max,10,0,2000,0] call BIS_fnc_findSafePos;
		local _mine = "Mine" createVehicle _pos;
		_mines set [count _mines, _mine];
	};
	_mines
};

WAI_Freeze = {
	{
		if !(_x getVariable ["DoNotFreeze", false]) then {
			{
				if (alive _x) then {
					_x disableAI "TARGET";
					_x disableAI "MOVE";
					_x disableAI "FSM";
					_x setVehicleInit "this hideObject true";
				};
			} count units _x;
			processInitCommands;
			
			{
				clearVehicleInit _x;
			} count units _x;
			
			if (WAI_DebugMode) then {diag_log format ["WAI: Freezing Units of Group: %1", _x];};
		};
	} count _this;
};

WAI_UnFreeze = {
	{
		if !(_x getVariable ["DoNotFreeze", false]) then {
			{
				if (alive _x) then {
					_x enableAI "TARGET";
					_x enableAI "MOVE";
					_x enableAI "FSM";
					_x setVehicleInit "this hideObject false";
				};
			} count units _x;
			processInitCommands;
				
			{
				clearVehicleInit _x;
			} count units _x;
			
			if (WAI_DebugMode) then {diag_log format ["WAI: Unfreezing Units of Group: %1", _x];};
		};
	} count _this;
};

WAI_kill_ai = {
	private ["_veh"];
	{
		if (_x getVariable ["mission" + dayz_serverKey, nil] == _this) then {
			_veh = vehicle _x;
			if (_veh != _x) then {
				_veh removeAllEventHandlers "GetOut";
				_x action ["eject", _veh];
				sleep 0.1;
				_veh setDamage 2;
			};
			if (alive _x) then {
				_x playmove (["ActsPercMstpSnonWpstDnon_suicide1B","ActsPercMstpSnonWpstDnon_suicide2B"] call BIS_fnc_selectRandom);
				sleep 8;
				_x fire (currentWeapon _x);
				sleep 0.1;
				_x setDamage 1;
				sleep 0.1;
				_x setVariable ["deathType", "suicide", true];
				removeAllWeapons _x;
				removeAllItems _x;
				_x setVariable ["cashMoney", 0, true];
			};
		};
	} count allUnits;
};

WAI_AbortMission = {
	local _mission = _this select 0;
	local _aiType = _this select 1;
	local _markerIndex = _this select 2;
	local _posIndex = _this select 3;
	local _remove = [];
	
	{
		if (typeName _x == "ARRAY") then {
			_remove set [count _remove, (_x select 1)];
		};
	} count (DZE_ServerMarkerArray select _markerIndex);
	
	PVDZ_ServerMarkerSend = ["end",_remove];
	publicVariable "PVDZ_ServerMarkerSend";

	if (_aiType == "Hero") then {
		WAI_HeroRunning = WAI_HeroRunning - 1;
		WAI_HeroStartTime = diag_tickTime;
	} else {
		WAI_BanditRunning = WAI_BanditRunning - 1;
		WAI_BanditStartTime = diag_tickTime;
	};
	
	WAI_MissionData set [_mission, -1];
	DZE_ServerMarkerArray set [_markerIndex, -1];
	DZE_MissionPositions set [_posIndex, -1];
};

WAI_str_initUpper = {
	private "_strA";
	_strA = toArray(toLower(_this));
	_strA set [0, (_strA select 0) - 32];
	toString(_strA)
};

WAI_spawn_trees = { // Spawn trees around mission
	local _position = _this select 0;
	local _difficulty = _this select 1;
	local _objects = [];

	local _num = switch (toLower _difficulty) do {
		case "easy": {50 + round(random 30)};
		case "medium": {50 + round(random 100)};
		case "hard": {100 + round(random 50)};
		case "extreme": {100 + round(random 100)};
		default {50 + round(random 100)};
	};

	//select 3 tree types
	local _trees = [
		"MAP_t_picea1s","MAP_t_picea2s","MAP_t_picea3f","MAP_t_pinusN1s","MAP_t_pinusN2s","MAP_t_pinusS2f","MAP_t_populus3s",
		"MAP_t_betula1f","MAP_t_betula2s","MAP_t_betula2w","MAP_t_betula2f","MAP_t_fagus2f","MAP_t_fagus2s","MAP_t_fagus2W","MAP_t_malus1s",
		"MAP_t_sorbus2s","MAP_t_quercus2f","MAP_t_quercus3s","MAP_t_pyrus2s","MAP_t_acer2s","MAP_t_fraxinus2W","MAP_t_fraxinus2s",
		"MAP_t_salix2s","MAP_t_alnus2s","MAP_t_carpinus2s","MAP_t_larix3f","MAP_t_larix3s","MAP_t_populus3s"
	];
	local _types = [_trees call BIS_fnc_selectRandom,_trees call BIS_fnc_selectRandom,_trees call BIS_fnc_selectRandom];

	for "_x" from 1 to _num do {
		//find good position
		local _pos = [_position,25 + _num * 1.0,50 + _num * 2.0,5 + (random 5),1,2000,0] call BIS_fnc_findSafePos;
		if ((!isOnRoad _pos) && (!surfaceIsWater _pos) && (count _pos < 3)) then {
			//select tree type
			local _type = _types call BIS_fnc_selectRandom;
			
			//spawn
			local _object = _type createVehicle _pos;
			_object setDir (random 180);
			_object setVectorUp surfaceNormal _pos;
			_object enableSimulation false;
			//_object addEventHandler ["Killed",{_this spawn enableSimulationTrue}];
			
			_objects set [count _objects, _object];
		};
	};

	_objects
};
