	// -----------------------------------------------
	// Author: code34 nicolas_boiteux@yahoo.fr
	// warcontext - teleport to MHQ

	private [
		"_vehicle",
		"_position"
	];

	_vehicle = wcteleport;

	if(format ["%1", _vehicle] == "any") exitWith {hint "No respawn point avalaible";};

	_position = (position _vehicle) findemptyposition [10, 300];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR RESPAWN POINT";
	};

	if ((alive _vehicle) and ((position _vehicle) distance _position < 100)) then {
		if(leader(group player) == player) then {
			{		
				if((!isplayer _x) and (_x distance player < 50)) then {
					_x setpos _position;
				};
			}foreach (units(group player));
		};
		player setpos _position;
	} else {
		hint "No respawn point avalaible";
	};