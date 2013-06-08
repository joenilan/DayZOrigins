/**
 * Prérempli le formulaire de saisie de mission
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

disableSerialization; // A cause des displayCtrl

private ["_dlg_saisie_mission", "_combo_munition", "_listbox_artilleurs", "_table_correspondance_index_artilleur"];

#include "dlg_constantes.h"

_dlg_saisie_mission = findDisplay R3F_ARTY_IDD_dlg_saisie_mission;

/**** DEBUT des traductions des labels ****/
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_position_batterie_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_label_long) ctrlSetText STR_R3F_ARTY_dlg_SM_position_label_long;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_label_lat) ctrlSetText STR_R3F_ARTY_dlg_SM_position_label_lat;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_label_alt) ctrlSetText STR_R3F_ARTY_dlg_SM_position_label_alt;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_btn_pos_joueur) ctrlSetText STR_R3F_ARTY_dlg_SM_position_btn_pos_joueur;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_btn_clic_carte) ctrlSetText STR_R3F_ARTY_dlg_SM_position_btn_clic_carte;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_position_cible_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_label_long) ctrlSetText STR_R3F_ARTY_dlg_SM_position_label_long;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_label_lat) ctrlSetText STR_R3F_ARTY_dlg_SM_position_label_lat;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_label_alt) ctrlSetText STR_R3F_ARTY_dlg_SM_position_label_alt;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_btn_clic_carte) ctrlSetText STR_R3F_ARTY_dlg_SM_position_btn_clic_carte;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_correction_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_label_add_drop) ctrlSetText STR_R3F_ARTY_dlg_SM_correction_label_add_drop;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_label_left_right) ctrlSetText STR_R3F_ARTY_dlg_SM_correction_label_left_right;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_label_dir_cible) ctrlSetText STR_R3F_ARTY_dlg_SM_correction_label_dir_cible;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_aide_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_aide_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_aide_contenu) ctrlSetStructuredText (parseText STR_R3F_ARTY_dlg_SM_aide_contenu);
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_info_tir_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_label_munition) ctrlSetText STR_R3F_ARTY_dlg_SM_info_tir_munition;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_label_nb_tirs) ctrlSetText STR_R3F_ARTY_dlg_SM_info_tir_nb_tirs;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_label_dispersion) ctrlSetText STR_R3F_ARTY_dlg_SM_info_tir_dispersion;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_btn_calculer) ctrlSetText STR_R3F_ARTY_dlg_SM_btn_calculer;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_param_tir_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_label_distance) ctrlSetText STR_R3F_ARTY_dlg_SM_param_tir_label_distance;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_label_azimut) ctrlSetText STR_R3F_ARTY_dlg_SM_param_tir_label_azimut;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_label_altitude) ctrlSetText STR_R3F_ARTY_dlg_SM_param_tir_label_altitude;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_courbe_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_label_elevation) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_courbe_label_elevation;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_label_azimut) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_courbe_label_azimut;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_label_temps_vol) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_courbe_label_temps_vol;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_tendu_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_label_elevation) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_tendu_label_elevation;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_label_azimut) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_tendu_label_azimut;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_label_temps_vol) ctrlSetText STR_R3F_ARTY_dlg_SM_tir_tendu_label_temps_vol;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_artilleurs_titre) ctrlSetText STR_R3F_ARTY_dlg_SM_artilleurs_titre;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_btn_ordonner_tir_courbe) ctrlSetText STR_R3F_ARTY_dlg_SM_btn_ordonner_tir_courbe;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_btn_ordonner_tir_tendu) ctrlSetText STR_R3F_ARTY_dlg_SM_btn_ordonner_tir_tendu;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_credits) ctrlSetText STR_R3F_ARTY_LOG_nom_produit;
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_btn_fermer) ctrlSetText STR_R3F_ARTY_dlg_SM_btn_fermer;
/**** FIN des traductions des labels ****/

_combo_munition = _dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_valeur_munition;
_listbox_artilleurs = _dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_artilleurs_liste;

{_combo_munition lbAdd _x;} forEach (uiNamespace getVariable "R3F_ARTY_table_correspondance_index_nom_munition");

_listbox_artilleurs lbAdd STR_R3F_ARTY_dlg_SM_artilleurs_touche_ctrl;
_table_correspondance_index_artilleur = [objNull];

// On insère chaque joueur dans la liste - cas des IA à bord de pièces d'artillerie
{
	if ((!isPlayer _x) && (alive _x) && (side _x == side player) && (vehicle _x != _x) && (gunner vehicle _x == _x)) then
	{
		private ["_ia"];
		_ia = _x;
		
		if ({vehicle _ia isKindOf _x} count R3F_ARTY_CFG_pieces_artillerie > 0) then
		{
			private ["_nom_piece", "_pos_GPS", "_nom_affichage"];
			
			_nom_piece = getText (configFile >> "CfgVehicles" >> (typeOf vehicle _ia) >> "displayName");
			_pos_GPS = [getPos vehicle _ia] call R3F_ARTY_FNCT_formater_pos2D_vers_posGPS;
			_nom_affichage = _nom_piece + " | " + (_pos_GPS select 0) + " " + (_pos_GPS select 1) + " | " + (name _ia);
			
			_listbox_artilleurs lbAdd _nom_affichage;
			_table_correspondance_index_artilleur = _table_correspondance_index_artilleur + [_ia];
			
			// Pré-sélection si sélectionné la dernière fois
			if (_x in (uiNamespace getVariable "R3F_ARTY_mem_artilleurs_liste")) then
			{
				_listbox_artilleurs lbSetSelected [((lbSize _listbox_artilleurs) - 1), true];
			};
		};
	};
} forEach allUnits;

// On insère chaque joueur dans la liste - cas des joueurs
{
	if ((isPlayer _x) && (alive _x) && (side _x == side player)) then
	{
		private ["_nom_affichage"];
		
		_nom_affichage = name _x;
		
		_listbox_artilleurs lbAdd _nom_affichage;
		_table_correspondance_index_artilleur = _table_correspondance_index_artilleur + [_x];
		
		// Pré-sélection si sélectionné la dernière fois
		if (_x in (uiNamespace getVariable "R3F_ARTY_mem_artilleurs_liste")) then
		{
			_listbox_artilleurs lbSetSelected [((lbSize _listbox_artilleurs) - 1), true];
		};
	};
} forEach  (switchableUnits + playableUnits);

// On mémorise la correspondance car on n'a accès qu'à l'index sélectionné lors de la validation
uiNamespace setVariable ["R3F_ARTY_dlg_SM_table_correspondance_index_artilleur", + _table_correspondance_index_artilleur];

// On rentre les valeurs dans tout les champs
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_long) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_position_batterie_valeur_long");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_lat) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_position_batterie_valeur_lat");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_alt) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_position_batterie_valeur_alt");

(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_valeur_long) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_position_cible_valeur_long");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_valeur_lat) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_position_cible_valeur_lat");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_valeur_alt) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_position_cible_valeur_alt");

(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_valeur_add_drop) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_correction_valeur_add_drop");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_valeur_left_right) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_correction_valeur_left_right");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_correction_valeur_dir_cible) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_correction_valeur_dir_cible");

if (uiNamespace getVariable "R3F_ARTY_mem_info_tir_valeur_munition" > 0) then
{(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_valeur_munition) lbSetCurSel (uiNamespace getVariable "R3F_ARTY_mem_info_tir_valeur_munition");};
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_valeur_nb_tirs) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_info_tir_valeur_nb_tirs");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_info_tir_valeur_dispersion) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_info_tir_valeur_dispersion");

(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_valeur_distance) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_param_tir_valeur_distance");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_valeur_azimut) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_param_tir_valeur_azimut");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_param_tir_valeur_altitude) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_param_tir_valeur_altitude");

(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_courbe_valeur_elevation");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation2) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_courbe_valeur_elevation2");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_courbe_valeur_azimut");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut2) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_courbe_valeur_azimut2");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_temps_vol) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_courbe_valeur_temps_vol");

(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_tendu_valeur_elevation");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation2) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_tendu_valeur_elevation2");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_tendu_valeur_azimut");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut2) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_tendu_valeur_azimut2");
(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_temps_vol) ctrlSetText (uiNamespace getVariable "R3F_ARTY_mem_tir_tendu_valeur_temps_vol");

// Selon la configuration on grise les boutons "Pos joueur" et "Clic carte"
if (!R3F_ARTY_CFG_autoriser_pos_joueur) then
{
	(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_btn_pos_joueur) ctrlEnable false;
};

if (!R3F_ARTY_CFG_autoriser_clic_carte) then
{
	(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_btn_clic_carte) ctrlEnable false;
	(_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_btn_clic_carte) ctrlEnable false;
};