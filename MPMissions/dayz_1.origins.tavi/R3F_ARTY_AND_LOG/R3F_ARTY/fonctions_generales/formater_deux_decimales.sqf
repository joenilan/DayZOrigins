/*
 * Formate un entier en chaîne de caractères avec des décimales
 * @param 0 l'entier
 * @return la chaîne formatée à deux décimales
 */
private ["_valeur", "_chaine_formatee"];
_valeur = _this select 0;

_valeur = round (_valeur*100) / 100;

_chaine_formatee = str _valeur;
if (round (_valeur*100) mod 10 == 0) then {
	if (round (_valeur*100) mod 100 == 0) then {
		_chaine_formatee = _chaine_formatee + ".00";
	} else {
		_chaine_formatee = _chaine_formatee + "0";
	};
};

_chaine_formatee