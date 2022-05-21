@Echo Off
Rem Hinzufuegen von Boeschungsobjekten zu einer Strecke.
Rem Achtung: Standardmaessig werden NICHT ALLE Typen unterstuetzt (vergleiche StaticDetailLevel)
Rem Standard-Belegung fuer 'StaticDetailLevel':
Rem   9 - Boeschung, 8 - Boeschung+Mauer(links), 7 - Boeschung+Mauer(rechts), 6 - Rampe, 5 - Bridge 
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.05<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .exec
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.help
Echo Aufruf: cvrt-3 "<route>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: Europe1)
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert.
Echo          Bitte TSUtil loeschen und Installation (V3.4.05) wiederholen.
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%2" cvrt -r -inplace -A9:^A(\d)(.*)\.s$:0::4:NR_Emb$1$2.s:NR_Emb$1t_Start.s:NR_Emb$1t_End.s^
 -A8:^A(\d)(.*)\.s$:0::4:NR_WallEmb$1$2_lft.s:NR_WallEmb$1t_End_lft.s:NR_WallEmb$1t_End_lft.s^
 -A7:^A(\d)(.*)\.s$:0::4:NR_WallEmb$1$2_rgt.s:NR_WallEmb$1t_End_rgt.s:NR_WallEmb$1t_End_rgt.s^
 -A6:^A(\d)(.*)\.s$:0::4:NR_Ramp$1$2.s -A5:^A(\d)(.*)\.s$:0::4:NR_Bridge$1$2.s "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!