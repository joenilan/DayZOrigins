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

<u><b>Finishing Up!</b></u>
============================

- Copy all the files from your git download into your folder. (Make sure to maintain the same file structure)
- Install your PBO tool if you haven't already.
- Use the PBO tool to pack the \@dayz_1.origins.tavi\addons\dayz_server folder.
(NOTE:  You can also pack the folder in the MPMissions folder, recommended but not required.)

<u><b>Add-Ons</b></u>
============================

<b>Available:</b><br/>
Color Corrections / (Clear Contrast, will test others later)<br/>
Auto Refueling<br/>
Sarge's AI / (Modify /addons/SARGE/SAR_config.sqf to your liking.)<br/>
Self Bloodbag<br/>
Lift/Tow / (Needs Survival Vehicle modifications)<br/>
Fast Rope / (Needs testing)<br/>

<b>Working On:</b><br/>
Air Dropped Cars<br/>
Air Dropped Care Packages<br/>
Heli Crash Animations<br/>

<u><b>Bugs:</b></u>
============================
Script Restriction #20 Enabling Battleye - (Temp Fix by changing 5 to 1 in scripts.txt)<br/>
Possible AI Lag<br/>
House loot disappears, bug has something to do with lag when choosing to unlock house twice.<br/>
Death Graves don't work (Uses bodies instead) - (Currently Testing Fix)<br/>
Logout Animation<br/><br/>

(NOTE:  Folders inside the \MPMissions\ folder don't have to be packed to .pbo format)
