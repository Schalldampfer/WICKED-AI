private ["_time","_rndnum","_president_himself","_mission","_position","_president","_president_himself"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [50] call find_position;
_time = ["MainBandit",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Bandit] Presidents in Town]: Starting... %1",_position];

// Loot
_loot = [[6,(ai_wep_special_good + ai_wep_special_cheap)],0,[10,crate_items_president],[1,(ai_wep_special_delux + ai_wep_special_rare)],2];

//Spawn Crates
[[
	[_loot,crates_large,[0,0,.25]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_A_Office01",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Hard",[1,"AA"],2,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[1,"AA"],2,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[0,"AT"],3,"Random","RU_Policeman_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[2,"AT"],3,"Random","RU_Policeman_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard",[2,"AT"],3,"Random","RU_Policeman_DZ","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Hard","KSVK_DZE",3,"Random","Soldier_Bodyguard_AA12_PMC_DZ","Random","Hero",_mission] call spawn_group;

//The President Himself
_president = [[((_position select 0) + 5), _position select 1, 4.1],1,"Extreme","revolver_gold_EP1",4,"none","Special","Random",["Hero",250],_mission] call spawn_group;
_president setBehaviour "COMBAT";

_president_himself = (units _president) select 0;
_president_himself setUnitPos "UP";
_president_himself disableAI "MOVE";

//Let him move once player is near
[_president_himself] spawn {
	private ["_president","_player_near"];
	_president = _this select 0;
	_player_near = false;
	while {!_player_near} do {
		_player_near = [(position _president),30] call isNearPlayer;
		uiSleep 1;
	};
	_president enableAI "MOVE";
	doStop _president;
};

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,ai_armored_vehicles call BIS_fnc_selectRandom,"Random","CZ_Special_Forces_GL_DES_EP1_DZ","Hero",_mission] call vehicle_patrol;

//Static guns
[[
	[(_position select 0) - 13.135, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 14.225, (_position select 1) + 5.025, 5.27],
	[(_position select 0) - 50,(_position select 1), 0]
],(ai_static_weapons call BIS_fnc_selectRandom),"Hard","Hero","Hero",1,2,"Random","Random",_mission] call spawn_static;
[[
	[(_position select 0) + 1.97, (_position select 1) - 2.368, 11.5]
],"SearchLight_RUS","Extreme","Hero","Hero",0,2,"none","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"President's in Town", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["assassinate",_president], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_PRESIDENT_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_PRESIDENT_WIN", // mission success
	"STR_CL_BANDIT_PRESIDENT_FAIL", // mission fail
	_time
] call mission_winorfail;