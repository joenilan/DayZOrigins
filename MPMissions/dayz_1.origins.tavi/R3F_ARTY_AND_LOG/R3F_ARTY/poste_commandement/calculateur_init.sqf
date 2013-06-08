/**
 * Initialise un calculateur d'artillerie
 * 
 * @param 0 le calculateur à initialiser
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_calculateur", "_est_demontable", "_est_transporte_par", "_est_deplace_par"];

_calculateur = _this select 0;

_est_demontable = _calculateur getVariable "R3F_ARTY_demontable";
if (isNil "_est_demontable") then
{
	_calculateur setVariable ["R3F_ARTY_demontable", true];
};

// Au cas où la logistique n'est pas activée, on définit ces variables à sa place
// Définition locale de la variable si elle n'est pas définie sur le réseau
_est_transporte_par = _calculateur getVariable "R3F_LOG_est_transporte_par";
if (isNil "_est_transporte_par") then
{
	_calculateur setVariable ["R3F_LOG_est_transporte_par", objNull, false];
};

// Au cas où la logistique n'est pas activée, on définit ces variables à sa place
// Définition locale de la variable si elle n'est pas définie sur le réseau
_est_deplace_par = _calculateur getVariable "R3F_LOG_est_deplace_par";
if (isNil "_est_deplace_par") then
{
	_calculateur setVariable ["R3F_LOG_est_deplace_par", objNull, false];
};

_calculateur addAction [("<t color=""#dddd00"">" + STR_R3F_ARTY_action_ouvrir_dlg_SM + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\ouvrir_dlg_saisie_mission.sqf", nil, 6, true, true, "", "vehicle player == player && ((isNil ""R3F_LOG_active"") || ( isNull R3F_LOG_joueur_deplace_objet && isNull (_target getVariable ""R3F_LOG_est_deplace_par"") || (!alive (_target getVariable ""R3F_LOG_est_deplace_par"")) && isNull (_target getVariable ""R3F_LOG_est_transporte_par"") )) && (_target getVariable ""R3F_ARTY_est_calculateur"")"];
_calculateur addAction [("<t color=""#dddd00"">" + STR_R3F_ARTY_action_demonter_poste + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\deplacer_calculateur.sqf", nil, 5, true, true, "", "vehicle player == player && isNull R3F_LOG_joueur_deplace_objet && (isNull (_target getVariable ""R3F_LOG_est_deplace_par"") || (!alive (_target getVariable ""R3F_LOG_est_deplace_par""))) && isNull (_target getVariable ""R3F_LOG_est_transporte_par"") && (_target getVariable ""R3F_ARTY_est_calculateur"") && ((_target getVariable ""R3F_ARTY_demontable"") && !(isNil ""R3F_LOG_active""))"];