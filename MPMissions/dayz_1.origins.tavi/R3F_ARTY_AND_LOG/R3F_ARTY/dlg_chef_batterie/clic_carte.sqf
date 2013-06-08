/**
 * Récupère les coordonnées du clic et préremplie les champs correspondant à la position de la batterie ou de la cible
 * 
 * @param les infos du clic effectué sur la carte
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

disableSerialization; // A cause des displayCtrl

// Si c'est un clic gauche
if (_this select 1 == 0) then
{
	private ["_pos_2D", "_altitude", "_vehicule", "_pos_GPS", "_longitude", "_latitude"];
	
	// Récupération de la position 2D
	_pos_2D = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
	
	// Récupération de l'altitude
	_vehicule = "Logic" createVehicleLocal _pos_2D;
	sleep 0.2;
	_altitude = round (getPosASL _vehicule select 2);
	deleteVehicle _vehicule;
	
	_pos_GPS = [_pos_2D] call R3F_ARTY_FNCT_formater_pos2D_vers_posGPS;
	_longitude = _pos_GPS select 0;
	_latitude = _pos_GPS select 1;
	
	#include "dlg_constantes.h"
	
	// Si l'appel a été fait pour la position de la cible
	if (uiNamespace getVariable "R3F_ARTY_dlg_saisie_mission_preremplir" == "cible") then
	{
		private ["_dlg_saisie_mission"];
		
		_dlg_saisie_mission = findDisplay R3F_ARTY_IDD_dlg_saisie_mission;
		// Mise à jour des champs de texte
		_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_valeur_long ctrlSetText _longitude;
		_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_valeur_lat ctrlSetText _latitude;
		_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_cible_valeur_alt ctrlSetText (str _altitude);
	}
	// Si l'appel a été fait pour la position de la batterie
	else
	{
		private ["_dlg_saisie_mission"];
		
		_dlg_saisie_mission = findDisplay R3F_ARTY_IDD_dlg_saisie_mission;
		// Mise à jour des champs de texte
		_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_long ctrlSetText _longitude;
		_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_lat ctrlSetText _latitude;
		_dlg_saisie_mission displayCtrl R3F_ARTY_IDC_dlg_SM_position_batterie_valeur_alt ctrlSetText (str _altitude);
	};
	
	closeDialog 0;
};