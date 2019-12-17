private ["_time","_rndnum","_mission","_position","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Crack House]: Starting... %1",_position];

// Loot
_loot = [0,0,[10,crate_items_crop_raider],10,2];

//Spawn Crates
[[
	[_loot,crates_medium,[2.3,-3,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_dum_zboreny",[-0.01,0.02,-0.1]],
	["Land_Misc_Garb_Heap_EP1",[5.6,3.4,-0.01]],
	["MAP_Kitchenstove_Elec",[2,5,-0.1]],
	["MAP_P_toilet_b_02",[-4.4,-3.3,-0.01],-90.84],
	["MAP_P_bath",[-4.9,-5,-0.01]],
	["MAP_armchair",[-1.7,-4.6,-0.01],179.92],
	["MAP_SmallTable",[2.6,1.4,-0.15]],
	["MAP_kitchen_chair_a",[2.5,2.2,-0.01]],
	["Land_Boots_EP1",[8.4,-1.5,-0.01],-170.27],
	["Land_Blankets_EP1",[-6.3,4.8,0.01],-170.27],
	["Land_Bench_EP1",[-3.2,-2.2,0.015]],
	["Land_Water_pipe_EP1",[-1.4,-3,0.01],105.15],
	["Land_Bag_EP1",[-5.9,1.9,0.01]],
//	["LADAWreck",[-8,-4,-0.01],-119.578],
	["SKODAWreck",[11,-3,-0.01]],
	["MAP_tv_a",[-2.7,-0.1,0.01]],
	["MAP_Dkamna_uhli",[-0.01,5,-0.1]],
	["MAP_Skrin_opalena",[1.2,0.1,0.05]],
	["MAP_Dhangar_whiteskrin",[0.9,1.6,0.05],91.19],
	["MAP_garbage_paleta",[5.3,-2,-0.01]],
	["MAP_t_salix2s",[-0.01,15,-0.01],47.639],
	["MAP_t_salix2s",[-0.01,-17,-0.01]],
	["MAP_t_salix2s",[25,-0.01,-0.01]],
	["MAP_t_salix2s",[-24,-0.01,-0.01]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 12, (_position select 1) - 15,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 12, (_position select 1) + 15,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 30, (_position select 1) - 30, 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Spawn Vehicle
[civil_vehicles,[(_position select 0) -8, (_position select 1) -4,-0.01],_mission,true,-119.578] call custom_publish;

//Paradrop after mission
[_position,100,civil_chopper call BIS_fnc_selectRandom,["North","South","East","West"] call BIS_fnc_selectRandom,[4000,5000],100,0.4,300,6,"Random","MP5_SD_DZ",2,"Random","RU_Policeman_DZ","Random","Hero",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Crack House", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_DRUGBUST_ANNOUNCE", // mission announcement
	"STR_CL_HERO_DRUGBUST_WIN", // mission success
	"STR_CL_HERO_DRUGBUST_FAIL", // mission fail
	_time
] call mission_winorfail;