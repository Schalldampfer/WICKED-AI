private ["_time","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [45] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Junk Yard]: Starting... %1",_position];

//Spawn Crates
[[
	[[[4,(ai_wep_special_rare + ai_wep_special_good + ai_wep_special_cheap)],0,[4,(crate_items_high_value + crate_items_vehicle_repair)],0,3],crates_small,[.2,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Mi8Wreck",[31,-12.4,-0.12]],
//	["UralWreck",[-7,-9,-0.04],-49.99],
	["UralWreck",[23,4,-0.04],201.46],
	["UralWreck",[-7,23,-0.04],80.879],
//	["HMMWVWreck",[-8,7,-0.04],44.77],
	["BMP2Wreck",[-4,24,-0.02],-89],
	["T72Wreck",[11,-13,-0.02],27],
	["UralWreck",[14,10,-0.02],162],
	["T72Wreck",[4,16,-0.02]],
//	["UH60_ARMY_Wreck_DZ",[7,1.3,-0.02],-41],
	["Land_Dirthump01",[9,1,-1.59],25],
	["Land_Dirthump01",[8,0.2,-1.59],53],
	["Mi8Wreck",[5,-34,-0.02],94],
	["BRDMWreck",[-1,-20,-0.12],-1.7],
	["T72Wreck",[-9,-21,-0.02],-75],
	["Mi8Wreck",[-21,-5,-0.02],-24],
	["Land_Misc_Rubble_EP1",[-10.02,7,-0.1]],
	["Land_Shed_W03_EP1",[-7,-1.4,-0.02],-99],
	["Land_Misc_Garb_Heap_EP1",[-6,1,-0.02]],
	["Land_Misc_Garb_Heap_EP1",[18,10,-0.02]],
	["Land_Misc_Garb_Heap_EP1",[-10,-12,-0.02]],
	["MAP_garbage_misc",[5,-21,-0.02]],
	["MAP_garbage_misc",[7,18,-0.02],-178],
	["MAP_garbage_paleta",[-12,14,-0.02],-91],
	["MAP_Kitchenstove_Elec",[-11,1.5,-0.02],146],
	["MAP_tv_a",[-12,-0.01,-0.02],108],
	["MAP_washing_machine",[-11,-1,-0.02],100],
	["MAP_P_toilet_b_02",[-16,0.01,-0.02],36],
	["Land_Misc_Garb_Heap_EP1",[-17,-3,-0.02],93],
	["MAP_garbage_paleta",[-11,-0.01,-0.02],21],
	["Land_Fire_barrel_burning",[-13,-3,-0.02]],
	["Land_Fire_barrel_burning",[2,-9,-0.02]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 2, (_position select 1) - 5, 0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 19, (_position select 1) + 19, 0],5,"Hard",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 17, (_position select 1) + 21, 0],5,"Hard",[1,"AA"],2,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 17, (_position select 1) + 21, 0],_rndnum,"Hard",[2,"AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) - 30, (_position select 1) + 40, 0],
  [(_position select 0) + 30, (_position select 1) + 40, 0],
  [(_position select 0) - 20, (_position select 1) + 30, 0],
  [(_position select 0) + 20, (_position select 1) - 30, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Static Guns
[[
	[(_position select 0) +7, (_position select 1) +1.3]
],(["UH1Wreck","UH60_wreck_EP1"] call BIS_fnc_selectRandom),"Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 17, _position select 1, 0],250,2,(spg9_vehicles call BIS_fnc_selectRandom),"Hard","Hero","Hero",_mission] call vehicle_patrol;

//Spawn Vehicle
[cargo_trucks,[(_position select 0) - 7, (_position select 1) - 9,-0.04],_mission,true,-49.99] call custom_publish;
[civil_vehicles call BIS_fnc_selectRandom,[(_position select 0) -8, (_position select 1) +7,-0.04],_mission,true,44.77] call custom_publish;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Junk Yard", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_JUNKYARD_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_JUNKYARD_WIN", // mission success
	"STR_CL_BANDIT_JUNKYARD_FAIL", // mission fail
	_time
] call mission_winorfail;