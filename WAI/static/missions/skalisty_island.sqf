local _mission = count WAI_MissionData - 1; // DO NOT CHANGE THIS LINE.

/*
	Skalisty Island Stronghold
	Mission AI by JasonTM
	POI by Thug. https://epochmod.com/forum/topic/14594-ai-skalisty-island-not-so-easy/
*/

// Spawn the mission objects
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\static\POIs\skalisty_island.sqf";
//local _villa = ([13716.6,2911.42,0] nearObjects ["Land_A_Villa_EP1", 50]) select 0; // Need to get this building object for spawning other objects inside it.

// Config
local _aiType = "Bandit"; // "Bandit" or "Hero" - determines the humanity and kill rewards.
local _position = [13649.7,2995.62]; // Select a position on the map for your mission. This should be the mission center. Just use the X and Y coordinates.
local _name = "Skalisty Island Stronghold"; // Used in marker text. If you know how to make localized strings and add them to a mission side string table then you can do it.
local _autoClaim = false; // Enable the auto-claim feature for this static location. Markers must also be enabled.
local _borderMarker = true; // This places a border marker on the perimeter defined by the _triggerDistance variable. It is also enabled with auto-claim.
local _triggerDistance = 1000; // This is how close in meters a player must be to spawn the AI. Also used for the auto-claim.
local _enableRespawn = false; // Allow an AI group to respawn after all members have been killed.
local _respawnTimer = 30; // The amount of time in minutes before an AI group is allowed to respawn.
local _aiCaching = false; // If players are not near then the behavioral FSM, targeting, and movement is disabled and the AI objects are hidden. Known to improve server performance.
local _enableMarkers = true; // Define the parameters below to place a custom JIP compatible marker on your mission.
local _markerColor = "ColorPink"; // Color of the mission marker. https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
local _markerSize = [700,700]; // Sets the size of the marker. https://community.bistudio.com/wiki/setMarkerSize
local _markerShape = "RECTANGLE"; // https://community.bistudio.com/wiki/setMarkerShape
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
	if (_showMarkerText) then {_markers set [1,[_position,"WAI" + str(_mission) + "dot","ColorBlack","mil_dot","","",[],[_name],0]];};
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

// Inside the outpost
[
	[13618.7,3142.23,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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

// Outside the castle walls
[
	[13313.6,3237.46,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13606.4,3177.71,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13649.7,3109.93,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13674,3000.89,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13620.3,2902.46,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13695.1,2812.8,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13909.6,2917.8,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	 [14031,2800.56,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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

// Inside the castle walls
[
	[13678,2946.97,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13695.6,2878.44,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
[
	[13757.3,2911.49,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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

// Random Static Gun Positions
local _random1 = [[13728.8,2858.17,0],[13772.7,2851.03,1.25],[13652.7,2860.58,0.9],[13695.3,2856.22,0]] call BIS_fnc_selectRandom;
local _random2 = [[13646.2,2923.39,1.2],[13699,2948.24,0],[13786.8,2911.45,1.05],[13744.3,2930.9,0]] call BIS_fnc_selectRandom;
local _random3 = [[13778.9,2980.68,1.2],[13740.3,2955.42,0],[13715,2968.29,0],[13695.5,2970.86,0]] call BIS_fnc_selectRandom;
local _random4 = [[13716,2915.39,10.6], [13734.1,2895.29,8.7], [13693.2,2900.96,8.14],[13714.6,2895.7,4.81]] call BIS_fnc_selectRandom;
local _random5 = [[13732.3,2903.29,1.24],[13722.8,2917.98,0.6],[13716.7,2914.34,0.72],[13702.4,2909.99,0.76],[13692.5,2899.75,1]] call BIS_fnc_selectRandom;
local _random6 = [[13623.1,3152.25,0],[13613.2,3147.17,0],[13588.5,3160.9,0],[13638.8,3183.57,0],[13613.9,3129.21,0]] call BIS_fnc_selectRandom;

[
	[	// Position(s) (can be multiple)
		_random1, // inside castle
		_random2, // inside castle
		_random3, // inside castle
		_random4, // villa roof
		_random5, // inside villa
		_random6 // outpost
	],
	"Random",				// Classname of turret - Can use "Random"
	"easy",					// Skill level of unit (easy, medium, hard, extreme, Random)
	_aiType,				// Skin - "Random", "Classname", or Array 
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Random",				// Backpack - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnStatic;

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
	700,					// Radius of patrol
	10,						// Number of waypoints to give
	"UH1H_DZ",				// Classname of helicopter - Do not use DZE models because they spawn with no ammo.
	"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",				// Skin - "Random", "Classname", or Array
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

[
	[13650.3,3038.33,0],	// Position to patrol
	[13650.3,3038.33,0],	// Position to spawn at
	200,					// Radius of patrol
	10,						// Number of waypoints to give
	"HMMWV_Armored",		// Classname of vehicle (make sure it has driver and gunner). Do not use DZE models because they spawn with no ammo.
	"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
	_aiType,				// Skin - "Random", "Classname", or Array
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_VehPatrol;

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

[
	[13117.2,2866.65,0],			// Position to patrol
	[13117.2,2866.65,0],			// Position to spawn at, can be same as patrol location
	150,							// Radius of patrol
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner). Do not use DZE models because they spawn with no ammo.
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	_aiType,						// Skin - "Random", "Classname", or Array
	_aiType,						// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission						// This is the mission variable established on line 1. Do not change.
] call WAI_VehPatrol;

[
	[13552.5,2566.86,0],			// Position to patrol
	[13552.5,2566.86,0],			// Position to spawn at, can be same as patrol location
	150,							// Radius of patrol
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner). Do not use DZE models because they spawn with no ammo.
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	_aiType,						// Skin - "Random", "Classname", or Array
	_aiType,						// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission						// This is the mission variable established on line 1. Do not change.
] call WAI_VehPatrol;

[
	[13908.3,3259.23,0],			// Position to patrol
	[13908.3,3259.23,0],			// Position to spawn at, can be same as patrol location
	150,							// Radius of patrol
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner). Do not use DZE models because they spawn with no ammo.
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	_aiType,						// Skin - "Random", "Classname", or Array
	_aiType,						// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	_mission						// This is the mission variable established on line 1. Do not change.
] call WAI_VehPatrol;


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

local _briefcases = 2 + (round (random 8)); // Up to 10 briefcases.

[	// Inside the villa
	[0,0,[_briefcases,["ItemBriefcase100oz"]],0,0],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[13705,2913.35,4.28],0],[[13695.7,2904.41,4.54],0],[[13723.1,2907.14,4.56],0]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// Inside the castle walls
	[[25,WAI_Sniper],8,0,10,[5,WAI_PacksLg]],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[13696.1,2958.89,0],0],[[13698.6,2968.86,0],0],[[13746.8,2950.01,0],0]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// At the outpost
	[12,0,[20,WAI_Hemp],5,3],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[13606.9,3164.01,0.00152016],150]],// position
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// Hidden inside one of the island buildings
	[0,0,[(ceil random 4),wai_gems],0,0], // Between 1 and 4 gems
	WAI_CrateSm,			// crate type - array or class
	[[[13946.1,2921.35,3.77],0],[[14028.1,2934.98,17.15],0],[[14029.8,2832.03,7.04],0],[[14050.4,2818.34,3.25],0],[[14141.1,2738.47,1.00467],0]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

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
