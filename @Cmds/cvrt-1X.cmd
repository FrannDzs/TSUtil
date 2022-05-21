@Echo Off
Rem Umwandeln einer Strecke zur Nutzung fuer XTrack mit unterdrueckter Oberleitung (SectionIDX=150,39887)
Rem Achtung: Schienen ohne Oberleitung werden mit StaticDetailLevel '1' gekennzeichnet.
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.09A<<
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
Echo Aufruf: cvrt-1X "<route>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: Europe1)
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Installation (V3.4.09A) wiederholen
goto .ende
:.route
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%2" fcpy -w "-m\"SectionIdx ( 150 )\":\"SectionIdx ( 4294967280 )\""^
 "-m\"SectionIdx ( 39887 )\":\"SectionIdx ( 4294967280 )\""^
 "%TrSimPath%/Routes/%1/World" "%TrSimPath%/Routes/%1/World" 
if NOT %ERRORLEVEL%==0 goto .error
Echo "Achtung: Schienen ohne Oberleitung werden mit StaticDetailLevel '1' gekennzeichnet."
java -Xmx512M -cp . TSUtil -$B "-L%2" -j1:2 cvrt "-b%TrSimPath%/Routes/tsection.dat" -v99:99 -inplace^
 "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!