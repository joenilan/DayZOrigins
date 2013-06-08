/**
 * Affiche les infos sur le chargeur actuel de la pièce d'artillerie
 * 
 * @param 0 chaîne spécifiant l'évènement ("recharge", "change_chargeur" ou "defaut")
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

disableSerialization; // A cause des displayCtrl

private ["_evenement", "_piece", "_dlg_chargeur", "_chargeur_actuel"];

_evenement = _this select 0;
_piece = vehicle player;

// Récupération des control des champs de texte
#include "dlg_constantes.h"
_dlg_chargeur = uiNamespace getVariable "R3F_ARTY_dlg_chargeur";

(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_label_chargeur) ctrlSetText STR_R3F_ARTY_dlg_chargeur_label_chargeur;
(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_label_nb_mun) ctrlSetText STR_R3F_ARTY_dlg_chargeur_label_nb_mun;

// Mise à jour de la couleur de la munition à tirer
_chargeur_actuel = [_piece] call R3F_ARTY_FNCT_get_chargeur_actuel;

(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_chargeur) ctrlSetText (_chargeur_actuel select 1);
(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun) ctrlSetText format ["%1", _piece ammo (weapons _piece select 0)];

if !(isNil "R3F_ARTY_fil_execution_chargeur_dispo") then {terminate R3F_ARTY_fil_execution_chargeur_dispo;};

if (_evenement == "change_chargeur") then
{
	(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun) ctrlSetTextColor [0.6, 0.05, 0.05, 1];
	
	R3F_ARTY_fil_execution_chargeur_dispo = [_dlg_chargeur, (getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "magazineReloadTime")) +
		1.3*(getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "reloadTime"))] spawn
	{
		disableSerialization;
		sleep (_this select 1);
		
		if (_this select 0 == uiNamespace getVariable "R3F_ARTY_dlg_chargeur") then
		{
			(_this select 0 displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun) ctrlSetTextColor [0.55, 0.80, 0.45, 1];
		};
	};
}
else
{
	if (_evenement == "recharge") then
	{
		(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun) ctrlSetTextColor [0.6, 0.05, 0.05, 1];
		
		R3F_ARTY_fil_execution_chargeur_dispo = [_dlg_chargeur, 1.3*(getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "reloadTime"))] spawn
		{
			disableSerialization;
			sleep (_this select 1);
			
			if (_this select 0 == uiNamespace getVariable "R3F_ARTY_dlg_chargeur") then
			{
				(_this select 0 displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun) ctrlSetTextColor [0.55, 0.80, 0.45, 1];
			};
		};
	}
	else
	{
		(_dlg_chargeur displayCtrl R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun) ctrlSetTextColor [0.55, 0.80, 0.45, 1];
	};
};