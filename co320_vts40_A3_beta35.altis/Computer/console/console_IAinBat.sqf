disableSerialization;
// Attention! il faut faire passer en global toutes les variables sur l'unit�!
// **********  mettre des ennemis dans les batiments **************
if  (breakclic <= 1 ) then
{
	clic1 = false;

	_display = finddisplay 8000;
	_txt = _display displayctrl 200;

	_txt CtrlSetText "Left click on the map";
	_txt CtrlSetTextColor [0.9,0.9,0.9,1];

	Ctrlshow [200,true];sleep 0.2; CtrlShow [200,false];sleep 0.2;Ctrlshow [200,true];

	onMapSingleClick "spawn_x = _pos select 0;
		spawn_y = _pos select 1;
		spawn_z = _pos select 2;

		
		clic1 = true;
		
	onMapSingleClick """";";
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
				_marker_Take = createMarkerLocal ["Takemarker",[spawn_x,spawn_y,spawn_z]];
				_marker_Take setMarkerShapeLocal "ELLIPSE";
				//		_marker_Take setMarkerTypeLocal "mil_Dot";
				_marker_Take setMarkerSizeLocal [radius, radius];
				_marker_Take setMarkerDirLocal 0;
				_marker_Take setMarkerColorLocal "Colorgreen";
				_marker_Take setMarkerAlphaLocal 0.5;
				_code={};
				_condition="isserver";
				if !(isnil "VTS_HC_AI") then {if !(isnull VTS_HC_AI) then {_condition="player==VTS_HC_AI";};};
				call compile format["
				_code={
				if (%9) then {[[%1,%2,%3],%4,%5,""%6"",""%7"",%8] execVM ""functions\TakeBuilding.sqf"";};
				};
				",spawn_x,spawn_y,spawn_z,vts_fillinteriorpercent,local_radius,local_var_console_valid_camp,local_var_console_valid_side,local_console_unit_moral,_condition];
				_sync=[_code] call vts_broadcastcommand;
				sleep 0.25;
				deletemarker "Takemarker";
			};
			clic1 = false;

		}; 
		sleep 0.5;
		//"" spawn vts_gmmessage;
		breakclic = 0; 
		//	waitUntil {(clic1)};
};
If (true) ExitWith {};
