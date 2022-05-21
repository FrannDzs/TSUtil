@Echo Off
Rem Erstellen einer alternativen Version von Schienendefinitionen
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.08<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if /I NOT "%1"=="A" goto .exec
Echo Fehler: Kennung 'A' ist als Original NICHT erlaubt!
Echo         Bitte verwenden Sie einen anderen Schienenprefix.
goto .ende
:.help
Echo Aufruf: fcpy-1 "<kng>"
Echo         "<kng>" ist der Prefix der neuen Schienendefinitionen aus der Textur (z.B. 'NB')
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Stand-Alone-Installation (V3.4.08) wiederholen
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%2" fcpy -s -o "-f^A(\d)(.*)\.s$" -z%1$1$2.s -mAClean:%1Clean -mATrack:%1Track^
 "%TrSimPath%/Global/Shapes" "%TrSimPath%/Global/Shapes/%1Shapes"
if NOT %ERRORLEVEL%==0 goto .error
java -Xmx512M -cp . TSUtil -$B "-L%2" fcpy -u "-f^A(\d)(.*)\.sd$" -z%1$1$2.sd -M(.*)A(\d)(.*)\.s:$1%1$2$3.s^
 "%TrSimPath%/Global/Shapes" "%TrSimPath%/Global/Shapes/%1Shapes"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!
