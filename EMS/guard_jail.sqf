//Created by axeman Edited by TheSzerdi
//Edited by Fuchs for EMS
private ["_aiunit","_xpos","_ypos","_unitpos","_aiGroup","_wppos","_wpradius","_wpnum","_levelnum","_numunits","_rndLOut","_ailoadout","_wp","_aispawnpos","_aiwep1","_aiammo1"];
 
    _aiunit = objNull;
    _aiGroup = createGroup west;
    _aispawnpos =_this select 0;
    _wpradius = _this select 1;
    _wpnum = _this select 2;
    _numunits = _this select 3;
    _levelnum = _this select 4;
 
    _xpos = _aispawnpos select 0;
    _ypos = _aispawnpos select 1;
 
    diag_log format ["AIUNIT: Spawn initiated: Centre:%1 | Radius in m:%2 | Waypoint number:%3 | WeaponLevel:%4",_aispawnpos,_wpradius,_wpnum,_levelnum];

    for [{ x=1 },{ x < _numunits+1 },{ x = x + 1; }] do
    {
        _unitpos = [_xpos+x,_ypos+x,0];
 
        if (_levelnum==0) then // in_sityes troops
        {
            if ((x == 1) || (x == 3) || (x == 5)) then //troop soldiers
            {
                "Policeman" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"PRIVATE"];
                _rndLOut=floor(random 4);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["M1014","8Rnd_B_Beneli_74Slug"]};
                  case 1: {["M1014","8Rnd_B_Beneli_Pellets"]};
                  case 2: {["Remington870_lamp","8Rnd_B_Beneli_74Slug"]};
                  case 3: {["Remington870_lamp","8Rnd_B_Beneli_Pellets"]};
                };
            };
            if ((x == 2) || (x == 4) || (x >= 6)) then //troops snipers
            {
                "Policeman" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"PRIVATE"];
                _rndLOut=floor(random 3);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["M4A1_HWS_GL_SD_Camo","30Rnd_556x45_StanagSD"]};
                  case 1: {["Huntingrifle","5x_22_LR_17_HMR"]};
                  case 2: {["M14_EP1","20Rnd_762x51_DMR"]};
                };
            };
        };
        if (_levelnum==1) then //in_military troops
        {
            if (x == 1) then //one troops comander
            {
                "Policeman" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"LIEUTENANT"];
                _rndLOut=floor(random 7);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["AK_47_M","30Rnd_762x39_AK47"]};
                  case 1: {["M4A1_RCO_GL","30Rnd_556x45_Stanag"]};
                  case 2: {["Sa58P_EP1","30Rnd_762x39_SA58"]};
                  case 3: {["Sa58V_CCO_EP1","30Rnd_762x39_SA58"]};
                  case 4: {["Sa58V_EP1","30Rnd_762x39_SA58"]};
                  case 5: {["M4SPR","30Rnd_556x45_Stanag"]};
                  case 6: {["M4A1_HWS_GL_SD_Camo","30Rnd_556x45_StanagSD"]};
                };
            };
            if ((x == 2) || (x == 3)) then //troops sergeant
            {
                "Policeman" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"SERGEANT"];
                _rndLOut=floor(random 4);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["BAF_L85A2_RIS_SUSAT","30Rnd_556x45_Stanag"]};
                  case 1: {["RPK_74","75Rnd_545x39_RPK"]};
                  case 2: {["G36A_camo","30Rnd_556x45_G36"]};
                  case 3: {["M4A1_HWS_GL_SD_Camo","30Rnd_556x45_StanagSD"]};
                };
            };
            if (x > 3) then //troops soldiers
            {
                "Policeman" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"CORPORAL"];
         
                _rndLOut=floor(random 5);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["SVD_CAMO","10Rnd_762x54_SVD"]};
                  case 1: {["M24","5Rnd_762x51_M24"]};
                  case 2: {["M24_des_EP1","5Rnd_762x51_M24"]};
                  case 3: {["SVD","10Rnd_762x54_SVD"]};
		  case 4: {["AK_107_pso","30Rnd_545x39_AK"]};
                };
            };
        };
        diag_log format ["AIUNIT: Creating Jail Guard by %1 at %2. Result:%3 | Loadout:%4 / Num:%5",player,_unitpos,_aiunit,_ailoadout,_rndLOut];
 
        _aiunit enableAI "TARGET";
        _aiunit enableAI "AUTOTARGET";
        _aiunit enableAI "MOVE";
        _aiunit enableAI "ANIM";
        _aiunit enableAI "FSM";
        _aiunit allowDammage false;
  	
		_aiunit addEventHandler ['killed',{_this execVM "\z\addons\dayz_server\EMS\bodyclean3.sqf"}]; //Body disappear time
 
        _aiunit setCombatMode "RED";
        _aiunit setBehaviour "COMBAT";
 
        //clear default weapons / ammo
        removeAllWeapons _aiunit;
        //add random selection
        _aiwep1 = _ailoadout select 0;
        _aiammo1 = _ailoadout select 1;
        _aiunit addweapon _aiwep1;
        _aiunit addMagazine _aiammo1;
        _aiunit addMagazine _aiammo1;
        _aiunit addMagazine _aiammo1;
		_aiunit removeWeapon "ItemRadio","NVGoggles";
      //add some garbage
        if (x == 1) then {
        _aiunit addMagazine "SmokeShellGreen";
        _aiunit addMagazine "HandGrenade_West";
        _aiunit addMagazine "FoodCanBakedBeans";
        _aiunit addMagazine "ItemSodaCoke";
        _aiunit addMagazine "ItemPainkiller";
        _aiunit addMagazine "ItemHeatPack";
        _aiunit addMagazine "ItemEpinephrine";
        _aiunit addMagazine "ItemMorphine";
        };
        if (x == 2) then {
        _aiunit addMagazine "ItemHeatPack";
        _aiunit addMagazine "ItemPainkiller";
        _aiunit addMagazine "ItemEpinephrine";
        _aiunit addMagazine "ItemMorphine";
        };
        if (x >= 3) then {
        _aiunit addMagazine "ItemHeatPack";
        _aiunit addMagazine "ItemBandage";
        };
        //set skills
        _aiunit setSkill ["aimingAccuracy",0.6];
        _aiunit setSkill ["aimingShake",0.7];
        _aiunit setSkill ["aimingSpeed",0.8];
        _aiunit setSkill ["endurance",0.9];
        _aiunit setSkill ["spotDistance",0.8];
        _aiunit setSkill ["spotTime",0.7];
        _aiunit setSkill ["courage",0.9];
        _aiunit setSkill ["reloadSpeed",0.8];
        _aiunit setSkill ["commanding",1];
        _aiunit setSkill ["general",1];
        //sleep 0.5;
    };
    _gun = ["gtower1","gtower2","gtower3","gtower4"] call bis_fnc_selectrandom;;
//    while{alive _aiunit} do {
//    _aiunit assignAsGunner _gun; [_aiunit] orderGetIn true;  
//    };
_count = 0;
{	
    if((isplayer _x) && (_x distance getmarkerpos "jail" < 20)) then {
	    [nil,nil,rHINT,"you have 3 minutes to leave jail"] call RE;
	    _count = _count + 1;
	    if (_count > 180) then {
	      _count = 0;
	      _jail = creategroup east;
	      [_x] join _jail;
	    _x addrating -10000;
	    };
	    };
	    }foreach playableunits;
    //generate waypoints
    for [{ x=1 },{ x < _wpnum },{ x = x + 1; }] do {
    _wppos = [_xpos+(x*20),_ypos+(x*20),_wpradius];
    _wp = _aiGroup addWaypoint [_wppos, _wpradius];
    _wp setWaypointType "MOVE";
    };
    _wp = _aiGroup addWaypoint [[_xpos,_ypos,0], _wpradius];
    _wp setWaypointType "CYCLE";
 
    diag_log format ["AIUNIT: Last Waypoint %1 at %2",_wp,_wppos];
