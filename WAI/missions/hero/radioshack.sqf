private ["_mission","_position","_rndnum"];

_mission = count wai_mission_data -1;

_position = [40] call find_position;

diag_log format["WAI: Mission:[Hero] Radio Tower started at %1",_position];

//Spawn Crates
[[
	[[4,[4,ai_wep_special_good],[10,crate_items_crop_raider],0,0],crates_medium,[.01,.01]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_cihlovej_dum_in",[-3,-1]],
//	["LADAWreck",[-7.5,-3]],
	["FoldTable",[-1.2,-4]],
	["FoldChair",[-1,-3]],
	["SmallTV",[-1.7,-4,0.82]],
	["SatPhone",[-0.8,-4,0.82],-201.34],
	["MAP_t_picea2s",[-4.5,7]],
	["MAP_t_picea2s",[13,10]],
	["MAP_t_pinusN2s",[3,9]],
	["MAP_t_pinusN1s",[8,17]],
	["MAP_t_picea1s",[7,10]],
	["MAP_t_picea2s",[34,-29]],
	["MAP_t_fraxinus2s",[-14,1]],
	["MAP_t_carpinus2s",[28,-13]]
],_position,_mission] call wai_spawnObjects;
_tower=[[
	["Land_Com_tower_ep1",[5,-2]]
],_position,-1] call wai_spawnObjects;

//Sound effect
[_position,_mission,_tower] spawn {
	private ["_pos","_mission","_running","_tower"];
	_pos = _this select 0;
	_mission = _this select 1;
	_tower = _this select 2;
	_running = true;
	while {_running} do {
		sleep ((random 2) + 2);
		_running = (typeName (wai_mission_data select _mission) == "ARRAY");
		{
			if ((isPlayer _x) && (_x distance _pos < 5)) exitWith { _running = false;};
			//if ((alive _x) && (_x distance _pos < 1600)) then {[objNull,_x,rSAY,"radionoise2",2] call RE;[nil,_x,"loc",rTITLETEXT,"[RADIO] . . .","PLAIN DOWN",2] call RE;};
		} count playableUnits;
	};
	[_tower] call wai_fnc_remove;
};

// Troops
_rndnum = round (random 5);
[[(_position select 0) - 1.2, (_position select 1)  - 20, 0],5,"hard","Random",3,"random","bandit","random","bandit",_mission] call spawn_group;
[[(_position select 0) - 17, (_position select 1) - 4, 0],5,"Medium",["random","RPG7V"],3,"random","bandit","random","bandit",_mission] call spawn_group;
[[(_position select 0) + 14, (_position select 1) - 3, 0],_rndnum,"Medium","Random",3,"random","bandit","random","bandit",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) - 10, (_position select 1) + 10, 0]],(ai_static_weapons call BIS_fnc_selectRandom),"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Spawn Vehicle
[civil_vehicles call BIS_fnc_selectRandom,[(_position select 0) -7.5, (_position select 1) -3,0],_mission,true,0] call custom_publish;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Radio Tower", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_RADIO_ANNOUNCE", // mission announcement
	"STR_CL_HERO_RADIO_WIN", // mission success
	"STR_CL_HERO_RADIO_FAIL" // mission fail
] call mission_winorfail;