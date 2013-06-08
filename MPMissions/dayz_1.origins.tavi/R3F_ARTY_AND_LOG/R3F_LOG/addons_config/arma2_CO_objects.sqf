/**
 * English and French comments
 * Commentaires anglais et français
 * 
 * This file adds the ArmA 2 and Arrowhead objetcs in the configuration variables of the logistics system.
 * Fichier ajoutant les objets d'ArmA 2 et Arrowhead dans la configuration du système de logistique.
 * 
 * Important note : All the classes names which inherits from the ones used in configuration variables will be also available.
 * Note importante : Tous les noms de classes dérivant de celles utilisées dans les variables de configuration seront aussi valables.
 */

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of vehicles which can tow towable objects.
 * Liste des noms de classes des véhicules terrestres pouvant remorquer des objets remorquables.
 */
R3F_LOG_CFG_remorqueurs = R3F_LOG_CFG_remorqueurs +
[
	"TowingTractor",
	"HMMWV_Ambulance_DZ",
	"Tractor",
	"Kamaz_Base",
	"MTVR",
	"GRAD_Base",
	"Ural_Base",
	"V3S_Base",
	"BRDM2_Base",
	"BTR90_Base",
	"GAZ_Vodnik_HMG",
	"LAV25_Base",
	"StrykerBase_EP1",
	"M2A2_Base",
	"HMMWV_Ambulance",
	"MLRS",
	"HMMWV_M2",
	"HMMWV_M2_DZ"
];

/**
 * List of class names of towables objects.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_objets_remorquables = R3F_LOG_CFG_objets_remorquables +
[
	"M119",
	"HMMWV_Ambulance_DZ",
	"HMMWV_Ambulance",
	"D30_base",
	"ZU23_base",
	"HMMWV_M2",
	"HMMWV_M2_DZ"
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of air vehicles which can lift liftable objects.
 * Liste des noms de classes des véhicules aériens pouvant héliporter des objets héliportables.
 */
R3F_LOG_CFG_heliporteurs = R3F_LOG_CFG_heliporteurs +
[
	"CH_47F_EP1",
	"CH_47F_BAF",
	"CH47_DZ",
	"Mi17_base",
	"Mi24_Base",
	"UH1H_base",
	"UH1_Base",
	"UH60_Base",
	"MV22",
	"MV22_DZ",
	"MH6J_DZ",
	"UH1H_DZ"
];

/**
 * List of class names of liftable objects.
 * Liste des noms de classes des objets héliportables.
 */
R3F_LOG_CFG_objets_heliportables = R3F_LOG_CFG_objets_heliportables +
[
	"ReammoBox",
	"ATV_Base_EP1",
	"HMMWV_Ambulance",
	"HMMWV_Ambulance_DZ",
	"Ikarus_TK_CIV_EP1",
	"Lada_base",
	"LandRover_Base",
	"Offroad_DSHKM_base",
	"Pickup_PK_base",
	"S1203_TK_CIV_EP1",
	"SUV_Base_EP1",
	"SkodaBase",
	"TowingTractor",
	"Tractor",
	"Kamaz_Base",
	"MTVR",
	"GRAD_Base",
	"Ural_Base",
	"Ural_ZU23_Base",
	"V3S_Base",
	"UAZ_Base",
	"VWGolf",
	"Volha_TK_CIV_Base_EP1",
	"BTR40_MG_base_EP1",
	"hilux1_civil_1_open",
	"hilux1_civil_3_open_EP1",
	"D30_base",
	"M119",
	"ZU23_base",
	"Boat",
	"Fishing_Boat",
	"SeaFox",
	"Smallboat_1",
	"Land_Misc_Cargo1A_EP1",
	"Land_Misc_Cargo1B",
	"Land_Misc_Cargo1B_EP1",
	"Land_Misc_Cargo1C",
	"Land_Misc_Cargo1C_EP1",
	"Land_Misc_Cargo1D",
	"Land_Misc_Cargo1D_EP1",
	"Land_Misc_Cargo1E",
	"Land_Misc_Cargo1E_EP1",
	"Land_Misc_Cargo1F",
	"Land_Misc_Cargo1G",
	"Land_Misc_Cargo2A_EP1",
	"Land_Misc_Cargo2B",
	"Land_Misc_Cargo2B_EP1",
	"Land_Misc_Cargo2C",
	"Land_Misc_Cargo2C_EP1",
	"Land_Misc_Cargo2D",
	"Land_Misc_Cargo2D_EP1",
	"Land_Misc_Cargo2E",
	"Land_Misc_Cargo2E_EP1",
	"Base_WarfareBContructionSite",
	"Misc_cargo_cont_net1",
	"Misc_cargo_cont_net2",
	"Misc_cargo_cont_net3",
	"Misc_cargo_cont_small",
	"Misc_cargo_cont_small2",
	"HMMWV_M2",
	"HMMWV_M2_DZ",
	"Misc_cargo_cont_tiny"
];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USSpecialWeaponsBox "weights" 5 units.
 * 
 * Cette section utilise une quantification du volume et/ou poids des objets.
 * Le référentiel arbitraire utilisé est : une caisse de munition de type USSpecialWeaponsBox "pèse" 5 unités.
 * 
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 * 
 * Note : la priorité d'une déclaration de capacité sur une autre correspond à leur ordre dans les tableaux.
 *   Par exemple : la classe "Truck" appartient à la classe "Car" (voir http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   Si "Truck" est déclaré avec une capacité de 140 avant "Car". Et que "Car" est déclaré après "Truck" avec une capacité de 40,
 *   Alors toutes les sous-classes appartenant à "Truck" auront une capacité de 140. Et toutes les sous-classes appartenant
 *   à "Car", exceptées celles de "Truck", auront une capacité de 40.
 */

/**
 * List of class names of (ground or air) vehicles which can transport transportable objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 * 
 * Liste des noms de classes des véhicules (terrestres ou aériens) pouvant transporter des objets transportables.
 * Le deuxième élément des tableaux est la capacité de chargement (en relation avec le coût de capacité des objets).
 */
R3F_LOG_CFG_transporteurs = R3F_LOG_CFG_transporteurs +
[
	["CH_47F_EP1", 80],
	["CH_47F_BAF", 80],
	["CH47_DZ", 80],
	["AH6_Base_EP1", 25],
	["Mi17_base", 60],
	["Mi24_Base", 50],
	["UH1H_base", 35],
	["UH1_Base", 30],
	["UH60_Base", 40],
	["An2_Base_EP1", 40],
	["C130J", 150],
	["MV22", 80],
	["ATV_Base_EP1", 5],
	["HMMWV_Avenger", 5],
	["HMMWV_M998A2_SOV_DES_EP1", 12],
	["HMMWV_Base", 18],
	["Ikarus", 50],
	["Lada_base", 10],
	["LandRover_Base", 15],
	["Offroad_DSHKM_base", 15],
	["Pickup_PK_base", 15],
	["S1203_TK_CIV_EP1", 20],
	["SUV_Base_EP1", 15],
	["SkodaBase", 10],
	["TowingTractor", 5],
	["Tractor", 5],
	["KamazRefuel", 10],
	["Kamaz", 50],
	["Kamaz_Base", 35],
	["MAZ_543_SCUD_Base_EP1", 10],
	["MtvrReammo", 35],
	["MtvrRepair", 35],
	["MtvrRefuel", 10],
	["MTVR", 50],
	["GRAD_Base", 10],
	["Ural_ZU23_Base", 12],
	["Ural_CDF", 50],
	["Ural_INS", 50],
	["UralRefuel_Base", 10],
	["Ural_Base", 35],
	["V3S_Refuel_TK_GUE_EP1", 10],
	["V3S_Civ", 35],
	["V3S_Base_EP1", 50],
	["UAZ_Base", 10],
	["VWGolf", 8],
	["Volha_TK_CIV_Base_EP1", 8],
	["BRDM2_Base", 15],
	["BTR40_MG_base_EP1", 15],
	["BTR90_Base", 25],
	["GAZ_Vodnik_HMG", 25],
	["LAV25_Base", 25],
	["StrykerBase_EP1", 25],
	["hilux1_civil_1_open", 12],
	["hilux1_civil_3_open_EP1", 12],
	["Motorcycle", 3],
	["2S6M_Tunguska", 10],
	["M113_Base", 12],
	["M1A1", 5],
	["M2A2_Base", 15],
	["MLRS", 8],
	["T34", 5],
	["T55_Base", 5],
	["T72_Base", 5],
	["T90", 5],
	["AAV", 12],
	["BMP2_Base", 7],
	["BMP3", 7],
	["ZSU_Base", 5],
	["RHIB", 10],
	["RubberBoat", 5],
	["Fishing_Boat", 10],
	["SeaFox", 5],
	["Smallboat_1", 8],
	["Fort_Crate_wood", 5],
	["Land_Misc_Cargo1A_EP1", 100],
	["Land_Misc_Cargo1B", 100],
	["Misc_Cargo1B_military", 100],
	["Land_Misc_Cargo1B_EP1", 100],
	["Land_Misc_Cargo1C", 100],
	["Land_Misc_Cargo1C_EP1", 100],
	["Land_Misc_Cargo1D", 100],
	["Land_Misc_Cargo1D_EP1", 100],
	["Land_Misc_Cargo1E", 100],
	["Land_Misc_Cargo1E_EP1", 100],
	["Land_Misc_Cargo1F", 100],
	["Land_Misc_Cargo1G", 100],
	["Land_Misc_Cargo2A_EP1", 200],
	["Land_Misc_Cargo2B", 200],
	["Land_Misc_Cargo2B_EP1", 200],
	["Land_Misc_Cargo2C", 200],
	["Land_Misc_Cargo2C_EP1", 200],
	["Land_Misc_Cargo2D", 200],
	["Land_Misc_Cargo2D_EP1", 200],
	["Land_Misc_Cargo2E", 200],
	["Land_Misc_Cargo2E_EP1", 200],
	["Base_WarfareBContructionSite", 100],
	["Misc_cargo_cont_net1", 18],
	["Misc_cargo_cont_net2", 36],
	["Misc_cargo_cont_net3", 60],
	["Misc_cargo_cont_small", 50],
	["Misc_cargo_cont_small2", 40],
	["Misc_cargo_cont_tiny", 35],
	["HMMWV_Ambulance_DZ", 40],
	["HMMWV_M2", 30],
	["HMMWV_M2_DZ", 20]
	
];

/**
 * List of class names of transportable objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 * 
 * Liste des noms de classes des objets transportables.
 * Le deuxième élément des tableaux est le coût de capacité (en relation avec la capacité des véhicules).
 */
R3F_LOG_CFG_objets_transportables = R3F_LOG_CFG_objets_transportables +
[
	["SatPhone", 1], // Needed for the R3F_ARTY module (arty HQ) (nécessaire pour le module R3F_ARTY (PC d'arti))
	["Pchela1T", 15],
	["ATV_Base_EP1", 20],
	["FoldChair_with_Cargo", 1],
	["MMT_base", 1],
	["Old_bike_base_EP1", 1],
	["M1030", 5],
	["Old_moto_base", 5],
	["TT650_Base", 5],
	["Igla_AA_pod_East", 7],
	["Stinger_Pod_base", 7],
	["Metis", 4],
	["SPG9_base", 4],
	["TOW_TriPod", 5],
	["TOW_TriPod_Base", 5],
	["AGS_base", 4],
	["MK19_TriPod", 4],
	["DSHKM_base", 4],
	["KORD_Base", 5],
	["M2StaticMG_base", 4],
	["WarfareBMGNest_M240_base", 10],
	["WarfareBMGNest_PK_Base", 10],
	["2b14_82mm", 4],
	["M252", 4],
	["Warfare2b14_82mm_Base", 4],
	["StaticSEARCHLight", 4],
	["FlagCarrierSmall", 1],
	["Fort_Crate_wood", 2],
	["Fort_RazorWire", 2],
	["Gunrack1", 3],
	["Base_WarfareBBarrier10xTall", 10],
	["Base_WarfareBBarrier10x", 7],
	["Base_WarfareBBarrier5x", 5],
	["Fort_EnvelopeBig", 1],
	["Fort_EnvelopeSmall", 1],
	["Land_A_tent", 2],
	["Land_Antenna", 4],
	["Land_Fire_barrel", 1],
	["Land_GuardShed", 3],
	["Land_Misc_Cargo1A_EP1", 110],
	["Land_Misc_Cargo1B", 110],
	["Misc_Cargo1B_military", 110],
	["Land_Misc_Cargo1B_EP1", 110],
	["Land_Misc_Cargo1C", 110],
	["Land_Misc_Cargo1C_EP1", 110],
	["Land_Misc_Cargo1D", 110],
	["Land_Misc_Cargo1D_EP1", 110],
	["Land_Misc_Cargo1E", 110],
	["Land_Misc_Cargo1E_EP1", 110],
	["Land_Misc_Cargo1F", 110],
	["Land_Misc_Cargo1G", 110],
	["Land_Misc_Cargo2A_EP1", 220],
	["Land_Misc_Cargo2B", 220],
	["Land_Misc_Cargo2B_EP1", 220],
	["Land_Misc_Cargo2C", 220],
	["Land_Misc_Cargo2C_EP1", 220],
	["Land_Misc_Cargo2D", 220],
	["Land_Misc_Cargo2D_EP1", 220],
	["Land_Misc_Cargo2E", 220],
	["Land_Misc_Cargo2E_EP1", 220],
	["Land_fort_bagfence_corner", 2],
	["Land_fort_bagfence_long", 2],
	["Land_fort_bagfence_round", 3],
	["Land_fortified_nest_small", 6],
	["Land_tent_east", 6],
	["Land_BagFenceCorner", 2],
	["Land_HBarrier_large", 3],
	["Land_Toilet", 3],
	["RoadBarrier_light", 2],
	["WarfareBunkerSign", 1],
	["Base_WarfareBContructionSite", 110],
	["ACamp", 3],
	["Camp", 5],
	["CampEast", 6],
	["MASH", 5],
	["FlagCarrier", 1],
	["FlagCarrierChecked", 1],
	["Hedgehog", 3],
	["AmmoCrate_NoInteractive_Base_EP1", 5],
	["Misc_cargo_cont_net1", 40],
	["Misc_cargo_cont_net2", 50],
	["Misc_cargo_cont_net3", 100],
	["Misc_cargo_cont_small", 55],
	["Misc_cargo_cont_small2", 50],
	["Misc_cargo_cont_tiny", 40],
	["RUVehicleBox", 12],
	["TKVehicleBox_EP1", 12],
	["USVehicleBox_EP1", 12],
	["USVehicleBox", 12],
	["ReammoBox", 5],
	["TargetE", 2],
	["TargetEpopup", 2],
	["TargetPopUpTarget", 2],
	["Desk", 1],
	["FoldChair", 1],
	["FoldTable", 1],
	["Land_Barrel_empty", 1],
	["Land_Barrel_sand", 1],
	["Land_Barrel_water", 1],
	["Land_arrows_yellow_L", 1],
	["Land_arrows_yellow_R", 1],
	["Land_coneLight", 1],
	["BarrelBase", 2],
	["Fuel_can", 1],
	["Notice_board", 1],
	["Pallets_comlumn", 1],
	["Unwrapped_sleeping_bag", 1],
	["Wheel_barrow", 1],
	["RoadCone", 1],
	["Sign_1L_Border", 1],
	["Sign_Danger", 1],
	["SmallTable", 1],
	["EvPhoto", 1],
	["MetalBucket", 1],
	["Notebook", 1],
	["Radio", 1],
	["SmallTV", 1],
	["Land_Chair_EP1", 1],
	["Suitcase", 1],
	["HMMWV_Ambulance_DZ", 30],
	["HMMWV_Ambulance", 40],
	["WeaponBagBase_EP1", 3],
	["HMMWV_M2", 30],
	["HMMWV_M2_DZ", 20]
];


/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects moveable by player.
 * Liste des noms de classes des objets transportables par le joueur.
 */
R3F_LOG_CFG_objets_deplacables = R3F_LOG_CFG_objets_deplacables +
[
	"SatPhone", // Needed for the R3F_ARTY module (arty HQ) (nécessaire pour le module R3F_ARTY (PC d'arti))
	"FoldChair_with_Cargo",
	"StaticWeapon",
	"FlagCarrierSmall",
	"Fort_Crate_wood",
	"Fort_RazorWire",
	"Gunrack1",
	"Base_WarfareBBarrier5x",
	"Fort_EnvelopeBig",
	"Fort_EnvelopeSmall",
	"Land_A_tent",
	"Land_Antenna",
	"Land_Fire_barrel",
	"Land_GuardShed",
	"Land_fort_bagfence_corner",
	"Land_fort_bagfence_long",
	"Land_fort_bagfence_round",
	"Land_fortified_nest_small",
	"Land_tent_east",
	"Land_HBarrier_large",
	"Land_Toilet",
	"RoadBarrier_light",
	"WarfareBunkerSign",
	"ACamp",
	"Camp",
	"CampEast",
	"MASH",
	"FlagCarrier",
	"FlagCarrierChecked",
	"Hedgehog",
	"AmmoCrate_NoInteractive_Base_EP1",
	"ReammoBox",
	"TargetE",
	"TargetEpopup",
	"TargetPopUpTarget",
	"Desk",
	"FoldChair",
	"FoldTable",
	"Land_Barrel_empty",
	"Land_Barrel_sand",
	"Land_Barrel_water",
	"Land_arrows_yellow_L",
	"Land_arrows_yellow_R",
	"Land_coneLight",
	"BarrelBase",
	"Fuel_can",
	"Notice_board",
	"Pallets_comlumn",
	"Unwrapped_sleeping_bag",
	"Wheel_barrow",
	"RoadCone",
	"Sign_1L_Border",
	"Sign_Danger",
	"SmallTable",
	"EvPhoto",
	"MetalBucket",
	"Notebook",
	"Radio",
	"SmallTV",
	"Land_Chair_EP1",
	"Suitcase",
	"WeaponBagBase_EP1"
];