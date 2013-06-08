/**
 * Configuration file - English and french translated
 * Fichier de configuration - Traduit en anglais et en français
 */

/**
 * LANGUAGE
 * Language selection ("en" for english, "fr" for french, or other if you create your own "XX_strings_lang.sqf" file)
 * Sélection de la langue ("en" pour anglais, "fr" pour français, ou autre si vous créez votre propre fichier "XX_strings_lang.sqf")
 */
R3F_REV_CFG_langage = "en";

/**
 * NUMBER OF REVIVES
 * Maximal number of revives for a player
 * Nombre maximal de réanimations par joueur
 */
R3F_REV_CFG_nb_reanimations = 3;

/**
 * ALLOW TO RESPAWN AT CAMP
 * True to permits the player to respawn at the "respawn_xxx" marker
 * when he has no more revive credits or if there is no medic to revive
 * 
 * Vrai pour que le joueur puisse réapparaitre sur le marqueur "respawn_xxx"
 * lorsqu'il a épuisé ses réanimations ou que personne ne peut le réanimer
 */
R3F_REV_CFG_autoriser_reapparaitre_camp = true;

/**
 * ALLOW CAMERA
 * True to allow the players who are out of the game (no more revive credits and respawn at camp forbidden) to view the game in camera mode
 * Vrai pour autoriser un joueur hors jeu (plus de réanimation possible et retour au camp non autorisé) à suivre la partie en mode caméra
 */
R3F_REV_CFG_autoriser_camera = true;

/**
 * SHOW MARKER
 * True to show a marker on map on the position of players who are waiting for being revived
 * Vrai pour afficher un marqueur sur carte sur la position des joueurs en attente de réanimation
 */
R3F_REV_CFG_afficher_marqueur = true;

/**
 * STILL INJURED AFTER REVIVE
 * True to keep the revived player slightly injured. So it need to be healed by a ("real") medic or a MASH (more "realistic")
 * Vrai pour garder le joueur réanimé légèrement blessé, de sorte qu'il doit être soigner par un ("vrai") infirmier ou un MASH (plus "réaliste")
 */
R3F_REV_CFG_revived_players_are_still_injured = false;

/**
 * ALLOW TO DRAG BODY
 * True to allow any player to drag unconscious bodies
 * The value can be changed with an external script at any time with an instant effect
 * 
 * Vrai pour autoriser les joueurs à traîner les corps inconscients
 * Cette variable peut-être modifiée par un script externe à n'importe quelle moment avec effet immédiat
 */
R3F_REV_CFG_player_can_drag_body = true;

/**
 * ALLOW TO REVIVE (system with three variables)
 * There are different ways to define who can revive unconscious bodies.
 * 
 * The variable R3F_REV_CFG_list_of_classnames_who_can_revive contains the list of classnames (i.e. the types of soldiers) who can revive.
 * To allow every soldiers to revive, you can write : R3F_REV_CFG_list_of_classnames_who_can_revive = ["CAManBase"];
 * To allow USMC officers and medics, you can write : R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer", "USMC_Soldier_Medic"];
 * To not use the classnames to specify who can revive, you can write an empty list : R3F_REV_CFG_list_of_classnames_who_can_revive = [];
 * To know the different classnames of soldiers, you can visit this page : http://www.armatechsquad.com/ArmA2Class/
 * 
 * The variable R3F_REV_CFG_list_of_slots_who_can_revive contains the list of named slots (or units) who can revive.
 * For example, consider that you have two playable units named "medic1" and "medic2" in your mission editor.
 * To allow these two medics to revive, you can write : R3F_REV_CFG_list_of_slots_who_can_revive = [medic1, medic2];
 * To not use the slots list to specify who can revive, you can write an empty list : R3F_REV_CFG_list_of_slots_who_can_revive = [];
 * 
 * The variable R3F_REV_CFG_all_medics_can_revive is a boolean to allow all medics to revive.
 * 
 * These three variables can be used together. The players who can revive are the union of the allowed players for each variable.
 * For example, if you set :
 *   R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer"];
 *   R3F_REV_CFG_list_of_slots_who_can_revive = [special_slot1, special_slot2];
 *   R3F_REV_CFG_all_medics_can_revive = true;
 * then all the medics, all the "USMC_Soldier_Officer" and the players at special_slot1, special_slot1 can revive.
 * If a player "appears" in two categories (e.g. he is an "USMC_Soldier_Officer" at the slot named "special_slot2"),
 * it is not a matter. He will be allowed to revive without problem.
 * 
 * The value of the three variables can be changed with an external script at any time with an instant effect.
 * 
 *************************************************************************************
 * Il y a différentes façons de définir qui peut réanimer les corps inconscients.
 * 
 * La variable R3F_REV_CFG_list_of_classnames_who_can_revive contient la listes des noms de classes (càd des types de soldats) qui peuvent réanimer.
 * Pour autoriser tous les soldats, vous pouvez écrire : R3F_REV_CFG_list_of_classnames_who_can_revive = ["CAManBase"];
 * Pour autoriser les officiers et infirmiers USMC, vous pouvez écrire : R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer", "USMC_Soldier_Medic"];
 * Pour ne pas utiliser les noms de classes pour définir qui peut réanimer, vous pouvez écrire : R3F_REV_CFG_list_of_classnames_who_can_revive = [];
 * Pour connaître les différents noms de classes des soldats, vous pouvez visiter cette page : http://www.armatechsquad.com/ArmA2Class/
 * 
 * La variable R3F_REV_CFG_list_of_slots_who_can_revive contient la liste des slots nommés (ou des unités) pouvant réanimer.
 * Par exemple, prenons deux unités jouables nommées "infimier1" et "infimier2" dans l'éditeur de mission.
 * Pour autoriser ces deux médecins à réanimer, vous pouvez écrire : R3F_REV_CFG_list_of_slots_who_can_revive = [infimier1, infimier2];
 * Pour ne pas utiliser la liste de slots pour définir qui peut réanimer, vous pouvez écrire : R3F_REV_CFG_list_of_slots_who_can_revive = [];
 * 
 * La variable R3F_REV_CFG_all_medics_can_revive est un booléen permettant d'autoriser tous les infimiers à réanimer.
 * 
 * Ces trois variables peuvent être utilisées ensemble. Les joueurs pouvant réanimer sont l'union des joueurs autorisés pour chacune des variables.
 * Par exemple, si vous avez :
 *   R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer"];
 *   R3F_REV_CFG_list_of_slots_who_can_revive = [slot_special1, slot_special2];
 *   R3F_REV_CFG_all_medics_can_revive = true;
 * alors tous les infirmiers, tous les "USMC_Soldier_Officer" et les joueurs occupant les slots slot_special1, slot_special2 pourront réanimer.
 * Si un joueur rentre dans plusieurs catégories (ex : c'est un "USMC_Soldier_Officer" occupant le slot "slot_special2"),
 * ce n'est pas un problème. Il sera correctement autorisé à réanimer.
 * 
 * Ces trois variables peuvent-être modifiées par un script externe à n'importe quelle moment avec effet immédiat.
 */
R3F_REV_CFG_list_of_classnames_who_can_revive = [];
R3F_REV_CFG_list_of_slots_who_can_revive = [];
R3F_REV_CFG_all_medics_can_revive = true;
