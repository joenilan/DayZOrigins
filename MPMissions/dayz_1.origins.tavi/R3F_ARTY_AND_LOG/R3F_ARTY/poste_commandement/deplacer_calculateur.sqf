/**
 * Fait remballer et déplacer le calculateur par le joueur.
 * Il garde le calculateur tant qu'il ne le relâche pas ou ne meurt pas.
 * L'objet est relaché quand la variable R3F_LOG_joueur_deplace_objet passe à objNull ce qui terminera le script.
 * 
 * @param 0 le calculateur à déplacer
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;
	
	private ["_calculateur", "_arme_principale", "_action_menu", "_azimut_canon"];
	
	_calculateur = _this select 0;
	
	_calculateur setVariable ["R3F_LOG_est_deplace_par", player, true];
	
	R3F_LOG_joueur_deplace_objet = _calculateur;
	
	// Remballer le poste de commandement d'artillerie
	R3F_ARTY_PUBVAR_supprimer_poste_commandement = _calculateur;
	if (isServer) then
	{
		["R3F_ARTY_PUBVAR_supprimer_poste_commandement", R3F_ARTY_PUBVAR_supprimer_poste_commandement] spawn R3F_ARTY_FNCT_PUBVAR_supprimer_poste_commandement;
	}
	else
	{
		publicVariable "R3F_ARTY_PUBVAR_supprimer_poste_commandement";
	};
	
	// Sauvegarde et retrait de l'arme primaire
	_arme_principale = primaryWeapon player;
	if (_arme_principale != "") then
	{
		player playMove "AidlPercMstpSnonWnonDnon04";
		sleep 2;
		player removeWeapon _arme_principale;
	}
	else {sleep 0.5;};
	
	// Si le joueur est mort pendant le sleep, on remet tout comme avant
	if (!alive player) then
	{
		R3F_LOG_mutex_local_verrou = false;
		
		// Car attachTo de "charger" à -2000m de haut :
		_calculateur setPos [getPos _calculateur select 0, getPos _calculateur select 1, 0];
		_calculateur setVelocity [0, 0, 0];
		
		execVM "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\installer_poste.sqf";
		
		_calculateur setVariable ["R3F_LOG_est_deplace_par", objNull, true];
	}
	else
	{
		_calculateur attachTo [player, [0, 0.7, 1.35]];
		
		R3F_LOG_mutex_local_verrou = false;
		
		_action_menu = player addAction [("<t color=""#dddd00"">" + STR_R3F_ARTY_action_installer_poste + "</t>"), "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\installer_poste.sqf", nil, 5, true, true];
		
		// On limite la vitesse de marche et on interdit de monter dans un véhicule tant que l'objet est porté
		while {!isNull R3F_LOG_joueur_deplace_objet && alive player} do
		{
			if (vehicle player != player) then
			{
				player globalChat STR_R3F_LOG_ne_pas_monter_dans_vehicule;
				player action ["eject", vehicle player];
				sleep 1;
			};
			
			if ([0,0,0] distance (velocity player) > 2.8) then
			{
				player globalChat STR_R3F_LOG_courir_trop_vite;
				player playMove "AmovPpneMstpSnonWnonDnon";
				sleep 1;
			};
			
			sleep 0.25;
		};
		
		// L'objet n'est plus porté, on le repose
		detach _calculateur;
		_calculateur setPos [getPos _calculateur select 0, getPos _calculateur select 1, 0];
		_calculateur setVelocity [0, 0, 0];
		
		player removeAction _action_menu;
		R3F_LOG_joueur_deplace_objet = objNull;
		
		_calculateur setVariable ["R3F_LOG_est_deplace_par", objNull, true];
		
		if (!alive player) then
		{
			R3F_LOG_joueur_deplace_objet = _calculateur;
			execVM "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\installer_poste.sqf";
		};
		
		// Restauration de l'arme primaire
		if (alive player && _arme_principale != "") then
		{
			player addWeapon _arme_principale;
			player selectWeapon _arme_principale;
			player selectWeapon (getArray (configFile >> "cfgWeapons" >> _arme_principale >> "muzzles") select 0);
		};
	};
};