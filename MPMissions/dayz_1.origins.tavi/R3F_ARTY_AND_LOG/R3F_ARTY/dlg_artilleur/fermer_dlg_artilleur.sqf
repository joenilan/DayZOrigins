/**
 * Ouvre la boîte de dialogue de l'artilleur et affiche en continu l'orientation du canon (azimut et élévation)
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

disableSerialization;

private ["_ref_dlg_artilleur"];

_ref_dlg_artilleur = uiNamespace getVariable "R3F_ARTY_dlg_artilleur";
uiNamespace setVariable ["R3F_ARTY_dlg_artilleur", displayNull];
_ref_dlg_artilleur closeDisplay 0;
R3F_ARTY_dlg_artilleur_ouverte = nil;