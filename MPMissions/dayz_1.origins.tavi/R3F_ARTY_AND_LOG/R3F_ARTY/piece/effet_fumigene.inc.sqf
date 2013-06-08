/**
 * Produit un effet de fumigène sur la position _pos_projectile. Fichier inclu dans suivre_projectile.sqf
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_decal_dir"];

_decal_dir = random 90;

"SmokeShell" createVehicle _pos_projectile;

sleep 3;

"SmokeShell" createVehicle [
	(_pos_projectile select 0) + 5*cos (_decal_dir+0),
	(_pos_projectile select 1) + 5*sin (_decal_dir+0),
	0
];

"SmokeShell" createVehicle [
	(_pos_projectile select 0) + 5*cos (_decal_dir+90),
	(_pos_projectile select 1) + 5*sin (_decal_dir+90),
	0
];

"SmokeShell" createVehicle [
	(_pos_projectile select 0) + 5*cos (_decal_dir+180),
	(_pos_projectile select 1) + 5*sin (_decal_dir+180),
	0
];

"SmokeShell" createVehicle [
	(_pos_projectile select 0) + 5*cos (_decal_dir+270),
	(_pos_projectile select 1) + 5*sin (_decal_dir+270),
	0
];

/*
// Old version - AI are not affected by particle effects
private ["_i"];

for [{_i = 0}, {_i < 160}, {_i = _i + 1}] do
{
	drop [["\ca\Data\ParticleEffects\Universal\Universal", 16, 12, 1, 8], "", "Billboard", 0, 30,
	[(_pos_projectile select 0)-0.3+random 0.6, (_pos_projectile select 1)-0.3+random 0.6, (_pos_projectile select 2)+0.1+random 0.05],
	[0.6*(wind select 0), 0.6*(wind select 1), 0.0], 0, 1.28, 1.0, 0.0, [1.0, 20+random 2, 20+random 2],
	[[1.0, 1.0, 1.0, 1.0], [1.0, 1.0, 1.0, 1.0], [1.0, 1.0, 0.9+random 0.1, 0.5+random 0.2], [1.0, 1.0, 1.0, 0.0]],
	[1, 0.1, 0.1, 0.1, 0.1], 1, 0, "", "", ""];
	
	sleep (0.6+random 0.2);
};
*/