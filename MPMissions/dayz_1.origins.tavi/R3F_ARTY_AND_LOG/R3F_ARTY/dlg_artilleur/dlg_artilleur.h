/**
 * Interface d'affichage de l'orientation de la pièce d'artillerie, des ordres de tir et de l'astuce
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

class R3F_ARTY_dlg_artilleur
{
	idd = R3F_ARTY_IDD_dlg_artilleur;
	name = "R3F_ARTY_dlg_artilleur";
	onLoad = "uiNamespace setVariable [""R3F_ARTY_dlg_artilleur"", _this select 0]; [] spawn R3F_ARTY_FNCT_afficher_ordre;";
	duration = 100000;
	fadein = 0;
	fadeout = 0;
	movingEnable = false;
	
	controlsBackground[] = {
		R3F_ARTY_dlg_artilleur_arriere_plan_gps,
		R3F_ARTY_dlg_artilleur_arriere_plan_fond_gps,
		R3F_ARTY_dlg_artilleur_barre_separation,
		R3F_ARTY_dlg_artilleur_astuce_bordure
	};
	objects[] = {};
	controls[] =
	{
		R3F_ARTY_dlg_artilleur_label_ordre_titre,
		R3F_ARTY_dlg_artilleur_label_ordre_azimut,
		R3F_ARTY_dlg_artilleur_valeur_ordre_azimut,
		R3F_ARTY_dlg_artilleur_label_ordre_elevation,
		R3F_ARTY_dlg_artilleur_valeur_ordre_elevation,
		R3F_ARTY_dlg_artilleur_label_ordre_munition,
		R3F_ARTY_dlg_artilleur_valeur_ordre_munition,
		R3F_ARTY_dlg_artilleur_label_ordre_emetteur,
		R3F_ARTY_dlg_artilleur_valeur_ordre_emetteur,
		R3F_ARTY_dlg_artilleur_label_info_purger,
		
		R3F_ARTY_dlg_artilleur_label_piece_titre,
		R3F_ARTY_dlg_artilleur_label_azimut,
		R3F_ARTY_dlg_artilleur_valeur_azimut,
		R3F_ARTY_dlg_artilleur_label_elevation,
		R3F_ARTY_dlg_artilleur_valeur_elevation,
		
		R3F_ARTY_dlg_artilleur_astuce_texte,
		R3F_ARTY_dlg_artilleur_credits
	};
	
	class R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = -1;
		type = CT_STATIC;
		style = ST_LEFT;
		colorText[] = {0.15, 0.16, 0.12, 1};
		colorBackground[] = {0.40, 0.43, 0.28, 1};
		font = "BitStream";
		sizeEx = 0.028;
		h = 0.028;
		text = "";
	};
	
	// Arrière plan
	class R3F_ARTY_dlg_artilleur_arriere_plan_gps : R3F_ARTY_dlg_artilleur_texte_basique
	{
		style = ST_PICTURE;
		x = 0.25; w = 0.5;
		y = 0.2; h = 0.5;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "\ca\ui\data\ui_gps_ca.paa";
	};
	
	class R3F_ARTY_dlg_artilleur_arriere_plan_fond_gps : R3F_ARTY_dlg_artilleur_texte_basique
	{
		x = 0.313; w = 0.374;
		y = 0.292; h = 0.2715;
		text = "";
	};
	// FIN Arrière plan
	
	// Info ordre de tir
	class R3F_ARTY_dlg_artilleur_label_ordre_titre : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_ordre_titre;
		x = 0.315; y = 0.30;
		w = 0.17; h = 0.04;
		sizeEx = 0.03;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_ordre_azimut : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_ordre_azimut;
		style = ST_RIGHT;
		x = 0.32; y = 0.34;
		w = 0.10; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_valeur_ordre_azimut : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_azimut;
		style = ST_RIGHT;
		x = 0.42; y = 0.34;
		w = 0.07; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_ordre_elevation : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_ordre_elevation;
		style = ST_RIGHT;
		x = 0.32; y = 0.38;
		w = 0.10; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_valeur_ordre_elevation : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_elevation;
		style = ST_RIGHT;
		x = 0.42; y = 0.38;
		w = 0.07; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_ordre_munition : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_ordre_munition;
		style = ST_RIGHT;
		x = 0.32; y = 0.42;
		w = 0.10; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_valeur_ordre_munition : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_munition;
		x = 0.42; y = 0.42;
		w = 0.21; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_ordre_emetteur : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_ordre_emetteur;
		style = ST_RIGHT;
		x = 0.32; y = 0.46;
		w = 0.10; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_valeur_ordre_emetteur : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_emetteur;
		x = 0.42; y = 0.46;
		w = 0.21; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_info_purger : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_info_purger;
		x = 0.315; y = 0.53;
		w = 0.36; h = 0.02;
		sizeEx = 0.02;
		text = "";
	};
	// FIN Info ordre de tir
	
	class R3F_ARTY_dlg_artilleur_barre_separation : R3F_ARTY_dlg_artilleur_texte_basique
	{
		x = 0.499; w = 0.002;
		y = 0.35; h = 0.06;
		colorBackground[] = {0.18, 0.20, 0.14, 1};
		text = "";
	};
	
	// Info pièce d'artillerie
	class R3F_ARTY_dlg_artilleur_label_piece_titre : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_piece_titre;
		x = 0.505; y = 0.30;
		w = 0.17; h = 0.04;
		sizeEx = 0.03;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_azimut : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_azimut;
		style = ST_RIGHT;
		x = 0.51; y = 0.34;
		w = 0.10; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_valeur_azimut : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_valeur_azimut;
		style = ST_RIGHT;
		x = 0.61; y = 0.34;
		w = 0.07; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_label_elevation : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_label_elevation;
		style = ST_RIGHT;
		x = 0.51; y = 0.38;
		w = 0.10; h = 0.04;
		text = "";
	};
	
	class R3F_ARTY_dlg_artilleur_valeur_elevation : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_valeur_elevation;
		style = ST_RIGHT;
		x = 0.61; y = 0.38;
		w = 0.07; h = 0.04;
		text = "";
	};
	// FIN Info pièce d'artillerie
	
	// DEBUT boîte astuce et crédits
	class R3F_ARTY_dlg_artilleur_astuce_bordure : R3F_ARTY_dlg_artilleur_texte_basique
	{
		style = ST_PICTURE;
		x = (safeZoneW + safeZoneX)-0.420; y = (safeZoneH + safeZoneY)-0.225;
		w = 0.6; h = 0.4;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "\ca\ui\data\ui_background_video_ca.paa";
	};
	
	class R3F_ARTY_dlg_artilleur_astuce_texte : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_astuce_texte;
		type = CT_STRUCTURED_TEXT;
		size = 0.03;
		x = (safeZoneW + safeZoneX)-0.406; y = (safeZoneH + safeZoneY)-0.176;
		w = 0.4; h = 0.17;
		colorBackground[] = {0.25, 0.35, 0.22, 0.0};
		text = "";
		class Attributes
		{
			font = "BitStream";
			color = "#aaee88";
			align = "left";
			valign = "top";
			shadow = false;
			shadowColor = "#000000";
			size = "1";
		};
	};
	
	class R3F_ARTY_dlg_artilleur_credits : R3F_ARTY_dlg_artilleur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_artilleur_credits;
		style = ST_RIGHT;
		x = (safeZoneW + safeZoneX)-0.198; y = (safeZoneH + safeZoneY)-0.027;
		w = 0.20; h = 0.02;
		sizeEx = 0.02;
		colorBackground[] = {0,0,0,0};
		colorText[] = {0.75, 1, 0.55, 0.5};
		text = "";
	};
	// FIN boîte astuce et crédits
};