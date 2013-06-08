/**
 * Purge la liste des ordres en attente
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// On efface
R3F_ARTY_ordres_recus = [];

// On averti
player globalChat STR_R3F_ARTY_action_purger_ordres_fait;

// On raffraichit la boîte de dialogue de l'artilleur
if !(isNil "R3F_ARTY_dlg_artilleur_ouverte") then
{
	[] spawn R3F_ARTY_FNCT_afficher_ordre;
};