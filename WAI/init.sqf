// Compile all Functions
WAI_SpawnGroup = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_group.sqf";
WAI_SpawnStatic = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_static.sqf";
WAI_SetWaypoints = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\waypoints.sqf";
WAI_HeliPara = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
WAI_HeliPatrol = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
WAI_VehPatrol = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";
WAI_Onkill = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\on_kill.sqf";
WAI_DynCrate = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\dynamic_crate.sqf";
WAI_FindPos = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\find_position.sqf";
WAI_FindPosForest = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\find_position_forest.sqf";
WAI_LoadAmmo = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\load_ammo.sqf";
WAI_MissionMonitor = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\missionMonitor.sqf";
WAI_PublishVeh = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\publishVehicle.sqf";
WAI_SpawnObjects = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawnObjects.sqf";
WAI_Overpoch = isClass (configFile >> "CfgWeapons" >> "USSR_cheytacM200");
ARTY_LOGIC = createAgent ["BIS_ARTY_Logic",[0,0,0],[],0,"NONE"];
enableEngineArtillery true;
WAI_HandleDamage_Unit = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_handledamage_unit.sqf";
WAI_HandleDamage_Vehicle = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_handledamage_vehicle.sqf";
WAI_Killed_Vehicle = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_kill.sqf";
WAI_arty_fire = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\arty_fire.sqf";
WAI_flare_fire = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\flare_fire.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\position_functions.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\functions.sqf";

if (isNil("DZMSInstalled")) then {

	createCenter EAST;
	createCenter RESISTANCE;

	WEST setFriend [EAST,0];
	WEST setFriend [RESISTANCE,0];

	EAST setFriend [WEST,0];
	EAST setFriend [RESISTANCE,1];
	
	RESISTANCE setFriend [EAST,1];
	RESISTANCE setFriend [WEST,0];

} else {

	createCenter RESISTANCE;
	
	EAST setFriend [RESISTANCE,1];
	WEST setFriend [RESISTANCE,0];
	
	RESISTANCE setFriend [EAST,1];
	RESISTANCE setFriend [WEST,0];
};

WAIconfigloaded = false;
WAI_MarkerReady = true;
WAI_MissionData = [];
WAI_HeroRunning = 0;
WAI_BanditRunning = 0;
WAI_HeroStartTime = diag_tickTime;
WAI_BanditStartTime = diag_tickTime;

call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\configs\mission_loot.sqf";

if (WAI_Overpoch) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\configs\overwatch.sqf";
};

if (WAI_SpawnPoints) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\configs\spawnpoints.sqf";
};

if (WAI_Blacklist) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\configs\blacklist.sqf";
};

if (WAI_StaticMissions) then {
	 WAI_SpawnStaticCrate = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\static\compile\spawnStaticCrate.sqf";
	 WAI_SpawnStaticObjects = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\static\compile\spawnStaticObjects.sqf";
	 execVM "\z\addons\dayz_server\WAI\static\init.sqf";
};
