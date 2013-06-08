/**
 * Script principal qui initialise le système d'artillerie réaliste
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "config.sqf"

[] spawn
{
	sleep 10;
	if !(isNil "BIS_ARTY_LOADED" && isNil "ACE_BI_ARTY_enabled" && isNil "ACE_BI_ARTY_VIRT_enabled") then
	{
		if !(isServer && isDedicated) then
		{
			hintC STR_R3F_ARTY_module_artillerie_BIS_present;
		};
		diag_log text (">>> " + STR_R3F_ARTY_module_artillerie_BIS_present + " <<<");
	};
};

// Suppression de l'interface d'artillerie de BIS apparue dans la version 1.54 d'ArmA OA
if (isClass (configFile >> "CfgVehicles" >> "BAF_Soldier_MTP")) then
{
	call compile "enableEngineArtillery false;";
};

// Un serveur dédié n'en a pas besoin
if !(isServer && isDedicated) then
{
	// Compilation de quelques fonctions
	R3F_ARTY_FNCT_calculer_portee = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\calcul_balistique\calculer_portee.sqf";
	R3F_ARTY_FNCT_calculer_elevation = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\calcul_balistique\calculer_elevation.sqf";
	R3F_ARTY_FNCT_tirer_position_dans_zone_elliptique = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\fonctions_generales\tirer_position_dans_zone_elliptique.sqf";
	R3F_ARTY_FNCT_formater_deux_decimales = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\fonctions_generales\formater_deux_decimales.sqf";
	R3F_ARTY_FNCT_formater_pos2D_vers_posGPS = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\fonctions_generales\formater_pos2D_vers_posGPS.sqf";
	R3F_ARTY_FNCT_afficher_ordre = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\afficher_ordre.sqf";
	R3F_ARTY_FNCT_ordre_suivant = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\ordre_suivant.sqf";
	R3F_ARTY_FNCT_afficher_chargeur = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\dlg_artilleur\afficher_chargeur.sqf";
	R3F_ARTY_FNCT_piece_init = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\piece_init.sqf";
	R3F_ARTY_FNCT_calculateur_init = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\calculateur_init.sqf";
	
	// Liste des ordres ; 2 dimensions ; 1ère dim : les ordres ; 2ème dim : [émetteur, récepteur, azimut, élévation, index_munition]
	R3F_ARTY_ordres_recus = [];
	
	uiNamespace setVariable ["R3F_ARTY_dlg_artilleur", displayNull];
	uiNamespace setVariable ["R3F_ARTY_dlg_chargeur", displayNull];
}
// Serveur dédié seulement
else
{
	R3F_ARTY_FNCT_piece_init_dedie = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\piece_init_dedie.sqf";
};

if (isServer) then
{
	R3F_ARTY_FNCT_creer_poste_commandement = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\creer_poste_commandement.sqf";
	R3F_ARTY_FNCT_supprimer_poste_commandement = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\poste_commandement\supprimer_poste_commandement.sqf";
	
	// Service offert par le serveur : créer un poste de commandement d'artillerie (valeur = calculateur associé)
	R3F_ARTY_FNCT_PUBVAR_creer_poste_commandement =
	{
		[_this select 1] spawn R3F_ARTY_FNCT_creer_poste_commandement;
	};
	"R3F_ARTY_PUBVAR_creer_poste_commandement" addPublicVariableEventHandler R3F_ARTY_FNCT_PUBVAR_creer_poste_commandement;
	
	// Service offert par le serveur : supprimer un poste de commandement d'artillerie (valeur = calculateur associé)
	R3F_ARTY_FNCT_PUBVAR_supprimer_poste_commandement =
	{
		[_this select 1] spawn R3F_ARTY_FNCT_supprimer_poste_commandement;
	};
	"R3F_ARTY_PUBVAR_supprimer_poste_commandement" addPublicVariableEventHandler R3F_ARTY_FNCT_PUBVAR_supprimer_poste_commandement;
};

R3F_ARTY_FNCT_get_chargeur_actuel = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\get_chargeur_actuel.sqf";
R3F_ARTY_FNCT_chargeurs_sont_egaux = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\chargeurs_sont_egaux.sqf";
R3F_ARTY_FNCT_get_chargeurs_compatibles_piece = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\get_chargeurs_compatibles_piece.sqf";
R3F_ARTY_FNCT_EH_fired_piece = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\EH_fired_piece.sqf";
R3F_ARTY_FNCT_executer_mission_tir_par_IA = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\executer_mission_tir_par_IA.sqf";
R3F_ARTY_FNCT_suivre_projectile = compile preprocessFile "R3F_ARTY_AND_LOG\R3F_ARTY\piece\suivre_projectile.sqf";

// Mémorisation de la liste du menu des munitions pour l'interface
private ["_table_correspondance_index_munition", "_table_correspondance_index_nom_munition", "_chargeurs_compatibles_par_piece"];
_table_correspondance_index_munition = [];
_table_correspondance_index_nom_munition = [];
_chargeurs_compatibles_par_piece = [];
// Pour chaque pièce à gérer, on insère dans la listes les munitions compatibles
for [{_i = 0}, {_i < count R3F_ARTY_CFG_pieces_artillerie}, {_i = _i + 1}] do
{
	private ["_chargeurs_compatibles", "_nom_piece"];
	
	_chargeurs_compatibles = [R3F_ARTY_CFG_pieces_artillerie select _i] call R3F_ARTY_FNCT_get_chargeurs_compatibles_piece;
	_nom_piece = getText (configFile >> "CfgVehicles" >> (R3F_ARTY_CFG_pieces_artillerie select _i) >> "displayName");
	
	_table_correspondance_index_munition = _table_correspondance_index_munition + [""];
	_table_correspondance_index_nom_munition = _table_correspondance_index_nom_munition + [" "];
	
	_table_correspondance_index_munition = _table_correspondance_index_munition + [""];
	_table_correspondance_index_nom_munition = _table_correspondance_index_nom_munition + [("----- " + _nom_piece + " -----")];
	
	for [{_j = 0}, {_j < count _chargeurs_compatibles}, {_j = _j + 1}] do
	{
		_table_correspondance_index_munition = _table_correspondance_index_munition + [_chargeurs_compatibles select _j];
		_table_correspondance_index_nom_munition = _table_correspondance_index_nom_munition + [_chargeurs_compatibles select _j select 1];
	};
	
	_chargeurs_compatibles_par_piece = _chargeurs_compatibles_par_piece + [_chargeurs_compatibles];
};

// On mémorise la correspondance car on n'a accès qu'à l'index sélectionné lors de la validation
uiNamespace setVariable ["R3F_ARTY_table_correspondance_index_munition", + _table_correspondance_index_munition];
uiNamespace setVariable ["R3F_ARTY_table_correspondance_index_nom_munition", + _table_correspondance_index_nom_munition];
uiNamespace setVariable ["R3F_ARTY_chargeurs_compatibles_par_piece", + _chargeurs_compatibles_par_piece];

// Quand on reçoit un message contenant des ordres de tir
R3F_ARTY_FNCT_PUBVAR_table_ordres_tirs =
{
	private ["_table_ordres_tirs"];
	_table_ordres_tirs = _this select 1;
	
	// Traitement des ordres destinés au joueur
	if (!isNull player) then
	{
		if (alive player) then
		{
			private ["_nb_ordres"];
			
			_nb_ordres = {_x select 1 == player} count _table_ordres_tirs;
			
			// Si on a des ordres pour nous
			if (_nb_ordres > 0) then
			{
				private ["_emetteur"];
				
				// Ajout des ordres nous concernant dans la file d'attente
				{
					if (_x select 1 == player) then
					{
						_emetteur = _x select 0;
						R3F_ARTY_ordres_recus = R3F_ARTY_ordres_recus + [_x];
					};
				} forEach _table_ordres_tirs;
				
				// Raffraichissement de l'interface si le joueur est dans une pièce
				if !(isNil "R3F_ARTY_dlg_artilleur_ouverte") then
				{
					[] spawn R3F_ARTY_FNCT_afficher_ordre;
				};
				
				if (_nb_ordres == 1) then
				{
					player globalChat format [STR_R3F_ARTY_dlg_SM_ordres_recus_un, _emetteur];
				}
				else
				{
					player globalChat format [STR_R3F_ARTY_dlg_SM_ordres_recus, _emetteur, _nb_ordres];
				};
			}
			// Informer les joueurs que des ordres de tirs sont donnés
			else
			{
				if (count _table_ordres_tirs == 1) then
				{
					player globalChat format [STR_R3F_ARTY_dlg_SM_ordres_non_personnels_recus_un, _table_ordres_tirs select 0 select 0];
				}
				else
				{
					player globalChat format [STR_R3F_ARTY_dlg_SM_ordres_non_personnels_recus, _table_ordres_tirs select 0 select 0, count _table_ordres_tirs];
				};
			};
		};
	};
	
	// Traitement des ordres destinés aux IA
	{
		if (!isPlayer (_x select 1) && local (_x select 1)) then
		{
			_x call R3F_ARTY_FNCT_executer_mission_tir_par_IA;
		};
	} forEach _table_ordres_tirs;
};
"R3F_ARTY_PUBVAR_table_ordres_tirs" addPublicVariableEventHandler R3F_ARTY_FNCT_PUBVAR_table_ordres_tirs;

// Quand on reçoit un ordre de changement de chargeur
R3F_ARTY_FNCT_PUBVAR_changer_chargeur =
{
	private ["_piece", "_chargeur"];
	_piece = _this select 1 select 0;
	_chargeur = _this select 1 select 1;
	
	// La machine appropriée effectue le changement de chargeur
	if (local (gunner _piece) || (isServer && isNull (gunner _piece))) then
	{
		_piece removeMagazines (magazines _piece select 0);
		_piece addMagazine (_chargeur select 0);
		_piece setVariable ["R3F_ARTY_chargeur_courant", _chargeur, true];
		
		// On raffraichit la boîte de dialogue de l'artilleur
		if (gunner _piece == player && !isNil "R3F_ARTY_dlg_artilleur_ouverte") then
		{
			[] spawn R3F_ARTY_FNCT_afficher_ordre;
		};
		
		// On raffraichit la boîte de dialogue du chargeur courant
		if (gunner _piece == player && !isNull (uiNamespace getVariable "R3F_ARTY_dlg_chargeur")) then
		{
			["change_chargeur"] spawn R3F_ARTY_FNCT_afficher_chargeur;
		};
	};
};
"R3F_ARTY_PUBVAR_changer_chargeur" addPublicVariableEventHandler R3F_ARTY_FNCT_PUBVAR_changer_chargeur;

// Un serveur dédié n'en a pas besoin
if !(isServer && isDedicated) then
{
	// Quand on reçoit un ordre de changement de chargeur
	R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur =
	{
		private ["_piece", "_chargeur", "_message"];
		_destinataire = _this select 1 select 0;
		_IA_artilleur = _this select 1 select 1;
		_message = _this select 1 select 2;
		
		// La machine appropriée effectue le changement de chargeur
		if (_destinataire == name player) then
		{
			_IA_artilleur globalChat _message;
		};
	};
	"R3F_ARTY_PUBVAR_message_IA_artilleur" addPublicVariableEventHandler R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
};