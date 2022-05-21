@Echo Off
Rem Bearbeiten einer Strecke und Unterdruecken der Oberleitung (Fahrdraht-Verfahren).
Rem Modifizieren Schienenobjekte gemaess StaticDetailLevel.
Rem Achtung: Standardmaessig werden NICHT ALLE Typen unterstuetzt (vergleiche StaticDetailLevel)
Rem Standard-Belegung fuer 'StaticDetailLevel':
Rem   0 - Normale Schiene (elektrifiziert) 1 - Normale Schiene ohne Fahrdraht (151) 
Rem   2 - Modifizierte Schienenreferenz ohne Fahrdraht (-Route-, 152) 
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.08<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .exec
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.help
Echo Aufruf: cvrt-4R "<route>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: Europe1)
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Stand-Alone-Installation (V3.4.08) wiederholen
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%2" cvrt -r -inplace -f1:151 -f2:152:0:A:A "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!