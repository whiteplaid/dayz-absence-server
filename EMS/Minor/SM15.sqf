private [
		"_vehicle", 
		"_location", 
		"_unit", 
		"_position", 
		"_group", 
		"_missiontype", 
		"_x", 
		"_building", 
		"_arrayofpos", 
		"_startposition", 
		"_index", 
		"_buildings", 
		"_missionname",
		"_missionnumber",
		"_missiontext75",
		"_marker",
		"_count",
		"_watersafeposition"
		];

private ["_position","_wait","_MainMarker75"];
[] execVM "\z\addons\dayz_server\EMS\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};
	
_position = wctownlocations call bis_fnc_selectrandom;
_marker = ['rescuezone', wcdistance, _position, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarker;
_marker = ['sidezone', 100, _position, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	_marker2 = ["bombzone", _marker] call WC_fnc_copymarkerlocal;
	_marker2 setMarkerSizeLocal [300, 300];
	_position = ["sidezone", "onground", "onflat", "empty"] call WC_fnc_createpositioninmarker;
	while { format ["%1", _position] ==  "[1,1,0]"} do {
		_position = ["sidezone", "onground", "onflat", "empty"] call WC_fnc_createpositioninmarker;
	};
diag_log "EMS: Minor mission created (SM15)";

//Mission start
[nil,nil,rTitleText,localize "STR_MinorM15", "PLAIN",10] call RE;
missiontext75 = localize "STR_MinorM15short";
MCoords = _position;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_group = createGroup east;
			_vehicle = _group createUnit ["Functionary1", _position, [], 0, "NONE"];
			_vname = "Functionary1";
			_name = gettext (configFile >> "CfgVehicles" >> _vname >> "DisplayName");
			_picture = "\z\addons\dayz_code\pics\Functionary1.paa";
_text = parseText format ["<t color='#FFCC33'>4 BC Gold</t><br/><br/><img size='5' image='%1'/><br/><br/><t color='#FFCC33'>Eliminate</t>", _picture];
[nil,nil,rHINT,_text] call RE;
			_arrayofpos = [_position, "bot"] call WC_fnc_gethousespositions;
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			_vehicle addmagazine "ItemBriefcase100oz";
			_vehicle addmagazine "ItemBriefcase100oz";
			_vehicle addmagazine "ItemBriefcase100oz";
			_vehicle addmagazine "ItemBriefcase100oz";
			wcgarbage = [_vehicle] spawn {
				private ["_unit"];
				_unit = _this select 0;
				_unit stop false;
			};
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
// CREATE ENEMIES ON TARGET
_numberofgroup = 4;
		for "_x" from 1 to _numberofgroup step 1 do {
			wcgarbage = [_marker, wcfactions call BIS_fnc_selectRandom, false] spawn WC_fnc_creategroup;
			sleep 2;
		};
		_numberofvehicle = 3;
		// CREATE ENEMIES VEHICLES ON TARGET
		for "_x" from 1 to _numberofvehicle step 1 do {
			wcgarbage = [_marker, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroup;
			sleep 2;
		};
			_missiontype = "eliminate";

waitUntil{!alive _vehicle};

//Mission completed
[nil,nil,rTitleText,localize "STR_MinorM15end", "PLAIN",6] call RE;
deletemarker "rescuezone";
deletemarkerlocal "sidezone";
deletemarkerlocal "bombzone";
[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 1;
[0] execVM "\z\addons\dayz_server\EMS\minor\SMfinder.sqf";
