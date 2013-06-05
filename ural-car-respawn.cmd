cd /D "C:\xampp\mysql\bin\"
mysql.exe --user=CHANGEME --password=CHANGEME --execute="call pCleanup()" dayz_origins
mysql.exe --user=CHANGEME --password=CHANGEME --execute="call pMain()" dayz_origins
mysql.exe --user=CHANGEME --password=CHANGEME --execute="call pMain()" dayz_origins
mysql.exe --user=CHANGEME --password=CHANGEME --execute="call pMain()" dayz_origins
mysql.exe --user=CHANGEME --password=CHANGEME --execute="call pMain()" dayz_origins
mysql.exe --user=cCHANGEME --password=CHANGEME --execute="call pMain()" dayz_origins
ping 127.0.0.1 -n 5 >NUL
EXIT