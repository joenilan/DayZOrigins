/**
 * Supprime un poste de commandement lié à un calculateur
 * A exécuter sur le serveur (via un publicVariable)
 * 
 * @param 0 le calculateur du poste de commandement d'artillerie
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (isServer) then
{
	private ["_calculateur", "_objets_crees", "_i"];
	
	_calculateur = _this select 0;
	_objets_crees = _calculateur getVariable "R3F_ARTY_poste_commandement_objets_crees";
	
	for [{_i = 0}, {_i < count _objets_crees}, {_i = _i + 1}] do
	{
		deleteVehicle (_objets_crees select _i);
		sleep 0.2;
	};
	
	_calculateur setVariable ["R3F_ARTY_poste_commandement_objets_crees", []];
	_calculateur setVariable ["R3F_LOG_disabled", false, true];
};