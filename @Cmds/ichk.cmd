@Echo Off
Rem Ausfuehren 'ichK' und pruefen einer Route
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.04<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .exec
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.help
Echo Aufruf: ichk "<route>"
Echo         "<route>" ist der RELATIVE Name der Route (z.B: 'Europe1')
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert!
Echo          Bitte TSUtil loeschen und Installation (V3.4.04) wiederholen
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%2" ichk -S "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
Echo Fehler -- Programm endete mit ReturnCode %ERRORLEVEL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!