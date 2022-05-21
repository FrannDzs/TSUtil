@Echo Off
Rem Hinzufuegen von Boeschungsobjekten zu einer Strecke.
Rem Achtung: Standardmaessig werden NICHT ALLE Typen unterstuetzt (vergleiche StaticDetailLevel)
Rem Standard-Belegung fuer 'StaticDetailLevel':
Rem   9 - Boeschung, 8 - Boeschung+Mauer(links), 7 - Boeschung+Mauer(rechts), 6 - Rampe, 5 - Bridge
Rem Globale Option fuer Quellverzeichnis '1' notwendig (z.B.:'-q1:W:\Routes\$NR_Shapes') 
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.05<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if X%2==X goto .help
if "%TrSimPath%"=="" goto .trsim
if NOT EXIST "%2\NR_Emb1t_End.s" goto .dir
if NOT EXIST "%2\NR_Emb1t100mStrt.s" goto .dir
if NOT EXIST "%2\NR_WallEmb1t100mStrt_lft.s" goto .dir
if NOT EXIST "%2\NR_WallEmb1t100mStrt_rgt.s" goto .dir
if NOT EXIST "%2\NR_Ramp1t100mStrt.s" goto .dir
if NOT EXIST "%2\NR_Bridge1t100mStrt.s" goto .dir
if EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .exec
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.help
Echo Aufruf: cvrt-3I "<route>" "<source>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: Europe1)"
Echo         "<source>" ist der (absolute) Pfad zum Installationsverzeichnis der Shapes
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Installation (V3.4.05) wiederholen
goto .ende
:.dir
Echo Achtung: Installationsverzeichnis fuer Zusatzobjekte falsch oder fehlt!
Echo          Bitte Installationsverzeichnis als zweites Argument spezifizieren.
Echo          Installationsverzeichnis darf KEINE weiteren Unterverzeichnisse enthalten.
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%3" "-q1:%2" cvrt -r -inplace^
 -A9:^A(\d)(.*)\.s$:0::4:1=NR_Emb$1$2.s:1=NR_Emb$1t_Start.s:1=NR_Emb$1t_End.s^
 -A8:^A(\d)(.*)\.s$:0::4:1=NR_WallEmb$1$2_lft.s:1=NR_WallEmb$1t_End_lft.s:1=NR_WallEmb$1t_End_lft.s^
 -A7:^A(\d)(.*)\.s$:0::4:1=NR_WallEmb$1$2_rgt.s:1=NR_WallEmb$1t_End_rgt.s:1=NR_WallEmb$1t_End_rgt.s^
 -A6:^A(\d)(.*)\.s$:0::4:1=NR_Ramp$1$2.s -A5:^A(\d)(.*)\.s$:0::4:1=NR_Bridge$1$2.s "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!