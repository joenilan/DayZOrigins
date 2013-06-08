/**
 * Réanimer un joueur inconscient
 * 
 * @param 0 l'unité à réanimer
 * 
 * Copyright (C) 2011 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_blesse", "_joueur", "_i"];

_blesse = _this select 0;
_joueur = player;

_blesse setVariable ["R3F_REV_est_pris_en_charge_par", _joueur, true];

// Animations de soins
_joueur attachTo [_blesse, [-0.666, 0.222, 0]];
_joueur setDir 90;
_joueur playMoveNow "AinvPknlMstpSnonWrflDnon_medic";

R3F_REV_code_distant = [_blesse, "playMoveNow", "AinjPpneMstpSnonWrflDnon_rolltoback"];
publicVariable "R3F_REV_code_distant";
["R3F_REV_code_distant", R3F_REV_code_distant] spawn R3F_REV_FNCT_code_distant;

sleep 1.5;
// Le joueur joue une animation de soin aléatoire
if (!isNull _joueur && alive _joueur && !isNull _blesse && alive _blesse) then
{
	_joueur playMove format ["AinvPknlMstpSnonWrflDnon_medic%1", floor random 6];
};

// Attente 12 secondes tant qu'aucun incident ne survient
for [{_i = 0}, {_i < 12 && !isNull _joueur && alive _joueur && !isNull _blesse && alive _blesse}, {_i = _i + 1}] do
{sleep 1;};

if !(isNull _blesse) then
{
	// Si le joueur qui réanime et le blessé ne sont pas morts durant les soins
	if (!isNull _joueur && alive _joueur && alive _blesse) then
	{
		// Validation la réanimation
		R3F_REV_fin_inconscience = _blesse;
		publicVariable "R3F_REV_fin_inconscience";
		["R3F_REV_fin_inconscience", R3F_REV_fin_inconscience] spawn R3F_REV_FNCT_fin_inconscience;
		_blesse setVariable ["R3F_REV_est_inconscient", false, true];
		
		// Remise sur le ventre et reprise de l'arme
		R3F_REV_code_distant = [_blesse, "playMoveNow", "AmovPpneMstpSrasWrflDnon"];
		publicVariable "R3F_REV_code_distant";
		["R3F_REV_code_distant", R3F_REV_code_distant] spawn R3F_REV_FNCT_code_distant;
	};
	
	_blesse setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];
};

// Fin des soins
if !(isNull _joueur) then
{
	if (alive _joueur) then
	{
		_joueur playMoveNow "AinvPknlMstpSnonWrflDnon_medicEnd";
		sleep 1;
	};
	detach _joueur;
};