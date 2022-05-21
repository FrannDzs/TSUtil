@Echo Off
Rem Umwandeln der Strecke PT10 mit unterdrueckter Oberleitung und Nebenbahnenschienen
Rem Achtung: Schienen ohne Oberleitung werden mit StaticDetailLevel '1' gekennzeichnet.
Rem Achtung: Nebenbahnenschienen ohne Oberleitung werden mit StaticDetailLevel '2' gekennzeichnet.
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.09A<<
Rem
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if EXIST "%TrSimPath%\Routes\PTAKR\PTAKR.trk" goto .exec
Echo Fehler: Route '%TrSimPath%/Routes/PTAKR' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.help
Echo Aufruf: cvrt-PT10
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Installation (V3.4.09A) wiederholen
goto .ende
:.exec
Echo Achtung: Schienen ohne Oberleitung werden mit StaticDetailLevel '1' gekennzeichnet.
Echo Achtung: Nebenbahnschienen ohne Oberleitung werden mit StaticDetailLevel '2' gekennzeichnet.
java -Xmx512M -cp . TSUtil -$B "-l%1" -j1:2 cvrt -n -z1 -z2:nb:A -inplace "%TrSimPath%/Routes/PTAKR"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!