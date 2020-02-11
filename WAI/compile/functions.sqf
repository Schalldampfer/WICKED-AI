KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt","_el1","_indx","_el2"];
    _arr = _this select 0;
    _cnt = count _arr - 1;
    _el1 = _arr select _cnt;
    _arr resize _cnt;
    for "_i" from 1 to (_this select 1) do {
        _indx = floor random _cnt;
        _el2 = _arr select _indx;
        _arr set [_indx, _el1];
        _el1 = _el2;
    };
    _arr set [_cnt, _el1];
    _arr
};

find_suitable_ammunition = {

	private["_weapon","_result","_ammoArray"];

	_result = false;
	_weapon = _this;
	_ammoArray = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
		call {
			if (_result == "20Rnd_556x45_Stanag") exitWith { _result = "30Rnd_556x45_Stanag"; };
			if (_result == "30Rnd_556x45_G36") exitWith { _result = "30Rnd_556x45_Stanag"; };
			if (_result == "30Rnd_556x45_G36SD") exitWith { _result = "30Rnd_556x45_StanagSD"; };
			if (_result == "vil_20Rnd_762x51_G3") exitWith { _result = "20Rnd_762x51_DMR"; };
			if (_result == "RH_20Rnd_762x51_hk417") exitWith { _result = "20Rnd_762x51_DMR"; };
			if (_result == "vil_45Rnd_545x39_AK") exitWith { _result = "30Rnd_545x39_AK"; };
			if (_result == "vil_20Rnd_9x39_SP6_VAL") exitWith { _result = "20Rnd_9x39_SP5_VSS"; };
			if (_result == "RH_32Rnd_9x19_Muzi") exitWith { _result = "30Rnd_9x19_UZI"; };
			if (_result == "vil_32Rnd_uzi") exitWith { _result = "30Rnd_9x19_UZI"; };
			if (_result == "vil_32Rnd_UZI_SD") exitWith { _result = "30Rnd_9x19_UZI_SD"; };
			if (_result == "vil_17Rnd_9x19_PYA") exitWith { _result = "15Rnd_9x19_M9"; };
			if (_result == "vil_75Rnd_762x39_AK47") exitWith { _result = "30Rnd_762x39_AK47"; };
			if (_result == "RH_20Rnd_9x19_M93") exitWith { _result = "15Rnd_9x19_M9"; };
			if (_result == "RH_19Rnd_9x19_g18") exitWith { _result = "17Rnd_9x19_glock17"; };
			if (_result == "RH_17Rnd_9x19_g17") exitWith { _result = "17Rnd_9x19_glock17"; };
			if (_result == "RH_17Rnd_9x19_g17SD") exitWith { _result = "15Rnd_9x19_M9SD"; };
			if (_result == "RH_20Rnd_32cal_vz61") exitWith { _result = "20Rnd_B_765x17_Ball"; };
			if (_result == "FHQ_rem_5Rnd_300Win_XM2010_NT") exitWith { _result = "FHQ_rem_5Rnd_300Win_XM2010_T"; };
			if (_result == "FHQ_rem_7Rnd_338Lapua_MSR_NT") exitWith { _result = "FHQ_rem_10Rnd_338Lapua_MSR_T"; };
			if (_result == "FHQ_rem_7Rnd_338Lapua_MSR_NT_SD") exitWith { _result = "FHQ_rem_10Rnd_338Lapua_MSR_TD_SD"; };
			if (_result == "8Rnd_B_Saiga12_74Slug") exitWith { _result = "8Rnd_B_Saiga12_Pellets"; };
			if (_result == "8Rnd_12Gauge_Slug") exitWith { _result = "8Rnd_12Gauge_Buck"; };
			//if (_result == "20Rnd_B_AA12_Pellets") exitWith { _result = "20Rnd_B_AA12_HE"; };
			if (_result == "PG7V") exitWith { _result = "OG7"; };
		};
	};
	_result
};

wai_spawnCrate = {
	private ["_pos","_crate","_mission","_offset","_type","_loot","_position","_crates"];
	_crates = _this select 0;
	_pos = _this select 1;
	if (count _this > 2) then {
		_mission = _this select 2;
	};
	
	{	
		_loot = _x select 0;
		_type = _x select 1;
		_offset = _x select 2;
		
		_position = [(_pos select 0) + (_offset select 0), (_pos select 1) + (_offset select 1), 0];
		
		if (count _offset > 2) then {
			_position set [2, (_offset select 2)];
		}; 
		
		if (typeName _type == "ARRAY") then {
			_type = _type call BIS_fnc_selectRandom;
		};
		
		_crate = _type createVehicle [0,0,0];
		
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
		if (!isNil "_mission") then {
			((wai_mission_data select _mission) select 3) set [count ((wai_mission_data select _mission) select 3), [_crate,_loot]];
		} else {
			(wai_static_data select 3) set [count (wai_static_data select 3), [_crate,_loot]];
		};
	} count _crates;
};

wai_server_message = {
	private ["_color","_params","_type"];
	_type = _this select 0;
	_message = _this select 1;
	
	call {
		if (wai_mission_announce == "Radio") exitWith {
			RemoteMessage = ["radio",_message];
		};		
		if (wai_mission_announce == "DynamicText") exitWith {
			_color = call {
				if(_type == "Easy") exitWith {"#00cc00"};
				if(_type == "Medium") exitWith {"#ffff66"};
				if(_type == "Hard") exitWith {"#990000"};
				if(_type == "Extreme") exitWith {"#33334d"};
			};
			_params = ["0.40","#FFFFFF","0.60",_color,0,-.35,10,0.5];
			RemoteMessage = ["dynamic_text", ["STR_CL_MISSION_ANNOUNCE",_message],_params];
		};		
		if (wai_mission_announce == "titleText") exitWith {
			RemoteMessage = ["titleText",_message];
		};
	};
	publicVariable "RemoteMessage";
};

wai_minefield_warning = {
	private ["_owner","_params"];
	_owner = (owner _this);
	_params = ["0","#FFFFFF","0.50","#ff3300",0,.3,10,0.5];
	RemoteMessage = ["dynamic_text",["","STR_CL_MINEFIELD_WARNING"],_params];
	(_owner) publicVariableClient "RemoteMessage";
};

wai_AutoClaimAlert = {
	private ["_unit","_owner","_mission","_type","_message","_name"];
	_unit = _this select 0;
	_mission = _this select 1;
	_type = _this select 2;
	if (typeName _unit == "ARRAY") then {
		_name = _unit select 1;
	} else {
		_owner = owner _unit;
		_name = name _unit;
	};
	
	_message = call {
		if (_type == "Start") exitWith {["STR_CL_AUTOCLAIM_ANNOUNCE",_mission,ac_delay_time];};
		if (_type == "Stop") exitWith {["STR_CL_AUTOCLAIM_NOCLAIM",_mission];};
		if (_type == "Return") exitWith {["STR_CL_AUTOCLAIM_RETURN",ac_timeout];};
		if (_type == "Reclaim") exitWith {"STR_CL_AUTOCLAIM_RECLAIM";};
		if (_type == "Claimed") exitWith {["STR_CL_AUTOCLAIM_CLAIM",_name,_mission];};
		if (_type == "Unclaim") exitWith {["STR_CL_AUTOCLAIM_ABANDON",_name,_mission];};
	};
	
	if (_type == "Claimed" || _type == "Unclaim") exitWith {
		RemoteMessage = ["IWAC",_message];
		publicVariable "RemoteMessage";
	};
	
	RemoteMessage = ["IWAC",_message];
	(_owner) publicVariableClient "RemoteMessage";
};

wai_monitor_ai_vehicles = {
	private ["_vehicle","_vD"];
	_vD = viewDistance;
	{
		_vehicle = _x;
		if (alive _vehicle && ({alive _x} count crew _vehicle > 0)) then {
			_vehicle setVehicleAmmo 1;
			_vehicle setFuel 1;
			//find players
			{
				if ((_x distance _vehicle) < _vD) then {
					if ((vehicle _x) isKindOf "Air" || !(lineIntersects [aimPos _vehicle,aimPos _x,_vehicle,_x]) && !(terrainIntersectASL [aimPos _vehicle,aimPos _x])) then {
						(gunner _vehicle) reveal [_x,2.5];
					};
				};
			} forEach playableUnits;
		} else {
			_vehicle setDamage 1;
		};
	} count _this;
};

wai_fnc_remove = {
	{
		deleteVehicle _x;
	} count _this;
};

wai_remove_vehicles = {
    private ["_mission","_vehicles"];
    _mission = _this select 0;
    _vehicles = _this select 1;
    
    {
        if (_x getVariable ["mission" + dayz_serverKey, nil] == _mission) then {
			dayz_serverObjectMonitor = dayz_serverObjectMonitor - [_x];
            deleteVehicle _x;
        };
    } count _vehicles;
};

wai_remove_ai = {
    {
        if (_x getVariable ["mission" + dayz_serverKey, nil] == _this) then {
			if (vehicle _x != _x) then {_x action ["eject",vehicle _x];unassignVehicle _x;};
            deleteVehicle _x;
        };
    } count allUnits;
};

wai_kill_ai = {
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
			};
		};
	} count allUnits;
};

wai_generate_vehicle_key = {
	private ["_isKeyOK","_crates","_keyColor","_keyNumber","_vehicle","_crate","_keySelected","_mission","_unit","_ailist","_characterID"];
	
	_vehicle = _this select 0;
	_mission = _this select 1;
	_crates = _this select 2;
		
	if (wai_vehicle_keys == "NoVehicleKey") exitWith {
		_vehicle setVariable ["CharacterID","0",true];
		_vehicle setVehicleLock "unlocked";
	};
	
	_keyColor = DZE_keyColors call BIS_fnc_selectRandom;
	_keyNumber = (ceil(random 2500)) + 1;
	_keySelected = format["ItemKey%1%2",_keyColor,_keyNumber];
	_isKeyOK = isClass(configFile >> "CfgWeapons" >> _keySelected);
	_characterID = str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));
	
	if !(_isKeyOK) exitWith {
		_vehicle setVariable ["CharacterID","0",true];
		_vehicle setVehicleLock "unlocked";
		diag_log format["WAI: Failed to generate a key for vehicle %1 at mission %2",_vehicle,_mission];
	};
	
	_vehicle setVariable ["CharacterID",_characterID,true];
	
	if (wai_vehicle_keys == "KeyinVehicle") exitWith {
		_vehicle addWeaponCargoGlobal [_keySelected,1];
		_vehicle setVehicleLock "unlocked";
	};
	if (wai_vehicle_keys == "KeyinCrate") exitWith {
		_crate = (_crates select 0) select 0;
		_crate addWeaponCargoGlobal [_keySelected, 1];
	};			
	if (wai_vehicle_keys == "KeyonAI") exitWith {
		_ailist = [];
		{
			if ((_x getVariable ["mission" + dayz_serverKey,nil] == _mission) && (_x getVariable ["bodyName",nil] == "mission_ai") && !(_x getVariable ["noKey", false])) then {
				_ailist set [count _ailist, _x];
			};
		} count allDead;
		
		_unit = _ailist call BIS_fnc_selectRandom;
		_unit addWeapon _keySelected;
		
		if(wai_debug_mode) then {
			diag_log format["There are %1 Dead AI for mission %2 vehicle key",_ailist,_mission];
			diag_log format["Key added to %1 for vehicle %2",_unit,_vehicle];
		};
	};
};

wai_completion_check = {
	private ["_completionType","_complete","_position","_mission","_killpercent","_objectivetarget"];
	
	_mission = _this select 0;
	_completionType = _this select 1;
	_killpercent = _this select 2;
	_position = _this select 3;
	_complete = false;
	
	call
	{
		if (_completionType select 0 == "crate") exitWith {

			if(wai_kill_percent == 0) then {
				_complete = [_position,20] call isNearPlayer;
			} else {
				if(((wai_mission_data select _mission) select 0) <= _killpercent) then {
					_complete = [_position,20] call isNearPlayer;
				};
			};
		};
		
		if (_completionType select 0 == "kill") exitWith {
			if(((wai_mission_data select _mission) select 0) == 0) then {
				_complete = true;
			};
		};
		
		if (_completionType select 0 == "assassinate") exitWith {
			_objectivetarget = _completionType select 1;
			{
				if !(alive _x) exitWith {_complete = true;};
			} count units _objectivetarget;
		};

		/* no missions are using this function at the moment
		if (_completionType == "resource") exitWith {
			_node 		= _completionType select 1;
			_resource 	= _node getVariable ["Resource", 0];
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

wai_clean_aircraft = {
	private ["_veh","_position","_group"];
	_veh = _this select 0;
	_position = _this select 1;
	_group = _this select 2;
	
	uiSleep 60;
	deleteVehicle _veh;
	
	while {(count (wayPoints _group)) > 0} do {
		deleteWaypoint ((wayPoints _group) select 0);
	};
	
	{
		deleteVehicle _x;
	} count (units _group);
	uiSleep 5;
	deleteGroup _group;
	if(wai_debug_mode) then {diag_log "WAI: Aircraft Cleaned";};
};

wai_str_initUpper = {
	private "_strA";
	_strA = toArray(toLower(_this));
	_strA set [0, (_strA select 0) - 32];
	toString(_strA)
};

wai_waitForPlayers = {
	private ["_missionType","_position","_mission","_markName","_dotName","_distance","_marker","_dot","_time","_timeout","_color"];
	_missionType = _this select 0;//MainBandit or MainHero
	_position = _this select 1;//position of center of mission
	_mission = _this select 2;//No. of mission

	_markName = _missionType + str(_mission);
	_dotName  = _missionType + str(_mission) + "dot";
	_distance = (ac_alert_distance max wai_timeout_distance) + 1000;//distance to wait
	_time = diag_tickTime;//start time
	_timeout = (random((wai_mission_timeout select 1) - (wai_mission_timeout select 0)) + (wai_mission_timeout select 0)) * 60;//time limit
	WAI_MarkerReady = true;// reset position finding

	_color = "ColorBlue";
	if (_missionType in ["MainHero","MainBandit"]) then {_color = "ColorOrange";};

	diag_log format["WAI: Mission %1 is waiting for players",_markName];

	//show marker until someone getting close
	while {(({(alive _x) && (_x distance _position < _distance)} count playableUnits) < 1) && ((diag_tickTime - _time) < _timeout)} do {
		_marker = createMarker [_markName, _position];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "Solid";
		_marker setMarkerColor _color;
		_marker setMarkerSize [300,300];
		_dot = createMarker [_dotName, _position];
		_dot setMarkerColor "ColorBlack";//ColorBlack
		_dot setMarkerType "hd_unknown";//mil_dot
		_dot setMarkerText "Unknown Mission";
		sleep 6;
		deleteMarker _marker;
		deleteMarker _dot;
	};

	diag_log format["WAI: Mission %1 has started at %2",_mission,_position call fa_coor2str];
	(_timeout - (diag_tickTime - _time))
};

wai_removeMission = {
	private ["_missionType","_mission"];
	_missionType = _this select 0;//MainBandit or MainHero
	_mission = _this select 1;//No. of mission
	
	if (_missionType == "MainBandit") then {
		b_missionsrunning = b_missionsrunning - 1;
		wai_b_starttime = diag_tickTime;
	} else {
		h_missionsrunning = h_missionsrunning - 1;
		wai_h_starttime = diag_tickTime;
	};
	wai_mission_data set [_mission, -1];
};

wai_spawn_trees = { // Spawn trees around mission
	private ["_position","_difficulty","_mission","_num","_trees","_types","_pos","_type","_object"];
	_position = _this select 0;
	_difficulty = _this select 1;
	_mission = _this select 2;

	_num = switch (toLower _difficulty) do {
		case "easy": {50 + round(random 50)};
		case "medium": {50 + round(random 100)};
		case "hard": {100 + round(random 50)};
		case "extreme": {100 + round(random 100)};
		default {50 + round(random 100)};
	};

	//select 3 tree types
	_trees = [
		"MAP_t_picea1s","MAP_t_picea2s","MAP_t_picea3f","MAP_t_pinusN1s","MAP_t_pinusN2s","MAP_t_pinusS2f","MAP_t_populus3s",
		"MAP_t_betula1f","MAP_t_betula2s","MAP_t_betula2w","MAP_t_betula2f","MAP_t_fagus2f","MAP_t_fagus2s","MAP_t_fagus2W","MAP_t_malus1s",
		"MAP_t_sorbus2s","MAP_t_quercus2f","MAP_t_quercus3s","MAP_t_pyrus2s","MAP_t_acer2s","MAP_t_fraxinus2W","MAP_t_fraxinus2s",
		"MAP_t_salix2s","MAP_t_alnus2s","MAP_t_carpinus2s","MAP_t_larix3f","MAP_t_larix3s","MAP_t_populus3s"
	];
	_types = [_trees call BIS_fnc_selectRandom,_trees call BIS_fnc_selectRandom,_trees call BIS_fnc_selectRandom];

	for "_x" from 1 to _num do {
		//find good position
		_pos = [_position,25 + _num * 1.0,50 + _num * 2.0,5 + (random 5),1,2000,0] call BIS_fnc_findSafePos;
		if ((!isOnRoad _pos) && (!surfaceIsWater _pos) && (count _pos < 3)) then {
			//select tree type
			_type = _types call BIS_fnc_selectRandom;
			
			//spawn
			_object = _type createVehicle _pos;
			_object setDir (random 180);
			_object setVectorUp surfaceNormal _pos;
			_object enableSimulation false;
			_object addEventHandler ["Killed",{_this spawn enableSimulationTrue}];
			
			if (_mission > -1) then {
				((wai_mission_data select _mission) select 6) set [count ((wai_mission_data select _mission) select 6), _object];
			};
		};
	};
};
