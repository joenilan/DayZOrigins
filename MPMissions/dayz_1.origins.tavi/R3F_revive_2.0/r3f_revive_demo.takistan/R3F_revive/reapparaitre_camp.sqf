/**
 * Fait réapparaître un joueur en attente de réanimation à la base.
 * La position de réapparition est la même que celle qu'ArmA a
 * déterminé à l'aide du système de marqueurs "respawn_xxx".
 * 
 * Copyright (C) 2011 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Fonctionnalité accessible uniquement lorsque personne ne s'occupe du blessé
if !(isNil {player getVariable "R3F_REV_est_pris_en_charge_par"}) then
{
	titleText [STR_R3F_REV_joueur_pris_en_charge, "PLAIN"];
}
else
{
	// On ferme tout les fils d'exécution éventuels
	terminate R3F_REV_fil_exec_attente_reanimation;
	terminate R3F_REV_fil_exec_reapparaitre_camp;
	terminate R3F_REV_fil_exec_effet_inconscient;
	
	// Mémorisation du fil d'exécution lancé
	R3F_REV_fil_exec_reapparaitre_camp = [] spawn
	{
		private ["_joueur"];
		_joueur = player;
		
		closeDialog 0;
		
		call R3F_REV_FNCT_detruire_marqueur_inconscient;
		
		// Informer tout le monde de la fin de l'état inconscient
		R3F_REV_fin_inconscience = _joueur;
		publicVariable "R3F_REV_fin_inconscience";
		["R3F_REV_fin_inconscience", R3F_REV_fin_inconscience] spawn R3F_REV_FNCT_fin_inconscience;
		_joueur setVariable ["R3F_REV_est_inconscient", false, true];
		_joueur setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];
		
		// On masque ce qui se passe au joueur (joueur dans les airs + animations forcés)
		R3F_REV_effet_video_couleur ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
		R3F_REV_effet_video_couleur ppEffectCommit 0;
		titleText [STR_R3F_REV_reapparition_camp_en_cours, "PLAIN"];
		
		R3F_REV_corps_avant_mort = _joueur;
		
		// Isoler le corps
		_joueur setPosATL [getPosATL _joueur select 0, getPosATL _joueur select 1, (getPosATL _joueur select 2)+2000];
		
		// Stop animation blessé, reprise arme debout
		_joueur selectWeapon (primaryWeapon _joueur);
		_joueur playMoveNow "AmovPercMstpSlowWrflDnon";
		
		sleep 5;
		
		// Retour du corps au marqueur de réapparition
		_joueur setVelocity [0, 0, 0];
		_joueur setPosATL R3F_REV_position_reapparition;
		
		// Suppresion de l'éventuel EH HandleDamage
		if !(isNil {_joueur getVariable "R3F_REV_id_EH_HandleDamage"}) then
		{
			_joueur removeEventHandler ["HandleDamage", _joueur getVariable "R3F_REV_id_EH_HandleDamage"];
			_joueur setVariable ["R3F_REV_id_EH_HandleDamage", nil, false];
		};
		
		_joueur setCaptive false;
		
		// Restauration du nombre de réanimations possibles
		R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;
		
		titleText ["", "PLAIN"];
		ppEffectDestroy R3F_REV_effet_video_flou;
		ppEffectDestroy R3F_REV_effet_video_couleur;
	};
};