/**
 * Execute une mission de tir reçu pour une IA locale à la machine actuelle
 * 
 * @param 0 le nom de l'émetteur de l'ordre
 * @param 1 l'IA devant éxecuter la mission de tir
 * @param 2 azimut du tir
 * @param 3 élévation du tir
 * @param 4 indice de la munition dans la table de correspondance
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_poursuivre", "_tireur", "_piece", "_tir_en_cours", "_ordres_tirs"];

_poursuivre = true;

_tireur = _this select 1;
if (isNull _tireur) then {_poursuivre = false;};
if !(local _tireur && alive _tireur) then {_poursuivre = false;};

_piece = vehicle _tireur;
if (isNull _piece) then {_poursuivre = false;};
if !(alive _piece) then {_poursuivre = false;};
if ({_piece isKindOf _x} count R3F_ARTY_CFG_pieces_artillerie == 0) then {_poursuivre = false;};

if (_poursuivre) then
{
	// On place l'ordre dans la file d'attente
	_ordres_tirs = + (_tireur getVariable "R3F_ARTY_mission_tir_IA_ordres_recus");
	if (isNil "_ordres_tirs") then {_ordres_tirs = [];};
	_ordres_tirs = _ordres_tirs + [_this];
	_tireur setVariable ["R3F_ARTY_mission_tir_IA_ordres_recus", + _ordres_tirs, false];
	
	// Si l'accès à l'exécution de mission de tir est vérouillé, on laisse le fil d'exécution en cours l'exécuter
	_tir_en_cours = _tireur getVariable "R3F_ARTY_mission_tir_IA_tir_en_cours";
	if (isNil "_tir_en_cours") then {_tir_en_cours = false;};
	
	if (!_tir_en_cours) then
	{
		// On vérouille l'accès à l'exécution de missions de tir pour l'IA
		_tireur setVariable ["R3F_ARTY_mission_tir_IA_tir_en_cours", true, false];
		
		// On lance le fil d'exécution qui va traiter toute la file d'attente
		[_tireur, _piece] spawn
		{
			private ["_tireur", "_piece", "_azimut_precedent", "_elevation_precedent"];
			
			_tireur = _this select 0;
			_piece = _this select 1;
			
			_tireur disableAI "TARGET";
			_tireur disableAI "AUTOTARGET";
			_tireur disableAI "MOVE";
			
			_azimut_precedent = 400;
			_elevation_precedent = 100;
			
			// Boucle sur la file d'attente des missions de tir
			while {local _tireur && gunner _piece == _tireur && alive _tireur && alive _piece &&
				({count _x > 0} count (_tireur getVariable "R3F_ARTY_mission_tir_IA_ordres_recus") > 0)
			} do
			{
				private ["_index_premier_ordre", "_ordres_tirs", "_ordre", "_azimut", "_elevation", "_idx_type_piece", "_mun_compatible", "_chargeur_demande"];
				
				// Recherche du premier ordre non accompli
				_index_premier_ordre = 0;
				while {count ((_tireur getVariable "R3F_ARTY_mission_tir_IA_ordres_recus") select _index_premier_ordre) == 0} do
				{
					_index_premier_ordre = _index_premier_ordre + 1;
				};
				
				_ordre = + ((_tireur getVariable "R3F_ARTY_mission_tir_IA_ordres_recus") select _index_premier_ordre);
				
				_azimut = _ordre select 2 + random 0.05;
				_elevation = _ordre select 3 + random 0.05;
				_chargeur_demande = _ordre select 4;
				
				// La munition demandée est-elle compatible avec la pièce ?
				_idx_type_piece = -1;
				for [{_i = 0}, {_i < count R3F_ARTY_CFG_pieces_artillerie}, {_i = _i+1}] do
				{
					if (_idx_type_piece == -1) then
					{
						if (_piece isKindOf (R3F_ARTY_CFG_pieces_artillerie select _i)) then
						{
							_idx_type_piece = _i;
						};
					};
				};
				
				_mun_compatible = false;
				if (_idx_type_piece != -1) then
				{
					{
						if (!_mun_compatible) then
						{
							if ([_x, _chargeur_demande] call R3F_ARTY_FNCT_chargeurs_sont_egaux) then
							{
								_mun_compatible = true;
							};
						};
					} forEach (uiNamespace getVariable "R3F_ARTY_chargeurs_compatibles_par_piece" select _idx_type_piece);
				};
				
				if (_mun_compatible) then
				{
					private ["_vec_dir_tir", "_pos_piece", "_pos_regard", "_cible_regard", "_muzzles", "_chargeur_actuel", "_mun_ok", "_nb_tests", "_tir_possible"];
					
					_vec_dir_tir = [
						(sin _azimut)*(cos _elevation),
						(cos _azimut)*(cos _elevation),
						(sin _elevation)
					];
					
					_pos_piece = getPosASL _piece;
					
					_pos_regard = [
						(_pos_piece select 0) + (_vec_dir_tir select 0)*1000,
						(_pos_piece select 1) + (_vec_dir_tir select 1)*1000,
						(_pos_piece select 2) + (_vec_dir_tir select 2)*1000
					];
					
					_cible_regard = "Logic" createVehicleLocal _pos_regard;
					_cible_regard setPosASL _pos_regard;
					_pos_regard = getPosATL _cible_regard;
					sleep 0.5;
					deleteVehicle _cible_regard;
					
					_tireur setVariable ["R3F_ARTY_mission_tir_IA_vec_dir_tir", _vec_dir_tir, false];
					
					_piece selectWeapon (weapons _piece select 0);
					_muzzles = getArray (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "muzzles");
					_piece selectWeapon (_muzzles select 0);
					sleep 0.25;
					
					_chargeur_actuel = [_piece] call R3F_ARTY_FNCT_get_chargeur_actuel;
					
					// Charger la bonne munition si besoin et si un PC est à proximité
					_mun_ok = true;
					if (_piece ammo (weapons _piece select 0) == 0 ||
						!([_chargeur_actuel, _chargeur_demande] call R3F_ARTY_FNCT_chargeurs_sont_egaux)) then
					{
						if (local _tireur && gunner _piece == _tireur && alive _tireur && alive _piece) then
						{
							if (count nearestObjects [_piece, ["SatPhone"], 100] > 0) then
							{
								R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_rechargement, name _tireur]];
								publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
								if !(isServer && isDedicated) then
								{
									["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
								};
								
								_piece removeMagazines (magazines _piece select 0);
								_piece addMagazine (_chargeur_demande select 0);
								_piece setVariable ["R3F_ARTY_chargeur_courant", _chargeur_demande, true];
								
								// Temps de rechargement du chargeur
								sleep ((getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "magazineReloadTime")) +
									1.4*(getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "reloadTime")));
							}
							else
							{
								_mun_ok = false;
								
								R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_pas_de_munition, name _tireur]];
								publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
								if !(isServer && isDedicated) then
								{
									["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
								};
							};
						};
					};
					
					if (_mun_ok) then
					{
						_tireur lookAt _pos_regard;
						// Si on change de zone de tir, on passe du temps à viser, sinon c'est rapide
						if (abs (_azimut_precedent - _azimut) < 1.5 && abs (_elevation_precedent - _elevation) < 1.5) then
						{sleep (0.25 + random 0.5);} else {sleep (6 + random 3);};
						
						// Vérification que l'IA est bien prête à tirer
						_tir_possible = false;
						for [{_nb_tests = 0}, {_nb_tests < 10 && !_tir_possible}, {_nb_tests = _nb_tests+1}] do
						{
							private ["_vec_canon", "_angle_ecart_canon_dir_tir"];
							
							_vec_canon = _piece weaponDirection (weapons _piece select 0);
							_angle_ecart_canon_dir_tir = acos ((_vec_dir_tir select 0) * (_vec_canon select 0) +
								(_vec_dir_tir select 1) * (_vec_canon select 1) +
								(_vec_dir_tir select 2) * (_vec_canon select 2));
							
							if (abs _angle_ecart_canon_dir_tir < 4) then
							{
								_tir_possible = true;
							}
							else
							{
								_tireur lookAt _pos_regard;
								sleep 4;
							};
						};
						
						if (local _tireur && gunner _piece == _tireur && alive _tireur && alive _piece) then
						{
							if (_tir_possible) then
							{
								R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_tir, name _tireur]];
								publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
								if !(isServer && isDedicated) then
								{
									["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
								};
								
								_piece fire (weapons _piece select 0);
								sleep 0.5;
							}
							else
							{
								R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_echec_visee, name _tireur, _elevation, _azimut]];
								publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
								if !(isServer && isDedicated) then
								{
									["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
								};
							};
						};
					};
					
					_azimut_precedent = _azimut;
					_elevation_precedent = _elevation;
					
					if (local _tireur && gunner _piece == _tireur && alive _tireur && alive _piece) then
					{
						// Recharger si la pièce est à court du munition et qu'un un PC est à proximité
						if (_piece ammo (weapons _piece select 0) <= 1) then
						{
							if (count nearestObjects [_piece, ["SatPhone"], 100] > 0) then
							{
								R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_rechargement, name _tireur]];
								publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
								if !(isServer && isDedicated) then
								{
									["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
								};
								
								_piece removeMagazines (magazines _piece select 0);
								_piece addMagazine (_chargeur_demande select 0);
								
								// Temps de rechargement du chargeur
								sleep (getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "magazineReloadTime"));
							}
							else
							{
								R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_pas_de_munition, name _tireur]];
								publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
								if !(isServer && isDedicated) then
								{
									["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
								};
							};
						};
						
						// Temps de rechargement de la munition
						sleep (1.4*(getNumber (configFile >> "CfgWeapons" >> (weapons _piece select 0) >> "reloadTime")));
					};
				}
				else
				{
					R3F_ARTY_PUBVAR_message_IA_artilleur = [_ordre select 0, _tireur, format [STR_R3F_ARTY_IA_munition_incompatible, name _tireur,
						_chargeur_demande select 1, getText (configFile >> "CfgVehicles" >> (typeOf _piece) >> "displayName")]];
					publicVariable "R3F_ARTY_PUBVAR_message_IA_artilleur";
					if !(isServer && isDedicated) then
					{
						["R3F_ARTY_PUBVAR_message_IA_artilleur", R3F_ARTY_PUBVAR_message_IA_artilleur] spawn R3F_ARTY_FNCT_PUBVAR_message_IA_artilleur;
					};
				};
				
				if (local _tireur && gunner _piece == _tireur && alive _tireur && alive _piece) then
				{
					// On marque l'ordre comme exécuté
					_ordres_tirs = + (_tireur getVariable "R3F_ARTY_mission_tir_IA_ordres_recus");
					_ordres_tirs set [_index_premier_ordre, []];
					_tireur setVariable ["R3F_ARTY_mission_tir_IA_ordres_recus", + _ordres_tirs, false];
				};
			};
			
			if (local _tireur && gunner _piece == _tireur && alive _tireur && alive _piece) then
			{
				_tireur enableAI "TARGET";
				_tireur enableAI "AUTOTARGET";
				_tireur enableAI "MOVE";
				
				// On dévérouille l'accès à l'exécution de missions de tir pour l'IA
				_tireur setVariable ["R3F_ARTY_mission_tir_IA_tir_en_cours", false, false];
			};
		};
	};
};