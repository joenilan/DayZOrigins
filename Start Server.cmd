@echo off
:start
C:\Windows\System32\tasklist /FI "IMAGENAME eq arma2oaserver.exe" 2>NUL | C:\Windows\System32\find /I /N "arma20aserver.exe.exe">NUL
if "%ERRORLEVEL%"=="0" goto loop
echo ======================================================
echo DayZ Origins Start/Restart Script by DreadedZombie
echo A modified Arma 3 Restarter by eRazeri
echo ======================================================
echo.
echo Server monitored is not running, will be started now
echo Respawning Cars and Sector B Urals
echo Please wait...
start cmd /k Call ural-car-respawn.cmd
ping 127.0.0.1 -n 12 >NUL
echo finished.
echo.
echo Starting server...
start "" /wait Expansion\beta\arma2oaserver.exe -beta=Expansion\beta;Expansion\beta\Expansion -nosplash -cpuCount=4 -maxMem=4096 -exThreads=7 -name=Origins -profiles=dayz_1.origins.tavi -cfg=dayz_1.origins.tavi\basic.cfg -config=dayz_1.origins.tavi\config.cfg -mod=expansion;expansion\beta;expansion\beta\expansion;@DayzOrigins;@dayz_1.origins.tavi
echo.
echo Server started succesfully
goto started
:loop
cls
echo Server is already running, running monitoring loop
:started
C:\Windows\System32\timeout /t 10
C:\Windows\System32\tasklist /FI "IMAGENAME eq arma2oaserver.exe" 2>NUL | C:\Windows\System32\find /I /N "arma2oaserver.exe">NUL
if "%ERRORLEVEL%"=="0" goto loop
goto start