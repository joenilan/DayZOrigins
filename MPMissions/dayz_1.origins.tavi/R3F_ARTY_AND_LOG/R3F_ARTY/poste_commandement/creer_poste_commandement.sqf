/**
 * Supprime un poste de de commandement lié à un calculateur
 * A exécuter sur le serveur (via d'un publicVariable)
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
	private ["_suffixe_arrowhead", "_fnct_calc_pos_angle", "_calculateur", "_position", "_temp_pos", "_direction", "_est_calculateur"];
	private ["_filet", "_caisse_mun", "_pancarte",  "_table", "_calculateur", "_chaise", "_chaise2"];
	
	/**
	 * Calcule la position d'un objet en fonction de :
	 * 
	 * @param 0 le décalage par rapport à la position centrale (tableau de 2 éléments)
	 * @param 1 la rotation appliquée
	 * @param 2 la position centrale (tableau de 2 ou 3 éléments)
	 * 
	 * @return la position calculée (tableau de 2 éléments)
	 */
	_fnct_calc_pos_angle =
	{
		private ["_decalage", "_direction", "_position"];
		_decalage = _this select 0;
		_direction = _this select 1;
		_position = _this select 2;
		
		[
			(_position select 0) + ((_decalage select 0)*cos _direction) + ((_decalage select 1)*sin _direction),
			(_position select 1) - ((_decalage select 0)*sin _direction) + ((_decalage select 1)*cos _direction)
		]
	};
	
	_calculateur = _this select 0;
	_position = getPos _calculateur;
	_direction = getDir _calculateur;
	
	// OA est-il présent ?
	_suffixe_arrowhead = "";
	if (isClass (configFile >> "CfgVehicles" >> "Land_CamoNet_NATO_EP1")) then
	{
		_suffixe_arrowhead = "_EP1";
	};
	
	// Définition réseau de la variable lors du premier lancement du script, pour indiquer que l'objet est bien un calculateur d'artillerie
	_est_calculateur = _calculateur getVariable "R3F_ARTY_est_calculateur";
	if (isNil "_est_calculateur") then
	{
		_calculateur setVariable ["R3F_ARTY_est_calculateur", true, true];
	};
	
	_temp_pos = [[3, -1.5], _direction, _position] call _fnct_calc_pos_angle;
	_filet = format ["Land_CamoNet_NATO%1", _suffixe_arrowhead] createVehicle _temp_pos;
	_filet setVariable ["R3F_LOG_disabled", true, true];
	_filet setPos _temp_pos;
	_filet setDir (_direction+180);
	sleep 0.2;
	
	_temp_pos = [[6.75, -1], _direction, _position] call _fnct_calc_pos_angle;
	_caisse_mun = format ["USVehicleBox%1", _suffixe_arrowhead] createVehicle _temp_pos;
	_caisse_mun setVariable ["R3F_LOG_disabled", true, true];
	_caisse_mun setPos _temp_pos;
	_caisse_mun setDir (_direction+10);
	clearMagazineCargo _caisse_mun;
	sleep 0.2;
	
	_temp_pos = [[2.5, -3.5], _direction, _position] call _fnct_calc_pos_angle;
	_pancarte = format ["Notice_board%1", _suffixe_arrowhead] createVehicle _temp_pos;
	_pancarte setVariable ["R3F_LOG_disabled", true, true];
	_pancarte setPos _temp_pos;
	_pancarte setDir (_direction+165);
	sleep 0.2;
	
	_temp_pos = [[0.8, -0.8], _direction, _position] call _fnct_calc_pos_angle;
	_chaise = "FoldChair" createVehicle _temp_pos;
	_chaise setVariable ["R3F_LOG_disabled", true, true];
	_chaise setPos _temp_pos;
	_chaise setDir (_direction+140);
	sleep 0.2;
	
	_temp_pos = [[-1.2, -0.3], _direction, _position] call _fnct_calc_pos_angle;
	_chaise2 = "FoldChair" createVehicle _temp_pos;
	_chaise2 setVariable ["R3F_LOG_disabled", true, true];
	_chaise2 setPos _temp_pos;
	_chaise2 setDir (_direction-100);
	sleep 0.2;
	
	_table = "SmallTable" createVehicle _position;
	_table setVariable ["R3F_LOG_disabled", true, true];
	_table setPos _position;
	_table setDir _direction;
	sleep 0.2;
	
	_calculateur setPos [_position select 0, _position select 1, (_position select 2) + 1.1];
	
	// On mémorise quels sont les objets du poste de commandement du calculateur
	_calculateur setVariable ["R3F_ARTY_poste_commandement_objets_crees", [_filet, _caisse_mun, _pancarte, _table, _chaise, _chaise2]];
	_calculateur setVariable ["R3F_LOG_disabled", true, true];
};