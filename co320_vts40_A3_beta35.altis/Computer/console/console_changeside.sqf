
disableSerialization;

_gmable=player getVariable "GMABLE";If !([player] call vts_getisGM) then {if (isnil "_gmable") then {killscript=true;breakclic=0;};}; if (killscript) exitwith {killscript=false;};

private ["_source"];

//Début de script OnmapClick
if  (breakclic <= 1 ) then
{
	clic1 = false;

	_display = finddisplay 8000;
	_txt = _display displayctrl 200;

	_txt CtrlSetText "Left click on the map to select the group";
	_txt CtrlSetTextColor [0.9,0.9,0.9,1];

	Ctrlshow [200,true];sleep 0.2; CtrlShow [200,false];sleep 0.2;Ctrlshow [200,true];

  //Récuperation des coordonnées de la carte
	onMapSingleClick "
    spawn_x = _pos select 0;
		spawn_y = _pos select 1;
		spawn_z = _pos select 2;

		clic1 = true;
	   onMapSingleClick """";
     ";
	 
		for "_j" from 10 to 0 step -1 do 
		{
		format["Click On Map %1, or wait for cancellation",_j] spawn vts_gmmessage;
		sleep 1;
		//hint "pause";
		
			//if (_clic1) exitWith {};
			if (clic1) then
			{
				"" spawn vts_gmmessage;
				_j=0;
				clic1 = false;
				_posclick = [spawn_x,spawn_y,spawn_z];
				/*
        _marker_Take = createMarkerLocal ["Nmarker",_posclick];
				_marker_Take setMarkerShapeLocal "ELLIPSE";
				//		_marker_Take setMarkerTypeLocal "mil_Dot";
				_marker_Take setMarkerSizeLocal [25, 25];
				_marker_Take setMarkerDirLocal 0;
				_marker_Take setMarkerColorLocal "Colorred";
				_marker_Take setMarkerAlphaLocal 0.5;
				*/
				
        //******************************
        //***** Code come here *********
				//******************************
				
	      _list = [[spawn_x,spawn_y,spawn_z],["CAManBase","Car","Truck","Tank","Helicopter","Plane","Ship"],500] call vts_nearestobjects2d;
	      _source = _list select 0;
	      
	      if ((count _list)==0) exitwith {breakclic = 0;hint "!!! No units found !!!"};
	     

	
	      
	      _group = group _source;
	      _count=0;
	      {
          _count=_count+1;
          call compile format["_marker=createMarkerLocal [""Gmarker%1"",getpos _x]; _marker setMarkerTypeLocal ""mil_Dot"";_marker setMarkerSizeLocal [1, 1]; _marker setMarkerAlphaLocal 0.5; _marker setMarkerColorLocal ""ColorGreen"";",_count];
        } foreach units _group;
	      
        //First	we create a group on  the current side
        private "_newgroup";
        call compile format["_newgroup = creategroup %1",var_console_valid_side];
        //_unit=_newgroup createunit ["USMC_Soldier",getpos Leader _group,[],0,"FORM"];
        //_newgroup selectLeader _unit;
        
		//Then i copy all waypoints
        _newgroup copyWaypoints _group;
		
        // then i every member of the group in this new sided camp;
        {[_x] joinsilent _newgroup;} foreach units _group;

     
        
        //Then i delete the obsolete group
        
        sleep 0.25;
        //{_x setcaptive false} foreach units _newgroup;
        deleteGroup _group;
        //deletevehicle _unit;
        
        hint format["Group moved to side : %1",var_console_valid_side];
	      
				//******************************
				
        breakclic = 0; 
       	sleep 0.5;
		
		vtsgrouptochangeside=_newgroup;
		
		publicvariable "vtsgrouptochangeside";
		_code=
		{
			{_x addrating 100000;} foreach units vtsgrouptochangeside;
		};
		[_code] call vts_broadcastcommand;
		
		deletemarker "Nmarker";
		//clean marker
		while {_count>0} do
		{
			  call compile format["deletemarker ""Gmarker%1"";",_count];
			  _count=_count-1;
        };
								
			};
			clic1 = false;

		}; 
		sleep 0.25;
		//"" spawn vts_gmmessage;
		breakclic = 0; 
		//	waitUntil {(clic1)};
};
If (true) ExitWith {};
