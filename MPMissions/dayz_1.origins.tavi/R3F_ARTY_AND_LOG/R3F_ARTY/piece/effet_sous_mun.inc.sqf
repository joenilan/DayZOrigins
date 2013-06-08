/**
 * Produit un effet d'obus à sous-munitions. Fichier inclu dans suivre_projectile.sqf
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_vec_projectile", "_vec_vitesse_projectile", "_vitesse_projectile", "_azimut_projectile", "_elevation_projectile", "_i"];
private ["_cos_az", "_sin_az", "_cos_el", "_sin_el", "_classe_munition "];

_vec_vitesse_projectile = velocity _projectile;
_vitesse_projectile = sqrt((_vec_vitesse_projectile select 0)^2 + (_vec_vitesse_projectile select 1)^2 + (_vec_vitesse_projectile select 2)^2);
_vec_projectile = [
	(_vec_vitesse_projectile select 0) / _vitesse_projectile,
	(_vec_vitesse_projectile select 1) / _vitesse_projectile,
	(_vec_vitesse_projectile select 2) / _vitesse_projectile
];

_azimut_projectile = (_vec_projectile select 0) atan2 (_vec_projectile select 1);
_elevation_projectile = asin (_vec_projectile select 2);

_cos_az = cos _azimut_projectile;
_sin_az = sin _azimut_projectile;
_cos_el = cos _elevation_projectile;
_sin_el = sin _elevation_projectile;

_classe_munition = if (_param_effet select 1 == "high") then {"Grenade"} else {"G_40mm_HE"};

deleteVehicle _projectile;

for [{_i = 0}, {_i < (_param_effet select 0)}, {_i = _i + 1}] do
{
	private ["_u1", "_u2", "_r", "_phi", "_vec_deviation", "_vec_sous_mun", "_vec_vitesse_sous_mun", "_sous_mun"];
	
	// Tirage uniforme d'un vecteur de déviation avec comme centre [0, 1, 0]
	_u1 = 1 - random 0.01;
	_u2 = random 1;
	_r = sqrt (0 max 1 - _u1*_u1);
	_phi = 360 * _u2;
	_vec_deviation = [_r * cos _phi, _r * sin _phi, _u1];
	
	// Application de la déviation relativement au vecteur du projectile
	_vec_sous_mun = [
		((_vec_deviation select 0) * _cos_az - (_vec_deviation select 1) * _sin_el * _sin_az + (_vec_deviation select 2) * _cos_el * _sin_az),
		(-(_vec_deviation select 0) * _sin_az - (_vec_deviation select 1) * _sin_el * _cos_az + (_vec_deviation select 2) * _cos_el * _cos_az),
		((_vec_deviation select 1) * _cos_el + (_vec_deviation select 2) * _sin_el)
	];
	
	_vec_vitesse_sous_mun = [
		_vitesse_projectile*(_vec_sous_mun select 0),
		_vitesse_projectile*(_vec_sous_mun select 1),
		_vitesse_projectile*(_vec_sous_mun select 2)
	];
	
	_sous_mun = _classe_munition createVehicle _pos_projectile;
	_sous_mun setVectorDir _vec_dir_projectile;
	_sous_mun setVelocity _vec_vitesse_sous_mun;
	
	// Marqueur d'impact
	if (R3F_ARTY_CFG_montrer_marqueur_impact) then
	{
		[_sous_mun, "submun", []] spawn R3F_ARTY_FNCT_suivre_projectile;
	};
	
	sleep (0.002 + random 0.001);
};