local _mission = count WAI_MissionData - 1; // DO NOT CHANGE THIS LINE.

/*
	Sector C
	Mission AI by Schalldampfer
	POI by Chris Atkins - April/May 2014
*/

// Spawn the mission objects
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\static\POIs\sector_c.sqf";

// Config
local _aiType = "Bandit"; // "Bandit" or "Hero" - determines the humanity and kill rewards.
local _position = [2186.8616, 11943.553]; // Select a position on the map for your mission. This should be the mission center. Just use the X and Y coordinates.
local _name = "Bandit Sector C"; // Used in marker text. If you know how to make localized strings and add them to a mission side string table then you can do it.
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
	[2095.6689, 11684.955,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2063.6782, 11846.96,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2189.7131, 11955.99,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2252.6467, 12124.506,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2386.0881, 11895.958,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2141.0818, 11826.796,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2013.6115, 11944.934,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2216.3472, 11877.72,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	 [2110.0903, 12046.773,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2311.5579, 11848.776,0],		// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2363.3757, 12007.775,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
	[2234.7959, 12008.812,0],	// Position - If you use a number greater than 0 for the z- coordinate, the AI will get "Sentry" WayPoints. Otherwise they are standard ground troops.
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
//12
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
[
	[	// Position(s) (can be multiple)
		[2036.1055, 11775.047, 50],
		[1992.8998, 11829.429, 50]
	],
	"ZU23_Ins",				// Classname of turret - Can use "Random"
	"easy",					// Skill level of unit (easy, medium, hard, extreme, Random)
	_aiType,				// Skin - "Random", "Classname", or Array 
	_aiType,				// AI Type, "Hero" or "Bandit". Defined at the top of this file with variable _aiType.
	"Random",				// Primary gun - "Random", "Unarmed", "Classname", Array
	"Random",				// Backpack - "Random", "Classname", or Array
	"Random",				// Gearset - 0,1,2, or "Random"
	_mission				// This is the mission variable established on line 1. Do not change.
] call WAI_SpawnStatic;
[
	[	// Position(s) (can be multiple)
		[2083.7717, 11800.014, 20.243473],
		[2208.2876, 11765.653, 2.758425],
		[2317.457, 12130.515, 14.556829],
		[2114.084, 11912.731, 20.239582],
		[2204.6321, 11890.069, 20.283073],
		[2247.5474, 11981.006, 20.30361]
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
	"Mi171Sh_CZ_EP1_DZ",				// Classname of helicopter - Do not use DZE models because they spawn with no ammo.
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
	8,						// Number of units to be para dropped
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

[	// At top of building
	[0,0,[_briefcases,WAI_Gems],0,0],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[2018.4861, 11957.557, 11.489552],40]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// Inside building WIP
	[[25,WAI_Sniper+WAI_RifleGood+WAI_Silenced],8,0,10,[5,WAI_PacksLg]],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[2286.9648, 12147.51, 12.266255],36]],// random positions
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// In Tower Building
	[[12,WAI_RifleGood+WAI_RifleRare+WAI_LauncherCheap],0,[20,WAI_Hemp],5,3],// loot
	WAI_CrateMd,			// crate type - array or class
	[[[2210.7173, 11997.606, 0.48433262],180]],// position
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

[	// In bunkers in forest
	[[(ceil random 4),WAI_RifleDelux+WAI_LauncherDelux],0,[(ceil random 4),WAI_StaticMG+WAI_StaticGMG+WAI_StaticHeavy],0,0],
	WAI_CrateSm,			// crate type - array or class
	[[[2397.3059, 11903.302, 0],0]],	// position and optional direction
	_mission				// mission variable - DO NOT CHANGE
] call WAI_SpawnStaticCrate;

//Traders
[
	//SectorC
	["RUS_Commander",[2178.6943, 11980.08,0],-223],
	["RU_Commander",[2182.136, 11913.39,0],-12]
] call server_spawnTraders;

//Spawn vehicles
[WAI_SuperVeh,[2188.7693, 11967.372, 0],_mission] call WAI_PublishVeh;

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
