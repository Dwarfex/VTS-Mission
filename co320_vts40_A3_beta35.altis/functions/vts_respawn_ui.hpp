class VTS_respawn_ui
{
	IDD = 8010;
	MovingEnable = 0;
	
	class Controls
	{
		class vts_respawn_button: VTS_boutons
		{
			idc = 1600;
			style = ST_CENTER; 
			text = "Force respawn"; //--- ToDo: Localize;
			colorText[] = {0.9,0.3,0.3, 1};
			x = 0.412485 * safezoneW + safezoneX;
			y = 0.765988 * safezoneH + safezoneY;
			w = 0.17503 * safezoneW;
			h = 0.0839961 * safezoneH;
			action = "[player] spawn vts_respawn_forcerespawn_uibutton;";
			tooltip = "Respawn at your respawn position or you can wait for a revive or the timer to end";
		};
	};
};