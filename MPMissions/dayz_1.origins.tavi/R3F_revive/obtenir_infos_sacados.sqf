/**
 * Obtenir le contenu d'un sac à dos sous la forme d'un tableau au format spécifique
 * 
 * @param 0 l'unité pour laquelle consulter le sac à dos
 * 
 * @return les informations du sac à dos au format suivant :
 *     si l'unité n'a pas de sac à dos : [], sinon
 *     [
 *         "nom de classe du sac à dos",
 *         [liste des armes, quantité associées à chaque arme],
 *         [liste des chargeurs, quantité associées à chaque chargeur]
 *     ]
 * 
 * Copyright (C) 2011 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_tableau_retour"];

_sacados = unitBackpack (_this select 0);

if (isNull _sacados) then
{
	_tableau_retour = [];
}
else
{
	_tableau_retour = [
		typeOf _sacados,
		getWeaponCargo _sacados,
		getMagazineCargo _sacados
	];
};

_tableau_retour