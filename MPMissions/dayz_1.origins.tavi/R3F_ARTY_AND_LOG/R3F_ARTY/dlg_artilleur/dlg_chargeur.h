/**
 * Interface remplaçant les informations sur le chargeur courant
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

class R3F_ARTY_dlg_chargeur
{
	idd = R3F_ARTY_IDD_dlg_chargeur;
	name = "R3F_ARTY_dlg_chargeur";
	onLoad = "uiNamespace setVariable [""R3F_ARTY_dlg_chargeur"", _this select 0]; [""defaut""] spawn R3F_ARTY_FNCT_afficher_chargeur;";
	duration = 100000;
	fadein = 0;
	fadeout = 0;
	movingEnable = false;
	
	controlsBackground[] = {
		R3F_ARTY_dlg_chargeur_arriere_plan_chargeur,
		R3F_ARTY_dlg_chargeur_arriere_plan_chargeur2,
		R3F_ARTY_dlg_chargeur_arriere_plan_chargeur3
	};
	objects[] = {};
	controls[] =
	{
		R3F_ARTY_dlg_chargeur_label_chargeur,
		R3F_ARTY_dlg_chargeur_valeur_chargeur,
		R3F_ARTY_dlg_chargeur_label_nb_mun,
		R3F_ARTY_dlg_chargeur_valeur_nb_mun
	};
	
	class R3F_ARTY_dlg_chargeur_texte_basique
	{
		idc = -1;
		type = CT_STATIC;
		style = ST_LEFT;
		colorText[] = {0.15, 0.16, 0.12, 1};
		colorBackground[] = {0.40, 0.43, 0.28, 1};
		font = "BitStream";
		sizeEx = 0.028;
		h = 0.028;
		text = "";
	};
	
	// DEBUT boîte d'info du chargeur
	class R3F_ARTY_dlg_chargeur_arriere_plan_chargeur : R3F_ARTY_dlg_chargeur_texte_basique
	{
		style = ST_PICTURE;
		x = (safeZoneW + safeZoneX)-0.35; w = 0.75;
		y = safeZoneY - 0.02; h = 0.30;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "\ca\ui\data\ui_messagebox_bottom_ca.paa";
	};
	class R3F_ARTY_dlg_chargeur_arriere_plan_chargeur2 : R3F_ARTY_dlg_chargeur_texte_basique
	{
		style = ST_PICTURE;
		x = (safeZoneW + safeZoneX)-0.35; w = 0.75;
		y = safeZoneY - 0.02; h = 0.30;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "\ca\ui\data\ui_messagebox_bottom_ca.paa";
	};
	class R3F_ARTY_dlg_chargeur_arriere_plan_chargeur3 : R3F_ARTY_dlg_chargeur_texte_basique
	{
		style = ST_PICTURE;
		x = (safeZoneW + safeZoneX)-0.35; w = 0.75;
		y = safeZoneY - 0.02; h = 0.30;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		text = "\ca\ui\data\ui_messagebox_bottom_ca.paa";
	};
	
	class R3F_ARTY_dlg_chargeur_label_chargeur : R3F_ARTY_dlg_chargeur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_chargeur_label_chargeur;
		style = ST_RIGHT;
		x = (safeZoneW + safeZoneX)-0.34; w = 0.08;
		y = safeZoneY + 0.022;
		colorBackground[] = {0,0,0,0};
		colorText[] = {0.55, 0.80, 0.45, 1};
		text = "";
	};
	
	class R3F_ARTY_dlg_chargeur_valeur_chargeur : R3F_ARTY_dlg_chargeur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_chargeur_valeur_chargeur;
		x = (safeZoneW + safeZoneX)-0.26; w = 0.25;
		y = safeZoneY + 0.022;
		text = "";
		colorBackground[] = {0,0,0,0};
		colorText[] = {0.55, 0.80, 0.45, 1};
	};
	
	class R3F_ARTY_dlg_chargeur_label_nb_mun : R3F_ARTY_dlg_chargeur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_chargeur_label_nb_mun;
		style = ST_RIGHT;
		x = (safeZoneW + safeZoneX)-0.34; w = 0.08;
		y = safeZoneY + 0.052;
		colorBackground[] = {0,0,0,0};
		colorText[] = {0.55, 0.80, 0.45, 1};
		text = "";
	};
	
	class R3F_ARTY_dlg_chargeur_valeur_nb_mun : R3F_ARTY_dlg_chargeur_texte_basique
	{
		idc = R3F_ARTY_IDC_dlg_chargeur_valeur_nb_mun;
		x = (safeZoneW + safeZoneX)-0.26; w = 0.25;
		y = safeZoneY + 0.052;
		colorBackground[] = {0,0,0,0};
		colorText[] = {0.55, 0.80, 0.45, 1};
		text = "";
	};
	// FIN boîte d'info du chargeur
};