/**
 * Initialisation du système de réanimation.
 * 
 * Copyright (C) 2011 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "config.sqf"

/** Execution à distance d'une commande à argument local sur une unité */
R3F_REV_FNCT_code_distant =
{
	private ["_unite", "_commande", "_parametre"];
	_unite = _this select 1 select 0;
	_commande = _this select 1 select 1;
	_parametre = _this select 1 select 2;
	
	if (local _unite) then 
	{
		switch (_commande) do
		{
			case "switchMove": {_unite switchMove _parametre;};
			case "setDir": {_unite setDir _parametre;};
			case "playMove": {_unite playMove _parametre;};
			case "playMoveNow": {_unite playMoveNow _parametre;};
		};
	};
};
"R3F_REV_code_distant" addPublicVariableEventHandler R3F_REV_FNCT_code_distant;

if !(isServer && isDedicated) then
{
	// Chargement du fichier de langage
	call compile preprocessFile format ["R3F_revive\%1_strings_lang.sqf", R3F_REV_CFG_langage];
	
	[] spawn
	{
		/** Contiendra l'instance de la dernière exécution de la réaction à l'évènement "killed" */
		R3F_REV_fil_exec_attente_reanimation = [] spawn {};
		
		/** Contiendra l'instance de la dernière exécution de la fonction R3F_REV_FNCT_reapparaitre_camp */
		R3F_REV_fil_exec_reapparaitre_camp = [] spawn {};
		
		/** Contiendra l'instance de la dernière boucle d'effets symbolisant l'effet inconscient */
		R3F_REV_fil_exec_effet_inconscient = [] spawn {};
		
		/** Nombre de vies restantes au joueur */
		R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;
		
		/** Code à exécuter lors de la mort du joueur */
		R3F_REV_FNCT_onKilled = compile preprocessFile "R3F_revive\onKilled.sqf";
		
		/** Code ramenant le joueur au camp alors qu'il est en attente de réanimation */
		R3F_REV_FNCT_reapparaitre_camp = compile preprocessFile "R3F_revive\reapparaitre_camp.sqf";
		
		// Fonction de gestion des sac à dos pour OA 1.54+
		if (isClass (configFile >> "CfgVehicles" >> "BAF_Soldier_MTP")) then
		{
			/** Obtenir le contenu d'un sac à dos */
			R3F_REV_FNCT_obtenir_infos_sacados = compile preprocessFile "R3F_revive\obtenir_infos_sacados.sqf";
			
			/** Assigner le contenu d'un sac à dos */
			R3F_REV_FNCT_assigner_sacados = compile preprocessFile "R3F_revive\assigner_sacados.sqf";
		};
		
		/** Création d'un marqueur "inconscient" sur le joueur, si l'option est activée */
		R3F_REV_FNCT_creer_marqueur_inconscient =
		{
			if (R3F_REV_CFG_afficher_marqueur && alive player) then
			{
				private ["_marqueur"];
				_marqueur = createMarker [("R3F_REV_mark_" + name player), getPos player];
				_marqueur setMarkerType "mil_triangle";
				_marqueur setMarkerColor "colorRed";
				_marqueur setMarkerText format [STR_R3F_REV_marqueur_attente_reanimation, name player];
			};
		};
		
		/** Destruction du marqueur "inconscient" du joueur, si l'option est activée */
		R3F_REV_FNCT_detruire_marqueur_inconscient =
		{
			if (R3F_REV_CFG_afficher_marqueur && alive player) then
			{
				deleteMarker ("R3F_REV_mark_" + name player);
			};
		};
		
		// Au cas où l'utilisateur définisse tardivement ces variables de configuration dans un script externe, initialisation par défaut
		if (isNil "R3F_REV_CFG_list_of_classnames_who_can_revive") then {R3F_REV_CFG_list_of_classnames_who_can_revive = [];};
		if (isNil "R3F_REV_CFG_list_of_slots_who_can_revive") then {R3F_REV_CFG_list_of_slots_who_can_revive = [];};
		if (isNil "R3F_REV_CFG_all_medics_can_revive") then {R3F_REV_CFG_all_medics_can_revive = false;};
		if (isNil "R3F_REV_CFG_player_can_drag_body") then {R3F_REV_CFG_player_can_drag_body = false;};
		
		/** Retourne vrai si le joueur est autorisé à réanimer un corps inconscient, faux sinon */
		R3F_REV_FNCT_peut_reanimer =
		{
			if (R3F_REV_CFG_all_medics_can_revive && getNumber (configFile >> "CfgVehicles" >> (typeOf player) >> "attendant") == 1) then {true}
			else
			{
				if (player in R3F_REV_CFG_list_of_slots_who_can_revive) then {true}
				else
				{
					if (typeOf player in R3F_REV_CFG_list_of_classnames_who_can_revive) then {true}
					else {false};
				};
			};
		};
		
		/** Gestion du signal réseau indiquant qu'un joueur passe en attente de réanimation */
		R3F_REV_FNCT_nouvel_inconscient =
		{
			private ["_unite", "_id_action"];
			_unite = _this select 1;
			
			// Ajout des actions "réanimer" et "traîner" dans le menu
			if !(isServer && isDedicated) then 
			{
				if !(isNull _unite) then
				{
					player reveal _unite;
					
					_id_action = _unite addAction [STR_R3F_REV_action_reanimer, "R3F_revive\reanimer.sqf", [], 10, false, true, "",
					"player distance _target < 2 && !(player getVariable ""R3F_REV_est_inconscient"") && call R3F_REV_FNCT_peut_reanimer && alive _target && isPlayer _target && (_target getVariable ""R3F_REV_est_inconscient"") && isNil {_target getVariable ""R3F_REV_est_pris_en_charge_par""}"];
					_unite setVariable ["R3F_REV_id_action_reanimer", _id_action, false];
					
					_id_action = _unite addAction [STR_R3F_REV_action_deplacer_corps, "R3F_revive\trainer_corps.sqf", [], 10, false, true, "",
					"player distance _target < 2 && !(player getVariable ""R3F_REV_est_inconscient"") && R3F_REV_CFG_player_can_drag_body && alive _target && isPlayer _target && (_target getVariable ""R3F_REV_est_inconscient"") && isNil {_target getVariable ""R3F_REV_est_pris_en_charge_par""}"];
					_unite setVariable ["R3F_REV_id_action_trainer_corps", _id_action, false];
				};
			};
		};
		"R3F_REV_nouvel_inconscient" addPublicVariableEventHandler R3F_REV_FNCT_nouvel_inconscient;
		
		/** Gestion du signal réseau indiquant qu'un joueur passe en attente de réanimation */
		R3F_REV_FNCT_fin_inconscience =
		{
			private ["_unite"];
			_unite = _this select 1;
			
			// Suppression des actions "réanimer" et "traîner" dans le menu
			if !(isServer && isDedicated) then 
			{
				if !(isNull _unite) then
				{
					if !(isNil {_unite getVariable "R3F_REV_id_action_reanimer"}) then
					{
						_unite removeAction (_unite getVariable "R3F_REV_id_action_reanimer");
						_unite setVariable ["R3F_REV_id_action_reanimer", nil, false];
					};
					
					if !(isNil {_unite getVariable "R3F_REV_id_action_trainer_corps"}) then
					{
						_unite removeAction (_unite getVariable "R3F_REV_id_action_trainer_corps");
						_unite setVariable ["R3F_REV_id_action_trainer_corps", nil, false];
					};
				};
			};
		};
		"R3F_REV_fin_inconscience" addPublicVariableEventHandler R3F_REV_FNCT_fin_inconscience;
		
		// Attente d'initialisation du joueur
		waitUntil {!(isNull player)};
		
		/** Mémorise le corps du joueur avant respawn */
		R3F_REV_corps_avant_mort = player;
		
		/** Mémorise la position à laquelle le joueur est réapparu avant le retour au lieu du décès (typiquement : marqueur respawn_west) */
		R3F_REV_position_reapparition = getPosATL R3F_REV_corps_avant_mort;
		
		// Destruction éventuelle du marqueur en cas de reconnexion après un plantage pendant une attente de réanimation
		call R3F_REV_FNCT_detruire_marqueur_inconscient;
		
		/** Démarre la phase d'attente de réanimation sur l'évènement "killed" */
		player addEventHandler ["killed", R3F_REV_FNCT_onKilled];
		
		sleep (0.5 + random 0.5);
		
		/** Référence l'unité réanimant ou traînant le joueur, ou bien nil (variable publique) */
		player setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];
		
		if !(isNil {player getVariable "R3F_REV_est_inconscient"}) then
		{
			// Si le joueur qui se connecte (en JIP) prend le contrôle d'une IA inconsciente
			if (player getVariable "R3F_REV_est_inconscient") then
			{
				// Retour en phase de réanimation
				[player, player] call R3F_REV_FNCT_onKilled;
			};
		}
		else
		{
			/** Vrai si le joueur est dans un état inconscient (variable publique) */
			player setVariable ["R3F_REV_est_inconscient", false, true];
		};
		
		// Initialisation des autres unités (JIP, disabledAI, ...)
		{
			["R3F_REV_fin_inconscience", _x] call R3F_REV_FNCT_fin_inconscience;
			
			if (_x != player) then
			{
				if !(isNil {_x getVariable "R3F_REV_est_inconscient"}) then
				{
					if (_x getVariable "R3F_REV_est_inconscient") then
					{["R3F_REV_nouvel_inconscient", _x] call R3F_REV_FNCT_nouvel_inconscient;};
				};
			};
		} forEach (playableUnits + switchableUnits + allUnits);
	};
};