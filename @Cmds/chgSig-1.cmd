@Echo Off
Rem Bearbeiten und Ersetzen einer Signalkonfiguration
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.08(F)<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if X%2==X goto .help
if "%TrSimPath%"=="" goto .trsim
if NOT EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .route
if EXIST "%TrSimPath%\Routes\%1\%2\chgSig.dat" goto .exec
Echo Achtung: Umwandlungsdefinition '%2/chgSig.dat' nicht gefunden
Echo          Bitte Steuerverzeichnis und Steuerdatei innerhalb von '%TrSimPath%/Routes/%1' erstellen.
goto .ende
:.help
Echo Aufruf: chgSig-1 "<route>" "<verz>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: Europe1)
Echo         "<verz>" ist der RELATIVE Name des Steuerverzeichnisses
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Installation (V3.4.08 F) wiederholen
goto .ende
:.route
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%3" chgSig -inplace "%2" "%TrSimPath%/Routes/%1" 
if NOT %ERRORLEVEL%==0 goto .error
REM Aufbereiten der erzeugten Streckendefinition
java -Xmx512M -cp . TSUtil -$B "-L%3" rendb -a -r -w -inplace "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!