private ["_veh","_killer"];
_veh = _this select 0;
_killer = _this select 1;

_veh removeAllEventHandlers "GetOut";

{
	unassignVehicle _x;
	_x action ["eject",_veh];
} forEach (assignedCargo _veh);

_veh setFuel 0;
_veh setVehicleAmmo 0;

_veh removeAllEventHandlers "Killed";
_veh removeAllEventHandlers "HandleDamage";

dayz_serverObjectMonitor = dayz_serverObjectMonitor - [_veh];
diag_log format["WAI: %1 is killed @ %2 - %3",typeOf _veh,position _veh,_veh getVariable ["mission",-1]];
