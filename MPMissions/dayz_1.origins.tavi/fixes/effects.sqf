//A few colour corrections I gathered up from the internet, clear contrast works really well on most maps (best on thirsk). 
//Just uncomment the correction you want to use, make a folder called "fixes" in your mission.pbo and put this file inside of fixes. 
//Put this line at the bottom of your init.sqf "execVM "fixes\effects.sqf";" and your good to go! Thanks, Tiger.

//Clear contrast 
_hndl = ppEffectCreate ["colorCorrections", 1501];
_hndl ppEffectEnable true;
_hndl ppEffectAdjust [ 1, 1, 0, [0, 0, 0, -0.31],[1.9, 1.9, 1.73, 0.7],[0.2, 1.1, -1.5, 1.64]];
_hndl ppEffectCommit 0;

//Wasteland 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
//_hndl ppEffectCommit 0;

//Dark draining
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 1, 0.21, 0, [0.1, 0, 0, 0],[3.59, 3.49, 3.78, 0.83],[-0.31, 0.08, 3.79, 5]];
//_hndl ppEffectCommit 0;

//Sandy
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 1, 1, 0, [1.01, -2.46, -1.23, 0],[2.11, 1.6, 0.71, 0.8],[1.43, 0.56, 3.69, 0.31]];
//_hndl ppEffectCommit 0;

//Sumer Chernarus 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [1,1,0,[0,0,0,0],[2,0,0,1.25],[2.5,-2.5,0,0]];
//_hndl ppEffectCommit 0;

//Dog Vision 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [1,0.6,0,[0,0,0,0],[3,3,1,0.75],[2.5,2.5,-2.75,0]];
//_hndl ppEffectCommit 0;

//Tropical
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 1, 1, 0.01, [-0.11, -0.65, -0.76, 0.015],[-5, 2.74, 0.09, 0.95],[-1.14, -0.73, 1.14, -0.09]];
//_hndl ppEffectCommit 0;

//Photo
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 0.2050, 35, 0, [6.32, 0.57, 10.71, -0.0015],[1.29, 0.81, 1.2, 0.67],[-1.24, 2.03, 0.37, -3.69]];
//_hndl ppEffectCommit 0;

//WarZone
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ .079990001, 7, 0.055, [1.320, 1.57, 1.31, -.022],[2.05, 1.8611, 1.62, .6807],[-1.954, 3.95553, 4.898, 5.19]];
//_hndl ppEffectCommit 0;

//Operation Flashpoint
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1.2,0.85],[1,1,-2.5,0]];
//_hndl ppEffectCommit 0;

//Africa 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 1, 1.3, 0.001, [-0.11, -0.65, -0.76, 0.015],[-5, -1.74, 0.09, 0.86],[-1.14, -0.73, 1.14, -0.09]];
//_hndl ppEffectCommit 0;

//Blue 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 0.9, 1, 0, [-2.32, 0.17, 0.71, 0],[1.09, 0.91, 1.1, 0.27],[-1.24, 3.03, 0.37, -1.69]];
//_hndl ppEffectCommit 0;

//Arma mission colours 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 1.0, 1, -0.003, [0.2, 0.15, -0.0, 0.125],[-2, -1.5, -1, 0.55],[-0.54, -0.53, 0.4, -0.09]];
//_hndl ppEffectCommit 0;

//Heavy Colour Correction 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [1, 1.04, -0.004, [0.0, 0.0, 0.0, 0.0], [1, 0.8, 0.6, 0.5], [0.199, 0.587, 0.114, 0.0]];
//_hndl ppEffectCommit 0;

//Zombie View 
//_hndl = ppEffectCreate ["colorCorrections", 1501];
//_hndl ppEffectEnable true;
//_hndl ppEffectAdjust [ 1, 0.75, 0, [-3.16, 5, 5, 0],[-4.3, 5, 5, 1.28],[-2.96, 5, 5, 5]];
//_hndl ppEffectCommit 0;
