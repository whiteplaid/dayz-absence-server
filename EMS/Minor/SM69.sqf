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
diag_log "EMS: Minor mission created (SM69)";

//Mission start
[nil,nil,rTitleText,localize "STR_MinorM69", "PLAIN",10] call RE;
missiontext75 = localize "STR_MinorM69short";
MCoords = _position;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

			_missiontext = [_missionname,"Escort a medic on battlefield"];
			_group = createGroup civilian;
			_unit = _group createUnit ["Doctor", getmarkerpos "safezone", [], 0, "NONE"];
						_vname = "Doctor";
			_name = gettext (configFile >> "CfgVehicles" >> _vname >> "DisplayName");
			_picture = "\z\addons\dayz_code\pics\doctor.paa";
_text = parseText format ["<t color='#FFCC33'>+2000 humanity</t><br/><br/><img size='5' image='%1'/><br/><br/><t color='#FFCC33'>Escort</t>", _picture];
[nil,nil,rHINT,_text] call RE;
			_unit setVehicleInit "this addAction ['<t color=''#ff4500''>Escort a medic</t>', '\z\addons\dayz_code\warcontext\actions\WC_fnc_dofollowme.sqf',[],6,false, true];";
			processinitcommands;
			_vehicle = createVehicle ["MASH_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_unit, position _vehicle] spawn WC_fnc_bringunit;
			wcgarbage = [_unit] spawn WC_fnc_createmedic;
			_missiontype = "bringunit";
	
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
			
