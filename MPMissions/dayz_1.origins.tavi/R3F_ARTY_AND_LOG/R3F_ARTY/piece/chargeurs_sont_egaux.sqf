/**
 * Teste si les deux chargeurs virtuels en paramètres sont égaux
 * 
 * @param 0 le tableau représentant le premier chargeur virtuel
 * @param 1 le tableau représentant le deuxième chargeur virtuel
 * 
 * @return vrai si les deux chargeurs sont égaux
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_chargeur1", "_chargeur2"];

_chargeur1 = _this select 0;
_chargeur2 = _this select 1;

if ((_chargeur1 select 0) == (_chargeur2 select 0) &&
	(_chargeur1 select 1) == (_chargeur2 select 1) &&
	(_chargeur1 select 2) == (_chargeur2 select 2) &&
	(_chargeur1 select 3) == (_chargeur2 select 3) &&
	(_chargeur1 select 4) == (_chargeur2 select 4)) then
{
	private ["_tab_param_identiques"];
	
	_tab_param_identiques = (count (_chargeur1 select 5) == count (_chargeur2 select 5));
	
	if (_tab_param_identiques) then
	{
		private ["_i"];
		
		for [{_i = 0}, {_i < count (_chargeur1 select 5)}, {_i = _i+1}] do
		{
			if (_chargeur1 select 5 select _i != (_chargeur2 select 5 select _i)) exitWith
			{
				_tab_param_identiques = false;
			}
		};
		
		_tab_param_identiques
	}
	else
	{
		false
	};
}
else
{
	false
};