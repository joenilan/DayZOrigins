/**
 * Traîne le corps d'un joueur inconscient
 * 
 * @param 0 l'unité à traîner
 * 
 * Copyright (C) 2011 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_blesse", "_joueur", "_id_action"];

_blesse = _this select 0;
_joueur = player;

_blesse setVariable ["R3F_REV_est_pris_en_charge_par", _joueur, true];
R3F_REV_demande_relacher_corps = false;
_id_action = _joueur addAction [STR_R3F_REV_action_relacher_corps, "R3F_revive\relacher_corps.sqf", _blesse, 10, false, true, "", ""];

// Le blessé est attaché au joueur
_blesse attachTo [_joueur, [0, 1.1, 0.092]];
R3F_REV_code_distant = [_blesse, "setDir", 180];
publicVariable "R3F_REV_code_distant";
["R3F_REV_code_distant", R3F_REV_code_distant] spawn R3F_REV_FNCT_code_distant;

// Le joueur tire le blessé par la poignée de son gilet
_joueur playMoveNow "AcinPknlMstpSrasWrflDnon";
sleep 1;
if (!isNull _joueur && alive _joueur && !isNull _blesse && alive _blesse) then
{
	R3F_REV_code_distant = [_blesse, "playMoveNow", "AinjPpneMstpSnonWrflDb_grab"];
	publicVariable "R3F_REV_code_distant";
	["R3F_REV_code_distant", R3F_REV_code_distant] spawn R3F_REV_FNCT_code_distant;
};

sleep 3;

// Attente d'un évènement mettant fin à l'action de traîner
while {!R3F_REV_demande_relacher_corps && !isNull _joueur && alive _joueur && !isNull _blesse && alive _blesse && isPlayer _blesse &&
	(animationState _joueur == "acinpknlmwlksraswrfldb" || animationState _joueur == "acinpknlmstpsraswrfldnon")} do
{
	sleep 0.1;
};

// On relâche le blessé
if !(isNull _blesse) then
{
	detach _blesse;
	if (alive _blesse) then
	{
		R3F_REV_code_distant = [_blesse, "playMoveNow", "AinjPpneMstpSnonWrflDb_release"];
		publicVariable "R3F_REV_code_distant";
		["R3F_REV_code_distant", R3F_REV_code_distant] spawn R3F_REV_FNCT_code_distant;
	}
	else
	{
		R3F_REV_code_distant = [_blesse, "switchMove", "AinjPpneMstpSnonWrflDnon"];
		publicVariable "R3F_REV_code_distant";
		["R3F_REV_code_distant", R3F_REV_code_distant] spawn R3F_REV_FNCT_code_distant;
	};
	_blesse setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];
};

// Le joueur sort de l'animation traînant le blessé
if !(isNull _joueur) then
{
	if (alive _joueur) then
	{
		// Le joueur a voulu se coucher pendant qu'il trainait le corps
		if (animationState _joueur == "acinpknlmstpsraswrfldnon_amovppnemstpsraswrfldnon") then
		{
			// On le fait coucher
			_joueur playMoveNow "AmovPpneMstpSrasWrflDnon";
		}
		else
		{
			// Retour à genoux
			_joueur playMoveNow "AmovPknlMstpSrasWrflDnon";
		};
	}
	else
	{
		// Eviter le bug ArmA du cadavre qui glisse indéfiniment sur le sol
		_joueur switchMove "AmovPknlMstpSrasWrflDnon";
	};
	_joueur removeAction _id_action;
};

R3F_REV_demande_relacher_corps = nil;