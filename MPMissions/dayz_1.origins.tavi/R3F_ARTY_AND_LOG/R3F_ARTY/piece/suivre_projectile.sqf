/**
 * Suit un projectile et met un marqueur sur la carte au lieu de l'impact
 * 
 * @param 0 le projectile à suivre
 * @param 1 l'effet (smoke, ...) du projectile
 * @param 2 les paramètres de l'effet
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_projectile", "_effet", "_param_effet", "_pos_projectile", "_marqueur"];

_projectile = _this select 0;
_effet = _this select 1;
_param_effet = _this select 2;

if (!isNull _projectile && alive _projectile) then
{
	if (_effet == "cluster") then
	{
		// Tant que le projectile n'a pas explosé
		while {alive _projectile} do
		{
			// Mise à jour de la position
			_pos_projectile = getPos _projectile;
			
			// Interruption prématurée de la boucle
			if (_effet == "cluster" && (_pos_projectile select 2) < (_param_effet select 3) && (velocity _projectile select 2) < 0) exitWith {};
			
			sleep 0.0075;
		};
		
		if (alive _projectile && (_pos_projectile select 2) > (_param_effet select 2)) then
		{
			#include "effet_sous_mun.inc.sqf"
		};
	}
	else
	{
		private ["_tempo"];
		
		_tempo = if (_effet == "submun") then {0.05} else {0.0075};
		
		// Tant que le projectile n'a pas explosé
		while {alive _projectile} do
		{
			// Mise à jour de la position
			_pos_projectile = getPos _projectile;
			
			sleep _tempo;
		};
		
		if (_effet == "smoke") then
		{
			#include "effet_fumigene.inc.sqf"
		};
		
		if (R3F_ARTY_CFG_montrer_marqueur_impact) then
		{
			// On crée un marqueur sur la dernière position du projectile
			_marqueur = createMarker [format ["impact%1%2%3", _pos_projectile select 0, _pos_projectile select 1, _pos_projectile select 2], _pos_projectile];
			_marqueur setMarkerType "Dot";
			_marqueur setMarkerColor "colorRed";
		};
	};
};