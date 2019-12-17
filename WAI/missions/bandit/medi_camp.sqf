private ["_time","_loot","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Medical Supply Camp]: Starting... %1",_position];

// Loot
_loot = [0,2,[40,crate_items_medical],0,2];

//Spawn Crates
[[
	[_loot,crates_small,[0,0],60]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_fort_watchtower",[1.5,12.6],-210],
	["MAP_MASH",[-17,5.3],60],
	["MAP_Stan_east",[-16.5,15.9],-30],
	["USMC_WarfareBFieldhHospital",[3,-4.4],60],
	["MAP_Stan_east",[-10,19.6],-30],
	["MAP_MASH",[-14,-0.4],60]
],_position,_mission] call wai_spawnObjects;

//MV22
["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish;

//Troops
[[(_position select 0) - 7.5,(_position select 1) + 7.9,0],4,"Medium",["Random","AT"],3,"Random","US_Soldier_EP1_DZ",   "Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 7.5,(_position select 1) + 7.9,0],4,"Medium",["Random","AT"],3,"Random","BAF_Soldier_N_MTP_DZ","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 7.5,(_position select 1) - 7.9,0],4,"Medium",["Random","AA"],3,"Random","RUS_Soldier1_DZ",     "Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 35, _position select 1, 0],       [(_position select 0) + 30, _position select 1, 0],50,2,"M1114_AGS_ACR","Hard","GER_Soldier_TL_EP1_DZ","Hero",_mission] call vehicle_patrol;
[[(_position select 0) +  2, (_position select 1) + 38, 0],[(_position select 0) - 28, _position select 1, 0],50,2,"M1114_DSK_ACR","Hard","BAF_Soldier_N_MTP_DZ", "Hero",_mission] call vehicle_patrol;

//Heli Paradrop
[[(_position select 0),(_position select 1),0],1000,"C130J_US_EP1_DZ","North",[3000,4000],150,1.0,250,10,"Random","Random",4,"Random","RU_Soldier_DZ","Random","Hero",false,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Medical Supply Camp", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_MSC_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_MSC_WIN", // mission success
	"STR_CL_BANDIT_MSC_FAIL", // mission fail
	_time
] call mission_winorfail;