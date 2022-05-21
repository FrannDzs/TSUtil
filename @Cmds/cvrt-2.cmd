@Echo On
Rem Umwandeln einer Strecke und anpassen an XTrack
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.04<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if NOT EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .route
if EXIST "%TrSimPath%\Routes\tsection.dat" goto .exec
Echo Achtung: Originale 'tsection.dat' nicht gefunden
Echo          Bitte ORIGINALE (globale) 'tsection.dat' nach '%TrSimPath%/Routes' kopieren.
goto .ende
:.help
Echo Aufruf: cvrt-2 "<route>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: Europe1)
Echo         Die ORIGINALE (globale) 'tsection.dat' muss in '%TrSimPath%/Routes' vorhanden sein.
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Installation (V3.4.04) wiederholen
goto .ende
:.route
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%2" cvrt "-b%TrSimPath%/Routes/tsection.dat" -v99:99 -inplace "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!