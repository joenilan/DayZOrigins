/**
 * Affiche l'ordre de tir actuel dans la boîte de dialogue de l'artilleur
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

disableSerialization; // A cause des displayCtrl

private ["_dlg_artilleur", "_nb_ordres"];

// Récupération des control des champs de texte
#include "dlg_constantes.h"

_dlg_artilleur = uiNamespace getVariable "R3F_ARTY_dlg_artilleur";

/**** DEBUT des traductions des labels ****/
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_titre) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_ordre_titre;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_azimut) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_azimut;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_elevation) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_elevation;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_munition) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_munition;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_emetteur) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_emetteur;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_info_purger) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_info_purger_aucun_ordre;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_piece_titre) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_piece_titre;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_azimut) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_azimut;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_elevation) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_elevation;
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_astuce_texte) ctrlSetStructuredText (parseText STR_R3F_ARTY_dlg_artilleur_astuce_texte);
(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_credits) ctrlSetText STR_R3F_ARTY_LOG_nom_produit;
/**** FIN des traductions des labels ****/

_nb_ordres = {count _x > 0} count R3F_ARTY_ordres_recus;

if (_nb_ordres == 0) then
{
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_titre) ctrlSetText (format [STR_R3F_ARTY_dlg_artilleur_label_ordre_titre, 0]);
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_azimut) ctrlSetText "-      ";
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_elevation) ctrlSetText "-      ";
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_munition) ctrlSetText "-";
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_emetteur) ctrlSetText "-";
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_info_purger) ctrlSetText STR_R3F_ARTY_dlg_artilleur_label_info_purger_aucun_ordre;
	
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_munition) ctrlSetTextColor [0.15, 0.16, 0.12, 1];
}
else
{
	private ["_index_premier_ordre", "_ordre", "_texte", "_chargeur_actuel"];
	
	// Recherche du premier ordre non accompli
	_index_premier_ordre = 0;
	while {count (R3F_ARTY_ordres_recus select _index_premier_ordre) == 0} do
	{
		_index_premier_ordre = _index_premier_ordre + 1
	};
	
	_ordre = R3F_ARTY_ordres_recus select _index_premier_ordre;
	
	// Correction azimut négative
	if (_ordre select 2 >= 360) then
	{
		_ordre set [2, ((_ordre select 2) - 360)];
	};
	
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_ordre_titre) ctrlSetText (format [STR_R3F_ARTY_dlg_artilleur_label_ordre_titre, _nb_ordres]);
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_azimut) ctrlSetText ([_ordre select 2] call R3F_ARTY_FNCT_formater_deux_decimales);
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_elevation) ctrlSetText ([_ordre select 3] call R3F_ARTY_FNCT_formater_deux_decimales);
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_munition) ctrlSetText (_ordre select 4 select 1);
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_emetteur) ctrlSetText (_ordre select 0);
	(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_label_info_purger) ctrlSetText (format [STR_R3F_ARTY_dlg_artilleur_label_info_purger, _nb_ordres]);
	
	// Mise à jour de la couleur de la munition à tirer
	_chargeur_actuel = [vehicle player] call R3F_ARTY_FNCT_get_chargeur_actuel;
	
	if !([_chargeur_actuel, _ordre select 4] call R3F_ARTY_FNCT_chargeurs_sont_egaux) then
	{
		(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_munition) ctrlSetTextColor [0.6, 0.05, 0.05, 1];
	}
	else
	{
		(_dlg_artilleur displayCtrl R3F_ARTY_IDC_dlg_artilleur_valeur_ordre_munition) ctrlSetTextColor [0.15, 0.16, 0.12, 1];
	};
};