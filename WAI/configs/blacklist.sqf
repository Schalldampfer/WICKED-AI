
call {
    if (toLower worldName == "chernarus") exitWith {wai_blacklist = [
		[[0,16000,0],[1000,-0,0]],	// Left edge of map
        [[0,16000,0],[16000.0,14580.3,0]] // Top edge of map
    ];};
    if (toLower worldName == "namalsk") exitWith {wai_blacklist = [];};
    if (toLower worldName == "panthera2") exitWith {wai_blacklist = [
		[[235,686,0],[758,160,0]] // Debug Island
	];};
    if (toLower worldName == "tavi") exitWith {wai_blacklist = [];};
    if (toLower worldName == "lingor") exitWith {wai_blacklist = [];};
    if (toLower worldName == "napf") exitWith {
    	wai_blacklist = [];
		_marker = createMarkerLocal ["NEAF", [14809.406, 16662.686]];
		_marker setMarkerShapeLocal "ELLIPSE";
		_marker setMarkerTypeLocal "Empty";
		_marker setMarkerBrushLocal "Solid";
		_marker setMarkerAlphaLocal 0;
		_marker setMarkerSizeLocal [800, 800];
		_marker = createMarkerLocal ["SWAF", [4551.0645, 4605.2861]];
		_marker setMarkerShapeLocal "ELLIPSE";
		_marker setMarkerTypeLocal "Empty";
		_marker setMarkerBrushLocal "Solid";
		_marker setMarkerAlphaLocal 0;
		_marker setMarkerSizeLocal [800, 800];
    };    if (toLower worldName == "smd_sahrani_a2") exitWith {wai_blacklist = [];};
    if (toLower worldName == "sauerland") exitWith {wai_blacklist = [];};
    wai_blacklist = []; diag_log "You are on an unsupported map! No blacklist available."; //default if nothing above matches
};

diag_log "WAI: blacklist Loaded";
