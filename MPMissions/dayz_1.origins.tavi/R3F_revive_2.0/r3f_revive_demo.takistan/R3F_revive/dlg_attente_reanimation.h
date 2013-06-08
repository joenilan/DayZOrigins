/**
 * Boîte de dialogue affichant le bouton de réapparition au camp
 * 
 * Copyright (C) 2011 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

class R3F_REV_dlg_attente_reanimation
{
	idd = 89453;
	
	// Masquer le bouton reapparaitre_camp si l'option n'est pas activée
	onLoad = "if !(R3F_REV_CFG_autoriser_reapparaitre_camp) then {_this select 0 displayCtrl 89454 ctrlShow false;} else {_this select 0 displayCtrl 89454 ctrlSetText STR_R3F_REV_btn_reapparition};";
	
	// Si on ferme la fenêtre avec échap, on la rouvre un peu plus tard (on laisse le temps de quitter la partie si voulu, sinon on remet le menu)
	onKeyDown = "if (_this select 1 == 1) then {call R3F_REV_FNCT_detruire_marqueur_inconscient; [] spawn {sleep 8; if (player getVariable ""R3F_REV_est_inconscient"" && isNull (findDisplay 89453)) then {call R3F_REV_FNCT_detruire_marqueur_inconscient; call R3F_REV_FNCT_creer_marqueur_inconscient; createDialog ""R3F_REV_dlg_attente_reanimation"";};};}; false";
	
	controlsBackground[] = {};
	objects[] = {};
	controls[] =
	{
		R3F_REV_dlg_AR_btn_focus,
		R3F_REV_dlg_AR_btn_reapparaitre_camp
	};
	
	// Bouton invisible capturant le focus, afin d'éviter que les touches entrée et espace active par accident le respawn au camp
	class R3F_REV_dlg_AR_btn_focus
	{
		idc = -1;
		
		type = 1;
		style = 0x02;
		w = 0.0; x = 0.0;
		h = 0.0; y = 0.0;
		text = "";
		action = "";
		colorText[] = {0.0, 0.0, 0.0, 0.0};
		font = "BitStream";
		sizeEx = 0.0;
		colorBackground[] = {0.0, 0.0, 0.0, 0.0};
		colorFocused[] = {0.0, 0.0, 0.0, 0.0};
		colorDisabled[] = {0.0, 0.0, 0.0, 0.0};
		colorBackgroundDisabled[] = {0.0, 0.0, 0.0, 0.0};
		colorBackgroundActive[] = {0.0, 0.0, 0.0, 0.0};
		offsetX = 0.0;
		offsetY = 0.0;
		offsetPressedX = 0.0;
		offsetPressedY = 0.0;
		colorShadow[] = {0.0, 0.0, 0.0, 0.0};
		colorBorder[] = {0.0, 0.0, 0.0, 0.0};
		borderSize = 0.0;
		soundEnter[] = {"", 0.0, 1.0};
		soundPush[] = {"", 0.1, 1.0};
		soundClick[] = {"", 0.0, 1.0};
		soundEscape[] = {"", 0.0, 1.0};
	};
	
	class R3F_REV_dlg_AR_btn_reapparaitre_camp
	{
		idc = 89454;
		
		type = 1;
		style = 0x02;
		w = 0.27; x = 0.73;
		h = 0.05; y = 0.9;
		text = "Respawn at camp";
		action = "[] spawn R3F_REV_FNCT_reapparaitre_camp;";
		colorText[] = {0.65, 0.89, 0.52, 1.0};
		font = "BitStream";
		sizeEx = 0.035;
		colorBackground[] = {0.3, 0.4, 0.3, 1.0};
		colorFocused[] = {1.0, 0.0, 0.0, 1.0};
		colorDisabled[] = {0.5, 0.5, 0.5, 0.7};
		colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.7};
		colorBackgroundActive[] = {0.5, 0.6, 0.5, 1.0};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0.0, 0.0, 0.0, 0.5};
		colorBorder[] = {0.0, 0.0, 0.0, 1.0};
		borderSize = 0.0;
		soundEnter[] = {"", 0.0, 1.0};
		soundPush[] = {"", 0.1, 1.0};
		soundClick[] = {"", 0.0, 1.0};
		soundEscape[] = {"", 0.0, 1.0};
	};
};