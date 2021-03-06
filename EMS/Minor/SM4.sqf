//Bandit Heli Down! by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)

private ["_position","_wait","_MainMarker75","_marker"];
[] execVM "\z\addons\dayz_server\EMS\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};
//_position =  [getMarkerPos "center",0,5000,10,0,1000,0] call BIS_fnc_findSafePos;
_position = wctownlocations call bis_fnc_selectrandom;
_marker = ['rescuezone', wcdistance, _position, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarker;
_marker = ['sidezone', 100, _position, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	_marker2 = ["bombzone", _marker] call WC_fnc_copymarkerlocal;
	_marker2 setMarkerSizeLocal [300, 300];
	_position = ["sidezone", "onground", "onflat", "empty"] call WC_fnc_createpositioninmarker;
	while { format ["%1", _position] ==  "[1,1,0]"} do {
		_position = ["sidezone", "onground", "onflat", "empty"] call WC_fnc_createpositioninmarker;
	};
diag_log "EMS: Minor mission created (SM4)";

//Mission start
[nil,nil,rTitleText,localize "STR_MinorM4", "PLAIN",10] call RE;
missiontext75 = localize "STR_MinorM4short";
MCoords = _position;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_chopcrash = createVehicle ["UH60Wreck_DZ",_position,[], 0, "CAN_COLLIDE"];
_chopcrash setVariable ["Sarge",1,true];
wcgarbage = [_chopcrash] spawn WC_fnc_protectobject;
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
_crate2 = createVehicle ["USLaunchersBox",[(_position select 0) - 6, _position select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\EMS\misc\fillBoxesS.sqf";
_crate2 setVariable ["permaLoot",true];

[_position,40,4,3,1] execVM "\z\addons\dayz_server\EMS\add_unit_server.sqf";//AI Guards
sleep 1;
[_position,40,4,3,1] execVM "\z\addons\dayz_server\EMS\add_unit_server.sqf";//AI Guards
sleep 1;

waitUntil{{isPlayer _x && _x distance _chopcrash < 30  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,localize "STR_MinorM4end", "PLAIN",6] call RE;
deletemarker "rescuezone";
deletemarkerlocal "sidezone";
deletemarkerlocal "bombzone";
[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 5;
[0] execVM "\z\addons\dayz_server\EMS\minor\SMfinder.sqf";
