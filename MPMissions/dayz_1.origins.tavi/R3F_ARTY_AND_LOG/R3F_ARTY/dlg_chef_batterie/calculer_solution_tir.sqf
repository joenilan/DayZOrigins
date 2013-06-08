/**
 * Executé lors du clic sur le bouton "Calculer". Contrôle la saisie et lance la calcul de la solution de tir
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_entrees_valides", "_long_batterie", "_lat_batterie", "_alt_batterie", "_long_cible", "_lat_cible", "_alt_cible"];
private ["_correction_add_drop", "_correction_left_right", "_correction_dir_cible", "_index_munition", "_table_correspondance_index_munition", "_dispersion", "_nb_tirs"];

#include "dlg_constantes.h"

// Récupération des entrées
_long_batterie = ctrlText R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_long;
_lat_batterie = ctrlText R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_lat;
_alt_batterie = ctrlText R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_alt;

_long_cible = ctrlText R3F_ARTY_IDC_dlg_SM_position_cible_valeur_long;
_lat_cible = ctrlText R3F_ARTY_IDC_dlg_SM_position_cible_valeur_lat;
_alt_cible = ctrlText R3F_ARTY_IDC_dlg_SM_position_cible_valeur_alt;

_correction_add_drop = ctrlText R3F_ARTY_IDC_dlg_SM_correction_valeur_add_drop;
_correction_left_right = ctrlText R3F_ARTY_IDC_dlg_SM_correction_valeur_left_right;
_correction_dir_cible = ctrlText R3F_ARTY_IDC_dlg_SM_correction_valeur_dir_cible;

_index_munition = lbCurSel R3F_ARTY_IDC_dlg_SM_info_tir_valeur_munition;
_table_correspondance_index_munition = uiNamespace getVariable "R3F_ARTY_table_correspondance_index_munition";

_dispersion = ctrlText R3F_ARTY_IDC_dlg_SM_info_tir_valeur_dispersion;
_nb_tirs = ctrlText R3F_ARTY_IDC_dlg_SM_info_tir_valeur_nb_tirs;

// Vérification des entrées
_entrees_valides = true;

if (_long_batterie == "" || _lat_batterie == "" || _alt_batterie == "") then
{player globalChat STR_R3F_ARTY_dlg_SM_saisie_manquante_batterie; _entrees_valides = false;};

if (parseNumber _long_batterie < 0 || parseNumber _lat_batterie < 0 || parseNumber _alt_batterie < 0) then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_batterie; _entrees_valides = false;};

if (_long_cible == "" || _lat_cible == "" || _alt_cible == "") then
{player globalChat STR_R3F_ARTY_dlg_SM_saisie_manquante_cible; _entrees_valides = false;};

if (parseNumber _long_cible < 0 || parseNumber _lat_cible < 0 || parseNumber _alt_cible < 0) then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_cible; _entrees_valides = false;};

if (_index_munition < 0 || _index_munition >= (count _table_correspondance_index_munition)) then
{
	player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_munition; _entrees_valides = false;
}
else
{
	if (_table_correspondance_index_munition select _index_munition select 0 == "") then
	{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_munition; _entrees_valides = false;};
};

if (parseNumber _dispersion < 0) then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_valeur_dispersion; _entrees_valides = false;};

if (parseNumber _nb_tirs <= 0) then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_valeur_nb_tirs; _entrees_valides = false;};

// Calcul de la solution de tir
if (_entrees_valides) then
{
	startLoadingScreen [STR_R3F_ARTY_calcul_en_cours];
	
	_long_batterie = parseNumber _long_batterie;
	_lat_batterie = parseNumber _lat_batterie;
	_alt_batterie = parseNumber _alt_batterie;
	
	_long_cible = parseNumber _long_cible;
	_lat_cible = parseNumber _lat_cible;
	_alt_cible = parseNumber _alt_cible;
	
	_correction_add_drop = parseNumber _correction_add_drop;
	_correction_left_right = -(parseNumber _correction_left_right);
	_correction_dir_cible = parseNumber _correction_dir_cible;
	
	_dispersion = parseNumber _dispersion;
	
	private ["_pos_canon", "_pos_cible", "_azimut", "_distance", "_vitesse_initiale", "_coef_frottement"];
	
	// Conversion des coordonnées long-lat en position [X, Y, Z] du jeu
	if (R3F_ARTY_CFG_hauteur_ile == -1) then
	{
		_pos_canon = [_long_batterie*10, _lat_batterie*10, 0];
		_pos_cible = [_long_cible*10, _lat_cible*10, 0];
	}
	else
	{
		_pos_canon = [_long_batterie*10, (R3F_ARTY_CFG_hauteur_ile - (_lat_batterie*10)), 0];
		_pos_cible = [_long_cible*10, (R3F_ARTY_CFG_hauteur_ile - (_lat_cible*10)), 0];
	};
		
	// On applique les corrections
	_pos_cible set [0, ((_pos_cible select 0) + (_correction_left_right*cos _correction_dir_cible) + (_correction_add_drop*sin _correction_dir_cible))];
	_pos_cible set [1, ((_pos_cible select 1) - (_correction_left_right*sin _correction_dir_cible) + (_correction_add_drop*cos _correction_dir_cible))];
	
	// Calcul de l'azimut
	_azimut = ((_pos_cible select 0) - (_pos_canon select 0)) atan2 ((_pos_cible select 1) - (_pos_canon select 1));
	if (_azimut < 0) then {_azimut = _azimut + 360;};
	// Calcul de la distance
	_distance = _pos_cible distance _pos_canon;
	
	// Récupération des propriétés balistique de la munition
	_vitesse_initiale = _table_correspondance_index_munition select _index_munition select 2;
	_coef_frottement = _table_correspondance_index_munition select _index_munition select 3;
	
	private ["_tir_courbe_possible", "_tir_courbe_valeur_azimut", "_tir_courbe_valeur_azimut2", "_tir_courbe_valeur_elevation", "_tir_courbe_valeur_elevation2", "_tir_courbe_valeur_temps_vol"];
	private ["_tir_tendu_possible", "_tir_tendu_valeur_azimut", "_tir_tendu_valeur_azimut2", "_tir_tendu_valeur_elevation", "_tir_tendu_valeur_elevation2", "_tir_tendu_valeur_temps_vol"];
	
	// Si la dispersion souhaitée est inférieure à 10m, on ne fera qu'un seul calcul, car la précision des munitions est déjà de cet ordre là
	if (_dispersion <= 10) then
	{
		private ["_solution_tir"];
		
		// Calcul de la solution de tir
		_solution_tir = [_distance, (_alt_cible - _alt_batterie), _vitesse_initiale, _coef_frottement, R3F_ARTY_CFG_precision] call R3F_ARTY_FNCT_calculer_elevation;
		
		_tir_tendu_possible = _solution_tir select 0;
		_tir_tendu_valeur_azimut = _azimut;
		_tir_tendu_valeur_azimut2 = _azimut;
		_tir_tendu_valeur_elevation = _solution_tir select 1;
		_tir_tendu_valeur_elevation2 = _solution_tir select 1;
		_tir_tendu_valeur_temps_vol = _solution_tir select 2;
		
		_tir_courbe_possible = _solution_tir select 3;
		_tir_courbe_valeur_azimut = _azimut;
		_tir_courbe_valeur_azimut2 = _azimut;
		_tir_courbe_valeur_elevation = _solution_tir select 4;
		_tir_courbe_valeur_elevation2 = _solution_tir select 4;
		_tir_courbe_valeur_temps_vol = _solution_tir select 5;
	}
	// Si une dispersion volontaire est souhaitée
	else
	{
		private ["_solution_tir_proche", "_solution_tir_loin", "_azimut_inf", "_azimut_sup"];
		
		// On va faire deux calculs d'élévation : en haut et en bas de la zone de dispersion
		_solution_tir_proche = [_distance - (_dispersion/2), (_alt_cible - _alt_batterie), _vitesse_initiale, _coef_frottement, _dispersion/6] call R3F_ARTY_FNCT_calculer_elevation;
		_solution_tir_loin = [_distance + (_dispersion/2), (_alt_cible - _alt_batterie), _vitesse_initiale, _coef_frottement, _dispersion/6] call R3F_ARTY_FNCT_calculer_elevation;
		
		// Calcul de l'azimut inf
		_azimut_inf = _azimut - atan (_dispersion/2/_distance);
		if (_azimut_inf < 0) then {_azimut_inf = _azimut_inf + 360;};
		
		// Calcul de l'azimut sup
		_azimut_sup = _azimut + atan (_dispersion/2/_distance);
		if (_azimut_sup < 0) then {_azimut_sup = _azimut_sup + 360;};
		
		_tir_tendu_possible = (_solution_tir_proche select 0) && (_solution_tir_loin select 0);
		_tir_tendu_valeur_azimut = _azimut_inf;
		_tir_tendu_valeur_azimut2 = _azimut_sup;
		_tir_tendu_valeur_elevation = _solution_tir_proche select 1;
		_tir_tendu_valeur_elevation2 = _solution_tir_loin select 1;
		_tir_tendu_valeur_temps_vol = ((_solution_tir_proche select 2) + (_solution_tir_loin select 2)) / 2;
		
		_tir_courbe_possible = (_solution_tir_proche select 3) && (_solution_tir_loin select 3);
		_tir_courbe_valeur_azimut = _azimut_inf;
		_tir_courbe_valeur_azimut2 = _azimut_sup;
		_tir_courbe_valeur_elevation = _solution_tir_loin select 4;
		_tir_courbe_valeur_elevation2 = _solution_tir_proche select 4;
		_tir_courbe_valeur_temps_vol = ((_solution_tir_proche select 5) + (_solution_tir_loin select 5)) / 2;
	};
	
	endLoadingScreen;
	
	ctrlSetText [R3F_ARTY_IDC_dlg_SM_param_tir_valeur_distance, ((str round _distance) + "m")];
	ctrlSetText [R3F_ARTY_IDC_dlg_SM_param_tir_valeur_azimut, [_azimut] call R3F_ARTY_FNCT_formater_deux_decimales];
	ctrlSetText [R3F_ARTY_IDC_dlg_SM_param_tir_valeur_altitude, ((str round (_alt_cible - _alt_batterie)) + "m")];
	
	if (_tir_courbe_possible) then
	{
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut, [_tir_courbe_valeur_azimut] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut2, [_tir_courbe_valeur_azimut2] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation, [_tir_courbe_valeur_elevation] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation2, [_tir_courbe_valeur_elevation2] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_temps_vol, ((str round _tir_courbe_valeur_temps_vol) + "s")];
	}
	else
	{
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut2, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation2, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_temps_vol, "-"];
	};
	
	
	if (_tir_tendu_possible) then
	{
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut, [_tir_tendu_valeur_azimut] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut2, [_tir_tendu_valeur_azimut2] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation, [_tir_tendu_valeur_elevation] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation2, [_tir_tendu_valeur_elevation2] call R3F_ARTY_FNCT_formater_deux_decimales];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_temps_vol, ((str round _tir_tendu_valeur_temps_vol) + "s")];
	}
	else
	{
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut2, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation2, "-"];
		ctrlSetText [R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_temps_vol, "-"];
	};
	
	// Avertissement quand aucune solution trouvée (sinon on croit qu'il ne se passe rien ou que ça plante)
	if !(_tir_courbe_possible || _tir_tendu_possible) then
	{
		player globalChat STR_R3F_ARTY_aucune_solution_trouvee;
	};
};