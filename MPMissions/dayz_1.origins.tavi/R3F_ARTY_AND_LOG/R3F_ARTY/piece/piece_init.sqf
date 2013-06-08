/**
 * Lancer par la routine d'auto-détection des objets pour initialiser la pièce d'artillerie
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

if (isServer) then
{
	private ["_chargeur_actuel"];
	
	_chargeur_actuel = _piece getVariable "R3F_ARTY_chargeur_courant";
	if (isNil "_chargeur_actuel") then
	{
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
	};
};

// Quand le joueur monte dans la pièce, on lance l'affichage des paramètres de la pièce
_piece addEventHandler ["GetIn",
{
	if (_this select 2 == player) then
	{
		_this spawn
		{
			sleep 0.2;
			
			execVM "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\afficher_dlg_artilleur.sqf";
		};
	};
}];

_piece addEventHandler ["Fired", R3F_ARTY_FNCT_EH_fired_piece];

// Si le joueur est déjà dedans au moment de l'intialisation
if (vehicle player == _piece) then
{
	execVM "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\afficher_dlg_artilleur.sqf";
};

// Ajout des actions de menu de gestion des ordres, valide seulement quand on est à bord
//_piece addAction [("<t color=""#22ee22"">" + STR_R3F_ARTY_action_ordre_suivant + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\ordre_suivant.sqf", nil, 6, false, true, "", "gunner _target == player"];
_piece addAction [("<t color=""#22ee22"">" + STR_R3F_ARTY_action_ouvrir_dlg_artilleur + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\afficher_dlg_artilleur.sqf", nil, 6, false, true, "", "gunner _target == player && (isNil ""R3F_ARTY_dlg_artilleur_ouverte"")"];
_piece addAction [("<t color=""#22ee22"">" + STR_R3F_ARTY_action_fermer_dlg_artilleur + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\fermer_dlg_artilleur.sqf", nil, 0, false, true, "", "gunner _target == player && (!isNil ""R3F_ARTY_dlg_artilleur_ouverte"")"];
_piece addAction [("<t color=""#22ee22"">" + STR_R3F_ARTY_action_purger_ordres+ "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\purger_ordres.sqf", nil, 6, false, true, "", "gunner _target == player"];

// On ajoute une action de rechargement pour chaque type de munition compatible
{
	_piece addAction [("<t color=""#aa0000"">" + STR_R3F_ARTY_action_recharger_piece + (_x select 1) + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\piece\recharger_piece.sqf", [_piece, _x], 0, false, true, "", "gunner _target == player"];
} forEach ([typeOf _piece] call R3F_ARTY_FNCT_get_chargeurs_compatibles_piece);