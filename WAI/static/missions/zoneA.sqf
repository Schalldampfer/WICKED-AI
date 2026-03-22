local _mission = count WAI_MissionData - 1; // DO NOT CHANGE THIS LINE.

/*
	ZoneA
	Mission AI by Schalldampfer
	POI by Chris Atkins - April/May 2014
*/

// Spawn the mission objects
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\static\POIs\zoneA.sqf";

// Config
local _aiType = "Bandit"; // "Bandit" or "Hero" - determines the humanity and kill rewards.
local _position = [8093.4624, 13528.083]; // Select a position on the map for your mission. This should be the mission center. Just use the X and Y coordinates.
local _name = "Bandit Zone Alpha"; // Used in marker text. If you know how to make localized strings and add them to a mission side string table then you can do it.
local _autoClaim = true; // Enable the auto-claim feature for this static location. Markers must also be enabled.
local _borderMarker = true; // This places a border marker on the perimeter defined by the _triggerDistance variable. It is also enabled with auto-claim.
local _triggerDistance = 1000; // This is how close in meters a player must be to spawn the AI. Also used for the auto-claim.
local _enableRespawn = false; // Allow an AI group to respawn after all members have been killed.
local _respawnTimer = 30; // The amount of time in minutes before an AI group is allowed to respawn.
local _aiCaching = true; // If players are not near then the behavioral FSM, targeting, and movement is disabled and the AI objects are hidden. Known to improve server performance.
local _enableMarkers = true; // Define the parameters below to place a custom JIP compatible marker on your mission.
local _markerColor = "ColorPink"; // Color of the mission marker. https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
local _markerSize = [500,500]; // Sets the size of the marker. https://community.bistudio.com/wiki/setMarkerSize
local _markerShape = "ELLIPSE"; // https://community.bistudio.com/wiki/setMarkerShape
local _markerBrush = "Solid"; // Fill texture for the marker. https://community.bistudio.com/wiki/setMarkerBrush
local _markerAlpha = 0.4; // From 0 to 1. Sets the marker transparency. https://community.bistudio.com/wiki/setMarkerAlpha
local _showMarkerText = true; // Show the name of the mission in the center of the marker. Needed for AI counter.
local _showAiCount = false; // Show the AI count in the mission marker.
local _markWhenClear = true; // If all AI are dead, place a marker that says that the mission has been cleared. Respawns must be disabled.
local _killPercent = 95; // The percentage of AI that must be killed for the mission to be marked "clear". Because the AI counts can be slightly off for some reason, I recommend not using 100%.
local _lootWhenClear = true; // Wait until the mission is cleared to spawn the loot. True or false.
//End Config

////////////////////// Do not edit this section ///////////////////////////
local _markers = [1,1,1,1];
local _markerIndex = -1;
if (_enableMarkers) then {
	_markers set [0,[_position,"WAI" + str(_mission),_markerColor,"",_markerShape,_markerBrush,_markerSize,[],_markerAlpha]];
	if (_showMarkerText) then {_markers set [1,[_position,"WAI" + str(_mission) + "dot","ColorBlack","hd_dot","","",[],[_name],0]];};
	if (_autoClaim || _borderMarker) then {_markers set [2, [_position, "WAI" + str(_mission) + "auto", "ColorRed", "", "ELLIPSE", "Border", [_triggerDistance,_triggerDistance], [], 0]];};
	DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers];
	_markerIndex = count DZE_ServerMarkerArray - 1;
	PVDZ_ServerMarkerSend = ["start",_markers];
	publicVariable "PVDZ_ServerMarkerSend";
};

WAI_StaticMarkerReady = true;

// Add the mission's position to the global array so that other missions do not spawn near it.
DZE_MissionPositions set [count DZE_MissionPositions, _position];

// Wait until a player is within range.
local _claimPlayer = objNull;
while {isNull _claimPlayer} do {
	_claimPlayer = [_position, _triggerDistance] call isClosestPlayer;
	uiSleep 1;
};
//////////////////////////////// End //////////////////////////////////////

local _mines = [_position,5,300,100] call WAI_MineField;

/*
Custom group spawns Eg.

[
	[953.237,4486.48,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Random",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	"Random",				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;

Place your custom group spawns below
*/

[
	[7950.3169, 13701.788,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L85A2_FL_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;

[
	[8189.5723, 13366.004,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L85A2_FL_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[7951.1899, 13594.916,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L85A2_FL_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8132.0103, 13640.752,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L85A2_FL_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AA",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8128.606, 13612.761,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L110A1_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8008.8716, 13674.027,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"M79_EP1",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8053.3198, 13688.962, 9.5873766],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"UK59_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AA",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8135.105, 13485.465, 9.1986609],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"SVD_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	 [8049.3315, 13496.273,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"Hard",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"M4A1_MFL_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"M47Launcher_EP1",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;

[
	[8062.3394, 13552.104,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"extreme",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"M4A3_Camo_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"M47Launcher_EP1",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8090.2271, 13607.234,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"extreme",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"MP5SD",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AA",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8181.3193, 13488.393,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"extreme",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"M4A1_MFL_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AA",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[8121.5259, 13408.837,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"extreme",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L110A1_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Igla",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
[
	[7970.1797, 13598.853,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
	5,						// Number Of units
	"extreme",				// Skill level of unit (easy, medium, hard, extreme, Random)
	"L110A1_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Igla",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnGroup;
//14
/*
Custom static weapon spawns Eg. (with multiple positions)

[
	[						// Position(s) (can be multiple)
		[911.21,4532.76,2.62],
		[921.21,4542.76,2.62]
	],
	"M2StaticMG",			// Classname of turret - Can use "Random"
	"easy",					// Skill level of unit (easy, medium, hard, extreme, Random)
	_aiType,				// Skin - "Random", "Classname", or Array 
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Random",				// Backpack - "Random", "Classname", "none" or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnStatic;

Place your custom static weapon spawns below
*/

// Static Gun Positions
local _grp = [
	[	// Position(s) (can be multiple)
		[8135.4629, 13485.684, 12.995364]
	],
	"2b14_82mm_INS",				// Classname of turret - Can use "Random"
	"easy",					// Skill level of unit (easy, medium, hard, extreme, Random)
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array 
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Random",				// Backpack - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnStatic;
local _grp2 = [
	[	// Position(s) (can be multiple)
		[8060.5122, 13559.302, 12.973366],
		[8070.3789, 13682.68, 0.00012207031],
		[7963.9917, 13614.555, 6.1035156e-005],
		[8122.4854, 13465.523, 3.0517578e-005]
	],
	"KORD_high_TK_EP1",				// Classname of turret - Can use "Random"
	"Hard",					// Skill level of unit (easy, medium, hard, extreme, Random)
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array 
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Random",				// Backpack - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnStatic;
(units _grp2) joinSilent _grp;
_grp2 = [
	[	// Position(s) (can be multiple)
		[8137.6597, 13527.928, 8.3778276]
	],
	"ZU23_Ins",				// Classname of turret - Can use "Random"
	"Extreme",					// Skill level of unit (easy, medium, hard, extreme, Random)
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array 
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Random",				// Backpack - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnStatic;
(units _grp2) joinSilent _grp;

//Some objects
{
	_grp2 = [[_x select 1],_x select 0,"Extreme",WAI_AcrSkin,_aiType,"Random","Random","Random",_mission] call WAI_SpawnStatic;
	local _veh = vehicle ((units _grp2) select 0);
	_veh setPos (_x select 1);
	_veh setDir (_x select 2);
	(units _grp2) joinSilent _grp;
} forEach [
	["UH1Wreck",[8133.1646, 13559.556, 0], 0.0],
	["UH1Wreck",[8204.8223, 13404.157, 0], 0.0],
	["UH60_wreck_EP1",[8206.4395, 13350.582, 0], 180 -70.319527]
];

/*
Custom Chopper Patrol spawn Eg.

[
	[725.391,4526.06,0],	// Position to patrol
	500,					// Radius of patrol
	10,						// Number of waypoints to give
	"UH1H_DZ",				// Classname of helicopter - Do not use DZE models because they spawn with no ammo.
	"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",				// Skin - "Random", "Classname", or Array
	_aitype,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_HeliPatrol;

Place your Chopper patrols below
*/

[
	_position,				// Position to patrol
	300,					// Radius of patrol
	4,						// Number of waypoints to give
	"Mi171Sh_CZ_EP1_DZ",				// Classname of helicopter - Do not use DZE models because they spawn with no ammo.
	"extreme",				// Skill level of units (easy, medium, hard, extreme, Random)
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	_aitype,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_HeliPatrol;

/* 
Custom vehicle patrol spawns Eg.

[
	[725.391,4526.06,0],	// Position to patrol
	[725.391,4526.06,0],	// Position to spawn at
	200,					// Radius of patrol
	10,						// Number of waypoints to give
	"HMMWV_Armored",		// Classname of vehicle (make sure it has driver and gunner). Do not use DZE models because they spawn with no ammo.
	"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
	_aiType,				// Skin - "Random", "Classname", or Array
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_VehPatrol;

Place your vehicle patrols below this line
*/

/* 
Custom Boat patrol spawns

[
	[725.391,4526.06,0],	// Position to patrol
	[725.391,4526.06,0],	// Position to spawn at
	150,					// Radius of patrol. Your spawn point should be at least this distance from shore.
	10,						// Number of waypoints to give
	"RHIB",					// Classname of armed boat (make sure it has driver and gunner). Do not use DZE models because they spawn with no ammo.
	"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",				// Skin - "Random", "Classname", or Array
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_VehPatrol;

Place your boat patrols below this line
*/

/*
Paradropped unit custom spawn Eg.

[
	_position,				// Position that units will be dropped
	400,					// Radius from drop position a player has to be to spawn chopper
	"UH1H_DZ",				// Classname of chopper. Do not use DZE models because they spawn with no ammo.
	"North",				// Direction of approach for the helicopter. Options: "North","South","East","West"
	[3000,4000],			// Random distance from the mission the helicopter should start. [min distance, max distance].
	150,					// Fly in height of the helicopter. Be careful that the height is not too low or the AI might die when they hit the ground
	1.0,					// Time in seconds between each deployed paratrooper. Higher number means paradropped AI will be more spread apart. Time of 0 means they all jump out rapidly.
	200,					// Distance from the mission the helicopter should start dropping paratroopers
	5,						// Number of units to be para dropped
	"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", or Array
	_aiType,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	true,					// true: Aircraft will stay at position and fight. false: Heli will leave if not under fire. 
	_mission				// This is the mission variable established on line 1. Do not change.
] spawn WAI_HeliPara;

Place your paradrop spawns under this line
*/

[
	_position,				// Position that units will be dropped
	400,					// Radius from drop position a player has to be to spawn chopper
	"Mi171Sh_CZ_EP1_DZE3",				// Classname of chopper. Do not use DZE models because they spawn with no ammo.
	"North",				// Direction of approach for the helicopter. Options: "North","South","East","West"
	[3000,4000],			// Random distance from the mission the helicopter should start. [min distance, max distance].
	150,					// Fly in height of the helicopter. Be careful that the height is not too low or the AI might die when they hit the ground
	1.0,					// Time in seconds between each deployed paratrooper. Higher number means paradropped AI will be more spread apart. Time of 0 means they all jump out rapidly.
	200,					// Distance from the mission the helicopter should start dropping paratroopers
	12,						// Number of units to be para dropped
	"extreme",				// Skill level of units (easy, medium, hard, extreme, Random)
	"UK59_DZ",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"AT",						// Launcher - "AT", "AA", or "" for no launcher
	"Random",				// Backpack - "Random", "Classname", or Array
	WAI_AcrSkin,				// Skin - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	true,					// true: Aircraft will stay at position and fight. false: Heli will leave if not under fire. 
	_mission				// This is the mission variable established on line 1. Do not change.
] spawn WAI_HeliPara;



/* Custom Crate Spawns

local _loot = 
[
	0, // Max number of long guns OR [MAX number of long guns,gun_array]
	0, // Max number of tools OR [MAX number of tools,tool_array]
	0, // Max number of items OR [MAX number of items,item_array]
	0, // Max number of pistols OR [MAX number of pistol,pistol_array]
	0 // Max number of backpacks OR [MAX number of backpacks,backpack_array]
];

[
	_loot,							// loot
	WAI_CrateSm,					// crate type - array or class
	[[[x,y,z],optional direction]],	// position and optional direction
	_mission						// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[ // example with multiple positions - it will pick one at random.
	_loot,							// loot
	WAI_CrateSm,					// crate type - array or class
	[[[x,y,z],optional direction],[[x,y,z],optional direction],[[x,y,z],optional direction]],	
	_mission					// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

Place your crate spawns under this line
*/

local _briefcases = 6 + (round (random 4)); // Up to 10 briefcases.

[	// 1
	[[25,WAI_Sniper+WAI_RifleRare+WAI_RifleGood+WAI_LauncherCheap],8,[(ceil random 4),WAI_StaticMG+WAI_StaticGMG+WAI_StaticHeavy],10,[5,WAI_PacksLg]],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[8053.8848, 13689.17, 9.1003056],48.119629]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// 2 in C-130Wreck
	[0,0,[_briefcases,WAI_HighValue],0,0],// loot
	WAI_CrateSm,			// crate type - array or class
	[[[8094.5679, 13582.804, 0.0],-76.372002]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// 3
	[[(ceil random 4),WAI_RifleDelux+WAI_LauncherDelux],0,[20,WAI_VehAmmo+WAI_HeliAmmo],5,[5,WAI_PacksLg]],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[8137.7388, 13524.22, 4.7680826],46.333576]],// position
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

//Traders
/*
[
	//SectorC
	["RUS_Commander",[2178.6943, 11980.08,0],-223],
	["RU_Commander",[2182.136, 11913.39,0],-12]
] call server_spawnTraders;
*/

//Spawn vehicles
[WAI_MilUnarmed,[8126.0454, 13517.477, 0.00012207031],_mission, false, 0] call WAI_PublishVeh;

// End

// Begin the mission monitoring thread.
[
	_mission, // Mission number
	_position, // Position of mission
	_name, // Name of Mission
	_triggerDistance, // used for AI caching
	_aiType, // "Bandit" or "Hero"
	_aiCaching, // true or false
	_autoClaim, // true or false
	_killPercent, // Percentage of AI killed to clear the mission
	_lootWhenClear, // Wait to spawn loot in crates until mission cleared
	_claimPlayer,
	[_enableRespawn,_respawnTimer], // Respawn options
	[_enableMarkers,_markerIndex,_showMarkerText,_showAiCount,_markWhenClear] // Marker parameters
] execVM "\z\addons\dayz_server\WAI\static\compile\staticMissionMonitor.sqf";

diag_log format ["WAI: static mission %1 started.",_name];
