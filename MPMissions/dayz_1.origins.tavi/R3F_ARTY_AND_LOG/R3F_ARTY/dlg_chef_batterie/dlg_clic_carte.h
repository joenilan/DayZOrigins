/**
 * Interface d'affichage de la carte pour y récupérer les coordonnées du clic
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "dlg_constantes.h"

class R3F_ARTY_dlg_clic_carte
{
	idd = R3F_ARTY_IDD_dlg_clic_carte;
	onLoad = "execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\traduire_dlg_clic_carte.sqf"";";
	name = "R3F_ARTY_dlg_clic_carte";
	movingEnable = false;
	
	controlsBackground[] =
	{
		R3F_ARTY_dlg_clic_carte_bord_haut,
		R3F_ARTY_dlg_clic_carte_bord_gauche,
		R3F_ARTY_dlg_clic_carte_bord_droit,
		R3F_ARTY_dlg_clic_carte_bord_bas,
		
		R3F_ARTY_dlg_clic_carte_coin_haut_gauche,
		R3F_ARTY_dlg_clic_carte_coin_haut_droit,
		R3F_ARTY_dlg_clic_carte_coin_bas_gauche,
		R3F_ARTY_dlg_clic_carte_coin_bas_droit,
		
		R3F_ARTY_dlg_clic_carte_btn_fonctions,
		R3F_ARTY_dlg_clic_carte_btn_generaux,
		R3F_ARTY_dlg_clic_carte_btn_power,
		
		R3F_ARTY_dlg_clic_carte_arriere_plan
	};
	objects[] = {};
	controls[] = {R3F_ARTY_dlg_clic_carte_titre, R3F_ARTY_dlg_clic_carte_btn_annuler, R3F_ARTY_dlg_clic_carte_carte};
	
	class R3F_ARTY_dlg_clic_carte_texte_basique
	{
		idc = -1;
		type = CT_STATIC;
		style = ST_LEFT;
		colorText[] = {0.75, 1, 0.55, 1};
		colorBackground[] = {0.15, 0.18, 0.15, 1};
		font = "BitStream";
		sizeEx = 0.028;
		h = 0.028;
		text = "";
	};
	
	class R3F_ARTY_dlg_clic_carte_arriere_plan
	{
		idc = -1;
		type = CT_STATIC;
		style = ST_LEFT;
		colorText[] = {0.66, 0.95, 0.47, 1};
		colorBackground[] = {1, 1, 1, 1};
		font = "BitStream";
		sizeEx = 0.028;
		x = 0; y = 0;
		w = 1; h = 1;
		text = "";
	};
	
	class R3F_ARTY_dlg_clic_carte_bord_haut : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = -0.015; w = 1.03;
		y = -0.07; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_haut.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_bord_gauche : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = -0.0525; w = 0.0525;
		y = -0.015; h = 1.03;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_gauche.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_bord_droit : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = 1; w = 0.0525;
		y = -0.015; h = 1.03;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_droit.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_bord_bas : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = -0.015; w = 1.03;
		y = 1; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_bas.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_coin_haut_gauche : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = -0.0525; w = 0.0525;
		y = -0.07; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_haut_gauche.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_coin_haut_droit : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = 1; w = 0.0525;
		y = -0.07; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_haut_droit.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_coin_bas_gauche : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = -0.0525; w = 0.0525;
		y = 1; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_bas_gauche.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_coin_bas_droit : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = 1; w = 0.0525;
		y = 1; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_bas_droit.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_btn_fonctions : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = 0.006; w = 0.215;
		y = 1.014; h = 0.035;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\btn_fonctions.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_btn_generaux : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = 0.70; w = 0.215;
		y = 1.014; h = 0.035;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\btn_generaux.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_btn_power : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		style = ST_PICTURE;
		x = 0.94; w = 0.054;
		y = 1.014; h = 0.035;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\btn_power.paa";
	};
	
	class R3F_ARTY_dlg_clic_carte_titre : R3F_ARTY_dlg_clic_carte_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_clic_carte_titre;
		style = ST_CENTER;
		sizeEx = 0.045;
		x = 0; y = 0;
		w = 1; h = 0.05;
		text = "";
	};
	
	class R3F_ARTY_dlg_clic_carte_btn_annuler
	{
		idc = R3F_ARTY_IDC_dlg_clic_carte_btn_annuler;
		type = CT_BUTTON;
		colorText[] = {0.75, 1, 0.55, 1};
		colorBackground[] = {0.3, 0.4, 0.3, 1};
		colorFocused[] = {0.4, 0.5, 0.4, 1};
		colorDisabled[] = {0.6, 0.6, 0.6, 0.7};
		colorBackgroundDisabled[] = {0.35, 0.35, 0.35, 0.7};
		colorBackgroundActive[] = {0.4, 0.5, 0.4, 1};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0, 0, 0, 0.5};
		colorBorder[] = {0, 0, 0, 1};
		borderSize = 0;
		soundEnter[] = {"", 0, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0, 1};
		soundEscape[] = {"", 0, 1};
		style = ST_CENTER;
		font = "BitStream";
		sizeEx = 0.033;
		x = 0.896; y = 0.004;
		w = 0.1; h = 0.042;
		text = "";
		action = "closeDialog 0;"; 
	};
	
	class R3F_ARTY_dlg_clic_carte_carte
	{
		idc = R3F_ARTY_IDC_dlg_clic_carte_carte;
		
		type = CT_MAP_MAIN;
		style = ST_PICTURE;
		
		x = 0; y = 0.05;
		w = 1; h = 0.95;
		
		colorBackground[] = {1.00, 1.00, 1.00, 0};
		colorText[] = {0.00, 0.00, 0.00, 1.00};
		colorSea[] = {0.56, 0.80, 0.98, 0.50};
		colorForest[] = {0.60, 0.80, 0.20, 0.50};
		colorRocks[] = {0.50, 0.50, 0.50, 0.50};
		colorCountlines[] = {0.65, 0.45, 0.27, 0.50};
		colorMainCountlines[] = {0.65, 0.45, 0.27, 1.00};
		colorCountlinesWater[] = {0.00, 0.53, 1.00, 0.50};
		colorMainCountlinesWater[] = {0.00, 0.53, 1.00, 1.00};
		colorForestBorder[] = {0.40, 0.80, 0.00, 1.00};
		colorRocksBorder[] = {0.50, 0.50, 0.50, 1.00};
		colorPowerLines[] = {0.00, 0.00, 0.00, 1.00};
		colorNames[] = {0.00, 0.00, 0.00, 1.00};
		colorInactive[] = {1.00, 1.00, 1.00, 0.50};
		colorLevels[] = {0.00, 0.00, 0.00, 1.00};
		colorRailWay[] = {0.00, 0.00, 0.00, 1.00};
		colorOutside[] = {0.00, 0.00, 0.00, 1.00};
		
		font = "TahomaB";
		sizeEx = 0.040000;
		
		stickX[] = {0.20, {"Gamma", 1.00, 1.50} };
		stickY[] = {0.20, {"Gamma", 1.00, 1.50} };
		ptsPerSquareSea = 6;
		ptsPerSquareTxt = 8;
		ptsPerSquareCLn = 8;
		ptsPerSquareExp = 8;
		ptsPerSquareCost = 8;
		ptsPerSquareFor = "4.0f";
		ptsPerSquareForEdge = "10.0f";
		ptsPerSquareRoad = 2;
		ptsPerSquareObj = 10;
		
		fontLabel = "Zeppelin32";
		sizeExLabel = 0.034000;
		fontGrid = "Zeppelin32";
		sizeExGrid = 0.034000;
		fontUnits = "Zeppelin32";
		sizeExUnits = 0.034000;
		fontNames = "Zeppelin32";
		sizeExNames = 0.056000;
		fontInfo = "Zeppelin32";
		sizeExInfo = 0.034000;
		fontLevel = "Zeppelin32";
		sizeExLevel = 0.034000;
		
		maxSatelliteAlpha = 0;     // Alpha to 0 by default
		alphaFadeStartScale = 1.0; 
		alphaFadeEndScale = 1.1;   // Prevent div/0
		
		showCountourInterval = 2;
		scaleDefault = 0.1;
		onMouseButtonClick = "_this execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\clic_carte.sqf"";";
		onMouseButtonDblClick = "";
		
		text = "\ca\ui\data\map_background2_co.paa";
		
		class CustomMark
		{
			icon = "\ca\ui\data\map_waypoint_ca.paa";
			color[] = {0, 0, 1, 1};
			size = 18;
			importance = 1;
			coefMin = 1;
			coefMax = 1;
		};
		
		class Legend
		{
			x = -1;
			y = -1;
			w = 0.340000;
			h = 0.152000;
			font = "Zeppelin32";
			sizeEx = 0.039210;
			colorBackground[] = {0.906000, 0.901000, 0.880000, 0.800000};
			color[] = {0, 0, 0, 1};
		};
		
		class Bunker
		{
			icon = "\ca\ui\data\map_bunker_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 14;
			importance = "1.5 * 14 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Bush
		{
			icon = "\ca\ui\data\map_bush_ca.paa";
			color[] = {0.550000, 0.640000, 0.430000, 1};
			size = 14;
			importance = "0.2 * 14 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class BusStop
		{
			icon = "\ca\ui\data\map_busstop_ca.paa";
			color[] = {0, 0, 1, 1};
			size = 10;
			importance = "1 * 10 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Command
		{
			icon = "\ca\ui\data\map_waypoint_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 18;
			importance = 1;
			coefMin = 1;
			coefMax = 1;
		};
		
		class Cross
		{
			icon = "\ca\ui\data\map_cross_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "0.7 * 16 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Fortress
		{
			icon = "\ca\ui\data\map_bunker_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "2 * 16 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Fuelstation
		{
			icon = "\ca\ui\data\map_fuelstation_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "2 * 16 * 0.05";
			coefMin = 0.750000;
			coefMax = 4;
		};
		
		class Fountain
		{
			icon = "\ca\ui\data\map_fountain_ca.paa";
			color[] = {0, 0.350000, 0.700000, 1};
			size = 12;
			importance = "1 * 12 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Hospital
		{
			icon = "\ca\ui\data\map_hospital_ca.paa";
			color[] = {0.780000, 0, 0.050000, 1};
			size = 16;
			importance = "2 * 16 * 0.05";
			coefMin = 0.500000;
			coefMax = 4;
		};
		
		class Chapel
		{
			icon = "\ca\ui\data\map_chapel_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "1 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class Church
		{
			icon = "\ca\ui\data\map_church_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class Lighthouse
		{
			icon = "\ca\ui\data\map_lighthouse_ca.paa";
			color[] = {0.780000, 0, 0.050000, 1};
			size = 20;
			importance = "3 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class Quay
		{
			icon = "\ca\ui\data\map_quay_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "2 * 16 * 0.05";
			coefMin = 0.500000;
			coefMax = 4;
		};
		
		class Rock
		{
			icon = "\ca\ui\data\map_rock_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 12;
			importance = "0.5 * 12 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Ruin
		{
			icon = "\ca\ui\data\map_ruin_ca.paa";
			color[] = {0.780000, 0, 0.050000, 1};
			size = 16;
			importance = "1.2 * 16 * 0.05";
			coefMin = 1;
			coefMax = 4;
		};
		
		class SmallTree
		{
			icon = "\ca\ui\data\map_smalltree_ca.paa";
			color[] = {0.550000, 0.640000, 0.430000, 1};
			size = 12;
			importance = "0.6 * 12 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Stack
		{
			icon = "\ca\ui\data\map_stack_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 20;
			importance = "2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class Tree
		{
			icon = "\ca\ui\data\map_tree_ca.paa";
			color[] = {0.550000, 0.640000, 0.430000, 1};
			size = 12;
			importance = "0.9 * 16 * 0.05";
			coefMin = 0.250000;
			coefMax = 4;
		};
		
		class Tourism
		{
			icon = "\ca\ui\data\map_tourism_ca.paa";
			color[] = {0.780000, 0, 0.050000, 1};
			size = 16;
			importance = "1 * 16 * 0.05";
			coefMin = 0.700000;
			coefMax = 4;
		};
		
		class Transmitter
		{
			icon = "\ca\ui\data\map_transmitter_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 20;
			importance = "2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class ViewTower
		{
			icon = "\ca\ui\data\map_viewtower_ca.paa";
			color[] = {0, 0.900000, 0, 1};
			size = 16;
			importance = "2.5 * 16 * 0.05";
			coefMin = 0.500000;
			coefMax = 4;
		};
		
		class Watertower
		{
			icon = "\ca\ui\data\map_watertower_ca.paa";
			color[] = {0, 0.350000, 0.700000, 1};
			size = 32;
			importance = "1.2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class Waypoint
		{
			icon = "\ca\ui\data\map_waypoint_ca.paa";
			size = 20;
			color[] = {0, 0.900000, 0, 1};
			importance = "1.2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class Task
		{
			icon = "\ca\ui\data\map_waypoint_ca.paa";
			iconCreated = "#(argb,8,8,3)color(1,1,1,1)";
			iconCanceled = "#(argb,8,8,3)color(0,0,1,1)";
			iconDone = "#(argb,8,8,3)color(0,0,0,1)";
			iconFailed = "#(argb,8,8,3)color(1,0,0,1)";
			colorCreated[] = {1,1,1,1};
			colorCanceled[] = {1,1,1,1};
			colorDone[] = {1,1,1,1};
			colorFailed[] = {1,1,1,1};
			size = 20;
			color[] = {0, 0.900000, 0, 1};
			importance = "1.2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class WaypointCompleted
		{
			icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
			size = 20;
			color[] = {0, 0.900000, 0, 1};
			importance = "1.2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
		
		class ActiveMarker
		{
			icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
			size = 20;
			color[] = {0, 0.900000, 0, 1};
			importance = "1.2 * 16 * 0.05";
			coefMin = 0.900000;
			coefMax = 4;
		};
	};
};