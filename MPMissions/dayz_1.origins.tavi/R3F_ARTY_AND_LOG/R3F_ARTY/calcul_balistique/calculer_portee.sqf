/**
 * Calcule la portée du projectile pour l'angle de tir et l'altitude d'impact relative au canon donnés
 * 
 * @param 0 angle d'élévation du canon pour le tir
 * @param 1 différence d'altitude en mètres du sol pour impact
 * @param 2 vitesse initiale du projectile en m/s
 * @param 3 coefficient de frottement dans l'air du projectile
 * @param 4 pas de temps en secondes pour la simulation balistique
 * 
 * @return tableau au format [portée en mètres du tir avant de tomber à l'altitude donnée, temps de vol en secondes], [0, 0] si impact pendant l'ascension
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
private ["_elevation", "_altitude_impact", "_vitesse_initiale", "_coef_frottement", "_deltat"];
private ["_gravite", "_pos_x", "_pos_y", "_vitesse", "_vitesse_x", "_vitesse_y", "_temps_vol", "_altitude_apogee"];

// Paramètres d'entrées
_elevation = _this select 0;
_altitude_impact = _this select 1; // Relative au canon
_vitesse_initiale = _this select 2;
_coef_frottement = _this select 3; // Positif, proche de 0
_deltat = _this select 4;

_gravite = 9.80665;

// Initialisation des variables de la simulation de la balistique
_pos_x = 0; // Distance par rapport au canon
_pos_y = 0; // Altitude par rapport au canon
_vitesse = _vitesse_initiale;
_vitesse_x = _vitesse * (cos _elevation);
_vitesse_y = _vitesse * (sin _elevation);
_temps_vol = 0;
_altitude_apogee = 0;

// Boucle faisant évoluer le temps de la simulation tant que le projectile peut encore potentiellement atteindre sa cible
while {_pos_y > _altitude_impact || _vitesse_y > 0} do
{
	// Les vitesses changent en fonction des frottements dans l'air et de la gravité
	_vitesse_x = _vitesse_x - (_coef_frottement * _vitesse_x * _vitesse * _deltat);
	_vitesse_y = _vitesse_y - (_coef_frottement * _vitesse_y * _vitesse * _deltat) - (_gravite * _deltat);
	_vitesse = sqrt ((_vitesse_x * _vitesse_x) + (_vitesse_y * _vitesse_y));
	
	// On fait avance le projectile pour ce pas de simulation en fonction des vitesses actuelles
	_pos_x = _pos_x + (_vitesse_x * _deltat);
	_pos_y = _pos_y + (_vitesse_y * _deltat);
	
	_temps_vol = _temps_vol + _deltat;
	_altitude_apogee = _altitude_apogee max _pos_y;
};

// Si le projectile n'est pas monté plus haut que la cible (arrive lorsque l'altitude d'impact est positive)
if (_altitude_apogee < _altitude_impact) then
{
	_pos_x = 0;
	_temps_vol = 0;
};

// Retour
[_pos_x, _temps_vol]