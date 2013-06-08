/*
 * Formate une position GPS de type 0123 4567 depuis une position 2D (ou 3D)
 * @param 0 la position 2D ou 3D sous forme de tableau
 * @return tableau de chaînes [longitude, latitude] de la position GPS au format 0123 4567
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
private ["_pos_2D", "_x_grille", "_y_grille", "_longitude", "_latitude"];

_pos_2D = _this select 0;

// Conversion de la pos 2D en coordonnées GPS à 4 chiffres
_x_grille = round ((_pos_2D select 0) / 10);
if (R3F_ARTY_CFG_hauteur_ile == -1) then
{
	_y_grille = round ((_pos_2D select 1) / 10);
}
else
{
	_y_grille = round ((R3F_ARTY_CFG_hauteur_ile - (_pos_2D select 1)) / 10);
};

if (_x_grille < 0 || _y_grille < 0) then
{
	player globalChat STR_R3F_ARTY_dlg_clic_carte_erreur_hors_champ;
}
else
{
	// Passage en notation à 4 chiffres, avec zéros devant
	_longitude = str _x_grille;
	while {count toArray _longitude < 4} do {_longitude = "0" + _longitude;};
	_latitude = str _y_grille;
	while {count toArray _latitude < 4} do {_latitude = "0" + _latitude;};
	
	// Retour
	[_longitude, _latitude]
};