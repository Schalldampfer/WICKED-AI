private ["_time","_rndnum","_room","_mayor_himself","_mission","_position","_mansion","_mayor"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Mayors Mansion]: Starting... %1",_position];

// Loot
_loot = [4,2,[10,crate_items_president],4,2];

//Spawn Crates
[[
	[_loot,crates_large,[0,0,.25]]
],_position,_mission] call wai_spawnCrate;
 
// Spawn Objects
_mansion = [[
	["Land_A_Villa_EP1",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium",["Random","RPG7V"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",3,"Random","BAF_Soldier_Officer_MTP_DZ","Random","Bandit",_mission] call spawn_group;

//The Mayor Himself
_mayor = [_position,1,"extreme","revolver_gold_EP1",4,"Random","Special","Random",["Bandit",100],_mission] call spawn_group;
_mayor setBehaviour "COMBAT";
_mayor_himself = (units _mayor) select 0;
_mayor_himself setUnitPos "UP";

//Put the Mayor in his room
_room = (6 + ceil(random(3)));
_mayor_himself disableAI "MOVE";
_mayor_himself setPos (_mansion buildingPos _room);

//Let him move once player is near
_mayor_himself spawn {
	private ["_mayor","_player_near"];
	_mayor = _this;
	_player_near = false;
	while {!_player_near} do {
		_player_near = [(position _mayor),30] call isNearPlayer;
		uiSleep 2;
	};
	_mayor enableAI "MOVE";
	doStop _mayor;
};

//Static mounted guns
[[
	[(_position select 0) - 15, (_position select 1) + 15, 8],
	[(_position select 0) + 15, (_position select 1) - 15, 8]
],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",1,2,"Random","Random",_mission] call spawn_static;
[[
	[(_position select 0) - 50,(_position select 1), 0]
],"SearchLight_Ins","Extreme","Bandit","Bandit",0,2,"none","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Mayors Mansion", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["assassinate",_mayor], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_MAYOR_ANNOUNCE", // mission announcement
	"STR_CL_HERO_MAYOR_WIN", // mission success
	"STR_CL_HERO_MAYOR_FAIL", // mission fail
	_time
] call mission_winorfail;
