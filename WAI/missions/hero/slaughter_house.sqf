private ["_time","_rndnum","_mission","_position","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;
_time = ["MainHero",_position,_mission] call wai_waitForPlayers;
if (_time < 1) exitWith { h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true; };

diag_log format["WAI: [Mission:[Hero] Slaughter House]: Starting... %1",_position];

// Loot
_loot = [[2,crate_weapons_buildables + ai_wep_pistol],0,[14,crate_items_food],0,[2,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_medium,[2.5,0,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_aif_tovarna1",[-0.01,-0.01,-0.02]],
	["Land_stand_meat_EP1",[-4,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[0.001,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-1,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[4,2,-0.02],0.3693],
	["Mass_grave",[-3,20,-0.02]],
	["Mass_grave",[4,18,-0.02]],
	["Mass_grave",[0,-15,-0.02]],
	["Axe_woodblock",[-4,-14,-0.02],-25],
	["Land_Table_EP1",[2,-2,-0.02]],
	["MAP_icebox",[-2,-0.01,-0.02]]
],_position,_mission] call wai_spawnObjects;

//Sound effect
[_position,_mission] spawn {
	private ["_pos","_mission","_running"];
	_pos = _this select 0;
	_mission = _this select 1;
	_running = true;
	while {_running} do {
		sleep ((random 4) + 3);
		_running = (typeName (wai_mission_data select _mission) == "ARRAY");
		{
			if ((alive _x) && (_x distance _pos < 30)) then {[objNull,_x,rSAY,"z_gut_0",2] call RE;};
		} count playableUnits;
	};
};

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],_rndnum,"Easy",4,2,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0), (_position select 1) + 20, 0],[(_position select 0), (_position select 1) - 20, 0],50,2,pk_vehicle call BIS_fnc_selectRandom,"Easy","Bandit","Bandit",_mission] call vehicle_patrol;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Slaughter House", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	false, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_SLAUGHTERHOUSE_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_SLAUGHTERHOUSE_WIN", // mission success
	"STR_CL_GENERAL_SLAUGHTERHOUSE_FAIL", // mission fail
	_time
] call mission_winorfail;
