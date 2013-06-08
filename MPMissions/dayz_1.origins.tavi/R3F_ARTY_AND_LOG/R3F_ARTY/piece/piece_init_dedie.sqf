/**
 * Lancer par la routine d'auto-détection des objets pour initialiser la pièce d'artillerie
 * Version allégée pour un serveur dédié uniquement
 * 
 * @param 0 la pièce d'artillerie
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_piece"];

_piece = _this select 0;

// Remplacer les chargeurs interdits par un chargeur virtuel
if (magazines _piece select 0 in R3F_ARTY_CFG_chargeurs_interdits) then
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
		R3F_ARTY_PUBVAR_changer_chargeur = [_piece, + (uiNamespace getVariable "R3F_ARTY_chargeurs_compatibles_par_piece" select _idx_type_piece select 0)];
		publicVariable "R3F_ARTY_PUBVAR_changer_chargeur";
		["R3F_ARTY_PUBVAR_changer_chargeur", R3F_ARTY_PUBVAR_changer_chargeur] spawn R3F_ARTY_FNCT_PUBVAR_changer_chargeur;
	};
};

_piece addEventHandler ["Fired", R3F_ARTY_FNCT_EH_fired_piece];