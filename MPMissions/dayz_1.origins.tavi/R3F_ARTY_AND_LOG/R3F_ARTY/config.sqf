/**
 * English and French comments
 * Commentaires anglais et français
 * 
 * This file contains the configuration variables of the realistic artillery system
 * Fichier contenant les variables de configuration du système d'artillerie réaliste
 */

/**
 * Boolean, set to true to enable the "show impact location on map" feature
 * Booléen indiquant s'il faut ou non afficher les marqueurs d'impact sur la carte
 */
R3F_ARTY_CFG_montrer_marqueur_impact = true;

/**
 * Boolean, set to true to enable the feature which permits to get coordinates from the player position
 * Booléen indiquant s'il faut ou non permettre de récupérer des coordonnées à partir de la position du joueur pour définir la position de la batterie
 */
R3F_ARTY_CFG_autoriser_pos_joueur = true;

/**
 * Boolean, set to true to enable the feature which permits to get coordinates by clicking on a map dialog
 * Booléen indiquant s'il faut ou non permettre de récupérer des coordonnées en cliquant sur la carte pour définir la position de la batterie et de la cible
 */
R3F_ARTY_CFG_autoriser_clic_carte = true;

/**
 * Island's property to convert map's long/lat to world's XY.
 * If the GPS position [0,0] is at the south-west corner, then the value must be -1.
 * If the GPS position [0,0] is at the north-east corner, then value must be the height
 * of the island in meters (i.e. how large is the island in the axis north-south).
 * 
 * Propriété de l'île convertir les long/lat de la carte en XY du monde.
 * Si la position GPS [0,0] est au coin sud-ouest, la valeur doit être -1.
 * Si la position GPS [0,0] est au coin nord-ouest, la valeur doit être la hauteur de l'île
 * en mètres (c'est-à-dire la largeur de l'île dans l'axe nord-sud).
 */
//R3F_ARTY_CFG_hauteur_ile = -1; // Takistan
//R3F_ARTY_CFG_hauteur_ile = -1; // Zargabad
//R3F_ARTY_CFG_hauteur_ile = -1; // Desert (from arrowhead)
R3F_ARTY_CFG_hauteur_ile = 15360; // Chernarus
//R3F_ARTY_CFG_hauteur_ile = 5120; // Utes
//R3F_ARTY_CFG_hauteur_ile = 12800; // Namalsk
//R3F_ARTY_CFG_hauteur_ile = 20480; // Podagorsk
//R3F_ARTY_CFG_hauteur_ile = 12800; // Everon
//R3F_ARTY_CFG_hauteur_ile = 10240; // Panthera
//R3F_ARTY_CFG_hauteur_ile = 10240; // Baghdad
//R3F_ARTY_CFG_hauteur_ile = 5120; // Little Green Bag
//R3F_ARTY_CFG_hauteur_ile = 10240; // Watkins
//R3F_ARTY_CFG_hauteur_ile = 10240; // Aiaktalik
//R3F_ARTY_CFG_hauteur_ile = 20480; // Afghanistan - Oruzgan province
//R3F_ARTY_CFG_hauteur_ile = 10240; // Ovaron
//R3F_ARTY_CFG_hauteur_ile = 5120; // Japahto
//R3F_ARTY_CFG_hauteur_ile = 5120; // Isla de Pollo
//R3F_ARTY_CFG_hauteur_ile = 10240; // Isla Duala
//R3F_ARTY_CFG_hauteur_ile = 20480; // Tropica
//R3F_ARTY_CFG_hauteur_ile = 51200; // PMC Desert (wrp demo) (with and without cities)
//R3F_ARTY_CFG_hauteur_ile = 10240; // Jade Groove
//R3F_ARTY_CFG_hauteur_ile = 10240; // Lingor

/**
 * List of class names of guns and mortars to manage. The classes which inherits from the ones listed will be also managed.
 * Liste des noms de classes des canons et mortiers à gérer. Les classes dérivant de celles listées seront aussi gérées.
 */
R3F_ARTY_CFG_pieces_artillerie = ["M119", "D30_Base", "M252", "2b14_82mm"];

// MLRS, BM-21 Grad and Stryker MC : OA 1.54+ only
if (isClass (configFile >> "CfgVehicles" >> "BAF_Soldier_MTP")) then
{
	R3F_ARTY_CFG_pieces_artillerie = R3F_ARTY_CFG_pieces_artillerie + ["M1129_MC_EP1"];
	// ACE currently don't work (ACE_ARTY_ReplaceWithAmmo)
	if !(isClass (configFile >> "CfgVehicles" >> "ACE_Help")) then
	{
		R3F_ARTY_CFG_pieces_artillerie = R3F_ARTY_CFG_pieces_artillerie + ["MLRS", "GRAD_Base"];
	};
};

// vilas' M109
if (isClass (configFile >> "CfgVehicles" >> "vil_m109_sph")) then
{
	R3F_ARTY_CFG_pieces_artillerie = R3F_ARTY_CFG_pieces_artillerie + ["vil_m109_sph"];
};

/**
 * List of class names of objects which provides an artillery computer INSIDE it (vehicle or unit). The classes which inherits from the ones listed will be also managed.
 * Liste des noms de classes des objets qui fournissent un calculateur d'artillerie à l'INTERIEUR (véhicule ou personne). Les classes dérivant de celles listées seront aussi gérées.
 */
R3F_ARTY_CFG_calculateur_interne = [];

// MLRS and BM-21 Grad : OA 1.54+ only
if (isClass (configFile >> "CfgVehicles" >> "BAF_Soldier_MTP")) then
{
	R3F_ARTY_CFG_calculateur_interne = R3F_ARTY_CFG_calculateur_interne + ["M1129_MC_EP1"];
	// ACE currently don't work (ACE_ARTY_ReplaceWithAmmo)
	if !(isClass (configFile >> "CfgVehicles" >> "ACE_Help")) then
	{
		R3F_ARTY_CFG_calculateur_interne = R3F_ARTY_CFG_calculateur_interne + ["MLRS", "GRAD_Base"];
	};
};

// vilas' M109
if (isClass (configFile >> "CfgVehicles" >> "vil_m109_sph")) then
{
	R3F_ARTY_CFG_calculateur_interne = R3F_ARTY_CFG_calculateur_interne + ["vil_m109_sph"];
};

/**
 * List of class names of objects which provides an artillery computer from outside. The classes which inherits from the ones listed will be also managed.
 * Liste des noms de classes des objets qui fournissent un calculateur d'artillerie depuis l'extérieur. Les classes dérivant de celles listées seront aussi gérées.
 */
R3F_ARTY_CFG_calculateur_externe = [];

/***** ADVANCED CONFIGURATION ABOUT THE BALLISTIC CALCULATIONS (MODIFY IT IS NOT RECOMMANDED) : *****/
/***** CONFIGURATION AVANCEE CONCERNANT LES CALCULS BALISTIQUES (MODIFICATION NON RECOMMANDEE) : *****/

/**
 * Step of time in seconds for the ballistic simulation. A small value gives more precise results but increase the calculation time.
 * Pas de temps en secondes pour la simulation balistique. Une petite valeur calcule des balistiques plus précises mais augmente le temps de calcul.
 */
R3F_ARTY_CFG_deltat = 0.002;

/**
 * Minimal wanted precision in meters for the fire solution computed, when the volunteer dispersion is lower than 10m.
 * A small value gives more precise results but increase the calculation time.
 * 
 * Précision minimale en mètres souhaitée pour les solutions de tir calculées, lorsque la dispersion volontaire souhaitée est inférieure à 10m.
 * Une petite valeur améliore la précision du tir mais augmente le temps de calcul.
 */
R3F_ARTY_CFG_precision = 1.75;

/**
 * List of default impact altitudes to use for the table generation
 * Liste des altitudes d'impact par défaut à utiliser dans la génération de tables
 */
R3F_ARTY_table_altitude_impact_defaut = [-1000,-600,-400,-260,-130,0,130,260,400,600,1000];

/**
 * List of default angles to use for the table generation
 * Liste des angles par défaut à utiliser dans la génération de tables
 */
R3F_ARTY_table_angles_defaut = [
	 0,  0.33,  0.66,  1,  1.33,  1.66,  2,  2.33,  2.66,  3,  3.33,  3.66,  4,  4.33,  4.66,  5,  5.33,  5.66,  6,  6.33,  6.66,  7,  7.33,  7.66,  8,  8.33,  8.66,  9,  9.33,  9.66,
	10, 10.33, 10.66, 11, 11.33, 11.66, 12, 12.33, 12.66, 13, 13.33, 13.66, 14, 14.33, 14.66, 15, 15.33, 15.66, 16, 16.33, 16.66, 17, 17.33, 17.66, 18, 18.33, 18.66, 19, 19.33, 19.66,
	20, 20.33, 20.66, 21, 21.33, 21.66, 22, 22.33, 22.66, 23, 23.33, 23.66, 24, 24.33, 24.66, 25, 25.33, 25.66, 26, 26.33, 26.66, 27, 27.33, 27.66, 28, 28.33, 28.66, 29, 29.33, 29.66,
	30, 30.33, 30.66, 31, 31.33, 31.66, 32, 32.33, 32.66, 33, 33.33, 33.66, 34, 34.33, 34.66, 35, 35.33, 35.66, 36, 36.33, 36.66, 37, 37.33, 37.66, 38, 38.33, 38.66, 39, 39.33, 39.66,
	40, 40.33, 40.66, 41, 41.33, 41.66, 42, 42.33, 42.66, 43, 43.33, 43.66, 44, 44.33, 44.66, 45, 45.33, 45.66, 46, 46.33, 46.66, 47, 47.33, 47.66, 48, 48.33, 48.66, 49, 49.33, 49.66,
	50, 50.33, 50.66, 51, 51.33, 51.66, 52, 52.33, 52.66, 53, 53.33, 53.66, 54, 54.33, 54.66, 55, 55.33, 55.66, 56, 56.33, 56.66, 57, 57.33, 57.66, 58, 58.33, 58.66, 59, 59.33, 59.66,
	60, 60.33, 60.66, 61, 61.33, 61.66, 62, 62.33, 62.66, 63, 63.33, 63.66, 64, 64.33, 64.66, 65, 65.33, 65.66, 66, 66.33, 66.66, 67, 67.33, 67.66, 68, 68.33, 68.66, 69, 69.33, 69.66,
	70, 70.33, 70.66, 71, 71.33, 71.66, 72, 72.33, 72.66, 73, 73.33, 73.66, 74, 74.33, 74.66, 75, 75.33, 75.66, 76, 76.33, 76.66, 77, 77.33, 77.66, 78, 78.33, 78.66, 79, 79.33, 79.66,
	80, 80.33, 80.66, 81, 81.33, 81.66, 82, 82.33, 82.66, 83, 83.33, 83.66, 84, 84.33, 84.66, 85, 85.33, 85.66, 86
];

/**
 * Load of pre-computed tables - add here the new tables
 * Chargement des tables précalculées - ajouter ici les nouvelles tables
 */
R3F_ARTY_CFG_tables = [
	#include "tables\spd100_fric0.sqf",
	#include "tables\spd150_fric0.sqf",
	#include "tables\spd200_fric0.sqf",
	#include "tables\spd250_fric0.sqf",
	#include "tables\spd300_fric0.sqf",
	#include "tables\spd350_fric0.sqf",
	#include "tables\spd400_fric0.sqf",
	
	#include "tables\spd450_fric0.00038.sqf",
	#include "tables\spd900_fric0.00038.sqf",
	#include "tables\spd2800_fric0.00038.sqf",
	#include "tables\spd8500_fric0.00038.sqf",
	
	#include "tables\spd150_fric0.00055.sqf",
	#include "tables\spd250_fric0.00055.sqf",
	#include "tables\spd800_fric0.00055.sqf",
	#include "tables\spd2200_fric0.00055.sqf"
];

/**
 * Magazines to not use
 * Chargeurs à ne pas utiliser
 */
R3F_ARTY_CFG_chargeurs_interdits = [
	"30Rnd_105mmHE_M119",
	"6RND_105mm_APDS",
	"12RND_105mm_HESH",
	"30Rnd_105mmWP_M119",
	"30Rnd_105mmSADARM_M119",
	"30Rnd_105mmLASER_M119",
	"30Rnd_105mmSMOKE_M119",
	"30Rnd_105mmILLUM_M119",
	"30Rnd_122mmHE_D30",
	"30Rnd_122mmWP_D30",
	"30Rnd_122mmSADARM_D30",
	"30Rnd_122mmLASER_D30",
	"30Rnd_122mmSMOKE_D30",
	"30Rnd_122mmILLUM_D30",
	"8Rnd_81mmHE_M252",
	"8Rnd_81mmWP_M252",
	"8Rnd_81mmILLUM_M252",
	"8Rnd_82mmHE_2B14",
	"8Rnd_82mmWP_2B14",
	"8Rnd_82mmILLUM_2B14",
	
	"ARTY_30Rnd_105mmHE_M119",
	"ARTY_30Rnd_105mmWP_M119",
	"ARTY_30Rnd_105mmSADARM_M119",
	"ARTY_30Rnd_105mmLASER_M119",
	"ARTY_30Rnd_105mmSMOKE_M119",
	"ARTY_30Rnd_105mmILLUM_M119",
	"ARTY_30Rnd_122mmHE_D30",
	"ARTY_30Rnd_122mmWP_D30",
	"ARTY_30Rnd_122mmSADARM_D30",
	"ARTY_30Rnd_122mmLASER_D30",
	"ARTY_30Rnd_122mmSMOKE_D30",
	"ARTY_30Rnd_122mmILLUM_D30",
	"ARTY_8Rnd_81mmHE_M252",
	"ARTY_8Rnd_81mmWP_M252",
	"ARTY_8Rnd_81mmILLUM_M252",
	"ARTY_8Rnd_82mmHE_2B14",
	"ARTY_8Rnd_82mmWP_2B14",
	"ARTY_8Rnd_82mmILLUM_2B14",
	"24Rnd_120mmHE_M120_02",
	
	"12Rnd_MLRS",
	"40Rnd_GRAD",
	
	"ACE_ARTY_30Rnd_105mmHE_M119",
	"ACE_ARTY_30Rnd_105mmWP_M119",
	"ACE_ARTY_30Rnd_105mmSADARM_M119",
	"ACE_ARTY_30Rnd_105mmLASER_M119",
	"ACE_ARTY_30Rnd_105mmSMOKE_M119",
	"ACE_ARTY_30Rnd_105mmILLUM_M119",
	"ACE_ARTY_30Rnd_122mmHE_D30",
	"ACE_ARTY_30Rnd_122mmWP_D30",
	"ACE_ARTY_30Rnd_122mmSADARM_D30",
	"ACE_ARTY_30Rnd_122mmLASER_D30",
	"ACE_ARTY_30Rnd_122mmSMOKE_D30",
	"ACE_ARTY_30Rnd_122mmILLUM_D30",
	"ACE_ARTY_8Rnd_81mmHE_M252",
	"ACE_ARTY_8Rnd_81mmWP_M252",
	"ACE_ARTY_8Rnd_81mmILLUM_M252",
	"ACE_ARTY_8Rnd_82mmHE_2B14",
	"ACE_ARTY_8Rnd_82mmWP_2B14",
	"ACE_ARTY_8Rnd_82mmILLUM_2B14",
	
	//"ACE_ARTY_12Rnd_227mmHE_M270", // ACE currently don't work (ACE_ARTY_ReplaceWithAmmo)
	//"ACE_ARTY_40Rnd_120mmHE_BM21", // ACE currently don't work (ACE_ARTY_ReplaceWithAmmo)
	
	"vil_PALmag_HE"
];

/**
 * Declaration of the virtual magazines handled by the system
 * Format : ["real_magazine_class_name", "virtual_shell_display_name", init speed, effect ("HE", "smoke", "cluster"), param_array]
 * Note : the friction coefficient if the same than real magazine class name
 * Param array for HE : [] (empty)
 * Param array for smoke : [] (empty)
 * Param array for cluster : [number of sub-munitions, sub-munitions hit power ("high"/"low"), inf deploy altitude, sup deploy altitude]
 * 
 * Définition des chargeurs virtuels gérés par le système
 * Format : ["nom_classe_chargeur_reel", "nom_affichage_obus_virtuel", vitesse initiale, effet ("HE", "smoke", "cluster"), tab_param]
 * Note : le coefficient de frottements est le même que celui du chargeur réel
 * Tableau de param pour HE : [] (vide)
 * Tableau de param pour smoke : [] (vide)
 * Tableau de param pour cluster : [nombre de sous-munitions, puissance des sous-munitions ("high"/"low"), altitude inf de déploiement, altitude sup de déploiement]
 */
R3F_ARTY_CFG_chargeurs_virtuels = [
	// M119 | OA/CO - A2 - ACE
	["30Rnd_105mmHE_M119", "HE 105mm Ch.1 (4000m)", 200, "HE", []],
	["30Rnd_105mmHE_M119", "HE 105mm Ch.2 (6000m)", 250, "HE", []],
	["30Rnd_105mmHE_M119", "HE 105mm Ch.3 (9000m)", 300, "HE", []],
	["30Rnd_105mmHE_M119", "HE 105mm Ch.4 (12000m)", 350, "HE", []],
	["30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.1 (4000m)", 200, "smoke", []],
	["30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.2 (6000m)", 250, "smoke", []],
	["30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.3 (9000m)", 300, "smoke", []],
	["30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.4 (12000m)", 350, "smoke", []],
	["30Rnd_105mmHE_M119", "Cluster 105mm Ch.1 (4000m)", 200, "cluster", [50, "high", 75, 300]],
	["30Rnd_105mmHE_M119", "Cluster 105mm Ch.2 (6000m)", 250, "cluster", [50, "high", 75, 300]],
	["30Rnd_105mmHE_M119", "Cluster 105mm Ch.3 (9000m)", 300, "cluster", [50, "high", 75, 300]],
	["30Rnd_105mmHE_M119", "Cluster 105mm Ch.4 (12000m)", 350, "cluster", [50, "high", 75, 300]],
	
	["ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.1 (4000m)", 450, "HE", []],
	["ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.2 (6000m)", 900, "HE", []],
	["ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.3 (9000m)", 2800, "HE", []],
	["ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.4 (12000m)", 8500, "HE", []],
	["ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.1 (4000m)", 450, "smoke", []],
	["ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.2 (6000m)", 900, "smoke", []],
	["ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.3 (9000m)", 2800, "smoke", []],
	["ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.4 (12000m)", 8500, "smoke", []],
	["ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.1 (4000m)", 450, "cluster", [50, "high", 75, 300]],
	["ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.2 (6000m)", 900, "cluster", [50, "high", 75, 300]],
	["ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.3 (9000m)", 2800, "cluster", [50, "high", 75, 300]],
	["ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.4 (12000m)", 8500, "cluster", [50, "high", 75, 300]],
	
	["ACE_ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.1 (4000m)", 450, "HE", []],
	["ACE_ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.2 (6000m)", 900, "HE", []],
	["ACE_ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.3 (9000m)", 2800, "HE", []],
	["ACE_ARTY_30Rnd_105mmHE_M119", "HE 105mm Ch.4 (12000m)", 8500, "HE", []],
	["ACE_ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.1 (4000m)", 450, "smoke", []],
	["ACE_ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.2 (6000m)", 900, "smoke", []],
	["ACE_ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.3 (9000m)", 2800, "smoke", []],
	["ACE_ARTY_30Rnd_105mmSMOKE_M119", "Smoke 105mm Ch.4 (12000m)", 8500, "smoke", []],
	["ACE_ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.1 (4000m)", 450, "cluster", [50, "high", 75, 300]],
	["ACE_ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.2 (6000m)", 900, "cluster", [50, "high", 75, 300]],
	["ACE_ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.3 (9000m)", 2800, "cluster", [50, "high", 75, 300]],
	["ACE_ARTY_30Rnd_105mmHE_M119", "Cluster 105mm Ch.4 (12000m)", 8500, "cluster", [50, "high", 75, 300]],
	
	// D30 | OA/CO - A2 - ACE
	["30Rnd_122mmHE_D30", "HE 122mm Ch.1 (4000m)", 200, "HE", []],
	["30Rnd_122mmHE_D30", "HE 122mm Ch.2 (6000m)", 250, "HE", []],
	["30Rnd_122mmHE_D30", "HE 122mm Ch.3 (9000m)", 300, "HE", []],
	["30Rnd_122mmHE_D30", "HE 122mm Ch.4 (12000m)", 350, "HE", []],
	["30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.1 (4000m)", 200, "smoke", []],
	["30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.2 (6000m)", 250, "smoke", []],
	["30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.3 (9000m)", 300, "smoke", []],
	["30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.4 (12000m)", 350, "smoke", []],
	["30Rnd_122mmHE_D30", "Cluster 122mm Ch.1 (4000m)", 200, "cluster", [50, "high", 75, 300]],
	["30Rnd_122mmHE_D30", "Cluster 122mm Ch.2 (6000m)", 250, "cluster", [50, "high", 75, 300]],
	["30Rnd_122mmHE_D30", "Cluster 122mm Ch.3 (9000m)", 300, "cluster", [50, "high", 75, 300]],
	["30Rnd_122mmHE_D30", "Cluster 122mm Ch.4 (12000m)", 350, "cluster", [50, "high", 75, 300]],
	
	["ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.1 (4000m)", 450, "HE", []],
	["ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.2 (6000m)", 900, "HE", []],
	["ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.3 (9000m)", 2800, "HE", []],
	["ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.4 (12000m)", 8500, "HE", []],
	["ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.1 (4000m)", 450, "smoke", []],
	["ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.2 (6000m)", 900, "smoke", []],
	["ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.3 (9000m)", 2800, "smoke", []],
	["ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.4 (12000m)", 8500, "smoke", []],
	["ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.1 (4000m)", 450, "cluster", [50, "high", 75, 300]],
	["ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.2 (6000m)", 900, "cluster", [50, "high", 75, 300]],
	["ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.3 (9000m)", 2800, "cluster", [50, "high", 75, 300]],
	["ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.4 (12000m)", 8500, "cluster", [50, "high", 75, 300]],
	
	["ACE_ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.1 (4000m)", 450, "HE", []],
	["ACE_ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.2 (6000m)", 900, "HE", []],
	["ACE_ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.3 (9000m)", 2800, "HE", []],
	["ACE_ARTY_30Rnd_122mmHE_D30", "HE 122mm Ch.4 (12000m)", 8500, "HE", []],
	["ACE_ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.1 (4000m)", 450, "smoke", []],
	["ACE_ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.2 (6000m)", 900, "smoke", []],
	["ACE_ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.3 (9000m)", 2800, "smoke", []],
	["ACE_ARTY_30Rnd_122mmSMOKE_D30", "Smoke 122mm Ch.4 (12000m)", 8500, "smoke", []],
	["ACE_ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.1 (4000m)", 450, "cluster", [50, "high", 75, 300]],
	["ACE_ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.2 (6000m)", 900, "cluster", [50, "high", 75, 300]],
	["ACE_ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.3 (9000m)", 2800, "cluster", [50, "high", 75, 300]],
	["ACE_ARTY_30Rnd_122mmHE_D30", "Cluster 122mm Ch.4 (12000m)", 8500, "cluster", [50, "high", 75, 300]],
	
	// M252 | OA/CO - A2 - ACE
	["8Rnd_81mmHE_M252", "HE 81mm Ch.1 (1000m)", 100, "HE", []],
	["8Rnd_81mmHE_M252", "HE 81mm Ch.2 (2000m)", 150, "HE", []],
	["8Rnd_81mmHE_M252", "HE 81mm Ch.3 (4000m)", 200, "HE", []],
	["8Rnd_81mmHE_M252", "HE 81mm Ch.4 (6000m)", 250, "HE", []],
	["8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.1 (1000m)", 100, "smoke", []],
	["8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.2 (2000m)", 150, "smoke", []],
	["8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.3 (4000m)", 200, "smoke", []],
	["8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.4 (6000m)", 250, "smoke", []],
	["8Rnd_81mmHE_M252", "Cluster 81mm Ch.1 (1000m)", 100, "cluster", [25, "low", 50, 200]],
	["8Rnd_81mmHE_M252", "Cluster 81mm Ch.2 (2000m)", 150, "cluster", [25, "low", 50, 200]],
	["8Rnd_81mmHE_M252", "Cluster 81mm Ch.3 (4000m)", 200, "cluster", [25, "low", 50, 200]],
	["8Rnd_81mmHE_M252", "Cluster 81mm Ch.4 (6000m)", 250, "cluster", [25, "low", 50, 200]],
	
	["ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.1 (1000m)", 150, "HE", []],
	["ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.2 (2000m)", 250, "HE", []],
	["ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.3 (4000m)", 800, "HE", []],
	["ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.4 (6000m)", 2200, "HE", []],
	["ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.1 (1000m)", 150, "smoke", []],
	["ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.2 (2000m)", 250, "smoke", []],
	["ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.3 (4000m)", 800, "smoke", []],
	["ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.4 (6000m)", 2200, "smoke", []],
	["ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.1 (1000m)", 150, "cluster", [25, "low", 50, 200]],
	["ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.2 (2000m)", 250, "cluster", [25, "low", 50, 200]],
	["ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.3 (4000m)", 800, "cluster", [25, "low", 50, 200]],
	["ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.4 (6000m)", 2200, "cluster", [25, "low", 50, 200]],
	
	["ACE_ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.1 (1000m)", 150, "HE", []],
	["ACE_ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.2 (2000m)", 250, "HE", []],
	["ACE_ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.3 (4000m)", 800, "HE", []],
	["ACE_ARTY_8Rnd_81mmHE_M252", "HE 81mm Ch.4 (6000m)", 2200, "HE", []],
	["ACE_ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.1 (1000m)", 150, "smoke", []],
	["ACE_ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.2 (2000m)", 250, "smoke", []],
	["ACE_ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.3 (4000m)", 800, "smoke", []],
	["ACE_ARTY_8Rnd_81mmILLUM_M252", "Smoke 81mm Ch.4 (6000m)", 2200, "smoke", []],
	["ACE_ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.1 (1000m)", 150, "cluster", [25, "low", 50, 200]],
	["ACE_ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.2 (2000m)", 250, "cluster", [25, "low", 50, 200]],
	["ACE_ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.3 (4000m)", 800, "cluster", [25, "low", 50, 200]],
	["ACE_ARTY_8Rnd_81mmHE_M252", "Cluster 81mm Ch.4 (6000m)", 2200, "cluster", [25, "low", 50, 200]],
	
	// 2B14 | OA/CO - A2 - ACE
	["8Rnd_82mmHE_2B14", "HE 82mm Ch.1 (1000m)", 100, "HE", []],
	["8Rnd_82mmHE_2B14", "HE 82mm Ch.2 (2000m)", 150, "HE", []],
	["8Rnd_82mmHE_2B14", "HE 82mm Ch.3 (4000m)", 200, "HE", []],
	["8Rnd_82mmHE_2B14", "HE 82mm Ch.4 (6000m)", 250, "HE", []],
	["8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.1 (1000m)", 100, "smoke", []],
	["8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.2 (2000m)", 150, "smoke", []],
	["8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.3 (4000m)", 200, "smoke", []],
	["8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.4 (6000m)", 250, "smoke", []],
	["8Rnd_82mmHE_2B14", "Cluster 82mm Ch.1 (1000m)", 100, "cluster", [25, "low", 50, 200]],
	["8Rnd_82mmHE_2B14", "Cluster 82mm Ch.2 (2000m)", 150, "cluster", [25, "low", 50, 200]],
	["8Rnd_82mmHE_2B14", "Cluster 82mm Ch.3 (4000m)", 200, "cluster", [25, "low", 50, 200]],
	["8Rnd_82mmHE_2B14", "Cluster 82mm Ch.4 (6000m)", 250, "cluster", [25, "low", 50, 200]],
	
	["ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.1 (1000m)", 150, "HE", []],
	["ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.2 (2000m)", 250, "HE", []],
	["ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.3 (4000m)", 800, "HE", []],
	["ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.4 (6000m)", 2200, "HE", []],
	["ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.1 (1000m)", 150, "smoke", []],
	["ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.2 (2000m)", 250, "smoke", []],
	["ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.3 (4000m)", 800, "smoke", []],
	["ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.4 (6000m)", 2200, "smoke", []],
	["ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.1 (1000m)", 150, "cluster", [25, "low", 50, 200]],
	["ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.2 (2000m)", 250, "cluster", [25, "low", 50, 200]],
	["ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.3 (4000m)", 800, "cluster", [25, "low", 50, 200]],
	["ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.4 (6000m)", 2200, "cluster", [25, "low", 50, 200]],
	
	["ACE_ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.1 (1000m)", 150, "HE", []],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.2 (2000m)", 250, "HE", []],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.3 (4000m)", 800, "HE", []],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "HE 82mm Ch.4 (6000m)", 2200, "HE", []],
	["ACE_ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.1 (1000m)", 150, "smoke", []],
	["ACE_ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.2 (2000m)", 250, "smoke", []],
	["ACE_ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.3 (4000m)", 800, "smoke", []],
	["ACE_ARTY_8Rnd_82mmILLUM_2B14", "Smoke 82mm Ch.4 (6000m)", 2200, "smoke", []],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.1 (1000m)", 150, "cluster", [25, "low", 50, 200]],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.2 (2000m)", 250, "cluster", [25, "low", 50, 200]],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.3 (4000m)", 800, "cluster", [25, "low", 50, 200]],
	["ACE_ARTY_8Rnd_82mmHE_2B14", "Cluster 82mm Ch.4 (6000m)", 2200, "cluster", [25, "low", 50, 200]],
	
	// M1129 Stryker MC | OA/CO/ACE
	["24Rnd_120mmHE_M120_02", "HE 120mm Ch.1 (1000m)", 100, "HE", []],
	["24Rnd_120mmHE_M120_02", "HE 120mm Ch.2 (2000m)", 150, "HE", []],
	["24Rnd_120mmHE_M120_02", "HE 120mm Ch.3 (4000m)", 200, "HE", []],
	["24Rnd_120mmHE_M120_02", "HE 120mm Ch.4 (6000m)", 250, "HE", []],
	["24Rnd_120mmHE_M120_02", "Cluster 120mm Ch.1 (1000m)", 100, "cluster", [35, "low", 60, 250]],
	["24Rnd_120mmHE_M120_02", "Cluster 120mm Ch.2 (2000m)", 150, "cluster", [35, "low", 60, 250]],
	["24Rnd_120mmHE_M120_02", "Cluster 120mm Ch.3 (4000m)", 200, "cluster", [35, "low", 60, 250]],
	["24Rnd_120mmHE_M120_02", "Cluster 120mm Ch.4 (6000m)", 250, "cluster", [35, "low", 60, 250]],
	
	// MLRS | OA/CO - ACE
	["12Rnd_MLRS", "HE M26 Ch.1 (6000m)", 250, "HE", []],
	["12Rnd_MLRS", "HE M26 Ch.2 (9000m)", 300, "HE", []],
	["12Rnd_MLRS", "HE M26 Ch.3 (12000m)", 350, "HE", []],
	["12Rnd_MLRS", "HE M26 Ch.4 (16000m)", 400, "HE", []],
	["12Rnd_MLRS", "Cluster M26 Ch.1 (6000m)", 250, "cluster", [50, "high", 75, 300]],
	["12Rnd_MLRS", "Cluster M26 Ch.2 (9000m)", 300, "cluster", [50, "high", 75, 300]],
	["12Rnd_MLRS", "Cluster M26 Ch.3 (12000m)", 350, "cluster", [50, "high", 75, 300]],
	["12Rnd_MLRS", "Cluster M26 Ch.4 (16000m)", 400, "cluster", [50, "high", 75, 300]],
	
	//["ACE_ARTY_12Rnd_227mmHE_M270", "M26 HE Ch.1 (6000m)", 250, "HE", []], // ACE currently don't work (ACE_ARTY_ReplaceWithAmmo)
	//["ACE_ARTY_12Rnd_227mmHE_M270", "M26 HE Ch.2 (9000m)", 300, "HE", []],
	//["ACE_ARTY_12Rnd_227mmHE_M270", "M26 HE Ch.3 (12000m)", 350, "HE", []],
	//["ACE_ARTY_12Rnd_227mmHE_M270", "M26 HE Ch.4 (16000m)", 400, "HE", []],
	
	// BM-21 Grad | OA/CO - ACE
	["40Rnd_GRAD", "HE 9M22U Ch.1 (6000m)", 250, "HE", []],
	["40Rnd_GRAD", "HE 9M22U Ch.2 (9000m)", 300, "HE", []],
	["40Rnd_GRAD", "HE 9M22U Ch.3 (12000m)", 350, "HE", []],
	["40Rnd_GRAD", "HE 9M22U Ch.4 (16000m)", 400, "HE", []],
	["40Rnd_GRAD", "Cluster 9M22U Ch.1 (6000m)", 250, "cluster", [50, "high", 75, 300]],
	["40Rnd_GRAD", "Cluster 9M22U Ch.2 (9000m)", 300, "cluster", [50, "high", 75, 300]],
	["40Rnd_GRAD", "Cluster 9M22U Ch.3 (12000m)", 350, "cluster", [50, "high", 75, 300]],
	["40Rnd_GRAD", "Cluster 9M22U Ch.4 (16000m)", 400, "cluster", [50, "high", 75, 300]],
	
	//["ACE_ARTY_40Rnd_120mmHE_BM21", "9M22U HE Ch.1 (6000m)", 250, "HE", []], // ACE currently don't work (ACE_ARTY_ReplaceWithAmmo)
	//["ACE_ARTY_40Rnd_120mmHE_BM21", "9M22U HE Ch.2 (9000m)", 300, "HE", []],
	//["ACE_ARTY_40Rnd_120mmHE_BM21", "9M22U HE Ch.3 (12000m)", 350, "HE", []],
	//["ACE_ARTY_40Rnd_120mmHE_BM21", "9M22U HE Ch.4 (16000m)", 400, "HE", []],
	
	// vilas' M109 | A2/OA/CO/ACE
	["vil_PALmag_HE", "HE 155mm Ch.1 (4000m)", 450, "HE", []],
	["vil_PALmag_HE", "HE 155mm Ch.2 (6000m)", 900, "HE", []],
	["vil_PALmag_HE", "HE 155mm Ch.3 (9000m)", 2800, "HE", []],
	["vil_PALmag_HE", "HE 155mm Ch.4 (12000m)", 8500, "HE", []],
	["vil_PALmag_HE", "Cluster 155mm Ch.1 (4000m)", 450, "cluster", [50, "high", 75, 300]],
	["vil_PALmag_HE", "Cluster 155mm Ch.2 (6000m)", 900, "cluster", [50, "high", 75, 300]],
	["vil_PALmag_HE", "Cluster 155mm Ch.3 (9000m)", 2800, "cluster", [50, "high", 75, 300]],
	["vil_PALmag_HE", "Cluster 155mm Ch.4 (12000m)", 8500, "cluster", [50, "high", 75, 300]]
];