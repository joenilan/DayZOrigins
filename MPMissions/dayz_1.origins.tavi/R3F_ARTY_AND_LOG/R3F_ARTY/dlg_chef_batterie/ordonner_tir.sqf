/**
 * Exécuté lors du clic sur un bouton "ordonner" (haut ou bas)
 * Génère une série de paramètres de tir et les envoi au joueurs sélectionnés
 * 
 * @param 0 : "tendu" ou "courbe" selon le tir à effectuer
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

disableSerialization; // A cause des displayCtrl

private ["_entrees_valides", "_type_tir", "_nb_tirs", "_index_munition", "_azimut", "_azimut2", "_elevation", "_elevation2"];
private ["_dlg_saisie_mission", "_listbox_artilleurs", "_liste_artilleurs", "_table_correspondance_index_artilleur", "_i"];

_type_tir = _this select 0;

#include "dlg_constantes.h"

_dlg_saisie_mission = findDisplay R3F_ARTY_IDD_dlg_saisie_mission;
_listbox_artilleurs = _dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_artilleurs_liste;

// Récupération des données de tir
_nb_tirs = ctrlText R3F_ARTY_IDC_dlg_SM_info_tir_valeur_nb_tirs;
_index_munition = lbCurSel R3F_ARTY_IDC_dlg_SM_info_tir_valeur_munition;

if (_type_tir == "tendu") then
{
	_azimut = ctrlText R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut;
	_azimut2 = ctrlText R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_azimut2;
	_elevation = ctrlText R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation;
	_elevation2 = ctrlText R3F_ARTY_IDC_dlg_SM_tir_tendu_valeur_elevation2;
}
else
{
	_azimut = ctrlText R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut;
	_azimut2 = ctrlText R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_azimut2;
	_elevation = ctrlText R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation;
	_elevation2 = ctrlText R3F_ARTY_IDC_dlg_SM_tir_courbe_valeur_elevation2;
};

_liste_artilleurs = lbSelection _listbox_artilleurs;
_table_correspondance_index_artilleur = uiNamespace getVariable "R3F_ARTY_dlg_SM_table_correspondance_index_artilleur";

// Vérification des entrées
_entrees_valides = true;

if (0 in _liste_artilleurs || count _liste_artilleurs == 0) then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_artilleurs; _entrees_valides = false;};

if (parseNumber _nb_tirs <= 0) then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_valeur_nb_tirs; _entrees_valides = false;};

if (_azimut == "" || _azimut2 == "" || _elevation == "" || _elevation2 == "") then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_pas_de_calcul; _entrees_valides = false;};

if (_azimut == "-" || _azimut2 == "-" || _elevation == "-" || _elevation2 == "-") then
{player globalChat STR_R3F_ARTY_dlg_SM_erreur_saisie_pas_de_calcul; _entrees_valides = false;};

if (_entrees_valides) then
{
	_nb_tirs = parseNumber _nb_tirs;
	_azimut = parseNumber _azimut;
	_azimut2 = parseNumber _azimut2;
	// Gestion du cas ou on franchit l'azimut nord
	if (_azimut > _azimut2) then
	{
		_azimut2 = _azimut2 + 360;
	};
	_elevation = parseNumber _elevation;
	_elevation2 = parseNumber _elevation2;
	
	private ["_milieu_azimut", "_milieu_elevation", "_amplitude_azimut", "_amplitude_elevation", "_table_ordres_tirs"];
	
	_milieu_azimut = (_azimut + _azimut2) /2;
	_milieu_elevation = (_elevation + _elevation2) /2;
	_amplitude_azimut = _milieu_azimut - _azimut;
	_amplitude_elevation = _milieu_elevation - _elevation;
	
	_table_ordres_tirs = [];
	// Autant de fois qu'on a de tirs à effectuer, on génère une position dans la zone et on l'affecte à un artilleur
	// Le principe de tirage d'une position dans la zone est de s'écarter du centre avec un pas fonction du nombre de tirs, et de choisir un angle aléatoire
	for [{_i = 0}, {_i < _nb_tirs}, {_i = _i + 1}] do
	{
		private ["_coordonnees_choisies", "_unite_choisi"];
		
		if (_amplitude_azimut > 0 && _amplitude_elevation > 0) then
		{
			// On tire une position dans l'ellipse
			_coordonnees_choisies = [[_milieu_azimut, _milieu_elevation], _amplitude_azimut, _amplitude_elevation] call R3F_ARTY_FNCT_tirer_position_dans_zone_elliptique;
		}
		else
		{
			_coordonnees_choisies = [_milieu_azimut - _amplitude_azimut + 2*(random _amplitude_azimut), _milieu_elevation - _amplitude_elevation + 2*(random _amplitude_elevation)];
		};
		
		_unite_choisi = _table_correspondance_index_artilleur select (_liste_artilleurs select (_i mod (count _liste_artilleurs)));
		
		_table_ordres_tirs = _table_ordres_tirs + [[
			name player,
			_unite_choisi,
			_coordonnees_choisies select 0,
			_coordonnees_choisies select 1,
			uiNamespace getVariable "R3F_ARTY_table_correspondance_index_munition" select _index_munition
		]];
	};
	
	R3F_ARTY_PUBVAR_table_ordres_tirs = + _table_ordres_tirs;
	publicVariable "R3F_ARTY_PUBVAR_table_ordres_tirs";
	["R3F_ARTY_PUBVAR_table_ordres_tirs", R3F_ARTY_PUBVAR_table_ordres_tirs] spawn R3F_ARTY_FNCT_PUBVAR_table_ordres_tirs;
	
	player globalChat STR_R3F_ARTY_dlg_SM_ordres_transmis;
};