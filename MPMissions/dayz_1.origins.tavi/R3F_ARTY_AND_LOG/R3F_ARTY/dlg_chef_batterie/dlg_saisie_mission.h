/**
 * Interface d'affichage de l'orientation de la pièce d'artillerie
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "dlg_constantes.h"

class R3F_ARTY_dlg_saisie_mission
{
	idd = R3F_ARTY_IDD_dlg_saisie_mission;
	name = "R3F_ARTY_dlg_saisie_mission";
	onLoad = "execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\preremplir_dlg_saisie_mission.sqf"";";
	onUnload = "call compile preprocessFile ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\memoriser_dlg_saisie_mission.sqf"";";
	movingEnable = false;
	
	controlsBackground[] =
	{
		R3F_ARTY_dlg_SM_bord_haut,
		R3F_ARTY_dlg_SM_bord_gauche,
		R3F_ARTY_dlg_SM_bord_droit,
		R3F_ARTY_dlg_SM_bord_bas,
		
		R3F_ARTY_dlg_SM_coin_haut_gauche,
		R3F_ARTY_dlg_SM_coin_haut_droit,
		R3F_ARTY_dlg_SM_coin_bas_gauche,
		R3F_ARTY_dlg_SM_coin_bas_droit,
		
		R3F_ARTY_dlg_SM_btn_fonctions,
		R3F_ARTY_dlg_SM_btn_generaux,
		R3F_ARTY_dlg_SM_btn_power,
		
		R3F_ARTY_dlg_SM_arriere_plan,
		R3F_ARTY_dlg_SM_separation
	};
	objects[] = {};
	controls[] =
	{
		R3F_ARTY_dlg_SM_position_batterie_titre,
		R3F_ARTY_dlg_SM_position_batterie_label_long,
		R3F_ARTY_dlg_SM_position_batterie_valeur_long,
		R3F_ARTY_dlg_SM_position_batterie_label_lat,
		R3F_ARTY_dlg_SM_position_batterie_valeur_lat,
		R3F_ARTY_dlg_SM_position_batterie_label_alt,
		R3F_ARTY_dlg_SM_position_batterie_valeur_alt,
		R3F_ARTY_dlg_SM_position_batterie_btn_pos_joueur,
		R3F_ARTY_dlg_SM_position_batterie_btn_clic_carte,
		
		R3F_ARTY_dlg_SM_position_cible_titre,
		R3F_ARTY_dlg_SM_position_cible_label_long,
		R3F_ARTY_dlg_SM_position_cible_valeur_long,
		R3F_ARTY_dlg_SM_position_cible_label_lat,
		R3F_ARTY_dlg_SM_position_cible_valeur_lat,
		R3F_ARTY_dlg_SM_position_cible_label_alt,
		R3F_ARTY_dlg_SM_position_cible_valeur_alt,
		R3F_ARTY_dlg_SM_position_cible_btn_clic_carte,
		
		R3F_ARTY_dlg_SM_correction_titre,
		R3F_ARTY_dlg_SM_correction_label_add_drop,
		R3F_ARTY_dlg_SM_correction_valeur_add_drop,
		R3F_ARTY_dlg_SM_correction_unites_add_drop,
		R3F_ARTY_dlg_SM_correction_label_left_right,
		R3F_ARTY_dlg_SM_correction_valeur_left_right,
		R3F_ARTY_dlg_SM_correction_unites_left_right,
		R3F_ARTY_dlg_SM_correction_label_dir_cible,
		R3F_ARTY_dlg_SM_correction_valeur_dir_cible,
		
		R3F_ARTY_dlg_SM_aide_titre,
		R3F_ARTY_dlg_SM_aide_contenu,
		
		R3F_ARTY_dlg_SM_info_tir_titre,
		R3F_ARTY_dlg_SM_info_tir_label_munition,
		R3F_ARTY_dlg_SM_info_tir_valeur_munition,
		R3F_ARTY_dlg_SM_info_tir_label_nb_tirs,
		R3F_ARTY_dlg_SM_info_tir_valeur_nb_tirs,
		R3F_ARTY_dlg_SM_info_tir_label_dispersion,
		R3F_ARTY_dlg_SM_info_tir_valeur_dispersion,
		R3F_ARTY_dlg_SM_info_tir_unites_dispersion,
		
		R3F_ARTY_dlg_SM_btn_calculer,
		
		R3F_ARTY_dlg_SM_param_tir_titre,
		R3F_ARTY_dlg_SM_param_tir_label_distance,
		R3F_ARTY_dlg_SM_param_tir_valeur_distance,
		R3F_ARTY_dlg_SM_param_tir_label_azimut,
		R3F_ARTY_dlg_SM_param_tir_valeur_azimut,
		R3F_ARTY_dlg_SM_param_tir_label_altitude,
		R3F_ARTY_dlg_SM_param_tir_valeur_altitude,
		
		R3F_ARTY_dlg_SM_tir_courbe_titre,
		R3F_ARTY_dlg_SM_tir_courbe_label_elevation,
		R3F_ARTY_dlg_SM_tir_courbe_valeur_elevation,
		R3F_ARTY_dlg_SM_tir_courbe_tiret_elevation,
		R3F_ARTY_dlg_SM_tir_courbe_valeur_elevation2,
		R3F_ARTY_dlg_SM_tir_courbe_label_azimut,
		R3F_ARTY_dlg_SM_tir_courbe_valeur_azimut,
		R3F_ARTY_dlg_SM_tir_courbe_tiret_azimut,
		R3F_ARTY_dlg_SM_tir_courbe_valeur_azimut2,
		R3F_ARTY_dlg_SM_tir_courbe_label_temps_vol,
		R3F_ARTY_dlg_SM_tir_courbe_valeur_temps_vol,
		
		R3F_ARTY_dlg_SM_tir_tendu_titre,
		R3F_ARTY_dlg_SM_tir_tendu_label_elevation,
		R3F_ARTY_dlg_SM_tir_tendu_valeur_elevation,
		R3F_ARTY_dlg_SM_tir_tendu_tiret_elevation,
		R3F_ARTY_dlg_SM_tir_tendu_valeur_elevation2,
		R3F_ARTY_dlg_SM_tir_tendu_label_azimut,
		R3F_ARTY_dlg_SM_tir_tendu_valeur_azimut,
		R3F_ARTY_dlg_SM_tir_tendu_tiret_azimut,
		R3F_ARTY_dlg_SM_tir_tendu_valeur_azimut2,
		R3F_ARTY_dlg_SM_tir_tendu_label_temps_vol,
		R3F_ARTY_dlg_SM_tir_tendu_valeur_temps_vol,
		
		R3F_ARTY_dlg_SM_artilleurs_titre,
		R3F_ARTY_dlg_SM_artilleurs_liste,
		
		R3F_ARTY_dlg_SM_btn_ordonner_tir_courbe,
		R3F_ARTY_dlg_SM_btn_ordonner_tir_tendu,
		
		R3F_ARTY_dlg_SM_credits,
		R3F_ARTY_dlg_SM_btn_fermer
	};
	
	
	// Définition des classes de base
	class R3F_ARTY_dlg_SM_texte_basique
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
	
	class R3F_ARTY_dlg_SM_resultat_basique : R3F_ARTY_dlg_SM_texte_basique
	{
		colorText[] = {0.78, 1, 0.58, 1};
		colorBackground[] = {0.23, 0.31, 0.20, 1};
	};
	
	class R3F_ARTY_dlg_SM_edit_basique : R3F_ARTY_dlg_SM_texte_basique
	{
		type = CT_EDIT;
		autocomplete = false;
		colorSelection[] = {0.70, 0.99, 0.65, 0.25}; 
	};
	
	class R3F_ARTY_dlg_SM_titre_basique : R3F_ARTY_dlg_SM_texte_basique
	{
		sizeEx = 0.035;
		h = 0.035;
	};
	
	class R3F_ARTY_dlg_SM_bouton_basique : R3F_ARTY_dlg_SM_texte_basique
	{
		type = CT_BUTTON;
		style = ST_CENTER;
		colorBackground[] = {0.3, 0.4, 0.3, 1};
		colorFocused[] = {0.4, 0.5, 0.4, 1};
		colorDisabled[] = {0.6, 0.6, 0.6, 0.7};
		colorBackgroundDisabled[] = {0.35, 0.35, 0.35, 0.7};
		colorBackgroundActive[] = {0.4, 0.5, 0.4, 1};
		offsetX = 0.0034;
		offsetY = 0.0034;
		offsetPressedX = 0.0022;
		offsetPressedY = 0.0022;
		colorShadow[] = {0, 0, 0, 0.5};
		colorBorder[] = {0, 0, 0, 1};
		borderSize = 0;
		soundEnter[] = {"", 0, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0, 1};
		soundEscape[] = {"", 0, 1};
	};
	
	class R3F_ARTY_dlg_SM_combo_basique : R3F_ARTY_dlg_SM_texte_basique
	{
		type = CT_COMBO;
		rowHeight = 0.028;
		wholeHeight = 20 * 0.028;
		color[] = {1,1,1,1};
		colorSelect[] = {0.70, 0.99, 0.65, 1};
		colorBackground[] = {0.28, 0.36, 0.26, 1};
		colorSelectBackground[] = {0.36, 0.46, 0.36, 1};
		soundSelect[] = {"", 0.0, 1};
		soundExpand[] = {"", 0.0, 1};
		soundCollapse[] = {"", 0.0, 1};
		arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
		maxHistoryDelay = 1;
		class ScrollBar
		{
			color[] = {1, 1, 1, 0.6};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 0.3};
			thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
			arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
			arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
			border = "\ca\ui\data\ui_border_scroll_ca.paa";
		};
	};
	// FIN Définition des classes de base
	
	
	class R3F_ARTY_dlg_SM_arriere_plan : R3F_ARTY_dlg_SM_texte_basique
	{
		x = 0; y = 0;
		w = 1; h = 1;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_bord_haut : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = -0.015; w = 1.03;
		y = -0.07; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_haut.paa";
	};
	
	class R3F_ARTY_dlg_SM_bord_gauche : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = -0.0525; w = 0.0525;
		y = -0.015; h = 1.03;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_gauche.paa";
	};
	
	class R3F_ARTY_dlg_SM_bord_droit : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = 1; w = 0.0525;
		y = -0.015; h = 1.03;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_droit.paa";
	};
	
	class R3F_ARTY_dlg_SM_bord_bas : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = -0.015; w = 1.03;
		y = 1; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\bord_bas.paa";
	};
	
	class R3F_ARTY_dlg_SM_coin_haut_gauche : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = -0.0525; w = 0.0525;
		y = -0.07; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_haut_gauche.paa";
	};
	
	class R3F_ARTY_dlg_SM_coin_haut_droit : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = 1; w = 0.0525;
		y = -0.07; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_haut_droit.paa";
	};
	
	class R3F_ARTY_dlg_SM_coin_bas_gauche : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = -0.0525; w = 0.0525;
		y = 1; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_bas_gauche.paa";
	};
	
	class R3F_ARTY_dlg_SM_coin_bas_droit : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = 1; w = 0.0525;
		y = 1; h = 0.07;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\coin_bas_droit.paa";
	};
	
	class R3F_ARTY_dlg_SM_btn_fonctions : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = 0.006; w = 0.215;
		y = 1.014; h = 0.035;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\btn_fonctions.paa";
	};
	
	class R3F_ARTY_dlg_SM_btn_generaux : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = 0.70; w = 0.215;
		y = 1.014; h = 0.035;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\btn_generaux.paa";
	};
	
	class R3F_ARTY_dlg_SM_btn_power : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_PICTURE;
		x = 0.94; w = 0.054;
		y = 1.014; h = 0.035;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "R3F_ARTY_AND_LOG\R3F_ARTY\images\btn_power.paa";
	};
	
	// Colone 1 : position batterie
	class R3F_ARTY_dlg_SM_position_batterie_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_titre;
		x = 0; y = 0;
		w = 0.25;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_label_long : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_label_long;
		style = ST_RIGHT;
		x = 0; y = 0.04;
		w = 0.11;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_valeur_long : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_long;
		x = 0.11; y = 0.04;
		w = 0.08;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_label_lat : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_label_lat;
		style = ST_RIGHT;
		x = 0; y = 0.08;
		w = 0.11;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_valeur_lat : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_lat;
		x = 0.11; y = 0.08;
		w = 0.08;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_label_alt : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_label_alt;
		style = ST_RIGHT;
		x = 0; y = 0.12;
		w = 0.11;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_valeur_alt : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_alt;
		x = 0.11; y = 0.12;
		w = 0.08;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_btn_pos_joueur : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_btn_pos_joueur;
		x = 0.005; y = 0.16;
		w = 0.1;
		text = "";
		action = "if (R3F_ARTY_CFG_autoriser_pos_joueur) then {execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\pos_joueur.sqf"";} else {player globalChat STR_R3F_ARTY_fonction_interdite;};"; 
	};
	
	class R3F_ARTY_dlg_SM_position_batterie_btn_clic_carte : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_batterie_btn_clic_carte;
		x = 0.110; y = 0.16;
		w = 0.1;
		text = "";
		action = "uiNamespace setVariable [""R3F_ARTY_dlg_saisie_mission_preremplir"", ""batterie""]; createDialog ""R3F_ARTY_dlg_clic_carte"";"; 
	};
	// FIN Colone 1 : position batterie
	
	
	// Colone 2 : position cible
	class R3F_ARTY_dlg_SM_position_cible_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_titre;
		x = 0.24; y = 0;
		w = 0.25;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_label_long : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_label_long;
		style = ST_RIGHT;
		x = 0.24; y = 0.04;
		w = 0.11;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_valeur_long : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_valeur_long;
		x = 0.35; y = 0.04;
		w = 0.08;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_label_lat : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_label_lat;
		style = ST_RIGHT;
		x = 0.24; y = 0.08;
		w = 0.11;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_valeur_lat : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_valeur_lat;
		x = 0.35; y = 0.08;
		w = 0.08;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_label_alt : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_label_alt;
		style = ST_RIGHT;
		x = 0.24; y = 0.12;
		w = 0.11;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_valeur_alt : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_valeur_alt;
		x = 0.35; y = 0.12;
		w = 0.08;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_position_cible_btn_clic_carte : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_position_cible_btn_clic_carte;
		x = 0.285; y = 0.16;
		w = 0.1;
		text = "";
		action = "uiNamespace setVariable [""R3F_ARTY_dlg_saisie_mission_preremplir"", ""cible""]; createDialog ""R3F_ARTY_dlg_clic_carte"";"; 
	};
	// FIN Colone 2 : position cible
	
	
	// Colone 3 : correction
	class R3F_ARTY_dlg_SM_correction_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_titre;
		x = 0.47; y = 0;
		w = 0.25;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_correction_label_add_drop : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_label_add_drop;
		style = ST_RIGHT;
		x = 0.44; y = 0.04;
		w = 0.18;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_correction_valeur_add_drop : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_valeur_add_drop;
		x = 0.62; y = 0.04;
		w = 0.055;
		text = "0";
	};
	
	class R3F_ARTY_dlg_SM_correction_unites_add_drop : R3F_ARTY_dlg_SM_texte_basique
	{
		x = 0.675; y = 0.04;
		w = 0.05;
		text = "m";
	};
	
	class R3F_ARTY_dlg_SM_correction_label_left_right : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_label_left_right;
		style = ST_RIGHT;
		x = 0.44; y = 0.08;
		w = 0.18;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_correction_valeur_left_right : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_valeur_left_right;
		x = 0.62; y = 0.08;
		w = 0.055;
		text = "0";
	};
	
	class R3F_ARTY_dlg_SM_correction_unites_left_right : R3F_ARTY_dlg_SM_texte_basique
	{
		x = 0.675; y = 0.08;
		w = 0.05;
		text = "m";
	};
	
	class R3F_ARTY_dlg_SM_correction_label_dir_cible : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_label_dir_cible;
		style = ST_RIGHT;
		x = 0.44; y = 0.12;
		w = 0.18;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_correction_valeur_dir_cible : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_correction_valeur_dir_cible;
		x = 0.62; y = 0.12;
		w = 0.055;
		text = "0";
	};
	// FIN Colone 3 : correction
	
	
	// Colone 4 : aide
	class R3F_ARTY_dlg_SM_aide_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_aide_titre;
		x = 0.71; y = 0;
		w = 0.29;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_aide_contenu : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_aide_contenu;
		type = CT_STRUCTURED_TEXT;
		size = 0.023;
		x = 0.71; y = 0.04;
		w = 0.29;  h = 0.88;
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
	// FIN Colone 4 : aide
	
	
	// Ligne 2 : informations de tir
	class R3F_ARTY_dlg_SM_info_tir_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_titre;
		x = 0; y = 0.22;
		w = 0.25;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_info_tir_label_munition : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_label_munition;
		style = ST_RIGHT;
		x = 0; y = 0.26;
		w = 0.13;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_info_tir_valeur_munition : R3F_ARTY_dlg_SM_combo_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_valeur_munition;
		x = 0.13; y = 0.26;
		w = 0.25;
	};
	
	class R3F_ARTY_dlg_SM_info_tir_label_nb_tirs : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_label_nb_tirs;
		style = ST_RIGHT;
		x = 0; y = 0.3;
		w = 0.13;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_info_tir_valeur_nb_tirs : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_valeur_nb_tirs;
		x = 0.13; y = 0.3;
		w = 0.05;
		text = "1";
	};
	
	class R3F_ARTY_dlg_SM_info_tir_label_dispersion : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_label_dispersion;
		style = ST_RIGHT;
		x = 0; y = 0.34;
		w = 0.13;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_info_tir_valeur_dispersion : R3F_ARTY_dlg_SM_edit_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_info_tir_valeur_dispersion;
		x = 0.13; y = 0.34;
		w = 0.05;
		text = "0";
	};
	
	class R3F_ARTY_dlg_SM_info_tir_unites_dispersion : R3F_ARTY_dlg_SM_texte_basique
	{
		x = 0.181; y = 0.34;
		w = 0.05;
		text = "m";
	};
	// FIN Ligne 2 : informations de tir
	
	
	class R3F_ARTY_dlg_SM_btn_calculer : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_btn_calculer;
		x = 0.4; y = 0.25;
		w = 0.2; h = 0.1;
		sizeEx = 0.035;
		text = "";
		action = "execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\calculer_solution_tir.sqf"";"; 
	};
	
	// Ligne de séparation
	class R3F_ARTY_dlg_SM_separation : R3F_ARTY_dlg_SM_texte_basique
	{
		x = 0.005; y = 0.385;
		w = 0.71; h = 0.003;
		colorBackground[] = {0.65, 0.89, 0.52, 1};
		text = "";
	};
	
	
	/*********************************/
	
	// Colonne 1 : paramètres de tir
	class R3F_ARTY_dlg_SM_param_tir_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_titre;
		x = 0; y = 0.4;
		w = 0.17;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_param_tir_label_distance : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_label_distance;
		style = ST_RIGHT;
		x = 0; y = 0.44;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_param_tir_valeur_distance : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_valeur_distance;
		x = 0.10; y = 0.44;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_param_tir_label_azimut : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_label_azimut;
		style = ST_RIGHT;
		x = 0; y = 0.48;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_param_tir_valeur_azimut : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_valeur_azimut;
		x = 0.10; y = 0.48;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_param_tir_label_altitude : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_label_altitude;
		style = ST_RIGHT;
		x = 0; y = 0.52;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_param_tir_valeur_altitude : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_param_tir_valeur_altitude;
		x = 0.10; y = 0.52;
		w = 0.07;
		text = "";
	};
	// FIN Colonne 1 : paramètres de tir
	
	
	// Colonne 2 : solution courbée
	class R3F_ARTY_dlg_SM_tir_courbe_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_titre;
		style = ST_CENTER;
		x = 0.195; y = 0.4;
		w = 0.245;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_label_elevation : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_label_elevation;
		style = ST_RIGHT;
		x = 0.185; y = 0.44;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_valeur_elevation : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation;
		x = 0.285; y = 0.44;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_tiret_elevation : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_CENTER;
		x = 0.355; y = 0.44;
		w = 0.015;
		text = "-";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_valeur_elevation2 : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation2;
		x = 0.37; y = 0.44;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_label_azimut : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_label_azimut;
		style = ST_RIGHT;
		x = 0.185; y = 0.48;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_valeur_azimut : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut;
		x = 0.285; y = 0.48;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_tiret_azimut : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_CENTER;
		x = 0.355; y = 0.48;
		w = 0.015;
		text = "-";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_valeur_azimut2 : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut2;
		x = 0.37; y = 0.48;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_label_temps_vol : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_label_temps_vol;
		style = ST_RIGHT;
		x = 0.185; y = 0.52;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_courbe_valeur_temps_vol : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_temps_vol;
		x = 0.285; y = 0.52;
		w = 0.07;
		text = "";
	};
	// FIN Colonne 2 : solution courbée
	
	
	// Colonne 3 : solution tendue
	class R3F_ARTY_dlg_SM_tir_tendu_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_titre;
		style = ST_CENTER;
		x = 0.465; y = 0.4;
		w = 0.245;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_label_elevation : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_label_elevation;
		style = ST_RIGHT;
		x = 0.455; y = 0.44;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_valeur_elevation : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation;
		x = 0.555; y = 0.44;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_tiret_elevation : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_CENTER;
		x = 0.625; y = 0.44;
		w = 0.015;
		text = "-";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_valeur_elevation2 : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation2;
		x = 0.640; y = 0.44;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_label_azimut : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_label_azimut;
		style = ST_RIGHT;
		x = 0.455; y = 0.48;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_valeur_azimut : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut;
		x = 0.555; y = 0.48;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_tiret_azimut : R3F_ARTY_dlg_SM_texte_basique
	{
		style = ST_CENTER;
		x = 0.625; y = 0.48;
		w = 0.015;
		text = "-";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_valeur_azimut2 : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut2;
		x = 0.640; y = 0.48;
		w = 0.07;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_label_temps_vol : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_label_temps_vol;
		style = ST_RIGHT;
		x = 0.455; y = 0.52;
		w = 0.10;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_tir_tendu_valeur_temps_vol : R3F_ARTY_dlg_SM_resultat_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_temps_vol;
		x = 0.555; y = 0.52;
		w = 0.07;
		text = "";
	};
	// FIN Colonne 3 : solution tendue
	
	
	// Zone liste des joueurs
	class R3F_ARTY_dlg_SM_artilleurs_titre : R3F_ARTY_dlg_SM_titre_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_artilleurs_titre;
		style = ST_CENTER;
		x = 0.005; y = 0.57;
		w = 0.25;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_artilleurs_liste : R3F_ARTY_dlg_SM_combo_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_artilleurs_liste;
		type = CT_LISTBOX;
		style = LB_MULTI;
		sizeEx = 0.022;
		rowHeight = 0.022;
		x = 0.005; y = 0.61;
		w = 0.27; h = 0.37;
		autoScrollRewind = 0;
		autoScrollDelay = 0;
		autoScrollSpeed = 0;
	};
	// FIN Zone liste des joueurs
	
	
	class R3F_ARTY_dlg_SM_btn_ordonner_tir_courbe : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_btn_ordonner_tir_courbe;
		x = 0.285; y = 0.57;
		w = 0.155; h = 0.07;
		sizeEx = 0.035;
		text = "";
		action = "[""courbe""] execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\ordonner_tir.sqf"";"; 
	};
	
	class R3F_ARTY_dlg_SM_btn_ordonner_tir_tendu : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_btn_ordonner_tir_tendu;
		x = 0.555; y = 0.57;
		w = 0.155; h = 0.07;
		sizeEx = 0.035;
		text = "";
		action = "[""tendu""] execVM ""R3F_ARTY_AND_LOG\R3F_ARTY\dlg_chef_batterie\ordonner_tir.sqf"";"; 
	};
	
	class R3F_ARTY_dlg_SM_credits : R3F_ARTY_dlg_SM_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_credits;
		style = ST_RIGHT;
		x = 0.68; y = 0.96;
		w = 0.20; h = 0.02;
		sizeEx = 0.02;
		text = "";
	};
	
	class R3F_ARTY_dlg_SM_btn_fermer : R3F_ARTY_dlg_SM_bouton_basique
	{
		idc = R3F_ARTY_IDC_dlg_SM_btn_fermer;
		x = 0.88; y = 0.93;
		w = 0.1; h = 0.05;
		sizeEx = 0.035;
		text = "";
		action = "closeDialog 0;"; 
	};
};