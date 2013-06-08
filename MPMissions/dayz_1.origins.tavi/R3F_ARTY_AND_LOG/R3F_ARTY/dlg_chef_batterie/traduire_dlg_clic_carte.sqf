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

private ["_dlg_clic_carte"];

#include "dlg_constantes.h"

_dlg_clic_carte = findDisplay R3F_ARTY_IDD_dlg_clic_carte;

/**** DEBUT des traductions des labels ****/
(_dlg_clic_carte displayCtrl R3F_ARTY_IDC_dlg_clic_carte_titre) ctrlSetText STR_R3F_ARTY_dlg_clic_carte_titre;
(_dlg_clic_carte displayCtrl R3F_ARTY_IDC_dlg_clic_carte_btn_annuler) ctrlSetText STR_R3F_ARTY_dlg_clic_carte_btn_annuler;
/**** FIN des traductions des labels ****/