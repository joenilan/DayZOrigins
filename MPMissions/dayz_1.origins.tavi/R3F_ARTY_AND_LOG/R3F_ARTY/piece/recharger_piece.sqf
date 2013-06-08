/**
 * Recharge une pièce d'artillerie avec le type de chargeur donné en paramètre
 * 
 * @param 3 select 0 la pièce à recharger
 * @param 3 select 1 l'index du chargeur à utiliser pour recharger
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_piece", "_chargeur"];

_piece = _this select 3 select 0;
_chargeur = _this select 3 select 1;

if (count nearestObjects [_piece, ["SatPhone"], 100] > 0) then
{
	_piece removeMagazines (magazines _piece select 0);
	_piece addMagazine (_chargeur select 0);
	_piece setVariable ["R3F_ARTY_chargeur_courant", _chargeur, true];
	
	// On raffraichit la boîte de dialogue de l'artilleur
	if !(isNil "R3F_ARTY_dlg_artilleur_ouverte") then
	{
		[] spawn R3F_ARTY_FNCT_afficher_ordre;
	};
	
	// On raffraichit la boîte de dialogue du chargeur courant
	if !(isNull (uiNamespace getVariable "R3F_ARTY_dlg_chargeur")) then
	{
		["change_chargeur"] spawn R3F_ARTY_FNCT_afficher_chargeur;
	};
}
else
{
	player globalChat STR_R3F_ARTY_recharger_trop_loin_poste_commandement;
};