private ["_time","_vehicle","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [60] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] C130 Crash]: Starting... %1",_position];

// Loot
_loot = [0,[5,crate_tools_buildable],[15,(crate_items_medical + crate_items_skin)],0,1];

// Spawn crates
[[
	[_loot,crates_medium,[-1.5547,2.3486,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Barrels",[-7.4511,3.8544],61.911976],
	["Misc_palletsfoiled",[4.062,4.7216],-29.273479],
	["Paleta2",[-3.4033,-2.2256],52.402905],
	["Land_Pneu",[1.17,1.249],-117.27345],
	["Land_transport_crates_EP1",[3.9029,-1.8477],-70.372086],
	["Fort_Crate_wood",[-2.1181,5.9765],-28.122475],
	["C130J_wreck_EP1",[-8.8681,15.3554,-.55],149.834555]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 10.5005,(_position select 1) - 2.6465,0],5,"Medium",[0,"RPG7V"],2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 4.7027,(_position select 1) + 12.2138,0],_rndnum,"Medium",1,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 2.9180,(_position select 1) - 9.03420,0],5,"Medium",[0,"RPG7V"],2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 2.9180,(_position select 1) - 9.03420,0],_rndnum,"Medium",1,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) - 28.4,(_position select 1) + 6, 0],
	[(_position select 0) + 8.9,(_position select 1) + 27.43, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"C130 Crash", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_DZMS_C130_START", // mission announcement
	"STR_CL_DZMS_C130_WIN", // mission success
	"STR_CL_DZMS_C130_FAIL", // mission fail
	_time
] call mission_winorfail;
