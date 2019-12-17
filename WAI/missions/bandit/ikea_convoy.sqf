private ["_time","_rndnum","_mission","_position","_vehclass","_vehclass2","_vehclass3"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Lunch break Convoy]: Starting... %1",_position];

// Loot
_loot = [[1,crate_weapons_buildables],[4,crate_tools_buildable],[20,crate_items_buildables],0,4];

//Spawn Crates
[[
	[_loot,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Troops
_rndnum = round (random 5) + 5;
[[_position select 0,_position select 1,0],5,"Hard",[0,"AT"],3,"Random","Worker1_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[0,"AT"],3,"Random","Worker3_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[2,"AT"],3,"Random","Worker4_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[2,"AA"],3,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 55, _position select 1, 0],       [(_position select 0) - 50, _position select 1, 0],500,2,armed_vehicle call BIS_fnc_selectRandom,"Hard","Soldier_Bodyguard_AA12_PMC_DZ","Hero",_mission] call vehicle_patrol;
[[(_position select 0) +  2, (_position select 1) + 48, 0],[(_position select 0) - 48, _position select 1, 0],250,2,"ArmoredSUV_PMC","Hard","Soldier_Bodyguard_AA12_PMC_DZ","Hero",_mission] call vehicle_patrol;
[[(_position select 0) - 55, (_position select 1) + 48, 0],[(_position select 0) + 48, _position select 1, 0],150,2,spg9_vehicles call BIS_fnc_selectRandom,"Hard","Soldier_Bodyguard_AA12_PMC_DZ","Hero",_mission] call vehicle_patrol;

//Heli Para Drop
[[(_position select 0),(_position select 1),0],800,"BAF_Merlin_DZE","North",[3000,4000],150,1.0,200,10,"Random",["Random","at"],4,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random","Hero",false,_mission] spawn heli_para;

[cargo_trucks,[(_position select 0) + 19,(_position select 1) + 11],_mission,true,90] call custom_publish;
[refuel_trucks,[(_position select 0) - 14,(_position select 1) - 14],_mission,true,-90] call custom_publish;
[military_unarmed,[(_position select 0) - 20,(_position select 1) - 6],_mission,true,-90] call custom_publish;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lunch break Convoy", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_IKEA_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_IKEA_WIN", // mission success
	"STR_CL_BANDIT_IKEA_FAIL", // mission fail
	_time
] call mission_winorfail;
