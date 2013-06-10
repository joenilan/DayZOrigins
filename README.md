DayZ Origins community build
============================

All credit goes to Cortez for all the hard work to make this mod available.<br/>
Special thanks to .=QUACK=.Major.Pain for his Github! https://github.com/MajorPainage/Origins

<u><b>Tools Required</b></u>
============================

- PBO tool which can be found in the tools folder.
(PBO Manager is the better of the two)

<u><b>Installing Database:</b></u>
============================

- You need to have MySQL version 5.5 and up. Work great on  5.5.31-0+wheezy1 (debian). Older version have problem importing the .SQL file
- Import \sqlfile\dayz_origins.sql into your database

(NOTE: If your having issues installing the functions, and get a message saying you don't have permission to install, you must install the functions as a 'root' user)

<u><b>Installing Files:</b></u>
============================

- Install the latest OA Beta Patch (http://www.arma2.com/beta-patch.php)
- Create a new folder copy the files from the OA folder into it. (This help retains your original files if you have to start over)
- Copy the Addons folder from the Arma 2 folder into the same folder.
- Copy the map (@DayzOrigins) into the same folder. (Downloaded from Dayz Commander or other tool)
- Edit the following files:<br>
--- \dayz_1.origins.tavi\config.cfg<br>
--- \dayz_1.origins.tavi\HiveExt.ini<br>
--- \dayz_1.origins.tavi\BattlEye\BEServer.cfg<br>
--- \MPMissions\dayz_1.origins.tavi\Debug\player_spawn_2.sqf (More Details Below)<br>
--- \MPMissions\dayz_1.origins.tavi\Camera\loginCamera.sqf (More Details Below)<br>

<u><b>Editing Debug</b></u>
============================

In <b>/Debug/player_spawn_2.sqf</b>
Look for 'DayZ Origins' on line 390 and change it to your liking.

<u><b>Enabling/Editing Login Camera</b></u>
============================

In <b>init.sqf</b> Look for:
<pre>
//_nul = [] execVM "Camera\loginCamera.sqf";
Remove the double slashes on the line above to enable Login Camera
</pre>

In <b>/Camera/loginCamera.sqf</b> Look for:
<pre>
_welcomeMessage = format["Welcome to DayZ Origin Servers %1, Enjoy your stay!",format["%1", name player]];
Edit this line to your liking.
</pre>

<u><b>Enabling Admin Tools</b></u>
============================

In <b>/admintools/Activate.sqf</b> Look for:
<pre>if ((getPlayerUID player) in ["#######"]) then {
Change "#######" to your Player ID
</pre>

In <b>/admintools/AdminToolsMain.sqf</b> Look for:
<pre>if ((getPlayerUID player) in ["#######"]) then {
Change "#######" to your Player ID
</pre>


<u><b>Adjusting Day/Night Time</b></u>
============================

- Edit \MPMissions\dayz_1.origins.tavi\init.sqf
- Look for:
<pre>
[3,true,true] execFSM "core_time.fsm";
</pre>
- Default is currently 4hr day/night.
- Other examples:<br>
--- [4,true,true] execFSM "core_time.fsm"; (3hr day/night)<br>
--- [3,true,true,12] execFSM "core_time.fsm"; (4hr day / 1 hr night)<br>
- To disable completely, just add a double slash to the front of the line '//'

<u><b>DMR Damage Scaling Removed</b></u>
============================

- Edit file: MPMissions/dayz_1.origins.tavi/BASTARDS/fn_damageHandler.sqf<br>
- Look at lines 81-88.
-If you would like DMR's to have the same damage as they would in cherno
then keep or delete lines that are commented out starting with  "  /* if
(_unit == player) then { "  if you want the new style DMR damage then
uncomment out the code.

<u><b>Increasing/Decreasing Zombies</b></u>
============================

- Edit \MPMissions\dayz_1.origins.tavi\BASTARDS\player_spawnCheck look for:
<pre>
switch (_nearbytype) do {
    default {
        _maxZombies = 10;
    };
    case "NameLocal": {
        _maxZombies = 10;
    };
    case "NameVillage": {
        _maxZombies = 15;
    };
    case "NameCity": {
        _maxZombies = 20;
    };
    case "NameCityCapital": {
        _maxZombies = 20;
    };
};
</pre>
- Edit the values to your preference.

<u><b>Finishing Up!</b></u>
============================

- Copy all the files from your git download into your folder. (Make sure to maintain the same file structure)
- Run Start Server.cmd and cross your fingers!

Optional:
If you want to modify files in the dayz_server or dayz_1.origins.tavi folders
- Install your PBO tool if you haven't already (PBO Manager is nice)
- Modify selected files.
- Use the PBO tool to pack the \@dayz_1.origins.tavi\addons\dayz_server folder.
- Use the PBO tool to pack the \MPMissions\dayz_1.origins.tavi folder.
- Run Start Server.cmd and cross your fingers!

<u><b>Add-Ons</b></u>
============================

<b>Available/Working:</b><br/>
Admin Tools<br/>
Color Corrections / (Clear Contrast, will test others later) - //Commented out in init.sqf<br/>
Air Dropped Cars - (South island only so far)<br/>
Auto Refueling<br/>
Sarge's AI / (Modify /addons/SARGE/SAR_config.sqf to your liking.)<br/>
Self Bloodbag<br/>

<b>Implemented but not working:</b><br/>
Lift/Tow / (Needs Survival Vehicle modifications) - Don't see any options<br/>
Fast Rope / (Needs testing) - Works for Pilot, Passanger doesnt see option<br/>

<b>Working On:</b><br/>
Air Dropped Care Packages - I might not be good enough to implement<br/>
Heli Crash Animations - I might not be good enough to implement<br/>

<u><b>Bugs:</b></u>
============================
House loot disappears, bug has something to do with lag when choosing to unlock house twice. - Possibly fixed<br/>
Logout Animation - This Server pack doesnt have Cloud Sync or Logout Animations (Temporary)<br/><br/>

(NOTE:  Folders inside the \MPMissions\ folder don't have to be packed to .pbo format)
