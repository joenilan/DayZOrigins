/**
 * Récupère le chargeur virtuel chargé dans une pièce
 * 
 * @param 0 la pièce d'artillerie dont on souhaite récupérer le chargeur virtuel
 * 
 * @return le tableau représentant le chargeur virtuel
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_piece", "_chargeur_actuel"];

_piece = _this select 0;

_chargeur_actuel = _piece getVariable "R3F_ARTY_chargeur_courant";
if (isNil "_chargeur_actuel") then
{
	private ["_chargeur"];
	_chargeur = magazines _piece select 0;
	
	_chargeur_actuel = [
		_chargeur,
		getText (configFile >> "CfgMagazines" >> _chargeur >> "displayName"),
		getNumber (configFile >> "CfgMagazines" >> _chargeur >> "initSpeed"),
		-(getNumber (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> _chargeur >> "ammo")) >> "airFriction")),
		"normal",
		[]
	];
	
	// Remplacer les chargeurs interdits par un chargeur virtuel
	if (_chargeur in R3F_ARTY_CFG_chargeurs_interdits) then
	{
		private ["_idx_type_piece", "_i"];
		
		_idx_type_piece = -1;
		for [{_i = 0}, {_i < count R3F_ARTY_CFG_pieces_artillerie}, {_i = _i+1}] do
		{
			if (_idx_type_piece == -1) then
			{
				if (_piece isKindOf (R3F_ARTY_CFG_pieces_artillerie select _i)) then
				{
					_idx_type_piece = _i;
				};
			};
		};
		
		if (_idx_type_piece != -1 && count (uiNamespace getVariable "R3F_ARTY_chargeurs_compatibles_par_piece" select _idx_type_piece) > 0) then
		{
			_chargeur_actuel = + (uiNamespace getVariable "R3F_ARTY_chargeurs_compatibles_par_piece" select _idx_type_piece select 0);
		};
	};
};

_chargeur_actuel