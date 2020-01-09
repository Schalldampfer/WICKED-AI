private ["_mission","_position","_aiType","_rndnum","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [100] call find_position;

if (([_missionType,_position,_mission] call wai_waitForPlayers) < 1) exitWith { [_missionType,_mission] call wai_removeMission; };

diag_log format["WAI: [Mission:[%2] Gem Tower]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_GemTower select 0;} else {Loot_GemTower select 1;};

//Spawn Crates
[[
	[_loot,crates_medium,[-20,11]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Misc_Coltan_Heap_EP1",[-3.41,16.4,-2.5],-82.16],
	["Land_Misc_Coltan_Heap_EP1",[-31,12,-2],8.27],
	["Land_Misc_Coltan_Heap_EP1",[-26,34,-2]],
	["GraveCrossHelmet",[-20,11]]
],_position,_mission] call wai_spawnObjects;
[[
	["Land_Ind_SiloVelke_01",[-0.01,-0.01,-0.25]],
	["Land_Ind_SiloVelke_01",[-21,-0.4,-0.25],182.209],
	["Land_A_Castle_Bastion",[-21,11,-0.2]]
],_position,-1] call wai_spawnObjects;

//Troops
[[(_position select 0) + 29, (_position select 1) - 21, 0],5,"Extreme",[1,"M47Launcher_EP1"],4,"Random","TK_CIV_Takistani01_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 19, 0],5,"Extreme",[1,"AT"],4,"Random","TK_CIV_Takistani03_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 23, (_position select 1) - 19, 0],5,"Extreme",[2,"Igla"],4,"Random","TK_CIV_Takistani04_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 12, (_position select 1) + 23, 0],5,"Extreme",[2,"AA"],4,"Random","TK_CIV_Takistani06_EP1_DZ","Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 12, (_position select 1) + 23, 0],5,"Extreme",["Anzio_20_DZ","KSVK_DZE"] call BIS_fnc_selectRandom,6,"Random","TK_INS_Warlord_EP1_DZ","Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
_uG1=[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],500,4,ai_armored_vehicles call BIS_fnc_selectRandom,"Extreme","TK_INS_Soldier_EP1_DZ",_aiType,_mission] call vehicle_patrol;
_uG2=[[(_position select 0) - 50, _position select 1, 0],[(_position select 0) + 60, _position select 1, 0],500,4,ai_antiair_vehicles call BIS_fnc_selectRandom,"Extreme","TK_INS_Soldier_EP1_DZ",_aiType,_mission] call vehicle_patrol;
(units _uG2) joinSilent _uG1;

//Static Guns
_uG1=[[
	[(_position select 0) - 1, (_position select 1) + 39, 0],
	[(_position select 0) + 33, (_position select 1) - 21, 0]
],"ZU23_TK_GUE_EP1","Extreme","TK_INS_Soldier_EP1_DZ",_aiType,0,2,"Random","Random",_mission] call spawn_static;
_uG2=[[
	[(_position select 0) + 1, (_position select 1) - 39, 0],
	[(_position select 0) + 33, (_position select 1) + 21, 0]
],ai_static_weapons call BIS_fnc_selectRandom,"Extreme","TK_INS_Soldier_EP1_DZ",_aiType,0,2,"Random","Random",_mission] call spawn_static;
(units _uG2) joinSilent _uG1;
_uG2=[[
  [(_position select 0) + 20, (_position select 1) - 20, 0]
],"Igla_AA_pod_TK_EP1","Extreme","TK_INS_Soldier_EP1_DZ",_aiType,0,2,"Random","Random",_mission] call spawn_static;
(units _uG2) joinSilent _uG1;

//Paradrop after mission
[_position,70,armed_chopper call BIS_fnc_selectRandom,["North","South","East","West"] call BIS_fnc_selectRandom,[4000,5000],100,0.4,300,6,"Random",0,4,"Random",_aiType,"Random",_aiType,true] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Extreme", // Difficulty
	"Gem Tower", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_GEMTOWER_ANNOUNCE","STR_CL_GENERAL_GEMTOWER_WIN","STR_CL_GENERAL_GEMTOWER_FAIL"]
] call mission_winorfail;
