/**
 * Réaction à l'évènement de tir d'une pièce d'artillerie chez un client et dédié
 * 
 * @param 0 les données de l'event handler fired
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (local gunner (_this select 0)) then
{
	private ["_piece", "_projectile", "_tireur"];
	
	_piece = _this select 0;
	_projectile = nearestObject [_piece, _this select 4];
	_tireur = gunner _piece;
	
	// Pour modifier la trajectoire de l'obus afin de viser plus précisémment qu'un lookAt et/ou de gérer les chargeurs virtuels
	if (!isNull _projectile) then
	{
		private ["_mission_tir_IA_vec_dir_tir", "_chargeur_courant"];
		private ["_vec_dir_projectile", "_vec_vitesse_projectile", "_vitesse_projectile", "_nouveau_vec_vitesse", "_pos_piece", "_dimension_piece", "_nouvelle_position"];
		
		_mission_tir_IA_vec_dir_tir = _tireur getVariable "R3F_ARTY_mission_tir_IA_vec_dir_tir";
		_chargeur_courant = [_piece] call R3F_ARTY_FNCT_get_chargeur_actuel;
		
		if (isNil "_mission_tir_IA_vec_dir_tir") then
		{
			_vec_vitesse_projectile = velocity _projectile;
			_vitesse_projectile = sqrt((_vec_vitesse_projectile select 0)^2 + (_vec_vitesse_projectile select 1)^2 + (_vec_vitesse_projectile select 2)^2);
			
			_vec_dir_projectile = [
				(_vec_vitesse_projectile select 0) / _vitesse_projectile,
				(_vec_vitesse_projectile select 1) / _vitesse_projectile,
				(_vec_vitesse_projectile select 2) / _vitesse_projectile
			];
		}
		else
		{
			_vec_dir_projectile = _mission_tir_IA_vec_dir_tir;
		};
		
		_vitesse_projectile = _chargeur_courant select 2;
		
		_nouveau_vec_vitesse = [
			_vitesse_projectile*(_vec_dir_projectile select 0),
			_vitesse_projectile*(_vec_dir_projectile select 1),
			_vitesse_projectile*(_vec_dir_projectile select 2)
		];
		
		_pos_piece = getPosASL _piece;
		// Largeur maximale par rapport au centre de la pièce
		_dimension_piece = (
			(
				((boundingBox _piece select 1 select 1) max (-(boundingBox _piece select 0 select 1)))
				max
				((boundingBox _piece select 1 select 0) max (-(boundingBox _piece select 0 select 0)))
			)
			max
			((boundingBox _piece select 1 select 2) max (-(boundingBox _piece select 0 select 2)))
		);
		
		_dimension_projectile = (
			(
				((boundingBox _projectile select 1 select 1) max (-(boundingBox _projectile select 0 select 1)))
				max
				((boundingBox _projectile select 1 select 0) max (-(boundingBox _projectile select 0 select 0)))
			)
			max
			((boundingBox _projectile select 1 select 2) max (-(boundingBox _projectile select 0 select 2)))
		);
		
		_nouvelle_position = [
			(_pos_piece select 0) + (_vec_dir_projectile select 0)*(_dimension_piece + _dimension_projectile + 1),
			(_pos_piece select 1) + (_vec_dir_projectile select 1)*(_dimension_piece + _dimension_projectile + 1),
			(_pos_piece select 2) + (_vec_dir_projectile select 2)*(_dimension_piece + _dimension_projectile + 1) + 2
		];
		
		// Correction vitesse et direction puis repositionnement au bout du canon
		_projectile setVectorDir _vec_dir_projectile;
		_projectile setVelocity _nouveau_vec_vitesse;
		_projectile setPosASL _nouvelle_position;
		
		if !(isNil "_mission_tir_IA_vec_dir_tir") then
		{
			// Le tir est effectué
			_tireur setVariable ["R3F_ARTY_mission_tir_IA_vec_dir_tir", nil, false];
		};
		
		// Suivre le projectile pour gérer l'effet (smoke, ...) et marquer le point d'impact
		[_projectile, _chargeur_courant select 4, _chargeur_courant select 5] spawn R3F_ARTY_FNCT_suivre_projectile;
	}
	else
	{
		if !(isServer && isDedicated) then
		{
			player globalChat STR_R3F_ARTY_echec_recup_projectile;
		}
	};
	
	if !(isServer && isDedicated) then
	{
		// Passage automatique à l'ordre suivant à chaque tir
		if (_tireur == player) then
		{
			[] spawn R3F_ARTY_FNCT_ordre_suivant;
			
			// On raffraichit la boîte de dialogue du chargeur courant
			if (!isNull (uiNamespace getVariable "R3F_ARTY_dlg_chargeur")) then
			{
				["recharge"] spawn R3F_ARTY_FNCT_afficher_chargeur;
			};
		};
	};
};