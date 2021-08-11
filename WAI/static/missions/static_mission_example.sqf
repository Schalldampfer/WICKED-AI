local _mission = count WAI_MissionData - 1; // DO NOT CHANGE THIS LINE.

/*
	Static missions
	Updated for 1.0.7.
	Static mission data is now managed like dynamic missions.
	The only difference is that relative positions are not used and they spawn at startup according to the init file.
	Since the missions spawn at server startup there is no need for announcements.
*/

// Config
local _aiType = "Bandit"; // "Bandit" or "Hero" - determines the humanity and kill rewards.
local _position = [x,y]; // Select a position on the map for your mission. This should be the mission center. Just use the X and Y coordinates.
local _name = "Name of Mission"; // Used in marker text. If you know how to make localized strings and add them to a mission side string table then you can do it.
local _autoClaim = false; // Enable the auto-claim feature for this static location. Markers must also be enabled.
local _borderMarker = true; // This places a border marker on the perimeter defined by the _triggerDistance variable. It is also enabled with auto-claim.
local _triggerDistance = 1000; // This is how close in meters a player must be to spawn the AI. Also used for the auto-claim.
local _enableRespawn = false; // Allow an AI group to respawn after all members have been killed.
local _respawnTimer = 30; // The amount of time in minutes before an AI group is allowed to respawn.
local _aiCaching = true; // If players are not near then the behavioral FSM, targeting, and movement is disabled and the AI objects are hidden. Known to improve server performance.
local _enableMarkers = true; // Define the parameters below to place a custom JIP compatible marker on your mission.
local _markerColor = "ColorPink"; // Color of the mission marker. https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
local _markerSize = [700,700]; // Sets the size of the marker. https://community.bistudio.com/wiki/setMarkerSize
local _markerShape = "ELLIPSE"; // https://community.bistudio.com/wiki/setMarkerShape
local _markerBrush = "Solid"; // Fill texture for the marker. https://community.bistudio.com/wiki/setMarkerBrush
local _markerAlpha = 0.4; // From 0 to 1. Sets the marker transparency. https://community.bistudio.com/wiki/setMarkerAlpha
local _showMarkerText = true; // Show the name of the mission in the center of the marker. Needed for AI counter.
local _showAiCount = false; // Show the AI count in the mission marker.
local _markWhenClear = true; // If all AI are dead, place a marker that says that the mission has been cleared. Respawns must be disabled.
local _killPercent = 95; // The percentage of AI that must be killed for the mission to be marked "clear". Because the AI counts can be slightly off for some reason, I recommend not using 100%.
local _lootWhenClear = false; // Wait until the mission is cleared to spawn the loot. True or false.
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
	4,						// Number Of units
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
